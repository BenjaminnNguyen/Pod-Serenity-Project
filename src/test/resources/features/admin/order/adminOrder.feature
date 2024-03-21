@feature=adminOrder
Feature: Admin Order

  @adminOrder_01a @adminOrder_44 @adminOrder
  Scenario: Buyer/Admin creates order without entering Customer PO field
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx500@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order a 01 | 31645              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Reset search filter full textbox
    And Admin filter visibility with id "3" by api
      | q[store_ids]              |
      | q[fulfillment_states]     |
      | q[custom_store_name]      |
      | q[buyer_id]               |
      | q[vendor_company_id]      |
      | q[product_variant_ids]    |
      | q[fulfillment_state]      |
      | q[region_id]              |
      | q[store_manager_id]       |
      | q[lack_tracking]          |
      | end_date                  |
      | q[express_progress]       |
      | q[only_edi]               |
      | q[has_out_of_stock_items] |
      | q[finance_state]          |
      | q[type]                   |
      | q[temperature_name]       |
      | start_date                |
      | q[lack_pod]               |
      | q[route_id]               |
      | q[buyer_payment_state]    |
      | q[upc]                    |
      | q[number]                 |
      | q[buyer_company_id]       |
      | q[store_id]               |
      | q[brand_id]               |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx500@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | orderNumber | customStore | store   | buyer   | buyercompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | storeManager | lackPOD | lackTracking | startDate | endDate | temperature | oos     | orderType | expressProgress | pendingFinancialApprove | edi     |
      | [blank]     | [blank]     | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank]      | [blank] | [blank]      | [blank]   | [blank] | [blank]     | [blank] | [blank]   | [blank]         | [blank]                 | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | orderNumber | customStore | store   | buyer   | buyercompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | storeManager | lackPOD | lackTracking | endDate | temperature | oos     | orderType | expressProgress | pendingFinancialApprove | edi     |
      | [blank]     | [blank]     | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank]      | [blank] | [blank]      | [blank] | [blank]     | [blank] | [blank]   | [blank]         | [blank]                 | [blank] |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | orderNumber | customStore | store   | buyer   | buyercompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | storeManager | lackPOD | lackTracking | startDate | endDate | temperature | oos     | orderType | expressProgress | pendingFinancialApprove | edi     |
      | [blank]     | [blank]     | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank]      | [blank] | [blank]      | [blank]   | [blank] | [blank]     | [blank] | [blank]   | [blank]         | [blank]                 | [blank] |
    Then Admin verify field search in edit visibility
      | orderNumber | customStore | store   | buyer   | buyercompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | storeManager | lackPOD | lackTracking | startDate | endDate | temperature | oos     | orderType | expressProgress | pendingFinancialApprove | ediOrder |
      | [blank]     | [blank]     | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank]      | [blank] | [blank]      | [blank]   | [blank] | [blank]     | [blank] | [blank]   | [blank]         | [blank]                 | [blank]  |
    # Verify save new filter
    And Admin search the orders by info
      | orderNumber | orderSpecific  | store   | buyer                       | buyerCompany | vendorCompany | brand                      | sku                  | upc       | fulfillment | buyerPayment | region              | route      | managed   | pod | tracking | startDate   | endDate     | temp | oos | orderType | exProcess | pendingFinancial |
      | 123         | customer Store | [blank] | ngoctx bbuyermultiorder0201 | ngoc cpn1    | ngoc vc 1     | AT Brand A Drop Summary 01 | AT SKU A Drop Sum 01 | 123456789 | Pending     | Pending      | Chicagoland Express | Unassigned | ngoctx555 | Yes | Yes      | currentDate | currentDate | Dry  | Yes | Express   | Pending   | Yes              |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | orderNumber | orderSpecific  | store   | buyer                       | buyerCompany | vendorCompany | brand                      | sku                  | upc       | fulfillmentOrder | buyerPayment | region              | route      | managed   | pod | tracking | startDate   | endDate     | temp | oos | orderType | exProcess | pendingFinancial |
      | 123         | customer Store | [blank] | ngoctx bbuyermultiorder0201 | ngoc cpn1    | ngoc vc 1     | AT Brand A Drop Summary 01 | AT SKU A Drop Sum 01 | 123456789 | Pending          | Pending      | Chicagoland Express | Unassigned | ngoctx555 | Yes | Yes      | currentDate | currentDate | Dry  | Yes | Express   | Pending   | Yes              |
    # Verify save as filter
    And Admin search the orders by info
      | orderNumber | orderSpecific  | store   | buyer                       | buyerCompany | vendorCompany | brand                      | sku                  | upc       | fulfillment | buyerPayment | region              | route      | managed   | pod | tracking | startDate   | endDate     | temp | oos | orderType | exProcess | pendingFinancial |
      | 123123      | customer Store | [blank] | ngoctx bbuyermultiorder0201 | ngoc cpn1    | ngoc vc 1     | AT Brand A Drop Summary 01 | AT SKU A Drop Sum 01 | 123456789 | Pending     | Pending      | Chicagoland Express | Unassigned | ngoctx555 | Yes | Yes      | currentDate | currentDate | Dry  | Yes | Express   | Pending   | Yes              |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | orderNumber | orderSpecific  | store   | buyer                       | buyerCompany | vendorCompany | brand                      | sku                  | upc       | fulfillmentOrder | buyerPayment | region              | route      | managed   | pod | tracking | startDate   | endDate     | temp | oos | orderType | exProcess | pendingFinancial |
      | 123123      | customer Store | [blank] | ngoctx bbuyermultiorder0201 | ngoc cpn1    | ngoc vc 1     | AT Brand A Drop Summary 01 | AT SKU A Drop Sum 01 | 123456789 | Pending          | Pending      | Chicagoland Express | Unassigned | ngoctx555 | Yes | Yes      | currentDate | currentDate | Dry  | Yes | Express   | Pending   | Yes              |

    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType    | street                | city    | state    | zip   |
      | ngoctx stOrder02chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order a 01"
    And Admin create order success
    And Admin create "create" sub-invoice with Suffix ="1"
      | skuName           |
      | AT SKU Order a 01 |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder02chi01 | ngoctx stOrder02 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | [blank]          | currentDate     | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice of order "direct"

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order   | po      |
      | Ordered, Latest first | In progress  | [blank] | [blank]       | [blank] | [blank] |
    And Check order record on order page
      | ordered     | number  | store            | delivery | route   | address                                         | fulfillment |
      | currentDate | [blank] | ngoctx stOrder02 | [blank]  | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | In progress |
    And LP go to order detail ""
    And LP see packing slip
    And LP verify info of packing slip
      | store            | buyer                 | orderDate   | customerPO | address                                         | department | receivingWeekday | receivingTime |
      | ngoctx stOrder02 | ngoctx stOrder02chi01 | currentDate | [blank]    | 1544 West 18th Street, Chicago, Illinois, 60608 | [blank]    | [blank]          | [blank]       |
    And USER_LP quit browser

    Given BUYER open web user
    And login to beta web with email "ngoctx+stOrder02CHI01@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Store 01 | currentDate   | [blank]        |
    And Go to order detail with order number ""
    And See invoice
    And Buyer verify info in Invoice "create by admin"
      | orderDate | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                                 | paymentMethod       |
      | [blank]   | [blank]       | [blank]    | [blank]      | [blank]    | ngoctx stOrder02chi01 - ngoctx stOrder02, 1544 West 18th Street, Chicago, Illinois, 60608 | Payment via invoice |
    And Buyer switch to parent page from invoice
    And BUYER quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v101@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region  | store            | paymentStatus | orderType | checkoutDate |
      | [blank] | ngoctx stOrder02 | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor select items to confirm in order
      | sku     | date   |
      | [blank] | Minus1 |
    And Vendor print invoice packing slip ""
    And Vendor verify info in Invoice
      | orderDate   | invoiceNumber   | customerPO | deliveryDate | department | deliverTo                                                                                 | paymentMethod       |
      | currentDate | create by admin | [blank]    | [blank]      | [blank]    | ngoctx stOrder02chi01 - ngoctx stOrder02, 1544 West 18th Street, Chicago, Illinois, 60608 | Payment via invoice |
    And Vendor verify packing slip
      | index | store            | buyer                 | orderDate   | customerPO |
      | 1     | ngoctx stOrder02 | ngoctx stOrder02chi01 | currentDate | [blank]    |
      | 2     | ngoctx stOrder02 | ngoctx stOrder02chi01 | currentDate | [blank]    |
    And VENDOR quit browser

    And Switch to actor NGOC_ADMIN_05
    And NGOC_ADMIN_05 refresh browser
    And Admin check line items "sub invoice" in order details
      | brand             | product          | sku               | unitCase     | casePrice | quantity | endQuantity | total   | skuID | expireDate | below75%  |
      | AT Brand Store 01 | AT Product Order | AT SKU Order a 01 | 1 units/case | $100.00   | 1        | [blank]     | $100.00 | 31645 | Minus1     | Below 75% |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_01b @adminOrder_01c @adminOrder_02 @adminOrder_03 @adminOrder
  Scenario: Buyer/Admin creates order edit Customer PO field
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx500@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order a 01 | 31645              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx501@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType    | street                | city    | state    | zip   |
      | ngoctx stOrder02chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order a 01"
    And Admin create order success
    And Admin create "create" sub-invoice with Suffix ="1"
      | skuName           |
      | AT SKU Order a 01 |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder02chi01 | ngoctx stOrder02 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | [blank]          | currentDate     | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice of order "direct"
    And Admin edit general information of order detail
      | customerPO       | customStoreName | adminNote |
      | Auto Customer PO | [blank]         | [blank]   |
    And Admin edit address of order detail
      | attn | street1               | street2 | city     | state | zip   |
      | 123  | 1545 West 18th Street | street2 | Chicago1 | Idaho | 60609 |
    And Verify general information of order detail
      | customerPo       | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | address                                                     |
      | Auto Customer PO | currentDate | Chicagoland Express | ngoctx stOrder02chi01 | ngoctx stOrder02 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     | 123, 1545 West 18th Street, street2, Chicago1, Idaho, 60609 |

    And NGOC_ADMIN_05 quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | In progress  | [blank] | [blank]       | create by admin | [blank] |
    And Check order record on order page
      | ordered     | number  | store            | delivery | route   | address                                                     | fulfillment |
      | currentDate | [blank] | ngoctx stOrder02 | [blank]  | [blank] | 123, 1545 West 18th Street, street2, Chicago1, Idaho, 60609 | In progress |
    And LP go to order detail ""
    And LP see packing slip
    And LP verify info of packing slip
      | store            | buyer                 | orderDate   | customerPO       | address                                                     | department | receivingWeekday | receivingTime |
      | ngoctx stOrder02 | ngoctx stOrder02chi01 | currentDate | Auto Customer PO | 123, 1545 West 18th Street, street2, Chicago1, Idaho, 60609 | [blank]    | [blank]          | [blank]       |
    And USER_LP quit browser

    Given BUYER open web user
    And login to beta web with email "ngoctx+stOrder02CHI01@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Store 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by admin"
    And See invoice
    And Buyer verify info in Invoice "create by admin"
      | orderDate   | invoiceNumber | customerPO       | deliveryDate | department | deliverTo                                                                                             | paymentMethod       |
      | currentDate | [blank]       | Auto Customer PO | [blank]      | [blank]    | ngoctx stOrder02chi01 - ngoctx stOrder02, 123, 1545 West 18th Street, street2, Chicago1, Idaho, 60609 | Payment via invoice |
    And Buyer switch to parent page from invoice
    And BUYER quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v101@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store            | paymentStatus | orderType | checkoutDate |
      | [blank] | ngoctx stOrder02 | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor print invoice packing slip ""
    And Vendor verify packing slip
      | index | store            | buyer                 | orderDate   | customerPO       |
      | 1     | ngoctx stOrder02 | ngoctx stOrder02chi01 | currentDate | Auto Customer PO |
      | 2     | ngoctx stOrder02 | ngoctx stOrder02chi01 | currentDate | Auto Customer PO |
    And VENDOR quit browser

  @adminOrder_04 @adminOrder
  Scenario: Check display and edit Route field
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx500@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 04 | 31685              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx502@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder03chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 04"
    And Admin create order success
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | route        |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder03chi01 | ngoctx stOrder03 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     | Auto Route 1 |

    And NGOC_ADMIN_05 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name             | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx stOrder03 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin go to detail of store "ngoctx stOrder03"
    And Admin edit general information of store
      | name    | storeSize | invoiceOption | dateThreshold | mile    | referredBy | region  | route        | email   | phone   | timeZone | expressNote | directNote | liftGate | retailerStore |
      | [blank] | [blank]   | [blank]       | [blank]       | [blank] | [blank]    | [blank] | Auto Route 1 | [blank] | [blank] | [blank]  | [blank]     | [blank]    | [blank]  | [blank]       |

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by admin"
    And Admin go to order detail number "create by admin"
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | route        | managedBy     | launchedBy    |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder03chi01 | ngoctx stOrder03 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     | Auto Route 1 | thuy_admin123 | thuy_admin123 |
    And Admin go to "buyer" by redirect icon and verify
    And NGOC_ADMIN_05 go back
    And Admin go to "store" by redirect icon and verify
    And NGOC_ADMIN_05 quit browser

  @adminOrder_07 @adminOrder
  Scenario: Buyer checkout with entering the Order-specific store name field
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx500@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 04 | 31685              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given BUYER open web user
    When login to beta web with email "ngoctx+storder03chi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch      | brand             | name            | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Order | AT Brand Store 01 | AT SKU Order 04 | 1      |
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $100.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $100.00 |
    And Buyer check out cart "Pay by invoice" with receiving info
      | customStore | customerPO | department | specialNote |
      | AT Store    | [blank]    | [blank]    | [blank]     |
    And BUYER quit browser

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx503@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order           | checkout    | buyer                 | store    | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by buyer | currentDate | ngoctx storder03chi01 | AT Store | CHI    | $100.00 | $5.00     | Pending      | Pending     | Pending       |
    When Admin go to detail after search
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder03chi0 | ngoctx stOrder03 | AT Store    | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin create "create" sub-invoice with Suffix ="1"
      | skuName         |
      | AT SKU Order 04 |
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | [blank]          | currentDate     | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice of order "direct"

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order   | po      |
      | Ordered, Latest first | In progress  | [blank] | [blank]       | [blank] | [blank] |
    And Check order record on order page
      | ordered     | number  | store    | delivery | route        | address                                         | fulfillment |
      | currentDate | [blank] | AT Store | [blank]  | Auto Route 1 | 1544 West 18th Street, Chicago, Illinois, 60608 | In progress |
    And LP go to order detail ""
    And LP see packing slip
    And LP verify info of packing slip
      | store    | buyer                 | orderDate   | customerPO | address                                         | department | receivingWeekday | receivingTime |
      | AT Store | ngoctx storder03chi01 | currentDate | [blank]    | 1544 West 18th Street, Chicago, Illinois, 60608 | [blank]    | [blank]          | [blank]       |

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    When Admin go to detail after search
    And Admin edit general information of order detail
      | customerPO | customStoreName | adminNote |
      | [blank]    | AT Store 1      | [blank]   |
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order           | checkout    | buyer                 | store      | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by buyer | currentDate | ngoctx storder03chi01 | AT Store 1 | CHI    | $100.00 | $5.00     | Pending      | Pending     | Pending       |
    And NGOC_ADMIN_05 quit browser

    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order   | po      |
      | Ordered, Latest first | In progress  | [blank] | [blank]       | [blank] | [blank] |
    And Check order record on order page
      | ordered     | number  | store      | delivery | route        | address                                         | fulfillment |
      | currentDate | [blank] | AT Store 1 | [blank]  | Auto Route 1 | 1544 West 18th Street, Chicago, Illinois, 60608 | In progress |
    And LP go to order detail ""
    And LP see packing slip
    And LP verify info of packing slip
      | store    | buyer                 | orderDate   | customerPO | address                                         | department | receivingWeekday | receivingTime |
      | AT Store | ngoctx storder03chi01 | currentDate | [blank]    | 1544 West 18th Street, Chicago, Illinois, 60608 | [blank]    | [blank]          | [blank]       |
    And USER_LP quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v101@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region  | store            | paymentStatus | orderType | checkoutDate |
      | [blank] | ngoctx stOrder03 | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor check general info
      | buyer                 | store      | email                             | orderValue | orderTotal | payment |
      | ngoctx storder03chi01 | AT Store 1 | ngoctx+storder03chi01@podfoods.co | $100.00    | $95.00     | Pending |
    And Vendor print invoice packing slip ""
    And Vendor verify info in Invoice
      | orderDate   | invoiceNumber   | customerPO | deliveryDate | department | deliverTo                                                                           | paymentMethod |
      | currentDate | create by admin | [blank]    | [blank]      | [blank]    | ngoctx storder03chi01 - AT Store 1, 1544 West 18th Street, Chicago, Illinois, 60608 | [blank]       |
    And Vendor verify packing slip
      | index | store      | buyer                 | orderDate   | customerPO |
      | 1     | AT Store 1 | ngoctx storder03chi01 | currentDate | [blank]    |
    And VENDOR quit browser

    Given BUYER1 open web user
    When login to beta web with email "ngoctx+storder03chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER1 Go to Dashboard
    And BUYER1 Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Store 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by buyer"
    And See invoice
    And Buyer verify info in Invoice ""
      | orderDate   | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                           | paymentMethod       |
      | currentDate | [blank]       | [blank]    | [blank]      | [blank]    | ngoctx storder03chi01 - AT Store 1, 1544 West 18th Street, Chicago, Illinois, 60608 | Payment via invoice |
    And BUYER1 quit browser

  @adminOrder_23 @adminOrder
  Scenario: Verify creator field - Admin creates order
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx504@podfoods.co | 12345678a |
    When Search order by sku "31804" by api
    And Admin delete order of sku "31804" by api
    # Set PRICING Brand
    And Admin set Fixed pricing of brand "3083" with "0.25" by API
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Order 23         | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Order 23" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 23 | 31804              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx504@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType    | street                | city    | state    | zip   |
      | ngoctx stOrder02chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 23"
    And Admin create order success
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder02chi01 | ngoctx stOrder02 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin go to "creator" by redirect icon and verify

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by admin"
    Then Admin verify result order in all order
      | order           | checkout    | creator   | buyer                 | store            | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by admin | currentDate | ngoctx504 | ngoctx stOrder02chi01 | ngoctx stOrder0… | CHI    | $100.00 | $25.00    | Pending      | Pending     | Pending       |
    When Admin go to order detail number "create by admin"
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | creator   |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder02chi01 | ngoctx stOrder02 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     | ngoctx504 |
    # increase quantity with show edit history - positive integer
    And Admin edit line item in order detail
      | sub | order         | subID | sku             | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 31804 | AT SKU Order 23 | 2        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
      # increase quantity with show edit history - positive decimal
    And Admin edit line item in order detail
      | sub | order         | subID | sku             | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 31804 | AT SKU Order 23 | 2.5      | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
    # increase quantity with show edit history error
    And Admin edit line item in order detail
      | sub | order         | subID | sku             | quantity      | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 31804 | AT SKU Order 23 | 1000000000000 | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action then verify message error "999999999990 is out of range for ActiveModel::Type::Integer with limit 4 bytes"
   # revert increase quantity with don't show edit history
    And Admin edit line item in order detail
      | sub | order         | subID | sku             | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 31804 | AT SKU Order 23 | 4        | Buyer adjustment | Autotest | Change | [blank]   | No       |
    And Admin "Change" quantity line item in order detail
    And Admin revert action in order detail
    # increase quantity with don't show edit history
    And Admin edit line item in order detail
      | sub | order         | subID | sku             | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 31804 | AT SKU Order 23 | 5        | Buyer adjustment | Autotest | Change | [blank]   | No       |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
    # decrease quantity with show edit history - positive integer
    And Admin edit line item in order detail
      | sub | order         | subID | sku             | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 31804 | AT SKU Order 23 | 4        | Buyer adjustment | Autotest | Change | Yes       | Yes      |
    And Admin create subtraction items in order detail
      | quantity | category          | subCategory | comment  |
      | [blank]  | Pull date reached | Donated     | Autotest |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
      # decrease quantity with show edit history - positive decimal
    And Admin edit line item in order detail
      | sub | order         | subID | sku             | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 31804 | AT SKU Order 23 | 3.2      | Buyer adjustment | Autotest | Change | Yes       | Yes      |
    And Admin create subtraction items in order detail
      | quantity | category          | subCategory | comment  |
      | [blank]  | Pull date reached | Donated     | Autotest |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
    # revert decrease quantity with don't show edit history
    And Admin edit line item in order detail
      | sub | order         | subID | sku             | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 31804 | AT SKU Order 23 | 2        | Buyer adjustment | Autotest | Change | [blank]   | No       |
    And Admin "Change" quantity line item in order detail
    And Admin revert action in order detail
       # increase quantity with don't show edit history
    And Admin edit line item in order detail
      | sub | order         | subID | sku             | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 31804 | AT SKU Order 23 | 1        | Buyer adjustment | Autotest | Change | [blank]   | No       |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
    And Admin refresh page by button
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand             | product          | sku             | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 23 | 1 units/case | $100.00   | 1        | 7           | $100.00 |
    And Admin verify history change quantity of line item in order detail
      | sub | order         | subID | quantity | reason           | updateBy         | updateOn    | note     | showOnVendor |
      | 1   | create by api | 31804 | 3 → 1    | Buyer adjustment | Admin: ngoctx504 | currentDate | Autotest | No           |
      |     | create by api | 31804 | 4 → 3    | Buyer adjustment | Admin: ngoctx504 | currentDate | Autotest | Yes          |
      |     | create by api | 31804 | 5 → 4    | Buyer adjustment | Admin: ngoctx504 | currentDate | Autotest | Yes          |
      |     | create by api | 31804 | 2 → 5    | Buyer adjustment | Admin: ngoctx504 | currentDate | Autotest | No           |
      |     | create by api | 31804 | 1 → 2    | Buyer adjustment | Admin: ngoctx504 | currentDate | Autotest | Yes          |

    And NGOC_ADMIN_05 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName         | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | AT SKU Order 23 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName      | skuName         | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | AT Product Order | AT SKU Order 23 | randomIndex | 10               | 8               | 7        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And NGOC_ADMIN_05 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region  | store            | paymentStatus | orderType | checkoutDate |
      | [blank] | ngoctx stOrder02 | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor Check items in order detail
      | brandName         | productName      | skuName         | casePrice | quantity | total   |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 23 | $100.00   | 1        | $100.00 |
    And Vendor verify change quantity history in order detail
      | quantity | reason           | editDate    |
      | 4 → 3    | Buyer adjustment | currentDate |
      | 5 → 4    | Buyer adjustment | currentDate |
      | 1 → 2    | Buyer adjustment | currentDate |

    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName         | zeroQuantity | orderBy                 |
      | AT SKU Order 23 | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | index | productName      | skuName         | skuID | region | lotCode     | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | 1     | AT Product Order | AT SKU Order 23 | 31804 | CHI    | randomIndex | 10          | currentDate | 8          | 0         | 7      | N/A        | N/A      |
    And VENDOR quit browser

  @adminOrder_24 @adminOrder
  Scenario: Verify creator field - Buyers create order by themselves
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx505@podfoods.co | 12345678a |
    When Search order by sku "31804" by api
    And Admin delete order of sku "31804" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Order 24         | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Order 24" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 24 | 59399              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given BUYER open web user
    When login to beta web with email "ngoctx+storder02chi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch      | brand             | name            | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Order | AT Brand Store 01 | AT SKU Order 24 | 1      |
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | 30.00              | [blank]           | [blank] | $130.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | 30.00              | [blank]           | [blank] | $130.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | 30.00              | [blank]           | [blank] | $130.00 |
    And BUYER quit browser

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx505@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order           | checkout    | creator | buyer                 | store            | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by buyer | currentDate | [blank] | ngoctx stOrder02chi01 | ngoctx stOrder0… | CHI    | $100.00 | $25.00    | Pending      | Pending     | Pending       |
    When Admin go to detail after search
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder02chi01 | ngoctx stOrder02 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_25 @adminOrder_27 @adminOrder
  Scenario: Admin creates order with entering the Note for admin field
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx506@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType    | street                | city    | state    | zip   |
      | ngoctx stOrder02chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 25"
    And Admin create order success
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder02chi01 | ngoctx stOrder02 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin edit general information of order detail
      | customerPO | customStoreName | adminNote |
      | [blank]    | [blank]         | AT Note 1 |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder02chi01 | ngoctx stOrder02 | [blank]     | AT Note 1 | Pending      | Payment via invoice | Pending       | Pending     |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_26 @adminOrder
  Scenario: Admin creates order with entering the Note for admin field
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx506@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType    | street                | city    | state    | zip   |
      | ngoctx stOrder02chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin fill info optional to create new order
      | customerPO | attn    | department | noteAdmin |
      | [blank]    | [blank] | [blank]    | AT Note   |
    And Admin add line item is "AT SKU Order 26"
    And Admin create order success
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder02chi01 | ngoctx stOrder02 | [blank]     | AT Note   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin edit general information of order detail
      | customerPO | customStoreName | adminNote |
      | [blank]    | [blank]         | AT Note 1 |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder02chi01 | ngoctx stOrder02 | [blank]     | AT Note 1 | Pending      | Payment via invoice | Pending       | Pending     |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_28 @adminOrder_29 @adminOrder_33 @adminOrder
  Scenario: Admin check displayed data of buyer payment
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx507@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType    | street                | city    | state    | zip   |
      | ngoctx stOrder02chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin fill info optional to create new order
      | customerPO | attn    | department | noteAdmin |
      | [blank]    | [blank] | [blank]    | AT Note   |
    And Admin add line item is "AT SKU Order 27"
    And Admin add line item is "AT SKU Order a 01"
    And Admin create order success
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder02chi01 | ngoctx stOrder02 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_34 @adminOrder
  Scenario: Admin check displayed data of buyer payment
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx508@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType                | street                | city    | state    | zip   |
      | ngoctx stOrder04chi01 | Pay by bank or credit card | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 28"
    And Admin create order success
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType                             | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder04chi01 | ngoctx stOrder04 | [blank]     | [blank]   | Pending      | Payment via credit card or bank account | Pending       | Pending     |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_35 @adminOrder_47 @adminOrder
  Scenario: Admin check displayed data of payment date
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx509@podfoods.co | 12345678a |
    When Search order by sku "31919" by api
    And Admin delete order of sku "31919" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Order 35         | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Order 35" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 35 | 31919              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                             | password  |
      | ngoctx+storder35chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 6628      | 31919 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx509@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    When Admin go to order detail number "create by api"
    And Admin fulfill all line items
      | index | skuName         | fulfillDate |
      | 1     | AT SKU Order 35 | currentDate |
    And Admin get ID of sub-invoice of order "express"
    And Admin turn off display surcharges
    And Admin verify when turn off display surcharges

    And NGOC_ADMIN_05 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx stOrder35 | ngoctx stOrder35chi01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx stOrder35"
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 150           | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    When Admin go to order detail number "create by api"
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | paymentDate | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder35chi01 | ngoctx stOrder35 | [blank]     | [blank]   | Paid         | Payment via invoice | currentDate | Pending       | Fulfilled   |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_40 @adminOrder
  Scenario: The order has more than 1 vendor company - Only one vendor company is paid
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx510@podfoods.co | 12345678a |
    When Search order by sku "31983" by api
    And Admin delete order of sku "31983" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Order 40         | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Order 40" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 40 | 31983              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    When Search order by sku "31984" by api
    And Admin delete order of sku "31984" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Order 40v2       | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Order 40v2" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 40v2 | 31984              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx510@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder40chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 40"
    And Admin add line item is "AT SKU Order 40v2"
    And Admin create order success
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder40chi01 | ngoctx stOrder40 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin fulfill all line items
      | index | skuName           | fulfillDate |
      | 1     | AT SKU Order 40v2 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_05 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoc vc2      | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoc vc2"
    And Admin choose order in vendor statements
      | orderID       |
      | create by api |
    And Admin pay in vendor statements
      | paymentType  | description |
      | Mark as paid | Auto        |
    Then Admin verify general information vendor statement
      | vendorCompany | statementMonth | paymentState |
      | ngoc vc2      | currentDate    | [blank]      |

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by admin"
    Then Admin verify result order in all order
      | order           | checkout    | buyer                 | store            | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by admin | currentDate | ngoctx storder40chi01 | ngoctx stOrder4… | CHI    | $200.00 | $50.00    | Pending      | In progress | In progress   |
    And Admin go to order detail number "create by admin"
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder40chi01 | ngoctx stOrder40 | [blank]     | [blank]   | Pending      | Payment via invoice | In progress   | In progress |
     # Verify vendor payment
    And Admin verify info vendor payment
      | vendorCompany | fulfillment | paymentState | value   | discount | serviceFee | additionalFee | paid   | payoutDate  | paymentType |
      | ngoc vc2      | Fulfilled   | Paid         | $100.00 | $0.00    | $25.00     | $0.00         | $75.00 | currentDate | Manually    |
      | ngoc vc 1     | Pending     | Pending      | $100.00 | $0.00    | $25.00     | $0.00         | $75.00 | [blank]     | [blank]     |
    And NGOC_ADMIN_05 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+vc2v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Finances" by sidebar
    And Vendor check payment in tab summary
      | number          | store            | orderValue | paid   | datePayment |
      | create by admin | ngoctx stOrder40 | $100.00    | $75.00 | currentDate |
    And VENDOR quit browser

  @adminOrder_43 @adminOrder_45 @adminOrder_46 @adminOrder
  Scenario: Buyer/Admin creates order without entering Customer PO field
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx511@podfoods.co | 12345678a |
    When Search order by sku "32157" by api
    And Admin delete order of sku "32157" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Order 35         | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Order 35" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 35 | 32157              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 41 | 32016              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 85544              | 32157              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3250     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |


    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx511@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    When Admin go to order detail number "create by api"
    And Admin fulfill all line items
      | index | skuName         | fulfillDate |
      | 1     | AT SKU Order 43 | currentDate |

    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType    | street                | city    | state    | zip   |
      | ngoctx stOrder43chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 43"
    And Admin create order success
    And Admin fulfill all line items
      | index | skuName         | fulfillDate |
      | 1     | AT SKU Order 43 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_05 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany  | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoc vcOrder43 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoc vcOrder43"
    And Admin choose order in vendor statements
      | orderID       |
      | create by api |
    And Admin pay in vendor statements
      | paymentType  | description |
      | Mark as paid | Auto        |
    Then Admin verify general information vendor statement
      | vendorCompany  | statementMonth | paymentState |
      | ngoc vcOrder43 | currentDate    | [blank]      |

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin verify sku textbox in search the orders
      | searchValue         | brand             | product             | sku             |
      | AT BRAND ORDER 41   | AT Brand Order 41 | AT Product Order 41 | AT SKU Order 41 |
      | AT Product Order 41 | AT Brand Order 41 | AT Product Order 41 | AT SKU Order 41 |
      | AT SKU Order 41     | AT Brand Order 41 | AT Product Order 41 | AT SKU Order 41 |
    And Admin search the orders "create by admin"
    And Admin go to order detail number "create by admin"
    And Admin verify add line item in order detail
      | searchValue         | region | brand             | product             | sku             | price   | status   |
      | 32016               | CHI    | AT BRAND ORDER 41 | AT Product Order 41 | AT SKU Order 41 | $100.00 | In stock |
      | AT BRAND ORDER 41   | CHI    | AT BRAND ORDER 41 | AT Product Order 41 | AT SKU Order 41 | $100.00 | In stock |
      | AT Product Order 41 | CHI    | AT BRAND ORDER 41 | AT Product Order 41 | AT SKU Order 41 | $100.00 | In stock |
      | AT SKU Order 41     | CHI    | AT BRAND ORDER 41 | AT Product Order 41 | AT SKU Order 41 | $100.00 | In stock |
    And Admin add line item in order detail
      | skuName         | quantity | note    |
      | AT SKU Order 41 | 1        | [blank] |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Pending      | Payment via invoice | In progress   | In progress |
    And Admin delete order from order detail
      | reason           | note     | showEdit | passkey |
      | Buyer adjustment | Autotest | Yes      | [blank] |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_58 @adminOrder_59 @adminOrder_61 @adminOrder_62 @adminOrder_64 @adminOrder_65 @adminOrder_67 @adminOrder_73 @adminOrder_78 @adminOrder_82 @adminOrder_83
  @adminOrder_87 @adminOrder_88 @adminOrder_90 @adminOrder_91 @adminOrder_93 @adminOrder_94 @adminOrder_95 @adminOrder_96 @adminOrder_97 @adminOrder_99 @adminOrder_98 @adminOrder
  Scenario: Admin/Buyer delete order then delete order
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx513@podfoods.co | 12345678a |
    When Search order by sku "31495" by api
    And Admin delete order of sku "" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Order 01         | AT Product Order | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Order 01" from API
    And Admin delete inventory "all" by API
    # Delete inventory
    When Search order by sku "31633" by api
    And Admin delete order of sku "" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Order 02         | AT Product Order | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Order 02" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 01 | 31495              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 02 | 31633              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given BUYER_PE open web user
    When login to beta web with email "ngoctx+storderchi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch      | brand             | name            | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Order | AT Brand Store 01 | AT SKU Order 01 | 3      |
    And BUYER_PE refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch      | brand             | name            | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Order | AT Brand Store 01 | AT SKU Order 02 | 5      |
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $816.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $816.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $816.00 |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx513@podfoods.co" pass "12345678a" role "Admin"
      # Delete line item
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin delete line item in "sub invoice"
      | index | skuName         | reason           | note     | deduction |
      | 1     | AT SKU Order 01 | Buyer adjustment | AutoTest | Yes       |
    And Admin create subtraction items in order detail
      | quantity | category          | subCategory | comment  |
      | [blank]  | Pull date reached | Donated     | Autotest |
    And Admin delete line item success in order detail
    And Admin save action in order detail
    # Check info sau khi delete line item
    And Verify general information of order detail
      | customerPo | date        | region              | buyer               | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrderCHI01 | ngoctx stOrder01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $510.00    | $0.00    | $0.00 | Not applied         | $0.00              | $127.50          | $510.00 |
    And Admin verify history delete line item in order detail
      | sku             | deletedBy        | deletedOn | reason           | note     | showOnVendor |
      | AT SKU Order 01 | Admin: ngoctx513 | [blank]   | Buyer adjustment | AutoTest | Yes          |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v101@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region              | store            | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoctx stOrder01 | Pending       | Express   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor Check items in order detail
      | brandName         | productName      | skuName         | casePrice | quantity | total   | podConsignment  |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 02 | $102.00   | 5        | $510.00 | POD CONSIGNMENT |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 01 | $102.00   | 3        | $306.00 | NOT SET         |
    And Vendor verify change quantity history in order detail
      | quantity | reason           | editDate |
      | 3        | Buyer adjustment | [blank]  |

    And Switch to actor NGOC_ADMIN_05
    And Admin turn off show on vendor of history delete line item in order detail

    And NGOC_ADMIN_05 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName         | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | AT SKU Order 01 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName      | skuName         | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | AT Product Order | AT SKU Order 01 | randomIndex | 10               | 7               | [blank]  | 0            | [blank]    | [blank]  | [blank]          | [blank]     | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |

    And Switch to actor VENDOR
    And VENDOR refresh browser
    And Vendor Check items not display in order detail

    And VENDOR quit browser
    And NGOC_ADMIN_05 quit browser

  @adminOrder_50 @adminOrder_52 @adminOrder_54 @adminOrder
  Scenario: Finance approval - (Credit limit > Ending balance)
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx512@podfoods.co | 12345678a |
    When Search order by sku "30752" by api
    And Admin delete order of sku "30752" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]              | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Ngoc01           | AT Product Financial Pending | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Ngoc01" from API
    And Admin delete all inventory by API
    # Change credit limit
    And Admin change credit limit of buyer company "2376" by API
      | buyer_company_id | id  | limit_value |
      | 2376             | 968 | 100000      |

    # Delete inventory
    When Search order by sku "31633" by api
    And Admin delete order of sku "" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]              | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Ngoc01           | AT Product Financial Pending | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Order 02" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku           | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Ngoc01 | 30752              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stOrder50chi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product Financial Pending", sku "AT SKU Ngoc01" and add to cart with amount = "1"
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax    | total   |
      | $30.00             | [blank]           | $10.00 | $140.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax    | total   |
      | $30.00             | [blank]           | $10.00 | $140.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax    | total   |
      | $30.00             | [blank]           | $10.00 | $140.00 |
    And BUYER quit browser

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx512@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    And Admin go to order detail number ""
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder50chi01 | ngoctx stOrder50 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin verify button Send delivery confirmation is "disable"
    And Admin fulfill all line items
      | index | skuName       | fulfillDate |
      | 1     | AT SKU Ngoc01 | currentDate |
    And Admin verify button Send delivery confirmation is ""
    And NGOC_ADMIN_05 quit browser

  @adminOrder_50a @adminOrder
  Scenario: Finance approval - (Credit limit < Ending balance)
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx512@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "65534" by api
    And Admin delete order of sku "65534" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]              | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Ngoc02           | AT Product Financial Pending | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Ngoc02" from API
    And Admin delete all inventory by API
      # Delete buyer company
    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | AT Buyer Financial 02 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API

     # Create buyer company by api
    And Admin create buyer company by API
      | name                  | ein    | launcher_id | manager_id | website                        | store_type_id |
      | AT Buyer Financial 02 | 01-123 | 83          | 83         | https://beta.podfoods.co/login | 2             |
    # Create store by api
    And Admin create store by API
      | name                    | email                               | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | ngoctx stpenfinancial02 | ngoctx+stpenfinancial02@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
    # Create buyer account
    And Admin create "store" buyer account by API
      | first_name | last_name          | email                                 | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | ngoctx     | bpenfinancialchi02 | ngoctx+bpenfinancialchi02@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |
    # Change credit limit
    And Admin change credit limit of buyer company "random" by API
      | buyer_company_id | limit_value |
      | random           | 1000        |
    # Create inventory
    And Admin create inventory api1
      | index | sku           | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Ngoc02 | 65534              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given BUYER open web user
    When login to beta web with email "ngoctx+bpenfinancialchi02@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product Financial Pending", sku "AT SKU Ngoc02" and add to cart with amount = "1"
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax    | total   |
      | $30.00             | [blank]           | $10.00 | $140.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax    | total   |
      | $30.00             | [blank]           | $10.00 | $140.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax    | total   |
      | $30.00             | [blank]           | $10.00 | $140.00 |
    And BUYER quit browser

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx512@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order           | checkout    | buyer                     | store            | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment | financePending |
      | create by buyer | currentDate | ngoctx bpenfinancialchi02 | ngoctx stpenfin… | CHI    | $100.00 | $25.00    | Pending      | Pending     | Pending       | Yes            |
    And Admin go to order detail number ""
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                     | store                   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx bpenfinancialchi02 | ngoctx stpenfinancial02 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    When Admin approve to fulfill this order
    And Admin expand line item in order detail
    And Admin fulfill all line items
      | index | skuName       | fulfillDate |
      | 1     | AT SKU Ngoc02 | currentDate |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                     | store                   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | financeApproval | financeApproveBy | financeApproveAt |
      | Empty      | currentDate | Chicagoland Express | ngoctx bpenfinancialchi02 | ngoctx stpenfinancial02 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Fulfilled   | Approved        | Admin: ngoctx512 | currentDate      |
    And NGOC_ADMIN_05 quit browser

    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx512@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "65534" by api
    And Admin delete order of sku "65534" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]              | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Ngoc02           | AT Product Financial Pending | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Ngoc02" from API
    And Admin delete all inventory by API
      # Delete buyer company
    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | AT Buyer Financial 02 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API

  @adminOrder_58a @adminOrder
  Scenario: Admin delete Express line item + Check deduction + inventory more lotcode
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx514@podfoods.co | 12345678a |
    When Search order by sku "59404" by api
    And Admin delete order of sku "59404" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Order a58        | AT Product Order | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Order a58" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order a58 | 59404              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 2     | AT SKU Order a58 | 59404              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
   # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123950             | 59404              | 1        | false     | [blank]          |
      | 84628              | 31633              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3187     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | IL                 | Illinois           |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx514@podfoods.co" pass "12345678a" role "Admin"
      # Delete line item
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin delete line item in "sub invoice"
      | index | skuName          | reason           | note     | deduction |
      | 1     | AT SKU Order a58 | Buyer adjustment | Autotest | Yes       |
    And Admin create subtraction items in order detail
      | quantity | category          | subCategory | comment  |
      | [blank]  | Pull date reached | Donated     | Autotest |
    And Admin delete line item success in order detail
    And Admin save action in order detail
    # Check info sau khi delete line item
    And Verify general information of order detail
      | customerPo | date        | region              | buyer               | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrderCHI01 | ngoctx stOrder01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $102.00    | $0.00    | $0.00 | $30.00              | $0.00              | $25.50           | $132.00 |

    And NGOC_ADMIN_05 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName          | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | AT SKU Order a58 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName      | skuName          | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | AT Product Order | AT SKU Order a58 | randomIndex | 10               | 9               | 9        | 0            | [blank]    | [blank]  | [blank]          | [blank]     | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_100 @adminOrder_104 @adminOrder
  Scenario: Verify Order with store not set All possible delivery days, Receiving weekday
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx515@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder100chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 100"
    And Admin create order success
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder100chi01 | ngoctx stOrder100 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_101 @adminOrder_110 @adminOrder
  Scenario: All possible delivery day - Store not set All possible delivery days
  cenario: Admin check displayed data of payment date
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx516@podfoods.co | 12345678a |
    When Search order by sku "59405" by api
    And Admin delete order of sku "59405" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Order 101        | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Order 35" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 101 | 59405              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx516@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder101chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 101"
    And Admin create order success

    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder101chi01 | ngoctx stOrder101 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin get ID of sub-invoice of order "express"
    And Admin verify receiving info
      | possibleReceiving | setReceiving | receivingTime              |
      | Full Day          | [blank]      | Pacific Time (US & Canada) |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_102 @adminOrder_108 @adminOrder
  Scenario: All possible delivery day - Store set All possible delivery days = Within 7 business days
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx517@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder102chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 102"
    And Admin create order success

    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder102chi01 | ngoctx stOrder102 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin verify receiving info
      | possibleReceiving      | setReceiving | receivingTime              |
      | Within 7 business days | [blank]      | Pacific Time (US & Canada) |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_103 @adminOrder
  Scenario: All possible delivery day - Store set All possible delivery days = Within 7 business days
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx518@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 100 | 32212              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx518@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder103chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 100"
    And Admin create order success

    And NGOC_ADMIN_05 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx stOrder103 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin go to detail of store "ngoctx stOrder103"
    And Admin change possible delivery day
      | date     | mon | tue     | wed     | thu     | fri     | sat     | sun     |
      | Full day | Yes | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] |

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by admin"
    And Admin go to order detail number "create by admin"
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder103chi01 | ngoctx stOrder103 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin verify receiving info
      | possibleReceiving | setReceiving | receivingTime              |
      | Mon               | [blank]      | Pacific Time (US & Canada) |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_105 @adminOrder
  Scenario: Verify Set receiving weekdays with a route is not assigned to a store
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx519@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 100 | 32212              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx519@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx stOrder105 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    When Admin go to detail of store "ngoctx stOrder105"
    And Admin change set receiving day in store detail
      | date     | mon | tue     | wed     | thu     | fri     | sat     | sun     |
      | Full day | Yes | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] |
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder105chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 100"
    And Admin create order success

    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder105chi01 | ngoctx stOrder105 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin verify receiving info
      | possibleReceiving | setReceiving | receivingTime              |
      | Mon               | Mon          | Pacific Time (US & Canada) |
    And Admin verify set receiving weekdays "Tuesday"
    And Admin verify remove set receiving weekday
    And Admin verify receiving info
      | possibleReceiving | setReceiving | receivingTime              |
      | Mon               | Mon          | Pacific Time (US & Canada) |

    And NGOC_ADMIN_05 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx stOrder105 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    When Admin go to detail of store "ngoctx stOrder105"
    And Admin change set receiving day in store detail
      | date     | mon | tue     | wed     | thu     | fri     | sat     | sun     |
      | Full day | Yes | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] |

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by admin"
    And Admin go to order detail number "create by admin"
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder105chi01 | ngoctx stOrder105 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin verify receiving info
      | possibleReceiving | setReceiving | receivingTime              |
      | Mon               | [blank]      | Pacific Time (US & Canada) |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_106 @adminOrder_109 @adminOrder_110 @adminOrder_111 @adminOrder_112 @adminOrder_113 @adminOrder_114
  @adminOrder_115 @adminOrder_116 @adminOrder_117 @adminOrder_118 @adminOrder
  Scenario: Verify Set receiving weekdays with a route is assigned to a store
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx520@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 100 | 32212              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx520@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx stOrder106 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    When Admin go to detail of store "ngoctx stOrder106"
    And Admin edit general information of store
      | name    | storeSize | invoiceOption | dateThreshold | mile    | referredBy | region  | route        | email   | phone   | timeZone | expressNote  | directNote  | liftGate | retailerStore |
      | [blank] | [blank]   | [blank]       | [blank]       | [blank] | [blank]    | [blank] | Auto Route 2 | [blank] | [blank] | [blank]  | Express Note | Direct Note | [blank]  | [blank]       |

    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder106chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 100"
    And Admin create order success

    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | route        |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder106chi01 | ngoctx stOrder106 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     | Auto Route 2 |
    And Admin verify receiving info
      | possibleReceiving | setReceiving | receivingTime              |
      | Mon               | Mon          | Pacific Time (US & Canada) |
    And Admin verify set receiving weekdays "Monday"
    And Admin verify remove set receiving weekday
    And Admin verify receiving info
      | possibleReceiving | setReceiving | receivingTime              |
      | Mon               | Mon          | Pacific Time (US & Canada) |

    And NGOC_ADMIN_05 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx stOrder106 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    When Admin go to detail of store "ngoctx stOrder106"
    And Admin edit general information of store
      | name    | storeSize | invoiceOption | dateThreshold | mile    | referredBy | region  | route | email   | phone   | timeZone | expressNote | directNote | liftGate | retailerStore |
      | [blank] | [blank]   | [blank]       | [blank]       | [blank] | [blank]    | [blank] | -     | [blank] | [blank] | [blank]  | [blank]     | [blank]    | [blank]  | [blank]       |

    And Admin change set receiving day in store detail
      | date     | mon | tue     | wed     | thu     | fri     | sat     | sun     |
      | Full day | Yes | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] |
    And Admin change receiving time in store detail
      | startTime | endTime |
      | 00:30     | 01:00   |

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by admin"
    And Admin go to order detail number "create by admin"
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder106chi01 | ngoctx stOrder106 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin verify receiving info
      | possibleReceiving | setReceiving | receivingTime              |
      | Mon               | [blank]      | Pacific Time (US & Canada) |
    And Admin change receiving time in order detail
      | startTime | endTime |
      | 00:30     | 01:00   |
    And Admin change department in order detail "Cheese"
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | [blank]          | currentDate     | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_05 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx stOrder106 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    When Admin go to detail of store "ngoctx stOrder106"
    And Admin verify general information of all store
      | name              | nameCompany | stateStore | storeSize | storeType     | invoiceOption | sendInvoice                                      | threshold | region              | street                | city    | state    | zip   | email                         | apEmail | phone      | timezone                   | day | start | end   | route   | referredBy |
      | ngoctx stOrder106 | ngoc cpn1   | Active     | <50k      | Grocery Store | Yes           | One day after sub-invoice is marked as fulfilled | 35 day(s) | Chicagoland Express | 1544 West 18th Street | Chicago | Illinois | 60608 | ngoctx+stOrder106@podfoods.co | [blank] | 1234567890 | Pacific Time (US & Canada) | Mon | 00:30 | 01:00 | [blank] | [blank]    |
    And NGOC_ADMIN_05 quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order   | po      |
      | Ordered, Latest first | In progress  | [blank] | [blank]       | [blank] | [blank] |
    And Check order record on order page
      | ordered     | number  | store             | delivery  | route   | address                                         | fulfillment |
      | currentDate | [blank] | ngoctx stOrder106 | Every Mon | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | In progress |
    And LP go to order detail "create by admin"
    And LP see packing slip
    And LP verify info of packing slip
      | store             | buyer                  | orderDate   | customerPO | address                                         | department | receivingWeekday | receivingTime             |
      | ngoctx stOrder106 | ngoctx storder106chi01 | currentDate | [blank]    | 1544 West 18th Street, Chicago, Illinois, 60608 | Cheese     | Every Mon        | 12:30 am - 01:00 am (PST) |
    Given USER_LP quit browser

    Given BUYER open web user
    And login to beta web with email "ngoctx+storder106chi01@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Store 01 | currentDate   | [blank]        |
    And Go to order detail with order number ""
    And See invoice
    And Buyer verify info in Invoice "create by admin"
      | orderDate   | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                                   | paymentMethod       |
      | currentDate | [blank]       | [blank]    | [blank]      | Cheese     | ngoctx storder106chi01 - ngoctx stOrder106, 1544 West 18th Street, Chicago, Illinois, 60608 | Payment via invoice |
    And Buyer switch to parent page from invoice
    Given BUYER quit browser

    Given NGOC_ADMIN_05A open web admin
    When NGOC_ADMIN_05A login to web with role Admin
    And NGOC_ADMIN_05A navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx stOrder106 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    When Admin go to detail of store "ngoctx stOrder106"
    And Admin edit general information of store
      | name    | storeSize | invoiceOption | dateThreshold | mile    | referredBy | region  | route        | email   | phone   | timeZone | expressNote | directNote | liftGate | retailerStore |
      | [blank] | [blank]   | [blank]       | [blank]       | [blank] | [blank]    | [blank] | Auto Route 2 | [blank] | [blank] | [blank]  | [blank]     | [blank]    | [blank]  | [blank]       |
    And NGOC_ADMIN_05A quit browser

  @adminOrder_119 @adminOrder_120 @adminOrder_121 @adminOrder_122 @adminOrder_123 @adminOrder_124 @adminOrder_125 @adminOrder_126 @adminOrder
  Scenario: Verify Set receiving weekdays with a route is assigned to a store case 2
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx521@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "32654" by api
    And Admin delete order of sku "32654" by api
    When Search order by sku "32653" by api
    And Admin delete order of sku "32653" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Order 119        | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Order 119" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 119 | 32653              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 86461              | 32653              | 1        | false     | [blank]          |
      | 86465              | 32654              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3250     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx521@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "sub invoice" in order details
      | brand             | product          | sku              | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 119 | 1 units/case | $100.00   | 1        | 9           | $100.00 |
    And Admin check line items "non invoice" in order details
      | brand             | product          | sku               | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 119b | 1 units/case | $100.00   | 1        | [blank]     | $100.00 |
     # Create purchase order
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    When Admin fulfill all line items
      | index | skuName          | fulfillDate |
      | 1     | AT SKU Order 119 | currentDate |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | In progress |
    And Admin unfulfill all line items created by buyer
      | index | skuName          |
      | 1     | AT SKU Order 119 |
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | Minus1          | [blank] | adminNote | lpNote |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Awaiting POD      | Yes         |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin delete line item in "non invoice"
      | index | skuName           | reason  | note    | deduction |
      | 1     | AT SKU Order 119b | [blank] | [blank] | No        |
    And Admin save action in order detail
    And Admin check line items "deleted or shorted items" in order details
      | brand             | product          | sku               | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 119b | 1 units/case | $100.00   | 1        | [blank]     | $100.00 |
    And Admin check line items "sub invoice" in order details when collapse
    And NGOC_ADMIN_05 quit browser

  @adminOrder_127 @adminOrder
  Scenario: Admin create sub-invoice - create sub-invoice for line item belong to Non-invoiced - Do not enter Suffix
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx522@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 127 | 32655              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx522@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder127chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 127"
    And Admin create order success
    And Admin add line item in order detail
      | skuName          | quantity | note    |
      | AT SKU Order 134 | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName          |
      | AT SKU Order 134 |
    And Admin get ID of sub-invoice 2 of order "express"

    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 127b | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix =""
      | skuName           |
      | AT SKU Order 127b |
    And Admin get ID of sub-invoice 3 of order "direct"

    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 127c | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix =""
      | skuName           |
      | AT SKU Order 127c |
    And Admin get ID of sub-invoice 4 of order "direct"
    And NGOC_ADMIN_05 quit browser

  @adminOrder_128 @adminOrder
  Scenario: Admin create sub-invoice - create sub-invoice for line item belong to Non-invoiced - Enter Suffix
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx523@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 127 | 32655              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx523@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder127chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 127"
    And Admin create order success
    And Admin add line item in order detail
      | skuID            | skuName          | quantity | note    |
      | AT SKU Order 134 | AT SKU Order 134 | 1        | [blank] |

    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName          |
      | AT SKU Order 134 |
    And Admin get ID of sub-invoice 2 of order "express"

    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 127b | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="3"
      | skuName           |
      | AT SKU Order 127b |
    And Admin get ID of sub-invoice 3 of order "direct"

    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 127c | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="4"
      | skuName           |
      | AT SKU Order 127c |
    And Admin get ID of sub-invoice 4 of order "direct"
    And NGOC_ADMIN_05 quit browser

  @adminOrder_129 @adminOrder_130 @adminOrder
  Scenario: Admin create sub-invoice - create sub-invoice for line item belong to Non-invoiced - Enter existing Pod Express Suffix
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx524@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 127 | 32655              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx524@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder127chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 127"
    And Admin create order success
    And Admin add line item in order detail
      | skuName          | quantity | note    |
      | AT SKU Order 134 | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="1" error "Validation failed: Surfix has already been taken"
      | skuName          |
      | AT SKU Order 134 |
    And Admin delete line item in "non invoice"
      | index | skuName          | reason  | note    | deduction |
      | 1     | AT SKU Order 134 | [blank] | [blank] | No        |
    And Admin save action in order detail
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 127b | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="1" error "Validation failed: Surfix has already been taken"
      | skuName           |
      | AT SKU Order 127b |
    And Admin delete line item in "non invoice"
      | index | skuName           | reason  | note    | deduction |
      | 1     | AT SKU Order 127b | [blank] | [blank] | No        |
    And Admin save action in order detail
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 127c | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="1" error "Validation failed: Surfix has already been taken"
      | skuName           |
      | AT SKU Order 127c |
    And Admin delete line item in "non invoice"
      | index | skuName           | reason  | note    | deduction |
      | 1     | AT SKU Order 127c | [blank] | [blank] | No        |
    And Admin save action in order detail
    And NGOC_ADMIN_05 quit browser

  @adminOrder_131 @adminOrder_132 @adminOrder_133 @adminOrder
  Scenario: Admin create sub-invoice - create sub-invoice for line item belong to Non-invoiced - Enter existing Pod Direct Suffix
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx525@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 127 | 32655              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx525@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder127chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 127b"
    And Admin create order success
    And Admin create "create" sub-invoice with Suffix =""
      | skuName           |
      | AT SKU Order 127b |
    And Admin add line item in order detail
      | skuName          | quantity | note    |
      | AT SKU Order 127 | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="1" error "Validation failed: Surfix has already been taken"
      | skuName          |
      | AT SKU Order 127 |
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 127c | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="1" error "Validation failed: Surfix has already been taken"
      | skuName           |
      | AT SKU Order 127c |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_134 @adminOrder
  Scenario: Split-Merge sub-invoice - Add 1 line item to new sub-invoice
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx526@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 134 | 32740              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 134b | 32741              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx526@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder134chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 134"
    And Admin add line item is "AT SKU Order 134b"
    And Admin create order success
    # Create purchase order
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin create "create" sub-invoice with Suffix =""
      | skuName           |
      | AT SKU Order 134b |
    And Admin get ID of sub-invoice by info
      | index | skuName           | type    |
      | 1     | AT SKU Order 134  | express |
      | 1     | AT SKU Order 134b | express |
    And Admin check line items "sub invoice" in order details
      | brand             | product          | sku               | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134  | 1 units/case | $100.00   | 1        | [blank]     | $100.00 |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | 1 units/case | $100.00   | 1        | [blank]     | $100.00 |
    # Edit purchase order
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |

    # Verify order summary
    And NGOC_ADMIN_05 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber     | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by admin | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store             | buyer                  | city    | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | CHI    | currentDate | ngoctx stOrder134 | ngoctx storder134chi01 | Chicago | Illinois     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice by subinvoice "create by api" in Order summary
      | index | po  | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | 1     | Yes | $0.00         | $130.00      | $25.00       | 1.00 lbs    | -   |
      | 2     | No  | $0.00         | $100.00      | $25.00       | 1.00 lbs    | -   |
    And Admin check invoice detail of order "create by api" in Order summary
      | sub | brand             | product          | sku               | tmp | delivery  | quantity | endQuantity | warehouse                  | fulfillment |
      | 1   | AT Brand Store 01 | AT Product Order | AT SKU Order 134  | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |
      | 2   | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |
    And NGOC_ADMIN_05 quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+storder134chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Store 01 | currentDate   | Plus1          |
    And Go to order detail with order number ""
    And Buyer check items in order detail have multi sub invoice
      | sub | index | brandName         | productName      | skuName           | unitPerCase | casePrice | quantity | total   | addCart | unitUPC                      | priceUnit    | caseUnit    |
      | 1   | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 134  | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case |
      | 1   | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case |
    And BUYER quit browser

  @adminOrder_135 @adminOrder
  Scenario: Split-Merge sub-invoice - Add all line item to new sub-invoice
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx527@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 134 | 32740              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 134b | 32741              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx527@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder134chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 134"
    And Admin add line item is "AT SKU Order 134b"
    And Admin create order success
    And Admin create "create" sub-invoice with Suffix =""
      | type | skuName           | suffix  |
      | 1    | AT SKU Order 134  | [blank] |
      | 1    | AT SKU Order 134b | [blank] |
    And Admin get ID of sub-invoice by info
      | index | skuName          | type    |
      | 1     | AT SKU Order 134 | express |
    And Admin check line items "sub invoice" in order details
      | brand             | product          | sku              | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | 1 units/case | $100.00   | 1        | [blank]     | $100.00 |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | 1 units/case | $100.00   | 1        | [blank]     | $100.00 |
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | [blank]   | [blank] |
    And Admin create "create" sub-invoice with Suffix ="3"
      | skuName           |
      | AT SKU Order 134b |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | Chicagoland Express | ngoctx storder134chi01 | ngoctx stOrder134 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 2   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Pending           | Yes         |
      | 3   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Pending           | Yes         |
    # Verify in order summary
    When Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store             | buyer                  | city    | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | CHI    | currentDate | ngoctx stOrder134 | ngoctx storder134chi01 | Chicago | Illinois     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin check express invoice by subinvoice "create by api" in Order summary
      | index | po  | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | 2     | Yes | $0.00         | $100.00      | $25.00       | 1.00 lbs    | -   |
      | 3     | No  | $0.00         | $100.00      | $25.00       | 1.00 lbs    | -   |
    And Admin check invoice detail in Order summary
      | index | brand             | product          | sku              | tmp | delivery  | quantity | endQuantity | warehouse                  | fulfillment |
      | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |
      | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |
    And Admin go back by browser
     # Verify in order summary
    And Admin create "add to" sub-invoice with Suffix ="1"
      | skuName           |
      | AT SKU Order 134b |
    Then Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | Chicagoland Express | ngoctx storder134chi01 | ngoctx stOrder134 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 2   | [blank] | Pending       | $200.00 | 2             | 2.00 lbs    | Pending           | Yes         |
    When Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store             | buyer                  | city    | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | CHI    | currentDate | ngoctx stOrder134 | ngoctx storder134chi01 | Chicago | Illinois     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin check express invoice by subinvoice "create by api" in Order summary
      | index | po  | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | 2     | Yes | $0.00         | $200.00      | $50.00       | 2.00 lbs    | -   |
    And Admin check invoice detail in Order summary
      | index | brand             | product          | sku              | tmp | delivery  | quantity | endQuantity | warehouse                  | fulfillment |
      | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |
      | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |
    And NGOC_ADMIN_05 quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+storder134chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Store 01 | currentDate   | Plus1          |
    And Go to order detail with order number ""
    And Check items in order detail
      | brandName         | productName      | skuName          | casePrice | quantity | total   | addCart |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | [blank] |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | [blank] |
    And BUYER quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v101@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region              | store             | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoctx stOrder134 | [blank]       | Express   | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor Check items in order detail
      | brandName         | productName      | skuName          | casePrice | quantity | total   | podConsignment  |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | POD CONSIGNMENT |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | POD CONSIGNMENT |

  @adminOrder_136 @adminOrder
  Scenario: Split-Merge sub-invoice - Merge 2 sub-invoice to 1 with PE item and PD item
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx528@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 134 | 32740              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx528@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder134chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 134"
    And Admin create order success
    And Admin add line item in order detail
      | skuName          | quantity | note    |
      | AT SKU Order 136 | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix =""
      | skuName          |
      | AT SKU Order 136 |
    And Admin create "create" sub-invoice with Suffix ="" error "Line items must be the same type(direct/warehoused)"
      | skuName          |
      | AT SKU Order 134 |
      | AT SKU Order 136 |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_137 @adminOrder
  Scenario: Split-Merge sub-invoice - Merge 2 sub-invoice to 1 with PE in 2 vendor company
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx529@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder134chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 136"
    And Admin create order success
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 137b | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix =""
      | skuName           |
      | AT SKU Order 137b |
    And Admin create "create" sub-invoice with Suffix ="" error "Direct line items must belong to the same company"
      | skuName           |
      | AT SKU Order 136  |
      | AT SKU Order 137b |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_138 @adminOrder
  Scenario: Split-Merge sub-invoice - Create subinvoice with PE and new PD item
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx530@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 138 | 32815              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx530@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder134chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 138"
    And Admin add line item is "AT SKU Order 138b"
    And Admin create order success
    And Admin create "create" sub-invoice with Suffix =""
      | skuName           |
      | AT SKU Order 138b |
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 138c | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="" error "Line items must be the same type(direct/warehoused)"
      | skuName           |
      | AT SKU Order 138  |
      | AT SKU Order 138c |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_140 @adminOrder
  Scenario: Split-Merge sub-invoice - Create subinvoice with PD and new PD belong to other vendor company
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx532@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder134chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 138b"
    And Admin add line item is "AT SKU Order 140b"
    And Admin create order success
    And Admin create "create" sub-invoice with Suffix =""
      | skuName           |
      | AT SKU Order 138b |
    And Admin create "create" sub-invoice with Suffix =""
      | skuName           |
      | AT SKU Order 140b |
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 140c | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="" error "Direct line items must belong to the same company"
      | skuName           |
      | AT SKU Order 138b |
      | AT SKU Order 140c |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_141 @adminOrder
  Scenario: Vendor create a sub-invoice number when confirm sub-invoice
    Given Buyer login web with by api
      | email                              | password  |
      | ngoctx+storder134chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 6628      | 32825 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v101@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region  | store             | paymentStatus | orderType | checkoutDate |
      | [blank] | ngoctx stOrder134 | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor select items to confirm in order
      | sku              | date  |
      | AT SKU Order 141 | Plus1 |
    And Vendor confirm with delivery method with info
      | delivery             | store             | address                                         |
      | Ship Direct to Store | ngoctx stOrder134 | 1544 West 18th Street, Chicago, Illinois, 60608 |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | USPS    | 12345678       | Auto    |
    And Vendor view delivery detail of "Ship Direct to Store"
      | item             | quantity | deliveryMethod       | store             | address                                         | deliveryDate | carrier | trackingNumber | comment |
      | AT SKU Order 141 | 1        | Ship Direct to Store | ngoctx stOrder134 | 1544 West 18th Street, Chicago, Illinois, 60608 | currentDate  | USPS    | 12345678       | Auto    |
    And Vendor verify sub-invoice created after confirm
      | index | sku              | suffix |
      | 1     | AT SKU Order 141 | 1      |
    And VENDOR quit browser

  @adminOrder_139 @adminOrder
  Scenario: Split-Merge sub-invoice - Create subinvoice with PD and new PE item
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx531@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 138 | 32815              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 139b | 32821              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx531@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder134chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 138"
    And Admin add line item is "AT SKU Order 138b"
    And Admin create order success
    And Admin create "create" sub-invoice with Suffix =""
      | skuName           |
      | AT SKU Order 138b |
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 139b | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="" error "Line items must be the same type(direct/warehoused)"
      | skuName           |
      | AT SKU Order 138b |
      | AT SKU Order 139b |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_142 @adminOrder
  Scenario: Admin remove sub-invoice - without PO
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx534@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 142 | 32838              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx534@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder134chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 142"
    And Admin create order success
    And Admin get ID of sub-invoice by info
      | index | skuName          | type    |
      | 1     | AT SKU Order 142 | express |
    And Admin remove sub-invoice with info
      | index | skuName          | type    | subinvoice |
      | 1     | AT SKU Order 142 | express | [blank]    |
    And Admin check line items "non invoice" in order details
      | brand             | product          | sku              | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 142 | 1 units/case | $100.00   | 1        | [blank]     | $100.00 |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_143 @adminOrder
  Scenario: Admin remove sub-invoice - with PO unconfirmed
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx535@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 142 | 32838              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx535@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder134chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 142"
    And Admin create order success
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice by info
      | index | skuName          | type    |
      | 1     | AT SKU Order 142 | express |
    And Admin remove sub-invoice with info
      | index | skuName          | type    | subinvoice |
      | 1     | AT SKU Order 142 | express | [blank]    |
    And Admin check line items "non invoice" in order details
      | brand             | product          | sku              | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 142 | 1 units/case | $100.00   | 1        | [blank]     | $100.00 |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_144 @adminOrder
  Scenario: Admin remove sub-invoice - with PO fulfilled
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx535@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 142 | 32838              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx536@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder134chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 142"
    And Admin create order success
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | [blank]          | currentDate     | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice by info
      | index | skuName          | type    |
      | 1     | AT SKU Order 142 | express |
    And Admin verify line item can not remove after fulfilled PO
      | index | skuName          |
      | 1     | AT SKU Order 142 |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_145 @adminOrder
  Scenario: Vendor remove all item from sub-invoice
    Given Buyer login web with by api
      | email                              | password  |
      | ngoctx+storder134chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 6628      | 32839 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v101@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region  | store             | paymentStatus | orderType | checkoutDate |
      | [blank] | ngoctx stOrder134 | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor select items to confirm in order
      | sku              | date  |
      | AT SKU Order 145 | Plus1 |
    And Vendor confirm with delivery method with info
      | delivery             | store             | address                                         |
      | Ship Direct to Store | ngoctx stOrder134 | 1544 West 18th Street, Chicago, Illinois, 60608 |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | USPS    | 12345678       | Auto    |
    And Vendor get ID sub invoice
      | index | sku              |
      | 1     | AT SKU Order 145 |
    And Vendor remove sub invoice "all"
      | index | sku              | itemRemove       |
      | 1     | AT SKU Order 145 | AT SKU Order 145 |
    And Vendor verify unconfirmed item
    And Vendor Check items in order detail
      | brandName         | productName      | skuName          | casePrice | quantity | total   | podConsignment |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 145 | $100.00   | 1        | $100.00 | not set        |
    And VENDOR quit browser

  @adminOrder_146 @adminOrder
  Scenario: Vendor remove part of item from sub-invoice
    Given Buyer login web with by api
      | email                              | password  |
      | ngoctx+storder134chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 6628      | 32839 | 1        |
      | 6628      | 32840 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v101@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region  | store             | paymentStatus | orderType | checkoutDate |
      | [blank] | ngoctx stOrder134 | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor select items to confirm in order
      | sku               | date  |
      | AT SKU Order 145  | Plus1 |
      | AT SKU Order 146b | Plus1 |
    And Vendor confirm with delivery method with info
      | delivery             | store             | address                                         |
      | Ship Direct to Store | ngoctx stOrder134 | 1544 West 18th Street, Chicago, Illinois, 60608 |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | USPS    | 12345678       | Auto    |
    And Vendor get ID sub invoice
      | index | sku              |
      | 1     | AT SKU Order 145 |
    And Vendor remove sub invoice ""
      | index | sku              | itemRemove        |
      | 1     | AT SKU Order 145 | AT SKU Order 146b |
    And Vendor verify unconfirmed item
    And Vendor Check items in order detail
      | brandName         | productName      | skuName           | casePrice | quantity | total   | podConsignment |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 146b | $100.00   | 1        | $100.00 | not set        |
    And Vendor Check items in order detail by subInvoice
      | index | brandName         | productName      | skuName          | casePrice | quantity | total   |
      | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 145 | $100.00   | 1        | $100.00 |
    And VENDOR quit browser

  @adminOrder_147 @adminOrder_148 @adminOrder_149 @adminOrder
  Scenario: Admin create sub-invoice of order lock or paid
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx539@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 147a | 64602              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132628             | 64602              | 1        | false     | [blank]          |
      | 86472              | 32656              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3287     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
    # Fulfilled this order
    Then Admin update line item in order by api
      | index | skuName           | skuId | order_id      | fulfilled | fulfillmentDate |
      | 1     | AT SKU Order 147a | 64602 | create by api | true      | currentDate     |
    # Paid order
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx539@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store             | buyer                  | statementMonth | region  | managedBy |
      | [blank]      | ngoctx stOrder147 | ngoctx storder147chi01 | currentDate    | [blank] | [blank]   |
    And Admin go to detail of store statement "ngoctx stOrder147"
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | 1       | 130           | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success

    # Verify
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin verify line item express "AT SKU Order 147a" index "1" can not edit of order paid
    And Admin verify message "This order can't be edited because it has been locked or paid" after click fulfill order paid
      | index | skuName           |
      | 1     | AT SKU Order 147a |
    And Admin create "add to" sub-invoice with Suffix ="1" error "Line items must be the same type(direct/warehoused)"
      | skuName           |
      | AT SKU Order 127b |
    And Admin verify message "This order can't be edited because it has been locked or paid" after click turn off display surcharge
    And NGOC_ADMIN_05 quit browser

  @adminOrder_152 @adminOrder
  Scenario: Admin check ETA in order with PD item (Store set Receiving weekdays is delivery day: Mon, Tue..)
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx541@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx stOrder150 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    When Admin go to detail of store "ngoctx stOrder150"
    And Admin change set receiving day is current day in store detail

    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder150chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 150c"
    And Admin create order success
    And Admin create "create" sub-invoice with Suffix ="1"
      | skuName           |
      | AT SKU Order 150c |
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 150d | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName           |
      | AT SKU Order 150d |
    And Admin check Sub invoice
      | eta     | paymentStatus | total   | totalQuantity | totalWeight |
      | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    |
      | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | Chicagoland Express | ngoctx storder150chi01 | ngoctx stOrder150 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    When Admin fulfill all line items
      | index | skuName           | fulfillDate |
      | 1     | AT SKU Order 150c | currentDate |
      | 1     | AT SKU Order 150d | currentDate |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | Chicagoland Express | ngoctx storder150chi01 | ngoctx stOrder150 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Fulfilled   |

    And NGOC_ADMIN_05 quit browser

  @adminOrder_153 @adminOrder_154 @adminOrder
  Scenario: Admin check ETA in order with PE item (Store set Receiving weekdays is within 7 business days)
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx542@podfoods.co | 12345678a |
    When Search order by sku "32864" by api
    And Admin delete order of sku "32864" by api
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 150 | 32864              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 150b | 32865              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx542@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder153chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 150"
    And Admin create order success
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 150b | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName           |
      | AT SKU Order 150b |
    And Admin check Sub invoice
      | eta     | paymentStatus | total   | totalQuantity | totalWeight |
      | Plus9   | Pending       | $100.00 | 1             | 1.00 lbs    |
      | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_155 @adminOrder
  Scenario: Admin check ETA in order with PD item (Store set Receiving weekdays is within 7 business days)
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx543@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder153chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 150c"
    And Admin create order success
    And Admin create "create" sub-invoice with Suffix ="1"
      | skuName           |
      | AT SKU Order 150c |
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 150d | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName           |
      | AT SKU Order 150d |
    And Admin check Sub invoice
      | eta     | paymentStatus | total   | totalQuantity | totalWeight |
      | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    |
      | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_156 @adminOrder
  Scenario: Admin check ETA in order with PE item (Store not set Receiving weekdays)
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx544@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 150 | 32864              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx544@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder156chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 150"
    And Admin create order success
    And Admin expand line item in order detail
    And Admin check Sub invoice
      | eta     | paymentStatus | total   | totalQuantity | totalWeight |
      | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    |
    And Admin verify ETA email not set
    And NGOC_ADMIN_05 quit browser

  @adminOrder_157 @adminOrder
  Scenario: Admin check ETA in order with PE item (Store not set Receiving weekdays)
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx545@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder156chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 150c"
    And Admin create order success
    And Admin create "create" sub-invoice with Suffix ="1"
      | skuName           |
      | AT SKU Order 150c |
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 150d | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName           |
      | AT SKU Order 150d |
    And Admin check Sub invoice
      | eta     | paymentStatus | total   | totalQuantity | totalWeight |
      | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    |
      | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_158 @adminOrder
  Scenario: Admin enter Fulfillment date for PO of express sub-invoice
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx546@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 150 | 32864              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx546@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder150chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 150"
    And Admin create order success
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice by info
      | index | skuName          | type    |
      | 1     | AT SKU Order 150 | express |
    And Admin check Sub invoice
      | eta     | paymentStatus | total   | totalQuantity | totalWeight |
      | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    |
    And NGOC_ADMIN_05 quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+storder150chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Store 01 | currentDate   | [blank]        |
    And Go to order detail with order number ""
    And Buyer check items in order detail have multi sub invoice
      | sub | index | brandName         | productName      | skuName          | unitPerCase | casePrice | quantity | total   | addCart | unitUPC                      | priceUnit    | caseUnit    | eta     |
      | 1   | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 150 | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case | [blank] |
    And BUYER quit browser

  @adminOrder_158a @adminOrder
  Scenario: Admin enter Fulfillment date for PO of express sub-invoice - ETA field pick the earliest receiving weekday
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx547@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 150 | 32864              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx547@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder150chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 150"
    And Admin create order success
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice by info
      | index | skuName          | type    |
      | 1     | AT SKU Order 150 | express |
    And Admin check Sub invoice
      | eta     | paymentStatus | total   | totalQuantity | totalWeight |
      | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    |
    And NGOC_ADMIN_05 quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+storder150chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Store 01 | currentDate   | [blank]        |
    And Go to order detail with order number ""
    And Buyer check items in order detail have multi sub invoice
      | sub | index | brandName         | productName      | skuName          | unitPerCase | casePrice | quantity | total   | addCart | unitUPC                      | priceUnit    | caseUnit    | eta     |
      | 1   | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 150 | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case | [blank] |
    And BUYER quit browser

  @adminOrder_158b @adminOrder
  Scenario: Admin enter Fulfillment date for PO of express sub-invoice - ETA field pick the any date
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx548@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder150chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 150"
    And Admin create order success
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice by info
      | index | skuName          | type    |
      | 1     | AT SKU Order 150 | express |
    And Admin check Sub invoice
      | eta     | paymentStatus | total   | totalQuantity | totalWeight |
      | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    |
    And Admin edit ETA of sub-invoice
      | index | skuName          | eta    |
      | 1     | AT SKU Order 150 | Minus1 |
    Then Admin verify ETA email not set
    And Admin edit ETA of sub-invoice
      | index | skuName          | eta         |
      | 1     | AT SKU Order 150 | currentDate |
    And NGOC_ADMIN_05 quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+storder150chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Store 01 | currentDate   | [blank]        |
    And Go to order detail with order number ""
    And Buyer check items in order detail have multi sub invoice
      | sub | index | brandName         | productName      | skuName          | unitPerCase | casePrice | quantity | total   | addCart | unitUPC                      | priceUnit    | caseUnit    | eta     |
      | 1   | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 150 | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case | [blank] |
    And BUYER quit browser

  @adminOrder_158c @adminOrder
  Scenario: Admin enter Fulfillment date for PO of express sub-invoice - ETA field pick the any date
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx549@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 158 | 32870              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx549@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder158chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 158"
    And Admin create order success
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | Minus1          | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice by info
      | index | skuName          | type    |
      | 1     | AT SKU Order 158 | express |
    And Admin check Sub invoice
      | eta     | paymentStatus | total   | totalQuantity | totalWeight |
      | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Awaiting POD      | Yes         |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment  |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder158chi01 | ngoctx stOrder158 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Awaiting POD |
    And NGOC_ADMIN_05 quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+storder158chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Store 01 | currentDate   | [blank]        |
    And Go to order detail with order number ""
    And Buyer check items in order detail have multi sub invoice
      | sub | index | brandName         | productName      | skuName          | unitPerCase | casePrice | quantity | total   | addCart | unitUPC                      | priceUnit    | caseUnit    |
      | 1   | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 158 | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case |
    And BUYER quit browser

  @adminOrder_159a @adminOrder
  Scenario: Admin not enter Fulfillment date for PO of express sub-invoice - ETA field pick the earliest receiving weekday
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx549@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 159 | 32871              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx550@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder159chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 159"
    And Admin create order success
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | [blank]          | currentDate     | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice by info
      | index | skuName          | type    |
      | 1     | AT SKU Order 159 | express |
    And Admin check Sub invoice
      | eta         | paymentStatus | total   | totalQuantity | totalWeight |
      | currentDate | Pending       | $100.00 | 1             | 1.00 lbs    |
    And NGOC_ADMIN_05 quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+storder159chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Store 01 | currentDate   | [blank]        |
    And Go to order detail with order number ""
    And Buyer check items in order detail have multi sub invoice
      | sub | index | brandName         | productName      | skuName          | unitPerCase | casePrice | quantity | total   | addCart | unitUPC                      | priceUnit    | caseUnit    |
      | 1   | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 159 | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case |
    And BUYER quit browser

  @adminOrder_160 @adminOrder
  Scenario: Check when admin create PO for Express sub-invoice
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx551@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 100 | 32212              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx551@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder106chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 100"
    And Admin create order success
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder106chi01 | ngoctx stOrder106 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    # Create purchase order
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice 1 of order "express"
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed | [blank]     | adminNote | lpNote |
    And Admin expand line item in order detail
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Pending           | Yes         |
     # Update purchase order unconfirmed to in progress
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | In progress      | [blank]         | [blank] | adminNote | lpNote |
    And Admin refresh page by button
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | In progress | [blank]     | adminNote | lpNote |
    And Admin expand line item in order detail
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Pending           | Yes         |
     # Update purchase order in progress to unconfirmed
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin refresh page by button
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed | [blank]     | adminNote | lpNote |
    And Admin expand line item in order detail
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Pending           | Yes         |
    # Update purchase order in progress to Awaiting POD
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | Minus1          | [blank] | adminNote | lpNote |
    And Admin refresh page by button
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | In progress | [blank]     | adminNote | lpNote |
    And Admin expand line item in order detail
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Awaiting POD      | Yes         |

       # Verify search Express progress
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber     | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess    | pendingFinancial |
      | create by admin | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | Awaiting POD | [blank]          |
    Then Admin verify result order in all order
      | order           | checkout    | buyer                  | store            | region | total   | vendorFee | buyerPayment | fulfillment  | vendorPayment |
      | create by admin | currentDate | ngoctx storder106chi01 | ngoctx stOrder1… | CHI    | $100.00 | $25.00    | Pending      | Awaiting POD | Pending       |
    When Admin go to order detail number "create by admin"

    # Update purchase order unconfirm to fulfill
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Fulfilled        | currentDate     | anhJPEG.jpg | adminNote | lpNote |
    And Admin refresh page by button
    And Admin verify Purchase order
      | logisticPartner     | status    | dateFulfill | adminNote | lpNote | proof       |
      | Auto Ngoc LP Mix 01 | Fulfilled | currentDate | adminNote | lpNote | anhJPEG.jpg |
    And Admin expand line item in order detail
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Fulfilled         | No          |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_161 @adminOrder
  Scenario: Check when admin create PO for Express sub-invoice (Fulfilled)
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx552@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 100 | 32212              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx552@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder106chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 100"
    And Admin create order success
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder106chi01 | ngoctx stOrder106 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    # Create purchase order
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Fulfilled        | currentDate     | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice 1 of order "express"
    And Admin refresh page by button
    And Admin verify Purchase order
      | logisticPartner     | status    | dateFulfill | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Fulfilled | currentDate | adminNote | lpNote |
    And Admin expand line item in order detail
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Fulfilled         | No          |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_161a @adminOrder
  Scenario: Check when admin remove PO for Express sub-invoice (Unconfirmed)
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx553@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 100 | 32212              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx553@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder106chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 100"
    And Admin create order success
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder106chi01 | ngoctx stOrder106 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    # Create purchase order
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice 1 of order "express"
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed | [blank]     | adminNote | lpNote |
    And Admin expand line item in order detail
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Pending           | Yes         |
    And Admin remove purchase order of order "create by api" of sub "1" with info
    And NGOC_ADMIN_05 quit browser

  @adminOrder_162 @adminOrder
  Scenario: Vefiry upload csv
    Given NGOC_ADMIN_05 open web admin
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx553@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Upload14 | 30655              | 20       | random   | 90           | currentDate  | [blank]     | [blank] |

    When login to beta web with email "ngoctx554@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder106chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    # Verify upload CSV success
    And Admin upload file order "adminCreateNewOrder.csv"
    Then Admin verify info after upload file CSV
      | nameSKU         | info  | warning | danger | uploadedPrice | estimatedPrice | quantity | promoPrice |
      | AT SKU Upload14 | empty | empty   | empty  | $15.00        | $1,400.00      | 14       | empty      |
    And Admin verify price in create order upload file
      | type      | totalCase | totalOrderValue | discount | taxes   | logisticsSurcharge | specialDiscount | totalPayment |
      | Total     | 14        | $1,400.00       | [blank]  | [blank] | [blank]            | [blank]         | [blank]      |
      | In stock  | 14        | $1,400.00       | [blank]  | [blank] | [blank]            | [blank]         | [blank]      |
      | OOS or LS | 0         | $0.00           | [blank]  | [blank] | [blank]            | [blank]         | [blank]      |
    And Admin upload file CSV success
    Then Admin verify line item added
      | title          | brand           | product           | sku             | tag   | upc          | unit         |
      | Items with MOQ | AT BRAND UPLOAD | AT Product Upload | AT SKU Upload14 | 30655 | 180219931214 | 1 units/case |
    And Admin create order success
    And NGOC_ADMIN_05 quit browser

  @adminOrder_163 @adminOrder
  Scenario: Buyer/Admin delete order with has 1 PO only with a POD attached (the PO is not marked as fulfilled yet)
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx511@podfoods.co | 12345678a |

   # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Upload14 | 30655              | 20       | random   | 90           | currentDate  | [blank]     | [blank] |

   # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 82307              | 30655              | 8        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3250     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
    # Create purchase order
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | in_progress       | adminNote  | lpNote                 | [blank]                        | 99                   |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx511@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin export order list
    And Admin check content file export "order list"
      | customerPO | date    | store            | shippingAddress                                 | receivingDate | earlestReceivingTime | latestReceivingTime | buyer                 | paymentMethod   | region              | brandID | brand           | product           | sku             | priceCase | unitCase | taxes   | quantity | promotion | itemValue | itemPrice | fulfillmentDate | deliveryMethod  | deliveryDetail                                     | sub     |
      | [blank]    | [blank] | ngoctx stOrder43 | 1544 West 18th Street, Chicago, Illinois, 60608 | [blank]       | [blank]              | [blank]             | ngoctx stOrder43chi01 | Pay via invoice | Chicagoland Express | 2919    | AT Brand Upload | AT Product Upload | AT SKU Upload14 | 100       | 1        | [blank] | 8        | $0.00     | [blank]   | [blank]   | [blank]         | Pod Consignment | pod_consignment, Pod Consignment auto-confirmation | [blank] |
    And Admin go to order detail number "create by api"
    And Admin export order detail
    And Admin check content file export "order detail"
      | customerPO | date    | store            | shippingAddress                                 | receivingDate | earlestReceivingTime | latestReceivingTime | buyer                 | paymentMethod   | region              | brandID | brand           | product           | sku             | priceCase | unitCase | taxes   | quantity | promotion | itemValue | itemPrice | fulfillmentDate | deliveryMethod  | deliveryDetail                                     | sub |
      | [blank]    | [blank] | ngoctx stOrder43 | 1544 West 18th Street, Chicago, Illinois, 60608 | [blank]       | [blank]              | [blank]             | ngoctx stOrder43chi01 | Pay via invoice | Chicagoland Express | 2919    | AT Brand Upload | AT Product Upload | AT SKU Upload14 | 100       | 1        | [blank] | 8        | $0.00     | [blank]   | [blank]   | [blank]         | Pod Consignment | pod_consignment, Pod Consignment auto-confirmation | 1   |

    And Admin delete order from order detail
      | reason           | note     | showEdit | passkey      |
      | Buyer adjustment | Autotest | Yes      | pizza4cheese |
    And NGOC_ADMIN_05 quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store            | fulFilledDate | order         | po      |
      | Ordered, Latest first | Unconfirmed  | ngoctx stOrder43 | [blank]       | create by api | [blank] |
    And LP don't found order record on order page
      | number        |
      | create by api |

  @adminOrder_164 @adminOrder
  Scenario: Check when admin Order has more than 1 sub-invoice - All Express sub-invoice is Awaiting POD
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx555@podfoods.co | 12345678a |

    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 100 | 32212              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 85726              | 32212              | 1        | false     | [blank]          |
      | 132628             | 64602              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3250     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
      # Create purchase order
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | Minus1           | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx555@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess    | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | Awaiting POD | [blank]          |
    When Admin go to order detail number "create by api"
    Then Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment  |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Awaiting POD |
    And Admin verify history fulfillment status changelog in order detail
      | state                | updatedBy        | updatedOn   |
      | Pending→Awaiting pod | Admin: ngoctx555 | currentDate |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | In progress | [blank]     | adminNote | lpNote |
    And Admin expand line item in order detail
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $300.00 | 2             | 2.00 lbs    | Awaiting POD      | Yes         |
    When Admin fulfill all line items created by buyer
      | index | skuName          | fulfillDate |
      | 1     | AT SKU Order 100 | currentDate |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $300.00 | 2             | 2.00 lbs    | Awaiting POD      | Yes         |
    When Admin fulfill all line items created by buyer
      | index | skuName           | fulfillDate |
      | 1     | AT SKU Order 147a | currentDate |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $300.00 | 2             | 2.00 lbs    | Fulfilled         | No          |
    And Admin verify history fulfillment status changelog in order detail
      | state                  | updatedBy        | updatedOn   |
      | Awaiting pod→Fulfilled | Admin: ngoctx555 | currentDate |
      | Pending→Awaiting pod   | Admin: ngoctx555 | currentDate |
    And Admin unfulfill all line items created by buyer
      | index | skuName           |
      | 1     | AT SKU Order 100  |
      | 1     | AT SKU Order 147a |
    And Admin verify history fulfillment status changelog in order detail
      | state                  | updatedBy        | updatedOn   |
      | Fulfilled→Awaiting pod | Admin: ngoctx555 | currentDate |
      | Awaiting pod→Fulfilled | Admin: ngoctx555 | currentDate |
      | Pending→Awaiting pod   | Admin: ngoctx555 | currentDate |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order         | po      |
      | Ordered, Latest first | [blank]      | [blank] | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |
    And USER_LP quit browser

    And Switch to actor NGOC_ADMIN_05
    And Admin refresh page by button
    And Admin verify history fulfillment status changelog in order detail
      | state                  | updatedBy                    | updatedOn   |
      | Awaiting pod→Fulfilled | LogisticsPartner: ngoctx lp1 | currentDate |
      | Fulfilled→Awaiting pod | Admin: ngoctx555             | currentDate |
      | Awaiting pod→Fulfilled | Admin: ngoctx555             | currentDate |
      | Pending→Awaiting pod   | Admin: ngoctx555             | currentDate |

    And NGOC_ADMIN_05 quit browser

  @adminOrder_152 @adminOrder
  Scenario: Check display of Fulfillment status field of an Direct Sub-invoice
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx541@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder150chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 150c"
    And Admin create order success
    And Admin create "create" sub-invoice with Suffix ="1"
      | skuName           |
      | AT SKU Order 150c |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | Chicagoland Express | ngoctx storder150chi01 | ngoctx stOrder150 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin fulfill by mark as fulfilled in order detail
      | sub |
      | 1   |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | Chicagoland Express | ngoctx storder150chi01 | ngoctx stOrder150 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Fulfilled   |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_165 @adminOrder
  Scenario: Check Shorted item: Line item is OOS/CS Items > Change availability to In stock, Order without express sub-invoice
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx549@podfoods.co | 12345678a |
    # Create sku
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | sold_out     | 1000      | 1200 |
    And Admin create a "active" SKU from admin with name "sku165 random" of product "32149"

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3250     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx549@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand Store 02 | AT Product Order 02 | random | 1 units/case | $10.00    | 1        | 9           | $10.00 |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | Not applied         | $0.00              | $2.50            | $10.00 |
    Then Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse            |
      | 1     | random | Pod Consignment | Auto Ngoc Distribution CHI |

     # Create purchase order
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    When Admin fulfill all line items
      | index | skuName | fulfillDate |
      | 1     | random  | currentDate |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Fulfilled   |
    And Admin unfulfill all line items created by buyer
      | index | skuName |
      | 1     | random  |
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | Minus1          | [blank] | adminNote | lpNote |
    And NGOC_ADMIN_05 wait 5000 mini seconds
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total  | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $10.00 | 1             | 1.00 lbs    | Awaiting POD      | Yes         |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment  |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Awaiting POD |
    When Admin fulfill all line items
      | index | skuName | fulfillDate |
      | 1     | random  | currentDate |
    And Admin get ID of sub-invoice of order "express"

      # Paid order
    And NGOC_ADMIN_05 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region  | managedBy |
      | [blank]      | ngoctx stOrder43 | ngoctx stOrder43chi01 | [blank]        | [blank] | [blank]   |
    And Admin go to detail of store statement "ngoctx stOrder43"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total  |
      | random  | currentDate | currentDate  | ngoctx stOrder43chi01 | Unpaid | 0     | [blank]     | $10.00     | [blank]  | $0.00   | $0.00 | [blank] | [blank] | $10.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total  |
      | random  | currentDate | currentDate  | ngoctx stOrder43chi01 | Unpaid | 0     | [blank]     | $10.00     | [blank]  | $0.00   | $0.00 | [blank] | [blank] | $10.00 |
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 10            | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand Store 02 | AT Product Order 02 | random | 1 units/case | $10.00    | 1        | 9           | $10.00 |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Paid         | Payment via invoice | Pending       | Fulfilled   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | Not applied         | Not applied        | $2.50            | $10.00 |
    Then Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse            |
      | 1     | random | Pod Consignment | Auto Ngoc Distribution CHI |

    And NGOC_ADMIN_05 quit browser

  @adminOrder_167 @adminOrder
  Scenario: Check Shorted item: Line item is OOS/CS Items > Change availability to In stock, Order with direct item
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx549@podfoods.co | 12345678a |
    # Create sku
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | sold_out     | 1000      | 1200 |
    And Admin create a "active" SKU from admin with name "sku167 random" of product "32149"

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3250     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx549@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "deleted or shorted items" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand Store 02 | AT Product Order 02 | random | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total |
      | $0.00      | $0.00    | $0.00 | Not applied         | $0.00              | $0.00            | $0.00 |

    # active region của sku
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx549@podfoods.co | 12345678a |
    And Admin change info of regions attributes of sku "sku167 random" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 58        | [blank]            | 1000             | 1000       | in_stock     | active |

    And Switch to actor NGOC_ADMIN_05
    And Admin refresh page by button
    And Admin check line items "non invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand Store 02 | AT Product Order 02 | random | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | Not applied         | $0.00              | $0.50            | $10.00 |

    And Admin create "create" sub-invoice with Suffix ="1"
      | skuName |
      | random  |
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | directItemDelivery     |
      | AT Brand Store 02 | AT Product Order 02 | random | 1 units/case | $10.00    | 1        | [blank]     | $10.00 | Please set deliverable |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | Not applied         | $0.00              | $0.50            | $10.00 |

#      Create purchase order
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    When Admin fulfill all line items
      | index | skuName | fulfillDate |
      | 1     | random  | currentDate |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Fulfilled   |
    And Admin unfulfill all line items created by buyer
      | index | skuName |
      | 1     | random  |
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | Minus1          | [blank] | adminNote | lpNote |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total  | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $10.00 | 1             | 1.00 lbs    | Awaiting POD      | Yes         |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment  |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Awaiting POD |
    When Admin fulfill all line items
      | index | skuName | fulfillDate |
      | 1     | random  | currentDate |
    And Admin get ID of sub-invoice of order "direct"

      # Paid order
    And NGOC_ADMIN_05 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region  | managedBy |
      | [blank]      | ngoctx stOrder43 | ngoctx stOrder43chi01 | [blank]        | [blank] | [blank]   |
    And Admin go to detail of store statement "ngoctx stOrder43"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total  |
      | random  | currentDate | currentDate  | ngoctx stOrder43chi01 | Unpaid | 0     | [blank]     | $10.00     | [blank]  | $0.00   | $0.00 | [blank] | [blank] | $10.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total  |
      | random  | currentDate | currentDate  | ngoctx stOrder43chi01 | Unpaid | 0     | [blank]     | $10.00     | [blank]  | $0.00   | $0.00 | [blank] | [blank] | $10.00 |
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 10            | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | directItemDelivery     |
      | AT Brand Store 02 | AT Product Order 02 | random | 1 units/case | $10.00    | 1        | [blank]     | $10.00 | Please set deliverable |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                 | store            | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder43chi01 | ngoctx stOrder43 | [blank]     | [blank]   | Paid         | Payment via invoice | Pending       | Fulfilled   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | Not applied         | Not applied        | $0.50            | $10.00 |
    And NGOC_ADMIN_05 quit browser

  @adminOrder_166 @adminOrder
  Scenario: Split-Merge sub-invoice - sub-invoice has 2 line-items SKU A pending, SKU B fulfilled
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx526@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 134 | 32740              | 1        | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 134b | 32741              | 1        | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx526@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder134chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 134"
    And Admin add line item is "AT SKU Order 134b"
    And Admin create order success
    # Create purchase order
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    When Admin fulfill all line items
      | index | skuName           | fulfillDate |
      | 1     | AT SKU Order 134b | currentDate |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder134chi01 | ngoctx stOrder134 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | In progress |
    And Admin create "create" sub-invoice with Suffix =""
      | skuName           |
      | AT SKU Order 134b |
    And Admin check line items "sub invoice" in order details
      | brand             | product          | sku               | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134  | 1 units/case | $100.00   | 1        | [blank]     | $100.00 |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | 1 units/case | $100.00   | 1        | [blank]     | $100.00 |
    And Admin get ID of sub-invoice by info
      | index | skuName           | type    |
      | 1     | AT SKU Order 134  | express |
      | 1     | AT SKU Order 134b | express |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Pending           | Yes         |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 2   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Fulfilled         | No          |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder134chi01 | ngoctx stOrder134 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | In progress |

     # Verify order summary
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store             | buyer                  | city    | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | CHI    | currentDate | ngoctx stOrder134 | ngoctx storder134chi01 | Chicago | Illinois     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice by subinvoice "create by api" in Order summary
      | index | po  | totalDelivery | totalPayment | totalService | totalWeight | eta | fulfillmentStatus |
      | 1     | Yes | $0.00         | $130.00      | $25.00       | 1.00 lbs    | -   | Pending           |
      | 2     | No  | $0.00         | $100.00      | $25.00       | 1.00 lbs    | -   | Fulfilled         |
    And Admin check invoice detail of order "create by api" in Order summary
      | sub | brand             | product          | sku               | tmp | delivery  | quantity | endQuantity | warehouse                  | fulfillment |
      | 1   | AT Brand Store 01 | AT Product Order | AT SKU Order 134  | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |
      | 2   | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |

    Given BUYER open web user
    When login to beta web with email "ngoctx+storder134chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Store 01 | currentDate   | Plus1          |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName              | storeName         | shippingAddress                                 | orderValue | total   | payment    | status  |
      | ngoctx storder134chi01 | ngoctx stOrder134 | 1544 West 18th Street, Chicago, Illinois, 60608 | $200.00    | $230.00 | By invoice | Pending |
    And Buyer check items in order detail have multi sub invoice
      | sub | index | brandName         | productName      | skuName           | unitPerCase | casePrice | quantity | total   | addCart | unitUPC                      | priceUnit    | caseUnit    | fulfillmentStatus |
      | 1   | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 134  | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case | Pending           |
      | 1   | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case | Fulfilled         |
    And Buyer check sub-invoice of order ""
      | sub | payment | total   | fulfillmentStatus |
      | 1   | Pending | $100.00 | Pending           |
      | 2   | Pending | $100.00 | Fulfilled         |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v101@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store             | paymentStatus | orderType | checkoutDate |
      | [blank] | ngoctx stOrder134 | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor Check items in order detail
      | brandName         | productName      | skuName          | casePrice | quantity | total   | podConsignment  |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | POD CONSIGNMENT |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | POD CONSIGNMENT |
    And Vendor check order detail info
      | region              | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Chicagoland Express | currentDate | In Progress       | currentDate     |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName         | productName      | skuName          | casePrice | quantity | total   | podConsignment  | unitUPC                      |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | POD CONSIGNMENT | Unit UPC / EAN: 123123123012 |
    And Vendor Check items in sub invoice "create by api" number "2" with status is "Fulfilled"
      | brandName         | productName      | skuName           | casePrice | quantity | total   | podConsignment  | unitUPC                      |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | $100.00   | 1        | $100.00 | POD CONSIGNMENT | Unit UPC / EAN: 123123123012 |

    And Switch to actor NGOC_ADMIN_05
    And Admin go back by browser
    And Admin create "add to" sub-invoice with Suffix ="1"
      | skuName           |
      | AT SKU Order 134b |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder134chi01 | ngoctx stOrder134 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | In progress |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $200.00 | 2             | 2.00 lbs    | Pending           | Yes         |
    And Admin get ID of sub-invoice by info
      | index | skuName           | type    |
      | 1     | AT SKU Order 134  | express |
      | 1     | AT SKU Order 134b | express |
      # Verify order summary
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store             | buyer                  | city    | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | CHI    | currentDate | ngoctx stOrder134 | ngoctx storder134chi01 | Chicago | Illinois     | UNASSIGNED | Pending | [blank]    | currentDate     | day(s)       | Payment via invoice |
    And Admin check express invoice by subinvoice "create by api" in Order summary
      | index | po  | totalDelivery | totalPayment | totalService | totalWeight | eta | fulfillmentStatus |
      | 1     | Yes | $0.00         | $230.00      | $50.00       | 2.00 lbs    | -   | Pending           |
    And Admin check invoice detail of order "create by api" in Order summary
      | sub | brand             | product          | sku               | tmp | delivery  | quantity | endQuantity | warehouse                  | fulfillment |
      | 1   | AT Brand Store 01 | AT Product Order | AT SKU Order 134  | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |
      | 1   | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |

    And Switch to actor BUYER
    And BUYER refresh browser
    And Check information in order detail
      | buyerName              | storeName         | shippingAddress                                 | orderValue | total   | payment    | status  |
      | ngoctx storder134chi01 | ngoctx stOrder134 | 1544 West 18th Street, Chicago, Illinois, 60608 | $200.00    | $230.00 | By invoice | Pending |
    And Buyer check items in order detail have multi sub invoice
      | sub | index | brandName         | productName      | skuName           | unitPerCase | casePrice | quantity | total   | addCart | unitUPC                      | priceUnit    | caseUnit    | fulfillmentStatus |
      | 1   | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 134  | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case | Pending           |
      | 1   | 2     | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case | Fulfilled         |
    And Buyer check sub-invoice of order ""
      | sub | payment | total   | fulfillmentStatus |
      | 1   | Pending | $200.00 | Pending           |

    And Switch to actor VENDOR
    And VENDOR refresh browser
    And Vendor check order detail info
      | region              | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Chicagoland Express | currentDate | In Progress       | currentDate     |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName         | productName      | skuName          | casePrice | quantity | total   | podConsignment  | unitUPC                      |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | POD CONSIGNMENT | Unit UPC / EAN: 123123123012 |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | POD CONSIGNMENT | Unit UPC / EAN: 123123123012 |

    And Switch to actor NGOC_ADMIN_05
    And Admin go back by browser
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | [blank]          | Minus1          | [blank] | adminNote | lpNote |
    When Admin fulfill all line items
      | index | skuName           | fulfillDate |
      | 1     | AT SKU Order 134b | currentDate |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName           |
      | AT SKU Order 134b |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder134chi01 | ngoctx stOrder134 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | In progress |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Awaiting POD      | Yes         |
      | 2   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Fulfilled         | No          |
    And Admin get ID of sub-invoice by info
      | index | skuName           | type    |
      | 1     | AT SKU Order 134  | express |
      | 1     | AT SKU Order 134b | express |
    And Admin verify display surcharges button of order "create by api" with sub "2" error with message "Validation failed: Display surcharge There is more than one surcharge sub invoice in the order"

    # Verify order summary
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store             | buyer                  | city    | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | CHI    | currentDate | ngoctx stOrder134 | ngoctx storder134chi01 | Chicago | Illinois     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice by subinvoice "create by api" in Order summary
      | index | po  | totalDelivery | totalPayment | totalService | totalWeight | eta    | fulfillmentStatus |
      | 1     | Yes | $0.00         | $130.00      | $25.00       | 1.00 lbs    | Minus1 | Awaiting POD      |
      | 2     | No  | $0.00         | $100.00      | $25.00       | 1.00 lbs    | -      | Fulfilled         |
    And Admin check invoice detail of order "create by api" in Order summary
      | sub | brand             | product          | sku               | tmp | delivery  | quantity | endQuantity | warehouse                  | fulfillment |
      | 1   | AT Brand Store 01 | AT Product Order | AT SKU Order 134  | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |
      | 2   | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |

    And Switch to actor BUYER
    And BUYER refresh browser
    And Check information in order detail
      | buyerName              | storeName         | shippingAddress                                 | orderValue | total   | payment    | status  |
      | ngoctx storder134chi01 | ngoctx stOrder134 | 1544 West 18th Street, Chicago, Illinois, 60608 | $200.00    | $230.00 | By invoice | Pending |
    And Buyer check items in order detail have multi sub invoice
      | sub | index | brandName         | productName      | skuName           | unitPerCase | casePrice | quantity | total   | addCart | unitUPC                      | priceUnit    | caseUnit    | fulfillmentStatus |
      | 1   | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 134  | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case | Awaiting POD      |
      | 1   | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case | Fulfilled         |
    And Buyer check sub-invoice of order ""
      | sub | payment | total   | fulfillmentStatus |
      | 1   | Pending | $100.00 | Awaiting POD      |
      | 2   | Pending | $100.00 | Fulfilled         |

    And Switch to actor VENDOR
    And VENDOR refresh browser
    And Vendor Check items in order detail
      | brandName         | productName      | skuName          | casePrice | quantity | total   | podConsignment  |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | POD CONSIGNMENT |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | POD CONSIGNMENT |
    And Vendor check order detail info
      | region              | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Chicagoland Express | currentDate | In Progress       | currentDate     |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Awaiting POD"
      | brandName         | productName      | skuName          | casePrice | quantity | total   | podConsignment  | unitUPC                      |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | POD CONSIGNMENT | Unit UPC / EAN: 123123123012 |
    And Vendor Check items in sub invoice "create by api" number "2" with status is "Fulfilled"
      | brandName         | productName      | skuName           | casePrice | quantity | total   | podConsignment  | unitUPC                      |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | $100.00   | 1        | $100.00 | POD CONSIGNMENT | Unit UPC / EAN: 123123123012 |

    And Switch to actor NGOC_ADMIN_05
    And Admin go back by browser
    And Admin create "add to" sub-invoice with Suffix ="1"
      | skuName           |
      | AT SKU Order 134b |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment  |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder134chi01 | ngoctx stOrder134 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Awaiting POD |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $200.00 | 2             | 2.00 lbs    | Awaiting POD      | Yes         |
    And Admin get ID of sub-invoice by info
      | index | skuName           | type    |
      | 1     | AT SKU Order 134  | express |
      | 1     | AT SKU Order 134b | express |
      # Verify order summary
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store             | buyer                  | city    | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | CHI    | currentDate | ngoctx stOrder134 | ngoctx storder134chi01 | Chicago | Illinois     | UNASSIGNED | Pending | [blank]    | currentDate     | day(s)       | Payment via invoice |
    And Admin check express invoice by subinvoice "create by api" in Order summary
      | index | po  | totalDelivery | totalPayment | totalService | totalWeight | eta    | fulfillmentStatus |
      | 1     | Yes | $0.00         | $230.00      | $50.00       | 2.00 lbs    | Minus1 | Awaiting POD      |
    And Admin check invoice detail of order "create by api" in Order summary
      | sub | brand             | product          | sku               | tmp | delivery  | quantity | endQuantity | warehouse                  | fulfillment |
      | 1   | AT Brand Store 01 | AT Product Order | AT SKU Order 134  | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |
      | 1   | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | Dry | Confirmed | 1        | [blank]     | Auto Ngoc Distribution CHI | [blank]     |

    And Switch to actor BUYER
    And BUYER refresh browser
    And Check information in order detail
      | buyerName              | storeName         | shippingAddress                                 | orderValue | total   | payment    | status  |
      | ngoctx storder134chi01 | ngoctx stOrder134 | 1544 West 18th Street, Chicago, Illinois, 60608 | $200.00    | $230.00 | By invoice | Pending |
    And Buyer check items in order detail have multi sub invoice
      | sub | index | brandName         | productName      | skuName           | unitPerCase | casePrice | quantity | total   | addCart | unitUPC                      | priceUnit    | caseUnit    | fulfillmentStatus |
      | 1   | 1     | AT Brand Store 01 | AT Product Order | AT SKU Order 134  | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case | In progress       |
      | 1   | 2     | AT Brand Store 01 | AT Product Order | AT SKU Order 134b | 1 unit/case | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123123123012 | $100.00/unit | 1 unit/case | Fulfilled         |
    And Buyer check sub-invoice of order ""
      | sub | payment | total   | fulfillmentStatus |
      | 1   | Pending | $200.00 | Awaiting POD      |

    And Switch to actor VENDOR
    And VENDOR refresh browser
    And Vendor check order detail info
      | region              | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Chicagoland Express | currentDate | Awaiting POD      | currentDate     |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Awaiting POD"
      | brandName         | productName      | skuName          | casePrice | quantity | total   | podConsignment  | unitUPC                      |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | POD CONSIGNMENT | Unit UPC / EAN: 123123123012 |
      | AT Brand Store 01 | AT Product Order | AT SKU Order 134 | $100.00   | 1        | $100.00 | POD CONSIGNMENT | Unit UPC / EAN: 123123123012 |
    And BUYER quit browser
    And NGOC_ADMIN_05 quit browser
    And VENDOR quit browser

  @adminOrder_168 @adminOrder
  Scenario: Check handling unconfirmed Express line-items once we receive additional inventory by processing an inbound inventory
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx549@podfoods.co | 12345678a |
    # Delete promotion
    And Admin search promotion by Promotion Name "AT Promo Order 168"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Sponsor Order 168"
    And Admin delete promotion by skuName ""
    # Create sku
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | sold_out     | 1000      | 1200 |
    And Admin create a "active" SKU from admin with name "sku168 random" of product "32407"

     # Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 3685      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Order 168 | AT Promo Order 168 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |

      # Create pod-sponsor promotion
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 3685      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                       | description                | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | AT Promo Sponsor Order 168 | AT Promo Sponsor Order 168 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3887     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

      # Create inbound by index
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1787              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1787              | 10            | 10                          | 1                        | 1     | 1          | 90           |
    And Admin save inbound number by index "1"
    And Admin clear list sku inbound by API
    # Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku    | lot_code | quantity | expiry_date |
      | random | random   | 10       | currentDate |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail   | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 10            | 10                          | 10                   | 10                              | submitted | 10           | 11111    | admin_note | 81           | other Shipping | freight Carrier | tracking_number | 123              | auto                       | 0123456789                  |
    # Processed inbound
    And Admin Process Incoming Inventory id "api" api

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx549@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $10.00    | 1        | 9           | $9.00 | $10.00   |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder168chi01 | ngoctx stOrder168 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $10.00     | $1.00    | $10.00 | Not applied         | $0.00              | $2.50            | $18.10 | $0.90           |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total  | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $18.10 | 1             | 1.00 lbs    | Pending           | Yes         |
    Then Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse      |
      | 1     | random | Pod Consignment | Bao Distribution CHI |

     # Create purchase order
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    When Admin fulfill all line items
      | index | skuName | fulfillDate |
      | 1     | random  | currentDate |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder168chi01 | ngoctx stOrder168 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Fulfilled   |
    And Admin unfulfill all line items created by buyer
      | index | skuName |
      | 1     | random  |
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | Minus1          | [blank] | adminNote | lpNote |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total  | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $18.10 | 1             | 1.00 lbs    | Awaiting POD      | Yes         |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment  |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder168chi01 | ngoctx stOrder168 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Awaiting POD |
    When Admin fulfill all line items
      | index | skuName | fulfillDate |
      | 1     | random  | currentDate |
    And Admin get ID of sub-invoice of order "express"

      # Paid order
    And NGOC_ADMIN_05 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store             | buyer                  | statementMonth | region  | managedBy |
      | [blank]      | ngoctx stOrder168 | ngoctx stOrder168chi01 | [blank]        | [blank] | [blank]   |
    And Admin go to detail of store statement "ngoctx stOrder168"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                  | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total  |
      | random  | currentDate | currentDate  | ngoctx stOrder168chi01 | Unpaid | 0     | [blank]     | $10.00     | ($1.90)  | $10.00  | $0.00 | [blank] | [blank] | $18.10 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                  | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total  |
      | random  | currentDate | currentDate  | ngoctx stOrder168chi01 | Unpaid | 0     | [blank]     | $10.00     | ($1.90)  | $10.00  | $0.00 | [blank] | [blank] | $18.10 |
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 18.1          | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $10.00    | 1        | 9           | $9.00 | $10.00   |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrder168chi01 | ngoctx stOrder168 | [blank]     | [blank]   | Paid         | Payment via invoice | Pending       | Fulfilled   |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $10.00     | $1.00    | $10.00 | Not applied         | Not applied        | $2.50            | $18.10 | $0.90           |
    Then Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse      |
      | 1     | random | Pod Consignment | Bao Distribution CHI |

    And NGOC_ADMIN_05 quit browser

  @adminOrder_169 @adminOrder
  Scenario: Check handling unconfirmed Express line-items once we receive additional inventory by processing an inbound inventory - pending financial
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx549@podfoods.co | 12345678a |

      # Delete promotion
    And Admin search promotion by Promotion Name "AT Promo Order 169"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Sponsor Order 169"
    And Admin delete promotion by skuName ""

    # Create sku
    And Info of Region
      | region           | id | state  | availability | casePrice | msrp  |
      | New York Express | 53 | active | sold_out     | 20000     | 20000 |
    And Admin create a "active" SKU from admin with name "sku169 random" of product "32407"

    # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | random | 3192      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Order 169 | AT Promo Order 169 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |

      # Create pod-sponsor promotion
    And Admin add region by API
      | region           | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | New York Express | 53        | [blank] | 3192      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                       | description                | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | AT Promo Sponsor Order 169 | AT Promo Sponsor Order 169 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api53    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1        | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3498     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 9th Avenue | New York | 33               | 60608 | true          | [blank]    | [blank]            | [blank]            |

      # Create inbound by index
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1787              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 53        | 1787              | 10            | 10                          | 1                        | 1     | 1          | 91           |
    And Admin save inbound number by index "1"
    And Admin clear list sku inbound by API
    # Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku    | lot_code | quantity | expiry_date |
      | random | random   | 10       | currentDate |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail   | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 10            | 10                          | 10                   | 10                              | submitted | 10           | 11111    | admin_note | 91           | other Shipping | freight Carrier | tracking_number | 123              | auto                       | 0123456789                  |
    # Processed inbound
    And Admin Process Incoming Inventory id "api" api

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx549@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    When Admin approve to fulfill this order
    And NGOC_ADMIN_05 refresh browser
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                      | store                           | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | financeApproval | financeApproveBy | financeApproveAt |
      | Empty      | currentDate | New York Express | ngoctx financialpendingb01 | ngoctx str financial pending 01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     | Approved        | Admin: ngoctx549 | currentDate      |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   | specialDiscount |
      | $200.00    | $20.00   | $10.00 | Not applied         | $0.00              | $50.00           | $172.00 | $18.00          |
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total   | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $200.00   | 1        | 9           | $180.00 | $200.00  |
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                      | store                           | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | New York Express | ngoctx financialpendingb01 | ngoctx str financial pending 01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    Then Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse         |
      | 1     | random | Pod Consignment | Auto Distribute NewYork |

     # Create purchase order
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    When Admin fulfill all line items
      | index | skuName | fulfillDate |
      | 1     | random  | currentDate |
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                      | store                           | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | New York Express | ngoctx financialpendingb01 | ngoctx str financial pending 01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Fulfilled   |
    And Admin unfulfill all line items created by buyer
      | index | skuName |
      | 1     | random  |
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | Minus1          | [blank] | adminNote | lpNote |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $172.00 | 1             | 1.00 lbs    | Awaiting POD      | Yes         |
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                      | store                           | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment  |
      | Empty      | currentDate | New York Express | ngoctx financialpendingb01 | ngoctx str financial pending 01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Awaiting POD |
    When Admin fulfill all line items
      | index | skuName | fulfillDate |
      | 1     | random  | currentDate |
    And Admin get ID of sub-invoice of order "express"

      # Paid order
    And NGOC_ADMIN_05 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store                           | buyer                      | statementMonth | region  | managedBy |
      | [blank]      | ngoctx str financial pending 01 | ngoctx financialpendingb01 | [blank]        | [blank] | [blank]   |
    And Admin go to detail of store statement "ngoctx str financial pending 01"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                      | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx financialpendingb01 | Unpaid | 0     | [blank]     | $200.00    | ($38.00) | $10.00  | $0.00 | [blank] | [blank] | $172.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                      | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx financialpendingb01 | Unpaid | 0     | [blank]     | $200.00    | ($38.00) | $10.00  | $0.00 | [blank] | [blank] | $172.00 |
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 172           | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total   | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $200.00   | 1        | 9           | $180.00 | $200.00  |
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                      | store                           | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | New York Express | ngoctx financialpendingb01 | ngoctx str financial pending 01 | [blank]     | [blank]   | Paid         | Payment via invoice | Pending       | Fulfilled   |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   | specialDiscount |
      | $200.00    | $20.00   | $10.00 | Not applied         | Not applied        | $50.00           | $172.00 | $18.00          |
    Then Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse         |
      | 1     | random | Pod Consignment | Auto Distribute NewYork |

    And NGOC_ADMIN_05 quit browser

  @adminOrder_170 @adminOrder
  Scenario: Check handling unconfirmed Express line-items once we receive additional inventory by add new addition item on Admin
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx550@podfoods.co | 12345678a |

     # Delete promotion
    And Admin search promotion by Promotion Name "AT Promo Order 170"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Sponsor Order 170"
    And Admin delete promotion by skuName ""

    # Create sku
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | sold_out     | 20000     | 20000 |
    And Admin create a "active" SKU from admin with name "sku170 random" of product "32407"

    # Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 3686      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Order 170 | AT Promo Order 170 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |

      # Create pod-sponsor promotion
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 3686      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                       | description                | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | AT Promo Sponsor Order 170 | AT Promo Sponsor Order 170 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1        | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3888     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 9th Avenue | New York | 33               | 60608 | true          | [blank]    | [blank]            | [blank]            |

       # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 1        | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1        | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3888     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 9th Avenue | New York | 33               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx549@podfoods.co" pass "12345678a" role "Admin"
    # Additional to inventory
    And NGOC_ADMIN_05 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random  | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin see detail inventory with lotcode
      | index | skuName | lotCode |
      | 1     | random  | random  |
    And Admin create addition items
      | quantity | category           | comment  |
      | 10       | Inbound correction | Autotest |

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder170chi01 | ngoctx stOrder170 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   | specialDiscount |
      | $200.00    | $20.00   | $10.00 | Not applied         | $0.00              | $50.00           | $172.00 | $18.00          |
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total   | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $200.00   | 1        | 9           | $180.00 | $200.00  |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder170chi01 | ngoctx stOrder170 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   | specialDiscount |
      | $200.00    | $20.00   | $10.00 | Not applied         | $0.00              | $50.00           | $172.00 | $18.00          |
    Then Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse            |
      | 1     | random | Pod Consignment | Auto Ngoc Distribution CHI |

     # Create purchase order
    And NGOC_ADMIN_05 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    When Admin fulfill all line items
      | index | skuName | fulfillDate |
      | 1     | random  | currentDate |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder170chi01 | ngoctx stOrder170 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Fulfilled   |
    And Admin unfulfill all line items created by buyer
      | index | skuName |
      | 1     | random  |
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | Minus1          | [blank] | adminNote | lpNote |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total  | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | 172.00 | 1             | 1.00 lbs    | Awaiting POD      | Yes         |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment  |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder170chi01 | ngoctx stOrder170 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Awaiting POD |
    When Admin fulfill all line items
      | index | skuName | fulfillDate |
      | 1     | random  | currentDate |
    And Admin get ID of sub-invoice of order "express"

      # Paid order
    And NGOC_ADMIN_05 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store             | buyer                  | statementMonth | region  | managedBy |
      | [blank]      | ngoctx stOrder170 | ngoctx storder170chi01 | [blank]        | [blank] | [blank]   |
    And Admin go to detail of store statement "ngoctx stOrder170"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                  | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx storder170chi01 | Unpaid | 0     | [blank]     | $200.00    | ($38.00) | $10.00  | $0.00 | [blank] | [blank] | $172.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                  | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx storder170chi01 | Unpaid | 0     | [blank]     | $200.00    | ($38.00) | $10.00  | $0.00 | [blank] | [blank] | $172.00 |
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 172           | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total   | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $200.00   | 1        | 9           | $180.00 | $200.00  |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder170chi01 | ngoctx stOrder170 | [blank]     | [blank]   | Paid         | Payment via invoice | Pending       | Fulfilled   |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   | specialDiscount |
      | $200.00    | $20.00   | $10.00 | Not applied         | Not applied        | $50.00           | $172.00 | $18.00          |
    Then Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse            |
      | 1     | random | Pod Consignment | Auto Ngoc Distribution CHI |

    And NGOC_ADMIN_05 quit browser

  @adminOrder_171 @adminOrder
  Scenario: Create order for a line-item that - Is not included in any other orders Has multiple inventories with End Qty > 0 in 2 different DCs
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx556@podfoods.co | 12345678a |
     # Delete promotion
    And Admin search promotion by Promotion Name "AT Promo Order 171"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Sponsor Order 171"
    And Admin delete promotion by skuName ""

    # Create sku
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | sold_out     | 2000      | 2000 |
    And Admin create a "active" SKU from admin with name "sku171 random" of product "32407"

    # Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 3687      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Order 171 | AT Promo Order 171 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |

      # Create pod-sponsor promotion
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 3687      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                       | description                | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | AT Promo Sponsor Order 171 | AT Promo Sponsor Order 171 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

     # Create inventory DC_1
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 2        | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create inventory DC_2
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 3        | random   | 99           | currentDate  | [blank]     | [blank] |

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 6        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1        | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3889     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 9th Avenue | New York | 33               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx556@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    Then Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder171chi01 | ngoctx stOrder171 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   | specialDiscount |
      | $100.00    | $10.00   | $50.00 | $30.00              | $30.00             | $25.00           | $161.00 | $9.00           |
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 3        | 0           | $54.00 | $60.00   |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 2        | 0           | $36.00 | $40.00   |
    And Admin check line items "deleted or shorted items" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |
    And Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse               |
      | 1     | random | Pod Consignment | Auto Ngoc Distribution CHI 01 |
      | 2     | random | Pod Consignment | Auto Ngoc Distribution CHI    |

  @adminOrder_172 @adminOrder
  Scenario: Create order for a line-item that - Is not included in any other orders Has multiple inventories with End Qty > 0 in 2 different DCs - financial pending approved
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx557@podfoods.co | 12345678a |
    # Delete promotion
    And Admin search promotion by Promotion Name "AT Promo Order 172"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Sponsor Order 172"
    And Admin delete promotion by skuName ""

    # Create sku
    And Info of Region
      | region           | id | state  | availability | casePrice | msrp |
      | New York Express | 53 | active | sold_out     | 2000      | 2000 |
    And Admin create a "active" SKU from admin with name "sku171 random" of product "32407"

    # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | random | 3688      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Order 172 | AT Promo Order 172 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |

      # Create pod-sponsor promotion
    And Admin add region by API
      | region           | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | New York Express | 26        | [blank] | 3688      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                       | description                | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | AT Promo Sponsor Order 172 | AT Promo Sponsor Order 172 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

     # Create inventory DC_1
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 2        | random   | 121          | currentDate  | [blank]     | [blank] |

    # Create inventory DC_2
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 3        | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api53    | create by api      | 6        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1        | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3890     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 9th Avenue | New York | 33               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx557@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | New York Express | ngoctx storder172chi01 | ngoctx stOrder172 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $100.00    | $10.00   | $50.00 | $30.00              | $30.00             | $25.00           | $170.00 |
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 3        | 5           | $54.00 | $60.00   |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 2        | 5           | $36.00 | $40.00   |
    And Admin check line items "deleted or shorted items" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 5           | $18.00 | $20.00   |
    Then Admin verify not set distribution center in order detail
      | index | sku    | delivery        |
      | 1     | random | Pod Consignment |
      | 2     | random | Pod Consignment |
    When Admin approve to fulfill this order
    And NGOC_ADMIN_05 refresh browser
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 3        | 0           | $54.00 | $60.00   |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 2        | 0           | $36.00 | $40.00   |
    And Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse         |
      | 1     | random | Pod Consignment | Auto Distribute NewYork |
      | 2     | random | Pod Consignment | AT Distribution NY 01   |

  @adminOrder_173 @adminOrder
  Scenario: Check when admin manually changes availability from OOS to In Stock - decrease inventory
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx558@podfoods.co | 12345678a |
      # Delete promotion
    And Admin search promotion by Promotion Name "AT Promo Order 173"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Sponsor Order 173"
    And Admin delete promotion by skuName ""

    # Create sku
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | sold_out     | 2000      | 2000 |
    And Admin create a "active" SKU from admin with name "sku173 random" of product "32407"

    # Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 3689      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Order 173 | AT Promo Order 173 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |

      # Create pod-sponsor promotion
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 3689      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                       | description                | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | AT Promo Sponsor Order 173 | AT Promo Sponsor Order 173 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

       # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 1        | random   | 90           | currentDate  | [blank]     | [blank] |

     # Active product and sku
    And Admin change info of regions attributes of sku "sku173 random" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 2000             | 2000       | sold_out     | active |

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3891     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx558@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 go to product "32407" with sku "" by link
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 20        | 20       | In stock     | [blank]  |
    And Click Update
    And NGOC_ADMIN_05 wait 2000 mini seconds

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder173chi01 | ngoctx stOrder173 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $20.00     | $2.00    | $10.00 | Not applied         | $0.00              | $5.00            | $26.20 | $1.80           |
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |
    And Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse            |
      | 1     | random | Pod Consignment | Auto Ngoc Distribution CHI |
      # increase quantity
    And Admin edit line item in order detail
      | sub | order         | subID         | sku    | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | create by api | random | 2        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail

    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |
    And Admin check line items "deleted or shorted items" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |

    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx558@podfoods.co | 12345678a |
    # Addition item inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | random                  | AT Product Order 03 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by lotcote "" from API
    And Admin addition item of inventory "" by API
      | action | addition_category_id | comment  | quantity |
      | add    | 1                    | AutoTest | 1        |

    And Switch to actor NGOC_ADMIN_05
    And NGOC_ADMIN_05 refresh browser
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 2        | 0           | $36.00 | $40.00   |

       # decrease quantity
    And Admin edit line item in order detail
      | sub | order         | subID         | sku    | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | create by api | random | 1        | Buyer adjustment | Autotest | Change | Yes       | Yes      |
    And Admin create subtraction items in order detail
      | quantity | category          | subCategory | comment  |
      | [blank]  | Pull date reached | Donated     | Autotest |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |

    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx558@podfoods.co | 12345678a |
      # Delete promotion
    And Admin search promotion by Promotion Name "AT Promo Order 173"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Sponsor Order 173"
    And Admin delete promotion by skuName ""

    # Create sku
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | sold_out     | 2000      | 2000 |
    And Admin create a "active" SKU from admin with name "sku1731 random" of product "32407"
    And Admin save sku name by index "1"

    # Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 3689      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Order 173 | AT Promo Order 173 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |

      # Create pod-sponsor promotion
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 3689      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                       | description                | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | AT Promo Sponsor Order 173 | AT Promo Sponsor Order 173 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

       # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 1        | random   | 90           | currentDate  | [blank]     | [blank] |

     # Active product and sku
    And Admin change info of regions attributes of sku "sku173 random" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 2000             | 2000       | sold_out     | active |

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3891     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx558@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 go to product "32407" with sku "" by link
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 20        | 20       | In stock     | [blank]  |
    And Click Update
    And NGOC_ADMIN_05 wait 2000 mini seconds

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder173chi01 | ngoctx stOrder173 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $20.00     | $2.00    | $10.00 | $30.00              | $0.00              | $5.00            | $56.20 | $1.80           |
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |
    And Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse            |
      | 1     | random | Pod Consignment | Auto Ngoc Distribution CHI |
      # increase quantity
    And Admin edit line item in order detail
      | sub | order         | subID         | sku    | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | create by api | random | 2        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail

    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |
    And Admin check line items "deleted or shorted items" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |

    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx558@podfoods.co | 12345678a |
    # Addition item inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | random                  | AT Product Order 03 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by lotcote "" from API
    And Admin addition item of inventory "" by API
      | action | addition_category_id | comment  | quantity |
      | add    | 1                    | AutoTest | 1        |

    And Switch to actor NGOC_ADMIN_05
    And NGOC_ADMIN_05 refresh browser
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 2        | 0           | $36.00 | $40.00   |

       # decrease quantity
    And Admin edit line item in order detail
      | sub | order         | subID         | sku    | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | create by api | random | 1        | Buyer adjustment | Autotest | Change | Yes       | Yes      |
    And Admin create subtraction items in order detail
      | quantity | category          | subCategory | comment  |
      | [blank]  | Pull date reached | Donated     | Autotest |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |
    And Admin add line item in order detail
      | skuName | quantity | note    |
      | index1  | 1        | [blank] |
    And Admin check line items "deleted or shorted items" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | index2 | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |

    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx558@podfoods.co | 12345678a |
    # Addition item inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | random                  | AT Product Order 03 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by lotcote "" from API
    And Admin addition item of inventory "" by API
      | action | addition_category_id | comment  | quantity |
      | add    | 1                    | AutoTest | 2        |
      # Active product and sku
    And Admin change info of regions attributes of sku "sku173 random" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 2000             | 2000       | sold_out     | active |

    And Switch to actor NGOC_ADMIN_05
    And Admin add line item in order detail
      | skuName        | quantity | note    |
      | sku1732 random | 1        | [blank] |
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku            | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | sku1732 random | 1 units/case | $20.00    | 1        | 2           | $18.00 | $20.00   |
    And Admin check line items "deleted or shorted items" in order details
      | brand             | product             | sku            | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | sku1732 random | 1 units/case | $20.00    | 1        | 2           | $18.00 | $20.00   |

  @adminOrder_173 @adminOrder
  Scenario: Check when admin manually changes availability from OOS to In Stock - decrease inventory
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx558@podfoods.co | 12345678a |
      # Delete promotion
    And Admin search promotion by Promotion Name "AT Promo Order 173"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Sponsor Order 173"
    And Admin delete promotion by skuName ""

    # Create sku
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | sold_out     | 2000      | 2000 |
    And Admin create a "active" SKU from admin with name "sku173 random" of product "32407"

    # Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 3689      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Order 173 | AT Promo Order 173 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |

      # Create pod-sponsor promotion
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 3689      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                       | description                | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | AT Promo Sponsor Order 173 | AT Promo Sponsor Order 173 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

       # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 1        | random   | 90           | currentDate  | [blank]     | [blank] |

     # Active product and sku
    And Admin change info of regions attributes of sku "sku173 random" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 2000             | 2000       | sold_out     | active |

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3891     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx558@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 go to product "32407" with sku "" by link
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 20        | 20       | In stock     | [blank]  |
    And Click Update
    And NGOC_ADMIN_05 wait 2000 mini seconds

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder173chi01 | ngoctx stOrder173 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $20.00     | $2.00    | $10.00 | Not applied         | $0.00              | $5.00            | $26.20 | $1.80           |
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |
    And Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse            |
      | 1     | random | Pod Consignment | Auto Ngoc Distribution CHI |
      # increase quantity
    And Admin edit line item in order detail
      | sub | order         | subID         | sku    | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | create by api | random | 2        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail

    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |
    And Admin check line items "deleted or shorted items" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |

    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx558@podfoods.co | 12345678a |
    # Addition item inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | random                  | AT Product Order 03 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by lotcote "" from API
    And Admin addition item of inventory "" by API
      | action | addition_category_id | comment  | quantity |
      | add    | 1                    | AutoTest | 1        |

    And Switch to actor NGOC_ADMIN_05
    And NGOC_ADMIN_05 refresh browser
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 2        | 0           | $36.00 | $40.00   |

       # decrease quantity
    And Admin edit line item in order detail
      | sub | order         | subID         | sku    | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | create by api | random | 1        | Buyer adjustment | Autotest | Change | Yes       | Yes      |
    And Admin create subtraction items in order detail
      | quantity | category          | subCategory | comment  |
      | [blank]  | Pull date reached | Donated     | Autotest |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |

    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx558@podfoods.co | 12345678a |
      # Delete promotion
    And Admin search promotion by Promotion Name "AT Promo Order 173"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Sponsor Order 173"
    And Admin delete promotion by skuName ""

    # Create sku
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | sold_out     | 2000      | 2000 |
    And Admin create a "active" SKU from admin with name "sku1731 random" of product "32407"
    And Admin save sku name by index "1"

    # Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 3689      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Order 173 | AT Promo Order 173 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |

      # Create pod-sponsor promotion
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 3689      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                       | description                | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | AT Promo Sponsor Order 173 | AT Promo Sponsor Order 173 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

       # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 1        | random   | 90           | currentDate  | [blank]     | [blank] |

     # Active product and sku
    And Admin change info of regions attributes of sku "sku173 random" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 2000             | 2000       | sold_out     | active |

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3891     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx558@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 go to product "32407" with sku "" by link
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 20        | 20       | In stock     | [blank]  |
    And Click Update
    And NGOC_ADMIN_05 wait 2000 mini seconds

    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                  | store             | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx storder173chi01 | ngoctx stOrder173 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $20.00     | $2.00    | $10.00 | $30.00              | $0.00              | $5.00            | $56.20 | $1.80           |
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |
    And Admin verify pod consignment and preferment warehouse
      | index | sku    | delivery        | preferWarehouse            |
      | 1     | random | Pod Consignment | Auto Ngoc Distribution CHI |
      # increase quantity
    And Admin edit line item in order detail
      | sub | order         | subID         | sku    | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | create by api | random | 2        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail

    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |
    And Admin check line items "deleted or shorted items" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |

    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx558@podfoods.co | 12345678a |
    # Addition item inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | random                  | AT Product Order 03 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by lotcote "" from API
    And Admin addition item of inventory "" by API
      | action | addition_category_id | comment  | quantity |
      | add    | 1                    | AutoTest | 1        |

    And Switch to actor NGOC_ADMIN_05
    And NGOC_ADMIN_05 refresh browser
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 2        | 0           | $36.00 | $40.00   |

       # decrease quantity
    And Admin edit line item in order detail
      | sub | order         | subID         | sku    | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | create by api | random | 1        | Buyer adjustment | Autotest | Change | Yes       | Yes      |
    And Admin create subtraction items in order detail
      | quantity | category          | subCategory | comment  |
      | [blank]  | Pull date reached | Donated     | Autotest |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |
    And Admin add line item in order detail
      | skuName | quantity | note    |
      | index1  | 1        | [blank] |
    And Admin check line items "deleted or shorted items" in order details
      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | index2 | 1 units/case | $20.00    | 1        | 0           | $18.00 | $20.00   |

    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx558@podfoods.co | 12345678a |
    # Addition item inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | random                  | AT Product Order 03 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by lotcote "" from API
    And Admin addition item of inventory "" by API
      | action | addition_category_id | comment  | quantity |
      | add    | 1                    | AutoTest | 2        |
      # Active product and sku
    And Admin change info of regions attributes of sku "sku173 random" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 2000             | 2000       | sold_out     | active |

    And Switch to actor NGOC_ADMIN_05
    And Admin add line item in order detail
      | skuName        | quantity | note    |
      | sku1732 random | 1        | [blank] |
    And Admin check line items "sub invoice" in order details
      | brand             | product             | sku            | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | sku1732 random | 1 units/case | $20.00    | 1        | 2           | $18.00 | $20.00   |
    And Admin check line items "deleted or shorted items" in order details
      | brand             | product             | sku            | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Store 03 | AT Product Order 03 | sku1732 random | 1 units/case | $20.00    | 1        | 2           | $18.00 | $20.00   |

#  @adminOrder_177 @adminOrder
#  Scenario: Check when admin deletes the Pod consignment of a line-item
#    Given NGOCTX05 login web admin by api
#      | email                 | password  |
#      | ngoctx558@podfoods.co | 12345678a |
#      # Delete promotion
#    And Admin search promotion by Promotion Name "AT Promo Order 174"
#    And Admin delete promotion by skuName ""
#    And Admin search promotion by Promotion Name "AT Promo Sponsor Order 174"
#    And Admin delete promotion by skuName ""
#
#    # Create sku
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | sold_out     | 2000      | 2000 |
#    And Admin create a "active" SKU from admin with name "sku174 random" of product "32407"
#
#    # Create promotion
#    And Admin add region by API
#      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
#      | Chicagoland Express | 26        | random | 3762      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
#    And Admin add stack deal of promotion by API
#      | typeCharge                             | chargeValue | stack | minQty |
#      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
#    And Admin create promotion by api with info
#      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
#      | Promotions::OnGoing | AT Promo Order 174 | AT Promo Order 174 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |
#
#      # Create pod-sponsor promotion
#    And Admin add region by API
#      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
#      | Chicagoland Express | 26        | [blank] | 3762      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
#    And Admin add stack deal of promotion by API
#      | typeCharge                             | chargeValue | stack | minQty |
#      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
#    And Admin create promotion by api with info
#      | type                     | name                       | description                | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
#      | Promotions::PodSponsored | AT Promo Sponsor Order 174 | AT Promo Sponsor Order 174 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |
#
#       # Create inventory
#    And Admin create inventory api1
#      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | random | random             | 8        | random   | 90           | currentDate  | [blank]     | [blank] |
#
#    # Create order
#    And Admin create line items attributes by API1
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api26    | create by api      | 10       | false     | [blank]          |
#    Then Admin create order by API
#      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
#      | 3919     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
#
#
#    Given NGOC_ADMIN_05 open web admin
#    When login to beta web with email "ngoctx558@podfoods.co" pass "12345678a" role "Admin"
#    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
#    And Admin search the orders "create by api"
#    And Admin go to order detail number "create by api"
#    And Admin remove pod consignment deliverable of sku "random" in line item
#    And Admin check line items "sub invoice" in order details
#      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total   | oldTotal |
#      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 8        | 0           | $144.00 | $160.00  |
#    And Admin check line items "deleted or shorted items" in order details
#      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
#      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 2        | 0           | $36.00 | $40.00   |
#    And NGOC_ADMIN_04 quit browser
#
#  @adminOrder_178 @adminOrder
#  Scenario: Check when admin deletes the Pod consignment of a line-item in 2 order
#    Given NGOCTX05 login web admin by api
#      | email                 | password  |
#      | ngoctx558@podfoods.co | 12345678a |
#      # Delete promotion
#    And Admin search promotion by Promotion Name "AT Promo Order 178"
#    And Admin delete promotion by skuName ""
#    And Admin search promotion by Promotion Name "AT Promo Sponsor Order 178"
#    And Admin delete promotion by skuName ""
#
#    # Create sku
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | sold_out     | 2000      | 2000 |
#    And Admin create a "active" SKU from admin with name "sku178 random" of product "32407"
#
#    # Create promotion
#    And Admin add region by API
#      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
#      | Chicagoland Express | 26        | random | 3762      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
#    And Admin add stack deal of promotion by API
#      | typeCharge                             | chargeValue | stack | minQty |
#      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
#    And Admin create promotion by api with info
#      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
#      | Promotions::OnGoing | AT Promo Order 178 | AT Promo Order 178 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |
#
#      # Create pod-sponsor promotion
#    And Admin add region by API
#      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
#      | Chicagoland Express | 26        | [blank] | 3762      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
#    And Admin add stack deal of promotion by API
#      | typeCharge                             | chargeValue | stack | minQty |
#      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
#    And Admin create promotion by api with info
#      | type                     | name                       | description                | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
#      | Promotions::PodSponsored | AT Promo Sponsor Order 174 | AT Promo Sponsor Order 174 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |
#
#       # Create inventory
#    And Admin create inventory api1
#      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | random | random             | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
#
#    # Create order 01
#    And Admin create line items attributes by API1
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api26    | create by api      | 14       | false     | [blank]          |
#    Then Admin create order by API
#      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
#      | 3919     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
#    And Admin clear line items attributes by API
#    And Admin save order number by index "1"
#
#     # Create order 02
#    And Admin create line items attributes by API1
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api26    | create by api      | 8        | false     | [blank]          |
#    Then Admin create order by API
#      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
#      | 3919     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
#    And Admin clear line items attributes by API
#    And Admin save order number by index "2"
#
#    Given NGOC_ADMIN_05 open web admin
#    When login to beta web with email "ngoctx558@podfoods.co" pass "12345678a" role "Admin"
#    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
#    And Admin search the orders "create by api"
#    And Admin go to order detail number "index1"
#    And Admin remove pod consignment deliverable of sku "random" in line item
#    And Admin check line items "sub invoice" in order details
#      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
#      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 2        | 0           | $36.00 | $40.00   |
#    And Admin check line items "deleted or shorted items" in order details
#      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
#      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 12       | 0           | 216.00 | $240.00  |
#
#    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
#    And Admin search the orders "create by api"
#    And Admin go to order detail number "index2"
#    And Admin check line items "sub invoice" in order details
#      | brand             | product             | sku    | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
#      | AT Brand Store 03 | AT Product Order 03 | random | 1 units/case | $20.00    | 8        | 0           | 144.00 | $160.00  |
#    And NGOC_ADMIN_04 quit browser

    #
    # Approve all pending orders
    #

  @adminOrder_174 @adminOrder
  Scenario: Check when admin approve 1 order (approve all pending order)
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx558@podfoods.co | 12345678a |
     # Delete order
    When Search order by sku "69440" by api
    And Admin delete order of sku "69440" by api
     # Create inventory
    And Admin create inventory api1
      | index | sku                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Financial 01 | 69440              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 139350             | 69440              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3916     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 280 Columbus Avenue | New York | 33               | 10023 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx558@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    # verify order
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | Yes              |
    When Admin go to order detail number "create by api"
    When Admin approve to fulfill this order
    And Admin expand line item in order detail
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                  | store                   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | financeApproval | financeApproveBy | financeApproveAt |
      | Empty      | currentDate | New York Express | ngoctx bapproveallny01 | ngoctx stapproveallny01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     | Approved        | Admin: ngoctx558 | currentDate      |
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
     # verify order
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | Yes              |
    And Admin no found data in result
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | No               |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                  | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx bapproveallny01 | ngoctx stapprov… | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    And NGOC_ADMIN_12 quit browser

  @adminOrder_175 @adminOrder
  Scenario: Check when admin approve 2 order (approve all pending order)
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx558@podfoods.co | 12345678a |
     # Delete order
    When Search order by sku "69443" by api
    And Admin delete order of sku "69443" by api
     # Create inventory
    And Admin create inventory api1
      | index | sku                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Financial 01 | 69443              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order 1
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 139350             | 69443              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3917     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 280 Columbus Avenue | New York | 33               | 10023 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"

     # Create order 2
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 139350             | 69443              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3917     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 280 Columbus Avenue | New York | 33               | 10023 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx558@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    # verify order
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | Yes              |
    When Admin go to order detail number "create by api"
    When Admin approve to fulfill all order
    And Admin expand line item in order detail
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                  | store                   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | financeApproval | financeApproveBy | financeApproveAt |
      | Empty      | currentDate | New York Express | ngoctx bapproveallny02 | ngoctx stapproveallny02 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     | Approved        | Admin: ngoctx558 | currentDate      |
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
     # verify order 1
    And Admin search the orders by info
      | index | orderNumber | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | 1     | index       | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | Yes              |
    And Admin no found data in result
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | No               |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                  | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx bapproveallny02 | ngoctx stapprov… | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    # verify order 2
    And Admin search the orders by info
      | index | orderNumber | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | 2     | index       | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | Yes              |
    And Admin no found data in result
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | No               |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                  | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx bapproveallny02 | ngoctx stapprov… | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    And NGOC_ADMIN_12 quit browser

  @adminOrder_176 @adminOrder
  Scenario: Check when admin approve 1 order in 2 order (approve all pending order)
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx558@podfoods.co | 12345678a |
     # Delete order
    When Search order by sku "69527" by api
    And Admin delete order of sku "69527" by api
     # Create inventory
    And Admin create inventory api1
      | index | sku                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Financial 03 | 69527              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order 1
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 139438             | 69527              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3918     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 280 Columbus Avenue | New York | 33               | 10023 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"

     # Create order 2
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 139438             | 69527              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3918     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 280 Columbus Avenue | New York | 33               | 10023 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx558@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    # verify order
    And Admin search the orders by info
      | index | orderNumber | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | 1     | index       | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | Yes              |
    When Admin go to order detail number "index1"
    Then Admin verify approve to fulfill all order is "Approve all pending orders (2 orders)"
    When Admin approve to fulfill this order
    And Admin expand line item in order detail
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                  | store                   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | financeApproval | financeApproveBy | financeApproveAt |
      | Empty      | currentDate | New York Express | ngoctx bapproveallny03 | ngoctx stapproveallny03 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     | Approved        | Admin: ngoctx558 | currentDate      |
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
     # verify order 1
    And Admin search the orders by info
      | index | orderNumber | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | 1     | index       | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | Yes              |
    And Admin no found data in result
    And Admin search the orders by info
      | index | orderNumber | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | 1     | index       | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | No               |
    Then Admin verify result order in all order
      | index | order | checkout    | buyer                  | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | 1     | index | currentDate | ngoctx bapproveallny03 | ngoctx stapprov… | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    # verify order 2
    And Admin search the orders by info
      | index | orderNumber | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | 2     | index       | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | Yes              |
    Then Admin verify result order in all order
      | index | order | checkout    | buyer                  | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | 2     | index | currentDate | ngoctx bapproveallny03 | ngoctx stapprov… | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    When Admin go to order detail number "index2"
    Then Admin verify approve to fulfill all order is not display
    When Admin approve to fulfill this order
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
     # verify order 2
    And Admin search the orders by info
      | index | orderNumber | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | 2     | index       | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | Yes              |
    And Admin no found data in result
    And Admin search the orders by info
      | index | orderNumber | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | 2     | index       | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | No               |
    Then Admin verify result order in all order
      | index | order | checkout    | buyer                  | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | 2     | index | currentDate | ngoctx bapproveallny03 | ngoctx stapprov… | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    And NGOC_ADMIN_12 quit browser
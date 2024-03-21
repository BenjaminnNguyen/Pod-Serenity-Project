#mvn clean verify -Dtestsuite="AddToCartTestSuite" -Dcucumber.options="src/test/resources/features/addtocart" -Denvironments=product
@feature=LPOrders
Feature: LP Orders

  @TC_01
  Scenario: Verify the Order function
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 1762      |
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 1664              |
    And Admin set all receiving weekday of store "2859" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "2859" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "2859" by api
      | day                    |
      | within 7 business days |
    And Admin set all receiving weekday of store "2859" by api
      | day                    |
      | within 7 business days |
    And Admin delete order by sku of product "random product lp order 1 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]               | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order 1 api" from API
    And Admin delete all inventory by API
    And Admin search product name "random product lp order 1 api" by api
    And Admin delete product name "random product lp order 1 api" by api
    And Admin set weekdays
      | weekday                |
      | within 7 business days |
    And Admin edit Route id "91"
      | name             | region_id | delivery_cost | case_pick_fee | within_7_business_day |
      | Auto bao route 1 | 63        | 0.0           | 0.0           | true                  |
    And Admin change route of store by api
      | storeID | routeID |
      | 2859    | 91      |
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | random product lp order 1 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order 1 api" of product ""
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code                  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 1 api | random             | 5        | random sku lp order 1 api | 95           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po            |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | create by api |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 1 | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                       | sku                       | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 1 api | random sku lp order 1 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

  @LP_TC_02
  Scenario Outline: Verify the Orders list
    Given USER_LP open web LP
    When login to beta web with email "<lp>" pass "12345678a" role "LP"
    Then USER_LP Navigate to "Orders" by sidebar
#    And LP check 1 number record on pagination
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order   | po      |
      | Ordered, Latest first | -            | [blank] | [blank]       | [blank] | [blank] |
#    And USER_LP clear filter on field "Fulfillment state"
#    And LP check 12 number record on pagination
#    And LP click "2" on pagination
#    And LP check 12 number record on pagination
#    And LP click "back" on pagination
#    And LP check 12 number record on pagination
#    And LP click "next" on pagination
#    And LP check 12 number record on pagination
#    And LP click "back" on pagination
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order   | po      | route   | uploadInvoice |
      | Ordered, Latest first | Unconfirmed  | [blank] | [blank]       | [blank] | [blank] | [blank] | Yes           |
    And LP clear search all filters
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order   | po      | route   | uploadInvoice |
      | Ordered, Latest first | In progress  | [blank] | [blank]       | [blank] | [blank] | [blank] | No            |
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order | po      | route   | uploadInvoice |
      | Ordered, Latest first | Fulfilled    | [blank] | [blank]       | 123   | [blank] | [blank] | -             |
    And USER_LP clear filter on field "Fulfillment state"
    And USER_LP filter order by info
      | orderBy                 | fulFillState | store   | fulFilledDate | order   | po      | route   | uploadInvoice |
      | Ordered, Earliest first | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | PO Number, A > Z        | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | PO Number, Z > A        | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | Store, A > Z            | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | Store, Z > A            | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | Delivery, A > Z         | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | Delivery, Z > A         | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | ETA, Latest first       | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | ETA, Earliest first     | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | Route, A > Z            | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | Route, Z > A            | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | Address, A > Z          | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | Address, Z > A          | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | Fulfillment, A > Z      | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
      | Fulfillment, Z > A      | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]       |
    And USER_LP clear filter on field "Order by"
    And Lp "Collapse" search order
    And Check field "Order by" is invisible
    And Check field "Fulfillment state" is invisible
    And Check field "Store" is invisible
    And Check field "Fulfilled date" is invisible
    And Check field "Order # / PO #" is invisible
    And Check field "Route" is invisible
    And Check field "Invoice uploaded?" is invisible
    And Lp "Show filters" search order
    And Check field "Order by" is visible
    And Check field "Fulfillment state" is visible
    And Check field "Store" is visible
    And Check field "Fulfilled date" is visible
    And Check field "Order # / PO #" is visible
    And Check field "Route" is visible
    And Check field "Invoice uploaded?" is visible
    And USER_LP log out
    Examples:
      | lp                     | route        |
#      | ngoctx+autolpdriver@podfoods.co      | Auto bao route 1 |
#      | ngoctx+autolpwarehousing@podfoods.co | Auto bao route 1 |
      | ngoctx+lp1@podfoods.co | Auto Route 1 |

  @TC_13 @LP_ORDERS_LIST_37
  Scenario: Check display of a PO when it is assigned to a driver LP company which has multiple LP account
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order 13 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order 13 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order 13 api" from API
    And Admin delete all inventory by API
    And Admin search product name "random product lp order 13 api" by api
    And Admin delete product name "random product lp order 13 api" by api
    And Admin change state of brand "3018" to "active" by API
    And Admin set weekdays
      | weekday                |
      | within 7 business days |
    And Admin edit Route id "91"
      | name             | region_id | delivery_cost | case_pick_fee | within_7_business_day |
      | Auto bao route 1 | 63        | 0.0           | 0.0           | true                  |
    And Admin change route of store by api
      | storeID | routeID |
      | 2859    | 91      |

    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | random product lp order 13 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order 13 api" of product ""
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code                   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 13 api | random             | 5        | random sku lp order 13 api | 95           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po            |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | create by api |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 1 | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                        | sku                        | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 13 api | random sku lp order 13 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

    Given USER_LP2 open web LP
    When login to beta web with email "ngoctx+autolpdriver2@podfoods.co" pass "12345678a" role "LP"
    And USER_LP2 accept Privacy Policy
    And USER_LP2 Navigate to "Orders" by sidebar
    And USER_LP2 filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po            |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | create by api |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 1 | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                        | sku                        | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 13 api | random sku lp order 13 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

#    Changes route
    And Admin remove route of store "2859" by api
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po            |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | create by api |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route   | address                                       | fulfillment |
      | currentDate | create by api | Auto store Florida | Within 7 business days | [blank] | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                        | sku                        | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 13 api | random sku lp order 13 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

    And Admin change route of store by api
      | storeID | routeID |
      | 2859    | 91      |
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po            |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | create by api |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 1 | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                        | sku                        | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 13 api | random sku lp order 13 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

    And Admin set weekdays
      | weekday                |
      | within 7 business days |
    And Admin edit Route id "91"
      | name             | region_id | delivery_cost | case_pick_fee | within_7_business_day |
      | Auto bao route 2 | 63        | 0.0           | 0.0           | true                  |
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po            |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | create by api |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 2 | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 2 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                        | sku                        | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 13 api | random sku lp order 13 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

  @TC_33 @TC_32 @TC_34 @TC_35 @TC_36 @TC_37
  Scenario: In case the store have NOT set any Route but set receiving weekdays = weekdays (Mon, Tue, Wed, Thu, Fri, Sat, Sun) and Receiving time
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order 33 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order 33 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order 33 api" from API
    And Admin delete all inventory by API
    And Admin search product name "random product lp order 33 api" by api
    And Admin delete product name "random product lp order 33 api" by api
    And Admin set weekdays
      | weekday                |
      | within 7 business days |
    And Admin edit Route id "91"
      | name             | region_id | delivery_cost | case_pick_fee | within_7_business_day |
      | Auto bao route 1 | 63        | 0.0           | 0.0           | true                  |
    And Admin change route of store by api
      | storeID | routeID |
      | 2859    | 91      |

    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | random product lp order 33 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order 33 api" of product ""
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code                   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 33 api | random             | 5        | random sku lp order 33 api | 95           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po            |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | create by api |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 1 | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                        | sku                        | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 33 api | random sku lp order 33 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
#
#    Changes route
    And Admin remove route of store "2859" by api
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po            |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | create by api |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route   | address                                       | fulfillment |
      | currentDate | create by api | Auto store Florida | Within 7 business days | [blank] | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                        | sku                        | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 33 api | random sku lp order 33 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

    And Admin change route of store by api
      | storeID | routeID |
      | 2859    | 91      |
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po            |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | create by api |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 1 | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                        | sku                        | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 33 api | random sku lp order 33 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

    And Admin set weekdays
      | weekday                |
      | within 7 business days |
    And Admin edit Route id "91"
      | name             | region_id | delivery_cost | case_pick_fee | within_7_business_day |
      | Auto bao route 2 | 63        | 0.0           | 0.0           | true                  |
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po            |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | create by api |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 2 | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 2 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                        | sku                        | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 33 api | random sku lp order 33 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

    And Admin set weekdays
      | weekday   |
      | monday    |
      | tuesday   |
      | wednesday |
    And Admin edit Route id "91"
      | name             | region_id | delivery_cost | case_pick_fee | within_7_business_day |
      | Auto bao route 2 | 63        | 0.0           | 0.0           | false                 |
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po            |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | create by api |
    And Check order record on order page
      | ordered     | number        | store              | delivery            | route            | address                                       | fulfillment |
      | currentDate | create by api | Auto store Florida | Every Mon, Tue, Wed | Auto bao route 2 | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday    | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Every Mon, Tue, Wed | [blank]       | Auto bao route 2 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                        | sku                        | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 33 api | random sku lp order 33 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
    And Admin set weekdays
      | weekday                |
      | within 7 business days |

    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po            |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | create by api |
    And Check order record on order page
      | ordered     | number        | store              | delivery            | route            | address                                       | fulfillment |
      | currentDate | create by api | Auto store Florida | Every Mon, Tue, Wed | Auto bao route 2 | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday    | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Every Mon, Tue, Wed | [blank]       | Auto bao route 2 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                        | sku                        | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 33 api | random sku lp order 33 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

    And Admin edit Route id "91"
      | name             | region_id | delivery_cost | case_pick_fee | within_7_business_day |
      | Auto bao route 1 | 63        | 0.0           | 0.0           | true                  |
    And Admin change route of store by api
      | storeID | routeID |
      | 2859    | 91      |
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po            |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | create by api |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 1 | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |

  @TC_47
  Scenario: Verify information displayed for LPs which have DRIVER role when the select mutiple POs mode is on
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order 47 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order 47 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order 47 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
#    And Admin delete all inventory by API
    And Admin search product name "random product lp order 47 api" by api
    And Admin delete product name "random product lp order 47 api" by api
    And Admin set weekdays
      | weekday                |
      | within 7 business days |
    And Admin edit Route id "91"
      | name             | region_id | delivery_cost | case_pick_fee | within_7_business_day |
      | Auto bao route 1 | 63        | 0.0           | 0.0           | true                  |
    And Admin change route of store by api
      | storeID | routeID |
      | 2859    | 91      |

    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | random product lp order 47 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order 47 api" of product ""
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code                   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 47 api | random             | 5        | random sku lp order 47 api | 95           | Plus1        | [blank]     | [blank] |
#    And Info of Region
#      | region               | id | state  | availability | casePrice | msrp |
#      | Pod Direct Southeast | 59 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order 47 2 api" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                     | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 47 2 api | random             | 5        | random sku lp order 47 2 api | 95           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |
    And Admin set Invoice by API
      | skuName                      | skuId | order_id      | eta_date | payment_state | surfix |
      | random sku lp order 47 2 api | 0     | create by api | [blank]  | pending       | 2      |

    And Admin create purchase order of sub-invoice "create by api" suffix "2" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order   | po      |
      | Ordered, Latest first | [blank]      | [blank] | Plus7         | [blank] | [blank] |
    And USER_LP check no order found
    And USER_LP clear filter on field "Fulfilled date"
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | -            | Auto store Florida | [blank]       | create by api | [blank] |
    And LP choose order to confirm
      | number        | suffix |
      | create by api | 1      |
      | create by api | 2      |
    And Click on button "Confirm POs"
    And Check button "Confirm POs" is "disabled"
    And LP Pick Fulfillment date "currentDate" to confirm POs
    And Click on button "Confirm POs"
    And USER_LP check alert message
      | Orders updated successfully. |
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po           |
      | Ordered, Latest first | -            | Auto store Florida | [blank]       | create by api | with suffix1 |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment | suffix |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 1 | 455 Madison Avenue, New York, Virginia, 10022 | In progress | 1      |
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po           | suffix |
      | Ordered, Latest first | -            | Auto store Florida | [blank]       | create by api | with suffix2 | 2      |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment | suffix |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 1 | 455 Madison Avenue, New York, Virginia, 10022 | In progress | 2      |
    And USER_LP clear filter on field "Order # / PO #"
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | -            | Auto store Florida | [blank]       | create by api | [blank] |
    And LP choose order to confirm
      | number        | suffix |
      | create by api | 1      |
      | create by api | 2      |
    And Click on button "Unselect all"
    And Check any text "is" showing on screen
      | 0 selected |
    And Check button "Confirm POs" is disabled
    And Check button "Sub-invoices" is disabled
    And Check button "Packing Slips" is disabled
    And Click on button "Select all"
    And Check any text "is" showing on screen
      | 2 selected |
    And LP select all orders on list
    And Check any text "is" showing on screen
      | 0 selected |
    And Check button "Confirm POs" is disabled
    And Check button "Sub-invoices" is disabled
    And Check button "Packing Slips" is disabled
    And LP select all orders on list
    And Check any text "is" showing on screen
      | 2 selected |
    And Check button "Confirm POs" is enable
    And Check button "Sub-invoices" is enable
    And Check button "Packing Slips" is enable
    And Click on button "Sub-invoices"
#    And LP wait for download "Sub-invoices" success
#    And Click on button "Packing Slips"
#    And LP wait for download "Packing Slips" success

  @TC_48
  Scenario: Verify information displayed for LPs which have Warehousing role when the select mutiple POs mode is on
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order 48 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order 48 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order 48 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order 48 api" by api
    And Admin delete product name "random product lp order 48 api" by api
    And Admin set weekdays
      | weekday                |
      | within 7 business days |
    And Admin edit Route id "91"
      | name             | region_id | delivery_cost | case_pick_fee | within_7_business_day |
      | Auto bao route 1 | 63        | 0.0           | 0.0           | true                  |
    And Admin change route of store by api
      | storeID | routeID |
      | 2859    | 91      |
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | random product lp order 48 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order 48 api" of product ""
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code                   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 48 api | random             | 5        | random sku lp order 48 api | 95           | Plus1        | [blank]     | [blank] |

    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |
    And Admin set Invoice by API
      | skuName                    | skuId | order_id      | eta_date | payment_state | surfix |
      | random sku lp order 48 api | 0     | create by api | [blank]  | pending       | 2      |
    And Admin create purchase order of sub-invoice "create by api" suffix "2" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpwarehousing@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | -            | Auto store Florida | [blank]       | create by api | [blank] |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment | eta   | suffix |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 1 | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed | Plus9 | 1      |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 1 | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed | -     | 2      |
    And LP choose order to confirm
      | number        | suffix |
      | create by api | 1      |
      | create by api | 2      |
    And Check any text "is" showing on screen
      | 2 selected |
    And LP select all orders on list
    And Check any text "is" showing on screen
      | 0 selected |
    And Check button "Packing Slips" is disabled
    And Click on button "Select all"
    And Check any text "is" showing on screen
      | 2 selected |
    And Click on button "Unselect all"
    And Check any text "is" showing on screen
      | 0 selected |
    And Check button "Packing Slips" is disabled
    And LP choose order to confirm
      | number        | suffix |
      | create by api | 1      |
      | create by api | 2      |
    And Click on button "Packing Slips"

  @TC_51
  Scenario: Check system response when tap on the Confirm POs button
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order 51 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order 51 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order 51 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order 51 api" by api
    And Admin delete product name "random product lp order 51 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | random product lp order 51 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order 51 api" of product ""
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code                   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 51 api | random             | 5        | random sku lp order 51 api | 95           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | [blank] |
    And LP choose order to confirm
      | number        | suffix |
      | create by api | 1      |
    And Click on button "Confirm POs"
    And Check button "Confirm POs" is "disabled"
    And LP Pick Fulfillment date "currentDate" to confirm POs
    And Click on button "Confirm POs"
    And LP check alert message
      | Orders updated successfully. |
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po           |
      | Ordered, Latest first | -            | Auto store Florida | [blank]       | create by api | with suffix1 |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment | suffix |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 1 | 455 Madison Avenue, New York, Virginia, 10022 | In progress | 1      |
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po           |
      | Ordered, Latest first | Fulfilled    | Auto store Florida | [blank]       | create by api | with suffix1 |
    And Lp check no order found
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po           |
      | Ordered, Latest first | In progress  | Auto store Florida | [blank]       | create by api | with suffix1 |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment | suffix |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 1 | 455 Madison Avenue, New York, Virginia, 10022 | In progress | 1      |
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po           |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | with suffix1 |
    And Lp check no order found
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po           |
      | Ordered, Latest first | Fulfilled    | Auto store Florida | [blank]       | create by api | with suffix1 |
    And Lp check no order found
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po           |
      | Ordered, Latest first | In progress  | Auto store Florida | [blank]       | create by api | with suffix1 |
    And LP choose order to confirm
      | number        | suffix |
      | create by api | 1      |
    And Click on button "Confirm POs"
#    And LP "" Unselect above POs with number "create by api" suffix "1"
#    And Check any text "is" showing on screen
#      | 0 selected |
#    And Check button "Confirm POs" is disabled

    And LP go to order detail "create by api"
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Fulfilled   | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                        | sku                        | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 51 api | random sku lp order 51 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
    And LP check fulfilled date "currentDate" on order detail

  @TC_52 @LP_ORDER52
  Scenario: Check system response when tap on the Confirm POs button 2
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order 52 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order 52 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order 52 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order 52 api" by api
    And Admin delete product name "random product lp order 52 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | random product lp order 52 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order 52 api" of product ""
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code                   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 52 api | random             | 5        | random sku lp order 52 api | 95           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | [blank] |
    And LP choose order to confirm
      | number        | suffix |
      | create by api | 1      |
    And Click on button "Confirm POs"
    And Check button "Confirm POs" is "disabled"
    And LP Pick Fulfillment date "Plus1" to confirm POs
    And Click on button "Confirm POs"
    And USER_LP check alert message
      | Orders updated successfully. |
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po           |
      | Ordered, Latest first | -            | Auto store Florida | [blank]       | create by api | with suffix1 |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment | suffix |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 2 | 455 Madison Avenue, New York, Virginia, 10022 | In progress | 1      |
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po           |
      | Ordered, Latest first | Fulfilled    | Auto store Florida | [blank]       | create by api | with suffix1 |
    And USER_LP check no order found
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po           |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | with suffix1 |
    And USER_LP check no order found
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po           |
      | Ordered, Latest first | In progress  | Auto store Florida | [blank]       | create by api | with suffix1 |
    And Check order record on order page
      | ordered     | number        | store              | delivery               | route            | address                                       | fulfillment | suffix |
      | currentDate | create by api | Auto store Florida | Within 7 business days | Auto bao route 2 | 455 Madison Avenue, New York, Virginia, 10022 | In progress | 1      |
    And LP choose order to confirm
      | number        | suffix |
      | create by api | 1      |
    And Click on button "Confirm POs"

    And USER_LP clear filter on field "Pick Fulfillment date first"
    And USER_LP check error message is showing of fields
      | field                       | message                    |
      | Pick Fulfillment date first | This field cannot be blank |
    And LP Pick Fulfillment date "Plus2" to confirm POs
    And Click on button "Confirm POs"
    And USER_LP check alert message
      | Orders updated successfully. |
    And LP go to order detail "create by api"
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check dialog message
      | The entered fulfillment date is a future date. Please update it to a correct date before you upload a POD or mark it as fulfilled. |
    And Click on dialog button "Confirm"
    And LP set fulfillment date "currentDate"
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Fulfilled   | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 2 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                        | sku                        | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 52 api | random sku lp order 52 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
    And LP check fulfilled date "currentDate" on order detail

  @TC_57 @LP_ORDER57
  Scenario: Verify export Summary function
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order 57 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order 57 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order 57 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order 57 api" by api
    And Admin delete product name "random product lp order 57 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | random product lp order 57 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Chicago Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order 57 api" of product ""
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code                   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 57 api | random             | 5        | random sku lp order 57 api | 99           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |
#
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order   | po      |
      | Ordered, Latest first | Unconfirmed  | [blank] | [blank]       | [blank] | [blank] |
    And LP export summary order
    And LP check content file export summary
      | Order number | Order date | Qty | Store name          | Phone number | Address                                       | Delivery | Status      |
      | [blank]      | [blank]    | 1   | Auto Store Chicago1 | 1234567890   | 455 Madison Avenue, New York, Virginia, 10022 | [blank]  | Unconfirmed |
    And LP choose order to confirm
      | number        | suffix |
      | create by api | 1      |
    And Click on button "Confirm POs"
    And LP Pick Fulfillment date "Plus1" to confirm POs
    And Click on button "Confirm POs"
    And LP check alert message
      | Orders updated successfully. |
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order         | po      |
      | Ordered, Latest first | In progress  | [blank] | [blank]       | create by api | [blank] |
    And LP export summary order
    And LP check content file export summary
      | Order number | Order date | Qty | Store name          | Phone number | Address                                       | Delivery | Status      |
      | [blank]      | [blank]    | 1   | Auto Store Chicago1 | 1234567890   | 455 Madison Avenue, New York, Virginia, 10022 | [blank]  | In progress |
    And LP choose order to confirm
      | number        | suffix |
      | create by api | 1      |
    And Click on button "Confirm POs"
    And LP Pick Fulfillment date "currentDate" to confirm POs
    And Click on button "Confirm POs"
    And LP check alert message
      | Orders updated successfully. |
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order         | po      |
      | Ordered, Latest first | Fulfilled    | [blank] | [blank]       | create by api | [blank] |
    And LP export summary order
    And LP check content file export summary
      | Order number | Order date | Qty | Store name          | Phone number | Address                                       | Delivery | Status    |
      | [blank]      | [blank]    | 1   | Auto Store Chicago1 | 1234567890   | 455 Madison Avenue, New York, Virginia, 10022 | [blank]  | Fulfilled |

  @LP_ORDER_DETAILS_1
  Scenario: Check Order detail, Check print Packing slip function
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order 58 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order 58 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order 58 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order 58 api" by api
    And Admin delete product name "random product lp order 58 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | random product lp order 58 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order 58 api" of product ""
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code                   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 57 api | random             | 5        | random sku lp order 58 api | 95           | Plus1        | [blank]     | [blank] |
#    And Admin create line items attributes by API
#      | skuName                    | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | random sku lp order 58 api | create by api63    | create by api      | 1        | false     | [blank]          |
#    Item 2
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product lp order 58 api 2 | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order 58 api 2" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 57 api 2 | random             | 5        | random sku lp order 57 api | 95           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API
      | skuName                      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku lp order 58 api   | create by api63    | create by api      | 1        | false     | [blank]          |
      | random sku lp order 58 api 2 | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                          | sku                          | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 58 api 2 | random sku lp order 58 api 2 | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
      | Auto brand create product | random product lp order 58 api   | random sku lp order 58 api   | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
    And LP confirm order unconfirmed then verify status is "In progress"
    And LP set fulfillment order from admin with date "Plus1"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | In progress | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP set fulfillment order from admin with date "currentDate"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | In progress | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
#    And LP check fulfillment date "currentDate" on order detail

#    Check invoice
    And LP print "invoice"
    And LP verify info in Invoice
      | orderDate   | invoiceNumber | contact      | receivingTime | deliveryDate | department | deliverTo                                                                        | paymentMethod       | paymentTerm |
      | currentDate | [blank]       | 123-456-7890 | [blank]       | currentDate  | [blank]    | Auto Buyer62 - Auto store Florida, 455 Madison Avenue, New York, Virginia, 10022 | Payment via invoice | Net 30      |
    And LP verify items info in Invoice
      | storage | unitUPC       | pack | unitSize | description                                             | temp          | caseQty | casePrice | discount | bottleDeposit | total |
      | Dry     | 12312312312 3 | 1    | 1.0 g    | Auto brand create product, random sku lp order 58 api 2 | 1.0 F - 1.0 F | 1       | 10.00     | - 0.00   | 0.00          | 10.00 |
      | Dry     | 12312312312 3 | 1    | 1.0 g    | Auto brand create product, random sku lp order 58 api   | 1.0 F - 1.0 F | 1       | 10.00     | - 0.00   | 0.00          | 10.00 |
    And LP verify summary items info in Invoice
      | totalQuantity | discount   | tax      | totalPrice | subTotal  | bottleDeposit | promotionDiscount | invoiceTotal | smallOrderSurcharge | logisticSurcharge |
      | 2             | - USD 0.00 | USD 0.00 | USD 20.00  | USD 20.00 | USD 0.00      | - USD 0.00        | USD 50.00    | USD 30.00           | USD 20.00         |
#    And Close this window

  @LP_ORDER_DETAILS_2
  Scenario: Check print Packing slip function
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order 58 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order 58 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order 58 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order 58 api" by api
    And Admin delete product name "random product lp order 58 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | random product lp order 58 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order 58 api" of product ""
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code                   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 58 api | random             | 5        | random sku lp order 58 api | 95           | Plus1        | [blank]     | [blank] |
#    And Admin create line items attributes by API
#      | skuName                    | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | random sku lp order 57 api | create by api63    | create by api      | 1        | false     | [blank]          |
#    Item 2
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product lp order 58 api 2 | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order 58 api 2" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 58 api 2 | random             | 5        | random sku lp order 57 api | 95           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API
      | skuName                      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku lp order 58 api   | create by api63    | create by api      | 1        | false     | [blank]          |
      | random sku lp order 58 api 2 | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                          | sku                          | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order 58 api 2 | random sku lp order 58 api 2 | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
      | Auto brand create product | random product lp order 58 api   | random sku lp order 58 api   | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
    And LP confirm order unconfirmed then verify status is "In progress"
    And LP set fulfillment order from admin with date "Plus1"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | In progress | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP set fulfillment order from admin with date "currentDate"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | In progress | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP print "packing slips"
    And LP verify packing slip
      | store              | buyer        | address                                       | orderDate   | department | receiving             |
      | Auto store Florida | Auto Buyer62 | 455 Madison Avenue, New York, Virginia, 10022 | currentDate | [blank]    | Within 7 business day |
    And LP verify items on packing slip
      | brand                     | product                          | variant                      | unitUPC      | caseUPC      | caseUnit        | distributeCenter                                   | condition | quantity |
      | Auto brand create product | random product lp order 58 api 2 | random sku lp order 58 api 2 | 123123123123 | 123123123123 | 1 unit per case | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Dry       | 1        |
      | Auto brand create product | random product lp order 58 api   | random sku lp order 58 api   | 123123123123 | 123123123123 | 1 unit per case | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Dry       | 1        |

  @LP_ORDER_DETAILS_5
  Scenario: Check if a SKU in the block of SKU has no sufficient inventory is moved to other block or split into a separate block when it has any sufficient inventory level to confirm
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order detail 5 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                      | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order detail 5 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order detail 5 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order detail 5 api" by api
    And Admin delete product name "random product lp order detail 5 api" by api
    And Admin update store "2859" by API
      | field                        | value   |
      | store[receiving_note]        | auto    |
      | store[direct_receiving_note] | [blank] |
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product lp order detail 5 api 1 | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 5 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                | product_variant_id | quantity | lot_code                           | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order detail 5 api 1 | random             | 5        | random sku lp order detail 5 api 1 | 95           | Plus1        | [blank]     | [blank] |
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api63    | create by api      | 5        | false     | [blank]          |
#    Item 2 diffirece warehouse
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product lp order detail 5 api 2 | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 5 api 2" of product ""
    And Admin create inventory api1
      | index | sku                                | product_variant_id | quantity | lot_code                   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order detail 5 api 2 | random             | 5        | random sku lp order 57 api | 135          | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API
      | skuName                            | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku lp order detail 5 api 1 | create by api63    | create by api      | 5        | false     | [blank]          |
      | random sku lp order detail 5 api 2 | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |
#
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate | storeNote |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         | auto      |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
      | 455 Madison Avenue, New York, New York, 10022      | Auto distribute warehouse      |
    And LP check line items
      | brand                     | product                                | sku                                | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 5 api 2 | random sku lp order detail 5 api 2 | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
      | Auto brand create product | random product lp order detail 5 api 1 | random sku lp order detail 5 api 1 | 1 unit/case | Unit UPC / EAN: 123123123123 | 5        | true           | 1.0 F - 1.0 F1 day - Dry |

#    And LP edit LP note in order detail
#      | [blank] |
#    And LP check alert message
#      | Unconfirmed purchase orders can not be updated |
    And LP edit LP note in order detail
      | auto |
    And LP check alert message
      | Unconfirmed purchase orders can not be updated |
    And LP back to Orders
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate | storeNote |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         | auto      |
    And LP print "packing slips"
    And LP verify packing slip
      | store              | buyer        | address                                       | orderDate   | department | receiving             |
      | Auto store Florida | Auto Buyer62 | 455 Madison Avenue, New York, Virginia, 10022 | currentDate | [blank]    | Within 7 business day |
    And LP verify items on packing slip
      | brand                     | product                                | variant                            | unitUPC      | caseUPC      | caseUnit        | distributeCenter                                   | condition | quantity |
      | Auto brand create product | random product lp order detail 5 api 2 | random sku lp order detail 5 api 2 | 123123123123 | 123123123123 | 1 unit per case | 455 Madison Avenue, New York, New York, 10022      | Dry       | 1        |
      | Auto brand create product | random product lp order detail 5 api 1 | random sku lp order detail 5 api 1 | 123123123123 | 123123123123 | 1 unit per case | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Dry       | 5        |

    And Admin update store "2859" by API
      | field                        | value   |
      | store[receiving_note]        | [blank] |
      | store[direct_receiving_note] | [blank] |

  @LP_ORDER_DETAILS_11
  Scenario: Check system response when click on the Confirm button
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order detail 11 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order detail 11 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order detail 11 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order detail 11 api" by api
    And Admin delete product name "random product lp order detail 11 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product lp order detail 11 api 1 | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 11 api 1" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                            | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 57 api 1 | random             | 5        | random sku lp order detail 11 api 1 | 95           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |

    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 2 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                                 | sku                                 | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 11 api 1 | random sku lp order detail 11 api 1 | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

    # Paid order
    And Admin "fulfilled" all line item in order "create by api" by api
    Given NGOC_ADMIN_05 open web admin
    When NGOC_ADMIN_05 login to web with role Admin
    And NGOC_ADMIN_05 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store              | buyer        | statementMonth | region  | managedBy |
      | [blank]      | Auto store Florida | Auto Buyer62 | currentDate    | [blank] | [blank]   |
    And Admin go to detail of store statement "Auto store Florida"
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | 1       | 40            | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success

    And Switch to actor USER_LP
    And LP confirm order unconfirmed
    And LP check alert message
      | This order can't be edited because it has been locked or paid |

  @LP_ORDER_DETAILS_13
  Scenario: Verify details of In Progress PO
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order detail 13 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order detail 13 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order detail 13 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order detail 13 api" by api
    And Admin delete product name "random product lp order detail 13 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product lp order detail 13 api 1 | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 13 api 1" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                            | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order 57 api 1 | random             | 5        | random sku lp order detail 13 api 1 | 95           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |

    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | Unconfirmed  | Auto store Florida | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                                 | sku                                 | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 13 api 1 | random sku lp order detail 13 api 1 | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
    And LP confirm order unconfirmed
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP upload Proof of Delivery file
      | POD_Invalid.csv |
    And LP check alert message
      | Invalid file type |
    And LP upload Proof of Delivery file
      | 10MBgreater.jpg |
    And LP check alert message
      | Maximum file size exceeded. |
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Fulfilled   | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check pod uploaded
      | name                    | file    |
      | PoD_Auto_Bao_LP_Driver_ | POD.png |
    And LP upload Proof of Delivery file
      | POD_Invalid.csv |
    And LP check alert message
      | Invalid file type |
    And LP upload Proof of Delivery file
      | POD2.gif |
    And LP check alert message
      | Fulfillment details updated successfully. |
#    And LP check pod uploaded
#      | name                       | file     |
#      | PoD_Auto_Bao_LP_Driver_PO_ | POD2.gif |
    And LP "Cancel" remove files pod uploaded "POD.png"
    And LP "OK" remove files pod uploaded "POD.png"
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Fulfilled   | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check pod uploaded
      | name                    | file     |
      | PoD_Auto_Bao_LP_Driver_ | POD2.gif |
#      | PoD_Auto_Bao_LP_Driver_PO_ | POD.png  |
    And LP "OK" remove files pod uploaded "POD2.gif"
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Fulfilled   | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, Virginia, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |

  @LP_ORDER_DETAILS_17 @LP_ORDERS_61 @LP_ORDERS_76 @LP_ORDERS_78
  Scenario: Verify information in the POs details when this PO is assigned to LP with ONLY warehousing role
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order detail 17 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order detail 17 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order detail 17 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order detail 17 api" by api
    And Admin delete product name "random product lp order detail 17 api" by api
    And Admin set weekdays
      | weekday                |
      | within 7 business days |
    And Admin edit Route id "91"
      | name             | region_id | delivery_cost | case_pick_fee | within_7_business_day |
      | Auto bao route 1 | 63        | 0.0           | 0.0           | true                  |
    And Admin change route of store by api
      | storeID | routeID |
      | 2859    | 91      |
    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product lp order detail 17 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 17 api" of product ""
    And Admin create inventory api1
      | index | sku                               | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order detail 17 api | random             | 5        | random sku lp order detail 17 api | 95           | Plus1        | [blank]     | [blank] |

    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpwarehousing@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | -            | Auto store Florida | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                               | sku                               | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 17 api | random sku lp order detail 17 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
    And LP Check LP Note is disabled
    And Check any button "not" showing on screen
      | Confirm |
      | Invoice |

    Given USER_LP2 open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP2 Navigate to "Orders" by sidebar
    And USER_LP2 filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | -            | Auto store Florida | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP confirm order unconfirmed
    And LP check alert message
      | Fulfillment details updated successfully. |

    And Switch to actor USER_LP
    And LP back to Orders
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | In progress  | Auto store Florida | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | In progress | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                               | sku                               | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 17 api | random sku lp order detail 17 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
    And LP Check LP Note is disabled

    And Switch to actor USER_LP2
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Fulfilled   | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check pod uploaded
      | name                    | file    |
      | PoD_Auto_Bao_LP_Driver_ | POD.png |

    And Switch to actor USER_LP
    And LP back to Orders
    And USER_LP filter order by info
      | orderBy               | fulFillState | store              | fulFilledDate | order         | po      |
      | Ordered, Latest first | Fulfilled    | Auto store Florida | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store              | address                                       | department | receivingWeekday       | receivingTime | route            | adminNote | lpNote | fulfillmentDate |
      | currentDate | Fulfilled   | Auto Buyer62 | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | Auto bao route 1 | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName         |
      | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Bao distribute florida express |
    And LP check line items
      | brand                     | product                               | sku                               | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 17 api | random sku lp order detail 17 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
    And LP Check LP Note is disabled

    And LP print "packing slip"
    And LP verify packing slip
      | store              | buyer        | address                                       | orderDate   | department | receiving             |
      | Auto store Florida | Auto Buyer62 | 455 Madison Avenue, New York, New York, 10022 | currentDate | [blank]    | Within 7 business day |
    And LP verify items on packing slip
      | brand                     | product                               | variant                           | unitUPC      | caseUPC      | caseUnit        | distributeCenter                                   | condition | quantity |
      | Auto brand create product | random product lp order detail 17 api | random sku lp order detail 17 api | 123123123123 | 123123123123 | 1 unit per case | 5802 Trimble Park Road, Mount Dora, Florida, 32757 | Dry       | 1        |

  @LP_ORDER_DETAILS_20
  Scenario: Verify information in the POs details when this PO is assigned to LP with 2 roles at the same time
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order detail 20 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order detail 20 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order detail 20 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order detail 20 api" by api
    And Admin delete product name "random product lp order detail 20 api" by api
    And Admin set all possible delivery days of store "2582" by api
      | day                    |
      | within 7 business days |
    And Admin set all receiving weekday of store "2582" by api
      | day                    |
      | within 7 business days |

    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product lp order detail 20 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 20 api" of product ""
    And Admin create inventory api1
      | index | sku                               | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order detail 20 api | random             | 5        | random sku lp order detail 20 api | 99           | Plus1        | [blank]     | [blank] |

    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store               | fulFilledDate | order         | po      |
      | Ordered, Latest first | -            | Auto Store Chicago1 | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName        |
      | 1060 West Addison Street, Chicago, Illinois, 60613 | Auto Ngoc Distribution CHI 01 |
    And LP check line items
      | brand                     | product                               | sku                               | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 20 api | random sku lp order detail 20 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
#    And LP edit LP note in order detail
#      | [blank] |
#    And LP check alert message
#      | Unconfirmed purchase orders can not be updated |
    And LP edit LP note in order detail
      | auto |
    And LP check alert message
      | Unconfirmed purchase orders can not be updated |
    And LP confirm order unconfirmed
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | In progress | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP set fulfillment order from admin with date "Plus1"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | In progress | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP upload Proof of Delivery file
      | POD.png |
#    And LP check alert message
#      | Fulfillment details updated successfully. |
    And LP check dialog message
      | The entered fulfillment date is a future date. Please update it to a correct date before you upload a POD or mark it as fulfilled. |
    And Click on dialog button "Confirm"
    And LP set fulfillment date "currentDate"
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Fulfilled   | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP check pod uploaded
      | name                     | file    |
      | PoD_Auto_Ngoc_LP_Mix_01_ | POD.png |
    And LP check fulfilled date "currentDate" on order detail

    And LP print "invoice"
    And LP verify info in Invoice
      | orderDate   | invoiceNumber | contact      | receivingTime | deliveryDate | department | deliverTo                                                                         | paymentMethod       | paymentTerm |
      | currentDate | [blank]       | 123-456-7890 | [blank]       | currentDate  | [blank]    | Auto Buyer59 - Auto Store Chicago1, 455 Madison Avenue, New York, New York, 10022 | Payment via invoice | Net 30      |
    And LP verify items info in Invoice
      | storage | unitUPC       | pack | unitSize | description                                                  | temp          | caseQty | casePrice | discount | bottleDeposit | total |
      | Dry     | 12312312312 3 | 1    | 1.0 g    | Auto brand create product, random sku lp order detail 20 api | 1.0 F - 1.0 F | 1       | 10.00     | - 0.00   | 0.00          | 10.00 |
    And LP verify summary items info in Invoice
      | totalQuantity | discount   | tax      | totalPrice | subTotal  | bottleDeposit | promotionDiscount | invoiceTotal | smallOrderSurcharge | logisticSurcharge |
      | 1             | - USD 0.00 | USD 0.00 | USD 10.00  | USD 10.00 | USD 0.00      | - USD 0.00        | USD 40.00    | USD 30.00           | USD 20.00         |

  @LP_ORDER_DETAILS_23
  Scenario: Verify information in the POs details when this PO is assigned to LP with 2 roles at the same time Check print Packing slip function
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order detail 23 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order detail 23 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order detail 23 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order detail 23 api" by api
    And Admin delete product name "random product lp order detail 23 api" by api

    And Admin set all possible delivery days of store "2582" by api
      | day                    |
      | within 7 business days |
    And Admin set all receiving weekday of store "2582" by api
      | day                    |
      | within 7 business days |

    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product lp order detail 23 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 23 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                 | product_variant_id | quantity | lot_code                            | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order detail 23 api 1 | random             | 5        | random sku lp order detail 23 api 1 | 99           | Plus1        | [blank]     | [blank] |
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api26    | create by api      | 1        | false     | [blank]          |
#    Item 2
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product lp order detail 23 api 2 | 3018     |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 23 api 2" of product ""
    And Admin create inventory api1
      | index | sku                                 | product_variant_id | quantity | lot_code                            | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order detail 23 api 2 | random             | 5        | random sku lp order detail 23 api 2 | 90           | Plus1        | [blank]     | [blank] |

    And Admin create line items attributes by API
      | skuName                             | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku lp order detail 23 api 1 | create by api26    | create by api      | 1        | false     | [blank]          |
      | random sku lp order detail 23 api 2 | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store               | fulFilledDate | order         | po      |
      | Ordered, Latest first | -            | Auto Store Chicago1 | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName        |
      | 32 Chicago Road, Chicago Heights, Illinois, 60411  | Auto Ngoc Distribution CHI    |
      | 1060 West Addison Street, Chicago, Illinois, 60613 | Auto Ngoc Distribution CHI 01 |
    And LP check line items
      | brand                     | product                                 | sku                                 | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 23 api 2 | random sku lp order detail 23 api 2 | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
      | Auto brand create product | random product lp order detail 23 api 1 | random sku lp order detail 23 api 1 | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

    And LP print "packing slips"
    And LP verify packing slip
      | store               | buyer        | address                                       | orderDate   | department | receiving             |
      | Auto Store Chicago1 | Auto Buyer59 | 455 Madison Avenue, New York, New York, 10022 | currentDate | [blank]    | Within 7 business day |
    And LP verify items on packing slip
      | brand                     | product                                 | variant                             | unitUPC      | caseUPC      | caseUnit        | distributeCenter                                   | condition | quantity |
      | Auto brand create product | random product lp order detail 23 api 2 | random sku lp order detail 23 api 2 | 123123123123 | 123123123123 | 1 unit per case | 32 Chicago Road, Chicago Heights, Illinois, 60411  | Dry       | 1        |
      | Auto brand create product | random product lp order detail 23 api 1 | random sku lp order detail 23 api 1 | 123123123123 | 123123123123 | 1 unit per case | 1060 West Addison Street, Chicago, Illinois, 60613 | Dry       | 1        |

  @LP_ORDER_DETAILS_30
  Scenario: Verify information in the POs details when this PO is assigned to LP with 2 roles at the same time Check system response when click on the Confirm button
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order detail 30 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order detail 30 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order detail 30 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order detail 30 api" by api
    And Admin delete product name "random product lp order detail 30 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product lp order detail 30 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 30 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                 | product_variant_id | quantity | lot_code                            | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order detail 30 api 1 | random             | 5        | random sku lp order detail 30 api 1 | 99           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |

    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store               | fulFilledDate | order         | po      |
      | Ordered, Latest first | Unconfirmed  | Auto Store Chicago1 | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName        |
      | 1060 West Addison Street, Chicago, Illinois, 60613 | Auto Ngoc Distribution CHI 01 |
    And LP check line items
      | brand                     | product                                 | sku                                 | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 30 api 1 | random sku lp order detail 30 api 1 | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

    # Paid order
    And Admin "fulfilled" all line item in order "create by api" by api
    Given NGOC_ADMIN_05 open web admin
    When NGOC_ADMIN_05 login to web with role Admin
    And NGOC_ADMIN_05 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store               | buyer        | statementMonth | region  | managedBy |
      | [blank]      | Auto Store Chicago1 | Auto Buyer59 | currentDate    | [blank] | [blank]   |
    And Admin go to detail of store statement "Auto Store Chicago1"
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | 1       | 40            | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success

    And Switch to actor USER_LP
    And LP confirm order unconfirmed
    And LP check alert message
      | This order can't be edited because it has been locked or paid |

  @LP_ORDER_DETAILS_36
  Scenario: Verify information in the POs details when this PO is assigned to LP with 2 roles at the same time Verify LP can NOT upload POD for paid POD
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order detail 33 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order detail 33 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order detail 33 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order detail 33 api" by api
    And Admin delete product name "random product lp order detail 33 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product lp order detail 33 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 33 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                 | product_variant_id | quantity | lot_code                            | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order detail 33 api 1 | random             | 5        | random sku lp order detail 33 api 1 | 99           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |

    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store               | fulFilledDate | order         | po      |
      | Ordered, Latest first | Unconfirmed  | Auto Store Chicago1 | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName        |
      | 1060 West Addison Street, Chicago, Illinois, 60613 | Auto Ngoc Distribution CHI 01 |
    And LP check line items
      | brand                     | product                                 | sku                                 | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 33 api 1 | random sku lp order detail 33 api 1 | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
    And LP confirm order unconfirmed
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | In progress | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |

    # Paid order
    And Admin "fulfilled" all line item in order "create by api" by api
    Given NGOC_ADMIN_05 open web admin
    When NGOC_ADMIN_05 login to web with role Admin
    And NGOC_ADMIN_05 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store               | buyer        | statementMonth | region  | managedBy |
      | [blank]      | Auto Store Chicago1 | Auto Buyer59 | currentDate    | [blank] | [blank]   |
    And Admin go to detail of store statement "Auto Store Chicago1"
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | 1       | 40            | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success

    And Switch to actor USER_LP
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Fulfilled   | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP check pod uploaded
      | name                     | file    |
      | PoD_Auto_Ngoc_LP_Mix_01_ | POD.png |
#    And LP check alert message
#      | This order can't be edited because it has been locked or paid |

  @LP_ORDERS_96 @LP_ORDERS_143
  Scenario: Verify information in the drop-POs details when this drop-PO is assigned to - LP with ONLY driver role
    Given BAO_ADMIN15 login web admin by api
      | email             | password  |
      | bao15@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order detail 96 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order detail 96 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order detail 96 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order detail 96 api" by api
    And Admin delete product name "random product lp order detail 96 api" by api
    And Admin set all possible delivery days of store "2582" by api
      | day                    |
      | within 7 business days |
    And Admin set all receiving weekday of store "2582" by api
      | day                    |
      | within 7 business days |

    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product lp order detail 96 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 96 api" of product ""
    And Admin create inventory api1
      | index | sku                               | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order detail 96 api | random             | 5        | random sku lp order detail 96 api | 99           | Plus1        | [blank]     | [blank] |

    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |
    And Admin save order number by index "1"

    Given BAO_ADMIN15 open web admin
    When login to beta web with email "bao15@podfoods.co" pass "12345678a" role "Admin"
    And BAO_ADMIN15 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
    And Admin create drop in drop summary
    And Admin create PO in create drop popup
      | store               | driver             | fulfillmentDate | fulfillmentState | pod     | adminNote  | lpNote  |
      | Auto Store Chicago1 | Auto Bao LP Driver | [blank]         | [blank]          | [blank] | Admin Note | LP Note |
    And Admin create drop with had PO in create drop popup
    And Admin get number of drop in drop summary
      | index | store               |
      | 1     | Auto Store Chicago1 |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy | fulFillState | store   | fulFilledDate | order         | po      |
      | [blank] | [blank]      | [blank] | [blank]       | create by api | [blank] |
    And Check order record on order page
      | ordered     | number            | store               | delivery               | route   | address                                       | fulfillment |
      | currentDate | admin create drop | Auto Store Chicago1 | Within 7 business days | [blank] | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP clear search all filters
    And USER_LP filter order by info
      | orderBy | fulFillState | store               | fulFilledDate | order             | po      |
      | [blank] | [blank]      | Auto Store Chicago1 | [blank]       | admin create drop | [blank] |
    And Check order record on order page
      | ordered     | number            | store               | delivery               | route   | address                                       | fulfillment |
      | currentDate | admin create drop | Auto Store Chicago1 | Within 7 business days | [blank] | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "admin create drop store Auto Store Chicago1"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote  | lpNote  | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | Admin Note | LP Note | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName        |
      | 1060 West Addison Street, Chicago, Illinois, 60613 | Auto Ngoc Distribution CHI 01 |
    And LP check line items
      | brand                     | product                               | sku                               | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 96 api | random sku lp order detail 96 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
    And LP confirm order unconfirmed
    And LP check alert message
      | Fulfillment details updated successfully |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote  | lpNote  | fulfillmentDate |
      | currentDate | In progress | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | Admin Note | LP Note | [blank]         |
    And LP set fulfillment date "Plus1"
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check dialog message
      | The entered fulfillment date is a future date. Please update it to a correct date before you upload a POD or mark it as fulfilled. |
    And Click on dialog button "Confirm"
    And LP set fulfillment date "currentDate"
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote  | lpNote  | fulfillmentDate |
      | currentDate | Fulfilled   | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | Admin Note | LP Note | [blank]         |
    And LP check pod uploaded
      | name                    | file    |
      | PoD_Auto_Bao_LP_Driver_ | POD.png |
    And LP print "packing slips"
    And LP verify packing slip
      | store               | address                                       | receiving             | number            |
      | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | Within 7 business day | admin create drop |
    And LP verify items on packing slip
      | brand                     | product                               | variant                           | unitUPC      | caseUPC      | caseUnit        | distributeCenter                                   | condition | quantity |
      | Auto brand create product | random product lp order detail 96 api | random sku lp order detail 96 api | 123123123123 | 123123123123 | 1 unit per case | 1060 West Addison Street, Chicago, Illinois, 60613 | Dry       | 1        |
    And Switch to default tab
    And Switch to tab by title "#"
    And LP print "invoice"
    And LP verify info in Invoice
      | invoiceNumber  | contact      | deliveryDate | deliverTo                                                                         | paymentMethod       | paymentTerm | effective                                                                       |
      | subInvoice api | 123-456-7890 | currentDate  | Auto Buyer59 - Auto Store Chicago1, 455 Madison Avenue, New York, New York, 10022 | Payment via invoice | Net 30      | Effective 12/1/22, all stores must reach an order minimum of $500 for delivery. |
    And LP verify items info in Invoice
      | storage | unitUPC       | pack | unitSize | description                                                  | temp          | caseQty | casePrice | discount | bottleDeposit | total |
      | Dry     | 12312312312 3 | 1    | 1.0 g    | Auto brand create product, random sku lp order detail 96 api | 1.0 F - 1.0 F | 1       | 10.00     | - 0.00   | 0.00          | 10.00 |
    And LP verify summary items info in Invoice
      | totalQuantity | discount   | tax      | totalPrice | subTotal  | bottleDeposit | promotionDiscount | invoiceTotal | smallOrderSurcharge | logisticSurcharge |
      | 1             | - USD 0.00 | USD 0.00 | USD 10.00  | USD 10.00 | USD 0.00      | - USD 0.00        | USD 40.00    | USD 30.00           | USD 0.00          |

  @LP_ORDERS_99
  Scenario: Verify information in the drop-POs details when this drop-PO is assigned to - LP with 2 roles
    Given BAO_ADMIN16 login web admin by api
      | email             | password  |
      | bao16@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order detail 96 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order detail 96 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order detail 96 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order detail 96 api" by api
    And Admin delete product name "random product lp order detail 96 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product lp order detail 96 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 96 api" of product ""
    And Admin create inventory api1
      | index | sku                               | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order detail 96 api | random             | 5        | random sku lp order detail 96 api | 81           | Plus1        | [blank]     | [blank] |

    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 100                  |
    And Admin save order number by index "1"

    Given BAO_ADMIN16 open web admin
    When login to beta web with email "bao15@podfoods.co" pass "12345678a" role "Admin"
    And BAO_ADMIN16 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
    And Admin create drop in drop summary
    And Admin create PO in create drop popup
      | store               | driver                   | fulfillmentDate | fulfillmentState | pod     | adminNote  | lpNote  |
      | Auto Store Chicago1 | Auto Bao LP company mix1 | [blank]         | [blank]          | [blank] | Admin Note | LP Note |
    And Admin create drop with had PO in create drop popup
    And Admin get number of drop in drop summary
      | index | store               |
      | 1     | Auto Store Chicago1 |

    Given USER_LP open web LP
    When login to beta web with email "bao@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy | fulFillState | store               | fulFilledDate | order             | po      |
      | [blank] | [blank]      | Auto Store Chicago1 | [blank]       | admin create drop | [blank] |
    And Check order record on order page
      | ordered     | number            | store               | delivery               | route   | address                                       | fulfillment |
      | currentDate | admin create drop | Auto Store Chicago1 | Within 7 business days | [blank] | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
      # Delete subinvoice in drop
    And Switch to actor BAO_ADMIN16
    And Admin delete subinvoice in drop
      | index | orderNumber   | sub |
      | 1     | create by api | 1   |

    And Switch to actor USER_LP
    And LP clear search all filters
    And USER_LP filter order by info
      | orderBy | fulFillState | store               | fulFilledDate | order             | po      |
      | [blank] | [blank]      | Auto Store Chicago1 | [blank]       | admin create drop | [blank] |
    And USER_LP check no order found
    And USER_LP filter order by info
      | orderBy | fulFillState | store   | fulFilledDate | order         | po      |
      | [blank] | [blank]      | [blank] | [blank]       | create by api | [blank] |
    And Check order record on order page
      | ordered     | number        | suffix | store               | delivery               | route   | address                                       | fulfillment |
      | currentDate | create by api | 1      | Auto Store Chicago1 | Within 7 business days | [blank] | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote  | lpNote  | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | Admin Note | LP Note | [blank]         |
    And LP check Distribution
      | distributionCenter                                  | distributionCenterName |
      | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | Bao Distribution CHI   |
    And LP check line items
      | brand                     | product                               | sku                               | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 96 api | random sku lp order detail 96 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

    And Switch to actor BAO_ADMIN16
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
    And Admin create drop in drop summary
    And Admin create PO in create drop popup
      | store               | driver                   | fulfillmentDate | fulfillmentState | pod     | adminNote  | lpNote  |
      | Auto Store Chicago1 | Auto Bao LP company mix1 | [blank]         | [blank]          | [blank] | Admin Note | LP Note |

    And Admin create drop with had PO in create drop popup
    And Admin get number of drop in drop summary
      | index | store               |
      | 1     | Auto Store Chicago1 |
    And Switch to actor USER_LP
    And USER_LP refresh browser
    And USER_LP check page missing
    And USER_LP go back by browser
    And LP go to order detail "admin create drop store Auto Store Chicago1"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote  | lpNote  | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | Admin Note | LP Note | [blank]         |
    And LP check Distribution
      | distributionCenter                                  | distributionCenterName |
      | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | Bao Distribution CHI   |
    And LP check line items
      | brand                     | product                               | sku                               | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 96 api | random sku lp order detail 96 api | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

  @LP_ORDERS_107
  Scenario: Verify information in the drop-POs details when this drop-PO has multiple sub-PO
    Given BAO_ADMIN17 login web admin by api
      | email             | password  |
      | bao17@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order detail 107 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order detail 107 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order detail 107 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order detail 107 api" by api
    And Admin delete product name "random product lp order detail 107 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product lp order detail 107 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 107 api" of product ""
    And Admin create inventory api1
      | index | sku                                | product_variant_id | quantity | lot_code                           | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order detail 107 api | random             | 5        | random sku lp order detail 107 api | 81           | Plus1        | [blank]     | [blank] |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 107 api 2" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code                             | warehouse_id | receive_date | expiry_date | comment |
      | 2     | random sku lp order detail 107 api 2 | random             | 5        | random sku lp order detail 107 api 2 | 81           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API
      | skuName                              | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku lp order detail 107 api   | create by api26    | create by api      | 1        | false     | [blank]          |
      | random sku lp order detail 107 api 2 | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin set Invoice by API
      | skuName                            | skuId | order_id      | eta_date | payment_state | surfix |
      | random sku lp order detail 107 api | 0     | create by api | [blank]  | pending       | 1      |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 100                  |
    And Admin save order number by index "1"

    And Admin set Invoice by API
      | skuName                              | skuId | order_id      | eta_date | payment_state | surfix |
      | random sku lp order detail 107 api 2 | 0     | create by api | [blank]  | pending       | 2      |
    And Admin create purchase order of sub-invoice "create by api" suffix "2" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 100                  |
    Given USER_LP open web LP
    When login to beta web with email "bao@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy | fulFillState | store   | fulFilledDate | order         | po      |
      | [blank] | [blank]      | [blank] | [blank]       | create by api | [blank] |
    And Check order record on order page
      | suffix | ordered     | number        | store               | delivery               | eta     | route   | address                                       | fulfillment |
      | 1      | currentDate | create by api | Auto Store Chicago1 | Within 7 business days | Plus9   | [blank] | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
      | 2      | currentDate | create by api | Auto Store Chicago1 | Within 7 business days | [blank] | [blank] | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |

#    Create drop
    Given BAO_ADMIN17 open web admin
    When login to beta web with email "bao15@podfoods.co" pass "12345678a" role "Admin"
    And BAO_ADMIN17 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
      | 1     | create by api | 2          |
    And Admin create drop in drop summary
    And Admin create PO in create drop popup
      | store               | driver                   | fulfillmentDate | fulfillmentState | pod     | adminNote  | lpNote  |
      | Auto Store Chicago1 | Auto Bao LP company mix1 | [blank]         | [blank]          | [blank] | Admin Note | LP Note |
    And Admin create drop with had PO in create drop popup
    And Admin get number of drop in drop summary
      | index | store               |
      | 1     | Auto Store Chicago1 |

    And Switch to actor USER_LP
    And LP clear search all filters
    And USER_LP filter order by info
      | orderBy | fulFillState | store   | fulFilledDate | order         | po      |
      | [blank] | [blank]      | [blank] | [blank]       | create by api | [blank] |
    And Check order record on order page
      | ordered     | number            | store               | delivery               | eta   | route   | address                                       | fulfillment |
      | currentDate | admin create drop | Auto Store Chicago1 | Within 7 business days | Plus9 | [blank] | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "admin create drop store Auto Store Chicago1"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote  | lpNote  | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | Admin Note | LP Note | [blank]         |
    And LP check Distribution
      | distributionCenter                                  | distributionCenterName |
      | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | Bao Distribution CHI   |
    And LP check line items
      | brand                     | product                                | sku                                  | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 107 api | random sku lp order detail 107 api   | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
      | Auto brand create product | random product lp order detail 107 api | random sku lp order detail 107 api 2 | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |

#  Update PO -> Inprogress
    And Admin update purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | Plus1            | in_progress       | adminNote  | lpNote                 | [blank]                        | 100                  |

    And Switch to actor USER_LP
    And USER_LP refresh page
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    #  Update PO -> Inprogress
    And Admin update purchase order of sub-invoice "create by api" suffix "2" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | Plus1            | in_progress       | adminNote  | lpNote                 | [blank]                        | 100                  |
    And Switch to actor USER_LP
    And USER_LP refresh page
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | In progress | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
#  Update PO -> Fulfilled
    And Admin update purchase order of sub-invoice "create by api" suffix "2" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | currentDate      | fulfilled         | adminNote  | lpNote                 | [blank]                        | 100                  |
    And Switch to actor USER_LP
    And USER_LP refresh page
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | In progress | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
#  Update PO -> Unconfirmed
    And Admin update purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 100                  |
    And Switch to actor USER_LP
    And USER_LP refresh page
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
#  Update PO -> fulfilled
    And Admin update purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | currentDate      | fulfilled         | adminNote  | lpNote                 | [blank]                        | 100                  |
    And Switch to actor USER_LP
    And USER_LP refresh page
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Fulfilled   | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |

  @LP_ORDERS_154
  Scenario: Verify information in the drop-POs details when this drop-PO is assigned to LP - Edit info
    Given BAO_ADMIN18 login web admin by api
      | email             | password  |
      | bao18@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order detail 154 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order detail 154 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order detail 154 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order detail 154 api" by api
    And Admin delete product name "random product lp order detail 154 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product lp order detail 154 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 154 api" of product ""
    And Admin create inventory api1
      | index | sku                                | product_variant_id | quantity | lot_code                           | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order detail 154 api | random             | 5        | random sku lp order detail 154 api | 99           | Plus1        | [blank]     | [blank] |

    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |
    And Admin save order number by index "1"

    Given BAO_ADMIN18 open web admin
    When login to beta web with email "bao18@podfoods.co" pass "12345678a" role "Admin"
    And BAO_ADMIN18 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
    And Admin create drop in drop summary
    And Admin create PO in create drop popup
      | store               | driver             | fulfillmentDate | fulfillmentState | pod     | adminNote  | lpNote  |
      | Auto Store Chicago1 | Auto Bao LP Driver | [blank]         | [blank]          | [blank] | Admin Note | LP Note |
    And Admin create drop with had PO in create drop popup
    And Admin get number of drop in drop summary
      | index | store               |
      | 1     | Auto Store Chicago1 |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy | fulFillState | store               | fulFilledDate | order             | po      |
      | [blank] | [blank]      | Auto Store Chicago1 | [blank]       | admin create drop | [blank] |
    And Check order record on order page
      | ordered     | number            | store               | delivery               | route   | address                                       | fulfillment |
      | currentDate | admin create drop | Auto Store Chicago1 | Within 7 business days | [blank] | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
    And LP go to order detail "admin create drop store Auto Store Chicago1"
    And LP edit LP note in order detail
      | auto |
    And LP check alert message
      | Unconfirmed purchase orders can not be updated |
    And LP confirm order unconfirmed
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP edit LP note in order detail
      | auto |
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote  | lpNote | fulfillmentDate |
      | currentDate | In progress | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | Admin Note | auto   | [blank]         |
    And LP set fulfillment order from admin with date "Plus1"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote  | lpNote | fulfillmentDate |
      | currentDate | In progress | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | Admin Note | auto   | Plus1           |
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check dialog message
      | The entered fulfillment date is a future date. Please update it to a correct date before you upload a POD or mark it as fulfilled. |
    And Click on dialog button "Confirm"
    And LP set fulfillment order from admin with date "currentDate"
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote  | lpNote | fulfillmentDate |
      | currentDate | Fulfilled   | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | Admin Note | auto   | [blank]         |
    And LP check fulfilled date "currentDate" on order detail
    And LP check pod uploaded
      | name                    | file    |
      | PoD_Auto_Bao_LP_Driver_ | POD.png |

  @LP_ORDERS_155
  Scenario: Check Driver LP can upload a drop-POD for paid/locked sub-invoices
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp11@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy | fulFillState | store   | fulFilledDate | order       | po      |
      | [blank] | [blank]      | [blank] | [blank]       | 23112348778 | [blank] |
    And Check order record on order page
      | ordered  | number       | store             | delivery  | route   | address                                         | fulfillment |
      | 11/23/23 | 231123487781 | ngoctx stOrder106 | Every Mon | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | Fulfilled   |
    And LP go to order detail "231123487781"
    And LP verify information of order detail
      | orderDate | fulfillment | buyer                  | store             | address                                         | department | receivingWeekday | receivingTime             | route        | adminNote | lpNote | storeNote    | fulfillmentDate |
      | 11/23/23  | Fulfilled   | ngoctx storder106chi01 | ngoctx stOrder106 | 1544 West 18th Street, Chicago, Illinois, 60608 | [blank]    | Every Mon        | 12:30 am - 01:00 am (PST) | Auto Route 2 | adminNote | auto   | Express Note | [blank]         |
    And LP edit LP note in order detail
      | lpAuto |
    And LP check alert message
      | This order can't be edited because it has been locked or paid |

  @LP_ORDERS_163
  Scenario:  Verify information shown on Invoice and Packing slip of PO - Sub-PO invoice:
    Given BAO_ADMIN18 login web admin by api
      | email             | password  |
      | bao18@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp order detail 154 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp order detail 154 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp order detail 154 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp order detail 154 api" by api
    And Admin delete product name "random product lp order detail 154 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product lp order detail 154 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 154 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code                             | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp order detail 154 api 1 | random             | 5        | random sku lp order detail 154 api 1 | 99           | Plus1        | [blank]     | [blank] |
    And Admin create a "active" SKU from admin with name "random sku lp order detail 154 api 2" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code                             | warehouse_id | receive_date | expiry_date | comment |
      | 2     | random sku lp order detail 154 api 2 | random             | 5        | random sku lp order detail 154 api 2 | 99           | Plus1        | [blank]     | [blank] |
    And Admin create line items attributes by API
      | skuName                              | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku lp order detail 154 api 1 | create by api26    | create by api      | 1        | false     | [blank]          |
      | random sku lp order detail 154 api 2 | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin save order number by index "1"
    # Set invoice
    And Admin set Invoice by API
      | skuName                              | skuId | order_id      | eta_date | payment_state | surfix |
      | random sku lp order detail 154 api 1 | 0     | create by api | [blank]  | pending       | 1      |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp11@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy | fulFillState | store   | fulFilledDate | order         | po           |
      | [blank] | [blank]      | [blank] | [blank]       | create by api | with suffix2 |
    And USER_LP check no order found
    And LP clear search all filters

#    Set PO
    And Admin set Invoice by API
      | skuName                              | skuId | order_id      | eta_date | payment_state | surfix |
      | random sku lp order detail 154 api 2 | 0     | create by api | [blank]  | pending       | 2      |
    And Admin create purchase order of sub-invoice "create by api" suffix "2" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |

    And USER_LP filter order by info
      | orderBy | fulFillState | store   | fulFilledDate | order         | po      |
      | [blank] | [blank]      | [blank] | [blank]       | create by api | [blank] |
    And Check order record on order page
      | suffix | ordered     | number        | store               | delivery               | eta     | route   | address                                       | fulfillment |
      | 1      | currentDate | create by api | Auto Store Chicago1 | Within 7 business days | Plus9   | [blank] | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |
      | 2      | currentDate | create by api | Auto Store Chicago1 | Within 7 business days | [blank] | [blank] | 455 Madison Avenue, New York, New York, 10022 | Unconfirmed |

    And LP go to order detail "create by api"
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Unconfirmed | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP check Distribution
      | distributionCenter                                 | distributionCenterName        |
      | 1060 West Addison Street, Chicago, Illinois, 60613 | Auto Ngoc Distribution CHI 01 |
    And LP check line items
      | brand                     | product                                | sku                                  | pack        | unitUPC                      | quantity | podConsignment | storageCondition         |
      | Auto brand create product | random product lp order detail 154 api | random sku lp order detail 154 api 2 | 1 unit/case | Unit UPC / EAN: 123123123123 | 1        | true           | 1.0 F - 1.0 F1 day - Dry |
    And LP confirm order unconfirmed
#    And USER_LP check alert message
#      | Fulfillment details updated successfully. |
    And LP set fulfillment date "Plus1"
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | In progress | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check dialog message
      | The entered fulfillment date is a future date. Please update it to a correct date before you upload a POD or mark it as fulfilled. |
    And Click on dialog button "Confirm"
    And LP set fulfillment date "currentDate"
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer        | store               | address                                       | department | receivingWeekday       | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | Fulfilled   | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | [blank]    | Within 7 business days | [blank]       | [blank] | adminNote | lpNote | [blank]         |
    And LP check pod uploaded
      | name                     | file    |
      | PoD_Auto_Ngoc_LP_Mix_01_ | POD.png |
    And LP print "packing slips"
    And LP verify packing slip
      | store               | address                                       | receiving             | number        |
      | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | Within 7 business day | create by api |
    And LP verify items on packing slip
      | brand                     | product                                | variant                              | unitUPC      | caseUPC      | caseUnit        | distributeCenter                                   | condition | quantity |
      | Auto brand create product | random product lp order detail 154 api | random sku lp order detail 154 api 2 | 123123123123 | 123123123123 | 1 unit per case | 1060 West Addison Street, Chicago, Illinois, 60613 | Dry       | 1        |
    And Switch to default tab
    And Switch to tab by title "#"
      And LP print "invoice"
    And LP verify info in Invoice
      | invoiceNumber  | contact      | deliveryDate | deliverTo                                                                         | paymentMethod       | paymentTerm | effective                                                                       |
      | subInvoice api | 123-456-7890 | currentDate  | Auto Buyer59 - Auto Store Chicago1, 455 Madison Avenue, New York, New York, 10022 | Payment via invoice | Net 30      | Effective 12/1/22, all stores must reach an order minimum of $500 for delivery. |
    And LP verify items info in Invoice
      | storage | unitUPC       | pack | unitSize | description                                                     | temp          | caseQty | casePrice | discount | bottleDeposit | total |
      | Dry     | 12312312312 3 | 1    | 1.0 g    | Auto brand create product, random sku lp order detail 154 api 2 | 1.0 F - 1.0 F | 1       | 10.00     | - 0.00   | 0.00          | 10.00 |
    And LP verify summary items info in Invoice
      | totalQuantity | discount   | tax      | totalPrice | subTotal  | bottleDeposit | promotionDiscount | invoiceTotal |
      | 1             | - USD 0.00 | USD 0.00 | USD 10.00  | USD 10.00 | USD 0.00      | - USD 0.00        | USD 10.00    |

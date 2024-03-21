@feature=vendorInventory
Feature: Vendor Inventory

  @V_INVENTORY_1
  Scenario: Check information shown on the page
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]               | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor inventory" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "auto product vendor inventory" by api
    And Admin delete product name "auto product vendor inventory" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | auto product vendor inventory | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor inventory" of product ""
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code                      | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor inventory | random             | 5        | auto lot sku vendor inventory | 99           | Plus1        | Plus1       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor65@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Check any text "is" showing on screen
      | This is the inventory you have consigned in Pod Foods distribution centers. |
      | Received quantity                                                           |
      | Total inventory that has arrived on consignment.                            |
      | Current quantity                                                            |
      | Total inventory currently physically on hand at distribution center.        |
      | End quantity                                                                |
      | Quantity left once all pending orders have been fulfilled.                  |
      | Pulled quantity                                                             |
      | Quantity pulled when it can no longer be sent to retail.                    |
    And Vendor go to "Inventory Status" tab
    And Check any text "is" showing on screen
#      | Inventory Status                                                                                                                       |
      | Green                                                                                                                                  |
      | You have sufficient amount of inventory at Pod Foods distribution center.                                                              |
      | Orange                                                                                                                                 |
      | This inventory is running low. Please get in touch with our team to send more inventory to the distribution center.                    |
      | Red                                                                                                                                    |
      | Insufficient inventory to fulfill pending orders. Please get in touch with our team to send more inventory to the distribution center. |
    And Vendor go to "Send Inventory" tab
    And Vendor go to "Withdraw Inventory" tab
    And Vendor go to "Dispose / Donate Inventory" tab

  @V_INVENTORY_4
  Scenario: Verify Search and Filter
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]               | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor inventory" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "auto product vendor inventory" by api
    And Admin delete product name "auto product vendor inventory" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor inventory4 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor inventory41" of product ""
    And Admin create inventory api1
      | index | sku                         | product_variant_id | quantity | lot_code                        | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor inventory41 | random             | 5        | auto lot sku vendor inventory41 | 99           | currentDate  | Plus1       | [blank] |
    And Clear Info of Region api
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor inventory42" of product ""
    And Admin create inventory api1
      | index | sku                         | product_variant_id | quantity | lot_code                        | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor inventory42 | random             | 10       | auto lot sku vendor inventory42 | 95           | Minus1       | currentDate | [blank] |
    And Info of Region
      | region           | id | state  | availability | casePrice | msrp |
      | New York Express | 53 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor inventory43" of product ""
    And Admin create inventory api1
      | index | sku                         | product_variant_id | quantity | lot_code                        | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor inventory43 | random             | 15       | auto lot sku vendor inventory43 | 91           | Plus2        | Plus3       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor65@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search Inventory on region "All regions"
      | skuName                    | zeroQuantity | orderBy                 |
      | auto sku vendor inventory4 | No           | Received - Latest first |
    And Vendor verify search inventory results
      | productName                    | skuName                     | lotCode                         | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate  | pullDate |
      | auto product vendor inventory4 | auto sku vendor inventory43 | auto lot sku vendor inventory43 | NY     | 15          | Plus2       | 15         | 0         | 15     | Plus3       | Minus52  |
      | auto product vendor inventory4 | auto sku vendor inventory41 | auto lot sku vendor inventory41 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1       | Minus54  |
      | auto product vendor inventory4 | auto sku vendor inventory42 | auto lot sku vendor inventory42 | FL     | 10          | Minus1      | 10         | 0         | 10     | currentDate | Minus55  |
    And Vendor search Inventory on region "All regions"
      | skuName                    | zeroQuantity | orderBy                   |
      | auto sku vendor inventory4 | No           | Received - Earliest first |
    And Vendor verify search inventory results
      | productName                    | skuName                     | lotCode                         | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate  | pullDate |
      | auto product vendor inventory4 | auto sku vendor inventory42 | auto lot sku vendor inventory42 | FL     | 10          | Minus1      | 10         | 0         | 10     | currentDate | Minus55  |
      | auto product vendor inventory4 | auto sku vendor inventory41 | auto lot sku vendor inventory41 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1       | Minus54  |
      | auto product vendor inventory4 | auto sku vendor inventory43 | auto lot sku vendor inventory43 | NY     | 15          | Plus2       | 15         | 0         | 15     | Plus3       | Minus52  |
    And Vendor search Inventory on region "All regions"
      | skuName                    | zeroQuantity | orderBy                      |
      | auto sku vendor inventory4 | No           | Received Qty - Highest first |
    And Vendor verify search inventory results
      | productName                    | skuName                     | lotCode                         | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate  | pullDate |
      | auto product vendor inventory4 | auto sku vendor inventory43 | auto lot sku vendor inventory43 | NY     | 15          | Plus2       | 15         | 0         | 15     | Plus3       | Minus52  |
      | auto product vendor inventory4 | auto sku vendor inventory42 | auto lot sku vendor inventory42 | FL     | 10          | Minus1      | 10         | 0         | 10     | currentDate | Minus55  |
      | auto product vendor inventory4 | auto sku vendor inventory41 | auto lot sku vendor inventory41 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1       | Minus54  |
    And Vendor search Inventory on region "All regions"
      | skuName                    | zeroQuantity | orderBy                     |
      | auto sku vendor inventory4 | No           | Received Qty - Lowest first |
    And Vendor verify search inventory results
      | productName                    | skuName                     | lotCode                         | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate  | pullDate |
      | auto product vendor inventory4 | auto sku vendor inventory41 | auto lot sku vendor inventory41 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1       | Minus54  |
      | auto product vendor inventory4 | auto sku vendor inventory42 | auto lot sku vendor inventory42 | FL     | 10          | Minus1      | 10         | 0         | 10     | currentDate | Minus55  |
      | auto product vendor inventory4 | auto sku vendor inventory43 | auto lot sku vendor inventory43 | NY     | 15          | Plus2       | 15         | 0         | 15     | Plus3       | Minus52  |
    And Vendor search Inventory on region "All regions"
      | skuName                    | zeroQuantity | orderBy                     |
      | auto sku vendor inventory4 | No           | Current Qty - Highest first |
    And Vendor verify search inventory results
      | productName                    | skuName                     | lotCode                         | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate  | pullDate |
      | auto product vendor inventory4 | auto sku vendor inventory43 | auto lot sku vendor inventory43 | NY     | 15          | Plus2       | 15         | 0         | 15     | Plus3       | Minus52  |
      | auto product vendor inventory4 | auto sku vendor inventory42 | auto lot sku vendor inventory42 | FL     | 10          | Minus1      | 10         | 0         | 10     | currentDate | Minus55  |
      | auto product vendor inventory4 | auto sku vendor inventory41 | auto lot sku vendor inventory41 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1       | Minus54  |
    And Vendor search Inventory on region "All regions"
      | skuName                    | zeroQuantity | orderBy                    |
      | auto sku vendor inventory4 | No           | Current Qty - Lowest first |
    And Vendor verify search inventory results
      | productName                    | skuName                     | lotCode                         | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate  | pullDate |
      | auto product vendor inventory4 | auto sku vendor inventory41 | auto lot sku vendor inventory41 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1       | Minus54  |
      | auto product vendor inventory4 | auto sku vendor inventory42 | auto lot sku vendor inventory42 | FL     | 10          | Minus1      | 10         | 0         | 10     | currentDate | Minus55  |
      | auto product vendor inventory4 | auto sku vendor inventory43 | auto lot sku vendor inventory43 | NY     | 15          | Plus2       | 15         | 0         | 15     | Plus3       | Minus52  |
    And Vendor search Inventory on region "All regions"
      | skuName                    | zeroQuantity | orderBy               |
      | auto sku vendor inventory4 | No           | Expiry - Latest first |
    And Vendor verify search inventory results
      | productName                    | skuName                     | lotCode                         | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate  | pullDate |
      | auto product vendor inventory4 | auto sku vendor inventory43 | auto lot sku vendor inventory43 | NY     | 15          | Plus2       | 15         | 0         | 15     | Plus3       | Minus52  |
      | auto product vendor inventory4 | auto sku vendor inventory41 | auto lot sku vendor inventory41 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1       | Minus54  |
      | auto product vendor inventory4 | auto sku vendor inventory42 | auto lot sku vendor inventory42 | FL     | 10          | Minus1      | 10         | 0         | 10     | currentDate | Minus55  |
    And Vendor search Inventory on region "All regions"
      | skuName                    | zeroQuantity | orderBy                 |
      | auto sku vendor inventory4 | No           | Expiry - Earliest first |
    And Vendor verify search inventory results
      | productName                    | skuName                     | lotCode                         | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate  | pullDate |
      | auto product vendor inventory4 | auto sku vendor inventory42 | auto lot sku vendor inventory42 | FL     | 10          | Minus1      | 10         | 0         | 10     | currentDate | Minus55  |
      | auto product vendor inventory4 | auto sku vendor inventory41 | auto lot sku vendor inventory41 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1       | Minus54  |
      | auto product vendor inventory4 | auto sku vendor inventory43 | auto lot sku vendor inventory43 | NY     | 15          | Plus2       | 15         | 0         | 15     | Plus3       | Minus52  |
    And Vendor search Inventory on region "CHI"
      | skuName                    | zeroQuantity | orderBy                 |
      | auto sku vendor inventory4 | No           | Received - Latest first |
    And Vendor verify search inventory results
      | productName                    | skuName                     | lotCode                         | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | auto product vendor inventory4 | auto sku vendor inventory41 | auto lot sku vendor inventory41 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1      | Minus54  |
    And Vendor search Inventory on region "CHI"
      | skuName | zeroQuantity | orderBy                     |
      | [blank] | [blank]      | Received - Earliest first   |
      | [blank] | [blank]      | Received - Highest first    |
      | [blank] | [blank]      | Received - Lowest first     |
      | [blank] | [blank]      | Current Qty - Highest first |
      | [blank] | [blank]      | Current Qty - Lowest first  |
      | [blank] | [blank]      | Expiry - Latest first       |
      | [blank] | [blank]      | Expiry - Earliest first     |
    And Vendor search Inventory on region "FL"
      | skuName                    | zeroQuantity | orderBy                 |
      | auto sku vendor inventory4 | No           | Received - Latest first |
    And Vendor verify search inventory results
      | productName                    | skuName                     | lotCode                         | region | receivedQty | received | currentQty | pulledQty | endQty | expiryDate  | pullDate |
      | auto product vendor inventory4 | auto sku vendor inventory42 | auto lot sku vendor inventory42 | FL     | 10          | Minus1   | 10         | 0         | 10     | currentDate | Minus55  |
    And Vendor search Inventory on region "FL"
      | skuName | zeroQuantity | orderBy                     |
      | [blank] | [blank]      | Received - Earliest first   |
      | [blank] | [blank]      | Received - Highest first    |
      | [blank] | [blank]      | Received - Lowest first     |
      | [blank] | [blank]      | Current Qty - Highest first |
      | [blank] | [blank]      | Current Qty - Lowest first  |
      | [blank] | [blank]      | Expiry - Latest first       |
      | [blank] | [blank]      | Expiry - Earliest first     |
    And Vendor search Inventory on region "NY"
      | skuName                    | zeroQuantity | orderBy                 |
      | auto sku vendor inventory4 | No           | Received - Latest first |
    And Vendor verify search inventory results
      | productName                    | skuName                     | lotCode                         | region | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | auto product vendor inventory4 | auto sku vendor inventory43 | auto lot sku vendor inventory43 | NY     | 15          | Plus2    | 15         | 0         | 15     | Plus3      | Minus52  |
    And Vendor search Inventory on region "NY"
      | skuName | zeroQuantity | orderBy                     |
      | [blank] | [blank]      | Received - Earliest first   |
      | [blank] | [blank]      | Received - Highest first    |
      | [blank] | [blank]      | Received - Lowest first     |
      | [blank] | [blank]      | Current Qty - Highest first |
      | [blank] | [blank]      | Current Qty - Lowest first  |
      | [blank] | [blank]      | Expiry - Latest first       |
      | [blank] | [blank]      | Expiry - Earliest first     |

  @V_INVENTORY_3 @V_INVENTORY_10
  Scenario: Check display of Inactive Brand/ Product/ SKU on Inventory list
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor inventory3 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor inventory3" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "auto product vendor inventory" by api
    And Admin delete product name "auto product vendor inventory" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor inventory3 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random auto sku vendor inventory3" of product ""
    And Admin create inventory api1
      | index | sku                               | product_variant_id | quantity | lot_code                              | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random auto sku vendor inventory3 | random             | 5        | random auto lot sku vendor inventory3 | 99           | currentDate  | Plus1       | [blank] |
    #  Change state to inactive
    And Admin change info of regions attributes of sku "random auto sku vendor inventory3" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | inactive |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor65@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search Inventory on region "All regions"
      | skuName                    | zeroQuantity | orderBy                 |
      | auto sku vendor inventory3 | No           | Received - Latest first |
    And Vendor verify search inventory results
      | productName                    | skuName                           | lotCode                               | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | auto product vendor inventory3 | random auto sku vendor inventory3 | random auto lot sku vendor inventory3 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1      | Minus54  |
    And Vendor search Inventory on region "CHI"
      | skuName                    | zeroQuantity | orderBy                 |
      | auto sku vendor inventory3 | No           | Received - Latest first |
    And Vendor verify search inventory results
      | productName                    | skuName                           | lotCode                               | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | auto product vendor inventory3 | random auto sku vendor inventory3 | random auto lot sku vendor inventory3 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1      | Minus54  |
    And Vendor search Inventory on region "All regions"
      | skuName                        | zeroQuantity | orderBy                 |
      | auto product vendor inventory3 | No           | Received - Latest first |
    And Vendor verify search inventory results
      | productName                    | skuName                           | lotCode                               | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | auto product vendor inventory3 | random auto sku vendor inventory3 | random auto lot sku vendor inventory3 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1      | Minus54  |

    #  Create pull qty not Pull date reached
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 2                       | 5        | Autotest |
    And VENDOR refresh browser
    And Vendor search Inventory on region "All regions"
      | skuName                    | zeroQuantity | orderBy                 |
      | auto sku vendor inventory3 | No           | Received - Latest first |
    And Check any text "is" showing on screen
      | No inventories found...       |
      | We couldn't find any matches. |
    And Vendor search Inventory on region "All regions"
      | skuName                    | zeroQuantity | orderBy                 |
      | auto sku vendor inventory3 | Yes          | Received - Latest first |
    And Vendor verify search inventory results
      | productName                    | skuName                           | lotCode                               | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | auto product vendor inventory3 | random auto sku vendor inventory3 | random auto lot sku vendor inventory3 | CHI    | 5           | currentDate | 0          | 0         | 0      | Plus1      | Minus54  |

  @V_INVENTORY_25
  Scenario: Check display Pulled Qty
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                 | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor inventory25 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor inventory25" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "auto product vendor inventory25" by api
    And Admin delete product name "auto product vendor inventory25" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                            | brand_id |
      | auto product vendor inventory25 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random auto sku vendor inventory25" of product ""
    And Admin create inventory api1
      | index | sku                                | product_variant_id | quantity | lot_code                               | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random auto sku vendor inventory25 | random             | 5        | random auto lot sku vendor inventory25 | 99           | currentDate  | Plus1       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor65@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search Inventory on region "All regions"
      | skuName                     | zeroQuantity | orderBy                 |
      | auto sku vendor inventory25 | No           | Received - Latest first |
    And Vendor verify search inventory results
      | productName                     | skuName                            | lotCode                                | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | auto product vendor inventory25 | random auto sku vendor inventory25 | random auto lot sku vendor inventory25 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1      | Minus54  |

    #  Create pull qty not Pull date reached
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 1        | Autotest |
    And VENDOR refresh browser
    And Vendor search Inventory on region "All regions"
      | skuName                     | zeroQuantity | orderBy                 |
      | auto sku vendor inventory25 | No           | Received - Latest first |
    And Vendor verify search inventory results
      | productName                     | skuName                            | lotCode                                | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | auto product vendor inventory25 | random auto sku vendor inventory25 | random auto lot sku vendor inventory25 | CHI    | 5           | currentDate | 4          | 1         | 4      | Plus1      | Minus54  |

      #  Create pull qty not Pull date reached
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 12                      | 1        | Autotest |
    And VENDOR refresh browser
    And Vendor search Inventory on region "All regions"
      | skuName                     | zeroQuantity | orderBy                 |
      | auto sku vendor inventory25 | No           | Received - Latest first |
    And Vendor verify search inventory results
      | productName                     | skuName                            | lotCode                                | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | auto product vendor inventory25 | random auto sku vendor inventory25 | random auto lot sku vendor inventory25 | CHI    | 5           | currentDate | 3          | 1         | 3      | Plus1      | Minus54  |
    And Vendor search Inventory on region "CHI"
      | skuName                     | zeroQuantity | orderBy                 |
      | auto sku vendor inventory25 | No           | Received - Latest first |
    And Vendor verify search inventory results
      | productName                     | skuName                            | lotCode                                | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | auto product vendor inventory25 | random auto sku vendor inventory25 | random auto lot sku vendor inventory25 | CHI    | 5           | currentDate | 3          | 1         | 3      | Plus1      | Minus54  |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                 | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor inventory25 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor inventory25" from API
    And Admin delete all subtraction of list inventory
    And VENDOR refresh browser
    And Vendor search Inventory on region "All regions"
      | skuName                     | zeroQuantity | orderBy                 |
      | auto sku vendor inventory25 | No           | Received - Latest first |
    And Vendor verify search inventory results
      | productName                     | skuName                            | lotCode                                | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | auto product vendor inventory25 | random auto sku vendor inventory25 | random auto lot sku vendor inventory25 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1      | Minus54  |
    And Vendor search Inventory on region "CHI"
      | skuName                     | zeroQuantity | orderBy                 |
      | auto sku vendor inventory25 | No           | Received - Latest first |
    And Vendor verify search inventory results
      | productName                     | skuName                            | lotCode                                | region | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | auto product vendor inventory25 | random auto sku vendor inventory25 | random auto lot sku vendor inventory25 | CHI    | 5           | currentDate | 5          | 0         | 5      | Plus1      | Minus54  |


  #INVENTORY STATUS
  @V_INVENTORY_33 @V_INVENTORY_35
  Scenario: Check information shown on the page INVENTORY STATUS
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    # Delete inventory
    And Admin delete order by sku of product "auto product vendor inventory" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]               | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor inventory" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "auto product vendor inventory" by api
    And Admin delete product name "auto product vendor inventory" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | auto product vendor inventory | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor inventory1" of product ""
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor inventory1 | random             | 5        | auto lot sku vendor inventory1 | 99           | Plus1        | Plus1       | [blank] |
 #Create order unfulfill
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    #Create order unfulfill 2
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 6        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor inventory2" of product ""
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor inventory2 | random             | 10       | auto lot sku vendor inventory2 | 95           | Plus1        | Plus1       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor65@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Inventory Status" tab
    And Check text "is" showing on screen
      | Green                                                                                                                                  |
      | You have sufficient amount of inventory at Pod Foods distribution center.                                                              |
      | Orange                                                                                                                                 |
      | This inventory is running low. Please get in touch with our team to send more inventory to the distribution center.                    |
      | Red                                                                                                                                    |
      | Insufficient inventory to fulfill pending orders. Please get in touch with our team to send more inventory to the distribution center. |
    And Vendor check help popup Inventory status
    And Vendor search Inventory Status "All regions"
      | skuName                    | orderBy |
      | auto sku vendor inventory1 | [blank] |
    Then Vendor verify result in Inventory Status
      | product                       | brand                  | sku                        | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | auto product vendor inventory | Auto Brand product moq | auto sku vendor inventory1 | 5                | 0                | 5               | 1               | 6                    | -2     | [blank]     | [blank]               | [blank] |
    And VENDOR clear filter on field "Search term"
    And Vendor search Inventory Status "All regions"
      | skuName                   | orderBy |
      | auto sku vendor inventory | [blank] |
    Then Vendor verify result in Inventory Status
      | product                       | brand                  | sku                        | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | auto product vendor inventory | Auto Brand product moq | auto sku vendor inventory1 | 5                | 0                | 5               | 1               | 6                    | -2     | [blank]     | [blank]               | [blank] |
      | auto product vendor inventory | Auto Brand product moq | auto sku vendor inventory2 | 10               | 0                | 10              | 0               | 0                    | 10     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "All regions"
      | skuName                   | orderBy                     |
      | auto sku vendor inventory | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product                       | brand                  | sku                        | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | auto product vendor inventory | Auto Brand product moq | auto sku vendor inventory2 | 10               | 0                | 10              | 0               | 0                    | 10     | [blank]     | [blank]               | [blank] |
      | auto product vendor inventory | Auto Brand product moq | auto sku vendor inventory1 | 5                | 0                | 5               | 1               | 6                    | -2     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "All regions"
      | skuName                   | orderBy                    |
      | auto sku vendor inventory | Current Qty - Lowest first |
    Then Vendor verify result in Inventory Status
      | product                       | brand                  | sku                        | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | auto product vendor inventory | Auto Brand product moq | auto sku vendor inventory1 | 5                | 0                | 5               | 1               | 6                    | -2     | [blank]     | [blank]               | [blank] |
      | auto product vendor inventory | Auto Brand product moq | auto sku vendor inventory2 | 10               | 0                | 10              | 0               | 0                    | 10     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "All regions"
      | skuName                   | orderBy                     |
      | auto sku vendor inventory | Pending Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product                       | brand                  | sku                        | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | auto product vendor inventory | Auto Brand product moq | auto sku vendor inventory1 | 5                | 0                | 5               | 1               | 6                    | -2     | [blank]     | [blank]               | [blank] |
      | auto product vendor inventory | Auto Brand product moq | auto sku vendor inventory2 | 10               | 0                | 10              | 0               | 0                    | 10     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "All regions"
      | skuName                   | orderBy                    |
      | auto sku vendor inventory | Pending Qty - Lowest first |
    Then Vendor verify result in Inventory Status
      | product                       | brand                  | sku                        | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | auto product vendor inventory | Auto Brand product moq | auto sku vendor inventory2 | 10               | 0                | 10              | 0               | 0                    | 10     | [blank]     | [blank]               | [blank] |
      | auto product vendor inventory | Auto Brand product moq | auto sku vendor inventory1 | 5                | 0                | 5               | 1               | 6                    | -2     | [blank]     | [blank]               | [blank] |

    And Vendor search Inventory Status "CHI"
      | skuName                    | orderBy                     |
      | auto sku vendor inventory1 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product                       | brand                  | sku                        | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status         |
      | auto product vendor inventory | Auto Brand product moq | auto sku vendor inventory1 | 5                | 0                | 5               | 1               | 6                    | [blank] | -           | [blank]               | 2 cases needed |
    And Vendor search Inventory Status "CHI"
      | skuName                    | orderBy |
      | auto sku vendor inventory2 | [blank] |
    And Check any text "is" showing on screen
      | No inventories found...       |
      | We couldn't find any matches. |
    And Vendor search Inventory Status "FL"
      | skuName                    | orderBy                     |
      | auto sku vendor inventory2 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product                       | brand                  | sku                        | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status                |
      | auto product vendor inventory | Auto Brand product moq | auto sku vendor inventory2 | 10               | 0                | 10              | 0               | 0                    | [blank] | -           | [blank]               | 10 cases in inventory |
    And Vendor search Inventory Status "FL"
      | skuName                    | orderBy |
      | auto sku vendor inventory1 | [blank] |
    And Check any text "is" showing on screen
      | No inventories found...       |
      | We couldn't find any matches. |
    And Vendor check help popup Inventory status
    And Vendor search Inventory Status "MA"
      | skuName | orderBy |
      | [blank] | [blank] |
    And Vendor check help popup Inventory status
    And Vendor search Inventory Status "NY"
      | skuName | orderBy |
      | [blank] | [blank] |
    And Vendor check help popup Inventory status
    And Vendor search Inventory Status "SF"
      | skuName | orderBy |
      | [blank] | [blank] |
    And Vendor check help popup Inventory status
    And Vendor search Inventory Status "LA"
      | skuName | orderBy |
      | [blank] | [blank] |
    And Vendor check help popup Inventory status
    And Vendor search Inventory Status "DAL"
      | skuName | orderBy |
      | [blank] | [blank] |
    And Vendor check help popup Inventory status

  @V_INVENTORY_56
  Scenario: Check display of this column Status
    Given BAO_ADMIN9 login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto product vendor inventory56" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                 | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor inventory56 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor inventory56" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "auto product vendor inventory56" by api
    And Admin delete product name "auto product vendor inventory56" by api
#    Create  SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                            | brand_id |
      | auto product vendor inventory56 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |

    And Admin create a "active" SKU from admin with name "auto sku vendor inventory56" of product ""
    And Admin create inventory api1
      | index | sku                         | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor inventory56 | random             | 5        | random   | 99           | currentDate  | currentDate | [blank] |
#      | 3     | random sku admin inventory 277 api 1 | random             | 3        | random   | 99           | currentDate  | currentDate | [blank] |
     #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer29@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | [blank]   | [blank] | 4        |
    And Checkout cart with payment by "invoice" by API
#    Fulfilled this order
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin "fulfilled" all line item in order "create by api" by api

    #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "update_inventoty_quantity_threshold"

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Inventory Status" tab
    And Vendor search Inventory Status "CHI"
      | skuName                     | orderBy                     |
      | auto sku vendor inventory56 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product                         | brand                     | sku                         | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status           |
      | auto product vendor inventory56 | Auto brand create product | auto sku vendor inventory56 | 5                | 4                | 1               | 0               | 0                    | [blank] | -           | 2                     | Only 1 case left |

    And Vendor search Inventory Status "All regions"
      | skuName                     | orderBy                     |
      | auto sku vendor inventory56 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product                         | brand                     | sku                         | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | auto product vendor inventory56 | Auto brand create product | auto sku vendor inventory56 | 5                | 4                | 1               | 0               | 0                    | 1      | [blank]     | [blank]               | [blank] |

  #INBOUND INVENTORY
  @V_INVENTORY_73
  Scenario Outline: Verify the Inbound instruction
    Given BAO_ADMIN20 login web admin by api
      | email             | password  |
      | bao20@podfoods.co | 12345678a |
       # Create inbound
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | <sku>              | 1845              | 10       |
    And Admin create Incoming Inventory api
      | region_id   | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id   |
      | <region_id> | 1845              | 10            | 10                          | 1                        | 1     | 1          | <warehouse_id> |

#    Given NGOC_ADMIN_02 open web admin
#    When NGOC_ADMIN_02 login to web with role Admin
#    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
#    And Admin create new incoming inventory
#      | vendorCompany                          | region   | warehouse   | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
#      | Auto Vendor Company Withdraw inventory | <region> | <warehouse> | 0                | 0        | [blank]       | [blank] | [blank]   |
#    And With SKUs
#      | sku   | ofCase |
#      | <sku> | 10     |
#    And Confirm Create Incoming inventory
#
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor28@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor search inbound inventory on tab "All"
      | region   | startDate | endDate |
      | <region> | [blank]   | [blank] |
    And VENDOR Go to detail of inbound inventory have number: "create by api"
    And Vendor verify instructions of region "<region>" in Inbound detail
    Examples:
      | region                   | region_id | warehouse                               | warehouse_id | sku   |
      | Chicagoland Express      | 26        | Auto Ngoc Distribution CHI              | 90           | 30722 |
      | North California Express | 25        | Bao distribute North California express | 98           | 30726 |
      | South California Express | 51        | Bao distribute South California Express | 97           | 30727 |
      | New York Express         | 53        | Auto Distribute NewYork                 | 91           | 30724 |
      | Dallas Express           | 61        | Auto distribute Texas Express           | 88           | 30728 |
      | Mid Atlantic Express     | 62        | Bao distribute Mid atlantic Express     | 96           | 30729 |
      | Florida Express          | 63        | Bao distribute florida express          | 95           | 30725 |
      | Sacramento Express       | 67        | Auto Distribute Sacramento Express      | 164          | 71161 |
      | Denver Express           | 66        | Auto Distribute Denver Express          | 162          | 71162 |
      | Phoenix Express          | 65        | Auto Distribute Phoenix Express         | 163          | 71163 |
      | Atlanta Express          | 64        | Auto Distribute Atlanta Express         | 161          | 71164 |

  @V_INVENTORY_64
  Scenario: Check display of the Inbound instruction on Create form
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor27@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And Click Create new inbound inventory
    And Vendor go to create inbound page by url
#    And Check General Instructions
    And Choose Region "South California Express" and check Instructions
    And Choose Region "Dallas Express" and check Instructions
    And Choose Region "North California Express" and check Instructions
    And Choose Region "New York Express" and check Instructions
    And Choose Region "Mid Atlantic Express" and check Instructions
    And Choose Region "Florida Express" and check Instructions
    And Choose Region "Sacramento Express" and check Instructions
    And Choose Region "Denver Express" and check Instructions
    And Choose Region "Phoenix Express" and check Instructions
    And Choose Region "Atlanta Express" and check Instructions

  @V_INVENTORY_87
  Scenario: Verify Search and Filter Inbound inventory
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 1 api 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                              | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inbound inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inbound inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 1 api" by api
    And Admin delete product name "random product admin inbound inventory 1 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                           | brand_id |
      | random product admin inbound inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 1 api 1" of product ""

    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor search inbound inventory on tab "All"
      | region              | startDate   | endDate     | showCanceled |
      | Chicagoland Express | currentDate | currentDate | Yes          |
    And Vendor verify search result in Send Inventory
      | number        | region              | eta | status    |
      | create by api | Chicagoland Express | -   | Requested |
    And Vendor search inbound inventory on tab "Requested"
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Vendor verify search result in Send Inventory
      | number        | region              | eta | status    |
      | create by api | Chicagoland Express | -   | Requested |
    And Vendor search inbound inventory on tab "Confirmed"
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Vendor verify no found inbound inventory "create by api"
#    And Vendor search inbound inventory on tab "Approved"
#      | region              | startDate   | endDate     |
#      | Chicagoland Express | currentDate | currentDate |
#    And Vendor verify no found inbound inventory "create by api"
    And Vendor search inbound inventory on tab "Received"
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Vendor verify no found inbound inventory "create by api"
    And Vendor search inbound inventory on tab "Processed"
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Vendor verify no found inbound inventory "create by api"

  #Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                        | lot_code                                   | quantity | expiry_date |
      | random sku admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
    And Vendor search inbound inventory on tab "All"
      | region              | startDate   | endDate |
      | Chicagoland Express | currentDate | Plus1   |
    And Vendor verify search result in Send Inventory
      | number        | region              | eta   | status    |
      | create by api | Chicagoland Express | Plus1 | Confirmed |
    And Vendor search inbound inventory on tab "Requested"
      | region              | startDate   | endDate |
      | Chicagoland Express | currentDate | Plus1   |
    And Vendor verify no found inbound inventory "create by api"
    And Vendor search inbound inventory on tab "Confirmed"
      | region              | startDate   | endDate |
      | Chicagoland Express | currentDate | Plus1   |
    And Vendor verify search result in Send Inventory
      | number        | region              | eta   | status    |
      | create by api | Chicagoland Express | Plus1 | Confirmed |
#    And Vendor search inbound inventory on tab "Approved"
#      | region              | startDate   | endDate |
#      | Chicagoland Express | currentDate | Plus1   |
#    And Vendor verify no found inbound inventory "create by api"
    And Vendor search inbound inventory on tab "Received"
      | region              | startDate   | endDate |
      | Chicagoland Express | currentDate | Plus1   |
    And Vendor verify no found inbound inventory "create by api"
    And Vendor search inbound inventory on tab "Processed"
      | region              | startDate   | endDate |
      | Chicagoland Express | currentDate | Plus1   |
    And Vendor verify no found inbound inventory "create by api"
##        Approve inbound
#    And Admin Approve Incoming Inventory id "api" api
#    And Vendor search inbound inventory on tab "All"
#      | region              | startDate   | endDate |
#      | Chicagoland Express | currentDate | Plus1   |
#    And Vendor verify search result in Send Inventory
#      | number        | region              | eta   | status   |
#      | create by api | Chicagoland Express | Plus1 | Approved |
#    And Vendor search inbound inventory on tab "Requested"
#      | region              | startDate   | endDate |
#      | Chicagoland Express | currentDate | Plus1   |
#    And Vendor verify no found inbound inventory "create by api"
#    And Vendor search inbound inventory on tab "Confirmed"
#      | region              | startDate   | endDate |
#      | Chicagoland Express | currentDate | Plus1   |
#    And Vendor verify no found inbound inventory "create by api"
#    And Vendor search inbound inventory on tab "Approved"
#      | region              | startDate   | endDate |
#      | Chicagoland Express | currentDate | Plus1   |
#    And Vendor verify search result in Send Inventory
#      | number        | region              | eta   | status   |
#      | create by api | Chicagoland Express | Plus1 | Approved |
#    And Vendor search inbound inventory on tab "Received"
#      | region              | startDate   | endDate |
#      | Chicagoland Express | currentDate | Plus1   |
#    And Vendor verify no found inbound inventory "create by api"
#    And Vendor search inbound inventory on tab "Processed"
#      | region              | startDate   | endDate |
#      | Chicagoland Express | currentDate | Plus1   |
#    And Vendor verify no found inbound inventory "create by api"
#    Upload file inbound
    And Admin upload file Incoming Inventory id "api" api
      | fileBOL | filePOD |
      | BOL.pdf | POD.png |
#    Mark as received
    And Admin Mark as received Incoming Inventory id "api" api

    #    Processed inbound
    And Admin Process Incoming Inventory id "api" api
    And Vendor search inbound inventory on tab "All"
      | region              | startDate   | endDate |
      | Chicagoland Express | currentDate | Plus1   |
    And Vendor verify search result in Send Inventory
      | number        | region              | eta   | status    |
      | create by api | Chicagoland Express | Plus1 | Processed |
    And Vendor search inbound inventory on tab "Requested"
      | region              | startDate   | endDate |
      | Chicagoland Express | currentDate | Plus1   |
    And Vendor verify no found inbound inventory "create by api"
    And Vendor search inbound inventory on tab "Confirmed"
      | region              | startDate   | endDate |
      | Chicagoland Express | currentDate | Plus1   |
    And Vendor verify no found inbound inventory "create by api"
#    And Vendor search inbound inventory on tab "Approved"
#      | region              | startDate   | endDate |
#      | Chicagoland Express | currentDate | Plus1   |
#    And Vendor verify no found inbound inventory "create by api"
    And Vendor search inbound inventory on tab "Received"
      | region              | startDate   | endDate |
      | Chicagoland Express | currentDate | Plus1   |
    And Vendor verify no found inbound inventory "create by api"
    And Vendor search inbound inventory on tab "Processed"
      | region              | startDate   | endDate |
      | Chicagoland Express | currentDate | Plus1   |
    And Vendor verify search result in Send Inventory
      | number        | region              | eta   | status    |
      | create by api | Chicagoland Express | Plus1 | Processed |

  @V_INVENTORY_97 @V_INVENTORY_135
  Scenario: Check information shown for a Requested Inbound inventory when admin creates the inbound inventory with required fields and 1 SKU only
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 1 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                              | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inbound inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inbound inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 1 api" by api
    And Admin delete product name "random product admin inbound inventory 1 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                           | brand_id |
      | random product admin inbound inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 1 api 1" of product ""

    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor search inbound inventory on tab "Requested"
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Vendor go to detail of inbound inventory "create by api"
    And Vendor verify instructions of region "Chicagoland Express" in Inbound detail
    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Requested | Chicagoland Express | [blank]        | [blank]       | [blank]   | [blank]          | 1        | 10                  | [blank]     | [blank] |
    And Vendor check detail info optional of Inbound inventory
      | other   | freight | reference | estimatedWeek | note |
      | [blank] | [blank] | [blank]   | 1             | 1    |
    And Vendor check detail of SKU in Inbound inventory
      | index | brand                     | product                                      | sku                                      | ofCases | lotCode | expiryDate | temperature   | shelfLife |
      | 1     | Auto brand create product | random product admin inbound inventory 1 api | random sku admin inbound inventory 1 api | 10      | [blank] | [blank]    | 1.0 F - 1.0 F | 1 dayDry  |
    And VENDOR check help text tooltip
      | field                                        | text                                                                                                                                                                                              |
      | # of Pallets                                 | If not shipping a pallet, please indicate 0                                                                                                                                                       |
      | # of Sellable Retail Cases per Master Carton | If not shipping in master cartons, please indicate 0                                                                                                                                              |
      | Other special shipping details               | e.g. if SKUs are color-coded, separated by layers on the pallet etc                                                                                                                               |
      | Freight Carrier                              | If using a freight carrier, please indicate the carrier name                                                                                                                                      |
      | Reference #                                  | If using a freight carrier, please indicate PRO/PO/BOL/Load number referenced on your shipment's paper                                                                                            |
      | Upload a BOL                                 | Can upload a PDF or image file.                                                                                                                                                                   |
      | Upload a POD                                 | Can upload a PDF or image file.                                                                                                                                                                   |
      | Transportation Coordinator Contact           | Please add contact name & number for your freight broker.                                                                                                                                         |
      | Product Lot code                             | If your product has a lot code, enter that. If not, enter expiration date                                                                                                                         |
      | Expiry date                                  | Products need to arrive at Pod Foods DCs with at least 75% total shelf life remaining. If expiry dates are not available at the point of form submission, please contact at inventory@podfoods.co |
      | Total # of Sellable Retail Cases             | A sellable retail case is how your product is set up on Pod Foods                                                                                                                                 |
      | # of Master Cartons                          | A master carton is a shipping carton which contains multiple sellable retail cases of the same item.                                                                                              |
    And Click on button "Update"
    And VENDOR check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check error message is showing of fields
      | field                                        | message                    |
      | Select Inbound Delivery Method               | This field cannot be blank |
      | Estimated Date of Arrival                    | This field cannot be blank |
      | # of Sellable Retail Cases per Master Carton | This field cannot be blank |
      | Total weight of shipment                     | This field cannot be blank |
      | What zip code is the shipment coming from?   | This field cannot be blank |

    And Vendor input info of inbound inventory
      | deliveryMethod      | estimatedDateArrival | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | trackingNumber | totalWeight | zipCode |
      | Brand Self Delivery | currentDate          | 1         | 1                | 1              | 1                         | 1              | 1           | 11111   |
    And Vendor check error message not showing of fields
      | field                                        | message                    |
      | Select Inbound Delivery Method               | This field cannot be blank |
      | Estimated Date of Arrival                    | This field cannot be blank |
      | # of Sellable Retail Cases per Master Carton | This field cannot be blank |
      | Total weight of shipment                     | This field cannot be blank |
      | What zip code is the shipment coming from?   | This field cannot be blank |

    And Edit info SKU of inbound inventory
      | index | sku                                      | caseOfSku | productLotCode | expiryDate |
      | 1     | random sku admin inbound inventory 1 api | 1         | random         | Plus1      |
    And Click on button "Update"
    And VENDOR check alert message
      | Inbound inventory updated successfully |

    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod      | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Confirmed | Chicagoland Express | Brand Self Delivery | currentDate   | 1         | 1                | 1        | 1                   | 1           | 11111   |
    And Vendor check detail info optional of Inbound inventory
      | other   | freight | reference | estimatedWeek | note |
      | [blank] | [blank] | [blank]   | 1             | 1    |
    And Vendor check detail of SKU in Inbound inventory
      | index | brand                     | product                                      | sku                                      | ofCases | lotCode | expiryDate | temperature   | shelfLife |
      | 1     | Auto brand create product | random product admin inbound inventory 1 api | random sku admin inbound inventory 1 api | 1       | random  | Plus1      | 1.0 F - 1.0 F | 1 dayDry  |
    And Click on any text "< Back to List Inbound Inventory"
    And Vendor search inbound inventory on tab "All"
      | region              | startDate   | endDate |
      | Chicagoland Express | currentDate | Plus1   |
    And Vendor verify search result in Send Inventory
      | number        | region              | eta         | status    |
      | create by api | Chicagoland Express | currentDate | Confirmed |

  @V_INVENTORY_110
  Scenario: Check Vendor submits the Requested Inbound inventory with edit value
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 1 api 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                              | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inbound inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inbound inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 1 api" by api
    And Admin delete product name "random product admin inbound inventory 1 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                           | brand_id |
      | random product admin inbound inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 1 api 1" of product ""

    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor search inbound inventory on tab "Requested"
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Vendor go to detail of inbound inventory "create by api"
    And Vendor input info of inbound inventory
      | deliveryMethod        | estimatedDateArrival | ofPallets | ofSellableRetailPerCarton | totalWeight | zipCode |
      | Freight Carrier / LTL | Minus1               | -1        | -1                        | -1          | 1       |
    And Vendor input info optional of inbound inventory
      | otherShipping | freightCarrier | trackingNumber | referenceNumber | estimatedWeek | note    | palletTransit | palletWarehouse | fileBOL | transportName | transportPhone |
      | [blank]       | [blank]        | [blank]        | [blank]         | -1            | [blank] | [blank]       | [blank]         | [blank] | [blank]       | 1              |
    And Click on button "Update"
    And VENDOR check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check error message is showing of fields
      | field                                        | message                                     |
      | # of Pallets                                 | Please enter a valid number                 |
      | # of Sellable Retail Cases per Master Carton | Please enter a valid number                 |
      | Estimated Weeks of Inventory                 | Please enter a valid number                 |
      | Total weight of shipment                     | Value must be greater than 0                |
      | What zip code is the shipment coming from?   | Please enter a valid zip code               |
      | Phone number                                 | Please enter a valid 10-digits phone number |
    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Requested | Chicagoland Express | [blank]        | [blank]       | [blank]   | [blank]          | [blank]  | [blank]             | [blank]     | [blank] |

    And Vendor input info optional of inbound inventory
      | otherShipping | freightCarrier | trackingNumber | referenceNumber | estimatedWeek | note    | palletTransit | palletWarehouse | fileBOL         | transportName | transportPhone |
      | [blank]       | [blank]        | [blank]        | [blank]         | [blank]       | [blank] | [blank]       | [blank]         | 10MBgreater.jpg | [blank]       | [blank]        |
    And VENDOR check alert message
      | Maximum file size exceeded. |
    And Vendor upload POD to inbound inventory
      | 10MBgreater.jpg |
    And VENDOR check alert message
      | Maximum file size exceeded. |
    And Vendor input info optional of inbound inventory
      | otherShipping | freightCarrier | trackingNumber | referenceNumber | estimatedWeek | note    | palletTransit | palletWarehouse | fileBOL            | transportName | transportPhone |
      | [blank]       | [blank]        | [blank]        | [blank]         | [blank]       | [blank] | [blank]       | [blank]         | ImageInvalid2.xlsx | [blank]       | [blank]        |
    And Vendor upload POD to inbound inventory
      | ImageInvalid2.xlsx |
    And Vendor input info of inbound inventory
      | deliveryMethod        | estimatedDateArrival | ofPallets | ofSellableRetailPerCarton | totalWeight | zipCode |
      | Freight Carrier / LTL | Minus1               | 1         | 1                         | 1           | 11111   |
    And Vendor input info optional of inbound inventory
      | otherShipping | freightCarrier | trackingNumber | referenceNumber | estimatedWeek | note    | palletTransit | palletWarehouse | fileBOL | transportName | transportPhone |
      | [blank]       | [blank]        | [blank]        | [blank]         | 1             | [blank] | [blank]       | [blank]         | [blank] | [blank]       | 0123456789     |
    And Click on button "Update"
    And VENDOR check alert message
      | Validation failed: Attachment content type is invalid |

    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod        | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Requested | Chicagoland Express | Freight Carrier / LTL | Minus1        | 1         | 1                | 1        | 1                   | 1           | 11111   |
    And Vendor check detail info optional of Inbound inventory
      | other   | freight | reference | estimatedWeek | note    | palletTransit | palletWarehouse | fileBOL | filePOD | transportName | transportPhone |
      | [blank] | [blank] | [blank]   | [blank]       | [blank] | [blank]       | [blank]         | [blank] | [blank] | [blank]       | 0123456789     |

  @V_INVENTORY_135
  Scenario: Check vendor submits a Requested Inbound inventory successfully 1
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 1 api 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                              | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inbound inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inbound inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 1 api" by api
    And Admin delete product name "random product admin inbound inventory 1 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                           | brand_id |
      | random product admin inbound inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 1 api 1" of product ""

    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor search inbound inventory on tab "Requested"
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Vendor go to detail of inbound inventory "create by api"
    And Vendor input info of inbound inventory
      | deliveryMethod        | estimatedDateArrival | ofPallets | ofSellableRetailPerCarton | totalWeight | zipCode |
      | Freight Carrier / LTL | Plus1                | 1         | 1                         | 1           | 111111  |
    And Vendor input info optional of inbound inventory
      | otherShipping       | freightCarrier       | trackingNumber | referenceNumber | estimatedWeek | note      | palletTransit | palletWarehouse | fileBOL | transportName  | transportPhone |
      | Auto other Shipping | Auto freight Carrier | [blank]        | 1               | 1             | Auto note | Yes           | No              | BOL.pdf | transport Name | 0123456789     |
    And Vendor upload POD to inbound inventory
      | anhJPEG.jpg |
    And Click on button "Update"
    And VENDOR check alert message
      | Inbound inventory updated successfully |
    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod        | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Confirmed | Chicagoland Express | Freight Carrier / LTL | Plus1         | 1         | 1                | 1        | 1                   | 1           | 111111  |
    And Vendor check detail info optional of Inbound inventory
      | other               | freight              | reference | estimatedWeek | note      | palletTransit | palletWarehouse | fileBOL | filePOD     | transportName  | transportPhone |
      | Auto other Shipping | Auto freight Carrier | 1         | 1             | Auto note | Yes           | No              | BOL.pdf | anhJPEG.jpg | transport Name | 0123456789     |
    And Vendor check detail of SKU in Inbound inventory
      | index | brand                     | product                                      | sku                                      | ofCases | lotCode | expiryDate | temperature   | shelfLife |
      | 1     | Auto brand create product | random product admin inbound inventory 1 api | random sku admin inbound inventory 1 api | 10      | [blank] | [blank]    | 1.0 F - 1.0 F | 1 dayDry  |

  @V_INVENTORY_134
  Scenario: Check vendor submits a Requested Inbound inventory successfully 2
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 1 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                              | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inbound inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inbound inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 1 api" by api
    And Admin delete product name "random product admin inbound inventory 1 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                           | brand_id |
      | random product admin inbound inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 1 api 1" of product ""

    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor search inbound inventory on tab "Requested"
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Vendor go to detail of inbound inventory "create by api"
    And Vendor input info of inbound inventory
      | deliveryMethod      | estimatedDateArrival | ofPallets | ofSellableRetailPerCarton | totalWeight | zipCode |
      | Brand Self Delivery | Plus1                | 1         | 1                         | 1           | 111111  |
    And Vendor input info optional of inbound inventory
      | otherShipping       | freightCarrier       | trackingNumber | referenceNumber | estimatedWeek | note      | palletTransit | palletWarehouse | fileBOL | transportName  | transportPhone |
      | Auto other Shipping | Auto freight Carrier | 1              | 1               | 1             | Auto note | Yes           | No              | BOL.pdf | transport Name | 0123456789     |
    And Vendor upload POD to inbound inventory
      | anhJPEG.jpg |
    And Click on button "Update"
    And VENDOR check alert message
      | Inbound inventory updated successfully |
    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod      | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Confirmed | Chicagoland Express | Brand Self Delivery | Plus1         | 1         | 1                | 1        | 1                   | 1           | 111111  |
    And Vendor check detail info optional of Inbound inventory
      | other               | freight              | reference | estimatedWeek | note      | palletTransit | palletWarehouse | fileBOL | filePOD     | transportName  | transportPhone | trackingNumber |
      | Auto other Shipping | Auto freight Carrier | 1         | 1             | Auto note | Yes           | No              | BOL.pdf | anhJPEG.jpg | transport Name | 0123456789     | 1              |
    And Vendor check detail of SKU in Inbound inventory
      | index | brand                     | product                                      | sku                                      | ofCases | lotCode | expiryDate | temperature   | shelfLife |
      | 1     | Auto brand create product | random product admin inbound inventory 1 api | random sku admin inbound inventory 1 api | 10      | [blank] | [blank]    | 1.0 F - 1.0 F | 1 dayDry  |

    Given BAO_ADMIN11 open web admin
    When BAO_ADMIN11 login to web with role Admin
    And BAO_ADMIN11 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] |
    And Go to detail of incoming inventory number "create by api"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod      | vendorCompany       | status    | warehouse            | eta   | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | zipCode | trackingNumber |
      | Chicagoland Express | Brand Self Delivery | Auto vendor company | Confirmed | Bao Distribution CHI | Plus1 | 1        | 1              | 10               | 1                         | 11111   | 1              |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                   | nameSKU                                  | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU |
      | 1     | Auto brand create product | random product admin inbound inventory 1 api | random sku admin inbound inventory 1 api | [blank]    | 10        | [blank]       | Plus1            |

  @V_INVENTORY_134_2
  Scenario: Check vendor submits a Requested Inbound inventory successfully 3
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 1 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                              | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inbound inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inbound inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 1 api" by api
    And Admin delete product name "random product admin inbound inventory 1 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                           | brand_id |
      | random product admin inbound inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 1 api 1" of product ""

    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor search inbound inventory on tab "Requested"
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Vendor go to detail of inbound inventory "create by api"
    And Vendor input info of inbound inventory
      | deliveryMethod        | estimatedDateArrival | ofPallets | ofSellableRetailPerCarton | totalWeight | zipCode |
      | Freight Carrier / LTL | Plus1                | 1         | 1                         | 1           | 111111  |
    And Vendor input info optional of inbound inventory
      | otherShipping       | freightCarrier       | trackingNumber | referenceNumber | estimatedWeek | note      | palletTransit | palletWarehouse | fileBOL | transportName  | transportPhone |
      | Auto other Shipping | Auto freight Carrier | [blank]        | [blank]         | 1             | Auto note | Yes           | No              | BOL.pdf | transport Name | 0123456789     |
    And Vendor upload POD to inbound inventory
      | anhJPEG.jpg |
    And Click on button "Update"
    And VENDOR check alert message
      | Inbound inventory updated successfully |
    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod        | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Confirmed | Chicagoland Express | Freight Carrier / LTL | Plus1         | 1         | 1                | 1        | 1                   | 1           | 111111  |
    And Vendor check detail info optional of Inbound inventory
      | other               | freight              | reference | estimatedWeek | note      | palletTransit | palletWarehouse | fileBOL | filePOD     | transportName  | transportPhone |
      | Auto other Shipping | Auto freight Carrier | [blank]   | 1             | Auto note | Yes           | No              | BOL.pdf | anhJPEG.jpg | transport Name | 0123456789     |
    And Vendor check detail of SKU in Inbound inventory
      | index | brand                     | product                                      | sku                                      | ofCases | lotCode | expiryDate | temperature   | shelfLife |
      | 1     | Auto brand create product | random product admin inbound inventory 1 api | random sku admin inbound inventory 1 api | 10      | [blank] | [blank]    | 1.0 F - 1.0 F | 1 dayDry  |

  @V_INVENTORY_104
  Scenario: Check information shown for a Requested Inbound inventory when admin creates the inbound inventory with all fields and multiple SKUs
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor inbound inventory 1 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                               | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor inbound inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor inbound inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product vendor inbound inventory 1 api" by api
    And Admin delete product name "random product vendor inbound inventory 1 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                          | brand_id |
      | random product vendor inbound inventory 1 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor inbound inventory 1 api1" of product ""

    And Admin create a "active" SKU from admin with name "random sku vendor inbound inventory 1 api2" of product ""
    And Admin add SKU to Incoming Inventory api
      | skuName                                    | product_variant_id | vendor_company_id | quantity |
      | random sku vendor inbound inventory 1 api1 | random             | 1847              | 10       |
      | random sku vendor inbound inventory 1 api2 | random             | 1847              | 20       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor search inbound inventory on tab "Requested"
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Vendor go to detail of inbound inventory "create by api"
    And Vendor verify instructions of region "Chicagoland Express" in Inbound detail
    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Requested | Chicagoland Express | [blank]        | [blank]       | [blank]   | [blank]          | 1        | 10                  | [blank]     | [blank] |
    And Vendor check detail info optional of Inbound inventory
      | other   | freight | reference | estimatedWeek | note |
      | [blank] | [blank] | [blank]   | 1             | 1    |
    And Vendor check detail of SKU in Inbound inventory
      | index | brand                     | product                                       | sku                                        | ofCases | lotCode | expiryDate | temperature   | shelfLife |
      | 1     | Auto brand create product | random product vendor inbound inventory 1 api | random sku vendor inbound inventory 1 api1 | 10      | [blank] | [blank]    | 1.0 F - 1.0 F | 1 dayDry  |
      | 1     | Auto brand create product | random product vendor inbound inventory 1 api | random sku vendor inbound inventory 1 api2 | 20      | [blank] | [blank]    | 1.0 F - 1.0 F | 1 dayDry  |
    And Vendor input info of inbound inventory
      | deliveryMethod      | estimatedDateArrival | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | trackingNumber | totalWeight | zipCode |
      | Brand Self Delivery | currentDate          | 1         | 1                | 1              | 1                         | 1              | 1           | 11111   |
    And Edit info SKU of inbound inventory
      | index | sku                                        | caseOfSku | productLotCode | expiryDate |
      | 1     | random sku vendor inbound inventory 1 api1 | 10        | random         | Plus1      |
      | 1     | random sku vendor inbound inventory 1 api2 | 20        | random         | Plus1      |
    And Click on button "Update"
    And VENDOR check alert message
      | Inbound inventory updated successfully |

    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod      | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Confirmed | Chicagoland Express | Brand Self Delivery | currentDate   | 1         | 1                | 1        | 30                  | 1           | 11111   |
    And Vendor check detail info optional of Inbound inventory
      | other   | freight | reference | estimatedWeek | note |
      | [blank] | [blank] | [blank]   | 1             | 1    |
    And Vendor check detail of SKU in Inbound inventory
      | index | brand                     | product                                       | sku                                        | ofCases | lotCode | expiryDate | temperature   | shelfLife |
      | 1     | Auto brand create product | random product vendor inbound inventory 1 api | random sku vendor inbound inventory 1 api1 | 10      | random  | Plus1      | 1.0 F - 1.0 F | 1 dayDry  |
      | 1     | Auto brand create product | random product vendor inbound inventory 1 api | random sku vendor inbound inventory 1 api2 | 20      | random  | Plus1      | 1.0 F - 1.0 F | 1 dayDry  |
    And Click on any text "< Back to List Inbound Inventory"
    And Vendor search inbound inventory on tab "All"
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Vendor verify search result in Send Inventory
      | number        | region              | eta         | status    |
      | create by api | Chicagoland Express | currentDate | Confirmed |

  @V_INVENTORY_128
  Scenario: Check vendor can edit the SKUs field
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor inbound inventory 1 api" by api
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                               | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor inbound inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inbound inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product vendor inbound inventory 1 api" by api
    And Admin delete product name "random product vendor inbound inventory 1 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                          | brand_id |
      | random product vendor inbound inventory 1 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor inbound inventory 1 api 1" of product ""

    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
      | random             | 1847              | 20       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor search inbound inventory on tab "Requested"
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Vendor go to detail of inbound inventory "create by api"
    And Vendor input info of inbound inventory
      | deliveryMethod      | estimatedDateArrival | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | trackingNumber | totalWeight | zipCode |
      | Brand Self Delivery | currentDate          | 1         | 1                | 1              | 1                         | 1              | 1           | 11111   |
    And Edit info SKU of inbound inventory
      | index | sku                                         | caseOfSku | productLotCode | expiryDate |
      | 1     | random sku vendor inbound inventory 1 api 1 | 10        | random         | Minus1     |
      | 2     | random sku vendor inbound inventory 1 api 1 | 20        | random         | Minus1     |
    And Vendor check error message is showing of fields
      | field       | message                                                                               |
      | Expiry date | Products need to arrive at Pod Foods DCs with at least 75% total shelf life remaining |
    And Click on button "Update"
    And VENDOR check alert message
      | Same product variants can't have same expire date |

  @V_INVENTORY_146 @V_INVENTORY_149
  Scenario: Received Inbound inventory
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor inbound inventory 1 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                               | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor inbound inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor inbound inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product vendor inbound inventory 1 api" by api
    And Admin delete product name "random product vendor inbound inventory 1 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                            | brand_id |
      | random product vendor inbound inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor inbound inventory 1 api 1" of product ""

    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |
#Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                         | lot_code                             | quantity | expiry_date |
      | random sku vendor inbound inventory 1 api 1 | sku vendor inbound inventory 1 api 1 | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
 #    Upload file inbound
    And Admin upload file Incoming Inventory id "api" api
      | fileBOL | filePOD |
      | BOL.pdf | POD.png |
#    Mark as received
    And Admin Mark as received Incoming Inventory id "api" api
#    Processed inbound
#    And Admin Process Incoming Inventory id "api" api

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor search inbound inventory on tab "All"
      | region              | startDate   | endDate |
      | Chicagoland Express | currentDate | Plus1   |
    And Vendor verify search result in Send Inventory
      | number        | region              | eta   | status   |
      | create by api | Chicagoland Express | Plus1 | Received |
    And Vendor search inbound inventory on tab "Received"
      | region              | startDate   | endDate |
      | Chicagoland Express | currentDate | Plus1   |
    And Vendor verify search result in Send Inventory
      | number        | region              | eta   | status   |
      | create by api | Chicagoland Express | Plus1 | Received |
    And Vendor go to detail of inbound inventory "create by api"
    And Vendor check detail of Inbound inventory
      | status   | region              | deliveryMethod        | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Received | Chicagoland Express | Freight Carrier / LTL | Plus1         | 1         | 1                | 1        | 1                   | 1           | 11111   |
    And Vendor check detail info optional of Inbound inventory
      | other        | freight         | reference        | estimatedWeek | note | palletTransit | palletWarehouse | fileBOL | filePOD | transportName              | transportPhone | trackingNumber  |
      | other_detail | freight_carrier | reference_number | 1             | 1    | [blank]       | [blank]         | BOL.pdf | POD.png | transport_coordinator_name | 1234567890     | tracking_number |
    And Vendor check detail of SKU in Inbound inventory
      | index | brand                     | product                                       | sku                                       | ofCases | lotCode                              | expiryDate | temperature   | shelfLife |
      | 1     | Auto brand create product | random product vendor inbound inventory 1 api | random sku vendor inbound inventory 1 api | 10      | sku vendor inbound inventory 1 api 1 | [blank]    | 1.0 F - 1.0 F | 1 dayDry  |
    And Check field "Select Express Region" is disabled
    And Check field "Select Inbound Delivery Method" is disabled
    And Check field "Estimated Date of Arrival" is disabled
    And Check field "# of Pallets" is disabled
    And Check field "# of Sellable Retail Cases per Master Carton" is disabled
    And Check field "Estimated Weeks of Inventory" is disabled
    And Check field "Total weight of shipment" is disabled
    And Check field "# of cases" is disabled
    And Check field "Expiry date" is disabled
    And Vendor input info of inbound inventory
      | deliveryMethod | estimatedDateArrival | ofPallets | ofSellableRetailPerCarton | totalWeight | zipCode |
      | [blank]        | [blank]              | [blank]   | [blank]                   | [blank]     | 11112   |
    And Vendor input info optional of inbound inventory
      | otherShipping       | freightCarrier       | trackingNumber | referenceNumber       | estimatedWeek | note      | palletTransit | palletWarehouse | fileBOL | transportName  | transportPhone |
      | Auto other Shipping | Auto freight Carrier | [blank]        | Auto reference number | [blank]       | Auto note | Yes           | No              | [blank] | transport Name | 0123456789     |
    And Click on button "Update"
    And VENDOR check alert message
      | Inbound inventory updated successfully |

    And Vendor check detail of Inbound inventory
      | status   | region              | deliveryMethod        | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Received | Chicagoland Express | Freight Carrier / LTL | Plus1         | 1         | 1                | 1        | 1                   | 1           | 11112   |
    And Vendor check detail info optional of Inbound inventory
      | other               | freight              | reference             | estimatedWeek | note      | palletTransit | palletWarehouse | fileBOL | filePOD | transportName  | transportPhone | trackingNumber  |
      | Auto other Shipping | Auto freight Carrier | Auto reference number | 1             | Auto note | Yes           | No              | BOL.pdf | POD.png | transport Name | 0123456789     | tracking_number |
#    Processed inbound
    And Admin Process Incoming Inventory id "api" api
    And VENDOR refresh browser
    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod        | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Processed | Chicagoland Express | Freight Carrier / LTL | Plus1         | 1         | 1                | 1        | 1                   | 1           | 11112   |
    And Check field "Select Express Region" is disabled
    And Check field "Select Inbound Delivery Method" is disabled
    And Check field "Estimated Date of Arrival" is disabled
    And Check field "# of Pallets" is disabled
    And Check field "# of Sellable Retail Cases per Master Carton" is disabled
    And Check field "Other special shipping details" is disabled
    And Check field "Freight Carrier" is disabled
    And Check field "Reference #" is disabled
    And Check field "Estimated Weeks of Inventory" is disabled
    And Check field "Total weight of shipment" is disabled
    And Check field "What zip code is the shipment coming from?" is disabled
    And Check field "Notes" is disabled
    And Check field "Name" is disabled
    And Check field "Phone number" is disabled
    And Check field "# of cases" is disabled
    And Check field "Expiry date" is disabled
    And Check field "Product Lot code" is disabled

  @V_INVENTORY_170
  Scenario: Canceled Inbound inventory
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor inbound inventory 170 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                 | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor inbound inventory 170 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor inbound inventory 170 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product vendor inbound inventory 170 api" by api
    And Admin delete product name "random product vendor inbound inventory 170 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                              | brand_id |
      | random product vendor inbound inventory 170 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor inbound inventory 170 api 1" of product ""
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |
#Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                           | lot_code                               | quantity | expiry_date |
      | random sku vendor inbound inventory 170 api 1 | sku vendor inbound inventory 170 api 1 | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
#     Upload file inbound
    And Admin upload file Incoming Inventory id "api" api
      | fileBOL | filePOD |
      | BOL.pdf | POD.png |
    And Admin cancel Incoming Inventory id "api" by api
      | reason    |
      | auto note |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor search inbound inventory on tab "All"
      | region              | startDate   | endDate | showCanceled | reference     |
      | Chicagoland Express | currentDate | Plus1   | Yes          | create by api |
    And Vendor verify search result in Send Inventory
      | number        | region              | eta   | status   |
      | create by api | Chicagoland Express | Plus1 | Canceled |
    And Vendor go to detail of inbound inventory "create by api"
    And Vendor check detail of Inbound inventory
      | status   | region              | deliveryMethod        | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Canceled | Chicagoland Express | Freight Carrier / LTL | Plus1         | 1         | 1                | 1        | 1                   | 1           | 11111   |
    And Vendor check detail info optional of Inbound inventory
      | other        | freight         | reference        | estimatedWeek | note | palletTransit | palletWarehouse | fileBOL | filePOD | transportName              | transportPhone | trackingNumber  |
      | other_detail | freight_carrier | reference_number | 1             | 1    | [blank]       | [blank]         | BOL.pdf | POD.png | transport_coordinator_name | 1234567890     | tracking_number |
    And Vendor check detail of SKU in Inbound inventory
      | index | brand                     | product                                         | sku                                         | ofCases | lotCode                                | expiryDate | temperature   | shelfLife |
      | 1     | Auto brand create product | random product vendor inbound inventory 170 api | random sku vendor inbound inventory 170 api | 10      | sku vendor inbound inventory 170 api 1 | [blank]    | 1.0 F - 1.0 F | 1 dayDry  |
    And Check field "Select Express Region" is disabled
    And Check field "Select Inbound Delivery Method" is disabled
    And Check field "Estimated Date of Arrival" is disabled
    And Check field "# of Pallets" is disabled
    And Check field "# of Sellable Retail Cases per Master Carton" is disabled
    And Check field "Estimated Weeks of Inventory" is disabled
    And Check field "Total weight of shipment" is disabled
    And Check field "# of cases" is disabled
    And Check field "Expiry date" is disabled
    And Check field "Freight Carrier" is disabled
    And Check field "Reference #" is disabled
    And Check field "Total weight of shipment" is disabled
    And Check field "What zip code is the shipment coming from?" is disabled
    And Check field "Notes" is disabled
    And Check field "Name" is disabled
    And Check field "Phone number" is disabled
    And Check field "# of cases" is disabled
    And Check field "Expiry date" is disabled
    And Check field "Product Lot code" is disabled
    And Check button "Update" is disabled

  @V_INVENTORY_150
  Scenario: Verify Withdrawal Requests list
    Given BAO10 login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor withdraw inventory 150 api" by api
#      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku vendor withdraw inventory 150 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor withdraw inventory 150 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor withdraw inventory 150 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product vendor withdraw inventory 150 api" by api
    And Admin delete product name "random product vendor withdraw inventory 150 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                               | brand_id |
      | random product vendor withdraw inventory 150 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 150 api 1" of product ""

    Given BAO10 login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 150 api 1 | random             | 5        | random sku vendor withdraw inventory 150 api 1 | 99           | Plus1        | Plus1       | [blank] |

      #Create Withdrawal
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                             | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku vendor withdraw inventory 150 api 1 | 5        | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | index | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 1     | 26        | 1847              | currentDate | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check 12 number record on pagination
    And Vendor click "2" on pagination
    And Vendor click "back" on pagination
    And Vendor check 12 number record on pagination
    And Vendor click "next" on pagination
    And Vendor click "1" on pagination
    And Vendor check withdrawal request just created on tab "All"
      | number        | requestDate | pickupDate  | case | status    |
      | create by api | currentDate | currentDate | 1    | Submitted |
    And Vendor check withdrawal request just created on tab "Submitted"
      | number        | requestDate | pickupDate  | case | status    |
      | create by api | currentDate | currentDate | 1    | Submitted |
    And Vendor check withdrawal request number "create by api" not show on tab "Approved"
    And Vendor check withdrawal request number "create by api" not show on tab "Completed"

  @V_INVENTORY_154 @V_INVENTORY_171
  Scenario: Request a Withdrawal (Create form)
    Given BAO10 login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor withdraw inventory 154 api" by api
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku vendor withdraw inventory 154 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor withdraw inventory 154 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor withdraw inventory 154 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product vendor withdraw inventory 154 api" by api
    And Admin delete product name "random product vendor withdraw inventory 154 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product vendor withdraw inventory 154 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 154 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 154 api 1 | random             | 5        | random sku vendor withdraw inventory 154 api 1 | 99           | Plus1        | Plus1       | [blank] |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 154 api 2" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 2     | random sku vendor withdraw inventory 154 api 2 | random             | 10       | random sku vendor withdraw inventory 154 api 2 | 99           | Plus1        | Plus1       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region              | carrier     | nameContact  | palletWeight | comment | bol          |
      | Plus7      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Auto contact | 10           | comment | data/BOL.pdf |
    And Vendor search value "random sku vendor withdraw inventory 154 api 1" and add lot to withdrawal request
      | sku                                            | product                                          | brand                     | lotCode                                        | currentQty | endQty | pulledQty |
      | random sku vendor withdraw inventory 154 api 1 | random product vendor withdraw inventory 154 api | Auto brand create product | random sku vendor withdraw inventory 154 api 1 | 5          | 5      | 0         |
    And Vendor remove sku with lot code to withdrawal request
      | index | sku                                            | lotCode                                        |
      | 1     | random sku vendor withdraw inventory 154 api 1 | random sku vendor withdraw inventory 154 api 1 |
    And Vendor search value "random product vendor withdraw inventory 154 api" and add lot to withdrawal request
      | sku                                            | product                                          | brand                     | lotCode                                        | currentQty | endQty | pulledQty |
      | random sku vendor withdraw inventory 154 api 1 | random product vendor withdraw inventory 154 api | Auto brand create product | random sku vendor withdraw inventory 154 api 1 | 5          | 5      | 0         |
      | random sku vendor withdraw inventory 154 api 2 | random product vendor withdraw inventory 154 api | Auto brand create product | random sku vendor withdraw inventory 154 api 2 | 10         | 10     | 0         |
    And Vendor search value "random product vendor withdraw inventory 154 api " and check lot added on withdrawal request
      | sku                                            |
      | random sku vendor withdraw inventory 154 api 1 |
      | random sku vendor withdraw inventory 154 api 2 |

  @V_INVENTORY_157
  Scenario: Check validating required fields
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region  | carrier | nameContact | palletWeight | comment | bol     |
      | [blank]    | [blank]    | [blank]  | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] |
    And Click on button "Create"
#    And VENDOR check alert message
#      | Please correct the errors on this form before continuing. |
    And Vendor check error message is showing of fields
      | field               | message                                  |
      | Pickup date         | Please enter pickup date                 |
      | Pickup region       | Please select pickup region              |
      | Name of Contact     | Please enter pickup partner name         |
      | Pickup time (Start) | Please select pickup start time          |
      | Pickup time (End)   | Please select pickup end time            |
      | Withdrawal Details  | Please select at least one inventory lot |
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region              | carrier | nameContact  | palletWeight | comment | bol     |
      | Plus7      | 09:30      | 10:00    | Chicagoland Express | [blank] | Auto contact | 10           | [blank] | [blank] |
    And Vendor check error message not showing of fields
      | field               | message                          |
      | Pickup date         | Please enter pickup date         |
      | Pickup region       | Please select pickup region      |
      | Name of Contact     | Please enter pickup partner name |
      | Pickup time (Start) | Please select pickup start time  |
      | Pickup time (End)   | Please select pickup end time    |

  @V_INVENTORY_158
  Scenario: Check validating required fields 2
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor verify field in create withdrawal
      | pickupDate | pickupFrom | pickupTo | region           | carrier     | nameContact | palletWeight | comment | bol        |
      | Plus6      | 09:00      | 09:30    | New York Express | Self Pickup | Bao         | 10           | comment | anhPNG.png |

  @V_INVENTORY_165
  Scenario: Check validating required fields 3
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor verify blank value in create withdrawal with carrier is "Self Pickup"

  @V_INVENTORY_165
  Scenario: Check validating required fields 4
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor verify blank value in create withdrawal with carrier is "Carrier Pickup"

  @V_INVENTORY_164 @V_INVENTORY_168
  Scenario: Check validating required fields Pickup region
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor create withdrawal request
      | pickupDate | pickupFrom          | pickupTo | region  | carrier | nameContact | palletWeight | comment | bol     |
      | [blank]    | Chicagoland Express | [blank]  | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] |
    And Vendor create withdrawal request
      | pickupDate | pickupFrom      | pickupTo | region  | carrier | nameContact | palletWeight | comment | bol     |
      | [blank]    | Florida Express | [blank]  | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] |
    And Vendor create withdrawal request
      | pickupDate | pickupFrom     | pickupTo | region  | carrier | nameContact | palletWeight | comment | bol     | contactEmail |
      | [blank]    | Dallas Express | [blank]  | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | a            |
    And Vendor check error message not showing of fields
      | field         | message                    |
      | Contact email | Please enter a valid email |

  @V_INVENTORY_169 @V_INVENTORY_177 @V_INVENTORY_192
  Scenario: Verify the Withdrawal Details section
    Given BAO10 login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor withdraw inventory 192 api" by api
#      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku vendor withdraw inventory 192 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor withdraw inventory 192 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor withdraw inventory 192 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product vendor withdraw inventory 192 api" by api
    And Admin delete product name "random product vendor withdraw inventory 192 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                               | brand_id |
      | random product vendor withdraw inventory 192 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 192 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 192 api 1 | random             | 5        | random   | 99           | Plus1        | Plus1       | [blank] |

      #Create Withdrawal
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                             | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku vendor withdraw inventory 192 api 1 | 5        | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | index | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 1     | 26        | 1847              | currentDate | 09:30      | 10:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |

    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 192 api 2" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 2     | random sku vendor withdraw inventory 192 api 2 | random             | 5        | random   | 99           | Plus1        | Plus1       | [blank] |
#    Create pull qty
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 2        | Autotest |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number        | requestDate | pickupDate  | case | status    |
      | create by api | currentDate | currentDate | 1    | Submitted |
    And Vendor go to detail of withdrawal request "create by api"
      | status    | pickupDate  | pickupFrom | pickupTo | region              | type           | carrier             | palletWeight | comment | bol     |
      | Submitted | currentDate | 09:30      | 10:00    | Chicagoland Express | Carrier Pickup | pickup_partner_name | 1            | comment | BOL.pdf |
    And Vendor check lots in detail of withdrawal request
      | index | brand                     | product                                          | sku                                            | skuID | lotCode | quantity |
      | 1     | Auto brand create product | random product vendor withdraw inventory 192 api | random sku vendor withdraw inventory 192 api 1 | #     | random  | 1        |
    And Vendor search value "random sku vendor withdraw inventory 192 api 2" and add lot to withdrawal request
      | index | sku                                            | product                                          | brand                     | lotCode | currentQty | endQty | pulledQty |
      | 2     | random sku vendor withdraw inventory 192 api 2 | random product vendor withdraw inventory 192 api | Auto brand create product | random  | 3          | 3      | 2         |
    And Vendor search value "random sku vendor withdraw inventory 192 api 2" and check lot added on withdrawal request
      | sku                                            |
#      | random sku vendor withdraw inventory 192 api 1 |
      | random sku vendor withdraw inventory 192 api 2 |
    And Vendor close popup
    And Click on button "Update"
    And Vendor check error message is showing of fields
      | field      | message                    |
      | # of cases | This field cannot be blank |
    And Vendor input lot code info to withdrawal request
      | index | sku                                            | lotCode | lotQuantity | max     |
      | 2     | random sku vendor withdraw inventory 192 api 2 | random  | 1           | [blank] |
    And Click on button "Update"
    And VENDOR check alert message
      | Withdraw items withdraw case must be in range 2..5 |
    And Vendor input lot code info to withdrawal request
      | index | sku                                            | lotCode | lotQuantity | max     |
      | 2     | random sku vendor withdraw inventory 192 api 2 | random  | 2           | [blank] |
    And Vendor remove sku with lot code to withdrawal request
      | index | sku                                            | lotCode |
      | 1     | random sku vendor withdraw inventory 192 api 1 | random  |
    And Click on button "Update"
    And VENDOR check alert message
      | Withdrawal inventory updated successfully. |
    And Vendor check lots in detail of withdrawal request
      | index | brand                     | product                                          | sku                                            | skuID | lotCode | quantity |
      | 2     | Auto brand create product | random product vendor withdraw inventory 192 api | random sku vendor withdraw inventory 192 api 2 | #     | random  | 2        |
    And Click on any text "< Back to Withdrawal Requests"
    And Vendor go to detail of withdrawal request "create by api"
      | status    | pickupDate  | pickupFrom | pickupTo | region              | type           | carrier             | palletWeight | comment | bol     |
      | Submitted | currentDate | 09:30      | 10:00    | Chicagoland Express | Carrier Pickup | pickup_partner_name | 2            | comment | BOL.pdf |
    And Vendor check lots in detail of withdrawal request
      | index | brand                     | product                                          | sku                                            | skuID | lotCode | quantity |
      | 2     | Auto brand create product | random product vendor withdraw inventory 192 api | random sku vendor withdraw inventory 192 api 2 | #     | random  | 2        |

  @V_INVENTORY_179
  Scenario: Check the selected lots list is reset to blank whenever the "Pickup region" field is changed
    Given BAO10 login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor withdraw inventory 179 api" by api
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku vendor withdraw inventory 179 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor withdraw inventory 179 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor withdraw inventory 179 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product vendor withdraw inventory 179 api" by api
    And Admin delete product name "random product vendor withdraw inventory 179 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                               | brand_id |
      | random product vendor withdraw inventory 179 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 179 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 179 api 1 | random             | 5        | random sku vendor withdraw inventory 179 api 1 | 99           | Plus1        | Plus1       | [blank] |

      #Create Withdrawal
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                             | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku vendor withdraw inventory 179 api 1 | 5        | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | index | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 1     | 26        | 1847              | currentDate | 09:30      | 10:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |

    And Clear Info of Region api
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 179 api 2" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 2     | random sku vendor withdraw inventory 179 api 2 | random             | 5        | random sku vendor withdraw inventory 179 api 2 | 95           | Plus1        | Plus1       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number        | requestDate | pickupDate  | case | status    |
      | create by api | currentDate | currentDate | 1    | Submitted |
    And Vendor go to detail of withdrawal request "create by api"
      | status    | pickupDate  | pickupFrom | pickupTo | region              | type           | carrier             | palletWeight | comment | bol     |
      | Submitted | currentDate | 09:30      | 10:00    | Chicagoland Express | Carrier Pickup | pickup_partner_name | 1            | comment | BOL.pdf |
    And Vendor check lots in detail of withdrawal request
      | index | brand                     | product                                          | sku                                          | skuID | lotCode                                        | quantity |
      | 1     | Auto brand create product | random product vendor withdraw inventory 179 api | random sku vendor withdraw inventory 179 api | #     | random sku vendor withdraw inventory 179 api 1 | 1        |
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region          | carrier | nameContact | palletWeight | comment | bol     |
      | [blank]    | [blank]    | [blank]  | Florida Express | [blank] | [blank]     | [blank]      | [blank] | [blank] |
    And Vendor search value "random sku vendor withdraw inventory 179 api 2" and add lot to withdrawal request
      | sku                                            | product                                          | brand                     | lotCode                                        | currentQty | endQty | pulledQty |
      | random sku vendor withdraw inventory 179 api 2 | random product vendor withdraw inventory 179 api | Auto brand create product | random sku vendor withdraw inventory 179 api 2 | 5          | 5      | 0         |
    And Vendor input lot code info to withdrawal request
      | index | sku                                            | lotCode                                        | lotQuantity | max |
      | 1     | random sku vendor withdraw inventory 179 api 2 | random sku vendor withdraw inventory 179 api 2 | 1           | Yes |
    And Vendor go to detail of withdrawal request "create by api"
      | status    | pickupDate  | pickupFrom | pickupTo | region          | type           | carrier             | palletWeight | comment | bol     |
      | Submitted | currentDate | 09:30      | 10:00    | Florida Express | Carrier Pickup | pickup_partner_name | 5            | comment | BOL.pdf |
    And Vendor check lots in detail of withdrawal request
      | index | brand                     | product                                          | sku                                            | skuID | lotCode                                        | quantity |
      | 1     | Auto brand create product | random product vendor withdraw inventory 179 api | random sku vendor withdraw inventory 179 api 2 | #     | random sku vendor withdraw inventory 179 api 2 | 5        |

    And Click on button "Update"
    And VENDOR check alert message
      | Withdrawal inventory updated successfully. |
    And Vendor check lots in detail of withdrawal request
      | index | brand                     | product                                          | sku                                            | skuID | lotCode                                        | quantity |
      | 1     | Auto brand create product | random product vendor withdraw inventory 179 api | random sku vendor withdraw inventory 179 api 2 | #     | random sku vendor withdraw inventory 179 api 2 | 5        |
    And Click on any text "< Back to Withdrawal Requests"
    And Vendor go to detail of withdrawal request "create by api"
      | status    | pickupDate  | pickupFrom | pickupTo | region          | type           | carrier             | palletWeight | comment | bol     |
      | Submitted | currentDate | 09:30      | 10:00    | Florida Express | Carrier Pickup | pickup_partner_name | 5            | comment | BOL.pdf |
    And Vendor check lots in detail of withdrawal request
      | index | brand                     | product                                          | sku                                            | skuID | lotCode                                        | quantity |
      | 1     | Auto brand create product | random product vendor withdraw inventory 179 api | random sku vendor withdraw inventory 179 api 2 | #     | random sku vendor withdraw inventory 179 api 2 | 5        |

  @V_INVENTORY_184
  Scenario: Request a Withdrawal (Create form)
    Given BAO10 login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor withdraw inventory 184 api" by api
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku vendor withdraw inventory 184 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor withdraw inventory 184 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor withdraw inventory 184 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product vendor withdraw inventory 184 api" by api
    And Admin delete product name "random product vendor withdraw inventory 184 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                               | brand_id |
      | random product vendor withdraw inventory 184 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 184 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 184 api 1 | random             | 5        | random sku vendor withdraw inventory 184 api 1 | 99           | Plus1        | Plus1       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region              | carrier     | nameContact  | palletWeight | comment | bol          |
      | Plus7      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Auto contact | 5            | comment | data/BOL.pdf |
    And Vendor search value "random sku vendor withdraw inventory 184 api 1" and add lot to withdrawal request
      | sku                                            | product                                          | brand                     | lotCode                                        | currentQty | endQty | pulledQty |
      | random sku vendor withdraw inventory 184 api 1 | random product vendor withdraw inventory 184 api | Auto brand create product | random sku vendor withdraw inventory 184 api 1 | 5          | 5      | 0         |
    And Vendor input lot code info to withdrawal request
      | index | sku                                            | lotCode                                        | lotQuantity | max     |
      | 1     | random sku vendor withdraw inventory 184 api 1 | random sku vendor withdraw inventory 184 api 1 | 5           | [blank] |
    And Vendor click create withdrawal request
    And Vendor go to detail of withdrawal request ""
      | status    | pickupDate | pickupFrom | pickupTo | region              | type        | name         | palletWeight | comment | bol     |
      | Submitted | Plus6      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Auto contact | 5            | comment | BOL.pdf |
    And Vendor check lots in detail of withdrawal request
      | index | brand                     | product                                            | sku                                          | skuID | lotCode                                        | quantity |
      | 1     | Auto brand create product | random product vendor withdraw inventory 184 api 1 | random sku vendor withdraw inventory 184 api | #     | random sku vendor withdraw inventory 184 api 1 | 5        |

    Given BAO_ADMIN10 open web admin
    When BAO_ADMIN10 login to web with role Admin
    And BAO_ADMIN10 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin search withdraw request
      | number          | vendorCompany | brand   | region  | status    | startDate | endDate |
      | create by admin | [blank]       | [blank] | [blank] | Submitted | [blank]   | [blank] |
    And Admin go to detail withdraw request number ""
    And Admin check general information "submitted" withdrawal request
      | vendorCompany       | pickupDate | startTime | endTime  | region              | pickupType  | partner      | palletWeight | status    | comment | bol     | buttonWPL |
      | Auto vendor company | Plus6      | 09:30 am  | 10:00 am | Chicagoland Express | Self pickup | Auto contact | 5 lbs        | Submitted | comment | BOL.pdf | [blank]   |
    And Admin check lot code in withdrawal request
      | index | product                                          | sku                                            | lotCode                                        | endQty | case |
      | 1     | random product vendor withdraw inventory 184 api | random sku vendor withdraw inventory 184 api 1 | random sku vendor withdraw inventory 184 api 1 | 5      | 5    |

  @V_INVENTORY_207 @V_INVENTORY_210
  Scenario: Approved Withdrawal Requests - Completed Withdrawal Requests
    Given BAO10 login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor withdraw inventory 207 api" by api
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku vendor withdraw inventory 150 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor withdraw inventory 207 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor withdraw inventory 207 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product vendor withdraw inventory 207 api" by api
    And Admin delete product name "random product vendor withdraw inventory 207 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product vendor withdraw inventory 207 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 150 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 150 api 1 | random             | 5        | random sku vendor withdraw inventory 150 api 1 | 99           | Plus1        | Plus1       | [blank] |
      #Create Withdrawal
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                             | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku vendor withdraw inventory 150 api 1 | 5        | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | index | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 1     | 26        | 1847              | currentDate | 09:30      | 10:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |
     #approve withdrawal
    And Admin approve withdrawal request "create by api" by api

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number        | requestDate | pickupDate  | case | status   |
      | create by api | currentDate | currentDate | 1    | Approved |
    And Vendor check withdrawal request just created on tab "Approved"
      | number  | requestDate | pickupDate  | case | status   |
      | [blank] | currentDate | currentDate | 1    | Approved |
    And Vendor go to detail of withdrawal request "create by api"
      | status   | pickupDate  | pickupFrom | pickupTo | region              | type           | carrier             | palletWeight | comment | bol     | address                                                               |
      | Approved | currentDate | 09:30      | 10:00    | Chicagoland Express | Carrier Pickup | pickup_partner_name | 1            | comment | BOL.pdf | Auto Ngoc LP Mix 011060 West Addison Street, Chicago, Illinois, 60613 |
    And Vendor check lots in detail of withdrawal request
      | index | brand                     | product                                          | sku                                          | skuID | lotCode                                        | quantity |
      | 1     | Auto brand create product | random product vendor withdraw inventory 207 api | random sku vendor withdraw inventory 150 api | #     | random sku vendor withdraw inventory 150 api 1 | 1        |
    And Check field "Pickup date" is disabled
    And Check field "Pickup region" is disabled
    And Check field "Pickup time (Start)" is disabled
    And Check field "Pickup time (End)" is disabled
    And Check field "Are you using a freight carrier?" is disabled
    And Check field "Carrier" is disabled
    And Check field "Contact email" is disabled
    And Check field "Pallet weight in total" is disabled
    And Check field "Comment" is disabled
    And Check field "# of cases" is disabled
    And Vendor update BOL is "data/10MBgreater.jpg"
    And Click on button "Update"
    And Vendor check alert message
      | Attachment File size should be less than 10 MB |
    And Vendor update BOL is "data/BOL1.pdf"
    And Click on button "Update"
    And Vendor check alert message
      | Withdrawal inventory updated successfully. |
    And Vendor go to detail of withdrawal request "create by api"
      | status   | pickupDate  | pickupFrom | pickupTo | region              | type           | carrier             | palletWeight | comment | bol      | address                                                               |
      | Approved | currentDate | 09:30      | 10:00    | Chicagoland Express | Carrier Pickup | pickup_partner_name | 1            | comment | BOL1.pdf | Auto Ngoc LP Mix 011060 West Addison Street, Chicago, Illinois, 60613 |

  #    Complete withdrawal
    And Admin complete withdrawal request "create by api" by api
    And Vendor refresh browser
    And Vendor go to detail of withdrawal request "create by api"
      | status    | pickupDate  | pickupFrom | pickupTo | region              | type           | carrier             | palletWeight | comment | bol      |
      | Completed | currentDate | 09:30      | 10:00    | Chicagoland Express | Carrier Pickup | pickup_partner_name | 1            | comment | BOL1.pdf |
    And Check field "Pickup date" is disabled
    And Check field "Pickup region" is disabled
    And Check field "Pickup time (Start)" is disabled
    And Check field "Pickup time (End)" is disabled
    And Check field "Are you using a freight carrier?" is disabled
    And Check field "Carrier" is disabled
    And Check field "Contact email" is disabled
    And Check field "Pallet weight in total" is disabled
    And Check field "Comment" is disabled
    And Check field "# of cases" is disabled
    And Check button "Add new inventory" is disable
    And Check any button "not" showing on screen
      | Update |
      | Create |
    And Click on any text "< Back to Withdrawal Requests"
    And Vendor check withdrawal request just created on tab "Completed"
      | number  | requestDate | pickupDate  | case | status    |
      | [blank] | currentDate | currentDate | 1    | Completed |

  @V_INVENTORY_212
  Scenario: Verify Dispose / Donate Inventory list
    Given BAO10 login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor withdraw inventory 212 api" by api
     # Delete dispose donate request
    And Admin search dispose donate request by API
      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[request_type] | q[status] | q[start_date] | q[end_date] | page |
      | [blank]   | 1847                 | [blank]     | [blank]      | [blank]         | [blank]   | [blank]       | [blank]     | 1    |
    And Admin delete all inventory request by API
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor withdraw inventory 212 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor withdraw inventory 212 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product vendor withdraw inventory 212 api" by api
    And Admin delete product name "random product vendor withdraw inventory 212 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product vendor withdraw inventory 212 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 212 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 212 api 1 | random             | 10       | random sku vendor withdraw inventory 212 api 1 | 99           | Plus1        | Plus1       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to dispose donate inventory page
    And Vendor go to create request dispose donate inventory
    And Vendor fill info request dispose donate
      | type                           | region              | comment      |
      | Dispose of Inventory / Destroy | Chicagoland Express | Auto comment |
    And Vendor add inventory to request dispose
      | index | sku                                            | lotCode                                        | quantity |
      | 1     | random sku vendor withdraw inventory 212 api 1 | random sku vendor withdraw inventory 212 api 1 | 5        |
    And Vendor create request dispose success
    Then Vendor verify information of request dispose detail
      | status    | type                           | region              | comment      |
      | Submitted | Dispose of Inventory / Destroy | Chicagoland Express | Auto comment |
    And Vendor check fee apply of request donate dispose
      | feeDonation                   | feeDisposal                   |
      | $.50/case (Min Charge of $50) | $.50/case (Min Charge of $50) |
    And Vendor verify detail inventory of request dispose detail
      | index | brand                     | product                                          | sku                                            | skuID   | lotCode                                        | expiryDate | pullDate | ofCase | max |
      | 1     | Auto brand create product | random product vendor withdraw inventory 212 api | random sku vendor withdraw inventory 212 api 1 | [blank] | random sku vendor withdraw inventory 212 api 1 | Plus1      | [blank]  | 5      | 10  |
    And Vendor get number dispose donate request
    And Click on any text "< Back"
    And Vendor go to tab "All" in dispose donate inventory page
    And Vendor verify inventory request
      | number | requestDate | type     | case | status    |
      | random | currentDate | Disposal | 5    | Submitted |
    And Vendor go to tab "Submitted" in dispose donate inventory page
    And Vendor verify inventory request
      | number | requestDate | type     | case | status    |
      | random | currentDate | Disposal | 5    | Submitted |
    And Vendor go to tab "Approved" in dispose donate inventory page
    And Vendor verify inventory request number "random" not show on list
    And Vendor go to tab "Completed" in dispose donate inventory page
    And Vendor verify inventory request number "random" not show on list

  @V_INVENTORY_215
  Scenario: Request a Dispose / Donate Inventory (Create form)
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to dispose donate inventory page
    And Vendor go to create request dispose donate inventory
    And Vendor check fee apply of request donate dispose
      | feeDonation                   | feeDisposal                   |
      | $.50/case (Min Charge of $50) | $.50/case (Min Charge of $50) |
    And Click on button "Create"
    And Vendor check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check error message is showing of fields
      | field             | message                                  |
      | Donate or Dispose | This field cannot be blank               |
      | Pickup region     | This field cannot be blank               |
      | Details           | Please select at least one inventory lot |
    And Vendor fill info request dispose donate
      | type                                | region                   | comment |
      | Donate Inventory to Local Food Bank | Chicagoland Express      | [blank] |
      | Dispose of Inventory / Destroy      | florida Express          | [blank] |
      | [blank]                             | Mid Atlantic Express     | [blank] |
      | [blank]                             | New York Express         | [blank] |
      | [blank]                             | North California Express | [blank] |
      | [blank]                             | South California Express | [blank] |
      | [blank]                             | Texas California Express | [blank] |
    And Vendor check error message not showing of fields
      | field             | message                    |
      | Donate or Dispose | This field cannot be blank |
      | Pickup region     | This field cannot be blank |

  @V_INVENTORY_222
  Scenario: Verify Dispose / Donate Inventory list Verify the Find lots by brand, product, SKU, or lot code... search box
    Given BAO10 login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor withdraw inventory 212 api" by api
     # Delete dispose donate request
    And Admin search dispose donate request by API
      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[request_type] | q[status] | q[start_date] | q[end_date] | page |
      | [blank]   | 1847                 | [blank]     | [blank]      | [blank]         | [blank]   | [blank]       | [blank]     | 1    |
    And Admin delete all inventory request by API
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor withdraw inventory 212 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor withdraw inventory 212 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product vendor withdraw inventory 212 api" by api
    And Admin delete product name "random product vendor withdraw inventory 212 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product vendor withdraw inventory 212 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 212 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 212 api 1 | random             | 5        | random sku vendor withdraw inventory 212 api 1 | 99           | Plus1        | Plus1       | [blank] |
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 212 api 1 | random             | 10       | random sku vendor withdraw inventory 212 api 2 | 99           | Plus1        | Plus1       | [blank] |
 #  Create pull qty not Pull date reached
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 2        | Autotest |
    And Clear Info of Region api
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 212 api 2" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 212 api 2 | random             | 10       | random sku vendor withdraw inventory 212 api 3 | 95           | Plus1        | Plus1       | [blank] |
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 212 api 2 | random             | 10       | random sku vendor withdraw inventory 212 api 4 | 95           | Plus1        | Plus1       | [blank] |
#  Create pull qty not Pull date reached
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 3                       | 10       | Autotest |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to dispose donate inventory page
    And Vendor go to create request dispose donate inventory
    And Vendor fill info request dispose donate
      | type                           | region              | comment      |
      | Dispose of Inventory / Destroy | Chicagoland Express | Auto comment |
    And Vendor search value "random sku vendor withdraw inventory 212 api 2" and add lot to donate dispose request
      | sku                                            | product                                          | brand                     | lotCode                                        | currentQty | endQty | pulledQty |
      | random sku vendor withdraw inventory 212 api 1 | random product vendor withdraw inventory 212 api | Auto brand create product | random sku vendor withdraw inventory 212 api 2 | 8          | 8      | 2         |
    And Vendor remove sku with lot code to donate dispose request
      | lotCode                                        |
      | random sku vendor withdraw inventory 212 api 2 |
    And Vendor search value "random product vendor withdraw inventory 212 api" and add lot to donate dispose request
      | sku                                            | product                                          | brand                     | lotCode                                        | currentQty | endQty | pulledQty |
      | random sku vendor withdraw inventory 212 api 1 | random product vendor withdraw inventory 212 api | Auto brand create product | random sku vendor withdraw inventory 212 api 1 | 5          | 5      | 0         |
      | random sku vendor withdraw inventory 212 api 1 | random product vendor withdraw inventory 212 api | Auto brand create product | random sku vendor withdraw inventory 212 api 2 | 8          | 8      | 2         |
    And Vendor remove sku with lot code to donate dispose request
      | lotCode                                        |
      | random sku vendor withdraw inventory 212 api 1 |
      | random sku vendor withdraw inventory 212 api 2 |
#    And Vendor search value "Auto brand create product" and add lot to donate dispose request
#      | sku                                            | product                                          | brand                     | lotCode                                        | currentQty | endQty | pulledQty |
#      | random sku vendor withdraw inventory 212 api 1 | random product vendor withdraw inventory 212 api | Auto brand create product | random sku vendor withdraw inventory 212 api 2 | 8          | 8      | 2         |
#    And Vendor remove sku with lot code to donate dispose request
#      | lotCode                                        |
#      | random sku vendor withdraw inventory 212 api 2 |
    And Vendor search value "random sku vendor withdraw inventory 212 api 3" and add lot to donate dispose request
      | sku                                            | product                                          | brand                     | lotCode | currentQty | endQty | pulledQty |
      | random sku vendor withdraw inventory 212 api 2 | random product vendor withdraw inventory 212 api | Auto brand create product | [blank] | 8          | 8      | 2         |
    And Vendor close popup
    And Vendor fill info request dispose donate
      | type    | region          | comment |
      | [blank] | Florida Express | [blank] |
    And Vendor search value "random sku vendor withdraw inventory 212 api 4" and add lot to donate dispose request
      | sku                                            | product                                          | brand                     | lotCode | currentQty | endQty | pulledQty |
      | random sku vendor withdraw inventory 212 api 2 | random product vendor withdraw inventory 212 api | Auto brand create product | [blank] | 8          | 8      | 2         |
    And Vendor close popup
    And Vendor fill info request dispose donate
      | type    | region              | comment |
      | [blank] | Chicagoland Express | [blank] |
    And Vendor search value "random sku vendor withdraw inventory 212 api 1" and add lot to donate dispose request
      | sku                                            | product                                          | brand                     | lotCode                                        | currentQty | endQty | pulledQty |
      | random sku vendor withdraw inventory 212 api 1 | random product vendor withdraw inventory 212 api | Auto brand create product | random sku vendor withdraw inventory 212 api 1 | 5          | 5      | 0         |
      | random sku vendor withdraw inventory 212 api 1 | random product vendor withdraw inventory 212 api | Auto brand create product | random sku vendor withdraw inventory 212 api 2 | 8          | 8      | 2         |
    And Vendor search value "random sku vendor withdraw inventory 212 api 1" and check lot added on withdrawal request
      | sku                                            |
      | random sku vendor withdraw inventory 212 api 1 |
    And Vendor close popup
    And Vendor edit item request dispose
      | index | sku                                            | lotCode                                        | ofCases |
      | 1     | random sku vendor withdraw inventory 212 api 1 | random sku vendor withdraw inventory 212 api 1 | 5       |
      | 1     | random sku vendor withdraw inventory 212 api 1 | random sku vendor withdraw inventory 212 api 2 | max     |
    And Vendor create request dispose success
    Then Vendor verify information of request dispose detail
      | status    | type                           | region              | comment      |
      | Submitted | Dispose of Inventory / Destroy | Chicagoland Express | Auto comment |
    And Vendor check fee apply of request donate dispose
      | feeDonation                   | feeDisposal                   |
      | $.50/case (Min Charge of $50) | $.50/case (Min Charge of $50) |
    And Vendor verify detail inventory of request dispose detail
      | index | brand                     | product                                          | sku                                            | skuID   | lotCode                                        | expiryDate | pullDate | ofCase | max |
      | 1     | Auto brand create product | random product vendor withdraw inventory 212 api | random sku vendor withdraw inventory 212 api 1 | [blank] | random sku vendor withdraw inventory 212 api 1 | Plus1      | [blank]  | 5      | 5   |
      | 1     | Auto brand create product | random product vendor withdraw inventory 212 api | random sku vendor withdraw inventory 212 api 1 | [blank] | random sku vendor withdraw inventory 212 api 2 | Plus1      | [blank]  | 10     | 10  |

  @V_INVENTORY_236
  Scenario: Check information displayed for a Submitted Dispose / Donate Inventory created by admin
    Given BAO10 login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor withdraw inventory 236 api" by api
     # Delete dispose donate request
    And Admin search dispose donate request by API
      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[request_type] | q[status] | q[start_date] | q[end_date] | page |
      | [blank]   | 1847                 | [blank]     | [blank]      | [blank]         | [blank]   | [blank]       | [blank]     | 1    |
    And Admin delete all inventory request by API
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor withdraw inventory 236 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor withdraw inventory 236 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
#    And Admin search product name "random product vendor withdraw inventory 236 api" by api
#    And Admin delete product name "random product vendor withdraw inventory 236 api" by api
    And Admin deactivate all product name "random product vendor withdraw inventory 236 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product vendor withdraw inventory 236 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 236 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 236 api 1 | random             | 10       | random sku vendor withdraw inventory 236 api 1 | 99           | Plus1        | Plus1       | [blank] |
    And Admin set inventory request items API
      | sku                                            | inventory_id  | product_variant_id | request_case |
      | random sku vendor withdraw inventory 236 api 1 | create by api | create by api      | 1            |
    And Admin create dispose donate request by API
      | comment      | region_id | request_type | vendor_company_id |
      | Auto comment | 26        | donation     | 1847              |
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 236 api 1 | random             | 5        | random sku vendor withdraw inventory 236 api 2 | 99           | Plus1        | Plus1       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to dispose donate inventory page
    And Vendor go to tab "All" in dispose donate inventory page
    And Vendor verify inventory request
      | number        | requestDate | type     | case | status    |
      | create by api | currentDate | Donation | 1    | Submitted |
    And Vendor go to detail inventory request "create by api"
    And Vendor verify information of request dispose detail
      | status    | type                                | region              | comment      |
      | Submitted | Donate Inventory to Local Food Bank | Chicagoland Express | Auto comment |
    And Vendor check fee apply of request donate dispose
      | feeDonation                   | feeDisposal                   |
      | $.50/case (Min Charge of $50) | $.50/case (Min Charge of $50) |
    And Vendor verify detail inventory of request dispose detail
      | index | brand                     | product                                          | sku                                            | skuID   | lotCode                                        | expiryDate | pullDate | ofCase | max |
      | 1     | Auto brand create product | random product vendor withdraw inventory 236 api | random sku vendor withdraw inventory 236 api 1 | [blank] | random sku vendor withdraw inventory 236 api 1 | Plus1      | [blank]  | 1      | 10  |
    And Check field "Pickup region" is disabled
    And Vendor fill info request dispose donate
      | type                           | region  | comment |
      | Dispose of Inventory / Destroy | [blank] | [blank] |
    And Vendor search value "random sku vendor withdraw inventory 236 api 2 index 1" and add lot to donate dispose request
      | sku                                            | product                                          | brand                     | lotCode                                        | currentQty | endQty | pulledQty |
      | random sku vendor withdraw inventory 236 api 1 | random product vendor withdraw inventory 236 api | Auto brand create product | random sku vendor withdraw inventory 236 api 2 | 5          | 5      | 0         |
    And Vendor edit item request dispose
      | index | sku                                            | lotCode                                        | ofCases |
      | 1     | random sku vendor withdraw inventory 236 api 1 | random sku vendor withdraw inventory 236 api 2 | 1       |
    And Click on button "Update"
    And Vendor check alert message
      | Updated successfully. |
    Then Vendor verify information of request dispose detail
      | status    | type                           | region              | comment      |
      | Submitted | Dispose of Inventory / Destroy | Chicagoland Express | Auto comment |
    And Vendor verify detail inventory of request dispose detail
      | index | brand                     | product                                          | sku                                            | skuID   | lotCode                                        | expiryDate | pullDate | ofCase | max |
      | 1     | Auto brand create product | random product vendor withdraw inventory 236 api | random sku vendor withdraw inventory 236 api 1 | [blank] | random sku vendor withdraw inventory 236 api 1 | Plus1      | [blank]  | 1      | 10  |
      | 1     | Auto brand create product | random product vendor withdraw inventory 236 api | random sku vendor withdraw inventory 236 api 1 | [blank] | random sku vendor withdraw inventory 236 api 2 | Plus1      | [blank]  | 1      | 5   |
    And Vendor remove sku with lot code to donate dispose request
      | lotCode                                        |
      | random sku vendor withdraw inventory 236 api 1 |
    And Click on button "Update"
    And Vendor check alert message
      | Updated successfully. |
    Then Vendor verify information of request dispose detail
      | status    | type                           | region              | comment      |
      | Submitted | Dispose of Inventory / Destroy | Chicagoland Express | Auto comment |
    And Vendor verify detail inventory of request dispose detail
      | index | brand                     | product                                          | sku                                            | skuID   | lotCode                                        | expiryDate | pullDate | ofCase | max |
      | 1     | Auto brand create product | random product vendor withdraw inventory 236 api | random sku vendor withdraw inventory 236 api 1 | [blank] | random sku vendor withdraw inventory 236 api 2 | Plus1      | [blank]  | 1      | 5   |

  @V_INVENTORY_237
  Scenario: Check information displayed for a Submitted Dispose / Donate Inventory created by admin
    Given BAO10 login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor withdraw inventory 236 api" by api
     # Delete dispose donate request
    And Admin search dispose donate request by API
      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[request_type] | q[status] | q[start_date] | q[end_date] | page |
      | [blank]   | 1847                 | [blank]     | [blank]      | [blank]         | [blank]   | [blank]       | [blank]     | 1    |
    And Admin delete all inventory request by API
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor withdraw inventory 236 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor withdraw inventory 236 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product vendor withdraw inventory 236 api" by api
    And Admin delete product name "random product vendor withdraw inventory 236 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product vendor withdraw inventory 236 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 236 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 236 api 1 | random             | 10       | random sku vendor withdraw inventory 236 api 1 | 99           | Plus1        | Plus1       | [blank] |
    And Admin set inventory request items API
      | sku                                            | inventory_id  | product_variant_id | request_case |
      | random sku vendor withdraw inventory 236 api 1 | create by api | create by api      | 1            |
    And Admin create dispose donate request by API
      | comment      | region_id | request_type | vendor_company_id |
      | Auto comment | 26        | disposal     | 1847              |
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 236 api 1 | random             | 5        | random sku vendor withdraw inventory 236 api 2 | 99           | Plus1        | Plus1       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to dispose donate inventory page
    And Vendor go to tab "All" in dispose donate inventory page
    And Vendor verify inventory request
      | number        | requestDate | type     | case | status    |
      | create by api | currentDate | Disposal | 1    | Submitted |
    And Vendor go to detail inventory request "create by api"
    And Vendor verify information of request dispose detail
      | status    | type                           | region              | comment      |
      | Submitted | Dispose of Inventory / Destroy | Chicagoland Express | Auto comment |
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 236 api 1 | random             | 10       | random sku vendor withdraw inventory 236 api 1 | 99           | Plus1        | Plus1       | [blank] |
    And Check field "Pickup region" is disabled
    And Vendor fill info request dispose donate
      | type                                | region  | comment |
      | Donate Inventory to Local Food Bank | [blank] | [blank] |
    And Vendor search value "random sku vendor withdraw inventory 236 api 2" and add lot to donate dispose request
      | sku                                            | product                                          | brand                     | lotCode                                        | currentQty | endQty | pulledQty |
      | random sku vendor withdraw inventory 236 api 1 | random product vendor withdraw inventory 236 api | Auto brand create product | random sku vendor withdraw inventory 236 api 2 | 5          | 5      | 0         |
    And Vendor edit item request dispose
      | index | sku                                            | lotCode                                        | ofCases |
      | 1     | random sku vendor withdraw inventory 236 api 1 | random sku vendor withdraw inventory 236 api 2 | 1       |
    And Click on button "Update"
    And Vendor check alert message
      | Updated successfully. |
    Then Vendor verify information of request dispose detail
      | status    | type                                | region              | comment      |
      | Submitted | Donate Inventory to Local Food Bank | Chicagoland Express | Auto comment |
    And Vendor verify detail inventory of request dispose detail
      | index | brand                     | product                                          | sku                                            | skuID   | lotCode                                        | expiryDate | pullDate | ofCase | max |
      | 1     | Auto brand create product | random product vendor withdraw inventory 236 api | random sku vendor withdraw inventory 236 api 1 | [blank] | random sku vendor withdraw inventory 236 api 1 | Plus1      | [blank]  | 1      | 10  |
      | 1     | Auto brand create product | random product vendor withdraw inventory 236 api | random sku vendor withdraw inventory 236 api 1 | [blank] | random sku vendor withdraw inventory 236 api 2 | Plus1      | [blank]  | 1      | 5   |
    And Vendor remove sku with lot code to donate dispose request
      | lotCode                                        |
      | random sku vendor withdraw inventory 236 api 1 |
    And Click on button "Update"
    And Vendor check alert message
      | Updated successfully. |
    Then Vendor verify information of request dispose detail
      | status    | type                                | region              | comment      |
      | Submitted | Donate Inventory to Local Food Bank | Chicagoland Express | Auto comment |
    And Vendor verify detail inventory of request dispose detail
      | index | brand                     | product                                          | sku                                            | skuID   | lotCode                                        | expiryDate | pullDate | ofCase | max |
      | 1     | Auto brand create product | random product vendor withdraw inventory 236 api | random sku vendor withdraw inventory 236 api 1 | [blank] | random sku vendor withdraw inventory 236 api 2 | Plus1      | [blank]  | 1      | 5   |

  @V_INVENTORY_247
  Scenario: Check Vendor Edit Approved Dispose / Donate Request
    Given BAO10 login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor withdraw inventory 247 api" by api
     # Delete dispose donate request
    And Admin search dispose donate request by API
      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[request_type] | q[status] | q[start_date] | q[end_date] | page |
      | [blank]   | 1847                 | [blank]     | [blank]      | [blank]         | [blank]   | [blank]       | [blank]     | 1    |
    And Admin delete all inventory request by API
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor withdraw inventory 247 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor withdraw inventory 247 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product vendor withdraw inventory 247 api" by api
    And Admin delete product name "random product vendor withdraw inventory 247 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product vendor withdraw inventory 247 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 247 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 247 api 1 | random             | 10       | random sku vendor withdraw inventory 247 api 1 | 99           | Plus1        | Plus1       | [blank] |
    And Admin set inventory request items API
      | sku                                            | inventory_id  | product_variant_id | request_case |
      | random sku vendor withdraw inventory 247 api 1 | create by api | create by api      | 1            |
    And Admin create dispose donate request by API
      | comment      | region_id | request_type | vendor_company_id |
      | Auto comment | 26        | disposal     | 1847              |
    And Admin approved dispose donate request by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to dispose donate inventory page
    And Vendor go to tab "All" in dispose donate inventory page
    And Vendor verify inventory request
      | number        | requestDate | type     | case | status   |
      | create by api | currentDate | Disposal | 1    | Approved |
    And Vendor go to detail inventory request "create by api"
    And Vendor verify information of request dispose detail
      | status   | type                           | region              | comment      |
      | Approved | Dispose of Inventory / Destroy | Chicagoland Express | Auto comment |
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 247 api 1 | random             | 10       | random sku vendor withdraw inventory 247 api 1 | 99           | Plus1        | Plus1       | [blank] |
    And Check field "Donate or Dispose" is disabled
    And Check field "Pickup region" is disabled
    And Check field "Comment" is disabled
    And Check button "Add new inventory" is disable
    And Check button "Update" is disable
    Given BAO_ADMIN10 open web admin
    When BAO_ADMIN10 login to web with role Admin
    And BAO_ADMIN10 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName                                        | productName                                      | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku vendor withdraw inventory 247 api 1 | random product vendor withdraw inventory 247 api | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin see detail inventory with lotcode
      | index | skuName                                        | lotCode                                        |
      | 1     | random sku vendor withdraw inventory 247 api 1 | random sku vendor withdraw inventory 247 api 1 |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category | description                           | date        | order   | comment |
      | 1        | Disposed | Created by Disposal/Donation requests | currentDate | [blank] | [blank] |

  @V_INVENTORY_249
  Scenario:Check Vendor Edit Completed Dispose / Donate Inventory Request
    Given BAO10 login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor withdraw inventory 249 api" by api
     # Delete dispose donate request
    And Admin search dispose donate request by API
      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[request_type] | q[status] | q[start_date] | q[end_date] | page |
      | [blank]   | 1847                 | [blank]     | [blank]      | [blank]         | [blank]   | [blank]       | [blank]     | 1    |
    And Admin delete all inventory request by API
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor withdraw inventory 249 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor withdraw inventory 249 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product vendor withdraw inventory 249 api" by api
    And Admin delete product name "random product vendor withdraw inventory 249 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product vendor withdraw inventory 249 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor withdraw inventory 249 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                            | product_variant_id | quantity | lot_code                                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor withdraw inventory 249 api 1 | random             | 10       | random sku vendor withdraw inventory 249 api 1 | 99           | Plus1        | Plus1       | [blank] |
    And Admin set inventory request items API
      | sku                                            | inventory_id  | product_variant_id | request_case |
      | random sku vendor withdraw inventory 249 api 1 | create by api | create by api      | 1            |
    And Admin create dispose donate request by API
      | comment      | region_id | request_type | vendor_company_id |
      | Auto comment | 26        | disposal     | 1847              |
    And Admin approved dispose donate request by API
    And Admin completed dispose donate request by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to dispose donate inventory page
    And Vendor go to tab "All" in dispose donate inventory page
    And Vendor verify inventory request
      | number        | requestDate | type     | case | status    |
      | create by api | currentDate | Disposal | 1    | Completed |
    And Vendor go to tab "Completed" in dispose donate inventory page
    And Vendor verify inventory request
      | number        | requestDate | type     | case | status    |
      | create by api | currentDate | Disposal | 1    | Completed |
    And Vendor go to detail inventory request "create by api"
    And Vendor verify information of request dispose detail
      | status    | type                           | region              | comment      |
      | Completed | Dispose of Inventory / Destroy | Chicagoland Express | Auto comment |
    And Check field "Donate or Dispose" is disabled
    And Check field "Pickup region" is disabled
    And Check field "Comment" is disabled
    And Check button "Add new inventory" is disable
    And Check button "Update" is disable
    Given BAO_ADMIN10 open web admin
    When BAO_ADMIN10 login to web with role Admin
    And BAO_ADMIN10 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName                                        | productName                                      | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku vendor withdraw inventory 249 api 1 | random product vendor withdraw inventory 249 api | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin see detail inventory with lotcode
      | index | skuName                                        | lotCode                                        |
      | 1     | random sku vendor withdraw inventory 249 api 1 | random sku vendor withdraw inventory 249 api 1 |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category | description                           | date        | order   | comment |
      | 1        | Disposed | Created by Disposal/Donation requests | currentDate | [blank] | [blank] |


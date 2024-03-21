#mvn clean verify -Dtestsuite="LPInventoryTestSuite" -Dcucumber.options="src/test/resources/features/lp" -Denvironments=product
@feature=AdminInventory
Feature: Admin Inventory
#  All Inventory
#  1. Show all inventory types: Low quantity, About to expire, Zero quantity
#  - Running low: If the inventory has quantity is less than Low quantity threshold on the Sku form (Different thresholds for a SKU by Express region based on sales history by region). The inventory will be displayed on the All inventories page and the Running low page
#  Formula : Average daily sales over the past 90 days of an Express region *42 days. (E.g. if a brand has average daily sales of Express region A = 1.5 cases. Trigger point when email sends out = 63 cases (rounded up))(E.g. Sum quantity within 90 days is 35, so low quantity threshold = (35*42)/90=16,333> So Low quantity threshold=17)
#  - About to expire: show inventory lots with less than 40% of total shelf life left.
#  Specifically, when (expiry_date - today) < storage_shelf_life_days*0.4 AND lot's end_quantity > 0.
#  The inventory will be displayed on the All inventories page and the About to expire page
#  - Zero quantity: Show inventory information by SKU by region. At the moment we are showing multiple inventory lots by SKU and by region, total End quantity = 0
#  That said, show just one line for SKU A for SF region regardless of how many lots we have on hand for the SKU in SF.
#
#  2. Inventory management:
#  - if order quantity <= inventory quantity:
#  a) auto-confirm the order,
#  b) assign delivery method as Pod consignment,
#  c) don't send an order reminder email
#  - if order quantity > inventory quantity:
#  a) Send order confirmation emails as usual. The inventory-specific notification emails will be sent separately
#
#  3. Inventory deduction rule:
#  1st rule: select most-prioritized warehouse in the order that has sufficient inventory and closest with store. If there's no warehouse with sufficient inventory, don't auto-confirm the line-item (this rule will use for inventory with the different warehouse)
#  2nd rule: Pull from earliest receive date. (From this rule it will be used for inventory with the same warehouse)
#  3rd rule : If receive dates are the same, pull from the lot with the earliest expiration date
#  4th rule: If both receive dates and expiration dates are the same, pull from the lot with lowest end-qty of cases
#  5th rule: Pull from the lot with the earliest data-entry date
########################################
#   Display of All inventory page
#   Product: Show product name. click on icon -> Lnk to product detail screen
#  - SKU: Show SKU name. Click on SKU -> Go to inventory detail of this SKU
#  - Lot code: Show Lot code
#  - Original Qty: Show Original Qty (number)
#  - Current Qty: Show Current Qty (number)
#  - End Qty: Show End Qty (number)
#  - Pull qty: Sum of quantities of subtraction with category of subtraction is Pull date reached and has no sub-category selected (Pullable PDR qty)
#  - Expiry: Show Expiry (date)
#  - Pull date: Pull date = Expiry date - Pull threshold. If Expiry date is null -> show nothing
#  - Receive: Show Receive (date)
#  - Distribution center: Show Distribution center
#  - Vendor company: Show vendor company name. Click on icon -> Link to Vendor company detail screen
#  - Region: Show stamp of region. Hover on stamp -> show region name
#  - ID: Show ID
#  - Created by: Show role created. If Created by is LP, click on icon -> Link to LP details screen

  @AD_Inventory_1 @AD_Inventory_4
  Scenario: Check display of All inventory page
    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar

    And Check button "Export" is enabled
    And Check button "Create" is enabled
    And Admin refresh inventory list
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Check field "SKU name / Item code" is enabled
    And Check field "Product name" is enabled
    And Check field "Vendor company" is enabled
    And Check field "Vendor brand" is enabled
    And Check field "Region" is enabled
    And Check field "Distribution center" is enabled
    And Check field "Created by" is enabled
    And Check field "Lots with 0 current quantity" is enabled
    And Check field "Pulled?" is enabled
    And Check button "Search" is enabled
    And Check button "Reset" is enabled
    Then Admin verify pagination function

  @AD_Inventory_2 @AD_Inventory_3
  Scenario: Check display of Inactive SKU on Inventory list
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inventory 1 api 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 1 api 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 1 api 1" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 1 api 1" by api
    And Admin delete product name "random product admin inventory 1 api 1" by api

#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product admin inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 1 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                | product_variant_id | quantity | lot_code                           | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 1 api 1 | random             | 5        | random sku admin inventory 1 api 1 | 99           | Plus1        | Plus1       | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
    And Admin refresh inventory list
    And Admin search inventory
      | skuName                            | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 1 api 1 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                            | skuName                            | lotCode                            | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 1 api 1 | random sku admin inventory 1 api 1 | random sku admin inventory 1 api 1 | 5                | 5               | 5        | 0            | Plus1      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    And Admin change state of product id "random" to inactive by api
#    And Change state of SKU id: "random sku admin inventory 1 api 1" to "inactive"
    And Admin refresh inventory list
    And Verify result inventory
      | index | productName                            | skuName                            | lotCode                            | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 1 api 1 | random sku admin inventory 1 api 1 | random sku admin inventory 1 api 1 | 5                | 5               | 5        | 0            | Plus1      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin search inventory
      | skuName                            | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 1 api 1 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
#    And Admin Export Inventory
#    And Admin check content file Export all inventory
#      | inventoryId | sku                                | product                                | brand                     | vendorCompany       | region              | unitUpc      | caseUpc      | originalQuantity | currentQuantity | endQuantity | createBy | lotCode                            | distribution                  | expiryDate | receivingDate | storageShelfLife | storageTemperature |
#      | [blank]     | random sku admin inventory 1 api 1 | random product admin inventory 1 api 1 | Auto brand create product | Auto vendor company | Chicagoland Express | 123123123123 | 123123123123 | 5                | 5               | 5           | Admin    | random sku admin inventory 1 api 1 | Auto Ngoc Distribution CHI 01 | Plus1      | Plus1         | Dry 1 day(s)     | 1.0 F - 1.0 F      |

  @AD_Inventory_5
  Scenario: Search and Filter
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inventory 5 api 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 5 api 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 5 api 1" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 5 api 1" by api
    And Admin delete product name "random product admin inventory 5 api 1" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product admin inventory 5 api 1 | 3018     |
    And Info of Region
      | region               | id | state  | availability | casePrice | msrp |
      | Chzicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 5 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                | product_variant_id | quantity | lot_code                           | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 5 api 1 | random             | 5        | random sku admin inventory 5 api 1 | 99           | Plus1        | Plus1       | [blank] |
#    SKU does not in inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product admin inventory 5 api 2 | 3018     |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 5 api 2" of product ""

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    Search SKU name
    And Admin search inventory
      | skuName                            | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 5 api 2 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin no found data in result
    And Admin reset filter
    And Admin search inventory
      | skuName                            | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 5 api 1 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                            | skuName                            | lotCode                            | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 5 api 1 | random sku admin inventory 5 api 1 | random sku admin inventory 5 api 1 | 5                | 5               | 5        | 0            | Plus1      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
#   Search product name
    And Admin reset filter
    And Admin search inventory
      | skuName | productName                            | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | random product admin inventory 5 api 2 | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin no found data in result
    And Admin reset filter
    And Admin search inventory
      | skuName | productName                            | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | random product admin inventory 5 api 1 | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                            | skuName                            | lotCode                            | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 5 api 1 | random sku admin inventory 5 api 1 | random sku admin inventory 5 api 1 | 5                | 5               | 5        | 0            | Plus1      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
#Search Vendor company
    And Admin reset filter
    And Admin search with invalid field "Vendor company"
      | value                   |
      | Auto vendor company 123 |
    And Click on button "Search"
    And Admin search inventory
      | skuName | productName                            | vendorCompany       | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | random product admin inventory 5 api 1 | Auto vendor company | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                            | skuName                            | lotCode                            | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 5 api 1 | random sku admin inventory 5 api 1 | random sku admin inventory 5 api 1 | 5                | 5               | 5        | 0            | Plus1      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
#Search Vendor brand
    And Admin reset filter
    And Admin search with invalid field "Vendor brand"
      | value                         |
      | Auto brand create product 123 |
    And Click on button "Search"
    And Admin search inventory
      | skuName | productName                            | vendorCompany | vendorBrand               | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | random product admin inventory 5 api 1 | [blank]       | Auto brand create product | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                            | skuName                            | lotCode                            | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 5 api 1 | random sku admin inventory 5 api 1 | random sku admin inventory 5 api 1 | 5                | 5               | 5        | 0            | Plus1      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
#Search Region
    And Admin reset filter
    And Admin search inventory
      | skuName | productName                            | vendorCompany | vendorBrand | region                   | distribution | createdBy | lotCode | pulled  |
      | [blank] | [blank]                                | [blank]       | [blank]     | Atlanta Express          | [blank]      | [blank]   | [blank] | [blank] |
      | [blank] | [blank]                                | [blank]       | [blank]     | Denver Express           | [blank]      | [blank]   | [blank] | [blank] |
      | [blank] | [blank]                                | [blank]       | [blank]     | Phoenix Express          | [blank]      | [blank]   | [blank] | [blank] |
      | [blank] | [blank]                                | [blank]       | [blank]     | Sacramento Express       | [blank]      | [blank]   | [blank] | [blank] |
      | [blank] | [blank]                                | [blank]       | [blank]     | Florida Express          | [blank]      | [blank]   | [blank] | [blank] |
      | [blank] | [blank]                                | [blank]       | [blank]     | Mid Atlantic Express     | [blank]      | [blank]   | [blank] | [blank] |
      | [blank] | [blank]                                | [blank]       | [blank]     | New York Express         | [blank]      | [blank]   | [blank] | [blank] |
      | [blank] | [blank]                                | [blank]       | [blank]     | North California Express | [blank]      | [blank]   | [blank] | [blank] |
      | [blank] | [blank]                                | [blank]       | [blank]     | South California Express | [blank]      | [blank]   | [blank] | [blank] |
#      | [blank] | [blank]                                | [blank]       | [blank]     | Texas Express                  | [blank]      | [blank]   | [blank] | [blank] |
      | [blank] | [blank]                                | [blank]       | [blank]     | Dallas Express           | [blank]      | [blank]   | [blank] | [blank] |
      | [blank] | [blank]                                | [blank]       | [blank]     | Pod Direct Central       | [blank]      | [blank]   | [blank] | [blank] |
      | [blank] | [blank]                                | [blank]       | [blank]     | Pod Direct East          | [blank]      | [blank]   | [blank] | [blank] |
#      | [blank] | [blank]                                | [blank]       | [blank]     | Pod Direct Southeast           | [blank]      | [blank]   | [blank] | [blank] |
#      | [blank] | [blank]                                | [blank]       | [blank]     | Pod Direct Southwest & Rockies | [blank]      | [blank]   | [blank] | [blank] |
      | [blank] | [blank]                                | [blank]       | [blank]     | Pod Direct West          | [blank]      | [blank]   | [blank] | [blank] |
      | [blank] | random product admin inventory 5 api 1 | [blank]       | [blank]     | Chicagoland Express      | [blank]      | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                            | skuName                            | lotCode                            | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 5 api 1 | random sku admin inventory 5 api 1 | random sku admin inventory 5 api 1 | 5                | 5               | 5        | 0            | Plus1      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
#Search Distribution
    And Admin reset filter
    And Admin search with invalid field "Distribution center"
      | value                           |
      | Auto Ngoc Distribution CHI 0123 |
    And Click on button "Search"
    And Admin search inventory
      | skuName | productName                            | vendorCompany | vendorBrand | region  | distribution                  | createdBy | lotCode | pulled  |
      | [blank] | random product admin inventory 5 api 1 | [blank]       | [blank]     | [blank] | Auto Ngoc Distribution CHI 01 | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                            | skuName                            | lotCode                            | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 5 api 1 | random sku admin inventory 5 api 1 | random sku admin inventory 5 api 1 | 5                | 5               | 5        | 0            | Plus1      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
#Search Create by
    And Admin reset filter
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy         | lotCode | pulled  |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | Logistics partner | [blank] | [blank] |
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | -         | [blank] | [blank] |
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | Admin     | [blank] | [blank] |
   #Search Lots with 0 current quantity
    And Admin reset filter
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | -       | [blank] |
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | Hide    | [blank] |
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | Show    | [blank] |
   #Search Pulled
    And Admin reset filter
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | -      |
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | Yes    |
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | No     |
   #Search with combine conditions
    And Admin reset filter
    And Admin search inventory
      | skuName                            | productName                            | vendorCompany       | vendorBrand               | region              | distribution                  | createdBy | lotCode | pulled |
      | random sku admin inventory 5 api 1 | random product admin inventory 5 api 1 | Auto vendor company | Auto brand create product | Chicagoland Express | Auto Ngoc Distribution CHI 01 | Admin     | Show    | No     |
    And Verify result inventory
      | index | productName                            | skuName                            | lotCode                            | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 5 api 1 | random sku admin inventory 5 api 1 | random sku admin inventory 5 api 1 | 5                | 5               | 5        | 0            | Plus1      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Hover on any text on screen
      | Auto vendo… |
#    And Check any text "is" showing on screen
#      | Auto vendor company |
    And Hover on any text on screen
      | CHI |
#    And Check any text "is" showing on screen
#      | Chicagoland Express |

  @AD_Inventories_5
  Scenario: All Inventories page - Check display of the Edit visibility popup
    Given BAO_ADMIN22 login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
     # Reset search filter full textbox
    And Admin filter visibility with id "10" by api
      | q[brand_id]            |
      | q[warehouse_id]        |
      | q[creator_type]        |
      | q[pulled]              |
      | q[vendor_company_id]   |
      | q[product_name]        |
      | q[region_id]           |
      | q[current_quantity_gt] |
      | q[product_variant_id]  |
    And Admin delete filter preset of screen id "10" by api
    Given BAO_ADMIN22 open web admin
    When BAO_ADMIN22 login to web with role Admin
    And BAO_ADMIN22 navigate to "Inventories" to "All inventory" by sidebar
    And Admin edit visibility search all inventory
      | skuNameItemCode | vendorCompany | region  | createBy | pulled  | productName | vendorBrand | distributionCenter | lotsWithZeroQuantity |
      | [blank]         | [blank]       | [blank] | [blank]  | [blank] | [blank]     | [blank]     | [blank]            | [blank]              |
    Then Admin verify search inventory field "not" visible
      | skuNameItemCode | vendorCompany | region  | createBy | pulled  | productName | vendorBrand | distributionCenter | lotsWithZeroQuantity |
      | [blank]         | [blank]       | [blank] | [blank]  | [blank] | [blank]     | [blank]     | [blank]            | [blank]              |
    And Admin edit visibility search all inventory
      | skuNameItemCode | vendorCompany | region  | createBy | pulled  | productName | vendorBrand | distributionCenter | lotsWithZeroQuantity |
      | [blank]         | [blank]       | [blank] | [blank]  | [blank] | [blank]     | [blank]     | [blank]            | [blank]              |
    Then Admin verify search inventory field "is" visible
      | skuNameItemCode | vendorCompany | region  | createBy | pulled  | productName | vendorBrand | distributionCenter | lotsWithZeroQuantity |
      | [blank]         | [blank]       | [blank] | [blank]  | [blank] | [blank]     | [blank]     | [blank]            | [blank]              |
    And Admin edit visibility search all inventory
      | skuNameItemCode | vendorCompany | region  | createBy | pulled  |
      | [blank]         | [blank]       | [blank] | [blank]  | [blank] |
    Then Admin verify search inventory field "not" visible
      | skuNameItemCode | vendorCompany | region  | createBy | pulled  |
      | [blank]         | [blank]       | [blank] | [blank]  | [blank] |
    Then Admin verify search inventory field "is" visible
      | productName | vendorBrand | distributionCenter | lotsWithZeroQuantity |
      | [blank]     | [blank]     | [blank]            | [blank]              |
    And Admin edit visibility search all inventory
      | skuNameItemCode | vendorCompany | region  | createBy | pulled  |
      | [blank]         | [blank]       | [blank] | [blank]  | [blank] |
    Then Admin verify search inventory field "is" visible
      | skuNameItemCode | vendorCompany | region  | createBy | pulled  | productName | vendorBrand | distributionCenter | lotsWithZeroQuantity |
      | [blank]         | [blank]       | [blank] | [blank]  | [blank] | [blank]     | [blank]     | [blank]            | [blank]              |
    And Admin search inventory
      | skuName              | productName  | vendorCompany       | vendorBrand               | region          | distribution                      | createdBy | lotCode | pulled |
      | Auto SKU 1 promotion | auto product | Auto vendor company | Auto brand create product | Atlanta Express | Auto Distribution Atlanta Express | Admin     | Hide    | No     |
    And Admin save filter by info
      | filterName | type               |
      | [blank]    | Save as new preset |
    And BAO_ADMIN22 check error message is showing of fields on dialog
      | field       | message                         |
      | Preset name | Please enter name filter preset |
    And Admin close dialog form
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN22 check value of field
      | field                        | value                             |
      | SKU name / Item code         | Auto SKU 1 promotion              |
      | Product name                 | auto product                      |
      | Vendor brand                 | Auto brand create product         |
      | Vendor company               | Auto vendor company               |
      | Region                       | Atlanta Express                   |
      | Distribution center          | Auto Distribution Atlanta Express |
      | Created by                   | Admin                             |
      | Lots with 0 current quantity | Hide                              |
      | Pulled?                      | No                                |
    And Admin reset filter
    And Admin save filter by info
      | filterName | type               |
      | AutoTest2  | Save as new preset |
    And Admin search inventory
      | skuName              | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | Auto SKU 1 promotion | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN22 check value of field
      | field                        | value                |
      | SKU name / Item code         | Auto SKU 1 promotion |
      | Product name                 | [blank]              |
      | Vendor brand                 | -                    |
      | Vendor company               | -                    |
      | Region                       | -                    |
      | Distribution center          | -                    |
      | Created by                   | -                    |
      | Lots with 0 current quantity | -                    |
      | Pulled?                      | -                    |
    And Admin delete filter preset is "AutoTest1"
    Then Admin verify filter "AutoTest1" is not display

    Given BAO_ADMIN23 open web admin
    When BAO_ADMIN23 login to web with role Admin
    And BAO_ADMIN23 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Admin verify filter "AutoTest2" is not display

  @AD_Inventories_133
  Scenario: About to expire Inventories page - Check display of the Edit visibility popup
    Given BAO_ADMIN22 login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
     # Reset search filter full textbox
    And Admin filter visibility with id "64" by api
      | q[brand_id]                     |
      | q[warehouse_id]                 |
      | q[creator_type]                 |
      | q[vendor_company_id]            |
      | q[product_name]                 |
      | q[region_id]                    |
      | q[product_variant_id]           |
      | q[storage_shelf_life_condition] |
      | q[until_pull_date_type]         |
      | q[pull_date_end]                |
      | q[current_quantity_gt]          |
      | q[pull_date_start]              |
      | q[tag_ids][]                    |
    And Admin delete filter preset of screen id "64" by api
    Given BAO_ADMIN22 open web admin
    When BAO_ADMIN22 login to web with role Admin
    And BAO_ADMIN22 navigate to "Inventories" to "About to expire" by sidebar
    And Admin edit visibility search all inventory
      | skuNameItemCode | vendorCompany | region  | createBy | productName | vendorBrand | distributionCenter | lotsWithZeroQuantity | storageShelfLife | tags    | untilPullDate | pullStartDate | pullEndDate |
      | [blank]         | [blank]       | [blank] | [blank]  | [blank]     | [blank]     | [blank]            | [blank]              | [blank]          | [blank] | [blank]       | [blank]       | [blank]     |
    Then Admin verify search inventory field "not" visible
      | skuNameItemCode | vendorCompany | region  | createBy | productName | vendorBrand | distributionCenter | lotsWithZeroQuantity | storageShelfLife | tags    | untilPullDate | pullStartDate | pullEndDate |
      | [blank]         | [blank]       | [blank] | [blank]  | [blank]     | [blank]     | [blank]            | [blank]              | [blank]          | [blank] | [blank]       | [blank]       | [blank]     |
    And Admin edit visibility search all inventory
      | skuNameItemCode | vendorCompany | region  | createBy | productName | vendorBrand | distributionCenter | lotsWithZeroQuantity | storageShelfLife | tags    | untilPullDate | pullStartDate | pullEndDate |
      | [blank]         | [blank]       | [blank] | [blank]  | [blank]     | [blank]     | [blank]            | [blank]              | [blank]          | [blank] | [blank]       | [blank]       | [blank]     |
    Then Admin verify search inventory field "is" visible
      | skuNameItemCode | vendorCompany | region  | createBy | productName | vendorBrand | distributionCenter | lotsWithZeroQuantity | storageShelfLife | tags    | untilPullDate | pullStartDate | pullEndDate |
      | [blank]         | [blank]       | [blank] | [blank]  | [blank]     | [blank]     | [blank]            | [blank]              | [blank]          | [blank] | [blank]       | [blank]       | [blank]     |
    And Admin edit visibility search all inventory
      | skuNameItemCode | vendorCompany | region  | createBy |
      | [blank]         | [blank]       | [blank] | [blank]  |
    Then Admin verify search inventory field "not" visible
      | skuNameItemCode | vendorCompany | region  | createBy |
      | [blank]         | [blank]       | [blank] | [blank]  |
    Then Admin verify search inventory field "is" visible
      | productName | vendorBrand | distributionCenter | lotsWithZeroQuantity | storageShelfLife | tags    | untilPullDate | pullStartDate | pullEndDate |
      | [blank]     | [blank]     | [blank]            | [blank]              | [blank]          | [blank] | [blank]       | [blank]       | [blank]     |
    And Admin edit visibility search all inventory
      | skuNameItemCode | vendorCompany | region  | createBy |
      | [blank]         | [blank]       | [blank] | [blank]  |
    Then Admin verify search inventory field "is" visible
      | skuNameItemCode | vendorCompany | region  | createBy | productName | vendorBrand | distributionCenter | lotsWithZeroQuantity | storageShelfLife | tags    | untilPullDate | pullStartDate | pullEndDate |
      | [blank]         | [blank]       | [blank] | [blank]  | [blank]     | [blank]     | [blank]            | [blank]              | [blank]          | [blank] | [blank]       | [blank]       | [blank]     |
    And Admin search expire inventory
      | skuName              | productName    | vendorCompany       | vendorBrand               | region          | distribution                      | createdBy | lotZero | storageSheftLife | tag   | dayUntilPullDateCondition | dayUntilPullDate | pullStartDate | pullEndDate |
      | Auto SKU 1 promotion | random product | Auto vendor company | Auto brand create product | Atlanta Express | Auto Distribution Atlanta Express | Admin     | Hide    | Dry              | 11111 | [blank]                   | 1                | currentDate   | currentDate |
    And Admin save filter by info
      | filterName | type               |
      | [blank]    | Save as new preset |
    And BAO_ADMIN22 check error message is showing of fields on dialog
      | field       | message                         |
      | Preset name | Please enter name filter preset |
    And Admin close dialog form
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN22 check value of field
      | field                        | value                             |
      | SKU name / Item code         | Auto SKU 1 promotion              |
      | Product name                 | random product                    |
      | Vendor brand                 | Auto brand create product         |
      | Vendor company               | Auto vendor company               |
      | Region                       | Atlanta Express                   |
      | Distribution center          | Auto Distribution Atlanta Express |
      | Created by                   | Admin                             |
      | Lots with 0 current quantity | Hide                              |
      | Storage shelf life           | Dry                               |
      | Tags                         | 11111                             |
#      | Days until pull date         | 1                                 |
      | Pull start date              | currentDate                       |
      | Pull end date                | currentDate                       |
    And Admin reset filter
    And Admin save filter by info
      | filterName | type               |
      | AutoTest2  | Save as new preset |
    And Admin search expire inventory
      | skuName              | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotZero | storageSheftLife | tag     | dayUntilPullDateCondition | dayUntilPullDate | pullStartDate | pullEndDate |
      | Auto SKU 1 promotion | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN22 check value of field
      | field                        | value                |
      | SKU name / Item code         | Auto SKU 1 promotion |
      | Product name                 | [blank]              |
      | Vendor brand                 | -                    |
      | Vendor company               | -                    |
      | Region                       | -                    |
      | Distribution center          | -                    |
      | Created by                   | -                    |
      | Lots with 0 current quantity | -                    |
      | Storage shelf life           | -                    |
      | Tags                         | -                    |
#      | Days until pull date         | [blank]              |
      | Pull start date              | [blank]              |
      | Pull end date                | [blank]              |
    And Admin delete filter preset is "AutoTest1"
    Then Admin verify filter "AutoTest1" is not display

    Given BAO_ADMIN23 open web admin
    When BAO_ADMIN23 login to web with role Admin
    And BAO_ADMIN23 navigate to "Inventories" to "About to expire" by sidebar
    And Admin search expire inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotZero | storageSheftLife | tag     | dayUntilPullDateCondition | dayUntilPullDate | pullStartDate | pullEndDate |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
    Then Admin verify filter "AutoTest2" is not display

  @AD_Inventories_212
  Scenario: Running low Inventories page - Check display of the Edit visibility popup
    Given BAO_ADMIN29 login web admin by api
      | email             | password  |
      | bao29@podfoods.co | 12345678a |
     # Reset search filter full textbox
    And Admin filter visibility with id "65" by api
      | q[brand_id]           |
      | q[product_name]       |
      | q[region_id]          |
      | q[product_variant_id] |
      | q[vendor_company_id]  |
    And Admin delete filter preset of screen id "65" by api
    Given BAO_ADMIN29 open web admin
    When BAO_ADMIN29 login to web with role Admin
    And BAO_ADMIN29 navigate to "Inventories" to "Running low" by sidebar
    And Admin edit visibility search all inventory
      | skuNameItemCode | productName | vendorBrand | region  | vendorCompany |
      | [blank]         | [blank]     | [blank]     | [blank] | vendorCompany |
    Then Admin verify search inventory field "not" visible
      | skuNameItemCode | productName | vendorBrand | region  | vendorCompany |
      | [blank]         | [blank]     | [blank]     | [blank] | vendorCompany |
    And Admin edit visibility search all inventory
      | skuNameItemCode | productName | vendorBrand | region  | vendorCompany |
      | [blank]         | [blank]     | [blank]     | [blank] | vendorCompany |
    Then Admin verify search inventory field "is" visible
      | skuNameItemCode | productName | vendorBrand | region  | vendorCompany |
      | [blank]         | [blank]     | [blank]     | [blank] | vendorCompany |
    And Admin edit visibility search all inventory
      | skuNameItemCode | productName |
      | [blank]         | [blank]     |
    Then Admin verify search inventory field "not" visible
      | skuNameItemCode | productName |
      | [blank]         | [blank]     |
    Then Admin verify search inventory field "is" visible
      | vendorBrand | region  | vendorCompany |
      | [blank]     | [blank] | vendorCompany |
    And Admin edit visibility search all inventory
      | skuNameItemCode | productName |
      | [blank]         | [blank]     |
    Then Admin verify search inventory field "is" visible
      | skuNameItemCode | productName | vendorBrand | region  | vendorCompany |
      | [blank]         | [blank]     | [blank]     | [blank] | vendorCompany |
    And Admin search inventory in running low
      | skuName              | productName    | vendorCompany       | vendorBrand               | region          |
      | Auto SKU 1 promotion | random product | Auto vendor company | Auto brand create product | Atlanta Express |
    And Admin save filter by info
      | filterName | type               |
      | [blank]    | Save as new preset |
    And BAO_ADMIN29 check error message is showing of fields on dialog
      | field       | message                         |
      | Preset name | Please enter name filter preset |
    And Admin close dialog form
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN22 check value of field
      | field                | value                     |
      | SKU name / Item code | Auto SKU 1 promotion      |
      | Product name         | random product            |
      | Vendor brand         | Auto brand create product |
      | Vendor company       | Auto vendor company       |
      | Region               | Atlanta Express           |
    And Admin reset filter
    And Admin save filter by info
      | filterName | type               |
      | AutoTest2  | Save as new preset |
    And Admin search inventory in running low
      | skuName              | productName | vendorCompany | vendorBrand | region  |
      | Auto SKU 1 promotion | [blank]     | [blank]       | [blank]     | [blank] |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN29 check value of field
      | field                | value                |
      | SKU name / Item code | Auto SKU 1 promotion |
      | Product name         | [blank]              |
      | Vendor brand         | -                    |
      | Vendor company       | -                    |
      | Region               | -                    |
    And Admin delete filter preset is "AutoTest1"
    Then Admin verify filter "AutoTest1" is not display

    Given BAO_ADMIN23 open web admin
    When BAO_ADMIN23 login to web with role Admin
    And BAO_ADMIN23 navigate to "Inventories" to "Running low" by sidebar
    And Admin search inventory in running low
      | skuName | productName | vendorCompany | vendorBrand | region  |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] |
    Then Admin verify filter "AutoTest2" is not display

  @AD_Inventory_25
  Scenario: Inventory List
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |

    And Admin delete order by sku of product "random product admin inventory 25 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 25 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 25 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 25 api" by api
    And Admin delete product name "random product admin inventory 25 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product admin inventory 25 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 25 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 25 api 1 | random             | 5        | random   | 99           | Plus1        | Plus1       | [blank] |
#    SKU 2
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product admin inventory 25 api 2 | 3018     |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 25 api 2" of product ""
    And Admin create inventory api1
      | index | sku                                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 2     | random sku admin inventory 25 api 2 | random             | 10       | random   | 99           | Plus2        | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    Search SKU name
    And Admin search inventory
      | skuName | productName                           | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | random product admin inventory 25 api | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin sort field "SKU" with "ascending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 10              | 10       | 0            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "SKU" with "descending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 10              | 10       | 0            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "SKU" with "descending"
    And Admin sort field "Original Qty" with "ascending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 10              | 10       | 0            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Original Qty" with "descending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 10              | 10       | 0            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Current Qty" with "ascending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 10              | 10       | 0            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Current Qty" with "descending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 10              | 10       | 0            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "End Qty" with "ascending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 10              | 10       | 0            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "End Qty" with "descending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 10              | 10       | 0            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

#    Create pull qty
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 1        | Autotest |

    And Admin search inventory
      | skuName | productName                           | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | random product admin inventory 25 api | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin sort field "Pull Qty" with "ascending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 9               | 9        | 1            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Pull Qty" with "descending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 9               | 9        | 1            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Expiry" with "ascending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 9               | 9        | 1            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Expiry" with "descending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 9               | 9        | 1            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Pull date" with "ascending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 9               | 9        | 1            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Pull date" with "descending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 9               | 9        | 1            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Receive" with "ascending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 9               | 9        | 1            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Receive" with "descending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 9               | 9        | 1            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Vendor Company" with "ascending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 9               | 9        | 1            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Vendor Company" with "descending"
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 25 api 1 | random sku admin inventory 25 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 25 api 2 | random sku admin inventory 25 api 2 | randomIndex | 10               | 9               | 9        | 1            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
#Clear Data
    And Admin delete order by sku of product "random product admin inventory 25 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 25 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 25 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 25 api" by api
    And Admin delete product name "random product admin inventory 25 api" by api

  @AD_Inventories_27
  Scenario: Inventory List - Checkbox to switch a warehouse
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "product admin inventory 27 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | product admin inventory 27 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "product admin inventory 27 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "product admin inventory 27 api" by api
    And Admin delete product name "product admin inventory 27 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | product admin inventory 27 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku admin inventory 27 api 1" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                     | warehouse_id | receive_date | expiry_date | comment |
      | 1     | sku admin inventory 27 api 1 | random             | 5        | sku admin inventory 27 api 1 | 99           | Plus1        | Plus1       | [blank] |
    #    SKU 2
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | product admin inventory 27 api 2 | 3018     |
    And Admin create a "active" SKU from admin with name "sku admin inventory 27 api 2" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                     | warehouse_id | receive_date | expiry_date | comment |
      | 2     | sku admin inventory 27 api 2 | random             | 10       | sku admin inventory 27 api 2 | 99           | Plus2        | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName                    | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | product admin inventory 27 api | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                      | skuName                      | lotCode                      | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | product admin inventory 27 api 2 | sku admin inventory 27 api 2 | sku admin inventory 27 api 2 | 10               | 10              | 10       | 0            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | product admin inventory 27 api 1 | sku admin inventory 27 api 1 | sku admin inventory 27 api 1 | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin select "a" inventory
      | sku                          |
      | sku admin inventory 27 api 2 |
      | sku admin inventory 27 api 1 |
    And Admin move warehouse inventory to "Bao distribute florida express"
#    And Admin edit distribution of inventory to "Bao distribute florida express"
    And BAO_ADMIN5 check alert message
      | sku admin inventory 27 api 1, sku admin inventory 27 api 2 are not active at the region |
    And Admin close dialog form
    And Verify result inventory
      | index | productName                      | skuName                      | lotCode                      | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | product admin inventory 27 api 1 | sku admin inventory 27 api 1 | sku admin inventory 27 api 1 | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | product admin inventory 27 api 2 | sku admin inventory 27 api 2 | sku admin inventory 27 api 2 | 10               | 10              | 10       | 0            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin select "a" inventory
      | sku                          |
      | sku admin inventory 27 api 1 |
    And Admin move warehouse inventory to "Auto Ngoc Distribution CHI"
#    And Admin edit distribution of inventory to "Auto Ngoc Distribution CHI"
    And BAO_ADMIN5 check alert message
      | Selected items has been updated successfully! |
    And Admin refresh inventory list
    And Verify result inventory
      | index | productName                      | skuName                      | lotCode                      | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | product admin inventory 27 api 1 | sku admin inventory 27 api 1 | sku admin inventory 27 api 1 | 5                | 5               | 5        | 0            | Plus1       | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | product admin inventory 27 api 2 | sku admin inventory 27 api 2 | sku admin inventory 27 api 2 | 10               | 10              | 10       | 0            | currentDate | Minus55  | [blank]          | Plus2       | Auto Ngoc Distribution CHI    | Auto vendor company | CHI    | Admin     |
    And Admin see detail inventory with lotcode "sku admin inventory 27 api 1"
    And Admin create subtraction items
      | quantity | category          | subCategory | comment  |
      | 1        | Pull date reached | Donated     | Autotest |
    And Admin go back with button
    And Admin select "a" inventory
      | sku                          |
      | sku admin inventory 27 api 1 |
    And Admin move warehouse inventory to "Auto Ngoc Distribution CHI"
    And BAO_ADMIN5 check alert message
      | Selected items has been updated successfully! |

  @AD_Inventories_69
  Scenario: Check admin edit Distribution center
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "product admin inventory 69 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | product admin inventory 69 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "product admin inventory 69 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "product admin inventory 69 api" by api
    And Admin delete product name "product admin inventory 69 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | product admin inventory 69 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku admin inventory 69 api 1" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                     | warehouse_id | receive_date | expiry_date | comment |
      | 1     | sku admin inventory 69 api 1 | random             | 5        | sku admin inventory 69 api 1 | 99           | currentDate  | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName                    | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | product admin inventory 69 api | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin see detail inventory with lotcode "sku admin inventory 69 api 1"
    And Verify inventory detail
      | index | product                        | sku                          | createdBy | region              | distributionCenter            | receiveDate | expireDate | pullDate | lotCode                      | originalQty | currentQty | endQty |
      | 1     | product admin inventory 69 api | sku admin inventory 69 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | [blank]    | [blank]  | sku admin inventory 69 api 1 | 5           | 5          | 5      |
    And Admin edit distribution of inventory to "Bao distribute florida express"
    And BAO_ADMIN5 check alert message
      | sku admin inventory 69 api 1 are not active at the region |
    And Click on tooltip button "Cancel"
    And Admin edit distribution of inventory to "Auto Ngoc Distribution CHI"
    And Verify inventory detail
      | index | product                        | sku                          | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode                      | originalQty | currentQty | endQty |
      | 1     | product admin inventory 69 api | sku admin inventory 69 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | sku admin inventory 69 api 1 | 5           | 5          | 5      |

#    And Admin create subtraction items
#      | quantity | category          | subCategory | comment  |
#      | 1        | Pull date reached | Donated     | Autotest |

  @AD_Inventory_35
  Scenario: Inventory List check Pull Qty
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inventory 35 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 35 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 35 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 35 api" by api
    And Admin delete product name "random product admin inventory 35 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product admin inventory 35 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 35 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 35 api 1 | random             | 5        | random   | 99           | Plus1        | Plus1       | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    Search SKU name
    And Admin search inventory
      | skuName                           | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 35 api | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 35 api 1 | random sku admin inventory 35 api 1 | randomIndex | 5                | 5               | 5        | 0            | Plus1      | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
#  Create pull qty not Pull date reached
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 2                       | 1        | Autotest |
    And Admin refresh inventory list
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 35 api 1 | random sku admin inventory 35 api 1 | randomIndex | 5                | 4               | 4        | 0            | Plus1      | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

#  Create subtraction is Pull date reached and do not select Sub Category
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 1        | Autotest |
    And Admin refresh inventory list
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 35 api 1 | random sku admin inventory 35 api 1 | randomIndex | 5                | 3               | 3        | 1            | Plus1      | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

#    Edit subtraction  is Pull date reached and do not select Sub Category to select sub category
    And Admin see detail inventory with lotcode
      | index | skuName                             | lotCode     |
      | 1     | random sku admin inventory 35 api 1 | randomIndex |
    Then Verify inventory detail
      | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | random product admin inventory 35 api 1 | random sku admin inventory 35 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | Plus1       | Plus1      | Minus54  | random  | 5           | 3          | 3      |
    And Admin edit fist subtraction on inventory
      | category | subCategory | comment |
      | [blank]  | Donated     | comment |
    And Admin go back with button
    And Admin refresh inventory list
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 35 api 1 | random sku admin inventory 35 api 1 | randomIndex | 5                | 3               | 3        | 0            | Plus1      | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    #  Create subtraction with Category is Pull date reached and have Sub-category
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 11                      | 1        | Autotest |
    And Admin refresh inventory list
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 35 api 1 | random sku admin inventory 35 api 1 | randomIndex | 5                | 2               | 2        | 0            | Plus1      | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    #Edit Category of subtraction item from Pull date reached to other Category
    And Admin see detail inventory with lotcode
      | index | skuName                             | lotCode     |
      | 1     | random sku admin inventory 35 api 1 | randomIndex |
    Then Verify inventory detail
      | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | random product admin inventory 35 api 1 | random sku admin inventory 35 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | Plus1       | Plus1      | Minus54  | random  | 5           | 2          | 2      |
    And Admin edit fist subtraction on inventory
      | category | subCategory | comment |
      | Donated  | [blank]     | [blank] |
    And Admin go back with button
    And Admin refresh inventory list
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 35 api 1 | random sku admin inventory 35 api 1 | randomIndex | 5                | 2               | 2        | 0            | Plus1      | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

#  Edit Category of subtraction item from not Pull date reached to Pull date reached not select sub category
    And Admin see detail inventory with lotcode
      | index | skuName                             | lotCode     |
      | 1     | random sku admin inventory 35 api 1 | randomIndex |
    Then Verify inventory detail
      | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | random product admin inventory 35 api 1 | random sku admin inventory 35 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | Plus1       | Plus1      | Minus54  | random  | 5           | 2          | 2      |
    And Admin edit fist subtraction on inventory
      | category          | subCategory | comment |
      | Pull date reached | [blank]     | [blank] |
    And Admin go back with button
    And Admin refresh inventory list
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 35 api 1 | random sku admin inventory 35 api 1 | randomIndex | 5                | 2               | 2        | 1            | Plus1      | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    #  Edit subtraction is Pull date reached do not select Sub Category to select Sub category
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 1        | Autotest |
    And Admin refresh inventory list
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 35 api 1 | random sku admin inventory 35 api 1 | randomIndex | 5                | 1               | 1        | 2            | Plus1      | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin see detail inventory with lotcode
      | index | skuName                             | lotCode     |
      | 1     | random sku admin inventory 35 api 1 | randomIndex |
    And Admin edit fist subtraction on inventory
      | category | subCategory | comment |
      | [blank]  | Donated     | [blank] |
    And Admin go back with button
    And Admin refresh inventory list
    And Verify result inventory
      | index | productName                             | skuName                             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 35 api 1 | random sku admin inventory 35 api 1 | randomIndex | 5                | 1               | 1        | 1            | Plus1      | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
#    Clear data
    And Admin delete order by sku of product "random product admin inventory 35 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 35 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 35 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 35 api" by api
    And Admin delete product name "random product admin inventory 35 api" by api

  @AD_Inventory_50
  Scenario: Create new Inventory
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inventory 50 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 50 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 50 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 50 api" by api
    And Admin delete product name "random product admin inventory 50 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product admin inventory 50 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 50 api 1" of product ""
    
      #Create inventory with quantity
    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                  | sku                                 | quantity | lotCode | receiveDate | expiryDate  | comment |
      | Auto Ngoc Distribution CHI 01 | random sku admin inventory 50 api 1 | 10       | random  | currentDate | currentDate | comment |
    And Admin add image to create new inventory
      | index | file        | comment       |
      | 1     | anhJPEG.jpg | Auto Upload 1 |
    And Admin create new inventory success
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 50 api 1 | random sku admin inventory 50 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 10         | 10     | comment |
    And Verify no inventory activities found

  @AD_Inventory_51_to_64 @AD_Inventory_96
  Scenario: Validate Create new Inventory
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inventory 51 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 51 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 51api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 51 api" by api
    And Admin delete product name "random product admin inventory 51 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product admin inventory 51 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 51 api 1" of product ""

      #Create inventory with quantity
    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution | sku     | quantity | lotCode | receiveDate | expiryDate | comment |
      | [blank]      | [blank] | [blank]  | [blank] | [blank]     | [blank]    | [blank] |

    And Admin check region when choose distribution center
      | distribution                            | region |
      | Auto Ngoc Distribution CHI 01           | CHI    |
      | Auto distribute Texas Express           | DAL    |
#      | Auto distribute Texas Express           | TX     |
      | Auto Distribute NewYork                 | NY     |
      | Bao distribute florida express          | FL     |
      | Bao distribute Mid atlantic Express     | MA     |
      | Bao distribute South California Express | LA     |
      | Bao distribute North California express | SF     |
      | Auto Ngoc Distribution CHI 01           | CHI    |
    And Admin check quantity when create inventory
      | action   | value |
      | increase | 2     |
      | increase | 3     |
      | decrease | 2     |
      | decrease | 1     |
    And Admin close dialog form
    And Admin create new inventory
      | distribution | sku     | quantity | lotCode | receiveDate | expiryDate | comment |
      | [blank]      | [blank] | [blank]  | [blank] | [blank]     | [blank]    | [blank] |
    And Click on dialog button "Create"
    And Admin check message is showing of field "Distribution center"
      | Please select a specific warehouse for this inventory |
    And Admin check message is showing of field "SKU"
      | Please select a specific product variant for this inventory |
    And Admin check message is showing of field "Lot code"
      | Please select a specific lot code for this inventory |
    And Admin check message is showing of field "Receive date"
      | Please select a specific receive date for this inventory |
    And Admin create new inventory
      | distribution                  | sku     | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI 01 | [blank] | [blank]  | [blank] | [blank]     | [blank]    | [blank] |
    And Admin check message not showing of field "Distribution center"
      | Please select a specific warehouse for this inventory |
    And Admin create new inventory
      | distribution | sku                                     | quantity | lotCode | receiveDate | expiryDate | comment |
      | [blank]      | random product admin inventory 51 api 1 | [blank]  | [blank] | [blank]     | [blank]    | [blank] |
    And Admin check message not showing of field "SKU"
      | Please select a specific product variant for this inventory |
    And Admin create new inventory
      | distribution | sku     | quantity | lotCode | receiveDate | expiryDate | comment |
      | [blank]      | [blank] | [blank]  | random  | [blank]     | [blank]    | [blank] |
    And Admin check message not showing of field "Lot code"
      | Please select a specific product variant for this inventory |
    And Admin create new inventory
      | distribution | sku     | quantity | lotCode | receiveDate | expiryDate | comment |
      | [blank]      | [blank] | [blank]  | [blank] | currentDate | [blank]    | [blank] |
    And Admin check message not showing of field "Receive date"
      | Please select a specific product variant for this inventory |
    And Admin add image to create new inventory
      | index | file        | comment       |
      | 1     | anhJPEG.jpg | Auto Upload 0 |
      | 2     | anhJPEG.jpg | Auto Upload 1 |
      | 3     | anhJPEG.jpg | Auto Upload 2 |
    And Check any button "not" showing on screen
      | Add a photo |
    And Click on dialog button "Remove"
    And Admin add image to create new inventory
      | index | file        | comment       |
      | 3     | anhJPEG.jpg | Auto Upload 3 |

    And Admin create new inventory
      | distribution                  | sku                                 | quantity   | lotCode | receiveDate | expiryDate  | comment |
      | Auto Ngoc Distribution CHI 01 | random sku admin inventory 50 api 1 | 9999999999 | random  | currentDate | currentDate | comment |
    And Click on dialog button "Create"
    And Admin check alert message
      | 9999999999 is out of range for ActiveModel::Type::Integer with limit 4 bytes |
    And Admin create new inventory
      | distribution | sku     | quantity | lotCode | receiveDate | expiryDate | comment |
      | [blank]      | [blank] | 1        | [blank] | [blank]     | [blank]    | [blank] |
    And Click on dialog button "Remove"
    And Click on dialog button "Add a photo"
    And Click on dialog button "Create"
    And Admin check alert message
      | Inventory images attachment can't be blank |
    And Admin close dialog form
    And Admin create new inventory
      | distribution                  | sku                                 | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI 01 | random sku admin inventory 51 api 1 | 10       | random  | Plus1       | Minus1     | comment |
    And Admin add image to create new inventory
      | index | file            | comment |
      | 1     | 10MBgreater.jpg | [blank] |
    And Admin check alert message
      | Maximum file size exceeded. |
    And Click on dialog button "Remove"
    And Admin add image to create new inventory
      | index | file             | comment |
      | 1     | ImageInvalid.mp4 | [blank] |
    And Click on dialog button "Create"
    And Admin check alert message
      | Validation failed: Attachment content type is invalid |
    And Click on dialog button "Remove"
    And Admin create new inventory success
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 51 api 1 | random sku admin inventory 51 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | Plus1       | Minus1     | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 10         | 10     | comment |
    And Verify no inventory activities found
    And Admin click "Cancel" delete inventory on detail
    And Admin click "OK" delete inventory on detail
    And Admin search inventory
      | skuName                           | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 51 api | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin check no data found

  @AD_Inventory_66
  Scenario: GENERAL INFORMATION - EDIT
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inventory 66 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 66 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 66 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 66 api" by api
    And Admin delete product name "random product admin inventory 66 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product admin inventory 66 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 66 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 66 api 1 | random             | 10       | random   | 99           | currentDate  | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    Search SKU name
    And Admin search inventory
      | skuName                           | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 66 api | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |

    And Admin see detail inventory with lotcode
      | index | skuName                             | lotCode     |
      | 1     | random sku admin inventory 66 api 1 | randomIndex |
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 66 api 1 | random sku admin inventory 66 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 10         | 10     | Empty   |
    And Admin edit general info of inventory
      | receiveDate | expiryDate | lotCode                             | comment        |
      | Plus1       | Plus1      | random sku admin inventory 66 api 1 | comment edited |
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate | pullDate | lotCode                             | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment        |
      | 1     | random product admin inventory 66 api 1 | random sku admin inventory 66 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | Plus1       | Plus1      | [blank]  | random sku admin inventory 66 api 1 | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 10         | 10     | comment edited |

  @AD_Inventory_67
  Scenario: GENERAL INFORMATION - VALIDATE EDIT
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inventory 67 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 67 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 67 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 67 api" by api
    And Admin delete product name "random product admin inventory 67 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product admin inventory 67 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 67 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 67 api 1 | random             | 10       | random   | 99           | currentDate  | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    Search SKU name
    And Admin search inventory
      | skuName                           | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 67 api | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |

    And Admin see detail inventory with lotcode
      | index | skuName                             | lotCode     |
      | 1     | random sku admin inventory 67 api 1 | randomIndex |
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 67 api 1 | random sku admin inventory 67 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 10         | 10     | Empty   |
    And Admin check validate edit general info of inventory

  @AD_Inventory_70 @AD_Inventory_71
  Scenario: GENERAL INFORMATION - CHECK QUANTITY
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inventory 70 api" by api
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku admin inventory 70 api 1" by api
 # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 70 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 70 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 70 api" by api
    And Admin delete product name "random product admin inventory 70 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product admin inventory 70 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 70 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 70 api 1 | random             | 10       | random   | 99           | currentDate  | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    Search SKU name
    And Admin search inventory
      | skuName                           | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 70 api | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |

    And Admin see detail inventory with lotcode
      | index | skuName                             | lotCode     |
      | 1     | random sku admin inventory 70 api 1 | randomIndex |
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 70 api 1 | random sku admin inventory 70 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 10         | 10     | Empty   |

    #  Create subtraction is not Pull date reached and do not select Sub Category
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 2                       | 1        | Autotest |
    And Admin refresh inventory on detail
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 70 api 1 | random sku admin inventory 70 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 9          | 9      | Empty   |

    #Create Withdraw
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                  | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku admin inventory 70 api 1 | 9        | 0             | 1             | currentDate           |
    And Admin create withdraw request api2
      | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 26        | 1847              | currentDate | 09:30      | 10:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |
    And Admin refresh inventory on detail
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 70 api 1 | random sku admin inventory 70 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 9          | 9      | Empty   |

     #approve withdrawal
    And Admin approve withdrawal request "create by api" by api
    And Admin refresh inventory on detail
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 70 api 1 | random sku admin inventory 70 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 8          | 8      | Empty   |

   #  Create subtraction is Pull date reached and do not select Sub Category with qty > currentQty
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment |
      | 1                       | 10       |         |
    And Admin refresh inventory on detail
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 70 api 1 | random sku admin inventory 70 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 8          | 8      | Empty   |

   #  Create subtraction is Pull date reached and do not select Sub Category with qty < currentQty
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment |
      | 1                       | 1        |         |
    And Admin refresh inventory on detail
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 70 api 1 | random sku admin inventory 70 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 7          | 7      | Empty   |

      #Create order unfulfill
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |

      # Fulfilled this order
    And Admin "fulfilled" all line item in order "create by api" by api
    And Admin refresh inventory on detail
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 70 api 1 | random sku admin inventory 70 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 6          | 6      | Empty   |

  @AD_Inventories_74
  Scenario: Check display of Original quantity when admin
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
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

#Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                        | lot_code                                   | quantity | expiry_date |
      | random sku admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
#    Approve inbound
#    And Admin Approve Incoming Inventory id "api" api

#    Upload file inbound
    And Admin upload file Incoming Inventory id "api" api
      | fileBOL | filePOD |
      | BOL.pdf | POD.png |
#    Mark as received
    And Admin Mark as received Incoming Inventory id "api" api
      #    Processed inbound
    And Admin Process Incoming Inventory id "api" api

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    Search SKU name
    And Admin search inventory
      | skuName | productName                                    | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | [blank] | random product admin inbound inventory 1 api 1 | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                                    | skuName                                    | lotCode                                    | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | 10               | 10              | 10       | 0            | Plus1      | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    #Create order unfulfill
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin refresh inventory list
    And Verify result inventory
      | index | productName                                    | skuName                                    | lotCode                                    | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | 10               | 10              | 9        | 0            | Plus1      | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
#    Create pull qty
#    And Admin get ID inventory by lotcote "random sku admin inbound inventory 1 api 1" from API
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 1        | Autotest |
    And Admin refresh inventory list
    And Verify result inventory
      | index | productName                                    | skuName                                    | lotCode                                    | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | 10               | 9               | 8        | 1            | Plus1      | Minus54  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin see detail inventory with lotcode "random sku admin inbound inventory 1 api 1"
    And Verify inventory detail
      | index | product                                        | sku                                        | createdBy | region              | distributionCenter            | receiveDate | expireDate | pullDate | lotCode                             | originalQty | currentQty | endQty |
      | 1     | random product admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | Plus1       | [blank]    | [blank]  | sku admin inbound inventory 1 api 1 | 10          | 9          | 8      |
    And Admin create addition items
      | quantity | category    | comment  |
      | 1        | Cycle count | Autotest |
    And Admin refresh inventory on detail
    And Verify inventory detail
      | index | product                                        | sku                                        | createdBy | region              | distributionCenter            | receiveDate | expireDate | pullDate | lotCode                             | originalQty | currentQty | endQty |
      | 1     | random product admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | Plus1       | [blank]    | [blank]  | sku admin inbound inventory 1 api 1 | 10          | 10         | 9      |
#Edit number of case Incoming
    And Admin edit number of case Incoming Inventory api
      | num_of_master_carton | quantity | status    | lot_code                                   | expiry_date |
      | 11                   | 11       | processed | random sku admin inbound inventory 1 api 1 | currentDate |
    And Admin refresh inventory on detail
    And Verify inventory detail
      | index | product                                        | sku                                        | createdBy | region              | distributionCenter            | receiveDate | expireDate | pullDate | lotCode                             | originalQty | currentQty | endQty |
      | 1     | random product admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | Plus1       | [blank]    | [blank]  | sku admin inbound inventory 1 api 1 | 11          | 11         | 10     |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category          | description                  | date        | order         | comment  |
      | 1        | Cycle count       | Created by bao5@podfoods.co. | currentDate | [blank]       | Autotest |
      | 1        | Pull date reached | Created by bao4@podfoods.co. | currentDate | [blank]       | Autotest |
      | 1        | [blank]           | auto-confirmed, pending      | currentDate | create by api | [blank]  |

  @AD_Inventory_108
  Scenario: Check display of "Create new addition item" popup
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 108 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 108 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 108 api" by api
    And Admin delete product name "random product admin inventory 108 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product admin inventory 108 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 108 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 108 api 1 | random             | 20       | random   | 99           | currentDate  | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    Search SKU name
    And Admin search inventory
      | skuName                            | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 108 api | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin see detail inventory with lotcode
      | index | skuName                              | lotCode     |
      | 1     | random sku admin inventory 108 api 1 | randomIndex |
    And Verify inventory detail
      | index | product                                  | sku                                  | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 108 api 1 | random sku admin inventory 108 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 20          | 20         | 20     | Empty   |
    And Admin create addition items
      | quantity | category    | comment  |
      | 1        | Cycle count | Autotest |
    And Admin refresh inventory on detail
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category    | description                  | date        | order   | comment  |
      | 1        | Cycle count | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
    And Admin create addition items
      | quantity | category           | comment  |
      | 1        | Inbound correction | Autotest |
    And Admin refresh inventory on detail
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category           | description                  | date        | order   | comment  |
      | 1        | Inbound correction | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
      | 1        | Cycle count        | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |

    And Admin create addition items
      | quantity | category  | comment  |
      | 1        | Transfers | Autotest |
    And Admin refresh inventory on detail
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category           | description                  | date        | order   | comment  |
      | 1        | Transfers          | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
      | 1        | Inbound correction | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
      | 1        | Cycle count        | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
    And Admin create addition items
      | quantity | category              | comment  |
      | 1        | Withdrawal adjustment | Autotest |
    And Admin refresh inventory on detail
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category              | description                  | date        | order   | comment  |
      | 1        | Withdrawal adjustment | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
      | 1        | Transfers             | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
      | 1        | Inbound correction    | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
      | 1        | Cycle count           | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
    And Admin create addition items
      | quantity | category | comment  |
      | 1        | Other    | Autotest |
    And Admin refresh inventory on detail
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category              | description                  | date        | order   | comment  |
      | 1        | Other                 | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
      | 1        | Withdrawal adjustment | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
      | 1        | Transfers             | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
      | 1        | Inbound correction    | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
      | 1        | Cycle count           | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest |
    And Verify inventory detail
      | index | product                                  | sku                                  | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 108 api 1 | random sku admin inventory 108 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 20          | 25         | 25     | Empty   |
    And Admin edit fist subtraction on inventory
      | category              | comment         |
      | Withdrawal adjustment | Autotest edited |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category              | description                  | date        | order   | comment         |
      | 1        | Withdrawal adjustment | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest edited |
      | 1        | Withdrawal adjustment | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest        |
      | 1        | Transfers             | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest        |
      | 1        | Inbound correction    | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest        |
      | 1        | Cycle count           | Created by bao5@podfoods.co. | currentDate | [blank] | Autotest        |
    And Admin delete first subtraction items with comment "delete"
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category              | description                                        | date        | order   | comment         |
      | [blank]  | [blank]               | bao5@podfoods.co removed subtraction/addition item | currentDate | [blank] | delete          |
      | 1        | [blank]               | Created by bao5@podfoods.co.                       | currentDate | [blank] | Autotest edited |
      | 1        | Withdrawal adjustment | Created by bao5@podfoods.co.                       | currentDate | [blank] | Autotest        |
      | 1        | Transfers             | Created by bao5@podfoods.co.                       | currentDate | [blank] | Autotest        |
      | 1        | Inbound correction    | Created by bao5@podfoods.co.                       | currentDate | [blank] | Autotest        |
      | 1        | Cycle count           | Created by bao5@podfoods.co.                       | currentDate | [blank] | Autotest        |
    And Verify inventory detail
      | index | product                                  | sku                                  | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 108 api 1 | random sku admin inventory 108 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 20          | 24         | 24     | Empty   |

  @AD_Inventory_73 @AD_Inventory_95
  Scenario: SUBTRACTION ITEM
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku admin inventory 73 api 1" by api
 # Delete inventory
    And Admin delete order by sku of product "random product admin inventory 73 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 73 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 73 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 73 api" by api
    And Admin delete product name "random product admin inventory 73 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product admin inventory 73 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 73 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 73 api 1 | random             | 10       | random   | 99           | currentDate  | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    Search SKU name
    And Admin search inventory
      | skuName                           | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 73 api | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |

    And Admin see detail inventory with lotcode
      | index | skuName                             | lotCode     |
      | 1     | random sku admin inventory 73 api 1 | randomIndex |
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 73 api 1 | random sku admin inventory 73 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 10         | 10     | Empty   |
    And Verify no inventory activities found

   #Create order unfulfill
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    And Admin refresh inventory on detail
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 73 api 1 | random sku admin inventory 73 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 10         | 9      | Empty   |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category | description             | date        | order         | comment |
      | 1        | [blank]  | auto-confirmed, pending | currentDate | create by api | [blank] |
    And Verify subtraction item "show" on tab "Pending (Auto)" of inventory
      | quantity | category | description             | date        | order         | comment |
      | 1        | [blank]  | auto-confirmed, pending | currentDate | create by api | [blank] |
    And Verify subtraction item "not show" on tab "Fulfilled (Auto)" of inventory
      | quantity | category | description             | date        | order         | comment |
      | 1        | [blank]  | auto-confirmed, pending | currentDate | create by api | [blank] |
    And Verify subtraction item "not show" on tab "Manual subtraction" of inventory
      | quantity | category | description             | date        | order         | comment |
      | 1        | [blank]  | auto-confirmed, pending | currentDate | create by api | [blank] |
    And Verify subtraction item "not show" on tab "Removal" of inventory
      | quantity | category | description             | date        | order         | comment |
      | 1        | [blank]  | auto-confirmed, pending | currentDate | create by api | [blank] |

          # Fulfilled this order
    And Admin "fulfilled" all line item in order "create by api" by api
    And Admin refresh inventory on detail
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 73 api 1 | random sku admin inventory 73 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 9          | 9      | Empty   |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category | description               | date        | order         | comment |
      | 1        | [blank]  | auto-confirmed, fulfilled | currentDate | create by api | [blank] |
    And Verify subtraction item "not show" on tab "Pending (Auto)" of inventory
      | quantity | category | description             | date        | order         | comment |
      | 1        | [blank]  | auto-confirmed, pending | currentDate | create by api | [blank] |
    And Verify subtraction item "show" on tab "Fulfilled (Auto)" of inventory
      | quantity | category | description               | date        | order         | comment |
      | 1        | [blank]  | auto-confirmed, fulfilled | currentDate | create by api | [blank] |
    And Verify subtraction item "not show" on tab "Manual subtraction" of inventory
      | quantity | category | description             | date        | order         | comment |
      | 1        | [blank]  | auto-confirmed, pending | currentDate | create by api | [blank] |
    And Verify subtraction item "not show" on tab "Removal" of inventory
      | quantity | category | description             | date        | order         | comment |
      | 1        | [blank]  | auto-confirmed, pending | currentDate | create by api | [blank] |

     #  Create subtraction is Pull date reached and do not select Sub Category
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 1        | Autotest |

    And Admin refresh inventory on detail
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 73 api 1 | random sku admin inventory 73 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 8          | 8      | Empty   |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category          | description                           | date        | order         | comment |
      | 1        | Pull date reached | Created by bao5@podfoods.co. Autotest | currentDate | [blank]       | [blank] |
      | 1        | [blank]           | auto-confirmed, fulfilled             | currentDate | create by api | [blank] |
    And Verify subtraction item "show" on tab "Manual subtraction" of inventory
      | quantity | category          | description                           | date        | order   | comment |
      | 1        | Pull date reached | Created by bao5@podfoods.co. Autotest | currentDate | [blank] | [blank] |
    And Verify subtraction item "not show" on tab "Removal" of inventory
      | quantity | category          | description                           | date        | order   | comment |
      | 1        | Pull date reached | Created by bao5@podfoods.co. Autotest | currentDate | [blank] | [blank] |
    #Create Withdrawal quantity = Pull date reached qty
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                  | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku admin inventory 73 api 1 | 8        | 0             | 2             | currentDate           |
    And Admin create withdraw request api2
      | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 26        | 1847              | currentDate | 09:30      | 10:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |
     #approve withdrawal
    And Admin approve withdrawal request "create by api" by api
    And Admin refresh inventory on detail
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 73 api 1 | random sku admin inventory 73 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 7          | 7      | Empty   |

    And Verify subtraction item "show" on tab "Manual subtraction" of inventory
      | quantity | category  | description                 | date        | order   | comment |
      | 1        | Will call | Created by withdraw request | currentDate | [blank] | [blank] |
      | 1        | Will call | Created by withdraw request | currentDate | [blank] | [blank] |
    And Verify subtraction item "not show" on tab "Removal" of inventory
      | quantity | category  | description                 | date        | order   | comment |
      | 1        | Will call | Created by withdraw request | currentDate | [blank] | [blank] |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category  | description                 | date        | order         | comment |
      | 1        | Will call | Created by withdraw request | currentDate | [blank]       | [blank] |
      | 1        | Will call | Created by withdraw request | currentDate | [blank]       | [blank] |
      | 1        | [blank]   | auto-confirmed, fulfilled   | currentDate | create by api | [blank] |

    And Admin create subtraction items
      | quantity | category          | subCategory | comment |
      | 1        | Pull date reached | Donated     | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category | description                          | date        | order   | comment |
      | 1        | Donated  | Created by bao5@podfoods.co. comment | currentDate | [blank] | [blank] |
    And Verify subtraction item "show" on tab "Manual subtraction" of inventory
      | quantity | category | description                          | date        | order   | comment |
      | 1        | Donated  | Created by bao5@podfoods.co. comment | currentDate | [blank] | [blank] |

    And Admin delete first subtraction items with comment "delete"
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category | description                                        | date        | order   | comment |
      | [blank]  | [blank]  | bao5@podfoods.co removed subtraction/addition item | currentDate | [blank] | delete  |
    And Verify subtraction item "show" on tab "Removal" of inventory
      | quantity | category | description                                        | date        | order   | comment |
      | [blank]  | [blank]  | bao5@podfoods.co removed subtraction/addition item | currentDate | [blank] | delete  |
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 73 api 1 | random sku admin inventory 73 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 10          | 7          | 7      | Empty   |
    #Sort by Order #
    And Click on any text "Order #"
    And Admin wait 1000 mini seconds
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category  | description                                        | date        | order         | comment |
      | [blank]  | [blank]   | bao5@podfoods.co removed subtraction/addition item | currentDate | [blank]       | delete  |
      | 1        | [blank]   | Created by bao5@podfoods.co                        | currentDate | [blank]       | comment |
      | 1        | Will call | Created by withdraw request                        | currentDate | [blank]       | [blank] |
      | 1        | Will call | Created by withdraw request                        | currentDate | [blank]       | [blank] |
      | 1        | [blank]   | auto-confirmed, fulfilled                          | currentDate | create by api | [blank] |

  @AD_Inventory_85
  Scenario: Check display of "Create new subtraction item" popup
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku admin inventory 85 api 1" by api
 # Delete inventory
    And Admin delete order by sku of product "random product admin inventory 85 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 85 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 85 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 85 api" by api
    And Admin delete product name "random product admin inventory 85 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product admin inventory 85 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 85 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 85 api 1 | random             | 20       | random   | 99           | currentDate  | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    Search SKU name
    And Admin search inventory
      | skuName                           | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 85 api | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin see detail inventory with lotcode
      | index | skuName                             | lotCode     |
      | 1     | random sku admin inventory 85 api 1 | randomIndex |
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 85 api 1 | random sku admin inventory 85 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 20          | 20         | 20     | Empty   |
    And Admin create subtraction items
      | quantity | category              | subCategory         | comment |
      | 1        | Donated               | [blank]             | comment |
      | 1        | Disposed              | [blank]             | comment |
      | 1        | Will call             | [blank]             | comment |
      | 1        | Inventory adjustments | [blank]             | comment |
      | 1        | Adjustment for orders | [blank]             | comment |
      | 1        | Damaged               | [blank]             | comment |
      | 1        | Transfers             | [blank]             | comment |
      | 1        | Others                | [blank]             | comment |
      | 1        | In review             | [blank]             | comment |
      | 1        | Pull date reached     | [blank]             | comment |
      | 1        | Pull date reached     | Donated             | comment |
      | 1        | Pull date reached     | Disposed            | comment |
      | 1        | Pull date reached     | Will call           | comment |
      | 1        | Pull date reached     | Free filled/samples | comment |

    And Click on button "New subtraction item"
    And Admin check quantity when create inventory
      | action   | value |
      | increase | 2     |
      | increase | 3     |
      | decrease | 2     |
      | decrease | 1     |
    And Admin input field values
      | field    | value |
      | Quantity | 0     |
    And ADMIN check value of field
      | field    | value |
      | Quantity | 1     |
    And Admin create subtraction items
      | quantity | category | subCategory | comment |
      | [blank]  | Donated  | [blank]     | [blank] |
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 85 api 1 | random sku admin inventory 85 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 20          | 5          | 5      | Empty   |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category              | description                  | date        | order   | comment |
      | 1        | Donated               | Created by bao5@podfoods.co. | currentDate | [blank] | [blank] |
      | 1        | Free filled/samples   | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
      | 1        | Will call             | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
      | 1        | Disposed              | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
      | 1        | Donated               | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
      | 1        | Pull date reached     | Created by bao5@podfoods.co. | currentDate | [blank] | [blank] |
      | 1        | In review             | Created by bao5@podfoods.co. | currentDate | [blank] | [blank] |
      | 1        | Others                | Created by bao5@podfoods.co. | currentDate | [blank] | [blank] |
      | 1        | Transfers             | Created by bao5@podfoods.co. | currentDate | [blank] | [blank] |
      | 1        | Damaged               | Created by bao5@podfoods.co. | currentDate | [blank] | [blank] |
      | 1        | Adjustment for orders | Created by bao5@podfoods.co. | currentDate | [blank] | [blank] |
      | 1        | Inventory adjustments | Created by bao5@podfoods.co. | currentDate | [blank] | [blank] |
      | 1        | Will call             | Created by bao5@podfoods.co. | currentDate | [blank] | [blank] |
      | 1        | Disposed              | Created by bao5@podfoods.co. | currentDate | [blank] | [blank] |
      | 1        | Donated               | Created by bao5@podfoods.co. | currentDate | [blank] | [blank] |

  @AD_Inventory_90
  Scenario: Check Edit subtraction
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 90 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 90 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 90 api" by api
    And Admin delete product name "random product admin inventory 90 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                    | brand_id |
      | random product admin inventory 90 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 90 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 90 api 1 | random             | 20       | random   | 99           | currentDate  | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    Search SKU name
    And Admin search inventory
      | skuName                           | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 90 api | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin see detail inventory with lotcode
      | index | skuName                             | lotCode     |
      | 1     | random sku admin inventory 90 api 1 | randomIndex |
    And Verify inventory detail
      | index | product                                 | sku                                 | createdBy | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product admin inventory 90 api 1 | random sku admin inventory 90 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random  | Dry 1 day(s)     | 1.0 F - 1.0 F | 20          | 20         | 20     | Empty   |
    And Admin create subtraction items
      | quantity | category | subCategory | comment |
      | 1        | Donated  | [blank]     | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category | description                  | date        | order   | comment |
      | 1        | Donated  | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category | subCategory | comment |
      | Donated  | [blank]     | [blank] |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category | description                  | date        | order   | comment |
      | 1        | Donated  | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category | subCategory | comment |
      | Disposed | [blank]     | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category | description                  | date        | order   | comment |
      | 1        | Disposed | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category  | subCategory | comment |
      | Will call | [blank]     | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category  | description                  | date        | order   | comment |
      | 1        | Will call | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category              | subCategory | comment |
      | Inventory adjustments | [blank]     | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category              | description                  | date        | order   | comment |
      | 1        | Inventory adjustments | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category              | subCategory | comment |
      | Adjustment for orders | [blank]     | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category              | description                  | date        | order   | comment |
      | 1        | Adjustment for orders | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category | subCategory | comment |
      | Damaged  | [blank]     | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category | description                  | date        | order   | comment |
      | 1        | Damaged  | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category  | subCategory | comment |
      | Transfers | [blank]     | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category  | description                  | date        | order   | comment |
      | 1        | Transfers | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category | subCategory | comment |
      | Others   | [blank]     | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category | description                  | date        | order   | comment |
      | 1        | Others   | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category  | subCategory | comment |
      | In review | [blank]     | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category  | description                  | date        | order   | comment |
      | 1        | In review | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category          | subCategory | comment |
      | Pull date reached | [blank]     | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category          | description                  | date        | order   | comment |
      | 1        | Pull date reached | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category          | subCategory | comment |
      | Pull date reached | Donated     | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category | description                  | date        | order   | comment |
      | 1        | Donated  | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category          | subCategory | comment |
      | Pull date reached | Disposed    | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category | description                  | date        | order   | comment |
      | 1        | Disposed | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category          | subCategory | comment |
      | Pull date reached | Will call   | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category  | description                  | date        | order   | comment |
      | 1        | Will call | Created by bao5@podfoods.co. | currentDate | [blank] | comment |
    And Admin edit fist subtraction on inventory
      | category          | subCategory         | comment |
      | Pull date reached | Free filled/samples | comment |
    And Verify subtraction item "show" on tab "All" of inventory
      | quantity | category            | description                  | date        | order   | comment |
      | 1        | Free filled/samples | Created by bao5@podfoods.co. | currentDate | [blank] | comment |

  @AD_Inventory_101
  Scenario: Check About to expire tab
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 101 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 101 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 101 api" by api
    And Admin delete product name "random product admin inventory 101 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product admin inventory 101 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 101 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 101 api 1 | random             | 1        | random   | 99           | currentDate  | currentDate | [blank] |

    And Admin create a "active" SKU from admin with name "random sku admin inventory 101 api 2" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 2     | random sku admin inventory 101 api 2 | random             | 2        | random   | 99           | currentDate  | Minus1      | [blank] |

    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "vendor_inventory_expiring_soon_reminder"

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "About to expire" by sidebar
    And Admin verify red number expire
#    And Admin verify sku textbox in search all inventory
#      | searchValue                        | brand                              | product                         | sku                         |
#      | 30914                              | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
#      | Auto Brand low quantity thresshold | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
#      | Auto product delete subtraction    | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
#      | Auto SKU delete subtraction        | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
    And Admin search expire inventory
      | skuName                              | productName                            | vendorCompany       | vendorBrand               | region              | distribution                  | createdBy | lotZero | storageSheftLife | tag           | dayUntilPullDateCondition | dayUntilPullDate | pullStartDate | pullEndDate |
      | random sku admin inventory 101 api 1 | random product admin inventory 101 api | Auto vendor company | Auto brand create product | Chicagoland Express | Auto Ngoc Distribution CHI 01 | Admin     | Show    | Dry              | Auto Bao Tags | Equal to                  | 1                | currentDate   | currentDate |
    And Click on button "Reset"
    And ADMIN check value of field
      | field                        | value    |
      | SKU name / Item code         | [blank]  |
      | Product name                 | [blank]  |
      | Vendor company               | -        |
      | Vendor brand                 | -        |
      | Region                       | -        |
      | Distribution center          | -        |
      | Created by                   | -        |
      | Lots with 0 current quantity | -        |
      | Storage shelf life           | -        |
      | Tags                         | -        |
      | Days until pull date         | Equal to |
      | Pull start date              | [blank]  |
      | Pull end date                | [blank]  |
    And Admin search with invalid field "SKU name / Item code"
      | value                                  |
      | random sku admin inventory 101 api 123 |
    And Admin search with invalid field "Vendor company"
      | value                   |
      | Auto vendor company 123 |
    And Admin search with invalid field "Vendor brand"
      | value                   |
      | Auto vendor company 123 |
    And Admin search with invalid field "Distribution center"
      | value                   |
      | Auto vendor company 123 |
    And Click on button "Search"
    And Admin search with invalid field "Tags"
      | value                   |
      | Auto vendor company 123 |
    And Click on button "Search"
    And Admin search expire inventory
      | skuName                              | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotZero | storageSheftLife | tag     | dayUntilPullDateCondition | dayUntilPullDate | pullStartDate | pullEndDate |
      | random sku admin inventory 101 api 1 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Click on button "Reset"
    And Admin search expire inventory
      | skuName | productName                              | vendorCompany | vendorBrand | region  | distribution | createdBy | lotZero | storageSheftLife | tag     | dayUntilPullDateCondition | dayUntilPullDate | pullStartDate | pullEndDate |
      | [blank] | random product admin inventory 101 api 1 | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Click on button "Reset"
    And Admin search expire inventory
      | skuName | productName | vendorCompany       | vendorBrand | region  | distribution | createdBy | lotZero | storageSheftLife | tag     | dayUntilPullDateCondition | dayUntilPullDate | pullStartDate | pullEndDate |
      | [blank] | [blank]     | Auto vendor company | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
    And Click on button "Reset"
    And Admin search expire inventory
      | skuName | productName | vendorCompany | vendorBrand               | region  | distribution | createdBy | lotZero | storageSheftLife | tag     | dayUntilPullDateCondition | dayUntilPullDate | pullStartDate | pullEndDate |
      | [blank] | [blank]     | [blank]       | Auto brand create product | [blank] | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
    And Click on button "Reset"
    And Admin search expire inventory
      | skuName | productName | vendorCompany | vendorBrand | region                   | distribution | createdBy | lotZero | storageSheftLife | tag     | dayUntilPullDateCondition | dayUntilPullDate | pullStartDate | pullEndDate |
      | [blank] | [blank]     | [blank]       | [blank]     | Atlanta Express          | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
      | [blank] | [blank]     | [blank]       | [blank]     | Denver Express           | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
      | [blank] | [blank]     | [blank]       | [blank]     | Phoenix Express          | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
      | [blank] | [blank]     | [blank]       | [blank]     | Sacramento Express       | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
      | [blank] | [blank]     | [blank]       | [blank]     | Florida Express          | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
      | [blank] | [blank]     | [blank]       | [blank]     | Mid Atlantic Express     | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
      | [blank] | [blank]     | [blank]       | [blank]     | New York Express         | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
      | [blank] | [blank]     | [blank]       | [blank]     | North California Express | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
      | [blank] | [blank]     | [blank]       | [blank]     | South California Express | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
#      | [blank] | [blank]     | [blank]       | [blank]     | Texas Express                   [blank] | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       |
      | [blank] | [blank]     | [blank]       | [blank]     | Dallas Express           | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
      | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct Central       | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
      | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct East          | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
#      | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct Southeast           | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
#      | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct Southwest & Rockies | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
      | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct West          | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
    And Click on button "Reset"
    And Admin search expire inventory
      | skuName                              | productName                            | vendorCompany       | vendorBrand | region  | distribution | createdBy | lotZero | storageSheftLife | tag     | dayUntilPullDateCondition | dayUntilPullDate | pullStartDate | pullEndDate |
      | random sku admin inventory 101 api 2 | random product admin inventory 101 api | Auto vendor company | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1     | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    And Admin Export Inventory
    And Admin check content file Export all inventory
      | inventoryId | sku                                  | product                                  | brand                     | vendorCompany       | region              | unitUpc      | caseUpc      | originalQuantity | currentQuantity | endQuantity | createBy | lotCode | distribution                  | expiryDate | receivingDate | storageShelfLife | storageTemperature |
      | [blank]     | random sku admin inventory 101 api 2 | random product admin inventory 101 api 1 | Auto brand create product | Auto vendor company | Chicagoland Express | 123123123123 | 123123123123 | 2                | 2               | 2           | Admin    | random  | Auto Ngoc Distribution CHI 01 | Minus1     | currentDate   | Dry 1 day(s)     | 1.0 F - 1.0 F      |
    And Click on button "Reset"

    And Admin search expire inventory
      | skuName | productName                            | vendorCompany | vendorBrand | region  | distribution | createdBy | lotZero | storageSheftLife | tag     | dayUntilPullDateCondition | dayUntilPullDate | pullStartDate | pullEndDate |
      | [blank] | random product admin inventory 101 api | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |

    And Admin sort field "SKU" with "ascending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "SKU" with "descending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    And Admin sort field "Original Qty" with "ascending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Original Qty" with "descending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    And Admin sort field "Current Qty" with "ascending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Current Qty" with "descending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    And Admin sort field "End Qty" with "ascending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "End Qty" with "descending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    And Admin sort field "Pull Qty" with "ascending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Pull Qty" with "descending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    And Admin sort field "Expiry" with "ascending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Expiry" with "descending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    And Admin sort field "Pull date" with "ascending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Pull date" with "descending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    And Admin sort field "Days until pull date" with "ascending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Days until pull date" with "descending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    And Admin sort field "Receive" with "ascending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Receive" with "descending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

    And Admin sort field "Vendor Company" with "ascending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin sort field "Vendor Company" with "descending"
    And Verify result inventory
      | index | productName                            | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 101 api | random sku admin inventory 101 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | -55              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
      | 2     | random product admin inventory 101 api | random sku admin inventory 101 api 2 | randomIndex | 2                | 2               | 2        | 0            | Minus1      | Minus56  | -56              | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

  @AD_Inventory_139
  Scenario: Check About to expire list
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 102 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 102 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 102 api" by api
    And Admin delete product name "random product admin inventory 102 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product admin inventory 102 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 102 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 102 api 1 | random             | 1        | random   | 99           | currentDate  | currentDate | [blank] |
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment |
      | 2                       | 1        | comment |

    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "vendor_inventory_expiring_soon_reminder"

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "About to expire" by sidebar
    And Admin search expire inventory
      | skuName                              | productName                            | vendorCompany | vendorBrand | region  | distribution | createdBy | lotZero | storageSheftLife | tag     | dayUntilPullDateCondition | dayUntilPullDate | pullStartDate | pullEndDate |
      | random sku admin inventory 102 api 1 | random product admin inventory 102 api | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |
    And Admin no found data in result
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName                              | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 102 api 1 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                              | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 102 api 1 | random sku admin inventory 102 api 1 | randomIndex | 1                | 0               | 0        | 0            | [blank]    | [blank]  | [blank]          | [blank]     | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |

  @AD_Inventory_139_to_165
  Scenario: Check About to expire list - LP create inventory
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 103 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 103 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 103 api" by api
    And Admin delete product name "random product admin inventory 103 api" by api
#    Create inventory
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product admin inventory 103 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 103 api 1" of product ""

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to "All Inventory" tab
    And LP go to create new inventory
    And LP create new inventory
      | distribution                  | sku                                  | quantity | lotCode                              | receiveDate | expiryDate  | comment  |
      | Auto Ngoc Distribution CHI 01 | random sku admin inventory 103 api 1 | 5        | random sku admin inventory 103 api 1 | currentDate | currentDate | Autotest |
    And Click on button "Add an image"
    And LP add image for Inventory
      | image       | description |
      | anhJPEG.jpg | auto        |
    And LP create new inventory successfully

    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "vendor_inventory_expiring_soon_reminder"

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "About to expire" by sidebar
    And Admin search expire inventory
      | skuName                              | productName                            | vendorCompany | vendorBrand | region  | distribution | createdBy         | lotZero | storageSheftLife | tag     | dayUntilPullDateCondition | dayUntilPullDate | pullStartDate | pullEndDate |
      | random sku admin inventory 103 api 1 | random product admin inventory 103 api | [blank]       | [blank]     | [blank] | [blank]      | Logistics partner | [blank] | [blank]          | [blank] | [blank]                   | [blank]          | [blank]       | [blank]     |

    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName                              | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 103 api 1 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                              | skuName                              | lotCode                              | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy  |
      | 1     | random product admin inventory 103 api 1 | random sku admin inventory 103 api 1 | random sku admin inventory 103 api 1 | 5                | 5               | 5        | 0            | [blank]    | [blank]  | [blank]          | [blank]     | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | ngoctx lp1 |
    And Admin see detail inventory with lotcode
      | index | skuName                              | lotCode                              |
      | 1     | random sku admin inventory 103 api 1 | random sku admin inventory 103 api 1 |
    And Verify inventory detail
      | index | product                                  | sku                                  | createdBy  | region              | distributionCenter            | receiveDate | expireDate  | pullDate | lotCode                              | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment  |
      | 1     | random product admin inventory 103 api 1 | random sku admin inventory 103 api 1 | ngoctx lp1 | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | currentDate | [blank]  | random sku admin inventory 103 api 1 | Dry 1 day(s)     | 1.0 F - 1.0 F | 5           | 5          | 5      | Autotest |
    And Admin create subtraction items
      | quantity | category | subCategory | comment |
      | 5        | Donated  | [blank]     | comment |
    And Admin go back with button
    And BAO_ADMIN5 navigate to "Inventories" to "About to expire" by sidebar
    And Admin search inventory
      | skuName                              | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 103 api 1 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin no found data in result

  @AD_Inventory_166
  Scenario: Check Running low tab
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inventory 166 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 166 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 166 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 166 api" by api
    And Admin delete product name "random product admin inventory 166 api" by api
#    Create  SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product admin inventory 166 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 166 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code                             | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 166 api 1 | random             | 1        | random sku admin inventory 166 api 1 | 99           | currentDate  | currentDate | [blank] |
    #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer29@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | [blank]   | [blank] | 20       |
    And Checkout cart with payment by "invoice" by API
#    Fulfilled this order
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin "fulfill" all line item in order "create by api" by api

#    Create item 2
    And Admin create a "active" SKU from admin with name "random sku admin inventory 166 api 2" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code                             | warehouse_id | receive_date | expiry_date | comment |
      | 2     | random sku admin inventory 166 api 2 | random             | 2        | random sku admin inventory 166 api 2 | 99           | currentDate  | Minus1      | [blank] |
  #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer29@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | [blank]   | [blank] | 20       |
    And Checkout cart with payment by "invoice" by API
#    Fulfilled this order
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin "fulfill" all line item in order "create by api" by api

    #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "update_inventoty_quantity_threshold"

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName                            | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | [blank] | random product admin inventory 166 api | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName                              | skuName                              | lotCode                              | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany | region | createdBy |
      | 2     | random product admin inventory 166 api 1 | random sku admin inventory 166 api 2 | random sku admin inventory 166 api 2 | 2                | 2               | 0        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI 01 | [blank]       | CHI    | Admin     |
      | 1     | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1                | 1               | 0        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI 01 | [blank]       | CHI    | Admin     |
#
    And BAO_ADMIN5 navigate to "Inventories" to "Running low" by sidebar
    And Admin verify sku textbox in search all inventory
      | searchValue                     | brand                              | product                         | sku                         |
      | 30914                           | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
#      | Auto Brand low quantity thresshold | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
      | Auto product delete subtraction | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
      | Auto SKU delete subtraction     | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
    And Admin search inventory in running low
      | skuName                              | productName                              | vendorCompany       | vendorBrand               | region              |
      | random sku admin inventory 166 api 1 | random product admin inventory 166 api 1 | Auto vendor company | Auto brand create product | Chicagoland Express |
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1           | 1          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
    And Admin reset filter
    And Admin search inventory in running low
      | skuName | productName                              | vendorCompany       | vendorBrand               | region              |
      | [blank] | random product admin inventory 166 api 1 | Auto vendor company | Auto brand create product | Chicagoland Express |

    And Admin sort field "SKU" with "ascending"
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1           | 1          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 2 | 2           | 2          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
    And Admin sort field "SKU" with "descending"
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 2 | 2           | 2          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1           | 1          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |

    And Admin sort field "Original Qty" with "ascending"
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1           | 1          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 2 | 2           | 2          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
    And Admin sort field "Original Qty" with "descending"
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 2 | 2           | 2          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1           | 1          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |

    And Admin sort field "Current Qty" with "ascending"
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1           | 1          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 2 | 2           | 2          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
    And Admin sort field "Current Qty" with "descending"
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 2 | 2           | 2          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1           | 1          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |

    And Admin sort field "End Qty" with "ascending"
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1           | 1          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 2 | 2           | 2          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
    And Admin sort field "End Qty" with "descending"
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 2 | 2           | 2          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1           | 1          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |

    And Admin sort field "Brand" with "ascending"
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1           | 1          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 2 | 2           | 2          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
    And Admin sort field "Brand" with "descending"
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1           | 1          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 2 | 2           | 2          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |

    And Admin sort field "Vendor Company" with "ascending"
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1           | 1          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 2 | 2           | 2          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
    And Admin sort field "Vendor Company" with "descending"
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 1 | 1           | 1          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 166 api 1 | random sku admin inventory 166 api 2 | 2           | 2          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |

  @AD_Inventory_167
  Scenario: Check Running low tab - When Admin edit quantity to lower or higher pull qty thresshold
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inventory 167 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 167 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 167 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 167 api" by api
    And Admin delete product name "random product admin inventory 167 api" by api
#    Create  SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product admin inventory 167 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 167 api 1" of product ""
    #Create inventory with quantity < low quantity threshold
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 167 api 1 | random             | 10       | random   | 99           | currentDate  | currentDate | [blank] |

    #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer29@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | [blank]   | [blank] | 5        |
    And Checkout cart with payment by "invoice" by API
#    Fulfilled this order
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin "fulfill" all line item in order "create by api" by api

    #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "update_inventoty_quantity_threshold"
#   Now Low quantity threshold = 3, end quantity of inventory = 5 -> not show on Running low

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    And Admin verify pagination function
    And Admin search inventory
      | skuName                              | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 167 api 1 | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName                              | skuName                              | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | random product admin inventory 167 api 1 | random sku admin inventory 167 api 1 | random  | 10               | 10              | 5        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | [blank]       | CHI    | Admin     |

    And BAO_ADMIN5 navigate to "Inventories" to "Running low" by sidebar
    And Admin search inventory in running low
      | skuName                              | productName                              | vendorCompany | vendorBrand | region  |
      | random sku admin inventory 167 api 1 | random product admin inventory 167 api 1 | [blank]       | [blank]     | [blank] |
    And Admin no found data in result

    #    Create Subtraction
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 2                       | 3        | Autotest |
#Now end qty =2 < Low qty thresshold
    And Admin refresh inventory list
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 167 api 1 | random sku admin inventory 167 api 1 | 10          | 7          | 2      | 0       | Auto brand create product | Auto vendor company | CHI    |

#    Delete subtraction
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 167 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 167 api" from API
    And Admin delete all subtraction of list inventory
    #Now end qty =10> Low qty thresshold
    And Admin refresh inventory list
    And Admin no found data in result

      #    Change low quantity > end qty
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
    And Admin "fulfill" all line item in order "create by api" by api
    #Run cron job to update low quantity threshold
    And Switch to actor ADMIN_OLD
    And Admin run cron job "update_inventoty_quantity_threshold"
#Now low qty thresshold =5 , end qty =1
    And Switch to actor BAO_ADMIN5
    And Admin refresh inventory list
    Then Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 167 api 1 | random sku admin inventory 167 api 1 | 10          | 10         | 1      | 0       | Auto brand create product | Auto vendor company | CHI    |
#    CHange state sku to draft, inactive
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Change state of SKU id: "random sku admin inventory 167 api 1" to "draft"
    And Admin refresh inventory list
    And Admin no found data in result

    And Admin change info of regions attributes of sku "random sku admin inventory 167 api 1" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | inactive |
    And Admin refresh inventory list
    And Admin no found data in result

  @AD_Inventory_172
  Scenario: Search and Filter Running low
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inventory 172 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 172 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 172 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 172 api" by api
    And Admin delete product name "random product admin inventory 172 api" by api
#    Create  SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product admin inventory 172 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 172 api 1" of product ""
     #Create inventory with quantity < low quantity threshold
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 172 api 1 | random             | 6        | random   | 99           | currentDate  | currentDate | [blank] |

 #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer29@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | [blank]   | [blank] | 5        |
    And Checkout cart with payment by "invoice" by API
#    Fulfilled this order
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin "fulfill" all line item in order "create by api" by api

    #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "update_inventoty_quantity_threshold"

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Running low" by sidebar
    And Admin search inventory in running low
      | skuName                              | productName | vendorCompany | vendorBrand | region  |
      | random sku admin inventory 172 api 1 | [blank]     | [blank]       | [blank]     | [blank] |
#    And Admin Export Inventory
#    And Admin check content file after Export inventory
#      | sku                                 | product                                  | brand                     | vendorCompany       | region              | unitUpc      | caseUpc      | originalQuantity | currentQuantity | endQQuantity |
#      | random sku admin inventory 72 api 1 | random product admin inventory 172 api 1 | Auto brand create product | Auto vendor company | Chicagoland Express | 123123123123 | 123123123123 | 6                | 6               | 1            |
    And Admin search inventory in running low
      | itemCode      | skuName                              | productName | vendorCompany | vendorBrand | region  |
      | item code api | random sku admin inventory 172 api 1 | [blank]     | [blank]       | [blank]     | [blank] |
    And Admin reset filter
    And Admin search with invalid field "SKU name / Item code"
      | value                                  |
      | random sku admin inventory 172 api 123 |
    And Admin search with invalid field "Vendor company"
      | value                   |
      | Auto vendor company 123 |
    And Admin search with invalid field "Vendor brand"
      | value                   |
      | Auto vendor company 123 |
    And Admin reset filter
    And Admin search inventory in running low
      | skuName | productName | vendorCompany | vendorBrand | region                   |
      | [blank] | [blank]     | [blank]       | [blank]     | Atlanta Express          |
      | [blank] | [blank]     | [blank]       | [blank]     | Denver Express           |
      | [blank] | [blank]     | [blank]       | [blank]     | Phoenix Express          |
      | [blank] | [blank]     | [blank]       | [blank]     | Sacramento Express       |
      | [blank] | [blank]     | [blank]       | [blank]     | Florida Express          |
      | [blank] | [blank]     | [blank]       | [blank]     | Mid Atlantic Express     |
      | [blank] | [blank]     | [blank]       | [blank]     | New York Express         |
      | [blank] | [blank]     | [blank]       | [blank]     | North California Express |
      | [blank] | [blank]     | [blank]       | [blank]     | South California Express |
#      | [blank] | [blank]     | [blank]       | [blank]       | Texas Express
      | [blank] | [blank]     | [blank]       | [blank]     | Dallas Express           |
      | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct Central       |
      | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct East          |
#      | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct Southeast           |
#      | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct Southwest & Rockies |
      | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct West          |
    And Admin search inventory in running low
      | skuName                              | productName | vendorCompany | vendorBrand | region  |
      | random sku admin inventory 172 api 1 | [blank]     | [blank]       | [blank]     | [blank] |
    And Admin Export Inventory
    And Admin check content file Export running low inventory
      | sku                                  | product                                  | brand                     | vendorCompany       | region              | unitUpc      | caseUpc      | originalQuantity | currentQuantity | endQuantity |
      | random sku admin inventory 172 api 1 | random product admin inventory 172 api 1 | Auto brand create product | Auto vendor company | Chicagoland Express | 123123123123 | 123123123123 | 6                | 6               | 1           |

  @AD_Inventory_209 @AD_Inventories_253
  Scenario: Check Zero quantity tab
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
     # Reset search filter full textbox
    And Admin filter visibility with id "66" by api
      | q[product_variant_id] |
      | q[vendor_company_id]  |
      | q[region_id]          |
      | q[product_name]       |
      | q[brand_id]           |
    And Admin delete filter preset of screen id "66" by api
    And Admin delete order by sku of product "random product admin inventory 209 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 209 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 209 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 209 api" by api
    And Admin delete product name "random product admin inventory 209 api" by api
#    Create  SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product admin inventory 209 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 209 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 209 api 1 | random             | 1        | random   | 99           | currentDate  | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    Then BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    And Admin verify pagination function
    And Admin search inventory
      | skuName                              | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 209 api 1 | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                              | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | [blank]          | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And BAO_ADMIN5 navigate to "Inventories" to "Zero quantity" by sidebar
#    And Admin verify sku textbox in search all inventory
#      | searchValue                        | brand                              | product                         | sku                         |
#      | 30914                              | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
#      | Auto Brand low quantity thresshold | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
#      | Auto product delete subtraction    | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
#      | Auto SKU delete subtraction        | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
    And Admin search inventory in running low
      | skuName | productName | vendorCompany | vendorBrand | region  |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] |
    And Admin search with invalid field "SKU name / Item code"
      | value                                  |
      | random sku admin inventory 209 api 123 |
    And Admin search with invalid field "Vendor company"
      | value                   |
      | Auto vendor company 123 |
    And Admin search with invalid field "Vendor brand"
      | value                   |
      | Auto vendor company 123 |
    And Admin reset filter
    And Admin search inventory in running low
      | skuName                              | productName                              | vendorCompany       | vendorBrand               | region              |
      | random sku admin inventory 209 api 1 | random product admin inventory 209 api 1 | Auto vendor company | Auto brand create product | Chicagoland Express |
    And Admin search inventory in running low
      | skuName | productName | vendorCompany | vendorBrand | region  |
      | [blank] | [blank]     | [blank]       | [blank]     | [blank] |
    And Admin no found data in result

#    Create Subtraction
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment |
      | 1                       | 1        | comment |
    And Admin refresh inventory list
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |

  #    Create item 2
    And Admin create a "active" SKU from admin with name "random sku admin inventory 209 api 2" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 2     | random sku admin inventory 209 api 2 | random             | 2        | random   | 99           | currentDate  | Minus1      | [blank] |
#    Create Subtraction
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment |
      | 2                       | 2        | comment |
    And Admin refresh inventory list
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
    And Admin reset filter
    And Admin search inventory in running low
      | skuName | productName                              | vendorCompany       | vendorBrand | region  |
      | [blank] | random product admin inventory 209 api 1 | Auto vendor company | [blank]     | [blank] |
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |

    And Admin sort field "SKU" with "ascending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
    And Admin sort field "SKU" with "descending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |

    And Admin sort field "Original Qty" with "ascending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
    And Admin sort field "Original Qty" with "descending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |

    And Admin sort field "Current Qty" with "ascending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
    And Admin sort field "Current Qty" with "descending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |

    And Admin sort field "End Qty" with "ascending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
    And Admin sort field "End Qty" with "descending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |

    And Admin sort field "Pull Qty" with "ascending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
    And Admin sort field "Pull Qty" with "descending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |

    And Admin sort field "Brand" with "ascending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
    And Admin sort field "Brand" with "descending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |

    And Admin sort field "Vendor Company" with "ascending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |
    And Admin sort field "Vendor Company" with "descending"
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 2 | 2           | 0          | 0      | 0       | Auto brand create product | Auto vendor company | CHI    |

    And Admin reset filter
    And Admin uncheck field of edit visibility in search
      | skuNameItemCode | productName | vendorCompany | region  | vendorBrand |
      | [blank]         | [blank]     | [blank]       | [blank] | [blank]     |
    Then Admin verify field search uncheck all in edit visibility
      | skuNameItemCode | productName | vendorCompany | region  | vendorBrand |
      | [blank]         | [blank]     | [blank]       | [blank] | [blank]     |
    And Admin uncheck field of edit visibility in search
      | skuNameItemCode | productName | vendorCompany | region  | vendorBrand |
      | [blank]         | [blank]     | [blank]       | [blank] | [blank]     |
    Then Admin verify field search in edit visibility
      | skuNameItemCode | productName | vendorCompany | region  | vendorBrand |
      | [blank]         | [blank]     | [blank]       | [blank] | [blank]     |
    And Admin uncheck field of edit visibility in search
      | vendorCompany | region  | vendorBrand |
      | [blank]       | [blank] | [blank]     |
    Then Admin verify field search uncheck all in edit visibility
      | vendorCompany | region  | vendorBrand |
      | [blank]       | [blank] | [blank]     |
    Then Admin verify field search in edit visibility
      | skuNameItemCode | productName |
      | [blank]         | [blank]     |
    And Admin uncheck field of edit visibility in search
      | vendorCompany | region  | vendorBrand |
      | [blank]       | [blank] | [blank]     |
    Then Admin verify field search in edit visibility
      | skuNameItemCode | productName | vendorCompany | region  | vendorBrand |
      | [blank]         | [blank]     | [blank]       | [blank] | [blank]     |
    And Admin search inventory in running low
      | skuName | productName                              | vendorCompany | vendorBrand | region              |
      | [blank] | random product admin inventory 209 api 1 | [blank]       | [blank]     | Chicagoland Express |
    And Admin save filter by info
      | filterName | type               |
      | [blank]    | Save as new preset |
    And BAO_ADMIN12 check error message is showing of fields on dialog
      | field       | message                         |
      | Preset name | Please enter name filter preset |
    And Admin close dialog form
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin reset filter
    And BAO_ADMIN5 check value of field
      | field  | value |
      | Region | -     |
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN7 check value of field
      | field        | value                                    |
      | Region       | Chicagoland Express                      |
      | Product name | random product admin inventory 209 api 1 |
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |

    And Admin reset filter
    And Admin search inventory in running low
      | skuName | productName                              | vendorCompany | vendorBrand               | region  |
      | [blank] | random product admin inventory 209 api 1 | [blank]       | Auto brand create product | [blank] |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest2  | Save as new preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest2"
    And BAO_ADMIN5 check value of field
      | field        | value                                    |
      | Product name | random product admin inventory 209 api 1 |
      | Vendor brand | Auto brand create product                |
    And Admin verify inventory running low
      | product                                  | sku                                  | originalQty | currentQty | endQty | pullQty | brand                     | vendorCompany       | region |
      | random product admin inventory 209 api 1 | random sku admin inventory 209 api 1 | 1           | 0          | 0      | 1       | Auto brand create product | Auto vendor company | CHI    |

    And Admin delete filter preset is "AutoTest1"
  # Reset search filter full textbox
    And Admin filter visibility with id "66" by api
      | q[product_variant_id] |
      | q[vendor_company_id]  |
      | q[region_id]          |
      | q[product_name]       |
      | q[brand_id]           |
    And Admin delete filter preset of screen id "66" by api

  @AD_Inventory_248
  Scenario: Inventory status
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
          # Reset search filter full textbox
    And Admin filter visibility with id "67" by api
      | q[product_variant_id] |
      | q[brand_id]           |
      | q[any_text]           |
      | q[vendor_company_id]  |
      | q[region_id]          |
      | q[product_name]       |
    And Admin delete filter preset of screen id "67" by api
    And Admin delete order by sku of product "random product admin inventory 248 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 248 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 248 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 248 api" by api
    And Admin delete product name "random product admin inventory 248 api" by api
#    Create  SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product admin inventory 248 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 248 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 248 api 1 | random             | 1        | random   | 99           | currentDate  | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    Then BAO_ADMIN5 navigate to "Inventories" to "All inventory" by sidebar
#    And Admin verify pagination function
    And Admin search inventory
      | skuName                              | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | random sku admin inventory 248 api 1 | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                              | skuName                              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | 1     | random product admin inventory 248 api 1 | random sku admin inventory 248 api 1 | randomIndex | 1                | 1               | 1        | 0            | currentDate | Minus55  | [blank]          | currentDate | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And BAO_ADMIN5 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText                                  | skuName | productName | vendorCompany | vendorBrand | region  |
      | random product admin inventory 248 api 2 | [blank] | [blank]     | [blank]       | [blank]     | [blank] |
    And Admin check no data found
    And Admin reset filter
    And Admin search with invalid field "SKU name / Item code"
      | value                                  |
      | random sku admin inventory 248 api 123 |
    And Admin search with invalid field "Vendor company"
      | value                   |
      | Auto vendor company 123 |
    And Admin search with invalid field "Vendor brand"
      | value                   |
      | Auto vendor company 123 |
    And Admin reset filter

    And Admin search inventory status
      | anyText                              | skuName                              | productName                            | vendorCompany       | vendorBrand               | region              |
      | random sku admin inventory 248 api 1 | random sku admin inventory 248 api 1 | random product admin inventory 248 api | Auto vendor company | Auto brand create product | Chicagoland Express |
    Then Verify result inventory status
      | sku                                  | brand                     | product                                | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status              |
      | random sku admin inventory 248 api 1 | Auto brand create product | random product admin inventory 248 api | 1                | 0                 | 1               | 0               | 0                    | 1           | 1 case in inventory |
    And Admin reset filter
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region  |
      | random product admin inventory 248 api | [blank] | [blank]     | [blank]       | [blank]     | [blank] |
    Then Verify result inventory status
      | sku                                  | brand                     | product                                | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity |
      | random sku admin inventory 248 api 1 | Auto brand create product | random product admin inventory 248 api | 1                | 0                 | 1               | 0               | 0                    | 1           |

#    Create inventory 2
    And Admin create a "active" SKU from admin with name "random sku admin inventory 248 api 2" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 2     | random sku admin inventory 248 api 2 | random             | 2        | random   | 99           | currentDate  | Plus1       | [blank] |
    And Admin refresh inventory list
    Then Verify result inventory status
      | sku                                  | brand                     | product                                | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | region |
#      | random sku admin inventory 248 api 1 | Auto brand create product | random product admin inventory 248 api | 1                | 0                 | 1               | 0               | 0                    | 1           | CHI    |
      | random sku admin inventory 248 api 2 | Auto brand create product | random product admin inventory 248 api | 2                | 0                 | 2               | 0               | 0                    | 2           | CHI    |
   #Create order unfulfill
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    And Admin reset filter
    And Admin search inventory status
      | anyText | skuName                              | productName | vendorCompany | vendorBrand | region              |
      | [blank] | random sku admin inventory 248 api 2 | [blank]     | [blank]       | [blank]     | Chicagoland Express |
    Then Verify result inventory status
      | sku                                  | brand                     | product                                | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status              |
      | random sku admin inventory 248 api 2 | Auto brand create product | random product admin inventory 248 api | 2                | 0                 | 2               | 1               | 0                    | 1           | 1 case in inventory |

#       Fulfilled this order
    And Admin "fulfilled" all line item in order "create by api" by api
    And Admin refresh inventory list
    Then Verify result inventory status
      | sku                                  | brand                     | product                                | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status              |
      | random sku admin inventory 248 api 2 | Auto brand create product | random product admin inventory 248 api | 2                | 1                 | 1               | 0               | 0                    | 1           | 1 case in inventory |
 #Create order unfulfill 2
    And Admin create line items attributes by API
      | skuName                              | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku admin inventory 248 api 1 | create by api26    | create by api      | 1        | false     | [blank]          |
      | random sku admin inventory 248 api 2 | create by api26    | create by api      | 2        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin refresh inventory list
# Check lai task 2636
#    Then Verify result inventory status
#      | sku                                  | brand                     | product                                | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status         |
#      | random sku admin inventory 248 api 2 | Auto brand create product | random product admin inventory 248 api | 2                | 1                 | 1               | 1               | 2                    | -2          | 2 cases needed |

    And Admin delete order by sku of product "random product admin inventory 248 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 248 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 248 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 248 api" by api
    And Admin delete product name "random product admin inventory 248 api" by api

  @AD_Inventory_276
  Scenario: Inventory status list
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inventory 276 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 276 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 276 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 276 api" by api
    And Admin delete product name "random product admin inventory 276 api" by api
#    Create  SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product admin inventory 276 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Dallas Express      | 61 | active | in_stock     | 1000      | 1000 |
      | Pod Direct Central  | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inventory 276 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 276 api 1 | random             | 1        | random   | 99           | currentDate  | currentDate | [blank] |
      | 2     | random sku admin inventory 276 api 1 | random             | 2        | random   | 88           | currentDate  | currentDate | [blank] |
#      | 3     | random sku admin inventory 276 api 1 | random             | 3        | random   | 99           | currentDate  | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region  |
      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | [blank] |
    Then Verify result inventory status
      | sku                                  | brand                     | product                                | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | region    |
      | random sku admin inventory 276 api 1 | Auto brand create product | random product admin inventory 276 api | 3                | 0                 | 3               | 0               | 0                    | 3           | PDMDALCHI |
    And Admin search inventory status
      | anyText                                    | skuName | productName | vendorCompany | vendorBrand | region              |
      | random product admin inventory 276 api 123 | [blank] | [blank]     | [blank]       | [blank]     | Chicagoland Express |
    And Admin check no data found
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region              |
      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | Chicagoland Express |
    Then Verify result inventory status
      | sku                                  | brand                     | product                                | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status              |
      | random sku admin inventory 276 api 1 | Auto brand create product | random product admin inventory 276 api | 1                | 0                 | 1               | 0               | 0                    | 1           | 1 case in inventory |
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region          |
      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | Florida Express |
    And Admin check no data found
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region               |
      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | Mid Atlantic Express |
    And Admin check no data found
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region           |
      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | New York Express |
    And Admin check no data found
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region                   |
      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | North California Express |
    And Admin check no data found
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region                   |
      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | South California Express |
    And Admin check no data found
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region         |
      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | Dallas Express |
#      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | Texas Express |
    Then Verify result inventory status
      | sku                                  | brand                     | product                                | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status               |
      | random sku admin inventory 276 api 1 | Auto brand create product | random product admin inventory 276 api | 2                | 0                 | 2               | 0               | 0                    | 2           | 2 cases in inventory |
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region             |
      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct Central |
    And Admin check no data found
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region          |
      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct East |
    And Admin check no data found
#    And Admin search inventory status
#      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region               |
#      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct Southeast |
#    And Admin check no data found
#    And Admin search inventory status
#      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region                         |
#      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct Southwest & Rockies |
#    And Admin check no data found
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region          |
      | random product admin inventory 276 api | [blank] | [blank]     | [blank]       | [blank]     | Pod Direct West |
    And Admin check no data found

  @AD_Inventory_277 @AD_Inventories_298
  Scenario: Inventory status list 2 + Search + filter
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
      # Reset search filter full textbox
    And Admin filter visibility with id "67" by api
      | q[product_variant_id] |
      | q[brand_id]           |
      | q[any_text]           |
      | q[vendor_company_id]  |
      | q[region_id]          |
      | q[product_name]       |
    And Admin delete filter preset of screen id "67" by api
    And Admin delete order by sku of product "random product admin inventory 277 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inventory 277 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inventory 277 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inventory 277 api" by api
    And Admin delete product name "random product admin inventory 277 api" by api
#    Create  SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product admin inventory 277 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |

    And Admin create a "active" SKU from admin with name "random sku admin inventory 277 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku admin inventory 277 api 1 | random             | 5        | random   | 99           | currentDate  | currentDate | [blank] |
#      | 3     | random sku admin inventory 277 api 1 | random             | 3        | random   | 99           | currentDate  | currentDate | [blank] |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region  |
      | random product admin inventory 277 api | [blank] | [blank]     | [blank]       | [blank]     | [blank] |
    Then Verify result inventory status
      | sku                                  | brand                     | product                                | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | region |
      | random sku admin inventory 277 api 1 | Auto brand create product | random product admin inventory 277 api | 5                | 0                 | 5               | 0               | 0                    | 5           | CHI    |

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

    And Switch to actor BAO_ADMIN5
    And Admin refresh inventory list
    And Admin search inventory status
      | anyText                                | skuName | productName | vendorCompany | vendorBrand | region              |
      | random product admin inventory 277 api | [blank] | [blank]     | [blank]       | [blank]     | Chicagoland Express |
    Then Verify result inventory status
      | sku                                  | brand                     | product                                | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status      |
      | random sku admin inventory 277 api 1 | Auto brand create product | random product admin inventory 277 api | 5                | 4                 | 1               | 0               | 0                    | 1           | 1 case left |

    And Admin reset filter
    And Admin uncheck field of edit visibility in search
      | anyText | vendorBrand | productName | skuNameItemCode | vendorCompany | region  |
      | [blank] | [blank]     | [blank]     | [blank]         | [blank]       | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | anyText | vendorBrand | productName | skuNameItemCode | vendorCompany | region  |
      | [blank] | [blank]     | [blank]     | [blank]         | [blank]       | [blank] |
    And Admin uncheck field of edit visibility in search
      | anyText | vendorBrand | productName | skuNameItemCode | vendorCompany | region  |
      | [blank] | [blank]     | [blank]     | [blank]         | [blank]       | [blank] |
    Then Admin verify field search in edit visibility
      | anyText | vendorBrand | productName | skuNameItemCode | vendorCompany | region  |
      | [blank] | [blank]     | [blank]     | [blank]         | [blank]       | [blank] |
    And Admin uncheck field of edit visibility in search
      | anyText | productName | skuNameItemCode | region  |
      | [blank] | [blank]     | [blank]         | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | anyText | productName | skuNameItemCode | region  |
      | [blank] | [blank]     | [blank]         | [blank] |
    Then Admin verify field search in edit visibility
      | vendorBrand | vendorCompany |
      | [blank]     | [blank]       |
    And Admin uncheck field of edit visibility in search
      | anyText | productName | skuNameItemCode | region  |
      | [blank] | [blank]     | [blank]         | [blank] |
    Then Admin verify field search in edit visibility
      | anyText | vendorBrand | productName | skuNameItemCode | vendorCompany | region  |
      | [blank] | [blank]     | [blank]     | [blank]         | [blank]       | [blank] |
    And Admin search inventory status
      | anyText                         | skuName                       | productName | vendorCompany | vendorBrand | region              |
      | product admin inventory 277 api | sku admin inventory 277 api 1 | [blank]     | [blank]       | [blank]     | Chicagoland Express |
    And Admin save filter by info
      | filterName | type               |
      | [blank]    | Save as new preset |
    And BAO_ADMIN12 check error message is showing of fields on dialog
      | field       | message                         |
      | Preset name | Please enter name filter preset |
    And Admin close dialog form
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin reset filter
    And BAO_ADMIN7 check value of field
      | field    | value   |
      | Any text | [blank] |
      | Region   | -       |
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN7 check value of field
      | field    | value                           |
      | Any text | product admin inventory 277 api |
      | Region   | Chicagoland Express             |
    Then Verify result inventory status
      | sku                                  | brand                     | product                                | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status      |
      | random sku admin inventory 277 api 1 | Auto brand create product | random product admin inventory 277 api | 5                | 4                 | 1               | 0               | 0                    | 1           | 1 case left |
    And Admin reset filter
    And Admin search inventory status
      | anyText | skuName | productName                     | vendorCompany       | vendorBrand               | region  |
      | [blank] | [blank] | product admin inventory 277 api | Auto vendor company | Auto brand create product | [blank] |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest2  | Save as new preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest2"
    And BAO_ADMIN5 check value of field
      | field          | value                           |
      | Product name   | product admin inventory 277 api |
      | Vendor company | Auto vendor company             |
      | Vendor brand   | Auto brand create product       |
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
      # Reset search filter full textbox
    And Admin filter visibility with id "67" by api
      | q[product_variant_id] |
      | q[brand_id]           |
      | q[any_text]           |
      | q[vendor_company_id]  |
      | q[region_id]          |
      | q[product_name]       |
    And Admin delete filter preset of screen id "67" by api

  @AD_Incoming_Inventory_1
  Scenario: AD_Incoming_Inventory
    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 01 | 10     |
    And Confirm Create Incoming inventory
    And BAO_ADMIN5 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand           | region              | initiatedBy | status    | startDate   | endDate     | warehouse                     | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by admin | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | Admin       | Requested | currentDate | currentDate | Auto Ngoc Distribution CHI 01 | No       | No      | [blank]        | [blank]         | [blank]        | 12          |
    And Verify table result Incoming inventory
      | number          | vendorCompany | brand                 | region              | eta     | status    |
      | create by admin | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Requested |
    And Go to detail of incoming inventory number ""
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany | status    | warehouse                     | eta     | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | zipCode | trackingNumber |
      | Chicagoland Express | [blank]        | ngoc vc 1     | Requested | Auto Ngoc Distribution CHI 01 | [blank] | 0        | N/A            | 10               | -                         | [blank] | [blank]        |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU              | productSKU        | nameSKU           | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 01 | [blank]    | 10        | [blank]       | [blank]          | [blank] |
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 01 | Brand Self Delivery | currentDate  | 1         | 1          | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod      | vendorCompany | status    | warehouse                     | eta         | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | zipCode |
      | Chicagoland Express | Brand Self Delivery | ngoc vc 1     | Confirmed | Auto Ngoc Distribution CHI 01 | currentDate | 1        | N/A            | 10               | 1                         | 60005   |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU              | productSKU        | nameSKU           | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge     |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 01 | [blank]    | 10        | currentDate   | currentDate      | Below 75% |
    And Admin go back with button
    And Admin reset filter
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand           | region              | initiatedBy | status    | startDate   | endDate     | warehouse                     | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by admin | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | Admin       | Requested | currentDate | currentDate | Auto Ngoc Distribution CHI 01 | No       | No      | [blank]        | [blank]         | [blank]        | 12          |
    And Admin no found data in result
    And Admin reset filter
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand           | region              | initiatedBy | status    | startDate   | endDate     | warehouse                     | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by admin | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | Admin       | Confirmed | currentDate | currentDate | Auto Ngoc Distribution CHI 01 | No       | Yes     | [blank]        | [blank]         | [blank]        | 12          |
    And Verify table result Incoming inventory
      | number          | vendorCompany | brand                 | region              | eta         | status    |
      | create by admin | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | currentDate | Confirmed |

  @AD_Incoming_Inventory_28
  Scenario: AD_Incoming_Inventory 2
    Given BAO_ADMIN5 login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
      # Reset search filter full textbox
    And Admin filter visibility with id "68" by api
      | q[number]            |
      | q[brand_id]          |
      | q[warehouse_id]      |
      | q[below_threshold]   |
      | q[status]            |
      | q[end_date]          |
      | q[reference_number]  |
      | per_page             |
      | q[vendor_company_id] |
      | q[region_id]         |
      | q[creator_type]      |
      | q[lp_review]         |
      | q[start_date]        |
      | q[tracking_number]   |
      | q[freight_carrier]   |
    And Admin delete filter preset of screen id "68" by api
    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number  | vendorCompany | vendorBrand | region                   | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | [blank] | [blank]       | [blank]     | Atlanta Express          | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
      | [blank] | [blank]       | [blank]     | Chicagoland Express      | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
      | [blank] | [blank]       | [blank]     | Denver Express           | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
      | [blank] | [blank]       | [blank]     | Phoenix Express          | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
      | [blank] | [blank]       | [blank]     | Sacramento Express       | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
      | [blank] | [blank]       | [blank]     | Florida Express          | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
      | [blank] | [blank]       | [blank]     | Mid Atlantic Express     | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
      | [blank] | [blank]       | [blank]     | New York Express         | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
      | [blank] | [blank]       | [blank]     | North California Express | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
      | [blank] | [blank]       | [blank]     | South California Express | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
      | [blank] | [blank]       | [blank]     | Dallas Express           | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
    And Admin reset filter
    And Admin search incoming inventory
      | number  | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | [blank] | [blank]       | [blank]     | [blank] | Admin       | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
      | [blank] | [blank]       | [blank]     | [blank] | Vendor      | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
    And Admin reset filter
    And Admin choose options on dropdown "Status"
      | option    |
#      | Pod Planned |
      | Requested |
      | Confirmed |
#      | Approved    |
      | Received  |
      | Processed |
      | Canceled  |
    And Admin reset filter
    And Admin search incoming inventory
      | number  | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | [blank] | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | Yes      | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
      | [blank] | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | No       | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
    And Admin reset filter
    And Admin search incoming inventory
      | number  | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | [blank] | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | Yes     | [blank]        | [blank]         | [blank]        | [blank]     |
      | [blank] | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | No      | [blank]        | [blank]         | [blank]        | [blank]     |

    And Admin reset filter
    And Admin uncheck field of edit visibility in search
      | number  | brand   | warehouse | status  | below75 | endDate | referenceNumber | itemPerPage | vendorCompany | region  | initiatedBy | lpReview | startDate | freightCarrier | trackingNumber |
      | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]         | [blank]     | [blank]       | [blank] | [blank]     | [blank]  | [blank]   | [blank]        | [blank]        |
    Then Admin verify field search uncheck all in edit visibility
      | number  | brand   | warehouse | status  | below75 | endDate | referenceNumber | itemPerPage | vendorCompany | region  | initiatedBy | lpReview | startDate | freightCarrier | trackingNumber |
      | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]         | [blank]     | [blank]       | [blank] | [blank]     | [blank]  | [blank]   | [blank]        | [blank]        |

    And Admin uncheck field of edit visibility in search
      | number  | brand   | warehouse | status  | below75 | endDate | referenceNumber | itemPerPage | vendorCompany | region  | initiatedBy | lpReview | startDate | freightCarrier | trackingNumber |
      | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]         | [blank]     | [blank]       | [blank] | [blank]     | [blank]  | [blank]   | [blank]        | [blank]        |

    Then Admin verify field search in edit visibility
      | number  | brand   | warehouse | status  | below75 | endDate | referenceNumber | itemPerPage | vendorCompany | region  | initiatedBy | lpReview | startDate | freightCarrier | trackingNumber |
      | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]         | [blank]     | [blank]       | [blank] | [blank]     | [blank]  | [blank]   | [blank]        | [blank]        |
    And Admin uncheck field of edit visibility in search
      | number  | brand   | warehouse | status  | below75 | endDate | referenceNumber | itemPerPage |
      | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]         | [blank]     |
    Then Admin verify field search uncheck all in edit visibility
      | number  | brand   | warehouse | status  | below75 | endDate | referenceNumber | itemPerPage |
      | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]         | [blank]     |
    Then Admin verify field search in edit visibility
      | vendorCompany | region  | initiatedBy | lpReview | startDate | freightCarrier | trackingNumber |
      | [blank]       | [blank] | [blank]     | [blank]  | [blank]   | [blank]        | [blank]        |
    And Admin uncheck field of edit visibility in search
      | number  | brand   | warehouse | status  | below75 | endDate | referenceNumber | itemPerPage |
      | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]         | [blank]     |
    Then Admin verify field search in edit visibility
      | number  | brand   | warehouse | status  | below75 | endDate | referenceNumber | itemPerPage | vendorCompany | region  | initiatedBy | lpReview | startDate | freightCarrier | trackingNumber |
      | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]         | [blank]     | [blank]       | [blank] | [blank]     | [blank]  | [blank]   | [blank]        | [blank]        |
    And Admin search incoming inventory
      | number  | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | [blank] | [blank]       | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
    And Admin save filter by info
      | filterName | type               |
      | [blank]    | Save as new preset |
    And BAO_ADMIN12 check error message is showing of fields on dialog
      | field       | message                         |
      | Preset name | Please enter name filter preset |
    And Admin close dialog form
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin reset filter
    And BAO_ADMIN5 check value of field
      | field  | value |
      | Region | -     |
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN7 check value of field
      | field  | value               |
      | Region | Chicagoland Express |
    And Verify table result Incoming inventory
      | number | vendorCompany | brand   | region              | eta     | status  |
      | 23     | [blank]       | [blank] | Chicagoland Express | [blank] | [blank] |
    And Admin reset filter
    And Admin search incoming inventory
      | number | vendorCompany | vendorBrand | region          | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | 23     | [blank]       | [blank]     | Florida Express | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest2  | Save as new preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest2"
    And BAO_ADMIN5 check value of field
      | field  | value           |
      | Region | Florida Express |
      | Number | 23              |
    And Verify table result Incoming inventory
      | number | vendorCompany | brand   | region          | eta     | status  |
      | 23     | [blank]       | [blank] | Florida Express | [blank] | [blank] |
    And Admin delete filter preset is "AutoTest1"
      # Reset search filter full textbox
    And Admin filter visibility with id "68" by api
      | q[number]            |
      | q[brand_id]          |
      | q[warehouse_id]      |
      | q[below_threshold]   |
      | q[status]            |
      | q[end_date]          |
      | q[reference_number]  |
      | per_page             |
      | q[vendor_company_id] |
      | q[region_id]         |
      | q[creator_type]      |
      | q[lp_review]         |
      | q[start_date]        |
      | q[tracking_number]   |
      | q[freight_carrier]   |
    And Admin delete filter preset of screen id "68" by api

  @AD_Incoming_Inventory_47
  Scenario: Check display of New incoming inventory page
    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Click on button "Create"
    And Admin check help text tooltip1
      | field                            | text                                                              |
      | # of Pallets                     | If not shipping a pallet, please indicate 0                       |
      | Total # of Sellable Retail Cases | A sellable retail case is how your product is set up on Pod Foods |
    And Check any text "is" showing on screen
      | You must choose a vendor company and a region first |
    And Check any button "not" showing on screen
      | Add line item |
    And Admin input invalid "Vendor Company"
      | value                                 |
      | Auto Vendor company invalid name !@*& |
    And Admin input invalid "Warehouse"
      | value                                 |
      | Auto Vendor company invalid name !@*& |
    And Click on button "Create"
    And Admin check message is showing of fields
      | field          | message                                                   |
      | Vendor Company | Please select a vendor company for the incoming inventory |
      | Region         | Please select a region for the incoming inventory         |
      | Warehouse      | Please select warehouse for the incoming inventory        |
    And Check any text "is" showing on screen
      | Variant must have at least one |
    And Admin go back with button
    And Admin create new incoming inventory
      | vendorCompany | region  | warehouse | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | [blank]       | [blank] | [blank]   | -1               | -1       | -1            | [blank] | [blank]   |
    And Admin check message is showing of fields
      | field                        | message                   |
      | # of Pallets                 | Please input valid number |
      | Estimated Weeks of Inventory | Please input valid number |

    And Admin increase field number tooltip 1 times
      | field        | text |
      | # of Pallets | 0    |
    And Admin check message not showing of fields
      | field        | message                   |
      | # of Pallets | Please input valid number |
    And Admin decrease field number tooltip 1 times
      | field        | text |
      | # of Pallets | -1   |
    And Admin check message is showing of fields
      | field        | message                   |
      | # of Pallets | Please input valid number |
    And Admin increase field number tooltip 1 times
      | field                        | text |
      | Estimated Weeks of Inventory | 0    |
    And Admin check message not showing of fields
      | field                        | message                   |
      | Estimated Weeks of Inventory | Please input valid number |
    And Admin decrease field number tooltip 1 times
      | field                        | text |
      | Estimated Weeks of Inventory | -1   |
    And Admin check message is showing of fields
      | field                        | message                   |
      | Estimated Weeks of Inventory | Please input valid number |

  @AD_Incoming_Inventory_54
  Scenario: Check popup Select line item when add line item
    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And Click on button "Add line item"
    And Search line item "AT Sku inbound 01" and check list SKU incoming inventory
      | sku               | brand                 | product           | price   | status   | show     |
      | AT Sku inbound 01 | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | $100.00 | In stock | show     |
      | AT Sku inbound 02 | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | $100.00 | In stock | not show |

    And Search line item "Auto Ngoc Inbound" and check list SKU incoming inventory
      | sku               | brand                 | product           | price   | status   | show     |
      | AT Sku inbound 44 | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | $100.00 | In stock | show     |
      | AT Sku inbound 02 | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | $100.00 | In stock | not show |
    And Search line item "AutoTest Brand Ngoc01" and check list SKU incoming inventory
      | sku               | brand                 | product           | price   | status   | show     |
      | AT Sku inbound 44 | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | $100.00 | In stock | show     |
      | AT Sku inbound 02 | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | $100.00 | In stock | not show |

  @AD_Incoming_Inventory_55
  Scenario: Check display of SKU after added > Then, admin changes Vendor company, Region
    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note          | adminNote           |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 8        | 5             | Autotest note | Autotest admin note |
    And With SKUs
      | sku               | ofCase  |
      | AT Sku inbound 14 | [blank] |
      | AT Sku inbound 19 | [blank] |
    And Check SKUs on create new incoming inventory form
      | index | brandSKU              | productSKU        | nameSKU           | unitUpc      | ofCaseSKU | caseUnit           | masterCarton | storeShelfLife | temperature |
      | 1     | AUTOTEST BRAND NGOC01 | Auto Ngoc Inbound | AT Sku inbound 14 | 123456789012 | [blank]   | 1 cases per pallet | N/A          | 100            | 1.0 - 1.0   |
      | 1     | AUTOTEST BRAND NGOC01 | Auto Ngoc Inbound | AT Sku inbound 19 | 123456789012 | [blank]   | 1 cases per pallet | N/A          | 1              | 1.0 - 1.0   |
    And Admin choose options on dropdown "Vendor Company" input with value "ngoc vc2"
      | option   |
      | ngoc vc2 |
    And Check any text "not" showing on screen
      | Auto Ngoc Inbound |
      | AT Sku inbound 14 |
      | AT Sku inbound 19 |
    And Admin choose options on dropdown "Vendor Company" input with value "ngoc vc 1"
      | option    |
      | ngoc vc 1 |
    And With SKUs
      | sku               | ofCase  |
      | AT Sku inbound 14 | [blank] |
      | AT Sku inbound 19 | [blank] |
    And Check SKUs on create new incoming inventory form
      | index | brandSKU              | productSKU        | nameSKU           | unitUpc      | ofCaseSKU | caseUnit           | masterCarton | storeShelfLife | temperature |
      | 1     | AUTOTEST BRAND NGOC01 | Auto Ngoc Inbound | AT Sku inbound 14 | 123456789012 | [blank]   | 1 cases per pallet | N/A          | 100            | 1.0 - 1.0   |
      | 1     | AUTOTEST BRAND NGOC01 | Auto Ngoc Inbound | AT Sku inbound 19 | 123456789012 | [blank]   | 1 cases per pallet | N/A          | 1              | 1.0 - 1.0   |
    And Admin choose options on dropdown "Region"
      | option          |
      | Florida Express |
    And BAO_ADMIN5 check value of field
      | field     | value   |
      | Warehouse | [blank] |
    And Check any text "not" showing on screen
      | Auto Ngoc Inbound |
      | AT Sku inbound 14 |
      | AT Sku inbound 19 |

  @AD_Incoming_Inventory_56
  Scenario: Check admin removes line item
    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note          | adminNote           |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 8        | 5             | Autotest note | Autotest admin note |
    And With SKUs
      | sku               | ofCase  |
      | AT Sku inbound 14 | [blank] |
#      | AT Sku inbound 19 | [blank] |
    And Click on button "Create"
    And Admin check message is showing of fields
      | field      | message                     |
      | # of Cases | Please input valid quantity |
    And Admin remove SKU "AT Sku inbound 14" from incoming inventory
    And Click on button "Create"
    And Check any text "is" showing on screen
      | Variant must have at least one |

  @AD_Incoming_Inventory_62
  Scenario: Incoming Inventory detail page
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
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

#Submit inbound
#    And Admin set items info to submit of Incoming Inventory "api" api
#      | sku                                        | lot_code                                   | quantity | expiry_date |
#      | random sku admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | 10       | Plus1       |
#    And Admin submit Incoming Inventory id "api" api
#      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
#      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
#
    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | 12          |
    And Verify table result Incoming inventory
      | number        | vendorCompany       | brand                     | region              | eta     | status    |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] | Requested |
    And Go to detail of incoming inventory number "create by api"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany       | status    | warehouse            | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | [blank]        | Auto vendor company | Requested | Bao Distribution CHI | [blank] | 1   | 10       | 10               | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | -              | -               | -             | -              | No       |
    And Admin subscribe incoming inventory
    And Admin unsubscribe incoming inventory
    And Admin download "Inbound packing list" PDF incoming inventory
    And Admin download "Replenishment Request Slip" PDF incoming inventory
    And Admin download Excel incoming inventory
    And Admin check help text tooltip1
      | field                                        | text                                                                                                                     |
      | # of Pallets                                 | If not shipping a pallet, please indicate 0                                                                              |
      | Total # of Sellable Retail Cases             | A sellable retail case is how your product is set up on Pod Foods                                                        |
      | # of Master Cartons                          | A master carton is a shipping carton which contains multiple sellable retail cases of the same item                      |
      | # of Sellable Retail Cases per Master Carton | If not shipping in master cartons, please indicate 0                                                                     |
      | Notes                                        | Vendors can view this field on vendor dashboard                                                                          |
      | Admin note                                   | Vendors can’t view this field on vendor dashboard                                                                        |
      | Other special shipping details               | e.g. if SKUs are color-coded, separated by layers on the pallet etc                                                      |
      | Freight Carrier                              | If using a freight carrier - please indicate the carrier name and PRO/PO/BOL/Load Number and tracking links if available |
      | Transportation Coordinator Contact           | Please add contact name & number for your freight broker                                                                 |

    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                     | nameSKU                                    | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | note    | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | [blank]    | 10        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |
    And Admin check help text tooltip1
      | field                           | text                                                                                                                          |
      | Lot code                        | If your product has a lot code, enter that. If not, enter expiration date                                                     |
      | # of originally suggested cases | This is a quantity admins suggested a vendor to send. If the field is blank, the inbound inventory was initiated by a vendor. |

  @AD_Incoming_Inventory_95
  Scenario: Incoming Inventory edit information
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
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

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | 12          |
    And Verify table result Incoming inventory
      | number        | vendorCompany       | brand                     | region              | eta     | status    |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] | Requested |
    And Go to detail of incoming inventory number "create by api"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany       | status    | warehouse            | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | [blank]        | Auto vendor company | Requested | Bao Distribution CHI | [blank] | 1   | 10       | 10               | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | -              | -               | -             | -              | No       |

    And Admin edit general information of incoming inventory
      | region           | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | New York Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
#      | New York Express | Brand Self Delivery | Minus1        | 1             | 20        | 50         | 0              | 0          | Yes     | Yes       | 2           | 11111   | ABC  | XYZ       | 8789564 | 24235   | 5243524  | 09678           | Strange       | 0948374658     | anhJPEG.jpg |
    And Admin check General Information of Incoming inventory
      | region           | deliveryMethod | vendorCompany       | status    | warehouse | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | New York Express | [blank]        | Auto vendor company | Requested | N/A       | [blank] | 1   | 10       | 0                | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | -              | -               | -             | -              | No       |
    And Check any text "is" showing on screen
      | Variant must have at least one |
    And Admin edit general information of incoming inventory
      | region               | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | Mid Atlantic Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region               | deliveryMethod | vendorCompany       | status    | warehouse | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | Mid Atlantic Express | [blank]        | Auto vendor company | Requested | N/A       | [blank] | 1   | 10       | 0                | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | -              | -               | -             | -              | No       |
    And Admin edit general information of incoming inventory
      | region                   | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | North California Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region                   | deliveryMethod | vendorCompany       | status    | warehouse | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | North California Express | [blank]        | Auto vendor company | Requested | N/A       | [blank] | 1   | 10       | 0                | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | -              | -               | -             | -              | No       |
    And Admin edit general information of incoming inventory
      | region                   | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | South California Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region                   | deliveryMethod | vendorCompany       | status    | warehouse | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | South California Express | [blank]        | Auto vendor company | Requested | N/A       | [blank] | 1   | 10       | 0                | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | -              | -               | -             | -              | No       |
    And Admin edit general information of incoming inventory
      | region         | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | Dallas Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod | vendorCompany       | status    | warehouse | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | Dallas Express | [blank]        | Auto vendor company | Requested | N/A       | [blank] | 1   | 10       | 0                | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | -              | -               | -             | -              | No       |
    And Admin edit delivery method of incoming inventory
      | deliveryMethod         | trackingNumber |
      | Small Package / Parcel | [blank]        |
    And BAO_ADMIN5 check error message is showing of fields
      | field           | message                      |
      | Tracking Number | Please input tracking number |
    And Admin edit delivery method of incoming inventory
      | deliveryMethod      | trackingNumber |
      | Brand Self Delivery | [blank]        |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status    | warehouse | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Requested | N/A       | [blank] | 1   | 10       | 0                | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | -              | -               | -             | -              | No       |
    And Admin edit delivery method of incoming inventory
      | deliveryMethod      | trackingNumber |
      | Brand Self Delivery | 123Abc         |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status    | warehouse | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Requested | N/A       | [blank] | 1   | 10       | 0                | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | 123Abc         | -               | -             | -              | No       |
    And Admin edit delivery method of incoming inventory
      | deliveryMethod         | trackingNumber |
      | Small Package / Parcel | 123Abc         |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod         | vendorCompany       | status    | warehouse | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | transportName | transportPhone | transfer |
      | Dallas Express | Small Package / Parcel | Auto vendor company | Requested | N/A       | [blank] | 1   | 10       | 0                | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | 123Abc         | -             | -              | No       |
    And Check any text "not" showing on screen
      | Reference Number |
    And Add the warehouse "Auto distribute Texas Express" for incoming inventory
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod         | vendorCompany       | status    | warehouse                     | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | transportName | transportPhone | transfer |
      | Dallas Express | Small Package / Parcel | Auto vendor company | Requested | Auto distribute Texas Express | [blank] | 1   | 10       | 0                | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | 123Abc         | -             | -              | No       |
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | 0             | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check alert message
      | Estimated covered period must be greater than 0 |
    And Click on tooltip button "Cancel"
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | -1            | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And BAO_ADMIN5 check error message is showing of fields
      | field                        | message                   |
      | Estimated Weeks of Inventory | Please input valid number |
    And Click on tooltip button "Cancel"
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | 10            | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod         | vendorCompany       | status    | warehouse                     | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | transportName | transportPhone | transfer |
      | Dallas Express | Small Package / Parcel | Auto vendor company | Requested | Auto distribute Texas Express | [blank] | 10  | 10       | 0                | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | 123Abc         | -             | -              | No       |
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | [blank]       | -1        | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And BAO_ADMIN5 check error message is showing of fields
      | field        | message                   |
      | # of Pallets | Please input valid number |
    And Click on tooltip button "Cancel"
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | [blank]       | 0         | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod         | vendorCompany       | status    | warehouse                     | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | transportName | transportPhone | transfer |
      | Dallas Express | Small Package / Parcel | Auto vendor company | Requested | Auto distribute Texas Express | [blank] | 10  | 0        | 0                | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | 123Abc         | -             | -              | No       |
    And Admin upload file to inbound
      | bol     | pod             |
      | [blank] | 10MBgreater.jpg |
    And Admin check alert message
      | Maximum file size exceeded. |
    And Admin upload file to inbound
      | bol     | pod             |
      | [blank] | POD_Invalid.csv |
    And Admin check alert message
      | Validation failed: Proof of delivery attachment content type is invalid |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod         | vendorCompany       | status    | warehouse                     | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | transportName | transportPhone | transfer | pod     |
      | Dallas Express | Small Package / Parcel | Auto vendor company | Requested | Auto distribute Texas Express | [blank] | 10  | 0        | 0                | 1              | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | 123Abc         | -             | -              | No       | [blank] |

  @AD_Incoming_Inventory_105
  Scenario: Incoming Inventory Check display of the SIGNED WPL section
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
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
      | region_id | vendor_company_id | num_of_pallet | num_of_master_carton | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                   | 10                          | 1                        | 1     | 1          | 81           |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | 12          |
    And Verify table result Incoming inventory
      | number        | vendorCompany       | brand                     | region              | eta     | status    |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] | Requested |
    And Go to detail of incoming inventory number "create by api"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany       | status    | warehouse            | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | [blank]        | Auto vendor company | Requested | Bao Distribution CHI | [blank] | 1   | 10       | 10               | 10             | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | -              | -               | -             | -              | No       |
    And Admin upload signed WPL
      | wpl             |
      | 10MBgreater.jpg |
    And Admin check alert message
      | Maximum file size exceeded. |
    And Admin remove signed WPL number "1"
    And Admin upload signed WPL
      | wpl       |
      | test.docx |
    And Admin save signed WPL number
    And Admin check alert message
      | Validation failed: Signed wpls attachment content type is invalid |
    And Admin remove signed WPL number "1"
    And Admin upload signed WPL
      | wpl         |
      | anhJPEG.jpg |
      | anhPNG.png  |
    And Admin save signed WPL number
    And Admin verify signed WPL
      | index | fileName    |
      | 1     | anhJPEG.jpg |
      | 2     | anhPNG.png  |

  @AD_Incoming_Inventory_109 @AD_Incoming_Inventory_132 @AD_Incoming_Inventory_135
  Scenario: Check display of SKU INFORMATION section
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

    And Create product by api with file "CreateProduct.json" and info
      | name                                           | brand_id |
      | random product admin inbound inventory 1 api 2 | 3002     |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 1 api 2" of product ""
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 5        |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_master_carton | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                   | 10                          | 1                        | 1     | 1          | 81           |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | 12          |
    And Verify table result Incoming inventory
      | number        | vendorCompany       | brand                     | region              | eta     | status    |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] | Requested |
    And Go to detail of incoming inventory number "create by api"
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                     | nameSKU                                    | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | note    | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 10        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |
      | 1     | Auto Brand promotion      | random product admin inbound inventory 1 api 2 | random sku admin inbound inventory 1 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 5         | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 5             | [blank] | Dry                       |
    And Admin redirect "Auto brand create product" from list SKU of Incoming inventory
    And Admin verify general information in brand detail
      | status | name                      | description | microDescriptions | inboundInventoryMOQ | city    | state   | vendorCompany       | launchedBy | managedBy |
      | Active | Auto brand create product | [blank]     | [blank]           | [blank]             | [blank] | [blank] | Auto vendor company | [blank]    | [blank]   |
    And BAO_ADMIN5 go back
    And Admin redirect "random product admin inbound inventory 1 api 1" from list SKU of Incoming inventory
    And Admin check product detail
      | stateStatus | productName                                    | brand                     | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | random product admin inbound inventory 1 api 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | [blank]    |
    And BAO_ADMIN5 go back
    And Admin redirect "random sku admin inbound inventory 1 api 1" from list SKU of Incoming inventory
    And Admin check general info of SKU
      | skuName                                    | state  | itemCode | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient  | leadTime | description | expireDayThreshold |
      | random sku admin inbound inventory 1 api 1 | Active | [blank]  | Yes     | 1         | 123123123123      | [blank]               | masterImage.jpg | 123123123123 | UPCImage.png | CaseImage.png | 1                | Dry              | 1               | Dry             | 1.0                | 1.0                | Chicago | Illinois         | Ingredients | [blank]  | Description | 100                |
    And BAO_ADMIN5 go back
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                     | nameSKU                                    | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | note    | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 1 api 1 | random sku admin inbound inventory 1 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 10        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |
      | 1     | Auto Brand promotion      | random product admin inbound inventory 1 api 2 | random sku admin inbound inventory 1 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 5         | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 5             | [blank] | Dry                       |
    And Admin remove SKU "random sku admin inbound inventory 1 api 1" from incoming inventory
    And Admin edit sku information
      | index | skuName                                    | lotcode                                    | expiredDate | ofCases | receivingDate | suggestedCase | damagedCase | excessCase | shortedCase | caseReceived | note    |
      | 1     | random sku admin inbound inventory 1 api 2 | random sku admin inbound inventory 1 api 2 | [blank]     | 20      | [blank]       | 10            | [blank]     | [blank]    | [blank]     | [blank]      | [blank] |
    And Click on button "Update Request"
    And Admin check alert message
      | SKUs has been updated successfully !! |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU             | productSKU                                     | nameSKU                                    | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | note    | storageShelfLifeCondition |
      | 1     | Auto Brand promotion | random product admin inbound inventory 1 api 2 | random sku admin inbound inventory 1 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 20        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |
    And Admin add sku into incoming inventory then update request
      | index | sku                                        | ofCase |
      | 2     | random sku admin inbound inventory 1 api 2 | 10     |
    And Click on button "Update Request"
    And Admin check alert message
      | SKUs has been updated successfully !! |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU             | productSKU                                     | nameSKU                                    | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU                                 | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | note    | storageShelfLifeCondition |
      | 1     | Auto Brand promotion | random product admin inbound inventory 1 api 2 | random sku admin inbound inventory 1 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]                                    | 10        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |
      | 2     | Auto Brand promotion | random product admin inbound inventory 1 api 2 | random sku admin inbound inventory 1 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | random sku admin inbound inventory 1 api 2 | 20        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |

  @AD_Incoming_Inventory_137
  Scenario: Check display of the submit form
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 137 api" by api
    And Admin delete product name "random product admin inbound inventory 137 api" by api
  # Reset search filter full textbox
    And Admin filter visibility with id "68" by api
      | q[number]            |
      | q[brand_id]          |
      | q[warehouse_id]      |
      | q[below_threshold]   |
      | q[status]            |
      | q[end_date]          |
      | q[reference_number]  |
      | per_page             |
      | q[vendor_company_id] |
      | q[region_id]         |
      | q[creator_type]      |
      | q[lp_review]         |
      | q[start_date]        |
      | q[tracking_number]   |
      | q[freight_carrier]   |
    And Admin delete filter preset of screen id "68" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product admin inbound inventory 137 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 137 api 1" of product ""

    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 10                   | 1                        | 1     | 1          | 81           |
    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | 12          |
    And Go to detail of incoming inventory number "create by api"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany       | status    | warehouse            | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | [blank]        | Auto vendor company | Requested | Bao Distribution CHI | [blank] | 1   | 10       | 10               | 10             | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | -              | -               | -             | -              | No       |
    And Admin changes status incoming inventory to "Confirmed"
    And Admin check submit incoming inventory form
      | vendorCompany       | region              | deliveryMethod | eta     | ofPallet | ofSellable | ofMasterCarton | ofSellableMasterCarton | otherDetail | freightCarrier | trackingNumber | referenceNumber | stackableTransit | stackableWarehouse | transportName | transportPhone | totalWeight | zipCode |
      | Auto vendor company | Chicagoland Express | [blank]        | [blank] | 10       | 10         | 1              | [blank]                | [blank]     | [blank]        | [blank]        | [blank]         | [blank]          | [blank]            | [blank]       | [blank]        | [blank]     | [blank] |
    And Admin check SKU section submit incoming inventory form
      | index | brand                     | product                                          | sku                                          | units              | lotCode | ofCases | expirationData | receivingData | note    |
      | 1     | Auto brand create product | random product admin inbound inventory 137 api 1 | random sku admin inbound inventory 137 api 1 | 1 cases per pallet | [blank] | 10      | [blank]        | [blank]       | [blank] |
    And Admin close submit incoming inventory
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany       | status    | warehouse            | eta     | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping | freightCarrier | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | [blank]        | Auto vendor company | Requested | Bao Distribution CHI | [blank] | 1   | 10       | 10               | 10             | -                         | -       | N/A           | N/A             | 0.00 lbs    | 1    | 1         | -             | -              | -              | -               | -             | -              | No       |
    And Admin add sku into incoming inventory then update request
      | index | sku                                          | ofCase |
      | 2     | random sku admin inbound inventory 137 api 1 | 5      |
    And Click on button "Update Request"
    And Admin check alert message
      | SKUs has been updated successfully !! |
    And Admin changes status incoming inventory to "Confirmed"
    And Admin check submit incoming inventory form
      | vendorCompany       | region              | deliveryMethod | eta     | ofPallet | ofSellable | ofMasterCarton | ofSellableMasterCarton | otherDetail | freightCarrier | trackingNumber | referenceNumber | stackableTransit | stackableWarehouse | transportName | transportPhone | totalWeight | zipCode |
      | Auto vendor company | Chicagoland Express | [blank]        | [blank] | 10       | 15         | 15             | [blank]                | [blank]     | [blank]        | [blank]        | [blank]         | [blank]          | [blank]            | [blank]       | [blank]        | [blank]     | [blank] |
    And Admin check SKU section submit incoming inventory form
      | index | brand                     | product                                          | sku                                          | units              | lotCode | ofCases | expirationData | receivingData | note    |
      | 1     | Auto brand create product | random product admin inbound inventory 137 api 1 | random sku admin inbound inventory 137 api 1 | 1 cases per pallet | [blank] | 5       | [blank]        | [blank]       | [blank] |
      | 2     | Auto brand create product | random product admin inbound inventory 137 api 1 | random sku admin inbound inventory 137 api 1 | 1 cases per pallet | [blank] | 10      | [blank]        | [blank]       | [blank] |
    And Admin fill submit incoming inventory form
      | deliveryMethod        | estimatedDate | ofPallets | ofSellAble | otherShipping  | freightCarrier  | trackingNumber | referenceNumber | stackableTransit | stackableWarehouse | totalWeight | zipCode | transportName | transportPhone | bol     |
      | Freight Carrier / LTL | currentDate   | [blank]   | 10         | other Shipping | freight Carrier | [blank]        | 123             | Yes              | Yes                | 10          | 11111   | auto          | 0123456789     | BOL.pdf |
    And Admin fill sku info submit incoming inventory form
      | index | skuName                                      | lotCode | estimateDateSKU | ofCase  | receivingDate | note        |
      | 1     | random sku admin inbound inventory 137 api 1 | random  | currentDate     | [blank] | [blank]       | Auto note 1 |
      | 2     | random sku admin inbound inventory 137 api 1 | random  | Plus1           | [blank] | [blank]       | Auto note 2 |
    And Click on dialog button "Submit"
    And Admin check alert message
      | Inventory has been confirmed successfully! |
    And Admin view changelog incoming inventory
      | state               | updateBy                | updateOn    |
      | Requested→Confirmed | Admin: bao5@podfoods.co | currentDate |
      | →Requested          | Admin: bao4@podfoods.co | currentDate |
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany       | status    | warehouse            | eta         | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping  | freightCarrier  | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | [blank]        | Auto vendor company | Confirmed | Bao Distribution CHI | currentDate | 1   | 10       | 15               | 15             | 10                        | 11111   | Yes           | Yes             | 10.00 lbs   | 1    | 1         | other Shipping | freight Carrier | 123             | auto          | 0123456789     | No       |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU    | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge     | storageShelfLife | temperature | temperatureCondition | suggestedCase | excessCase | shortedCase | receivedCase | note        | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 137 api 1 | random sku admin inbound inventory 137 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | randomInbound | 5         | currentDate   | currentDate      | Below 75% | 1                | 1.0 - 1.0   | °F                   | 5             | 0          | 0           | [blank]      | Auto note 1 | Dry                       |
      | 2     | Auto brand create product | random product admin inbound inventory 137 api 1 | random sku admin inbound inventory 137 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | randomInbound | 10        | Plus1         | currentDate      | Below 75% | 1                | 1.0 - 1.0   | °F                   | 10            | 0          | 0           | [blank]      | Auto note 2 | Dry                       |

  @AD_Incoming_Inventory_138
  Scenario: Check display of the submit form - validate
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin filter visibility with id "68" by api
      | q[number]            |
      | q[brand_id]          |
      | q[warehouse_id]      |
      | q[below_threshold]   |
      | q[status]            |
      | q[end_date]          |
      | q[reference_number]  |
      | per_page             |
      | q[vendor_company_id] |
      | q[region_id]         |
      | q[creator_type]      |
      | q[lp_review]         |
      | q[start_date]        |
      | q[tracking_number]   |
      | q[freight_carrier]   |
    And Admin delete filter preset of screen id "68" by api
    And Admin delete order by sku of product "random product admin inbound inventory 138 api" by api
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 138 api" by api
    And Admin delete product name "random product admin inbound inventory 138 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product admin inbound inventory 138 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 138 api 1" of product ""

    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 10                   | 1                        | 1     | 1          | 81           |
    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | 12          |

    And Go to detail of incoming inventory number "create by api"
    And Admin changes status incoming inventory to "Confirmed"
#    And Admin fill sku info submit incoming inventory form
#      | index | skuName                                      | lotCode | estimateDateSKU | ofCase  | receivingDate | note        |
#      | 1     | random sku admin inbound inventory 137 api 1 | random  | currentDate     | [blank] | [blank]       | Auto note 1 |
    And Scroll to dialog button "Submit"
    And Click on dialog button "Submit"
    And Admin check error message is showing of fields on dialog
      | field                                        | message                                         |
      | Inbound Delivery Method                      | Please select delivery method                   |
      | Estimated Date of Arrival                    | Please input estimated date of arrival          |
      | # of Sellable Retail Cases per Master Carton | Please input number of retail per master carton |
      | Total weight of shipment?                    | Please input number of total weight             |
      | What zip code is the shipment coming from?   | Please input zip code                           |
    And Admin fill submit incoming inventory form
      | deliveryMethod        | estimatedDate | ofPallets | ofSellAble | otherShipping | freightCarrier | trackingNumber | referenceNumber | stackableTransit | stackableWarehouse | totalWeight | zipCode | transportName | transportPhone | bol     |
      | Freight Carrier / LTL | Minus1        | -1        | -1         | [blank]       | [blank]        | [blank]        | [blank]         | [blank]          | [blank]            | -1          | 1       | [blank]       | [blank]        | [blank] |
    And Admin check error message is showing of fields on dialog
      | field                                        | message                                         |
      | # of Pallets                                 | Please input valid number                       |
      | # of Sellable Retail Cases per Master Carton | Please input number of retail per master carton |
      | Total weight of shipment?                    | Please input number of total weight             |
      | What zip code is the shipment coming from?   | Please enter a valid zip code                   |
    And Admin check error message no showing of fields on dialog
      | field                     | message                                |
      | Estimated Date of Arrival | Please input estimated date of arrival |
    And Admin fill submit incoming inventory form
      | deliveryMethod      | estimatedDate | ofPallets | ofSellAble | otherShipping | freightCarrier | trackingNumber | referenceNumber | stackableTransit | stackableWarehouse | totalWeight | zipCode | transportName | transportPhone | bol     |
      | Brand Self Delivery | Plus1         | 0         | 0          | [blank]       | [blank]        | [blank]        | [blank]         | [blank]          | [blank]            | 0           | a       | [blank]       | [blank]        | [blank] |
    And Admin check error message no showing of fields on dialog
      | field                                        | message                                         |
      | Estimated Date of Arrival                    | Please input estimated date of arrival          |
      | # of Pallets                                 | Please input valid number                       |
      | Inbound Delivery Method                      | Please select delivery method                   |
      | # of Sellable Retail Cases per Master Carton | Please input number of retail per master carton |
    And Admin check error message is showing of fields on dialog
      | field                                      | message                             |
      | Total weight of shipment?                  | Please input number of total weight |
      | What zip code is the shipment coming from? | Please enter a valid zip code       |
    And Admin fill submit incoming inventory form
      | deliveryMethod | estimatedDate | ofPallets | ofSellAble | otherShipping | freightCarrier | trackingNumber | referenceNumber | stackableTransit | stackableWarehouse | totalWeight | zipCode | transportName | transportPhone | bol       |
      | [blank]        | [blank]       | [blank]   | [blank]    | [blank]       | [blank]        | [blank]        | [blank]         | [blank]          | [blank]            | [blank]     | [blank] | [blank]       | [blank]        | test.docx |
    And Admin check alert message
      | Invalid file type. |
    And Admin fill sku info submit incoming inventory form
      | index | skuName                                      | lotCode | estimateDateSKU | ofCase | receivingDate | note    |
      | 1     | random sku admin inbound inventory 138 api 1 | [blank] | [blank]         | -1     | [blank]       | [blank] |
    And Admin check error message is showing of fields on dialog
      | field      | message               |
      | # of Cases | Please input quantity |
    And Admin fill sku info submit incoming inventory form
      | index | skuName                                      | lotCode | estimateDateSKU | ofCase | receivingDate | note    |
      | 1     | random sku admin inbound inventory 138 api 1 | [blank] | [blank]         | 0      | [blank]       | [blank] |
    And Admin check error message is showing of fields on dialog
      | field      | message               |
      | # of Cases | Please input quantity |
    And Admin fill sku info submit incoming inventory form
      | index | skuName                                      | lotCode  | estimateDateSKU | ofCase | receivingDate | note        |
      | 1     | random sku admin inbound inventory 138 api 1 | random   | Plus2           | 1      | Plus2         | Auto note 1 |
      | 2     | random sku admin inbound inventory 138 api 1 | [random] | Plus2           | 2      | Plus2         | Auto note 2 |
    And Admin fill submit incoming inventory form
      | deliveryMethod        | estimatedDate | ofPallets | ofSellAble | otherShipping | freightCarrier | trackingNumber | referenceNumber | stackableTransit | stackableWarehouse | totalWeight | zipCode | transportName | transportPhone | bol     |
      | Freight Carrier / LTL | Plus1         | 1         | 1          | [blank]       | [blank]        | [blank]        | [blank]         | [blank]          | [blank]            | 1           | 11111   | [blank]       | [blank]        | [blank] |
    And Click on dialog button "Submit"
    And Admin check alert message
      | Same product variants can't have same expire date |

  @AD_Incoming_Inventory_183
  Scenario: CONFIRMED Incoming Inventory detail page
    Given BAO_ADMIN login web admin by api
      | email             | password  |
      | bao13@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 183 api" by api
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 183 api" by api
    And Admin delete product name "random product admin inbound inventory 183 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product admin inbound inventory 183 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 183 api 1" of product ""
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 10                   | 1                        | 1     | admin_note | 81           |
#Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                          | lot_code | quantity | expiry_date |
      | random sku admin inbound inventory 183 api 1 | [blank]  | 10       | [blank]     |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail   | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 10            | 10                          | 10                   | 10                              | submitted | 10           | 11111    | admin_note | 81           | other Shipping | freight Carrier | tracking_number | 123              | auto                       | 0123456789                  |

    Given BAO_ADMIN13 open web admin
    When BAO_ADMIN13 login to web with role Admin
    And BAO_ADMIN13 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
    And Go to detail of incoming inventory number "create by api"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod        | vendorCompany       | status    | warehouse            | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | Freight Carrier / LTL | Auto vendor company | Confirmed | Bao Distribution CHI | No       | Plus1 | 1   | 10       | 10               | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | 123             | auto          | 0123456789     | No       |
    And Admin view changelog incoming inventory
      | state               | updateBy                 | updateOn    |
      | Requested→Confirmed | Admin: bao13@podfoods.co | currentDate |
      | →Requested          | Admin: bao13@podfoods.co | currentDate |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | storageShelfLife | temperature | temperatureCondition | suggestedCase | excessCase | shortedCase | receivedCase | note    | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 183 api 1 | random sku admin inbound inventory 183 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 10        | [blank]       | Plus1            | 1                | 1.0 - 1.0   | °F                   | 10            | 0          | 0           | [blank]      | [blank] | Dry                       |
    And Admin upload signed WPL
      | wpl             |
      | 10MBgreater.jpg |
    And Admin check alert message
      | Maximum file size exceeded. |
    And Admin remove signed WPL number "1"
    And Admin upload signed WPL
      | wpl       |
      | test.docx |
    And Admin save signed WPL number
    And Admin check alert message
      | Validation failed: Signed wpls attachment content type is invalid |
    And Admin remove signed WPL number "1"
    And Admin upload signed WPL
      | wpl         |
      | anhJPEG.jpg |
      | anhPNG.png  |
    And Admin save signed WPL number
    And BAO_ADMIN13 wait button "Save" not visible after 10 seconds
    And Admin verify signed WPL
      | index | fileName    |
      | 1     | anhJPEG.jpg |
      | 2     | anhPNG.png  |
    And Admin update inbound inventory images
      | index | image           | description |
      | 1     | 10MBgreater.jpg | [blank]     |
    And Admin check alert message
      | Maximum file size exceeded. |
    And Admin remove inbound inventory images
      | index |
      | 1     |
    And Admin update inbound inventory images
      | index | image     | description |
      | 1     | test.docx | [blank]     |
    And Admin save inbound inventory images
    And Admin check alert message
      | Validation failed: Inbound inventory images attachment content type is invalid |
    And Admin remove inbound inventory images
      | index |
      | 1     |
    And Admin update inbound inventory images
      | index | image       | description |
      | 1     | anhPNG.png  | Autotest_1  |
      | 2     | anhJPEG.jpg | Autotest_2  |
    And Admin save inbound inventory images
    And BAO_ADMIN13 wait button "Save" not visible after 15 seconds
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod        | vendorCompany       | status   | warehouse            | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | Freight Carrier / LTL | Auto vendor company | Received | Bao Distribution CHI | No       | Plus1 | 1   | 10       | 10               | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | 123             | auto          | 0123456789     | No       |
    And Admin view changelog incoming inventory
      | state               | updateBy                 | updateOn    |
      | Confirmed→Received  | Admin: bao13@podfoods.co | currentDate |
      | Requested→Confirmed | Admin: bao13@podfoods.co | currentDate |
      | →Requested          | Admin: bao13@podfoods.co | currentDate |

  @AD_Incoming_Inventory_220
  Scenario: CONFIRMED Incoming Inventory Check edit
    Given BAO_ADMIN login web admin by api
      | email             | password  |
      | bao13@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 220 api" by api
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 220 api" by api
    And Admin delete product name "random product admin inbound inventory 220 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product admin inbound inventory 220 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 220 api 1" of product ""
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 10                   | 1                        | 1     | admin_note | 81           |
#Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                          | lot_code | quantity | expiry_date |
      | random sku admin inbound inventory 220 api 1 | [blank]  | 10       | [blank]     |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail   | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 10            | 10                          | 10                   | 10                              | submitted | 10           | 11111    | admin_note | 81           | other Shipping | freight Carrier | tracking_number | 123              | auto                       | 0123456789                  |
    Given BAO_ADMIN13 open web admin
    When BAO_ADMIN13 login to web with role Admin
    And BAO_ADMIN13 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
    And Go to detail of incoming inventory number "create by api"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod        | vendorCompany       | status    | warehouse            | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | Freight Carrier / LTL | Auto vendor company | Confirmed | Bao Distribution CHI | No       | Plus1 | 1   | 10       | 10               | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | 123             | auto          | 0123456789     | No       |
    And Admin edit general information of incoming inventory
      | region           | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | New York Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region           | deliveryMethod | vendorCompany       | status    | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | New York Express | [blank]        | Auto vendor company | Confirmed | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |
    And Check any text "is" showing on screen
      | Variant must have at least one |
    And Admin edit general information of incoming inventory
      | region               | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | Mid Atlantic Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region               | deliveryMethod | vendorCompany       | status    | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | Mid Atlantic Express | [blank]        | Auto vendor company | Confirmed | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |
    And Admin edit general information of incoming inventory
      | region                   | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | North California Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region                   | deliveryMethod | vendorCompany       | status    | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | North California Express | [blank]        | Auto vendor company | Confirmed | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |
    And Admin edit general information of incoming inventory
      | region                   | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | South California Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region                   | deliveryMethod | vendorCompany       | status    | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | South California Express | [blank]        | Auto vendor company | Confirmed | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |
    And Admin edit general information of incoming inventory
      | region         | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | Dallas Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod | vendorCompany       | status    | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | Dallas Express | [blank]        | Auto vendor company | Confirmed | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |

    And Admin edit delivery method of incoming inventory
      | deliveryMethod      | trackingNumber |
      | Brand Self Delivery | [blank]        |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status    | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Confirmed | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |
    And Admin edit delivery method of incoming inventory
      | deliveryMethod      | trackingNumber |
      | Brand Self Delivery | 123Abc         |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status    | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Confirmed | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | 123Abc         | 123             | auto          | 0123456789     | No       |
    And Add the warehouse "Auto distribute Texas Express" for incoming inventory
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status    | warehouse                     | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Confirmed | Auto distribute Texas Express | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | 123Abc         | 123             | auto          | 0123456789     | No       |
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | 0             | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check alert message
      | Estimated covered period must be greater than 0 |
    And Click on tooltip button "Cancel"
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | -1            | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And BAO_ADMIN13 check error message is showing of fields
      | field                        | message                   |
      | Estimated Weeks of Inventory | Please input valid number |
    And Click on tooltip button "Cancel"
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | 10            | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status    | warehouse                     | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber | referenceNumber | transportName | transportPhone | transfer |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Confirmed | Auto distribute Texas Express | No       | Plus1 | 10  | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | 123Abc         | 123             | auto          | 0123456789     | No       |
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | [blank]       | -1        | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And BAO_ADMIN13 check error message is showing of fields
      | field        | message                   |
      | # of Pallets | Please input valid number |
    And Click on tooltip button "Cancel"
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | a              | [blank] |
    And Admin check alert message
      | Contact number length must be 10 |
    And Click on tooltip button "Cancel"
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | 1              | [blank] |
    And Admin check alert message
      | Contact number length must be 10 |
    And Click on tooltip button "Cancel"
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note      | adminNote       | other      | freight      | tracking | referenceNumber      | transportName      | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | [blank]       | 1         | [blank]    | [blank]        | 1          | Yes     | Yes       | 1           | 11112   | auto note | auto admin note | auto other | auto freight | [blank]  | auto referenceNumber | auto transportName | 1234567890     | [blank] |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status    | warehouse                     | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note      | adminNote       | otherShipping | freightCarrier | trackingNumber | referenceNumber      | transportName      | transportPhone | transfer |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Confirmed | Auto distribute Texas Express | No       | Plus1 | 10  | 1        | 0                | 10             | 1                         | 11112   | Yes           | Yes             | 1.00 lbs    | auto note | auto admin note | auto other    | auto freight   | 123Abc         | auto referenceNumber | auto transportName | 1234567890     | No       |
    And Admin upload file to inbound
      | bol     | pod             |
      | [blank] | 10MBgreater.jpg |
    And Admin check alert message
      | Maximum file size exceeded. |
    And Admin upload file to inbound
      | bol     | pod             |
      | [blank] | POD_Invalid.csv |
    And Admin check alert message
      | Validation failed: Proof of delivery attachment content type is invalid |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status    | warehouse                     | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note      | adminNote       | otherShipping | freightCarrier | trackingNumber | referenceNumber      | transportName      | transportPhone | transfer |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Confirmed | Auto distribute Texas Express | No       | Plus1 | 10  | 1        | 0                | 10             | 1                         | 11112   | Yes           | Yes             | 1.00 lbs    | auto note | auto admin note | auto other    | auto freight   | 123Abc         | auto referenceNumber | auto transportName | 1234567890     | No       |
    And Admin upload file to inbound
      | bol     | pod     |
      | BOL.pdf | POD.pdf |
    And Check any button "is" showing on screen
      | Mark as Received |
    And Admin edit general information of incoming inventory
      | region              | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | Chicagoland Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin add sku into incoming inventory then update request
      | index | sku                                          | ofCase |
      | 1     | random sku admin inbound inventory 220 api 1 | 10     |
    And Click on button "Update Request"
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | note    | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 220 api 1 | random sku admin inbound inventory 220 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 10        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |

  @AD_Incoming_Inventory_230
  Scenario: Confirm Incoming Inventory Check SKU INFORMATION section
    Given BAO_ADMIN login web admin by api
      | email             | password  |
      | bao13@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 230 api" by api
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 230 api" by api
    And Admin delete product name "random product admin inbound inventory 230 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product admin inbound inventory 230 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 230 api 1" of product ""
#    And Admin add SKU to Incoming Inventory api
#      | product_variant_id | vendor_company_id | quantity |
#      | random             | 1847              | 10       |

    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product admin inbound inventory 230 api 2 | 3002     |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 230 api 2" of product ""
    And Admin add SKU to Incoming Inventory api
      | skuName                                      | product_variant_id | vendor_company_id | quantity |
      | random sku admin inbound inventory 230 api 1 | random             | 1847              | 10       |
      | random sku admin inbound inventory 230 api 2 | random             | 1847              | 5        |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_master_carton | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                   | 10                          | 1                        | 1     | 1          | 81           |
#Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                          | lot_code | quantity | expiry_date |
      | random sku admin inbound inventory 230 api 1 | [blank]  | 10       | [blank]     |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail   | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 10            | 10                          | 10                   | 10                              | submitted | 10           | 11111    | admin_note | 81           | other Shipping | freight Carrier | tracking_number | 123              | auto                       | 0123456789                  |

    Given BAO_ADMIN13 open web admin
    When BAO_ADMIN13 login to web with role Admin
    And BAO_ADMIN13 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | 12          |
    And Go to detail of incoming inventory number "create by api"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany       | status    | warehouse            | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | [blank]        | Auto vendor company | Confirmed | Bao Distribution CHI | Plus1 | 1   | 10       | 10               | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | note    | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 230 api 1 | random sku admin inbound inventory 230 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 10        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |
      | 1     | Auto Brand promotion      | random product admin inbound inventory 230 api 2 | random sku admin inbound inventory 230 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 5         | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 5             | [blank] | Dry                       |
    And Admin redirect "Auto brand create product" from list SKU of Incoming inventory
    And Admin verify general information in brand detail
      | status | name                      | description | microDescriptions | inboundInventoryMOQ | city    | state   | vendorCompany       | launchedBy | managedBy |
      | Active | Auto brand create product | [blank]     | [blank]           | [blank]             | [blank] | [blank] | Auto vendor company | [blank]    | [blank]   |
    And BAO_ADMIN13 go back
    And Admin redirect "random product admin inbound inventory 230 api 1" from list SKU of Incoming inventory
    And Admin check product detail
      | stateStatus | productName                                      | brand                     | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | random product admin inbound inventory 230 api 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | [blank]    |
    And BAO_ADMIN13 go back
    And Admin redirect "random sku admin inbound inventory 230 api 1" from list SKU of Incoming inventory
    And Admin check general info of SKU
      | skuName                                      | state  | itemCode  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient  | leadTime | description | expireDayThreshold |
      | random sku admin inbound inventory 230 api 1 | Active | not check | Yes     | 1         | 123123123123      | [blank]               | masterImage.jpg | 123123123123 | UPCImage.png | CaseImage.png | 1                | Dry              | 1               | Dry             | 1.0                | 1.0                | Chicago | Illinois         | Ingredients | [blank]  | Description | 100                |
    And BAO_ADMIN13 go back
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | note    | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 230 api 1 | random sku admin inbound inventory 230 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 10        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |
      | 1     | Auto Brand promotion      | random product admin inbound inventory 230 api 2 | random sku admin inbound inventory 230 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 5         | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 5             | [blank] | Dry                       |
    And Admin remove SKU "random sku admin inbound inventory 230 api 1" from incoming inventory
    And Admin edit sku information
      | index | skuName                                      | lotcode                                      | expiredDate | ofCases | receivingDate | suggestedCase | damagedCase | excessCase | shortedCase | caseReceived | note    |
      | 1     | random sku admin inbound inventory 230 api 2 | random sku admin inbound inventory 230 api 2 | [blank]     | 20      | [blank]       | 10            | [blank]     | [blank]    | [blank]     | [blank]      | [blank] |
    And Click on button "Save"
    And Admin check alert message
      | SKUs has been updated successfully !! |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU             | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | note    | storageShelfLifeCondition |
      | 1     | Auto Brand promotion | random product admin inbound inventory 230 api 2 | random sku admin inbound inventory 230 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 20        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |
    And Admin add sku into incoming inventory then update request
      | index | sku                                          | ofCase |
      | 2     | random sku admin inbound inventory 230 api 2 | 10     |
    And Click on button "Save"
    And Admin check alert message
      | SKUs has been updated successfully !! |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU             | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU                                   | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | storageShelfLifeCondition | damagedCase | excessCase | shortedCase | receivedCase | note    |
      | 1     | Auto Brand promotion | random product admin inbound inventory 230 api 2 | random sku admin inbound inventory 230 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]                                      | 10        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | Dry                       | 0           | 0          | 0           | [blank]      | [blank] |
      | 2     | Auto Brand promotion | random product admin inbound inventory 230 api 2 | random sku admin inbound inventory 230 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | random sku admin inbound inventory 230 api 2 | 20        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | Dry                       | 0           | 0          | 0           | [blank]      | [blank] |
    And Admin edit sku information
      | index | skuName                                      | lotcode                                      | expiredDate | ofCases | receivingDate | suggestedCase | damagedCase | excessCase | shortedCase | caseReceived | note      |
      | 1     | random sku admin inbound inventory 230 api 2 | random sku admin inbound inventory 230 api 1 | Plus1       | 30      | Minus1        | 30            | 30          | 30         | 30          | 30           | Auto note |
    And Click on button "Save"
    And Admin check alert message
      | SKUs has been updated successfully !! |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU             | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU                                   | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | storageShelfLifeCondition | damagedCase | excessCase | shortedCase | receivedCase | note      |
      | 1     | Auto Brand promotion | random product admin inbound inventory 230 api 2 | random sku admin inbound inventory 230 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | random sku admin inbound inventory 230 api 1 | 30        | Plus1         | Minus1           | [blank] | 1                | 1.0 - 1.0   | °F                   | 30            | Dry                       | 30          | 30         | 30          | 30           | Auto note |
      | 2     | Auto Brand promotion | random product admin inbound inventory 230 api 2 | random sku admin inbound inventory 230 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | random sku admin inbound inventory 230 api 2 | 20        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | Dry                       | 0           | 0          | 0           | [blank]      | [blank]   |

  @AD_Incoming_Inventory_338
  Scenario: RECEIVED Incoming Inventory detail page
    Given BAO_ADMIN13 login web admin by api
      | email             | password  |
      | bao13@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 338 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inbound inventory 338 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inbound inventory 338 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 338 api" by api
    And Admin delete product name "random product admin inbound inventory 338 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product admin inbound inventory 338 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 338 api 1" of product ""
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |
    #Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                          | lot_code                                     | quantity | expiry_date |
      | random sku admin inbound inventory 338 api 1 | random sku admin inbound inventory 338 api 1 | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail   | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 10            | 10                          | 10                   | 10                              | submitted | 10           | 11111    | admin_note | 99           | other Shipping | freight Carrier | tracking_number | 123              | auto                       | 0123456789                  |
    #Upload file inbound
    And Admin upload file Incoming Inventory id "api" api
      | fileBOL | filePOD |
      | BOL.pdf | POD.png |
    #Mark as received
    And Admin Mark as received Incoming Inventory id "api" api

    Given BAO_ADMIN13 open web admin
    When BAO_ADMIN13 login to web with role Admin
    And BAO_ADMIN13 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | 12          |
    And Go to detail of incoming inventory number "create by api"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany       | status   | warehouse                     | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | [blank]        | Auto vendor company | Received | Auto Ngoc Distribution CHI 01 | Plus1 | 1   | 10       | 10               | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |
    And Admin view changelog incoming inventory
      | state               | updateBy                 | updateOn    |
      | Confirmed→Received  | Admin: bao13@podfoods.co | currentDate |
      | Requested→Confirmed | Admin: bao13@podfoods.co | currentDate |
      | →Requested          | Admin: bao13@podfoods.co | currentDate |

    And Admin edit general information of incoming inventory
      | region           | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | New York Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region           | deliveryMethod | vendorCompany       | status   | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer | bol     | pod     |
      | New York Express | [blank]        | Auto vendor company | Received | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       | BOL.pdf | POD.png |
    And Check any text "is" showing on screen
      | Variant must have at least one |
    And Admin edit general information of incoming inventory
      | region               | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | Mid Atlantic Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region               | deliveryMethod | vendorCompany       | status   | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer | bol     | pod     |
      | Mid Atlantic Express | [blank]        | Auto vendor company | Received | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       | BOL.pdf | POD.png |
    And Admin edit general information of incoming inventory
      | region                   | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | North California Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region                   | deliveryMethod | vendorCompany       | status   | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer | bol     | pod     |
      | North California Express | [blank]        | Auto vendor company | Received | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       | BOL.pdf | POD.png |
    And Admin edit general information of incoming inventory
      | region                   | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | South California Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region                   | deliveryMethod | vendorCompany       | status   | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer | bol     | pod     |
      | South California Express | [blank]        | Auto vendor company | Received | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       | BOL.pdf | POD.png |
    And Admin edit general information of incoming inventory
      | region         | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | Dallas Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod | vendorCompany       | status   | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer | bol     | pod     |
      | Dallas Express | [blank]        | Auto vendor company | Received | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       | BOL.pdf | POD.png |

    And Admin edit delivery method of incoming inventory
      | deliveryMethod      | trackingNumber |
      | Brand Self Delivery | [blank]        |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status   | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Received | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |
    And Admin edit delivery method of incoming inventory
      | deliveryMethod      | trackingNumber |
      | Brand Self Delivery | 123Abc         |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status   | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber | referenceNumber | transportName | transportPhone | transfer | bol     | pod     |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Received | N/A       | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | 123Abc         | 123             | auto          | 0123456789     | No       | BOL.pdf | POD.png |
    And Add the warehouse "Auto distribute Texas Express" for incoming inventory
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status   | warehouse                     | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber | referenceNumber | transportName | transportPhone | transfer | bol     | pod     |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Received | Auto distribute Texas Express | No       | Plus1 | 1   | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | 123Abc         | 123             | auto          | 0123456789     | No       | BOL.pdf | POD.png |
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | 0             | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check alert message
      | Estimated covered period must be greater than 0 |
    And Click on tooltip button "Cancel"
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | -1            | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And BAO_ADMIN13 check error message is showing of fields
      | field                        | message                   |
      | Estimated Weeks of Inventory | Please input valid number |
    And Click on tooltip button "Cancel"
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | 10            | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status   | warehouse                     | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber | referenceNumber | transportName | transportPhone | transfer | bol     | pod     |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Received | Auto distribute Texas Express | No       | Plus1 | 10  | 10       | 0                | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | 123Abc         | 123             | auto          | 0123456789     | No       | BOL.pdf | POD.png |
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | [blank]       | -1        | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And BAO_ADMIN13 check error message is showing of fields
      | field        | message                   |
      | # of Pallets | Please input valid number |
    And Click on tooltip button "Cancel"
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | a              | [blank] |
    And Admin check alert message
      | Contact number length must be 10 |
    And Click on tooltip button "Cancel"
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | 1              | [blank] |
    And Admin check alert message
      | Contact number length must be 10 |
    And Click on tooltip button "Cancel"
    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note      | adminNote       | other      | freight      | tracking | referenceNumber      | transportName      | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | [blank]       | 1         | [blank]    | [blank]        | 1          | Yes     | Yes       | 1           | 11112   | auto note | auto admin note | auto other | auto freight | [blank]  | auto referenceNumber | auto transportName | 1234567890     | [blank] |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status   | warehouse                     | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note      | adminNote       | otherShipping | freightCarrier | trackingNumber | referenceNumber      | transportName      | transportPhone | transfer |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Received | Auto distribute Texas Express | No       | Plus1 | 10  | 1        | 0                | 10             | 1                         | 11112   | Yes           | Yes             | 1.00 lbs    | auto note | auto admin note | auto other    | auto freight   | 123Abc         | auto referenceNumber | auto transportName | 1234567890     | No       |
    And Admin upload file to inbound
      | bol     | pod             |
      | [blank] | 10MBgreater.jpg |
    And Admin check alert message
      | Maximum file size exceeded. |
    And Admin upload file to inbound
      | bol     | pod             |
      | [blank] | POD_Invalid.csv |
    And Admin check alert message
      | Validation failed: Proof of delivery attachment content type is invalid |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status   | warehouse                     | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note      | adminNote       | otherShipping | freightCarrier | trackingNumber | referenceNumber      | transportName      | transportPhone | transfer | bol     | pod             |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Received | Auto distribute Texas Express | No       | Plus1 | 10  | 1        | 0                | 10             | 1                         | 11112   | Yes           | Yes             | 1.00 lbs    | auto note | auto admin note | auto other    | auto freight   | 123Abc         | auto referenceNumber | auto transportName | 1234567890     | No       | BOL.pdf | POD_Invalid.csv |
    And Admin upload file to inbound
      | bol      | pod     |
      | BOL1.pdf | POD.pdf |
    And Check any button "is" showing on screen
      | Process |
    And Admin check General Information of Incoming inventory
      | region         | deliveryMethod      | vendorCompany       | status   | warehouse                     | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note      | adminNote       | otherShipping | freightCarrier | trackingNumber | referenceNumber      | transportName      | transportPhone | transfer | bol      | pod     |
      | Dallas Express | Brand Self Delivery | Auto vendor company | Received | Auto distribute Texas Express | No       | Plus1 | 10  | 1        | 0                | 10             | 1                         | 11112   | Yes           | Yes             | 1.00 lbs    | auto note | auto admin note | auto other    | auto freight   | 123Abc         | auto referenceNumber | auto transportName | 1234567890     | No       | BOL1.pdf | POD.pdf |
    And Admin edit general information of incoming inventory
      | region              | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | Chicagoland Express | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
#    And Admin add sku into incoming inventory then update request
#      | index | sku                                          | ofCase |
#      | 1     | random sku admin inbound inventory 338 api 1 | 10     |
#    And Click on button "Save"
#    And Check SKUs Information of Incoming inventory
#      | index | brandSKU                  | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | note    | storageShelfLifeCondition |
#      | 1     | Auto brand create product | random product admin inbound inventory 338 api 1 | random sku admin inbound inventory 338 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 10        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |
#    And Admin check General Information of Incoming inventory
#      | region              | deliveryMethod      | vendorCompany       | status   | warehouse | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note      | adminNote       | otherShipping | freightCarrier | trackingNumber | referenceNumber      | transportName      | transportPhone | transfer | bol      | pod     |
#      | Chicagoland Express | Brand Self Delivery | Auto vendor company | Received | N/A       | No       | Plus1 | 10  | 1        | 10               | 10             | 1                        | 11112   | Yes           | Yes             | 1.00 lbs    | auto note | auto admin note | auto other    | auto freight   | 123Abc         | auto referenceNumber | auto transportName | 1234567890     | No       | BOL1.pdf | POD.pdf |

    And Admin subscribe incoming inventory
    And Admin unsubscribe incoming inventory
    And Admin download "Inbound packing list" PDF incoming inventory
    And Admin download "Replenishment Request Slip" PDF incoming inventory
    And Admin download Excel incoming inventory

  @AD_Incoming_Inventory_382
  Scenario: RECEIVED Incoming Inventory detail page - SIGNED WPL and INBOUND INVENTORY IMAGES
    Given BAO_ADMIN login web admin by api
      | email             | password  |
      | bao13@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 382 api" by api
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 382 api" by api
    And Admin delete product name "random product admin inbound inventory 382 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product admin inbound inventory 382 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 382 api 1" of product ""
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 10                   | 1                        | 1     | admin_note | 81           |
#Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                          | lot_code | quantity | expiry_date |
      | random sku admin inbound inventory 382 api 1 | [blank]  | 10       | [blank]     |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail   | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 10            | 10                          | 10                   | 10                              | submitted | 10           | 11111    | admin_note | 81           | other Shipping | freight Carrier | tracking_number | 123              | auto                       | 0123456789                  |
#Upload file inbound
    And Admin upload file Incoming Inventory id "api" api
      | fileBOL | filePOD |
      | BOL.pdf | POD.png |
    #Mark as received
    And Admin Mark as received Incoming Inventory id "api" api

    Given BAO_ADMIN13 open web admin
    When BAO_ADMIN13 login to web with role Admin
    And BAO_ADMIN13 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | [blank]     |
    And Go to detail of incoming inventory number "create by api"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod        | vendorCompany       | status   | warehouse            | lpReview | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | Freight Carrier / LTL | Auto vendor company | Received | Bao Distribution CHI | No       | Plus1 | 1   | 10       | 10               | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | 123             | auto          | 0123456789     | No       |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | storageShelfLife | temperature | temperatureCondition | suggestedCase | excessCase | shortedCase | receivedCase | note    | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 382 api 1 | random sku admin inbound inventory 382 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 10        | [blank]       | Plus1            | 1                | 1.0 - 1.0   | °F                   | 10            | 0          | 0           | [blank]      | [blank] | Dry                       |
    And Admin upload signed WPL
      | wpl             |
      | 10MBgreater.jpg |
    And Admin check alert message
      | Maximum file size exceeded. |
    And Admin remove signed WPL number "1"
    And Admin upload signed WPL
      | wpl       |
      | test.docx |
    And Admin save signed WPL number
    And Admin check alert message
      | Validation failed: Signed wpls attachment content type is invalid |
    And Admin remove signed WPL number "1"
    And Admin upload signed WPL
      | wpl         |
      | anhJPEG.jpg |
      | anhPNG.png  |
    And Admin save signed WPL number
    And BAO_ADMIN13 wait button "Save" not visible after 10 seconds
    And Admin verify signed WPL
      | index | fileName    |
      | 1     | anhJPEG.jpg |
      | 2     | anhPNG.png  |
    And Admin update inbound inventory images
      | index | image     | description |
      | 1     | test.docx | [blank]     |
    And Admin save inbound inventory images
    And Admin check alert message
      | Validation failed: Inbound inventory images attachment content type is invalid |
    And Admin remove inbound inventory images
      | index |
      | 1     |
    And Admin update inbound inventory images
      | index | image           | description |
      | 1     | 10MBgreater.jpg | [blank]     |
    And Admin check alert message
      | Maximum file size exceeded. |
    And Admin remove inbound inventory images
      | index |
      | 1     |
    And Admin update inbound inventory images
      | index | image       | description |
      | 1     | anhPNG.png  | Autotest_1  |
      | 2     | anhJPEG.jpg | Autotest_2  |
    And Admin save inbound inventory images

  @AD_Incoming_Inventory_386
  Scenario: RECEIVED Incoming Inventory Check SKU INFORMATION section
    Given BAO_ADMIN login web admin by api
      | email             | password  |
      | bao13@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 386 api" by api
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 386 api" by api
    And Admin delete product name "random product admin inbound inventory 386 api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product admin inbound inventory 386 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 386 api 1" of product ""
#    And Admin add SKU to Incoming Inventory api
#      | product_variant_id | vendor_company_id | quantity |
#      | random             | 1847              | 10       |

    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product admin inbound inventory 386 api 2 | 3002     |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 386 api 2" of product ""
    And Admin add SKU to Incoming Inventory api
      | skuName                                      | product_variant_id | vendor_company_id | quantity |
      | random sku admin inbound inventory 386 api 1 | random             | 1847              | 10       |
      | random sku admin inbound inventory 386 api 2 | random             | 1847              | 5        |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_master_carton | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                   | 10                          | 1                        | 1     | 1          | 81           |
#Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                          | lot_code | quantity | expiry_date |
      | random sku admin inbound inventory 386 api 1 | [blank]  | 10       | [blank]     |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail   | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 10            | 10                          | 10                   | 10                              | submitted | 10           | 11111    | admin_note | 81           | other Shipping | freight Carrier | tracking_number | 123              | auto                       | 0123456789                  |
      | 1                  | Plus1 | 10            | 10                          | 10                   | 10                              | submitted | 10           | 11111    | admin_note | 81           | other Shipping | freight Carrier | tracking_number | 123              | auto                       | 0123456789                  |
#Upload file inbound
    And Admin upload file Incoming Inventory id "api" api
      | fileBOL | filePOD |
      | BOL.pdf | POD.png |
    #Mark as received
    And Admin Mark as received Incoming Inventory id "api" api

    Given BAO_ADMIN13 open web admin
    When BAO_ADMIN13 login to web with role Admin
    And BAO_ADMIN13 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | 12          |
    And Go to detail of incoming inventory number "create by api"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany       | status   | warehouse            | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | [blank]        | Auto vendor company | Received | Bao Distribution CHI | Plus1 | 1   | 10       | 10               | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | note    | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 386 api 1 | random sku admin inbound inventory 386 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 10        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |
      | 1     | Auto Brand promotion      | random product admin inbound inventory 386 api 2 | random sku admin inbound inventory 386 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 5         | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 5             | [blank] | Dry                       |
    And Admin redirect "Auto brand create product" from list SKU of Incoming inventory
    And Admin verify general information in brand detail
      | status | name                      | description | microDescriptions | inboundInventoryMOQ | city    | state   | vendorCompany       | launchedBy | managedBy |
      | Active | Auto brand create product | [blank]     | [blank]           | [blank]             | [blank] | [blank] | Auto vendor company | [blank]    | [blank]   |
    And BAO_ADMIN13 go back
    And Admin redirect "random product admin inbound inventory 386 api 1" from list SKU of Incoming inventory
    And Admin check product detail
      | stateStatus | productName                                      | brand                     | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | random product admin inbound inventory 386 api 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | [blank]    |
    And BAO_ADMIN13 go back
    And Admin redirect "random sku admin inbound inventory 386 api 1" from list SKU of Incoming inventory
    And Admin check general info of SKU
      | skuName                                      | state  | itemCode  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient  | leadTime | description | expireDayThreshold |
      | random sku admin inbound inventory 386 api 1 | Active | not check | Yes     | 1         | 123123123123      | [blank]               | masterImage.jpg | 123123123123 | UPCImage.png | CaseImage.png | 1                | Dry              | 1               | Dry             | 1.0                | 1.0                | Chicago | Illinois         | Ingredients | [blank]  | Description | 100                |
    And BAO_ADMIN13 go back
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | note    | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 386 api 1 | random sku admin inbound inventory 386 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 10        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |
      | 1     | Auto Brand promotion      | random product admin inbound inventory 386 api 2 | random sku admin inbound inventory 386 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 5         | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 5             | [blank] | Dry                       |
    And Admin remove SKU "random sku admin inbound inventory 386 api 1" from incoming inventory
    And Admin edit sku information
      | index | skuName                                      | lotcode                                      | expiredDate | ofCases | receivingDate | suggestedCase | damagedCase | excessCase | shortedCase | caseReceived | note    |
      | 1     | random sku admin inbound inventory 386 api 2 | random sku admin inbound inventory 386 api 2 | [blank]     | 20      | [blank]       | 10            | [blank]     | [blank]    | [blank]     | [blank]      | [blank] |
    And Click on button "Save"
    And Admin check alert message
      | SKUs has been updated successfully !! |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU             | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | note    | storageShelfLifeCondition |
      | 1     | Auto Brand promotion | random product admin inbound inventory 386 api 2 | random sku admin inbound inventory 386 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 20        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | [blank] | Dry                       |
    And Admin add sku into incoming inventory then update request
      | index | sku                                          | ofCase |
      | 2     | random sku admin inbound inventory 386 api 2 | 10     |
    And Click on button "Save"
    And Admin check alert message
      | SKUs has been updated successfully !! |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU             | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU                                   | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | storageShelfLifeCondition | damagedCase | excessCase | shortedCase | receivedCase | note    |
      | 1     | Auto Brand promotion | random product admin inbound inventory 386 api 2 | random sku admin inbound inventory 386 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]                                      | 10        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | Dry                       | 0           | 0          | 0           | [blank]      | [blank] |
      | 2     | Auto Brand promotion | random product admin inbound inventory 386 api 2 | random sku admin inbound inventory 386 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | random sku admin inbound inventory 386 api 2 | 20        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | Dry                       | 0           | 0          | 0           | [blank]      | [blank] |
    And Admin edit sku information
      | index | skuName                                      | lotcode                                      | expiredDate | ofCases | receivingDate | suggestedCase | damagedCase | excessCase | shortedCase | caseReceived | note      |
      | 1     | random sku admin inbound inventory 386 api 2 | random sku admin inbound inventory 386 api 1 | Plus1       | 30      | Minus1        | 30            | 30          | 30         | 30          | 30           | Auto note |
    And Click on button "Save"
    And Admin check alert message
      | SKUs has been updated successfully !! |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU             | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU                                   | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature | temperatureCondition | suggestedCase | storageShelfLifeCondition | damagedCase | excessCase | shortedCase | receivedCase | note      |
      | 1     | Auto Brand promotion | random product admin inbound inventory 386 api 2 | random sku admin inbound inventory 386 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | random sku admin inbound inventory 386 api 1 | 30        | Plus1         | Minus1           | [blank] | 1                | 1.0 - 1.0   | °F                   | 30            | Dry                       | 30          | 30         | 30          | 30           | Auto note |
      | 2     | Auto Brand promotion | random product admin inbound inventory 386 api 2 | random sku admin inbound inventory 386 api 2 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | random sku admin inbound inventory 386 api 2 | 20        | [blank]       | [blank]          | [blank] | 1                | 1.0 - 1.0   | °F                   | 10            | Dry                       | 0           | 0          | 0           | [blank]      | [blank]   |

  @AD_Incoming_Inventory_414
  Scenario: PROCESSED Incoming Inventory detail page
    Given BAO_ADMIN13 login web admin by api
      | email             | password  |
      | bao13@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 414 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inbound inventory 414 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inbound inventory 414 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 414 api" by api
    And Admin delete product name "random product admin inbound inventory 414 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product admin inbound inventory 414 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 414 api 1" of product ""
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |
    #Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                          | lot_code                                     | quantity | expiry_date |
      | random sku admin inbound inventory 414 api 1 | random sku admin inbound inventory 414 api 1 | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail   | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 10            | 10                          | 10                   | 10                              | submitted | 10           | 11111    | admin_note | 99           | other Shipping | freight Carrier | tracking_number | 123              | auto                       | 0123456789                  |
    #Upload file inbound
    And Admin upload file Incoming Inventory id "api" api
      | fileBOL | filePOD |
      | BOL.pdf | POD.png |
    #Mark as received
    And Admin Mark as received Incoming Inventory id "api" api
 #    Processed inbound
    And Admin Process Incoming Inventory id "api" api

    Given BAO_ADMIN13 open web admin
    When BAO_ADMIN13 login to web with role Admin
    And BAO_ADMIN13 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | 12          |
    And Go to detail of incoming inventory number "create by api"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany       | status    | warehouse                     | eta   | etw    | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | [blank]        | Auto vendor company | Processed | Auto Ngoc Distribution CHI 01 | Plus1 | 1 week | 10       | 10               | 10             | 10                        | 11111   | N/A           | N/A             | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |
    And Admin view changelog incoming inventory
      | state               | updateBy                 | updateOn    |
      | Received→Processed  | Admin: bao13@podfoods.co | currentDate |
      | Confirmed→Received  | Admin: bao13@podfoods.co | currentDate |
      | Requested→Confirmed | Admin: bao13@podfoods.co | currentDate |
      | →Requested          | Admin: bao13@podfoods.co | currentDate |
    And Admin view eta history incoming inventory
      | oldEta  | newEta | updateBy                 | updateOn    |
      | [blank] | Plus1  | Admin: bao13@podfoods.co | currentDate |
    And Admin check help text tooltip1
      | field                                        | text                                                                                                                     |
      | # of Pallets                                 | If not shipping a pallet, please indicate 0                                                                              |
      | Total # of Sellable Retail Cases             | A sellable retail case is how your product is set up on Pod Foods                                                        |
      | # of Master Cartons                          | A master carton is a shipping carton which contains multiple sellable retail cases of the same item                      |
      | # of Sellable Retail Cases per Master Carton | If not shipping in master cartons, please indicate 0                                                                     |
      | Notes                                        | Vendors can view this field on vendor dashboard                                                                          |
      | Admin note                                   | Vendors can’t view this field on vendor dashboard                                                                        |
      | Other special shipping details               | e.g. if SKUs are color-coded, separated by layers on the pallet etc                                                      |
      | Freight Carrier                              | If using a freight carrier - please indicate the carrier name and PRO/PO/BOL/Load Number and tracking links if available |
      | Transportation Coordinator Contact           | Please add contact name & number for your freight broker                                                                 |

    And Admin edit general information of incoming inventory
      | region  | deliveryMethod | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note    | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | [blank] | [blank]        | [blank]       | [blank]       | [blank]   | [blank]    | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | [blank] | Auto note | [blank] | [blank] | [blank]  | [blank]         | [blank]       | [blank]        | [blank] |
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany       | status    | warehouse                     | eta   | etw    | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | [blank]        | Auto vendor company | Processed | Auto Ngoc Distribution CHI 01 | Plus1 | 1 week | 10       | 10               | 10             | 10                        | 11111   | N/A           | N/A             | 10.00 lbs   | 1    | Auto note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | storageShelfLife | temperature | temperatureCondition | suggestedCase | excessCase | shortedCase | receivedCase | note    | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 414 api 1 | random sku admin inbound inventory 414 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | [blank]    | 10        | [blank]       | Plus1            | 1                | 1.0 - 1.0   | °F                   | 10            | 0          | 0           | [blank]      | [blank] | Dry                       |
    And Admin edit sku information
      | index | skuName                                      | lotcode                                      | expiredDate | ofCases | receivingDate | suggestedCase | damagedCase | excessCase | shortedCase | caseReceived | note    |
      | 1     | random sku admin inbound inventory 414 api 1 | random sku admin inbound inventory 414 api 2 | currentDate | 20      | [blank]       | [blank]       | [blank]     | [blank]    | [blank]     | [blank]      | [blank] |
    And Click on button "Save"
    And BAO_ADMIN13 check dialog message
      | This inbound inventory was processed. Are you sure you'd like to proceed? |
    And Click on dialog button "No"
    And Click on button "Save"
    And BAO_ADMIN13 check dialog message
      | This inbound inventory was processed. Are you sure you'd like to proceed? |
    And Click on dialog button "Yes"
    And Admin check alert message
      | SKUs has been updated successfully !! |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU                                   | ofCaseSKU | expiryDateSKU | receivingDateSKU | storageShelfLife | temperature | temperatureCondition | suggestedCase | excessCase | shortedCase | receivedCase | note    | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 414 api 1 | random sku admin inbound inventory 414 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | random sku admin inbound inventory 414 api 2 | 20        | [blank]       | Plus1            | 1                | 1.0 - 1.0   | °F                   | 10            | 0          | 0           | [blank]      | [blank] | Dry                       |
    And Admin upload signed WPL
      | wpl             |
      | 10MBgreater.jpg |
    And Admin check alert message
      | Maximum file size exceeded. |
    And Admin remove signed WPL number "1"
    And Admin upload signed WPL
      | wpl       |
      | test.docx |
    And Admin save signed WPL number
    And Admin check alert message
      | Validation failed: Signed wpls attachment content type is invalid |
    And Admin remove signed WPL number "1"
    And Admin upload signed WPL
      | wpl         |
      | anhJPEG.jpg |
      | anhPNG.png  |
    And Admin save signed WPL number
    And BAO_ADMIN13 wait button "Save" not visible after 15 seconds
    And Admin verify signed WPL
      | index | fileName    |
      | 1     | anhJPEG.jpg |
      | 2     | anhPNG.png  |
    And Admin update inbound inventory images
      | index | image           | description |
      | 1     | 10MBgreater.jpg | [blank]     |
    And Admin check alert message
      | Maximum file size exceeded. |
    And Admin remove inbound inventory images
      | index |
      | 1     |
    And Admin update inbound inventory images
      | index | image     | description |
      | 1     | test.docx | [blank]     |
    And Admin save inbound inventory images
    And Admin check alert message
      | Validation failed: Inbound inventory images attachment content type is invalid |
    And Admin remove inbound inventory images
      | index |
      | 1     |
    And Admin update inbound inventory images
      | index | image       | description |
      | 1     | anhPNG.png  | Autotest_1  |
      | 2     | anhJPEG.jpg | Autotest_2  |
    And Admin save inbound inventory images

  @AD_Incoming_Inventory_431
  Scenario: CANCELED Incoming Inventory detail page
    Given BAO_ADMIN13 login web admin by api
      | email             | password  |
      | bao13@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product admin inbound inventory 431 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inbound inventory 431 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inbound inventory 431 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search product name "random product admin inbound inventory 431 api" by api
    And Admin delete product name "random product admin inbound inventory 431 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product admin inbound inventory 431 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 431 api 1" of product ""
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |
    #Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                          | lot_code                                     | quantity | expiry_date |
      | random sku admin inbound inventory 431 api 1 | random sku admin inbound inventory 431 api 1 | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail   | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 10            | 10                          | 10                   | 10                              | submitted | 10           | 11111    | admin_note | 99           | other Shipping | freight Carrier | tracking_number | 123              | auto                       | 0123456789                  |
    #Cancel inbound
    And Admin search Incoming Inventory by api
      | field     | value         |
      | q[number] | create by api |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |

    Given BAO_ADMIN13 open web admin
    When BAO_ADMIN13 login to web with role Admin
    And BAO_ADMIN13 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate | warehouse | lpReview | below75 | freightCarrier | referenceNumber | trackingNumber | itemPerPage |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] | [blank]   | [blank]  | [blank] | [blank]        | [blank]         | [blank]        | 12          |
    And Go to detail of incoming inventory number "create by api"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany       | status   | warehouse                     | eta   | etw    | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | [blank]        | Auto vendor company | Canceled | Auto Ngoc Distribution CHI 01 | Plus1 | 1 week | 10       | 10               | 10             | 10                        | 11111   | N/A           | N/A             | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |
    And Admin view changelog incoming inventory
      | state               | updateBy                 | updateOn    |
      | Confirmed→Canceled  | Admin: bao13@podfoods.co | currentDate |
      | Requested→Confirmed | Admin: bao13@podfoods.co | currentDate |
      | →Requested          | Admin: bao13@podfoods.co | currentDate |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU                  | productSKU                                       | nameSKU                                      | unitUPC      | caseUPC      | casePerPallet      | casePerCarton              | lotCodeSKU                                   | ofCaseSKU | expiryDateSKU | receivingDateSKU | storageShelfLife | temperature | temperatureCondition | suggestedCase | excessCase | shortedCase | receivedCase | note    | storageShelfLifeCondition |
      | 1     | Auto brand create product | random product admin inbound inventory 431 api 1 | random sku admin inbound inventory 431 api 1 | 123123123123 | 123123123123 | 1 cases per pallet | Cases per Master Carton: 1 | random sku admin inbound inventory 431 api 1 | 10        | [blank]       | Plus1            | 1                | 1.0 - 1.0   | °F                   | 10            | 0          | 0           | [blank]      | [blank] | Dry                       |
    And Check field "Lot code" is disabled
    And Check field "Expiration Date" is disabled
    And Check field "Storage shelf life" is disabled
    And Check field "# of Cases" is disabled
    And Check field "Receiving Date" is disabled
    And Check field "Temperature Requirement" is disabled
    And Check field "# of originally suggested cases" is disabled
    And Check field "# of Damaged Cases" is disabled
    And Check field "# of Excess Cases" is disabled
    And Check field "# of Shorted Cases" is disabled
    And Check field "# of Cases Received" is disabled
    And Check text area "Note" is disabled
    And Admin upload signed WPL
      | wpl             |
      | 10MBgreater.jpg |
    And Admin check alert message
      | Maximum file size exceeded. |
    And Admin remove signed WPL number "1"
    And Admin upload signed WPL
      | wpl       |
      | test.docx |
    And Admin save signed WPL number
    And Admin check alert message
      | Can't touch a canceled inbound inventory |
    And Admin remove signed WPL number "1"
    And Admin upload signed WPL
      | wpl         |
      | anhJPEG.jpg |
      | anhPNG.png  |
    And Admin save signed WPL number
    And Admin check alert message
      | Can't touch a canceled inbound inventory |
    And Admin update inbound inventory images
      | index | image           | description |
      | 1     | 10MBgreater.jpg | [blank]     |
    And Admin check alert message
      | Maximum file size exceeded. |
    And Admin remove inbound inventory images
      | index |
      | 1     |
    And Admin update inbound inventory images
      | index | image     | description |
      | 1     | test.docx | [blank]     |
    And Admin save inbound inventory images
    And Admin check alert message
      | Can't touch a canceled inbound inventory |
    And Admin remove inbound inventory images
      | index |
      | 1     |
    And Admin reactivate incoming inventory
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany       | status    | warehouse                     | eta   | etw | ofPallet | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | zipCode | palletTransit | palletWarehouse | totalWeight | note | adminNote  | otherShipping  | freightCarrier  | trackingNumber  | referenceNumber | transportName | transportPhone | transfer |
      | Chicagoland Express | [blank]        | Auto vendor company | Confirmed | Auto Ngoc Distribution CHI 01 | Plus1 | 1   | 10       | 10               | 10             | 10                        | 11111   | Empty         | Empty           | 10.00 lbs   | 1    | admin_note | other Shipping | freight Carrier | tracking_number | 123             | auto          | 0123456789     | No       |
    And Admin view changelog incoming inventory
      | state               | updateBy                 | updateOn    |
      | Canceled→Confirmed  | Admin: bao13@podfoods.co | currentDate |
      | Confirmed→Canceled  | Admin: bao13@podfoods.co | currentDate |
      | Requested→Confirmed | Admin: bao13@podfoods.co | currentDate |
      | →Requested          | Admin: bao13@podfoods.co | currentDate |
    And Check field "Lot code" is enabled
    And Check field "Expiration Date" is enabled
    And Check field "Storage shelf life" is disabled
    And Check field "# of Cases" is enabled
    And Check field "Receiving Date" is enabled
    And Check field "Temperature Requirement" is disabled
    And Check field "# of originally suggested cases" is enabled
    And Check field "# of Damaged Cases" is enabled
    And Check field "# of Excess Cases" is enabled
    And Check field "# of Shorted Cases" is enabled
    And Check field "# of Cases Received" is enabled
    And Check text area "Note" is enabled

  @AD_Incoming_Inventory_445
  Scenario:  Withdraw Inventory - Search and Filter
    Given BAO_ADMIN14 login web admin by api
      | email             | password  |
      | bao14@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                                | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin inbound inventory 445 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin inbound inventory 445 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin inbound inventory 445 api" by api
    And Admin delete product name "random product admin inbound inventory 445 api" by api
    # Create SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                                             | brand_id |
      | random product admin inbound inventory 445 api 1 | 2944     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin inbound inventory 445 api 1" of product ""
    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 90           | Plus1        | [blank]     | [blank] |
   #Create Withdrawal
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                           | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku admin inbound inventory 445 api 1 | 10       | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | index | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 1     | 26        | 1845              | currentDate | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |

    Given BAO_ADMIN14 open web admin
    When BAO_ADMIN14 login to web with role Admin
    Then BAO_ADMIN14 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin search withdraw request
      | number        | vendorCompany | brand   | region  | status  | startDate | endDate |
      | create by api | [blank]       | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin check record on list withdrawal request
      | number        | vendorCompany                          | brand                               | region              | status    | pickupDate  |
      | create by api | Auto Vendor Company Withdraw inventory | Auto brand check withdraw inventory | Chicagoland Express | Submitted | currentDate |
    And Admin reset filter
    And Admin search withdraw request
      | number  | vendorCompany | brand   | region                   | status  | startDate | endDate |
      | [blank] | [blank]       | [blank] | Chicagoland Express      | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | Florida Express          | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | Mid Atlantic Express     | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | New York Express         | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | North California Express | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | South California Express | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | Dallas Express           | [blank] | [blank]   | [blank] |
    And Admin reset filter
    And Admin search withdraw request
      | number  | vendorCompany | brand   | region  | status    | startDate | endDate |
      | [blank] | [blank]       | [blank] | [blank] | Submitted | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | [blank] | Approved  | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | [blank] | Completed | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | [blank] | Canceled  | [blank]   | [blank] |
    And Admin reset filter
    And Admin search withdraw request
      | number  | vendorCompany | brand                               | region  | status   | startDate | endDate |
      | [blank] | [blank]       | Auto brand check withdraw inventory | [blank] | Canceled | [blank]   | [blank] |
    And Admin reset filter
    And Admin search withdraw request
      | number  | vendorCompany | brand   | region  | status   | startDate      | endDate |
      | [blank] | [blank]       | [blank] | [blank] | Canceled | Minus1         | [blank] |
      | [blank] | [blank]       | [blank] | [blank] | Canceled | currentDate    | [blank] |
      | [blank] | [blank]       | [blank] | [blank] | Canceled | Plus1          | [blank] |
      | [blank] | [blank]       | [blank] | [blank] | Canceled | currentMonth+1 | [blank] |
      | [blank] | [blank]       | [blank] | [blank] | Canceled | currentMonth-1 | [blank] |
    And Admin reset filter
    And Admin search withdraw request
      | number  | vendorCompany | brand   | region  | status   | startDate | endDate        |
      | [blank] | [blank]       | [blank] | [blank] | Canceled | [blank]   | Minus1         |
      | [blank] | [blank]       | [blank] | [blank] | Canceled | [blank]   | currentDate    |
      | [blank] | [blank]       | [blank] | [blank] | Canceled | [blank]   | Plus1          |
      | [blank] | [blank]       | [blank] | [blank] | Canceled | [blank]   | currentMonth+1 |
      | [blank] | [blank]       | [blank] | [blank] | Canceled | [blank]   | currentMonth-1 |
    And Admin reset filter
    And Admin search withdraw request
      | number        | vendorCompany                          | brand                               | region              | status    | startDate   | endDate     |
      | create by api | Auto Vendor Company Withdraw inventory | Auto brand check withdraw inventory | Chicagoland Express | Submitted | currentDate | currentDate |
    And Admin check record on list withdrawal request
      | number        | vendorCompany                          | brand                               | region              | status    | pickupDate  |
      | create by api | Auto Vendor Company Withdraw inventory | Auto brand check withdraw inventory | Chicagoland Express | Submitted | currentDate |
    And Admin cancel withdraw request success
      | number        | note      |
      | create by api | Auto note |
    And Admin search withdraw request
      | number  | vendorCompany | brand   | region  | status   | startDate | endDate |
      | [blank] | [blank]       | [blank] | [blank] | Canceled | [blank]   | [blank] |
    And Admin check record on list withdrawal request
      | number        | vendorCompany                          | brand                               | region              | status   | pickupDate  |
      | create by api | Auto Vendor Company Withdraw inventory | Auto brand check withdraw inventory | Chicagoland Express | Canceled | currentDate |

  @AD_Incoming_Inventory_462
  Scenario: Admin create new withdrawal request - Check display of the page
    Given BAO_ADMIN14 open web admin
    When BAO_ADMIN14 login to web with role Admin
    And BAO_ADMIN14 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin go to create withdrawal request
    And Admin create withdrawal request "Self pickup" with blank value
    And Admin create withdrawal request "Carrier pickup" with blank value

  @AD_Incoming_Inventory_463
  Scenario: Admin create new Withdrawal request with invalid value
    Given BAO_ADMIN14 login web admin by api
      | email             | password  |
      | bao14@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin withdrawal 463 api 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin withdrawal 463 api 1" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin withdrawal 463 api 1" by api
    And Admin delete product name "random product admin withdrawal 463 api 1" by api
   # Create SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                                      | brand_id |
      | random product admin withdrawal 463 api 1 | 2944     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin withdrawal 463 api 1" of product ""
    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code                              | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random sku admin withdrawal 463 api 1 | 90           | Plus1        | [blank]     | [blank] |
   #Create Withdrawal
#    And Admin add Lot code to withdraw request api
#      | inventory_id | product_variant_id | inventory_lot_code                    | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
#      | random       | random             | random sku admin withdrawal 463 api 1 | 10       | 0             | 1             | Plus1                 |
#    And Admin create withdraw request api2
#      | index | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
#      | 1     | 26        | 1845              | currentDate | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |


    Given BAO_ADMIN14 open web admin
    When login to beta web with email "bao14@podfoods.co" pass "12345678a" role "Admin"
    And BAO_ADMIN14 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin input invalid vendor company
      | vendorCompany         | result  |
      | ngoc vc invalid       | No data |
      | NGOCTX_04 vc inactive | No data |
    And Admin create withdrawal request
      | vendorCompany                          | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail  | palletWeight | bol        | comment |
      | Auto Vendor Company Withdraw inventory | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Auto Withdrawal | contact Email | -1           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName                               | productName | lotCode                               | case |
      | 1     | [blank]     | random sku admin withdrawal 463 api 1 | [blank]     | random sku admin withdrawal 463 api 1 | 5    |
    And Admin verify # of case of lotcode
      | case | result                  |
      | -1   | Please enter valid case |
      | 0.1  | Please enter valid case |
      | 0    | Please enter valid case |
      | 1    | [blank]                 |
    And Admin verify upload BOL
      | bol               | result                      |
      | samplepdf10mb.pdf | Maximum file size exceeded. |
    And BAO_ADMIN7 check error message is showing of fields
      | field         | message                            |
      | Contact email | Please input a valid contact email |
      | Pallet weight | Please input valid number          |
    And Admin create withdrawal request
      | vendorCompany | pickerDate | pickerFrom | pickerTo | region  | pickupType | pickupPartner | contactEmail | palletWeight | bol     | comment |
      | [blank]       | [blank]    | [blank]    | 00:30    | [blank] | [blank]    | [blank]       | [blank]      | [blank]      | [blank] | [blank] |
    And Admin create withdrawal request
      | vendorCompany | pickerDate | pickerFrom | pickerTo | region  | pickupType | pickupPartner | contactEmail     | palletWeight | bol     | comment |
      | [blank]       | [blank]    | 01:00      | [blank]  | [blank] | [blank]    | [blank]       | auto@podfoods.co | 1            | [blank] | [blank] |
    And Click on button "Create"
    And Admin check alert message
      | Start time must less than end time |

  @AD_Incoming_Inventory_483 @AD_Incoming_Inventory_537
  Scenario: Admin create new Withdrawal request - Verify the Find lots by brand, product, SKU, or lot code.
    Given BAO_ADMIN14 login web admin by api
      | email             | password  |
      | bao14@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                         | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin withdrawal 483 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin withdrawal 483 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin withdrawal 483 api" by api
    And Admin delete product name "random product admin withdrawal 483 api" by api

  # Create SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                                      | brand_id |
      | random product admin withdrawal 483 api 2 | 2944     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin withdrawal 483 api 4" of product ""
 # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code                              | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 5        | random sku admin withdrawal 483 api 4 | 90           | Plus1        | [blank]     | [blank] |
#    Create pull qty
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 5        | Autotest |
# Create product 1 SKU 2
    And Create product by api with file "CreateProduct.json" and info
      | name                                      | brand_id |
      | random product admin withdrawal 483 api 1 | 2944     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
  #    SKU does not in inventory
    And Admin create a "active" SKU from admin with name "random sku admin withdrawal 483 api 2" of product ""
    And Clear Info of Region api
# Create product 1 SKU 3
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin withdrawal 483 api 3" of product ""
    And Clear Info of Region api
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code                              | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 5        | random sku admin withdrawal 483 api 3 | 95           | Plus1        | [blank]     | [blank] |
    # Create product 1 SKU 1
    And Clear Info of Region api
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin withdrawal 483 api 1" of product ""
    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code                              | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random sku admin withdrawal 483 api 1 | 90           | Plus1        | [blank]     | [blank] |

#
    Given BAO_ADMIN14 open web admin
    When login to beta web with email "bao14@podfoods.co" pass "12345678a" role "Admin"
    And BAO_ADMIN14 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany                          | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | Auto Vendor Company Withdraw inventory | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Auto Withdrawal | [blank]      | 1            | anhPNG.png | comment |
    And Click on button "Add lot code"
    And Admin search add lot codes to withdrawal request
      | vendorBrand                         | skuName | productName | lotCode |
      | Auto brand check withdraw inventory | [blank] | [blank]     | [blank] |
    And Click on dialog button "Reset"
    And Admin search add lot codes to withdrawal request
      | vendorBrand | skuName                             | productName | lotCode |
      | [blank]     | random sku admin withdrawal 483 api | [blank]     | [blank] |
    And Admin verify result after search add lot codes withdrawal request
      | productName                               | skuName                               | lotCode                               | endQty | pullQty |
      | random product admin withdrawal 483 api 2 | random sku admin withdrawal 483 api 4 | random sku admin withdrawal 483 api 4 | 0      | 5       |
      | random product admin withdrawal 483 api 1 | random sku admin withdrawal 483 api 1 | random sku admin withdrawal 483 api 1 | 10     | 0       |
    And Click on dialog button "Reset"
    And Admin search add lot codes to withdrawal request
      | vendorBrand | skuName | productName                               | lotCode |
      | [blank]     | [blank] | random product admin withdrawal 483 api 2 | [blank] |
    And Admin verify result after search add lot codes withdrawal request
      | productName                               | skuName                               | lotCode                               | endQty | pullQty |
      | random product admin withdrawal 483 api 2 | random sku admin withdrawal 483 api 4 | random sku admin withdrawal 483 api 4 | 0      | 5       |
    And Click on dialog button "Reset"
    And Admin search add lot codes to withdrawal request
      | vendorBrand | skuName | productName | lotCode                               |
      | [blank]     | [blank] | [blank]     | random sku admin withdrawal 483 api 1 |
    And Admin verify result after search add lot codes withdrawal request
      | productName                               | skuName                               | lotCode                               | endQty | pullQty |
      | random product admin withdrawal 483 api 1 | random sku admin withdrawal 483 api 1 | random sku admin withdrawal 483 api 1 | 10     | 0       |
    And Click on dialog button "Reset"
    And Admin search add lot codes to withdrawal request
      | vendorBrand | skuName | productName | lotCode                               |
      | [blank]     | [blank] | [blank]     | random sku admin withdrawal 483 api 3 |
    And Admin verify result after search add lot codes withdrawal request
      | productName | skuName | lotCode | endQty  | pullQty |
      | [blank]     | [blank] | [blank] | [blank] | [blank] |
    And Click on dialog button "Reset"
    And Admin search add lot codes to withdrawal request
      | vendorBrand | skuName                               | productName | lotCode |
      | [blank]     | random sku admin withdrawal 483 api 3 | [blank]     | [blank] |
    And Admin verify result after search add lot codes withdrawal request
      | productName | skuName | lotCode | endQty  | pullQty |
      | [blank]     | [blank] | [blank] | [blank] | [blank] |
    And Click on dialog button "Reset"
    And Admin search add lot codes to withdrawal request
      | vendorBrand | skuName | productName                               | lotCode |
      | [blank]     | [blank] | random product admin withdrawal 483 api 3 | [blank] |
    And Admin verify result after search add lot codes withdrawal request
      | productName | skuName | lotCode | endQty  | pullQty |
      | [blank]     | [blank] | [blank] | [blank] | [blank] |
    And Click on dialog button "Reset"
    And Admin search add lot codes to withdrawal request
      | vendorBrand | skuName                             | productName                             | lotCode                             |
      | [blank]     | random sku admin withdrawal 483 api | random product admin withdrawal 483 api | random sku admin withdrawal 483 api |
    And Admin verify result after search add lot codes withdrawal request
      | productName                               | skuName                               | lotCode                               | endQty | pullQty |
      | random product admin withdrawal 483 api 2 | random sku admin withdrawal 483 api 4 | random sku admin withdrawal 483 api 4 | 0      | 5       |
      | random product admin withdrawal 483 api 1 | random sku admin withdrawal 483 api 1 | random sku admin withdrawal 483 api 1 | 10     | 0       |
    And Admin choose lot codes add to withdrawal request
      | index | lotCode                               |
      | 1     | random sku admin withdrawal 483 api 1 |
      | 1     | random sku admin withdrawal 483 api 4 |
    And Admin create withdrawal request
      | vendorCompany | pickerDate | pickerFrom | pickerTo | region          | pickupType | pickupPartner | contactEmail | palletWeight | bol     | comment |
      | [blank]       | [blank]    | [blank]    | [blank]  | Florida Express | [blank]    | [blank]       | [blank]      | [blank]      | [blank] | [blank] |

    And BAO_ADMIN14 check error message is showing of fields
      | field     | message                          |
      | Lot codes | Lot codes must have at least one |
    And Click on button "Add lot code"
    And Admin search add lot codes to withdrawal request
      | vendorBrand                         | skuName | productName | lotCode |
      | Auto brand check withdraw inventory | [blank] | [blank]     | [blank] |
    And Admin verify result after search add lot codes withdrawal request
      | productName                               | skuName                               | lotCode                               | endQty | pullQty |
      | random product admin withdrawal 483 api 1 | random sku admin withdrawal 483 api 3 | random sku admin withdrawal 483 api 3 | 5      | 0       |
    And Click on dialog button "Reset"
    And Admin search add lot codes to withdrawal request
      | vendorBrand | skuName                               | productName | lotCode |
      | [blank]     | random sku admin withdrawal 483 api 1 | [blank]     | [blank] |
    And Admin verify result after search add lot codes withdrawal request
      | productName | skuName | lotCode | endQty  | pullQty |
      | [blank]     | [blank] | [blank] | [blank] | [blank] |
    And Click on dialog button "Reset"
    And Admin search add lot codes to withdrawal request
      | vendorBrand | skuName | productName | lotCode                               |
      | [blank]     | [blank] | [blank]     | random sku admin withdrawal 483 api 1 |
    And Admin verify result after search add lot codes withdrawal request
      | productName | skuName | lotCode | endQty  | pullQty |
      | [blank]     | [blank] | [blank] | [blank] | [blank] |
    And Click on dialog button "Reset"
    And Admin close dialog form
    And Admin create withdrawal request
      | vendorCompany | pickerDate | pickerFrom | pickerTo | region              | pickupType | pickupPartner | contactEmail | palletWeight | bol     | comment |
      | [blank]       | [blank]    | [blank]    | [blank]  | Chicagoland Express | [blank]    | [blank]       | [blank]      | [blank]      | [blank] | [blank] |
    And Click on button "Add lot code"
    And Admin search add lot codes to withdrawal request
      | vendorBrand | skuName                             | productName | lotCode |
      | [blank]     | random sku admin withdrawal 483 api | [blank]     | [blank] |
    And Admin choose lot codes add to withdrawal request
      | index | lotCode                               |
      | 1     | random sku admin withdrawal 483 api 1 |
      | 1     | random sku admin withdrawal 483 api 4 |
    And Admin check lot code in withdrawal request
      | index | product                                   | sku                                   | lotCode                               | endQty | pullQty | case |
      | 1     | random product admin withdrawal 483 api 2 | random sku admin withdrawal 483 api 4 | random sku admin withdrawal 483 api 4 | 0      | 5       | 1    |
      | 1     | random product admin withdrawal 483 api 1 | random sku admin withdrawal 483 api 1 | random sku admin withdrawal 483 api 1 | 10     | 0       | 1    |
    And Click on button "Create"
    And Admin check alert message
      | Withdraw items withdraw case must be at least 5 cases |
  #  Change quatity of inventory
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 2                       | 1        | Autotest |
    And Admin edit case of lot code
      | index | skuName                               | lotCode                               | case |
      | 1     | random sku admin withdrawal 483 api 1 | random sku admin withdrawal 483 api 1 | 10   |
      | 1     | random sku admin withdrawal 483 api 4 | random sku admin withdrawal 483 api 4 | 5    |
    And Click on button "Create"
    And Admin check alert message
      | Withdraw items withdraw case must be in range 0..9 |
    And Admin check lot code in withdrawal request
      | index | product                                   | sku                                   | lotCode                               | endQty | pullQty | case |
      | 1     | random product admin withdrawal 483 api 2 | random sku admin withdrawal 483 api 4 | random sku admin withdrawal 483 api 4 | 0      | 5       | 5    |
      | 1     | random product admin withdrawal 483 api 1 | random sku admin withdrawal 483 api 1 | random sku admin withdrawal 483 api 1 | 10     | 0       | 10   |

  @AD_Incoming_Inventory_549 @AD_Incoming_Inventory_555
  Scenario: Check information displayed for a Submitted withdrawal request created by admin
    Given BAO_ADMIN14 login web admin by api
      | email             | password  |
      | bao14@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin withdrawal 549 api 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin withdrawal 549 api 1" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin withdrawal 549 api 1" by api
    And Admin delete product name "random product admin withdrawal 549 api 1" by api
   # Create SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                                      | brand_id |
      | random product admin withdrawal 549 api 1 | 2944     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin withdrawal 549 api 1" of product ""
    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code                              | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random sku admin withdrawal 549 api 1 | 90           | Plus1        | [blank]     | [blank] |
   #Create Withdrawal
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                    | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku admin withdrawal 549 api 1 | 10       | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | index | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 1     | 26        | 1845              | currentDate | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |


    Given BAO_ADMIN14 open web admin
    When login to beta web with email "bao14@podfoods.co" pass "12345678a" role "Admin"
    And BAO_ADMIN14 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin search withdraw request
      | number        | vendorCompany | brand   | region  | status  | startDate | endDate |
      | create by api | [blank]       | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin go to detail withdraw request number "create by api"
    And Admin check general information "submitted" withdrawal request
      | vendorCompany                          | pickupDate  | startTime | endTime  | region              | pickupType     | partner             | palletWeight | status    | comment | bol     | createBy                 | createOn    |
      | Auto Vendor Company Withdraw inventory | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Carrier pickup | pickup_partner_name | 1 lbs        | Submitted | comment | BOL.pdf | Admin: bao14@podfoods.co | currentDate |
    And Admin view changelog incoming inventory
      | state      | updateBy                 | updateOn    |
      | →Submitted | Admin: bao14@podfoods.co | currentDate |
    And Admin check lot code in withdrawal request
      | index | product                                   | sku                                   | lotCode                               | endQty | case | pullQty |
      | 1     | random product admin withdrawal 549 api 1 | random sku admin withdrawal 549 api 1 | random sku admin withdrawal 549 api 1 | 10     | 1    | 0       |

    #Create Withdrawal 2
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                    | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku admin withdrawal 549 api 1 | 10       | 0             | 2             | Plus1                 |
    And Admin create withdraw request api2
      | index | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type | pickup_partner_name  | pallet_weight | comment  | attachment | contact_email     |
      | 2     | 26        | 1845              | currentDate | 00:30      | 01:00    | self_pickup | pickup_partner_name2 | 2             | comment2 | BOL.pdf    | podfoods@email.co |

    And Admin go back with button
    And Admin search withdraw request
      | number        | vendorCompany | brand   | region  | status  | startDate | endDate |
      | create by api | [blank]       | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin go to detail withdraw request number "create by api"
    And Admin check general information "submitted" withdrawal request
      | vendorCompany                          | pickupDate  | startTime | endTime  | region              | pickupType  | partner              | palletWeight | status    | comment  | bol     | createBy                 | createOn    |
      | Auto Vendor Company Withdraw inventory | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | pickup_partner_name2 | 2 lbs        | Submitted | comment2 | BOL.pdf | Admin: bao14@podfoods.co | currentDate |
    And Admin check lot code in withdrawal request
      | index | product                                   | sku                                   | lotCode                               | endQty | case | pullQty |
      | 2     | random product admin withdrawal 549 api 1 | random sku admin withdrawal 549 api 1 | random sku admin withdrawal 549 api 1 | 10     | 2    | 0       |
    And Admin change info of general information in withdrawal request
      | vendorCompany | pickupDate | startTime | endTime | region  | pickupType | partner | palletWeight | comment | bol     |
      | ngoc vc 1     | [blank]    | [blank]   | [blank] | [blank] | [blank]    | [blank] | [blank]      | [blank] | [blank] |
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner              | palletWeight | status    | comment  | bol     | createBy                 | createOn    |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | pickup_partner_name2 | 2 lbs        | Submitted | comment2 | BOL.pdf | Admin: bao14@podfoods.co | currentDate |
    And Check any text "is" showing on screen
      | Withdrawal request must have at least one lot code |
    And Admin change info of "pallet weight" field of withdrawal and see message
      | value | value1  | message                                          |
      | -1    | [blank] | Pallet weight must be greater than or equal to 0 |
    And Admin change info of "pickup date" field of withdrawal and see message
      | value   | value1  | message                    |
      | [blank] | [blank] | Pickup date can't be blank |
    And Admin change info of "bol" field of withdrawal and see message
      | value             | value1  | message                     |
      | samplepdf10mb.pdf | [blank] | Maximum file size exceeded. |
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner              | palletWeight | status    | comment  | bol     | createBy                 | createOn    |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | pickup_partner_name2 | 2 lbs        | Submitted | comment2 | BOL.pdf | Admin: bao14@podfoods.co | currentDate |
    And Admin change info of general information in withdrawal request
      | vendorCompany | pickupDate | startTime | endTime | region              | pickupType     | partner      | palletWeight | comment | bol        |
      | [blank]       | Minus1     | 01:30     | 02:00   | Chicagoland Express | Carrier pickup | Auto partner | 1 lbs        | comment | anhPNG.png |
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate | startTime | endTime  | region              | pickupType     | partner      | palletWeight | status    | comment | bol        | contactEmail      |
      | ngoc vc 1     | Minus1     | 01:30 am  | 02:00 am | Chicagoland Express | Carrier pickup | Auto partner | 1 lbs        | Submitted | comment | anhPNG.png | podfoods@email.co |
    And Admin view changelog incoming inventory
      | state      | updateBy                 | updateOn    |
      | →Submitted | Admin: bao14@podfoods.co | currentDate |

  @AD_Incoming_Inventory_551 @AD_Incoming_Inventory_574 @AD_Incoming_Inventory_584
  Scenario: Check information displayed for a Submitted withdrawal request created by vendor + Approved withdrawal request
    Given BAO_ADMIN14 login web admin by api
      | email             | password  |
      | bao14@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin withdrawal 551 api 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin withdrawal 551 api 1" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin withdrawal 551 api 1" by api
    And Admin delete product name "random product admin withdrawal 551 api 1" by api
   # Create SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                                      | brand_id |
      | random product admin withdrawal 551 api 1 | 2944     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin withdrawal 551 api 1" of product ""
    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code                              | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random sku admin withdrawal 551 api 1 | 90           | Plus1        | [blank]     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor28@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region              | carrier     | nameContact     | palletWeight | comment | bol          |
      | Plus7      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | data/BOL.pdf |
    And Vendor add new sku with lot code to withdrawal request
      | index | sku                                   | lotCode                               | lotQuantity | max     |
      | 1     | random sku admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | 5           | [blank] |
    And Vendor click create withdrawal request

    Given BAO_ADMIN14 open web admin
    When login to beta web with email "bao14@podfoods.co" pass "12345678a" role "Admin"
    And BAO_ADMIN14 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin search withdraw request
      | number           | vendorCompany | brand   | region  | status  | startDate | endDate |
      | create by vendor | [blank]       | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin go to detail withdraw request number "create by vendor"
    And Admin check general information "submitted" withdrawal request
      | vendorCompany                          | pickupDate | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol     | createBy               | createOn    | contactEmail |
      | Auto Vendor Company Withdraw inventory | Plus7      | 09:30 am  | 10:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 5 lbs        | Submitted | comment | BOL.pdf | Vendor: Bao North cali | currentDate | [blank]      |
    And Admin view changelog incoming inventory
      | state      | updateBy               | updateOn    |
      | →Submitted | Vendor: Bao North cali | currentDate |
    And Admin check lot code in withdrawal request
      | index | product                                   | sku                                   | lotCode                               | endQty | case | pullQty |
      | 1     | random product admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | 10     | 5    | 0       |
    And Admin edit case of lot code
      | index | skuName                               | lotCode                               | case |
      | 1     | random sku admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | 11   |
    And Click on button "Save"
    And Admin check alert message
      | Withdraw items withdraw case must be in range 0..10 |
    And Admin edit case of lot code
      | index | skuName                               | lotCode                               | case |
      | 1     | random sku admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | 10   |
    And Click on button "Save"
    And Admin check alert message
      | Lot code has been updated successfully !! |
    And Click on button "Approve"
    And Click on dialog button "Cancel"
    And Admin check general information "submitted" withdrawal request
      | vendorCompany                          | pickupDate | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol     | createBy               | createOn    | contactEmail |
      | Auto Vendor Company Withdraw inventory | Plus7      | 09:30 am  | 10:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 5 lbs        | Submitted | comment | BOL.pdf | Vendor: Bao North cali | currentDate | [blank]      |
    And Click on button "Approve"
    And Click on dialog button "OK"
    And Admin check alert message
      | Withdraw request has been approved successfully! |
    And Admin check general information "approved" withdrawal request
      | vendorCompany                          | pickupDate | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status   | comment | bol     | createBy               | createOn    | contactEmail |
      | Auto Vendor Company Withdraw inventory | Plus7      | 09:30 am  | 10:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 5 lbs        | Approved | comment | BOL.pdf | Vendor: Bao North cali | currentDate | [blank]      |
    And Admin view changelog incoming inventory
      | state              | updateBy                 | updateOn    |
      | Submitted→Approved | Admin: bao14@podfoods.co | currentDate |
      | →Submitted         | Vendor: Bao North cali   | currentDate |
    And Admin check lot code in withdrawal request
      | index | product                                   | sku                                   | lotCode                               | endQty | case | pullQty |
      | 1     | random product admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | 0      | 10   | 0       |
    And Admin edit case of lot code
      | index | skuName                               | lotCode                               | case |
      | 1     | random sku admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | 1    |
    And Click on button "Save"
    And Admin check alert message
      | Lot code has been updated successfully !! |
    And Admin check lot code in withdrawal request
      | index | product                                   | sku                                   | lotCode                               | endQty | case | pullQty |
      | 1     | random product admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | 9      | 1    | 0       |
    And Admin edit case of lot code
      | index | skuName                               | lotCode                               | case |
      | 1     | random sku admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | 10   |
    And Click on button "Save"
    And Admin check alert message
      | Lot code has been updated successfully !! |
    And Admin check lot code in withdrawal request
      | index | product                                   | sku                                   | lotCode                               | endQty | case | pullQty |
      | 1     | random product admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | 0      | 10   | 0       |
    And Click on button "Complete"
    And Admin check dialog message
      | Are you sure that you want to complete this withdraw request? |
    And Click on dialog button "Cancel"
    And Admin check general information "approved" withdrawal request
      | vendorCompany                          | pickupDate | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status   | comment | bol     | createBy               | createOn    | contactEmail |
      | Auto Vendor Company Withdraw inventory | Plus7      | 09:30 am  | 10:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 5 lbs        | Approved | comment | BOL.pdf | Vendor: Bao North cali | currentDate | [blank]      |
    And Click on button "Complete"
    And Click on dialog button "OK"
    And Admin check alert message
      | Withdraw request has been completed successfully! |
    And Admin check general information "complete" withdrawal request
      | vendorCompany                          | pickupDate | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol     | createBy               | createOn    | contactEmail |
      | Auto Vendor Company Withdraw inventory | Plus7      | 09:30 am  | 10:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 5 lbs        | Completed | comment | BOL.pdf | Vendor: Bao North cali | currentDate | [blank]      |
    And Admin view changelog incoming inventory
      | state              | updateBy                 | updateOn    |
      | Approved→Completed | Admin: bao14@podfoods.co | currentDate |
      | Submitted→Approved | Admin: bao14@podfoods.co | currentDate |
      | →Submitted         | Vendor: Bao North cali   | currentDate |

  @AD_Inventories_900
  Scenario: Admin verify Create A Submitted Disposal/Donation Request Page
    Given BAO_ADMIN15 login web admin by api
      | email             | password  |
      | bao15@podfoods.co | 12345678a |
     # Delete dispose donate request
    And Admin search dispose donate request by API
      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[request_type] | q[status] | q[start_date] | q[end_date] | page    |
      | [blank]   | [blank]              | 2944        | [blank]      | [blank]         | [blank]   | [blank]       | [blank]     | [blank] |
    And Admin cancel all inventory request by API
#    And Admin search inventory by API
#      | q[product_variant_name] | q[product_name]                             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
#      | [blank]                 | random product admin donate request 900 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
#    And Admin get ID inventory by product "random product admin donate request 900 api" from API
#    And Admin delete all subtraction of list inventory
#    And Admin delete inventory "all" by API
#    And Admin search product name "random product admin donate request 900 api" by api
#    And Admin delete product name "random product admin donate request 900 api" by api
##   # Create SKU
#    And Create product by api with file "CreateProduct.json" and info
#      | name                                          | brand_id |
#      | random product admin donate request 900 api 1 | 2944     |
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
#    And Admin create a "active" SKU from admin with name "random sku admin donate request 900 api 1" of product ""
#    # Create inventory
#    And Admin create inventory api1
#      | index | sku    | product_variant_id | quantity | lot_code                                  | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | random | random             | 10       | random sku admin donate request 900 api 1 | 90           | Plus1        | [blank]     | [blank] |
#    And Clear Info of Region api
#  # Create SKU
#    And Create product by api with file "CreateProduct.json" and info
#      | name                                          | brand_id |
#      | random product admin donate request 900 api 2 | 2944     |
#    And Info of Region
#      | region          | id | state  | availability | casePrice | msrp |
#      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
#    And Admin create a "active" SKU from admin with name "random sku admin donate request 900 api 2" of product ""
#    # Create inventory
#    And Admin create inventory api1
#      | index | sku    | product_variant_id | quantity | lot_code                                  | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | random | random             | 10       | random sku admin donate request 900 api 2 | 95           | Plus1        | [blank]     | [blank] |
#    And Clear Info of Region api
#  # Create SKU
#    And Create product by api with file "CreateProduct.json" and info
#      | name                                          | brand_id |
#      | random product admin donate request 900 api 3 | 2944     |
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
#    And Admin create a "active" SKU from admin with name "random sku admin donate request 900 api 3" of product ""
#    # Create inventory
#    And Admin create inventory api1
#      | index | sku    | product_variant_id | quantity | lot_code                                  | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | random | random             | 10       | random sku admin donate request 900 api 3 | 90           | Plus1        | Plus1       | [blank] |
#
    Given BAO_ADMIN15 open web admin
    When login to beta web with email "bao15@podfoods.co" pass "12345678a" role "Admin"
    And BAO_ADMIN15 navigate to "Inventories" to "Disposal/Donation requests" by sidebar
    And Admin create inventory requests
      | vendorCompany                          | region              | type     | note                   |
      | Auto Vendor Company Withdraw inventory | Chicagoland Express | Disposal | Auto Inventory Request |
    And Click on button "Add pullable Inventory"
    And ADMIN check value of field
      | field        | value   |
      | Vendor brand | -       |
      | SKU name     | [blank] |
      | Product name | [blank] |
      | Lot code     | [blank] |
    And Admin search pull able inventory
      | index | vendorBrand                         | sku     | product                                 | lotCode |
      | 1     | Auto brand check withdraw inventory | [blank] | random product admin donate request 900 | [blank] |
    And Admin check lot after search pull able inventory
      | product                                       | lotCode                                   | sku                                       | expiryDate | pullDate |
      | random product admin donate request 900 api 1 | random sku admin donate request 900 api 1 | random sku admin donate request 900 api 1 | [blank]    | [blank]  |
      | random product admin donate request 900 api 3 | random sku admin donate request 900 api 3 | random sku admin donate request 900 api 3 | [blank]    | [blank]  |
    And Admin choose lots to pull able inventory
      | index | sku                                       | lotCode                                   | quantity |
      | 1     | random sku admin donate request 900 api 1 | random sku admin donate request 900 api 1 | 11       |
    And Admin verify pullable inventory of inventory requests detail
      | index | brand                               | product                                       | sku                                       | skuID   | lotCode                                   | expiryDate | pullDate | case |
      | 1     | Auto brand check withdraw inventory | random product admin donate request 900 api 1 | random sku admin donate request 900 api 1 | [blank] | random sku admin donate request 900 api 1 | [blank]    | [blank]  | 1    |
    And Admin create inventory requests and see message "Inventory request items request case must be in range 0..10"
    And Admin verify pullable inventory of inventory requests detail
      | index | brand                               | product                                       | sku                                       | skuID   | lotCode                                   | expiryDate | pullDate | case |
      | 1     | Auto brand check withdraw inventory | random product admin donate request 900 api 1 | random sku admin donate request 900 api 1 | [blank] | random sku admin donate request 900 api 1 | [blank]    | [blank]  | 11   |
    And Click on button "Add pullable Inventory"
    And Admin search pull able inventory
      | index | vendorBrand                         | sku     | product                                 | lotCode |
      | 1     | Auto brand check withdraw inventory | [blank] | random product admin donate request 900 | [blank] |
    And Admin check lot after search pull able inventory
      | product                                       | lotCode                                   | sku                                       | expiryDate | pullDate |
      | random product admin donate request 900 api 3 | random sku admin donate request 900 api 3 | random sku admin donate request 900 api 3 | [blank]    | [blank]  |
    And Admin choose lots to pull able inventory
      | index | sku                                       | lotCode                                   | quantity |
      | 1     | random sku admin donate request 900 api 3 | random sku admin donate request 900 api 3 | [blank]  |
    And Admin verify pullable inventory of inventory requests detail
      | index | brand                               | product                                       | sku                                       | skuID   | lotCode                                   | expiryDate | pullDate | case |
      | 1     | Auto brand check withdraw inventory | random product admin donate request 900 api 3 | random sku admin donate request 900 api 3 | [blank] | random sku admin donate request 900 api 3 | [blank]    | [blank]  | 1    |
    And Click on button "Add pullable Inventory"
    And Admin search pull able inventory
      | index | vendorBrand                         | sku     | product                                 | lotCode |
      | 1     | Auto brand check withdraw inventory | [blank] | random product admin donate request 900 | [blank] |
    And Admin check lot after search pull able inventory
      | product | lotCode | sku     | expiryDate | pullDate |
      | [blank] | [blank] | [blank] | [blank]    | [blank]  |
    And Admin close dialog form
    And Admin edit new inventory requests
      | vendorCompany | region          | type    | note    |
      | [blank]       | Florida Express | [blank] | [blank] |
    And BAO_ADMIN15 check error message is showing of fields
      | field              | message                                   |
      | Pullable Inventory | Pullable inventory must have at least one |
    And Click on button "Add pullable Inventory"
    And Admin search pull able inventory
      | index | vendorBrand                         | sku     | product                                 | lotCode |
      | 1     | Auto brand check withdraw inventory | [blank] | random product admin donate request 900 | [blank] |
    And Admin check lot after search pull able inventory
      | product                                       | lotCode                                   | sku                                       | expiryDate | pullDate |
      | random product admin donate request 900 api 2 | random sku admin donate request 900 api 2 | random sku admin donate request 900 api 2 | [blank]    | [blank]  |
    And Admin choose lots to pull able inventory
      | index | sku                                       | lotCode                                   | quantity |
      | 1     | random sku admin donate request 900 api 2 | random sku admin donate request 900 api 2 | [blank]  |
    And Admin verify pullable inventory of inventory requests detail
      | index | brand                               | product                                       | sku                                       | skuID   | lotCode                                   | expiryDate | pullDate | case |
      | 1     | Auto brand check withdraw inventory | random product admin donate request 900 api 2 | random sku admin donate request 900 api 2 | [blank] | random sku admin donate request 900 api 2 | [blank]    | [blank]  | 1    |
    And Click on button "Add pullable Inventory"
    And Admin search pull able inventory
      | index | vendorBrand                         | sku     | product                                 | lotCode |
      | 1     | Auto brand check withdraw inventory | [blank] | random product admin donate request 900 | [blank] |
    And Admin check lot after search pull able inventory
      | product | lotCode | sku     | expiryDate | pullDate |
      | [blank] | [blank] | [blank] | [blank]    | [blank]  |
    And Admin close dialog form
#      remove lot code
    And  Admin remove inventory to inventory requests detail
      | index | sku                                       | lotCode                                   |
      | 1     | random sku admin donate request 900 api 2 | random sku admin donate request 900 api 2 |
    And BAO_ADMIN15 check error message is showing of fields
      | field              | message                                   |
      | Pullable Inventory | Pullable inventory must have at least one |

  @AD_Inventories_876
  Scenario: Search and Filter
    Given BAO_ADMIN15 login web admin by api
      | email             | password  |
      | bao15@podfoods.co | 12345678a |
     # Reset search filter full textbox
    And Admin filter visibility with id "70" by api
      | q[status]            |
      | q[number]            |
      | q[request_type]      |
      | q[brand_id]          |
      | q[start_date]        |
      | q[end_date]          |
      | q[vendor_company_id] |
      | q[region_id]         |
    And Admin delete filter preset of screen id "70" by api

     # Delete dispose donate request
#    And Admin search dispose donate request by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[request_type] | q[status] | q[start_date] | q[end_date] | page    |
#      | [blank]   | [blank]              | 2944        | [blank]      | [blank]         | [blank]   | [blank]       | [blank]     | [blank] |
#    And Admin cancel all inventory request by API
#    And Admin search inventory by API
#      | q[product_variant_name] | q[product_name]                               | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
#      | [blank]                 | random product admin donate inventory api 876 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
#    And Admin get ID inventory by product "random product admin donate inventory api 876" from API
#    And Admin delete all subtraction of list inventory
#    And Admin delete inventory "all" by API
#    And Admin delete order by sku of product "random product admin donate inventory api 876" by api
#    And Admin search product name "random product admin donate inventory api 876" by api
#    And Admin delete product name "random product admin donate inventory api 876" by api
#    And Create product by api with file "CreateProduct.json" and info
#      | name                                          | brand_id |
#      | random product admin donate inventory api 876 | 3018     |
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
#    And Admin create a "active" SKU from admin with name "random sku admin donate inventory api 876" of product ""
#    And Admin create inventory api1
#      | index | sku                                     | product_variant_id | quantity | lot_code                                  | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | random sku admin donate inventory api 1 | random             | 5        | random sku admin donate inventory api 876 | 99           | Plus1        | Plus1       | [blank] |
#    And Admin set inventory request items API
#      | inventory_id  | product_variant_id | request_case |
#      | create by api | create by api      | 1            |
#    And Admin create dispose donate request by API
#      | comment      | region_id | request_type | vendor_company_id |
#      | Auto comment | 26        | disposal     | 1847              |

    Given BAO_ADMIN15 open web admin
    When login to beta web with email "bao15@podfoods.co" pass "12345678a" role "Admin"
    And BAO_ADMIN15 navigate to "Inventories" to "Disposal/Donation requests" by sidebar
    And Admin search disposal donation requests
      | number  | vendorCompany | brand   | region                   | type    | status  | startDate | endDate |
      | [blank] | [blank]       | [blank] | Atlanta Express          | [blank] | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | Chicagoland Express      | [blank] | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | Denver Express           | [blank] | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | Florida Express          | [blank] | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | Mid Atlantic Express     | [blank] | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | New York Express         | [blank] | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | North California Express | [blank] | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | Phoenix Express          | [blank] | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | Sacramento Express       | [blank] | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | South California Express | [blank] | [blank] | [blank]   | [blank] |
      | [blank] | [blank]       | [blank] | Dallas Express           | [blank] | [blank] | [blank]   | [blank] |
    And Admin reset filter
    And Admin uncheck field of edit visibility in search
      | number  | brand   | type    | startDate | endDate | vendorCompany | region  | status  |
      | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]       | [blank] | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | number  | brand   | type    | startDate | endDate | vendorCompany | region  | status  |
      | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]       | [blank] | [blank] |
    And Admin uncheck field of edit visibility in search
      | number  | brand   | type    | startDate | endDate | vendorCompany | region  | status  |
      | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]       | [blank] | [blank] |
    Then Admin verify field search in edit visibility
      | number  | brand   | type    | startDate | endDate | vendorCompany | region  | status  |
      | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]       | [blank] | [blank] |
    And Admin uncheck field of edit visibility in search
      | number  | region  | status  |
      | [blank] | [blank] | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | number  | region  | status  |
      | [blank] | [blank] | [blank] |
    Then Admin verify field search in edit visibility
      | brand   | type    | startDate | endDate | vendorCompany |
      | [blank] | [blank] | [blank]   | [blank] | [blank]       |
    And Admin uncheck field of edit visibility in search
      | number  | region  | status  |
      | [blank] | [blank] | [blank] |
    Then Admin verify field search in edit visibility
      | number  | brand   | type    | startDate | endDate | vendorCompany | region  | status  |
      | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]       | [blank] | [blank] |
    And Admin search disposal donation requests
      | number    | vendorCompany | brand   | region  | type    | status  | startDate | endDate |
      | 230917839 | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result dispose donate request
      | number    | requestDate | vendorCompany       | brand                     | region              | type     | status    |
      | 230917839 | 09/17/23    | Auto vendor company | Auto brand create product | Chicagoland Express | Disposal | Submitted |
    And Admin save filter by info
      | filterName | type               |
      | [blank]    | Save as new preset |
    And BAO_ADMIN12 check error message is showing of fields on dialog
      | field       | message                         |
      | Preset name | Please enter name filter preset |
    And Admin close dialog form
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin reset filter
    And BAO_ADMIN7 check value of field
      | field  | value   |
      | Number | [blank] |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify result dispose donate request
      | number    | requestDate | vendorCompany       | brand                     | region              | type     | status    |
      | 230917839 | 09/17/23    | Auto vendor company | Auto brand create product | Chicagoland Express | Disposal | Submitted |
    And Admin reset filter
    And Admin search disposal donation requests
      | number  | vendorCompany | brand   | region              | type    | status  | startDate | endDate |
      | 2309178 | [blank]       | [blank] | Chicagoland Express | [blank] | [blank] | [blank]   | [blank] |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest2  | Save as new preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest2"
    And BAO_ADMIN7 check value of field
      | field  | value               |
      | Number | 2309178             |
      | Region | Chicagoland Express |
    Then Admin verify result dispose donate request
      | number    | requestDate | vendorCompany       | brand                     | region              | type     | status    |
      | 230917839 | 09/17/23    | Auto vendor company | Auto brand create product | Chicagoland Express | Disposal | Submitted |
    And Admin search disposal donation requests
      | number  | vendorCompany | brand   | region  | type     | status  | startDate | endDate |
      | 2309178 | [blank]       | [blank] | [blank] | Disposal | [blank] | [blank]   | [blank] |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest2  | Reset existing preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest2"
    And BAO_ADMIN7 check value of field
      | field  | value    |
      | Number | 2309178  |
      | Type   | Disposal |
    Then Admin verify result dispose donate request
      | number    | requestDate | vendorCompany       | brand                     | region              | type     | status    |
      | 230917839 | 09/17/23    | Auto vendor company | Auto brand create product | Chicagoland Express | Disposal | Submitted |
    And Admin delete filter preset is "AutoTest1"
#    And Admin delete filter preset is "AutoTest2"
    Given BAO_ADMIN15 login web admin by api
      | email             | password  |
      | bao15@podfoods.co | 12345678a |
     # Reset search filter full textbox
    And Admin filter visibility with id "70" by api
      | q[status]            |
      | q[number]            |
      | q[request_type]      |
      | q[brand_id]          |
      | q[start_date]        |
      | q[end_date]          |
      | q[vendor_company_id] |
      | q[region_id]         |
    And Admin delete filter preset of screen id "70" by api

  @AD_Inventories_881
  Scenario: Search and Filter 2
    Given BAO_ADMIN15 open web admin
    When login to beta web with email "bao15@podfoods.co" pass "12345678a" role "Admin"
    And BAO_ADMIN15 navigate to "Inventories" to "Disposal/Donation requests" by sidebar
    And Admin search disposal donation requests
      | number    | vendorCompany       | brand                     | region              | type     | status    | startDate   | endDate |
      | 230917839 | Auto vendor company | Auto brand create product | Chicagoland Express | Disposal | Submitted | currentDate | Plus1   |
    Then Admin verify result dispose donate request
      | number    | requestDate | vendorCompany       | brand                     | region              | type     | status    |
      | 230917839 | currentDate | Auto vendor company | Auto brand create product | Chicagoland Express | Disposal | Submitted |


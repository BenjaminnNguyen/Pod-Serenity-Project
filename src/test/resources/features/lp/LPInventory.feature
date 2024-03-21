#mvn clean verify -Dtestsuite="LPInventoryTestSuite" -Dcucumber.options="src/test/resources/features/lp" -Denvironments=product
@feature=LPInventory
Feature: LP Inventory

  @LP_ALL_INVENTORY_1
  Scenario: Verify the All Inventory list
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp inventory 1 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp inventory 1 api" by api
    And Admin delete product name "random product lp inventory 1 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product lp inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inventory 1 api 1" of product ""
    And Admin create inventory api1
      | index | sku                             | product_variant_id | quantity | lot_code                        | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp inventory 1 api 1 | random             | 5        | random sku lp inventory 1 api 1 | 99           | Plus1        | [blank]     | [blank] |

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku                             | product | vendorCompany | vendorBrand |
      | random sku lp inventory 1 api 1 | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku                             | distributionCenter            | vendorCompany       | lotCode                         | currentQuantity | originalQuantity | received | expiry  |
      | 1     | random sku lp inventory 1 api 1 | Auto Ngoc Distribution CHI 01 | Auto vendor company | random sku lp inventory 1 api 1 | 5               | 5                | Plus1    | [blank] |

    And LP clear filter on field "SKU"
    And LP check 50 number record on pagination
    And LP click "2" on pagination
    And LP check 50 number record on pagination
    And LP click "back" on pagination
    And LP check 50 number record on pagination
    And LP click "next" on pagination
#    And LP check 50 number record on pagination
    And LP click "back" on pagination
    And LP search "All" inventory
      | sku     | product                             | vendorCompany | vendorBrand |
      | [blank] | random product lp inventory 1 api 1 | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku                             | distributionCenter            | vendorCompany       | lotCode                         | currentQuantity | originalQuantity | received | expiry  |
      | 1     | random sku lp inventory 1 api 1 | Auto Ngoc Distribution CHI 01 | Auto vendor company | random sku lp inventory 1 api 1 | 5               | 5                | Plus1    | [blank] |
    And LP clear filter on field "Product"
    And LP check 50 number record on pagination
    And LP search "All" inventory
      | sku     | product                             | vendorCompany       | vendorBrand |
      | [blank] | random product lp inventory 1 api 1 | Auto vendor company | [blank]     |
    And Check search result in All inventory
      | index | sku                             | distributionCenter            | vendorCompany       | lotCode                         | currentQuantity | originalQuantity | received | expiry  |
      | 1     | random sku lp inventory 1 api 1 | Auto Ngoc Distribution CHI 01 | Auto vendor company | random sku lp inventory 1 api 1 | 5               | 5                | Plus1    | [blank] |

    And LP search "All" inventory
      | sku     | product                             | vendorCompany | vendorBrand               |
      | [blank] | random product lp inventory 1 api 1 | [blank]       | Auto brand create product |
    And Check search result in All inventory
      | index | sku                             | distributionCenter            | vendorCompany       | lotCode                         | currentQuantity | originalQuantity | received | expiry  |
      | 1     | random sku lp inventory 1 api 1 | Auto Ngoc Distribution CHI 01 | Auto vendor company | random sku lp inventory 1 api 1 | 5               | 5                | Plus1    | [blank] |
    And LP clear filter on field "Vendor Brand"
    And LP clear filter on field "Product"
    And LP search "All" inventory
      | sku                             | product                             | vendorCompany       | vendorBrand               |
      | random sku lp inventory 1 api 1 | random product lp inventory 1 api 1 | Auto vendor company | Auto brand create product |
    And Check search result in All inventory
      | index | sku                             | distributionCenter            | vendorCompany       | lotCode                         | currentQuantity | originalQuantity | received | expiry  |
      | 1     | random sku lp inventory 1 api 1 | Auto Ngoc Distribution CHI 01 | Auto vendor company | random sku lp inventory 1 api 1 | 5               | 5                | Plus1    | [blank] |

  @LP_ALL_INVENTORY_2
  Scenario: Verify the All Inventory list 1
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp inventory 1 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp inventory 1 api" by api
    And Admin delete product name "random product lp inventory 1 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product lp inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inventory 1 api 1" of product ""
    And Admin create inventory api1
      | index | sku                             | product_variant_id | quantity | lot_code                        | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp inventory 1 api 1 | random             | 5        | random sku lp inventory 1 api 1 | 99           | Plus1        | [blank]     | [blank] |

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to "All Inventory" tab
    And LP search "All" inventory
      | sku                             | product                             | vendorCompany       | vendorBrand               |
      | random sku lp inventory 1 api 1 | random product lp inventory 1 api 1 | Auto vendor company | Auto brand create product |
    And Check search result in All inventory
      | index | sku                             | distributionCenter            | vendorCompany       | lotCode                         | currentQuantity | originalQuantity | received | expiry  |
      | 1     | random sku lp inventory 1 api 1 | Auto Ngoc Distribution CHI 01 | Auto vendor company | random sku lp inventory 1 api 1 | 5               | 5                | Plus1    | [blank] |
    And Lp go to "Inbound Inventories" tab
    And Search Inbound inventory
      | number  | brand   | start   | end     | deliveryMethod |
      | [blank] | [blank] | [blank] | [blank] | [blank]        |
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number  | vendorCompany | brand   | region  | request |
      | [blank] | [blank]       | [blank] | [blank] | [blank] |
    And LP search "Submitted" withdrawal requests
      | number  | vendorCompany | brand   | region  | request |
      | [blank] | [blank]       | [blank] | [blank] | [blank] |
    And LP search "Approved" withdrawal requests
      | number  | vendorCompany | brand   | region  | request |
      | [blank] | [blank]       | [blank] | [blank] | [blank] |
    And LP search "Completed" withdrawal requests
      | number  | vendorCompany | brand   | region  | request |
      | [blank] | [blank]       | [blank] | [blank] | [blank] |

  @LP_ALL_INVENTORY_6
  Scenario: Verify validation of each fileds on the Inventory Details section
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp inventory 1 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp inventory 1 api" by api
    And Admin delete product name "random product lp inventory 1 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product lp inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inventory 1 api 1" of product ""
    And Admin create inventory api1
      | index | sku                             | product_variant_id | quantity | lot_code                        | warehouse_id | receive_date | expiry_date | comment  |
      | 1     | random sku lp inventory 1 api 1 | random             | 5        | random sku lp inventory 1 api 1 | 99           | currentDate  | currentDate | Autotest |

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to "All Inventory" tab
    And LP search "All" inventory
      | sku                             | product                             | vendorCompany       | vendorBrand               |
      | random sku lp inventory 1 api 1 | random product lp inventory 1 api 1 | Auto vendor company | Auto brand create product |
    And Check search result in All inventory
      | index | sku                             | distributionCenter            | vendorCompany       | lotCode                         | currentQuantity | originalQuantity | received    | expiry      |
      | 1     | random sku lp inventory 1 api 1 | Auto Ngoc Distribution CHI 01 | Auto vendor company | random sku lp inventory 1 api 1 | 5               | 5                | currentDate | currentDate |
    And LP go to detail inventory "random sku lp inventory 1 api 1"
    Then LP verify info of inventory detail
      | product                             | sku                             | quantity | totalCase | distribution               | lotCode                         | receiveDate | expiryDate  | comment  |
      | random product lp inventory 1 api 1 | random sku lp inventory 1 api 1 | 5        | 5         | Auto Ngoc Distribution CHI | random sku lp inventory 1 api 1 | currentDate | currentDate | Autotest |

  @LP_ALL_INVENTORY_5
  Scenario: Check displayed information on the Create new Inventory page
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp inventory 5 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inventory 5 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inventory 5 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp inventory 5 api" by api
    And Admin delete product name "random product lp inventory 5 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product lp inventory 5 api 1 | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inventory 5 api 1" of product ""

    Given LP open web LP
    When login to beta web with email "ngoctx+autolpwarehousing@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to "All Inventory" tab
    And LP go to create new inventory
    And LP create new inventory
      | distribution                   | sku                             | quantity | lotCode                         | receiveDate | expiryDate  | comment  |
      | Bao distribute florida express | random sku lp inventory 5 api 1 | 5        | random sku lp inventory 5 api 1 | currentDate | currentDate | Autotest |
    And Click on button "Add an image"
    And LP add image for Inventory
      | image       | description |
      | anhJPEG.jpg | auto        |
    And LP create new inventory successfully
    Then LP verify info of inventory detail
      | product                             | sku                             | quantity | totalCase | distribution                   | lotCode                         | receiveDate | expiryDate  | comment  |
      | random product lp inventory 5 api 1 | random sku lp inventory 5 api 1 | 5        | 5         | Bao distribute florida express | random sku lp inventory 5 api 1 | currentDate | currentDate | Autotest |
    And LP check inventory image
      | index | file        | comment |
      | 1     | anhJPEG.jpg | auto    |
    And LP go to back all inventory from detail
    And LP search "All" inventory
      | sku                             | product                             | vendorCompany       | vendorBrand               |
      | random sku lp inventory 5 api 1 | random product lp inventory 5 api 1 | Auto vendor company | Auto brand create product |
    And Check search result in All inventory
      | index | sku                             | distributionCenter             | vendorCompany       | lotCode                         | currentQuantity | originalQuantity | received    | expiry      |
      | 1     | random sku lp inventory 5 api 1 | Bao distribute florida express | Auto vendor company | random sku lp inventory 5 api 1 | 5               | 5                | currentDate | currentDate |

#    SKU 2
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | sold_out     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inventory 5 api 2" of product ""
    And LP go to create new inventory
    And LP create new inventory
      | distribution                   | sku                             | quantity | lotCode                         | receiveDate | expiryDate  | comment  |
      | Bao distribute florida express | random sku lp inventory 5 api 2 | 5        | random sku lp inventory 5 api 2 | currentDate | currentDate | Autotest |
    And Click on button "Add an image"
    And LP add image for Inventory
      | image       | description |
      | anhJPEG.jpg | auto        |
    And LP create new inventory successfully
    Then LP verify info of inventory detail
      | product                             | sku                             | quantity | totalCase | distribution                   | lotCode                         | receiveDate | expiryDate  | comment  |
      | random product lp inventory 5 api 1 | random sku lp inventory 5 api 2 | 5        | 5         | Bao distribute florida express | random sku lp inventory 5 api 2 | currentDate | currentDate | Autotest |

    And LP go to back all inventory from detail
    And LP search "All" inventory
      | sku                             | product                             | vendorCompany       | vendorBrand               |
      | random sku lp inventory 5 api 2 | random product lp inventory 5 api 1 | Auto vendor company | Auto brand create product |
    And Check search result in All inventory
      | index | sku                             | distributionCenter             | vendorCompany       | lotCode                         | currentQuantity | originalQuantity | received    | expiry      |
      | 1     | random sku lp inventory 5 api 2 | Bao distribute florida express | Auto vendor company | random sku lp inventory 5 api 2 | 5               | 5                | currentDate | currentDate |
#    SKU 3
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | coming_soon  | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inventory 5 api 3" of product ""
    And LP go to create new inventory
    And LP create new inventory
      | distribution                   | sku                             | quantity | lotCode                         | receiveDate | expiryDate  | comment  |
      | Bao distribute florida express | random sku lp inventory 5 api 3 | 5        | random sku lp inventory 5 api 3 | currentDate | currentDate | Autotest |
    And Click on button "Add an image"
    And LP add image for Inventory
      | image       | description |
      | anhJPEG.jpg | auto        |
    And LP create new inventory successfully
    Then LP verify info of inventory detail
      | product                             | sku                             | quantity | totalCase | distribution                   | lotCode                         | receiveDate | expiryDate  | comment  |
      | random product lp inventory 5 api 1 | random sku lp inventory 5 api 3 | 5        | 5         | Bao distribute florida express | random sku lp inventory 5 api 3 | currentDate | currentDate | Autotest |

    And LP go to back all inventory from detail
    And LP search "All" inventory
      | sku                             | product                             | vendorCompany       | vendorBrand               |
      | random sku lp inventory 5 api 3 | random product lp inventory 5 api 1 | Auto vendor company | Auto brand create product |
    And Check search result in All inventory
      | index | sku                             | distributionCenter             | vendorCompany       | lotCode                         | currentQuantity | originalQuantity | received    | expiry      |
      | 1     | random sku lp inventory 5 api 3 | Bao distribute florida express | Auto vendor company | random sku lp inventory 5 api 3 | 5               | 5                | currentDate | currentDate |
    #SKU 4
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "inactive" SKU from admin with name "random sku lp inventory 5 api 4" of product ""
    And LP go to create new inventory
    And LP create new inventory
      | distribution                   | sku     | quantity | lotCode | receiveDate | expiryDate | comment |
      | Bao distribute florida express | [blank] | [blank]  | [blank] | [blank]     | [blank]    | [blank] |
    And LP input invalid "SKU"
      | value                           |
      | random sku lp inventory 5 api 4 |
    #SKU 5
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "inactive" SKU from admin with name "random sku lp inventory 5 api 5" of product ""
    And LP go to back all inventory from detail
    And LP go to create new inventory
    And LP create new inventory
      | distribution                   | sku     | quantity | lotCode | receiveDate | expiryDate | comment |
      | Bao distribute florida express | [blank] | [blank]  | [blank] | [blank]     | [blank]    | [blank] |
    And LP input invalid "SKU"
      | value                           |
      | random sku lp inventory 5 api 5 |
#Check email
#    Given USER_EMAIL open login gmail with email "bao@podfoods.co" pass "Baovip99"
#    And USER_EMAIL search email with sender "New inventory registered by LP Auto BaoLPWarehousing "
#    And QA go to first email with title "New inventory registered by LP"
#    And User verify email inventory
#      | lp                                                                     | brand                     | region          | product                           | sku                           | lotCade                       | qty | receivingDate | expiryDate  | time                       |
#      | Auto BaoLPWarehousing received and added the inventory below in Admin, | Auto brand create product | Florida Express | random product lp inventory 5 api | random sku lp inventory 5 api | random sku lp inventory 5 api | 5   | currentDate   | currentDate | Pacific Time (US & Canada) |

  @LP_ALL_INVENTORY_7
  Scenario: Verify validation of each fileds on the Inventory Details section
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp inventory 5 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inventory 5 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inventory 5 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp inventory 5 api" by api
    And Admin delete product name "random product lp inventory 5 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product lp inventory 5 api 1 | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inventory 5 api 1" of product ""

    Given LP open web LP
    When login to beta web with email "ngoctx+autolpwarehousing@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to "All Inventory" tab
    And LP go to create new inventory
    And LP check input "SKU" is "disable"
    And LP create new inventory successfully
    And LP check error message is showing of fields
      | field               | message                    |
      | Distribution center | This field cannot be blank |
      | SKU                 | This field cannot be blank |
      | Quantity            | This field cannot be blank |
      | Lot Code            | This field cannot be blank |
      | Receive date        | This field cannot be blank |

    And LP check error message not showing of fields
      | field       | message                    |
      | Expiry date | This field cannot be blank |
      | Comment     | This field cannot be blank |

    And LP input invalid "Distribution center"
      | value                         |
      | Auto Ngoc Distribution CHI 01 |
    And LP check input "SKU" is "disable"
    And LP create new inventory
      | distribution                   | sku     | quantity | lotCode | receiveDate | expiryDate | comment |
      | Bao distribute florida express | [blank] | a        | [blank] | [blank]     | [blank]    | [blank] |
    And LP check error message is showing of fields
      | field    | message                   |
      | Quantity | Value must be an integer. |
    And LP create new inventory
      | distribution                   | sku     | quantity | lotCode | receiveDate | expiryDate | comment |
      | Bao distribute florida express | [blank] | [blank]  | [blank] | aa/aa/aa    | aa/aa/aa   | [blank] |
    And LP check error message is showing of fields
      | field        | message                    |
      | Receive date | This field cannot be blank |
    And LP check error message not showing of fields
      | field       | message                    |
      | Expiry date | This field cannot be blank |
    And LP check value of field
      | field        | value   |
      | Receive date | [blank] |
      | Expiry date  | [blank] |
    And Click on button "Add an image"
    And LP add image for Inventory
      | image           | description |
      | 10MBgreater.jpg | [blank]     |
    And LP check alert message
      | Maximum file size exceeded. |
    And LP add image for Inventory
      | image            | description |
      | ImageInvalid.mp4 | [blank]     |
    And LP check alert message
      | Invalid file type |
    And LP add image for Inventory
      | image             | description |
      | ImageInvalid1.pdf | [blank]     |
    And LP check alert message
      | Invalid file type |
    And LP add image for Inventory
      | image              | description |
      | ImageInvalid2.xlsx | [blank]     |
    And LP check alert message
      | Invalid file type |
    And LP add image for Inventory
      | image       | description |
      | anhJPEG.jpg | auto        |
    And Click on button "Add an image"
    And Click on button "Add an image"
    And LP add image for Inventory
      | image       | description |
      | anhJPEG.jpg | auto        |

    And Check button "Add an image" is disabled
    And LP delete image of Inventory number 2
    And Check button "Add an image" is enable
    And LP create new inventory
      | distribution                   | sku                             | quantity | lotCode                         | receiveDate | expiryDate  | comment  |
      | Bao distribute florida express | random sku lp inventory 5 api 1 | 5        | random sku lp inventory 5 api 1 | currentDate | currentDate | Autotest |
    And Click on button "Add an image"
    And LP create new inventory successfully
    And LP check alert message
      | Inventory images attachment can't be blank |
    And LP add image for Inventory
      | image       | description |
      | anhJPEG.jpg | auto        |
    And LP create new inventory successfully
    And LP check alert message
      | Create inventory successfully. |
    Then LP verify info of inventory detail
      | product                             | sku                             | quantity | totalCase | distribution                   | lotCode                         | receiveDate | expiryDate  | comment  |
      | random product lp inventory 5 api 1 | random sku lp inventory 5 api 1 | 5        | 5         | Bao distribute florida express | random sku lp inventory 5 api 1 | currentDate | currentDate | Autotest |
    And LP check inventory image
      | index | file        | comment |
      | 1     | anhJPEG.jpg | auto    |
      | 2     | anhJPEG.jpg | auto    |
      | 3     | anhJPEG.jpg | auto    |
    And LP go to back all inventory from detail
    And LP search "All" inventory
      | sku                             | product                             | vendorCompany       | vendorBrand               |
      | random sku lp inventory 5 api 1 | random product lp inventory 5 api 1 | Auto vendor company | Auto brand create product |
    And Check search result in All inventory
      | index | sku                             | distributionCenter             | vendorCompany       | lotCode                         | currentQuantity | originalQuantity | received    | expiry      |
      | 1     | random sku lp inventory 5 api 1 | Bao distribute florida express | Auto vendor company | random sku lp inventory 5 api 1 | 5               | 5                | currentDate | currentDate |

  @LP_ALL_INVENTORY_25
  Scenario: Verify the Non-zero quantity list, Verify the About To Expire list, Verify the Running low list, Verify the Zero quantity list
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp inventory 25 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                    | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inventory 25 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inventory 25 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp inventory 25 api" by api
    And Admin delete product name "random product lp inventory 25 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product lp inventory 25 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inventory 25 api 1" of product ""
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code                         | warehouse_id | receive_date | expiry_date | comment  |
      | 1     | random | random             | 5        | random sku lp inventory 25 api 1 | 99           | currentDate  | currentDate | Autotest |

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to "All Inventory" tab
    And LP search "Non-zero quantity" inventory
      | sku    | product                              | vendorCompany       | vendorBrand               |
      | random | random product lp inventory 25 api 1 | Auto vendor company | Auto brand create product |
    And Check search result in All inventory
      | index | sku    | distributionCenter            | vendorCompany       | lotCode                          | currentQuantity | originalQuantity | received    | expiry      |
      | 1     | random | Auto Ngoc Distribution CHI 01 | Auto vendor company | random sku lp inventory 25 api 1 | 5               | 5                | currentDate | currentDate |

  #    About to expire
    And LP search "About to expire" inventory
      | sku    | product                              | vendorCompany       | vendorBrand               |
      | random | random product lp inventory 25 api 1 | Auto vendor company | Auto brand create product |
    And Check search result in All inventory
      | index | sku    | distributionCenter            | vendorCompany       | lotCode                          | currentQuantity | originalQuantity | received    | expiry      |
      | 1     | random | Auto Ngoc Distribution CHI 01 | Auto vendor company | random sku lp inventory 25 api 1 | 5               | 5                | currentDate | currentDate |
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
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin "fulfilled" all line item in order "create by api" by api
#    #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "update_inventoty_quantity_threshold"
    #"Running low"
    And Switch to actor LP
    And LP search "Running low" inventory
      | sku    | product                              | vendorCompany       | vendorBrand               |
      | random | random product lp inventory 25 api 1 | Auto vendor company | Auto brand create product |
    And Check search result in Running low inventory
      | index | sku    | product                              | vendorCompany       | currentQuantity | originalQuantity | endQuantity |
      | 1     | random | random product lp inventory 25 api 1 | Auto vendor company | 0               | 5                | 0           |
    #Zero quantity"
    And Switch to actor LP
    And LP search "Zero quantity" inventory
      | sku    | product                              | vendorCompany       | vendorBrand               |
      | random | random product lp inventory 25 api 1 | Auto vendor company | Auto brand create product |
    And Check search result in All inventory
      | index | sku    | distributionCenter            | vendorCompany       | lotCode                          | currentQuantity | originalQuantity | received    | expiry      |
      | 1     | random | Auto Ngoc Distribution CHI 01 | Auto vendor company | random sku lp inventory 25 api 1 | 0               | 5                | currentDate | currentDate |

  @LP_ALL_INVENTORY_26
  Scenario: Check the order of all inventory on the Non-zero quantity tab and All tab
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product lp inventory 26 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                    | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inventory 26 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inventory 26 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product lp inventory 26 api" by api
    And Admin delete product name "random product lp inventory 26 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product lp inventory 26 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inventory 26 api 1" of product ""
    And Admin create inventory api1
      | index | sku                              | product_variant_id | quantity | lot_code                         | warehouse_id | receive_date | expiry_date | comment  |
      | 1     | random sku lp inventory 26 api 1 | random             | 5        | random sku lp inventory 26 api 1 | 99           | currentDate  | currentDate | Autotest |
    And Admin create inventory api1
      | index | sku                              | product_variant_id | quantity | lot_code                         | warehouse_id | receive_date | expiry_date | comment  |
      | 2     | random sku lp inventory 26 api 1 | random             | 5        | random sku lp inventory 26 api 2 | 99           | currentDate  | currentDate | Autotest |

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to "All Inventory" tab
    And LP search "Non-zero quantity" inventory
      | sku                              | product                              | vendorCompany       | vendorBrand               |
      | random sku lp inventory 26 api 1 | random product lp inventory 26 api 1 | Auto vendor company | Auto brand create product |
    And Check search result in All inventory
      | index | sku                              | distributionCenter            | vendorCompany       | lotCode                          | currentQuantity | originalQuantity | received    | expiry      |
      | 1     | random sku lp inventory 26 api 1 | Auto Ngoc Distribution CHI 01 | Auto vendor company | random sku lp inventory 26 api 2 | 5               | 5                | currentDate | currentDate |
      | 1     | random sku lp inventory 26 api 1 | Auto Ngoc Distribution CHI 01 | Auto vendor company | random sku lp inventory 26 api 1 | 5               | 5                | currentDate | currentDate |

    Given NGOC_ADMIN_02 open web admin
    When NGOC_ADMIN_02 login to web with role Admin
    And NGOC_ADMIN_02 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName                          | productName                          | vendorCompany       | vendorBrand | region  | distribution                  | createdBy | lotCode | pulled  |
      | random sku lp inventory 26 api 1 | random product lp inventory 26 api 1 | Auto vendor company | [blank]     | [blank] | Auto Ngoc Distribution CHI 01 | [blank]   | [blank] | [blank] |
    And Admin see detail inventory with lotcode
      | index | skuName                          | lotCode                          |
      | 1     | random sku lp inventory 26 api 1 | random sku lp inventory 26 api 2 |
    And Admin create subtraction items
      | quantity | category          | subCategory | comment  |
      | 1        | Pull date reached | Donated     | Autotest |

    And Switch to actor LP
    And LP search "Non-zero quantity" inventory
      | sku                              | product                              | vendorCompany       | vendorBrand               |
      | random sku lp inventory 26 api 1 | random product lp inventory 26 api 1 | Auto vendor company | Auto brand create product |
    And Check search result in All inventory
      | index | sku                              | distributionCenter            | vendorCompany       | lotCode                          | currentQuantity | originalQuantity | received    | expiry      |
      | 1     | random sku lp inventory 26 api 1 | Auto Ngoc Distribution CHI 01 | Auto vendor company | random sku lp inventory 26 api 1 | 5               | 5                | currentDate | currentDate |

  @LP_INBOUND_INVENTORY_1
  Scenario: Verify the Inbound Inventories list
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inbound inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inbound inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin delete order by sku of product "random product lp inbound inventory 1 api" by api
    And Admin search product name "random product lp inbound inventory 1 api" by api
    And Admin delete product name "random product lp inbound inventory 1 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                        | brand_id |
      | random product lp inbound inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 1 api 1" of product ""

    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |
#Submit inbound
    And  Admin set items info to submit of Incoming Inventory "api" api
      | sku                                     | lot_code                                | quantity | expiry_date |
      | random sku lp inbound inventory 1 api 1 | random sku lp inbound inventory 1 api 1 | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
    #Approve inbound
#    And Admin Approve Incoming Inventory id "api" api

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Inbound Inventories" tab
    And Search Inbound inventory
      | number        | brand   | start   | end     | deliveryMethod |
      | create by api | [blank] | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number        | brand                     | eta   | pallets | cases | freightCarrier  |
      | create by api | Auto brand create product | Plus1 | 1       | 1     | freight_carrier |

#    And LP search inbound with all filter
#      | number        | brand                     | start       | end     | deliveryMethod      | freightCarrier  | lpReview | status   |
#      | create by api | Auto brand create product | currentDate | [blank] | Brand Self Delivery | freight_carrier | No       | Approved |
#    And LP close search all filters inbound
#    And LP Check list of Inbound inventory
#      | number        | brand                     | eta   | pallets | cases | freightCarrier  |
#      | create by api | Auto brand create product | Plus1 | 1       | 1     | freight_carrier |
#    And LP search inbound with all filter
#      | number  | brand   | start       | end   | deliveryMethod      | freightCarrier  | lpReview | status   |
#      | [blank] | [blank] | currentDate | Plus1 | Brand Self Delivery | freight_carrier | -        | Received |
#    And LP clear search all filters inbound
#    And LP search inbound with all filter
#      | number  | brand   | start       | end    | deliveryMethod         | freightCarrier | lpReview | status |
#      | [blank] | [blank] | currentDate | Minus1 | Small Package / Parcel | [blank]        | Yes      | -      |
#    And LP clear search all filters inbound

#  @LP_INBOUND_INVENTORY_2
#  Scenario: Verify the Inbound Inventories list * Vendor creates inbound inventory process
#    Given NGOCTX login web admin by api
#      | email            | password  |
#      | bao4@podfoods.co | 12345678a |
#    And Admin search inventory by API
#      | q[product_variant_name] | q[product_name]                           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
#      | [blank]                 | random product lp inbound inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
#    And Admin get ID inventory by product "random product lp inbound inventory 1 api" from API
#    And Admin delete all subtraction of list inventory
#    And Admin delete inventory "all" by API
#    And Admin search Incoming Inventory by api
#      | field       | value |
#      | q[brand_id] | 3018  |
#    And Admin cancel Incoming Inventory by api
#      | reason   |
#      | Autotest |
#    And Admin delete order by sku of product "random product lp inbound inventory 1 api" by api
#    And Admin search product name "random product lp inbound inventory 1 api" by api
#    And Admin delete product name "random product lp inbound inventory 1 api" by api
#    And Create product by api with file "CreateProduct.json" and info
#      | name                                        | brand_id |
#      | random product lp inbound inventory 1 api 1 | 3018     |
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
#    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 1 api 1" of product ""
#
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And Vendor go to create inbound page by url
#    And Choose Region "Chicagoland Express" and check Instructions
#    And Vendor input info of inbound inventory
#      | deliveryMethod      | estimatedDateArrival | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | trackingNumber | totalWeight | zipCode |
#      | Brand Self Delivery | currentDate          | 1         | 1                | 1              | 1                         | 1              | 1           | 11111   |
#    And Vendor input info optional of inbound inventory
#      | otherShipping | freightCarrier | trackingNumber | referenceNumber | estimatedWeek | note | palletTransit | palletWarehouse | fileBOL     | transportName     | transportPhone |
#      | 1             | 1              | 1              | 1               | [blank]       | 1    | Yes           | Yes             | anhJPEG.jpg | AT Transport Name | 0123456789     |
#
##    And Add SKU to inbound inventory
##      | index | sku                                     | caseOfSku | productLotCode                          | expiryDate |
##      | 1     | random sku lp inbound inventory 1 api 1 | 10        | random sku lp inbound inventory 1 api 1 | Plus2      |
##    And Vendor check Total of Sellable Retail Cases = "10"
#    And Confirm create inbound inventory
#
#    Given NGOC_ADMIN_02 open web admin
#    When NGOC_ADMIN_02 login to web with role Admin
#    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
#    And Admin search incoming inventory
#      | number          | vendorCompany       | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
#      | create by admin | Auto vendor company | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
#    And Go to detail of incoming inventory number ""
#    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI" then approve
#
#    Given USER_LP open web LP
#    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
#    And USER_LP Navigate to "Inventory" by sidebar
#    And Lp go to "Inbound Inventories" tab
#    And Search Inbound inventory
#      | number           | brand   | start   | end     | deliveryMethod |
#      | create by vendor | [blank] | [blank] | [blank] | [blank]        |
#    And LP Check list of Inbound inventory
#      | number  | brand                     | eta         | pallets | cases | freightCarrier  | status   |
#      | [blank] | Auto brand create product | currentDate | 1       | 1     | Freight Carrier | Approved |
#
#    And Switch to actor NGOC_ADMIN_02
#    And Admin upload file to inbound
#      | bol     | pod     |
#      | [blank] | POD.pdf |
#    And Click on button "Mark as Received"
#    And Click on dialog button "OK"
#
#    And Switch to actor USER_LP
#    And USER_LP Navigate to "Inventory" by sidebar
#    And Lp go to "Inbound Inventories" tab
#    And Search Inbound inventory
#      | number           | brand   | start   | end     | deliveryMethod |
#      | create by vendor | [blank] | [blank] | [blank] | [blank]        |
#    And LP Check list of Inbound inventory
#      | number  | brand                     | eta         | pallets | cases | freightCarrier  | status   |
#      | [blank] | Auto brand create product | currentDate | 1       | 1     | Freight Carrier | Received |
#    And LP export Item List
#    And LP check content file Item List
#      | Brand | Product | SKU | Case UPC/EAN | Itemcode | Unit Weight | Case pack size | Storage shelf life | New |

  @LP_INBOUND_INVENTORY_18 @LP_INBOUND_INVENTORY_22 @LP_INBOUND_INVENTORY_3
  Scenario: Verify the Inbound Inventory list and the Inbound Inventory details by details
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                            | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inbound inventory 18 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inbound inventory 18 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin delete order by sku of product "random product lp inbound inventory 18 api" by api
    And Admin search product name "random product lp inbound inventory 18 api" by api
    And Admin delete product name "random product lp inbound inventory 18 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                         | brand_id |
      | random product lp inbound inventory 18 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 18 api 1" of product ""
    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 18 api 2" of product ""
    And Admin add SKU to Incoming Inventory api
      | skuName                                  | product_variant_id | vendor_company_id | quantity |
      | random sku lp inbound inventory 18 api 1 | random             | 1847              | 10       |
      | random sku lp inbound inventory 18 api 2 | random             | 1847              | 20       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |
#Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                      | lot_code                                 | quantity | expiry_date |
      | random sku lp inbound inventory 18 api 1 | random sku lp inbound inventory 18 api 1 | 10       | Plus1       |
      | random sku lp inbound inventory 18 api 2 | random sku lp inbound inventory 18 api 2 | 20       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
    #Approve inbound
#    And Admin Approve Incoming Inventory id "api" api

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Inbound Inventories" tab
    And Search Inbound inventory
      | number        | brand   | start   | end     | deliveryMethod |
      | create by api | [blank] | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number        | brand                     | eta   | pallets | cases | freightCarrier  | status    |
      | create by api | Auto brand create product | Plus1 | 1       | 0     | freight_carrier | Confirmed |
    And LP go to Inbound inventory detail of number "create by api"
    And LP Check General Information of Inbound inventory
      | region              | vendorCompany       | status    | deliveryMethod        | lpReview | eta   | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | transportContactName       | transportContactPhone | otherShippingDetail | freightCarrier  | trackingNumber  | referenceNumber  | bol   |
      | Chicagoland Express | Auto vendor company | Confirmed | Freight Carrier / LTL | No       | Plus1 | 1        | 1.0            | 30               | 1                         | transport_coordinator_name | 1234567890            | other_detail        | freight_carrier | tracking_number | reference_number | Empty |

    And LP check help text tooltip
      | field                                        | text                                                                                                                                                       |
      | # of Pallets                                 | If not shipping a pallet, please indicate 0                                                                                                                |
#      | # of Sellable Retail Cases                   | A sellable retail case is how your product is set up on Pod Foods                                                                                          |
      | # of Master Cartons                          | If not shipping in master cartons, please indicate 0, A master carton is a shipping carton which contains multiple sellable retail cases of the same item. |
      | # of Sellable Retail Cases per Master Carton | If not shipping in master cartons, please indicate 0                                                                                                       |
      | Other special shipping details               | e.g. if SKUs are color-coded, separated by layers on the pallet etc                                                                                        |
#      | Freight Carrier                              | If using a freight carrier - please indicate the carrier name and" and "PRO/PO/BOL/Load Number and tracking links if available                             |
      | Upload Signed WPL                            | Can upload multiple PDF, Excel or Image files. The maximum file size is 10MB.                                                                              |
    And LP Check SKUs Information of Inbound inventory
      | brand                     | product                                      | nameSKU                                  | unitUpc      | caseUpc      | lotCode                                  | ofCase | pack        | expiryDate | receivingDate | storage | temperature   | caseReceived | caseDamaged | caseShorted | caseExcess |
      | Auto brand create product | random product lp inbound inventory 18 api 1 | random sku lp inbound inventory 18 api 1 | 123123123123 | 123123123123 | random sku lp inbound inventory 18 api 1 | 10     | 1 unit/case | Plus1      | Plus1         | 1 day   | 1.0 F - 1.0 F | [blank]      | 0           | 0           | 0          |
      | Auto brand create product | random product lp inbound inventory 18 api 1 | random sku lp inbound inventory 18 api 1 | 123123123123 | 123123123123 | random sku lp inbound inventory 18 api 1 | 10     | 1 unit/case | Plus1      | Plus1         | Dry     | 1.0 F - 1.0 F | [blank]      | 0           | 0           | 0          |
      | Auto brand create product | random product lp inbound inventory 18 api 1 | random sku lp inbound inventory 18 api 2 | 123123123123 | 123123123123 | random sku lp inbound inventory 18 api 2 | 20     | 1 unit/case | Plus1      | Plus1         | 1 day   | 1.0 F - 1.0 F | [blank]      | 0           | 0           | 0          |
      | Auto brand create product | random product lp inbound inventory 18 api 1 | random sku lp inbound inventory 18 api 2 | 123123123123 | 123123123123 | random sku lp inbound inventory 18 api 2 | 20     | 1 unit/case | Plus1      | Plus1         | Dry     | 1.0 F - 1.0 F | [blank]      | 0           | 0           | 0          |

    Given NGOC_ADMIN_02 open web admin
    When NGOC_ADMIN_02 login to web with role Admin
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany       | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by api | Auto vendor company | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Go to detail of incoming inventory number "create by api"
    And Admin upload file to inbound
      | bol     | pod     |
      | [blank] | POD.pdf |
    And Admin choose "OK" mark inbound as received

#    And Click on button "Mark as Received"
#    And Click on dialog button "OK"

    And Switch to actor USER_LP
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Inbound Inventories" tab
    And Search Inbound inventory
      | number        | brand   | start   | end     | deliveryMethod |
      | create by api | [blank] | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number        | brand                     | eta   | pallets | cases | freightCarrier  | status   |
      | create by api | Auto brand create product | Plus1 | 1       | 30    | freight_carrier | Received |
    And LP go to Inbound inventory detail of number "create by api"
    And LP Check General Information of Inbound inventory
      | region              | vendorCompany       | status   | deliveryMethod        | lpReview | eta   | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | transportContactName       | transportContactPhone | otherShippingDetail | freightCarrier  | trackingNumber  | referenceNumber  | bol   |
      | Chicagoland Express | Auto vendor company | Received | Freight Carrier / LTL | No       | Plus1 | 1        | 1.0            | 30               | 1                         | transport_coordinator_name | 1234567890            | other_detail        | freight_carrier | tracking_number | reference_number | Empty |

  @LP_INBOUND_INVENTORY_4
  Scenario: Verify the Inbound Inventories list * Admin creates inbound inventory - Vendor upload POD
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inbound inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inbound inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin delete order by sku of product "random product lp inbound inventory 1 api" by api
    And Admin search product name "random product lp inbound inventory 1 api" by api
    And Admin delete product name "random product lp inbound inventory 1 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                        | brand_id |
      | random product lp inbound inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 18 api 1" of product ""
#    And Admin add SKU to Incoming Inventory api
#      | product_variant_id | vendor_company_id | quantity |
#      | random             | 1847              | 10       |
    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 18 api 2" of product ""
    And Admin add SKU to Incoming Inventory api
      | skuName                                  | product_variant_id | vendor_company_id | quantity |
      | random sku lp inbound inventory 18 api 1 | random             | 1847              | 10       |
      | random sku lp inbound inventory 18 api 2 | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |
#Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                      | lot_code                                 | quantity | expiry_date |
      | random sku lp inbound inventory 18 api 1 | random sku lp inbound inventory 18 api 1 | 10       | Plus1       |
      | random sku lp inbound inventory 18 api 2 | random sku lp inbound inventory 18 api 2 | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
    #Approve inbound
#    And Admin Approve Incoming Inventory id "api" api
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And Vendor go to create inbound page by url
#    And Choose Region "Chicagoland Express" and check Instructions
#    And Vendor input info of inbound inventory
#      | deliveryMethod      | estimatedDateArrival | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | trackingNumber | totalWeight | zipCode |
#      | Brand Self Delivery | currentDate          | 1         | 1                | 1              | 1                         | 1              | 1           | 11111   |
#    And Vendor input info optional of inbound inventory
#      | otherShipping | freightCarrier | trackingNumber | referenceNumber | estimatedWeek | note | palletTransit | palletWarehouse | fileBOL     | transportName     | transportPhone |
#      | 1             | 1              | 1              | 1               | [blank]       | 1    | Yes           | Yes             | anhJPEG.jpg | AT Transport Name | 0123456789     |
#    And Vendor upload POD to inbound inventory
#      | anhJPEG.jpg |
##    And Add SKU to inbound inventory
##      | index | sku                                     | caseOfSku | productLotCode                          | expiryDate |
##      | 1     | random sku lp inbound inventory 1 api 1 | 10        | random sku lp inbound inventory 1 api 1 | Plus2      |
##    And Vendor check Total of Sellable Retail Cases = "10"
#    And Confirm create inbound inventory

    Given NGOC_ADMIN_02 open web admin
    When NGOC_ADMIN_02 login to web with role Admin
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany       | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by api | Auto vendor company | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Go to detail of incoming inventory number "create by api"
    And Add the warehouse "Auto Ngoc Distribution CHI" for incoming inventory
#    And Admin Process for this incoming inventory
#    And Approve for this incoming inventory
#    And Click on button "Mark as Received"
#    And Click on dialog button "OK"
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Inbound Inventories" tab
    And Search Inbound inventory
      | number        | brand   | start   | end     | deliveryMethod |
      | create by api | [blank] | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number        | brand                     | eta   | pallets | cases | freightCarrier  | status    |
      | create by api | Auto brand create product | Plus1 | 1       | 20    | freight_carrier | Confirmed |
    And LP go to Inbound inventory detail of number "create by api"
    And LP Check General Information of Inbound inventory
      | region              | vendorCompany       | status    | deliveryMethod        | lpReview | eta   | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | transportContactName       | transportContactPhone | otherShippingDetail | freightCarrier  | trackingNumber  | referenceNumber  | bol   |
      | Chicagoland Express | Auto vendor company | Confirmed | Freight Carrier / LTL | No       | Plus1 | 1        | 1.0            | 20               | 1                         | transport_coordinator_name | 1234567890            | other_detail        | freight_carrier | tracking_number | reference_number | Empty |
    And Switch to actor NGOC_ADMIN_02
    And Admin upload file to inbound
      | bol     | pod     |
      | BOL.pdf | POD.pdf |
    And Admin choose "OK" mark inbound as received
    And Switch to actor USER_LP
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Inbound Inventories" tab
    And Search Inbound inventory
      | number        | brand   | start   | end     | deliveryMethod |
      | create by api | [blank] | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number        | brand                     | eta   | pallets | cases | freightCarrier  | status   |
      | create by api | Auto brand create product | Plus1 | 1       | 20    | freight_carrier | Received |
    And LP go to Inbound inventory detail of number "create by api"
    And LP Check General Information of Inbound inventory
      | region              | vendorCompany       | status   | deliveryMethod        | lpReview | eta   | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | transportContactName       | transportContactPhone | otherShippingDetail | freightCarrier  | trackingNumber  | referenceNumber  | bol     |
      | Chicagoland Express | Auto vendor company | Received | Freight Carrier / LTL | No       | Plus1 | 1        | 1.0            | 20               | 1                         | transport_coordinator_name | 1234567890            | other_detail        | freight_carrier | tracking_number | reference_number | BOL.pdf |

  @LP_INBOUND_INVENTORY_23 @LP_INBOUND_INVENTORY_24 @LP_INBOUND_INVENTORY_26
  Scenario: Vendor edit all editable fields on the General Information so that they are not equal to 0 or not empty
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                            | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inbound inventory 23 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inbound inventory 23 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin delete order by sku of product "random product lp inbound inventory 23 api" by api
    And Admin search product name "random product lp inbound inventory 23 api" by api
    And Admin delete product name "random product lp inbound inventory 23 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                         | brand_id |
      | random product lp inbound inventory 23 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 23 api 1" of product ""
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |
#Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                      | lot_code                                 | quantity | expiry_date |
      | random sku lp inbound inventory 23 api 1 | random sku lp inbound inventory 23 api 1 | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 2                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
    #Approve inbound
#    And Admin Approve Incoming Inventory id "api" api

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And VENDOR Go to detail of inbound inventory have number: "create by api"
    And Vendor input info optional of inbound inventory
      | otherShipping | freightCarrier | trackingNumber | referenceNumber | estimatedWeek | note | palletTransit | palletWarehouse | fileBOL     | transportName     | transportPhone |
      | 1             | 1              | 1              | 1               | [blank]       | 1    | Yes           | Yes             | anhJPEG.jpg | AT Transport Name | 0123456789     |
    And Vendor update request inbound inventory

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Inbound Inventories" tab
    And Search Inbound inventory
      | number        | brand   | start   | end     | deliveryMethod |
      | create by api | [blank] | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number        | brand                     | eta   | pallets | cases | freightCarrier |
      | create by api | Auto brand create product | Plus1 | 1       | 1     | 1              |
    And LP go to Inbound inventory detail of number "create by api"
    And LP Check General Information of Inbound inventory
      | region              | vendorCompany       | status    | deliveryMethod      | lpReview | eta   | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | transportContactName | transportContactPhone | otherShippingDetail | freightCarrier | trackingNumber | referenceNumber | bol         |
      | Chicagoland Express | Auto vendor company | Confirmed | Brand Self Delivery | No       | Plus1 | 1        | 1.0            | 10               | 1                         | AT Transport Name    | 0123456789            | 1                   | 1              | 1              | 1               | anhJPEG.jpg |

    And Switch to actor VENDOR
    And Vendor input info optional of inbound inventory
      | otherShipping | freightCarrier | trackingNumber | referenceNumber | estimatedWeek | note    | palletTransit | palletWarehouse | fileBOL | transportName | transportPhone |
      | [blank]       | [blank]        | [blank]        | [blank]         | [blank]       | [blank] | [blank]       | [blank]         | BOL.pdf | [blank]       | [blank]        |
    And Vendor update request inbound inventory
    And Switch to actor USER_LP
    And LP go to back inbound inventory from detail
    And Search Inbound inventory
      | number        | brand   | start   | end     | deliveryMethod |
      | create by api | [blank] | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number        | brand                     | eta   | pallets | cases | freightCarrier |
      | create by api | Auto brand create product | Plus1 | 1       | 1     | 1              |

    And LP go to Inbound inventory detail of number "create by api"
    And LP Check General Information of Inbound inventory
      | region              | vendorCompany       | status    | deliveryMethod      | lpReview | eta   | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | transportContactName | transportContactPhone | otherShippingDetail | freightCarrier | trackingNumber | referenceNumber | bol     |
      | Chicagoland Express | Auto vendor company | Confirmed | Brand Self Delivery | No       | Plus1 | 1        | 1.0            | 10               | 1                         | AT Transport Name    | 0123456789            | 1                   | 1              | 1              | 1               | BOL.pdf |
    And LP choose Appointment date inbound
      | appointmentDate | appointmentTime |
      | [blank]         | [blank]         |
    And LP check alert message
      | Please correct the errors on this form before continuing. |
    And LP check error message is showing of fields
      | field            | message                    |
      | Appointment date | This field cannot be blank |
    And LP choose Appointment date inbound
      | appointmentDate | appointmentTime |
      | currentDate     | [blank]         |
    And LP check alert message
      | Please correct the errors on this form before continuing. |
    And LP check error message is showing of fields
      | field            | message                    |
      | Appointment date | This field cannot be blank |
    And LP remove Appointment date inbound
    And LP choose Appointment date inbound
      | appointmentDate | appointmentTime |
      | [blank]         | 08:00           |
    And LP check alert message
      | Please correct the errors on this form before continuing. |
    And LP check error message is showing of fields
      | field            | message                    |
      | Appointment date | This field cannot be blank |
    And LP choose Appointment date inbound
      | appointmentDate | appointmentTime |
      | currentDate     | 08:00           |
    And LP check alert message
      | Inbound inventory updated successfully. |
    And LP remove Appointment date inbound
    And LP choose Appointment date inbound
      | appointmentDate | appointmentTime |
      | [blank]         | [blank]         |
    And LP check alert message
      | Please correct the errors on this form before continuing. |
    And LP go to back inbound inventory from detail
    And Search Inbound inventory
      | number        | brand   | start   | end     | deliveryMethod |
      | create by api | [blank] | [blank] | [blank] | [blank]        |
    And LP go to Inbound inventory detail of number "create by api"
    And LP Check General Information of Inbound inventory
      | region              | vendorCompany       | status    | deliveryMethod      | lpReview | eta         | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | transportContactName | transportContactPhone | otherShippingDetail | freightCarrier | trackingNumber | referenceNumber | bol     |
      | Chicagoland Express | Auto vendor company | Confirmed | Brand Self Delivery | No       | currentDate | 1        | 1.0            | 10               | 1                         | AT Transport Name    | 0123456789            | 1                   | 1              | 1              | 1               | BOL.pdf |
    And LP check Appointment date inbound
      | appointmentDate | appointmentTime |
      | currentDate     | 08:00           |
    And LP edit cases info of items on inbound
      | lotCode                                  | casesReceived | damagedCase | shortedCase | excessCases |
      | random sku lp inbound inventory 23 api 1 | [blank]       | [blank]     | [blank]     | [blank]     |
    And LP check alert message
      | Inbound inventory updated successfully. |
    And LP Check SKUs Information of Inbound inventory
      | brand                     | product                                      | nameSKU                                  | unitUpc      | caseUpc      | lotCode                                  | ofCase | pack        | expiryDate | receivingDate | storage | temperature   | caseReceived | caseDamaged | caseShorted | caseExcess |
      | Auto brand create product | random product lp inbound inventory 23 api 1 | random sku lp inbound inventory 23 api 1 | 123123123123 | 123123123123 | random sku lp inbound inventory 23 api 1 | 10     | 1 unit/case | Plus1      | Plus1         | 1 day   | 1.0 F - 1.0 F | [blank]      | 0           | 0           | 0          |
    And LP edit cases info of items on inbound
      | lotCode                                  | casesReceived | damagedCase | shortedCase | excessCases |
      | random sku lp inbound inventory 23 api 1 | -1            | [blank]     | [blank]     | [blank]     |
    And LP check alert message
      | Please correct the errors on this form before continuing. |
    And LP check error message is showing of fields
      | field               | message                                  |
      | # of Cases Received | Value must be greater than or equal to 0 |
    And LP edit cases info of items on inbound
      | lotCode                                  | casesReceived | damagedCase | shortedCase | excessCases |
      | random sku lp inbound inventory 23 api 1 | 0             | -1          | [blank]     | [blank]     |
    And LP check alert message
      | Please correct the errors on this form before continuing. |
    And LP check error message is showing of fields
      | field              | message                                  |
      | # of Damaged Cases | Value must be greater than or equal to 0 |
    And LP edit cases info of items on inbound
      | lotCode                                  | casesReceived | damagedCase | shortedCase | excessCases |
      | random sku lp inbound inventory 23 api 1 | 0             | 0           | -1          | [blank]     |
    And LP check alert message
      | Please correct the errors on this form before continuing. |
    And LP check error message is showing of fields
      | field              | message                                  |
      | # of Shorted Cases | Value must be greater than or equal to 0 |
    And LP edit cases info of items on inbound
      | lotCode                                  | casesReceived | damagedCase | shortedCase | excessCases |
      | random sku lp inbound inventory 23 api 1 | 0             | 0           | 0           | -1          |
    And LP check alert message
      | Please correct the errors on this form before continuing. |
    And LP check error message is showing of fields
      | field             | message                                  |
      | # of Excess Cases | Value must be greater than or equal to 0 |
    And LP edit cases info of items on inbound
      | lotCode                                  | casesReceived | damagedCase | shortedCase | excessCases |
      | random sku lp inbound inventory 23 api 1 | -1            | -1          | -1          | -1          |
    And LP check alert message
      | Please correct the errors on this form before continuing. |
    And LP check error message is showing of fields
      | field               | message                                  |
      | # of Cases Received | Value must be greater than or equal to 0 |
      | # of Damaged Cases  | Value must be greater than or equal to 0 |
      | # of Shorted Cases  | Value must be greater than or equal to 0 |
      | # of Excess Cases   | Value must be greater than or equal to 0 |
    And LP edit cases info of items on inbound
      | lotCode                                  | casesReceived | damagedCase | shortedCase | excessCases |
      | random sku lp inbound inventory 23 api 1 | 0             | 1           | 1           | 1           |
    And LP check alert message
      | Inbound inventory updated successfully. |
    And LP Check SKUs Information of Inbound inventory
      | brand                     | product                                      | nameSKU                                  | unitUpc      | caseUpc      | lotCode                                  | ofCase | pack        | expiryDate | receivingDate | storage | temperature   | caseReceived | caseDamaged | caseShorted | caseExcess |
      | Auto brand create product | random product lp inbound inventory 23 api 1 | random sku lp inbound inventory 23 api 1 | 123123123123 | 123123123123 | random sku lp inbound inventory 23 api 1 | 10     | 1 unit/case | Plus1      | Plus1         | 1 day   | 1.0 F - 1.0 F | 0            | 1           | 1           | 1          |
    And LP go to back inbound inventory from detail
    And Search Inbound inventory
      | number        | brand   | start   | end     | deliveryMethod |
      | create by api | [blank] | [blank] | [blank] | [blank]        |
    And LP go to Inbound inventory detail of number "create by api"
    And LP Check General Information of Inbound inventory
      | region              | vendorCompany       | status    | deliveryMethod      | lpReview | eta         | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | transportContactName | transportContactPhone | otherShippingDetail | freightCarrier | trackingNumber | referenceNumber | bol     |
      | Chicagoland Express | Auto vendor company | Confirmed | Brand Self Delivery | Yes      | currentDate | 1        | 1.0            | 10               | 1                         | AT Transport Name    | 0123456789            | 1                   | 1              | 1              | 1               | BOL.pdf |
    And LP check Appointment date inbound
      | appointmentDate | appointmentTime |
      | currentDate     | 08:00           |
    And LP Check SKUs Information of Inbound inventory
      | brand                     | product                                      | nameSKU                                  | unitUpc      | caseUpc      | lotCode                                  | ofCase | pack        | expiryDate | receivingDate | storage | temperature   | caseReceived | caseDamaged | caseShorted | caseExcess |
      | Auto brand create product | random product lp inbound inventory 23 api 1 | random sku lp inbound inventory 23 api 1 | 123123123123 | 123123123123 | random sku lp inbound inventory 23 api 1 | 10     | 1 unit/case | Plus1      | Plus1         | 1 day   | 1.0 F - 1.0 F | 0            | 1           | 1           | 1          |

  @LP_INBOUND_INVENTORY_30
  Scenario: Check displayed information on each inbound inventory in the list and in the details when ADMIN creates inbound inventory process
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                            | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inbound inventory 30 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inbound inventory 30 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 2946  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin delete order by sku of product "random product lp inbound inventory 30 api" by api
    And Admin search product name "random product lp inbound inventory 30 api" by api
    And Admin delete product name "random product lp inbound inventory 30 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                         | brand_id |
      | random product lp inbound inventory 30 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 30 api 1" of product ""
#    And Admin add SKU to Incoming Inventory api
#      | product_variant_id | vendor_company_id | quantity |
#      | random             | 1847              | 10       |
#    Brand 2
    And Create product by api with file "CreateProduct.json" and info
      | name                                         | brand_id |
      | random product lp inbound inventory 30 api 2 | 2946     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 30 api 2" of product ""
#    And Admin add SKU to Incoming Inventory api
#      | product_variant_id | vendor_company_id | quantity |
#      | random             | 1847              | 10       |
    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 30 api 3" of product ""
    And Admin add SKU to Incoming Inventory api
      | skuName                                  | product_variant_id | vendor_company_id | quantity |
      | random sku lp inbound inventory 30 api 1 | random             | 1847              | 10       |
      | random sku lp inbound inventory 30 api 2 | random             | 1847              | 10       |
      | random sku lp inbound inventory 30 api 3 | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |
#Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                      | lot_code                                 | quantity | expiry_date |
      | random sku lp inbound inventory 30 api 1 | random sku lp inbound inventory 30 api 1 | 10       | Plus1       |
      | random sku lp inbound inventory 30 api 2 | random sku lp inbound inventory 30 api 2 | 10       | Plus1       |
      | random sku lp inbound inventory 30 api 3 | random sku lp inbound inventory 30 api 3 | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
    #Approve inbound
#    And Admin Approve Incoming Inventory id "api" api

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Inbound Inventories" tab
    And Search Inbound inventory
      | number        | brand   | start   | end     | deliveryMethod |
      | create by api | [blank] | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number        | brand                              | eta   | pallets | cases | freightCarrier  |
      | create by api | Auto Brand low quantity thresshold | Plus1 | 1       | 30    | freight_carrier |
    And LP Check list of Inbound inventory
      | number        | brand                     | eta   | pallets | cases | freightCarrier  |
      | create by api | Auto brand create product | Plus1 | 1       | 30    | freight_carrier |
    And Search Inbound inventory
      | number  | brand                              | start   | end     | deliveryMethod |
      | [blank] | Auto Brand low quantity thresshold | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number        | brand                     | eta   | pallets | cases | freightCarrier  |
      | create by api | Auto brand create product | Plus1 | 1       | 30    | freight_carrier |
    And LP Check list of Inbound inventory
      | number        | brand                              | eta   | pallets | cases | freightCarrier  |
      | create by api | Auto Brand low quantity thresshold | Plus1 | 1       | 30    | freight_carrier |
    And Search Inbound inventory
      | number  | brand                     | start   | end     | deliveryMethod |
      | [blank] | Auto brand create product | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number        | brand                              | eta   | pallets | cases | freightCarrier  |
      | create by api | Auto Brand low quantity thresshold | Plus1 | 1       | 30    | freight_carrier |
    And LP Check list of Inbound inventory
      | number        | brand                     | eta   | pallets | cases | freightCarrier  |
      | create by api | Auto brand create product | Plus1 | 1       | 30    | freight_carrier |

    And LP go to Inbound inventory detail of number "create by api"
    And LP Check General Information of Inbound inventory
      | region              | vendorCompany       | status    | deliveryMethod        | lpReview | eta   | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | transportContactName       | transportContactPhone | otherShippingDetail | freightCarrier  | trackingNumber  | referenceNumber  | bol   |
      | Chicagoland Express | Auto vendor company | Confirmed | Freight Carrier / LTL | No       | Plus1 | 1        | 1.0            | 30               | 1                         | transport_coordinator_name | 1234567890            | other_detail        | freight_carrier | tracking_number | reference_number | Empty |
    And LP Check SKUs Information of Inbound inventory
      | brand                              | product                                      | nameSKU                                  | unitUpc      | caseUpc      | lotCode                                  | ofCase | pack        | expiryDate | receivingDate | storage | temperature   | caseReceived | caseDamaged | caseShorted | caseExcess |
      | Auto Brand low quantity thresshold | random product lp inbound inventory 30 api 2 | random sku lp inbound inventory 30 api 3 | 123123123123 | 123123123123 | random sku lp inbound inventory 30 api 3 | 10     | 1 unit/case | Plus1      | Plus1         | 1 day   | 1.0 F - 1.0 F | [blank]      | 0           | 0           | 0          |
      | Auto Brand low quantity thresshold | random product lp inbound inventory 30 api 2 | random sku lp inbound inventory 30 api 2 | 123123123123 | 123123123123 | random sku lp inbound inventory 30 api 2 | 10     | 1 unit/case | Plus1      | Plus1         | 1 day   | 1.0 F - 1.0 F | [blank]      | 0           | 0           | 0          |
      | Auto brand create product          | random product lp inbound inventory 30 api 1 | random sku lp inbound inventory 30 api 1 | 123123123123 | 123123123123 | random sku lp inbound inventory 30 api 1 | 10     | 1 unit/case | Plus1      | Plus1         | 1 day   | 1.0 F - 1.0 F | [blank]      | 0           | 0           | 0          |

  @LP_INBOUND_INVENTORY_31
  Scenario: Check displayed information on each inbound inventory in the list and in the details when ADMIN creates inbound inventory process Vendor add more SKUs
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                            | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inbound inventory 31 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inbound inventory 31 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 2946  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin delete order by sku of product "random product lp inbound inventory 31 api" by api
    And Admin search product name "random product lp inbound inventory 31 api" by api
    And Admin delete product name "random product lp inbound inventory 31 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                         | brand_id |
      | random product lp inbound inventory 31 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 31 api 1" of product ""
#    And Admin add SKU to Incoming Inventory api
#      | product_variant_id | vendor_company_id | quantity |
#      | random             | 1847              | 10       |
#    Brand 2
    And Create product by api with file "CreateProduct.json" and info
      | name                                         | brand_id |
      | random product lp inbound inventory 31 api 2 | 2946     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 31 api 2" of product ""
    And Admin add SKU to Incoming Inventory api
      | skuName                                  | product_variant_id | vendor_company_id | quantity |
      | random sku lp inbound inventory 31 api 1 | random             | 1847              | 10       |
      | random sku lp inbound inventory 31 api 2 | random             | 1847              | 10       |
    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 31 api 3" of product ""

    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And VENDOR Go to detail of inbound inventory have number: "create by api"
    And Vendor input info of inbound inventory
      | deliveryMethod      | estimatedDateArrival | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | trackingNumber | reference | totalWeight | zipCode |
      | Brand Self Delivery | currentDate          | [blank]   | [blank]          | 1              | 1                         | 1              | 1         | 1           | 11111   |
    And Edit info SKU of inbound inventory
      | index | sku                                      | caseOfSku | productLotCode                           | expiryDate |
      | 1     | random sku lp inbound inventory 31 api 1 | 10        | random sku lp inbound inventory 31 api 1 | Plus2      |
      | 1     | random sku lp inbound inventory 31 api 2 | 10        | random sku lp inbound inventory 31 api 2 | Plus2      |
#    And Add SKU to inbound inventory
#      | index | sku                                      | caseOfSku | productLotCode                           | expiryDate |
#      | 1     | random sku lp inbound inventory 31 api 3 | 10        | random sku lp inbound inventory 31 api 3 | Plus2      |
    And Vendor update request inbound inventory
    And Vendor check alert message
      | Inbound inventory updated successfully |
    #Approve inbound

#    And Admin Approve Incoming Inventory id "api" api

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Inbound Inventories" tab
    And Search Inbound inventory
      | number        | brand   | start   | end     | deliveryMethod |
      | create by api | [blank] | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number        | brand                              | eta         | pallets | cases | freightCarrier  |
      | create by api | Auto Brand low quantity thresshold | currentDate | 10      | 20    | Freight Carrier |
    And LP Check list of Inbound inventory
      | number        | brand                     | eta         | pallets | cases | freightCarrier  |
      | create by api | Auto brand create product | currentDate | 10      | 20    | Freight Carrier |
    And Search Inbound inventory
      | number  | brand                              | start   | end     | deliveryMethod |
      | [blank] | Auto Brand low quantity thresshold | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number        | brand                              | eta         | pallets | cases | freightCarrier  |
      | create by api | Auto Brand low quantity thresshold | currentDate | 10      | 20    | Freight Carrier |
    And LP Check list of Inbound inventory
      | number        | brand                     | eta         | pallets | cases | freightCarrier  |
      | create by api | Auto brand create product | currentDate | 10      | 20    | Freight Carrier |
    And Search Inbound inventory
      | number  | brand                     | start   | end     | deliveryMethod |
      | [blank] | Auto brand create product | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number        | brand                              | eta         | pallets | cases | freightCarrier  |
      | create by api | Auto Brand low quantity thresshold | currentDate | 10      | 20    | Freight Carrier |
    And LP Check list of Inbound inventory
      | number        | brand                     | eta         | pallets | cases | freightCarrier  |
      | create by api | Auto brand create product | currentDate | 10      | 20    | Freight Carrier |
    And LP go to Inbound inventory detail of number "create by api"
    And LP Check General Information of Inbound inventory
      | region              | vendorCompany       | status    | deliveryMethod      | lpReview | eta         | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | transportContactName | transportContactPhone | otherShippingDetail | freightCarrier | trackingNumber | referenceNumber | bol   |
      | Chicagoland Express | Auto vendor company | Confirmed | Brand Self Delivery | No       | currentDate | 10       | 1.0            | 20               | 1                         | -                    | -                     | Empty               | Empty          | 1              | 1               | Empty |
    And LP Check SKUs Information of Inbound inventory
      | brand                              | product                                      | nameSKU                                  | unitUpc      | caseUpc      | lotCode                                  | ofCase | pack        | expiryDate | receivingDate | storage | temperature   | caseReceived | caseDamaged | caseShorted | caseExcess |
#      | Auto Brand low quantity thresshold | random product lp inbound inventory 31 api 2 | random sku lp inbound inventory 31 api 3 | 123123123123 | 123123123123 | random sku lp inbound inventory 31 api 3 | 10     | 1 unit/case | Plus2      | currentDate   | 1 day   | 1.0 F - 1.0 F | [blank]      | 0           | 0           | 0          |
      | Auto Brand low quantity thresshold | random product lp inbound inventory 31 api 2 | random sku lp inbound inventory 31 api 2 | 123123123123 | 123123123123 | random sku lp inbound inventory 31 api 2 | 10     | 1 unit/case | Plus2      | currentDate   | 1 day   | 1.0 F - 1.0 F | [blank]      | 0           | 0           | 0          |
      | Auto brand create product          | random product lp inbound inventory 31 api 1 | random sku lp inbound inventory 31 api 1 | 123123123123 | 123123123123 | random sku lp inbound inventory 31 api 1 | 10     | 1 unit/case | Plus2      | currentDate   | 1 day   | 1.0 F - 1.0 F | [blank]      | 0           | 0           | 0          |

#    And LP download Inbound packing list "PDF"
#      | brand                              | inbound       |
#      | Auto Brand low quantity thresshold | create by api |
#    And LP download Inbound packing list "Excel"
#      | brand                              | inbound       |
#      | Auto Brand low quantity thresshold | create by api |
    And LP upload Signed WPL with file "10MBgreater.jpg"
    And LP check alert message
      | Maximum file size exceeded. |
    And LP upload Signed WPL with file "ImageInvalid.mp4"
    And LP check alert message
      | Invalid file type |
    And LP upload Signed WPL with file "ImageInvalid.mp4"
    And LP check alert message
      | Invalid file type |
    And LP upload Signed WPL with file "autotest.csv"
    And LP check alert message
      | Invalid file type |
    And LP upload Signed WPL with file "POD.png"
    And LP check alert message
      | Invalid file type |
    And LP upload Signed WPL with file "claim.jpg"
    And LP check alert message
      | Inbound inventory updated successfully. |
    And LP upload Signed WPL with file "BOL.pdf"
    And LP check alert message
      | Inbound inventory updated successfully. |
    And LP upload Signed WPL with file "ImageInvalid2.xlsx"
    And LP check alert message
      | Inbound inventory updated successfully. |

  @LP_WITHDRAW_INVENTORY_1
  Scenario: Check display of information on the Withdraw Inventory list page
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku lp withdraw inventory 1 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                            | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp withdraw inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp withdraw inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp withdraw inventory 1 api" by api
    And Admin search product name "random product lp withdraw inventory 1 api" by api
    And Admin delete product name "random product lp withdraw inventory 1 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                         | brand_id |
      | random product lp withdraw inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp withdraw inventory 1 api 1" of product ""

    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                                      | product_variant_id | quantity | lot_code                                 | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp withdraw inventory 1 api 1 | random             | 5        | random sku lp withdraw inventory 1 api 1 | 99           | Plus1        | Plus1       | [blank] |
#Create Withdraw
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                       | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku lp withdraw inventory 1 api 1 | 5        | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 26        | 1847              | currentDate | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request     |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | currentDate |
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate  | status    |
      | create by api | Auto brand create product | currentDate | Submitted |
    And LP search "Approved" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request     |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | currentDate |
    And LP search "Completed" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request     |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | currentDate |

    And LP search "All" withdrawal requests
      | number  | vendorCompany | brand   | region                   | request        |
      | [blank] | [blank]       | [blank] | Florida Express          | Plus1          |
      | [blank] | [blank]       | [blank] | Mid Atlantic Express     | Minus1         |
      | [blank] | [blank]       | [blank] | New York Express         | currentMonth+1 |
      | [blank] | [blank]       | [blank] | North California Express | currentMonth-1 |
      | [blank] | [blank]       | [blank] | South California Express | currentDate    |
      | [blank] | [blank]       | [blank] | Dallas Express           | currentDate    |
    And LP search "Submitted" withdrawal requests
      | number  | vendorCompany | brand   | region                   | request        |
      | [blank] | [blank]       | [blank] | Florida Express          | Plus1          |
      | [blank] | [blank]       | [blank] | Mid Atlantic Express     | Minus1         |
      | [blank] | [blank]       | [blank] | New York Express         | currentMonth+1 |
      | [blank] | [blank]       | [blank] | North California Express | currentMonth-1 |
      | [blank] | [blank]       | [blank] | South California Express | currentDate    |
      | [blank] | [blank]       | [blank] | Dallas Express           | currentDate    |
    And LP search "Approved" withdrawal requests
      | number  | vendorCompany | brand   | region                   | request        |
      | [blank] | [blank]       | [blank] | Florida Express          | Plus1          |
      | [blank] | [blank]       | [blank] | Mid Atlantic Express     | Minus1         |
      | [blank] | [blank]       | [blank] | New York Express         | currentMonth+1 |
      | [blank] | [blank]       | [blank] | North California Express | currentMonth-1 |
      | [blank] | [blank]       | [blank] | South California Express | currentDate    |
      | [blank] | [blank]       | [blank] | Dallas Express           | currentDate    |
    And LP search "Completed" withdrawal requests
      | number  | vendorCompany | brand   | region                   | request        |
      | [blank] | [blank]       | [blank] | Florida Express          | Plus1          |
      | [blank] | [blank]       | [blank] | Mid Atlantic Express     | Minus1         |
      | [blank] | [blank]       | [blank] | New York Express         | currentMonth+1 |
      | [blank] | [blank]       | [blank] | North California Express | currentMonth-1 |
      | [blank] | [blank]       | [blank] | South California Express | currentDate    |
      | [blank] | [blank]       | [blank] | Dallas Express           | currentDate    |
    And LP search "Submitted" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request     |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | currentDate |
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate  | status    |
      | create by api | Auto brand create product | currentDate | Submitted |
    And LP go to details withdrawal requests "create by api"
    Then LP verify pickup information in withdrawal requests detail
      | number        | status    | pickupDate  | startTime | endTime | region              | useFreight     | carrier             | bol     |
      | create by api | Submitted | currentDate | 00:30     | 01:00   | Chicagoland Express | Carrier Pickup | pickup_partner_name | BOL.pdf |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                     | product                                      | sku                                      | lotCode                                  | quantity | expiryDate | pallet | comment |
      | 1     | Auto brand create product | random product lp withdraw inventory 1 api 1 | random sku lp withdraw inventory 1 api 1 | random sku lp withdraw inventory 1 api 1 | 1        | Plus1      | 1      | comment |

    #approve withdrawal
    And Admin approve withdrawal request "create by api" by api
    Then LP go to back Withdrawal request from detail
    And LP search "Approved" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request     |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | currentDate |
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate  | status   |
      | create by api | Auto brand create product | currentDate | Approved |
    And LP go to details withdrawal requests "create by api"
    Then LP verify pickup information in withdrawal requests detail
      | number        | status   | pickupDate  | startTime | endTime | region              | useFreight     | carrier             | bol     |
      | create by api | Approved | currentDate | 00:30     | 01:00   | Chicagoland Express | Carrier Pickup | pickup_partner_name | BOL.pdf |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                     | product                                      | sku                                      | lotCode                                  | quantity | expiryDate | pallet | comment |
      | 1     | Auto brand create product | random product lp withdraw inventory 1 api 1 | random sku lp withdraw inventory 1 api 1 | random sku lp withdraw inventory 1 api 1 | 1        | Plus1      | 1      | comment |
#    Complete withdrawal
    And Admin complete withdrawal request "create by api" by api
    Then LP go to back Withdrawal request from detail
    And LP search "Completed" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request     |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | currentDate |
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate  | status    |
      | create by api | Auto brand create product | currentDate | Completed |
    And LP go to details withdrawal requests "create by api"
    Then LP verify pickup information in withdrawal requests detail
      | number        | status    | pickupDate  | startTime | endTime | region              | useFreight     | carrier             | bol     |
      | create by api | Completed | currentDate | 00:30     | 01:00   | Chicagoland Express | Carrier Pickup | pickup_partner_name | BOL.pdf |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                     | product                                      | sku                                      | lotCode                                  | quantity | expiryDate | pallet | comment |
      | 1     | Auto brand create product | random product lp withdraw inventory 1 api 1 | random sku lp withdraw inventory 1 api 1 | random sku lp withdraw inventory 1 api 1 | 1        | Plus1      | 1      | comment |

  @LP_WITHDRAW_INVENTORY_2  @LP_WITHDRAW_INVENTORY_5
  Scenario: Check display of information on the Withdraw Inventory list page 2
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku lp withdraw inventory 1 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                            | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp withdraw inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp withdraw inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp withdraw inventory 1 api" by api
    And Admin search product name "random product lp withdraw inventory 1 api" by api
    And Admin delete product name "random product lp withdraw inventory 1 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                         | brand_id |
      | random product lp withdraw inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp withdraw inventory 1 api 1" of product ""

    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                                      | product_variant_id | quantity | lot_code                                 | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp withdraw inventory 1 api 1 | random             | 5        | random sku lp withdraw inventory 1 api 1 | 99           | Plus1        | Plus1       | [blank] |
#Create Withdraw
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                       | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku lp withdraw inventory 1 api 1 | 5        | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 26        | 1847              | currentDate | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |
     #approve withdrawal
    And Admin approve withdrawal request "create by api" by api
    #    Complete withdrawal
    And Admin complete withdrawal request "create by api" by api

    Given NGOC_ADMIN_04 open web admin
    When NGOC_ADMIN_04 login to web with role Admin
    Then NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName                                  | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | random sku lp withdraw inventory 1 api 1 | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | productName                                  | skuName                                  | lotCode                                  | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter            | vendorCompany       | region | createdBy |
      | random product lp withdraw inventory 1 api 1 | random sku lp withdraw inventory 1 api 1 | random sku lp withdraw inventory 1 api 1 | 5                | 4               | 4        | 0            | [blank]    | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution CHI 01 | Auto vendor company | CHI    | Admin     |
    And Admin see detail inventory with lotcode
      | index | skuName                                  | lotCode                                  |
      | 1     | random sku lp withdraw inventory 1 api 1 | random sku lp withdraw inventory 1 api 1 |
    Then Verify inventory detail
      | product                                      | sku                                      | createdBy | region              | distributionCenter            | receiveDate | expireDate | pullDate | lotCode                                  | originalQty | currentQty | endQty |
      | random product lp withdraw inventory 1 api 1 | random sku lp withdraw inventory 1 api 1 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | Plus1       | [blank]    | [blank]  | random sku lp withdraw inventory 1 api 1 | 5           | 4          | 4      |
    And Verify subtraction item on inventory
      | quantity | category  | description                 | date        | order   |
      | 1        | Will call | Created by withdraw request | currentDate | [blank] |
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number  | vendorCompany | brand   | region  | request |
      | [blank] | [blank]       | [blank] | [blank] | [blank] |
    And LP check 12 number record on pagination
    And LP click "2" on pagination
    And LP click "back" on pagination
    And LP check 12 number record on pagination
    And LP click "next" on pagination
    And LP click "1" on pagination

    And LP search withdrawal request with all filter
      | number        | brand                     | requestFrom | requestTo | vendorCompany       | region              |
      | create by api | Auto brand create product | currentDate | Plus1     | Auto vendor company | Chicagoland Express |
    And LP close search all filters withdrawal
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate  | status    |
      | create by api | Auto brand create product | currentDate | Completed |
    And LP search withdrawal request with all filter
      | number  | brand   | requestFrom | requestTo | vendorCompany | region  |
      | [blank] | [blank] | [blank]     | [blank]   | Plus1         | [blank] |
    And LP close search all filters withdrawal
    And  LP verify no found result withdrawal requests after search
    And LP search withdrawal request with all filter
      | number  | brand   | requestFrom | requestTo | vendorCompany | region  |
      | [blank] | [blank] | [blank]     | [blank]   | [blank]       | [blank] |
    And LP clear search all filters withdrawal

    And LP search "All" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request     |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | currentDate |
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate  | status    |
      | create by api | Auto brand create product | currentDate | Completed |
    And LP search "Approved" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request     |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | currentDate |
    And  LP verify no found result withdrawal requests after search
    And LP search "Submitted" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request     |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | currentDate |
    And  LP verify no found result withdrawal requests after search
    And LP search "Completed" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request     |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | currentDate |
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate  | status    |
      | create by api | Auto brand create product | currentDate | Completed |
    And LP go to details withdrawal requests "create by api"
    Then LP verify pickup information in withdrawal requests detail
      | number        | status    | pickupDate  | startTime | endTime | region              | useFreight     | carrier             | bol     |
      | create by api | Completed | currentDate | 00:30     | 01:00   | Chicagoland Express | Carrier Pickup | pickup_partner_name | BOL.pdf |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                     | product                                      | sku                                      | lotCode                                  | quantity | expiryDate | pallet | comment |
      | 1     | Auto brand create product | random product lp withdraw inventory 1 api 1 | random sku lp withdraw inventory 1 api 1 | random sku lp withdraw inventory 1 api 1 | 1        | Plus1      | 1      | comment |

  @LP_WITHDRAW_INVENTORY_6
  Scenario: Check display of information on the Withdraw Inventory list page A Withdrawal request is created by vendor, approved by admin then completed by LP
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku lp withdraw inventory 6 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                            | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp withdraw inventory 6 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp withdraw inventory 6 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp withdraw inventory 6 api" by api
    And Admin search product name "random product lp withdraw inventory 6 api" by api
    And Admin delete product name "random product lp withdraw inventory 6 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                         | brand_id |
      | random product lp withdraw inventory 6 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp withdraw inventory 6 api 1" of product ""

    And Admin create inventory api1
      | index | sku                                      | product_variant_id | quantity | lot_code                                 | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp withdraw inventory 6 api 1 | random             | 5        | random sku lp withdraw inventory 6 api 1 | 99           | Plus1        | Plus1       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region              | carrier     | nameContact  | palletWeight | comment | bol          |
      | Plus6      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Name contact | 10           | comment | data/BOL.pdf |
    And Vendor add new sku with lot code to withdrawal request
      | index | sku                                      | lotCode                                  | lotQuantity | max     |
      | 1     | random sku lp withdraw inventory 6 api 1 | random sku lp withdraw inventory 6 api 1 | 2           | [blank] |
    And Vendor click create withdrawal request

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                     | pickupDate | status    |
      | random | Auto brand create product | Plus6      | Submitted |
    And LP search "Submitted" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                     | pickupDate | status    |
      | random | Auto brand create product | Plus6      | Submitted |
    And LP search "Approved" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    And  LP verify no found result withdrawal requests after search
    And LP search "Completed" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    And  LP verify no found result withdrawal requests after search

       #approve withdrawal
    And Admin approve withdrawal request "create by vendor" by api

    And LP search "All" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                     | pickupDate | status   |
      | random | Auto brand create product | Plus6      | Approved |
    And LP search "Approved" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                     | pickupDate | status   |
      | random | Auto brand create product | Plus6      | Approved |
    And LP search "Submitted" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    And  LP verify no found result withdrawal requests after search
    And LP search "Completed" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    And  LP verify no found result withdrawal requests after search

       #    Complete withdrawal
    And Admin complete withdrawal request "create by vendor" by api

    And LP search "All" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                     | pickupDate | status    |
      | random | Auto brand create product | Plus6      | Completed |
    And LP search "Approved" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    And  LP verify no found result withdrawal requests after search
    And LP search "Submitted" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    And  LP verify no found result withdrawal requests after search
    And LP search "Completed" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                     | pickupDate | status    |
      | random | Auto brand create product | Plus6      | Completed |

  @LP_WITHDRAW_INVENTORY_21
  Scenario: Check display of information on the Withdraw Inventory list page 3
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku lp withdraw inventory 21 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp withdraw inventory 21 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp withdraw inventory 21 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp withdraw inventory 21 api" by api
    And Admin search product name "random product lp withdraw inventory 21 api" by api
    And Admin delete product name "random product lp withdraw inventory 21 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                          | brand_id |
      | random product lp withdraw inventory 21 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp withdraw inventory 21 api 1" of product ""

    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                                       | product_variant_id | quantity | lot_code                                  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp withdraw inventory 21 api 1 | random             | 5        | random sku lp withdraw inventory 21 api 1 | 99           | Plus1        | Plus1       | [blank] |
#Create Withdrawal
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                        | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku lp withdraw inventory 21 api 1 | 5        | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment | index |
      | 26        | 1847              | currentDate | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    | 1     |
#    Record 2
    And Admin create withdraw request api2
      | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name  | pallet_weight | comment | attachment | index |
      | 26        | 1847              | Plus1       | 00:30      | 01:00    | carrier_pickup | pickup_partner_name2 | 1             | comment | BOL.pdf    | 2     |
#    Record 3
    And Admin create withdraw request api2
      | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name  | pallet_weight | comment | attachment | index |
      | 26        | 1847              | Minus2      | 00:30      | 01:00    | carrier_pickup | pickup_partner_name3 | 1             | comment | BOL.pdf    | 3     |
#    Record 4
    And Admin create withdraw request api2
      | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name  | pallet_weight | comment | attachment | index |
      | 26        | 1847              | Minus1      | 00:30      | 01:00    | carrier_pickup | pickup_partner_name4 | 1             | comment | BOL.pdf    | 4     |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number  | vendorCompany       | brand                     | region              | request |
      | [blank] | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate  | status    | index |
      | create by api | Auto brand create product | currentDate | Submitted | 1     |
      | create by api | Auto brand create product | Plus1       | Submitted | 2     |
      | create by api | Auto brand create product | Minus2      | Submitted | 3     |
      | create by api | Auto brand create product | Minus1      | Submitted | 4     |
    And LP search "Submitted" withdrawal requests
      | number  | vendorCompany       | brand                     | region              | request |
      | [blank] | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate  | status    | index |
      | create by api | Auto brand create product | currentDate | Submitted | 1     |
      | create by api | Auto brand create product | Plus1       | Submitted | 2     |
      | create by api | Auto brand create product | Minus2      | Submitted | 3     |
      | create by api | Auto brand create product | Minus1      | Submitted | 4     |

#    Given NGOCTX_04 login web admin by api
#      | email                | password  |
#      | ngoctx04@podfoods.co | 12345678a |
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku lp withdraw inventory 21 api 1" by api
     # Delete inventory
#    And Admin search inventory by API
#      | q[product_variant_name] | q[product_name]                             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
#      | [blank]                 | random product lp withdraw inventory 21 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
#    And Admin get ID inventory by product "random product lp withdraw inventory 21 api" from API
#    And Admin delete all subtraction of list inventory
#    And Admin delete inventory "all" by API
#    And Admin search product name "random product lp withdraw inventory 21 api" by api
#    And Admin delete product name "random product lp withdraw inventory 21 api" by api

  #Check not found page
    And LP go to details withdrawal requests "create by api"
#    And LP check page missing

  @LP_WITHDRAW_INVENTORY_23 @LP_WITHDRAW_INVENTORY_32
  Scenario: Check displayed information on each Withdrawal request in the list and in the details
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku lp withdraw inventory 23 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp withdraw inventory 23 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp withdraw inventory 23 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp withdraw inventory 23 api" by api
    And Admin search product name "random product lp withdraw inventory 23 api" by api
    And Admin delete product name "random product lp withdraw inventory 23 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                          | brand_id |
      | random product lp withdraw inventory 23 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp withdraw inventory 23 api 1" of product ""

    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                                       | product_variant_id | quantity | lot_code                                  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp withdraw inventory 23 api 1 | random             | 5        | random sku lp withdraw inventory 23 api 1 | 99           | Plus1        | Plus1       | [blank] |
#Create Withdrawal
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                        | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku lp withdraw inventory 23 api 1 | 5        | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 26        | 1847              | currentDate | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate  | status    |
      | create by api | Auto brand create product | currentDate | Submitted |
    And LP go to details withdrawal requests "create by api"
    Then LP verify pickup information in withdrawal requests detail
      | number        | status    | pickupDate  | startTime | endTime | region              | useFreight     | carrier             | bol     |
      | create by api | Submitted | currentDate | 00:30     | 01:00   | Chicagoland Express | Carrier Pickup | pickup_partner_name | BOL.pdf |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                     | product                                       | sku                                       | lotCode                                   | quantity | expiryDate | pallet | comment |
      | 1     | Auto brand create product | random product lp withdraw inventory 23 api 1 | random sku lp withdraw inventory 23 api 1 | random sku lp withdraw inventory 23 api 1 | 1        | Plus1      | 1      | comment |

    And Check field "Pickup date" is enable
    And Check field "Pickup time (Start)" is enable
    And Check field "Pickup time (End)" is enable
    And Check field "Pickup region" is disabled
    And Check field "Are you using a freight carrier?" is disabled
    And Check field "Carrier" is disabled
    And Check field "Expiry date" is disabled
    And Check field "Pallet weight in total" is disabled
    And Check field "Comment" is disabled
    And Check button "UPDATE" is enabled

       #approve withdrawal
    And Admin approve withdrawal request "create by api" by api

    And LP go to back Withdrawal request from detail
    And LP search "All" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    And LP go to details withdrawal requests "create by api"
    And LP download WPL "create by api" and brand "Auto brand create product"
    And LP check content WPL Export
      | number        | brandId | brand                     | product                                       | sku                                       | itemCode      | quantity | casePack | unitUPC      | caseUPC      | minTemperature | maxTemperature | expirationDate |
      | create by api | 3018    | Auto brand create product | random product lp withdraw inventory 23 api 1 | random sku lp withdraw inventory 23 api 1 | create by api | 1        | 1        | 123123123123 | 123123123123 | 1.0            | 1.0            | Plus1          |

    Then LP verify pickup information in withdrawal requests detail
      | number        | status   | pickupDate  | startTime | endTime | region              | useFreight     | carrier             | bol     |
      | create by api | Approved | currentDate | 00:30     | 01:00   | Chicagoland Express | Carrier Pickup | pickup_partner_name | BOL.pdf |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                     | product                                       | sku                                       | lotCode                                   | quantity | expiryDate | pallet | comment |
      | 1     | Auto brand create product | random product lp withdraw inventory 23 api 1 | random sku lp withdraw inventory 23 api 1 | random sku lp withdraw inventory 23 api 1 | 1        | Plus1      | 1      | comment |

    And Check field "Pickup date" is enable
    And Check field "Pickup time (Start)" is enable
    And Check field "Pickup time (End)" is enable
    And Check field "Pickup region" is disabled
    And Check field "Are you using a freight carrier?" is disabled
    And Check field "Carrier" is disabled
    And Check field "Expiry date" is disabled
    And Check field "Pallet weight in total" is disabled
    And Check field "Comment" is disabled
    And Check button "UPDATE" is enabled
    And Check button "COMPLETE" is enabled

#    And LP edit field in withdrawal requests detail
#      | pickupDate | startTime | endTime |
#      | [blank]    | [blank]   | [blank] |
    And LP remove value on Input "Pickup date"
    And LP remove value on Input "Pickup time (Start)"
    And LP remove value on Input "Pickup time (End)"
    And LP check error message is showing of fields
      | field               | message                         |
      | Pickup date         | Please enter pickup date        |
      | Pickup time (Start) | Please select pickup start time |
      | Pickup time (End)   | Please select pickup end time   |
    And Click on button "UPDATE"

    And LP go to back Withdrawal request from detail
    And LP search "All" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    And LP go to details withdrawal requests "create by api"
    Then LP verify pickup information in withdrawal requests detail
      | number        | status   | pickupDate  | startTime | endTime | region              | useFreight     | carrier             | bol     |
      | create by api | Approved | currentDate | 00:30     | 01:00   | Chicagoland Express | Carrier Pickup | pickup_partner_name | BOL.pdf |

    And LP update success withdrawal request
    And LP edit field in withdrawal requests detail
      | pickupDate  | startTime | endTime |
      | currentDate | 09:00     | [blank] |
    And Click on button "UPDATE"
    And LP check alert message
      | Start time must less than end time |
    And Click on button "COMPLETE"
    And Click on dialog button "Yes"
    And LP check alert message
      | Start time must less than end time |
    And LP edit field in withdrawal requests detail
      | pickupDate  | startTime | endTime |
      | currentDate | 09:00     | 09:30   |
    And Click on button "UPDATE"
    And LP check alert message
      | Withdrawal inventory updated successfully. |
    And Check field "Pickup date" is enable
    And Check field "Pickup time (Start)" is enable
    And Check field "Pickup time (End)" is enable
    And Click on button "COMPLETE"
    And Click on dialog button "Yes"
    And LP check alert message
      | Request marked as complete successfully. |
    Then LP verify pickup information in withdrawal requests detail
      | number        | status    | pickupDate  | startTime | endTime | region              | useFreight     | carrier             | bol     |
      | create by api | Completed | currentDate | 09:00     | 09:30   | Chicagoland Express | Carrier Pickup | pickup_partner_name | BOL.pdf |
    And Check field "Pickup date" is disabled
    And Check field "Pickup time (Start)" is disabled
    And Check field "Pickup time (End)" is disabled
    And Check field "Pickup region" is disabled
    And Check field "Are you using a freight carrier?" is disabled
    And Check field "Carrier" is disabled
    And Check field "Expiry date" is disabled
    And Check field "Pallet weight in total" is disabled
    And Check field "Comment" is disabled
    And Check any button "not" showing on screen
      | UPDATE   |
      | COMPLETE |

    And LP go to back Withdrawal request from detail
    And LP search "All" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate  | status    |
      | create by api | Auto brand create product | currentDate | Completed |
    And LP search "Completed" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate  | status    |
      | create by api | Auto brand create product | currentDate | Completed |

  @LP_WITHDRAW_INVENTORY_26
  Scenario: Check displayed information on each Withdrawal request in the list and in the details When Vendor create an Approved Withdrawal request with multiple Lot codes:
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku lp withdraw inventory 26 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp withdraw inventory 26 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp withdraw inventory 26 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp withdraw inventory 26 api" by api
    And Admin search product name "random product lp withdraw inventory 26 api" by api
    And Admin delete product name "random product lp withdraw inventory 26 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                          | brand_id |
      | random product lp withdraw inventory 26 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp withdraw inventory 26 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp withdraw inventory 26 api 1 | random             | 5        | random   | 99           | Plus1        | Plus1       | [blank] |
    And Admin create inventory api1
      | index | sku                                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 2     | random sku lp withdraw inventory 26 api 1 | random             | 5        | random   | 99           | Plus1        | Plus1       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region              | carrier     | nameContact  | palletWeight | comment | bol          |
      | Plus7      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Name contact | 10           | comment | data/BOL.pdf |

    And Vendor add new lot code to withdrawal request
      | index | sku                                       | lotCode | lotQuantity | max     |
      | 1     | random sku lp withdraw inventory 26 api 1 | random  | 2           | [blank] |
      | 2     | random sku lp withdraw inventory 26 api 1 | random  | 3           | [blank] |
    And Vendor input lot code info to withdrawal request
      | index | sku                                       | lotCode | lotQuantity | max     |
      | 1     | random sku lp withdraw inventory 26 api 1 | random  | 2           | [blank] |
      | 2     | random sku lp withdraw inventory 26 api 1 | random  | 3           | [blank] |
    And Vendor click create withdrawal request

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                     | pickupDate | status    |
      | random | Auto brand create product | Plus7      | Submitted |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status    | pickupDate | startTime | endTime | region              | useFreight  | nameContact  | bol     |
      | random | Submitted | Plus7      | 09:30     | 10:00   | Chicagoland Express | Self Pickup | Name contact | BOL.pdf |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                     | product                                       | sku                                       | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | Auto brand create product | random product lp withdraw inventory 26 api 1 | random sku lp withdraw inventory 26 api 1 | random  | 2        | Plus1      | 5      | comment |
      | 2     | Auto brand create product | random product lp withdraw inventory 26 api 1 | random sku lp withdraw inventory 26 api 1 | random  | 3        | Plus1      | 5      | comment |

    And Check field "Pickup date" is enable
    And Check field "Pickup time (Start)" is enable
    And Check field "Pickup time (End)" is enable
    And Check field "Pickup region" is disabled
    And Check field "Are you using a freight carrier?" is disabled
#    And Check field "Carrier" is disabled
#    And Check field "Expiry date" is disabled
    And Check field "Pallet weight in total" is disabled
    And Check field "Comment" is disabled
    And Check button "UPDATE" is enabled
#    And Check button "COMPLETE" is enabled
    And Check any button "not" showing on screen
      | COMPLETE |
       #approve withdrawal
    And Admin approve withdrawal request "create by vendor" by api
    And LP go to back Withdrawal request from detail
    And LP search "All" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status   | pickupDate | startTime | endTime | region              | useFreight  | nameContact  | bol     |
      | random | Approved | Plus7      | 09:30     | 10:00   | Chicagoland Express | Self Pickup | Name contact | BOL.pdf |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                     | product                                       | sku                                       | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | Auto brand create product | random product lp withdraw inventory 26 api 1 | random sku lp withdraw inventory 26 api 1 | random  | 2        | Plus1      | 5      | comment |
      | 2     | Auto brand create product | random product lp withdraw inventory 26 api 1 | random sku lp withdraw inventory 26 api 1 | random  | 3        | Plus1      | 5      | comment |

    And Check field "Pickup date" is enable
    And Check field "Pickup time (Start)" is enable
    And Check field "Pickup time (End)" is enable
    And Check field "Pickup region" is disabled
    And Check field "Are you using a freight carrier?" is disabled
#    And Check field "Carrier" is disabled
#    And Check field "Expiry date" is disabled
    And Check field "Pallet weight in total" is disabled
    And Check field "Comment" is disabled
    And Check button "UPDATE" is enabled
    And Check button "COMPLETE" is enabled
#    Complete withdrawal
    And Admin complete withdrawal request "create by vendor" by api
    Then LP go to back Withdrawal request from detail
    And LP search "All" withdrawal requests
      | number | vendorCompany       | brand                     | region              | request |
      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status    | pickupDate | startTime | endTime | region              | useFreight  | nameContact  | bol     |
      | random | Completed | Plus7      | 09:30     | 10:00   | Chicagoland Express | Self Pickup | Name contact | BOL.pdf |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                     | product                                       | sku                                       | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | Auto brand create product | random product lp withdraw inventory 26 api 1 | random sku lp withdraw inventory 26 api 1 | random  | 2        | Plus1      | 5      | comment |
      | 2     | Auto brand create product | random product lp withdraw inventory 26 api 1 | random sku lp withdraw inventory 26 api 1 | random  | 3        | Plus1      | 5      | comment |

    And Check field "Pickup date" is disabled
    And Check field "Pickup time (Start)" is disabled
    And Check field "Pickup time (End)" is disabled
    And Check field "Pickup region" is disabled
    And Check field "Are you using a freight carrier?" is disabled
#    And Check field "Carrier" is disabled
#    And Check field "Expiry date" is disabled
    And Check field "Pallet weight in total" is disabled
    And Check field "Comment" is disabled
    And Check any button "not" showing on screen
#      | UPDATE   |
      | COMPLETE |

  @LP_WITHDRAW_INVENTORY_27
  Scenario: Admin creates new Withdrawal request with the same Lot code more than once
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku lp withdraw inventory 27 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp withdraw inventory 27 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp withdraw inventory 27 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp withdraw inventory 27 api" by api
    And Admin search product name "random product lp withdraw inventory 27 api" by api
    And Admin delete product name "random product lp withdraw inventory 27 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                          | brand_id |
      | random product lp withdraw inventory 27 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp withdraw inventory 27 api 1" of product ""

    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                                       | product_variant_id | quantity | lot_code                                  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp withdraw inventory 27 api 1 | random             | 5        | random sku lp withdraw inventory 27 api 1 | 99           | Plus1        | Plus1       | [blank] |

      #Create Withdrawal
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                        | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku lp withdraw inventory 27 api 1 | 5        | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | index | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 1     | 26        | 1847              | currentDate | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |

    Given NGOC_ADMIN_04 open web admin
    When NGOC_ADMIN_04 login to web with role Admin
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin search withdraw request
      | number        | vendorCompany       | brand   | region  | status    | startDate   | endDate |
      | create by api | Auto vendor company | [blank] | [blank] | Submitted | currentDate | [blank] |
    And Admin go to detail withdraw request number "create by api"
    And Admin add same lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode                                   | case |
      | 1     | [blank]     | AT SKU Withdrawal 03 | [blank]     | random sku lp withdraw inventory 27 api 1 | 2    |

  @LP_WITHDRAW_INVENTORY_28
  Scenario: Check system response when LP complete a withdrawal request 0
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku lp withdraw inventory 28 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp withdraw inventory 28 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp withdraw inventory 28 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp withdraw inventory 28 api" by api
    And Admin search product name "random product lp withdraw inventory 28 api" by api
    And Admin delete product name "random product lp withdraw inventory 28 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                          | brand_id |
      | random product lp withdraw inventory 28 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp withdraw inventory 28 api 1" of product ""

    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                                       | product_variant_id | quantity | lot_code                                  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp withdraw inventory 27 api 1 | random             | 5        | random sku lp withdraw inventory 28 api 1 | 99           | Plus1        | Plus1       | [blank] |

      #Create Withdrawal
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                        | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku lp withdraw inventory 28 api 1 | 5        | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | index | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 1     | 26        | 1847              | Plus6       | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |
    #approve withdrawal
    And Admin approve withdrawal request "create by api" by api

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate | status   |
      | create by api | Auto brand create product | Plus6      | Approved |
    And LP go to details withdrawal requests "create by api"
    And Click on button "COMPLETE"
    And Click on dialog button "Yes"
    And LP check alert message
      | Request marked as complete successfully. |
    Then LP verify pickup information in withdrawal requests detail
      | number        | status    | pickupDate | startTime | endTime | region              | useFreight     | carrier             | bol     |
      | create by api | Completed | Plus6      | 00:30     | 01:00   | Chicagoland Express | Carrier Pickup | pickup_partner_name | BOL.pdf |
#Record 2
    And Admin create withdraw request api2
      | index | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 2     | 26        | 1847              | Plus6       | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |
    #approve withdrawal
    And Admin approve withdrawal request "create by api" by api
    Then LP go to back Withdrawal request from detail
    And LP search "All" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    And LP go to details withdrawal requests "create by api"

      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku lp withdraw inventory 28 api 1" by api

    And Click on button "COMPLETE"
    And Click on dialog button "Yes"
#    And LP check page missing

  @LP_WITHDRAW_INVENTORY_30
  Scenario: Check system response when LP complete a withdrawal request 2
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku lp withdraw inventory 30 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp withdraw inventory 30 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp withdraw inventory 30 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp withdraw inventory 30 api" by api
    And Admin search product name "random product lp withdraw inventory 30 api" by api
    And Admin delete product name "random product lp withdraw inventory 30 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                          | brand_id |
      | random product lp withdraw inventory 30 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp withdraw inventory 30 api 1" of product ""

    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                                       | product_variant_id | quantity | lot_code                                  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp withdraw inventory 30 api 1 | random             | 5        | random sku lp withdraw inventory 30 api 1 | 99           | Plus1        | Plus1       | [blank] |

      #Create Withdrawal
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                        | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku lp withdraw inventory 30 api 1 | 5        | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | index | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 1     | 26        | 1847              | Plus6       | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |
    #approve withdrawal
    And Admin approve withdrawal request "create by api" by api

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate | status   |
      | create by api | Auto brand create product | Plus6      | Approved |
    And LP go to details withdrawal requests "create by api"
    Then LP verify pickup information in withdrawal requests detail
      | number        | status   | pickupDate | startTime | endTime | region              | useFreight     | carrier             | bol     |
      | create by api | Approved | Plus6      | 00:30     | 01:00   | Chicagoland Express | Carrier Pickup | pickup_partner_name | BOL.pdf |

    And Change state of SKU id: "random sku lp withdraw inventory 30 api 1" to "draft"
    And Click on button "COMPLETE"
    And Click on dialog button "Yes"
    And LP check alert message
      | Request marked as complete successfully. |

  @LP_WITHDRAW_INVENTORY_31
  Scenario: Check system response when LP complete a withdrawal request 3
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
#      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1847                 | 3018        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku lp withdraw inventory 30 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp withdraw inventory 30 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp withdraw inventory 30 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp withdraw inventory 30 api" by api
    And Admin search product name "random product lp withdraw inventory 30 api" by api
    And Admin delete product name "random product lp withdraw inventory 30 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                          | brand_id |
      | random product lp withdraw inventory 30 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp withdraw inventory 30 api 1" of product ""

    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                                       | product_variant_id | quantity | lot_code                                  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp withdraw inventory 30 api 1 | random             | 5        | random sku lp withdraw inventory 30 api 1 | 99           | Plus1        | Plus1       | [blank] |

      #Create Withdrawal
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                        | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku lp withdraw inventory 30 api 1 | 5        | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | index | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 1     | 26        | 1847              | Plus6       | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |
    #approve withdrawal
    And Admin approve withdrawal request "create by api" by api

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number        | vendorCompany       | brand                     | region              | request |
      | create by api | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |

    Then LP verify result withdrawal requests after search
      | number        | brand                     | pickupDate | status   |
      | create by api | Auto brand create product | Plus6      | Approved |
    And LP go to details withdrawal requests "create by api"
    Then LP verify pickup information in withdrawal requests detail
      | number        | status   | pickupDate | startTime | endTime | region              | useFreight     | carrier             | bol     |
      | create by api | Approved | Plus6      | 00:30     | 01:00   | Chicagoland Express | Carrier Pickup | pickup_partner_name | BOL.pdf |

#    And Change state of SKU id: "random sku lp withdraw inventory 30 api 1" to "inactive"
    And Admin change state of product id "random" to inactive by api
    And Click on button "COMPLETE"
    And Click on dialog button "Yes"
    And LP check alert message
      | Request marked as complete successfully. |

#    Check Mail

  @LP_WITHDRAW_INVENTORY_33
  Scenario: Check email: Vendor create a Request withdrawal
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete withdrawal
#    And Admin search withdrawal by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
#      | [blank]   | 1774                 | 2811        | 26           | [blank]   | [blank]       | [blank]     |
#    And Admin delete all ID of withdrawal request of SKU "random sku lp withdraw inventory 33 api 1" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp withdraw inventory 33 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp withdraw inventory 33 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp withdraw inventory 33 api" by api
    And Admin search product name "random product lp withdraw inventory 33 api" by api
    And Admin delete product name "random product lp withdraw inventory 33 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                          | brand_id |
      | random product lp withdraw inventory 33 api 1 | 2811     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp withdraw inventory 33 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp withdraw inventory 33 api 1 | random             | 5        | random   | 81           | Plus1        | Plus1       | [blank] |
#
    Given VENDOR open web user
    When login to beta web with email "bao@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region              | carrier     | nameContact  | palletWeight | comment | bol          |
      | Plus7      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Name contact | 10           | comment | data/BOL.pdf |

    And Vendor add new lot code to withdrawal request
      | index | sku                                       | lotCode | lotQuantity | max     |
      | 1     | random sku lp withdraw inventory 33 api 1 | random  | 2           | [blank] |
    And Vendor input lot code info to withdrawal request
      | index | sku                                       | lotCode | lotQuantity | max     |
      | 1     | random sku lp withdraw inventory 33 api 1 | random  | 2           | [blank] |
    And Vendor click create withdrawal request
#
    Given USER_EMAIL_INVENTORY open login gmail with email "qa@podfoods.co" pass "12345678a"
    And USER_EMAIL_INVENTORY search email with sender "to:qa+inventory@podfoods.co"
    And QA go to first email with title ""
    And Verify submitted withdrawal Inventory email
      | number        | brand          | region              |
      | create by api | Auto Brand Bao | Chicagoland Express |

    And Admin approve withdrawal request "create by vendor" by api
#
    Given USER_EMAIL_INVENTORY_LP open login gmail with email "bao@podfoods.co" pass "Baovip99"
    And USER_EMAIL_INVENTORY_LP search email with sender "from:qa+inventory@podfoods.co "
    And QA go to first email with title ""
    And Verify approved withdrawal Inventory email to LP
      | number        | name |
      | create by api | Auto |
    And Switch to tab by title "Login - Pod Foods | Online Distribution Platform for Emerging Brands"

#    Given USER_LP open web LP
#    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
#    And USER_LP Navigate to "Inventory" by sidebar
#    And Lp go to "Withdraw Inventory" tab
#    And LP search "All" withdrawal requests
#      | number | vendorCompany       | brand                     | region              | request |
#      | random | Auto vendor company | Auto brand create product | Chicagoland Express | [blank] |
#    Then LP verify result withdrawal requests after search
#      | number | brand                     | pickupDate | status    |
#      | random | Auto brand create product | Plus6      | Submitted |
#    And LP go to details withdrawal requests ""
#    Then LP verify pickup information in withdrawal requests detail
#      | number | status    | pickupDate | startTime | endTime | region              | useFreight  | nameContact  | bol     |
#      | random | Submitted | Plus6      | 09:30     | 10:00   | Chicagoland Express | Self Pickup | Name contact | BOL.pdf |

  @LP_INBOUND_INVENTORY_24_1
  Scenario: Check email: Vendor create a Inbound
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp inbound inventory 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp inbound inventory 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    And Admin delete order by sku of product "random product lp inbound inventory 1 api" by api
    And Admin search product name "random product lp inbound inventory 1 api" by api
    And Admin delete product name "random product lp inbound inventory 1 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                        | brand_id |
      | random product lp inbound inventory 1 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp inbound inventory 1 api 1" of product ""

    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 81           |

#Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                                      | lot_code                                 | quantity | expiry_date |
      | random sku lp inbound inventory 23 api 1 | random sku lp inbound inventory 23 api 1 | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
##    Approve inbound
#    And Admin Approve Incoming Inventory id "api" api

    Given USER_EMAIL open login gmail with email "bao@podfoods.co" pass "Baovip99"
    Then USER_EMAIL search email with value "qa+inventory@podfoods.co"
    And QA go to first email with title ""
    And Verify approved Inbound Inventory in LP email
      | brand                     | eta         |
      | Auto brand create product | currentDate |

  @LP_DONATE_DISPOSE_INVENTORY_1
  Scenario: Check display of information on the Donate / Dispose Inventory list page
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Donate/Dispose Inventory" tab
    And LP search "All" dispose donate inventory
      | number  | vendorCompany       | brand                     | type     | region                   |
      | 123     | Auto vendor company | Auto brand create product | Donation | Chicagoland Express      |
      | [blank] | [blank]             | [blank]                   | Disposal | Florida Express          |
      | [blank] | [blank]             | [blank]                   | [blank]  | Mid Atlantic Express     |
      | [blank] | [blank]             | [blank]                   | [blank]  | New York Express         |
      | [blank] | [blank]             | [blank]                   | [blank]  | North California Express |
      | [blank] | [blank]             | [blank]                   | [blank]  | South California Express |
      | [blank] | [blank]             | [blank]                   | [blank]  | Dallas Express           |
    And LP input invalid "Brand"
      | value                                |
      | Auto brand create product invalid123 |
    And LP input invalid "Type"
      | value |
      | Auto  |
    And LP input invalid "Region"
      | value |
      | Auto  |
    And LP search "Approved" dispose donate inventory
      | number  | vendorCompany       | brand                     | type     | region                   |
      | 123     | Auto vendor company | Auto brand create product | Donation | Chicagoland Express      |
      | [blank] | [blank]             | [blank]                   | Disposal | Florida Express          |
      | [blank] | [blank]             | [blank]                   | [blank]  | Mid Atlantic Express     |
      | [blank] | [blank]             | [blank]                   | [blank]  | New York Express         |
      | [blank] | [blank]             | [blank]                   | [blank]  | North California Express |
      | [blank] | [blank]             | [blank]                   | [blank]  | South California Express |
      | [blank] | [blank]             | [blank]                   | [blank]  | Dallas Express           |
    And LP input invalid "Brand"
      | value                                |
      | Auto brand create product invalid123 |
    And LP input invalid "Type"
      | value |
      | Auto  |
    And LP input invalid "Region"
      | value |
      | Auto  |
    And LP search "Completed" dispose donate inventory
      | number  | vendorCompany       | brand                     | type     | region                   |
      | 123     | Auto vendor company | Auto brand create product | Donation | Chicagoland Express      |
      | [blank] | [blank]             | [blank]                   | Disposal | Florida Express          |
      | [blank] | [blank]             | [blank]                   | [blank]  | Mid Atlantic Express     |
      | [blank] | [blank]             | [blank]                   | [blank]  | New York Express         |
      | [blank] | [blank]             | [blank]                   | [blank]  | North California Express |
      | [blank] | [blank]             | [blank]                   | [blank]  | South California Express |
      | [blank] | [blank]             | [blank]                   | [blank]  | Dallas Express           |
    And LP input invalid "Brand"
      | value                                |
      | Auto brand create product invalid123 |
    And LP input invalid "Type"
      | value |
      | Auto  |
    And LP input invalid "Region"
      | value |
      | Auto  |

  @LP_DONATE_DISPOSE_INVENTORY_2
  Scenario: Check display condition of a Donate / Dispose Inventory in the list
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete dispose donate request
    And Admin search dispose donate request by API
      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[request_type] | q[status] | q[start_date] | q[end_date] | page |
      | [blank]   | 1847                 | [blank]     | [blank]      | [blank]         | [blank]   | [blank]       | [blank]     | 1    |
    And Admin delete all inventory request by API
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp donate inventory api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp donate inventory api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp donate inventory api" by api
    And Admin search product name "random product lp donate inventory api" by api
    And Admin delete product name "random product lp donate inventory api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product lp donate inventory api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp donate inventory 27 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                     | product_variant_id | quantity | lot_code                                | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp donate inventory 27 api 1 | random             | 5        | random sku lp donate inventory 27 api 1 | 99           | Plus1        | Plus1       | [blank] |

    And Admin set inventory request items API
      | sku                                     | inventory_id  | product_variant_id | request_case |
      | random sku lp donate inventory 27 api 1 | create by api | create by api      | 1            |
    And Admin create dispose donate request by API
      | comment      | region_id | request_type | vendor_company_id |
      | Auto comment | 26        | donation     | 1847              |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Donate/Dispose Inventory" tab
    And LP search "All" dispose donate inventory
      | number        | vendorCompany | brand   | type    | region  |
      | create by api | [blank]       | [blank] | [blank] | [blank] |
    And Check any text "is" showing on screen
      | No data found...              |
      | We couldn't find any matches. |
    And LP search "Approved" dispose donate inventory
      | number        | vendorCompany | brand   | type    | region  |
      | create by api | [blank]       | [blank] | [blank] | [blank] |
    And Check any text "is" showing on screen
      | No data found...              |
      | We couldn't find any matches. |
    And LP search "Completed" dispose donate inventory
      | number        | vendorCompany | brand   | type    | region  |
      | create by api | [blank]       | [blank] | [blank] | [blank] |
    And Check any text "is" showing on screen
      | No data found...              |
      | We couldn't find any matches. |
#    Approved Donate
    And Admin approved dispose donate request by API
    And USER_LP refresh browser
    And LP search "All" dispose donate inventory
      | number        | vendorCompany | brand   | type    | region  |
      | create by api | [blank]       | [blank] | [blank] | [blank] |
    Then LP verify result Dispose Donate inventory after search
      | number        | brand                     | type     | status   |
      | create by api | Auto brand create product | Donation | Approved |
    And LP search "All" dispose donate inventory
      | number        | vendorCompany       | brand                     | type     | region              |
      | create by api | Auto vendor company | Auto brand create product | Donation | Chicagoland Express |
    Then LP verify result Dispose Donate inventory after search
      | number        | brand                     | type     | status   |
      | create by api | Auto brand create product | Donation | Approved |
    And LP search "Approved" dispose donate inventory
      | number        | vendorCompany | brand   | type    | region  |
      | create by api | [blank]       | [blank] | [blank] | [blank] |
    Then LP verify result Dispose Donate inventory after search
      | number        | brand                     | type     | status   |
      | create by api | Auto brand create product | Donation | Approved |
    And LP search "Approved" dispose donate inventory
      | number        | vendorCompany       | brand                     | type     | region              |
      | create by api | Auto vendor company | Auto brand create product | Donation | Chicagoland Express |
    Then LP verify result Dispose Donate inventory after search
      | number        | brand                     | type     | status   |
      | create by api | Auto brand create product | Donation | Approved |
    And LP search "Completed" dispose donate inventory
      | number        | vendorCompany | brand   | type    | region  |
      | create by api | [blank]       | [blank] | [blank] | [blank] |
    And Check any text "is" showing on screen
      | No data found...              |
      | We couldn't find any matches. |
    And LP search "Completed" dispose donate inventory
      | number    | vendorCompany | brand   | type    | region  |
      | 230207782 | [blank]       | [blank] | [blank] | [blank] |
    Then LP verify result Dispose Donate inventory after search
      | number     | brand                       | type     | status    |
      | #230207782 | thang auto sample 127 brand | Disposal | Completed |
    And LP search "All" dispose donate inventory
      | number    | vendorCompany | brand   | type    | region  |
      | 230207782 | [blank]       | [blank] | [blank] | [blank] |
    Then LP verify result Dispose Donate inventory after search
      | number     | brand                       | type     | status    |
      | #230207782 | thang auto sample 127 brand | Disposal | Completed |
    And LP search "Approved" dispose donate inventory
      | number    | vendorCompany | brand   | type    | region  |
      | 230207782 | [blank]       | [blank] | [blank] | [blank] |
    And Check any text "is" showing on screen
      | No data found...              |
      | We couldn't find any matches. |


  @LP_DONATE_DISPOSE_INVENTORY_8
  Scenario: Check which criteria displayed on the Filters bar
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete dispose donate request
    And Admin search dispose donate request by API
      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[request_type] | q[status] | q[start_date] | q[end_date] | page |
      | [blank]   | 1847                 | [blank]     | [blank]      | [blank]         | [blank]   | [blank]       | [blank]     | 1    |
    And Admin delete all inventory request by API
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp donate inventory api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp donate inventory api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp donate inventory api" by api
    And Admin search product name "random product lp donate inventory api" by api
    And Admin delete product name "random product lp donate inventory api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product lp donate inventory api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp donate inventory 27 api 1" of product ""
    And Admin create inventory api1
      | index | sku                                     | product_variant_id | quantity | lot_code                                | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp donate inventory 27 api 1 | random             | 5        | random sku lp donate inventory 27 api 1 | 99           | Plus1        | Plus1       | [blank] |

    And Admin set inventory request items API
      | sku                                     | inventory_id  | product_variant_id | request_case |
      | random sku lp donate inventory 27 api 1 | create by api | create by api      | 1            |
    And Admin create dispose donate request by API
      | comment      | region_id | request_type | vendor_company_id |
      | Auto comment | 26        | disposal     | 1847              |
#    Approved Disposal
    And Admin approved dispose donate request by API

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Donate/Dispose Inventory" tab
    And LP search "All" dispose donate inventory
      | number        | vendorCompany       | brand                     | type     | region              |
      | create by api | Auto vendor company | Auto brand create product | Disposal | Chicagoland Express |
    Then LP verify result Dispose Donate inventory after search
      | number        | brand                     | type     | status   |
      | create by api | Auto brand create product | Disposal | Approved |
    And USER_LP clear filter on field "Number"
    And USER_LP clear filter on field "Vendor Company"
    And USER_LP clear filter on field "Brand"
    And USER_LP clear filter on field "Type"
    And USER_LP clear filter on field "Region"
    And LP search dispose donate with all filter
      | number        | vendorCompany       | brand                     | type     | region              | requestFrom | requestTo   |
      | create by api | Auto vendor company | Auto brand create product | Disposal | Chicagoland Express | currentDate | currentDate |
    And LP close search all filters donate
    Then LP verify result Dispose Donate inventory after search
      | number        | brand                     | type     | status   |
      | create by api | Auto brand create product | Disposal | Approved |
    And LP search dispose donate with all filter
      | number  | vendorCompany | brand   | type    | region  | requestFrom | requestTo |
      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]   |
    And LP clear search all filters donate
    And LP search dispose donate with all filter
      | number   | vendorCompany | brand   | type    | region  | requestFrom | requestTo |
      | 99999999 | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]   |
    And LP close search all filters donate
    And Check any text "is" showing on screen
      | No data found...              |
      | We couldn't find any matches. |
    And LP search dispose donate with all filter
      | number  | vendorCompany | brand   | type    | region  | requestFrom | requestTo |
      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]   |
    And USER_LP clear filter on field "Number"
    And LP close search all filters donate
    And LP search dispose donate with all filter
      | number  | vendorCompany | brand   | type     | region                   | requestFrom | requestTo |
      | [blank] | [blank]       | [blank] | Donation | [blank]                  | [blank]     | [blank]   |
      | [blank] | [blank]       | [blank] | Disposal | [blank]                  | [blank]     | [blank]   |
      | [blank] | [blank]       | [blank] | [blank]  | Chicagoland Express      | [blank]     | [blank]   |
      | [blank] | [blank]       | [blank] | [blank]  | Florida Express          | [blank]     | [blank]   |
      | [blank] | [blank]       | [blank] | [blank]  | Mid Atlantic Express     | [blank]     | [blank]   |
      | [blank] | [blank]       | [blank] | [blank]  | New York Express         | [blank]     | [blank]   |
      | [blank] | [blank]       | [blank] | [blank]  | North California Express | [blank]     | [blank]   |
      | [blank] | [blank]       | [blank] | [blank]  | South California Express | [blank]     | [blank]   |
      | [blank] | [blank]       | [blank] | [blank]  | Dallas Express           | [blank]     | [blank]   |
      | [blank] | [blank]       | [blank] | [blank]  | [blank]                  | Minus1      | [blank]   |
      | [blank] | [blank]       | [blank] | [blank]  | [blank]                  | Plus1       | [blank]   |
      | [blank] | [blank]       | [blank] | [blank]  | [blank]                  | [blank]     | Minus1    |
      | [blank] | [blank]       | [blank] | [blank]  | [blank]                  | [blank]     | Plus1     |
    And LP clear search all filters donate

  @LP_DONATE_DISPOSE_INVENTORY_23
  Scenario: Check the order of the Donate / Dispose request list
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete dispose donate request
    And Admin search dispose donate request by API
      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[request_type] | q[status] | q[start_date] | q[end_date] | page |
      | [blank]   | 1847                 | [blank]     | [blank]      | [blank]         | [blank]   | [blank]       | [blank]     | 1    |
    And Admin delete all inventory request by API
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp donate inventory api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp donate inventory api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp donate inventory api" by api
    And Admin search product name "random product lp donate inventory api" by api
    And Admin delete product name "random product lp donate inventory api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product lp donate inventory api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp donate inventory api 1" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code                                | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp donate inventory api 1 | random             | 5        | random sku lp donate inventory 27 api 1 | 99           | Plus1        | Plus1       | [blank] |

    And Admin set inventory request items API
      | sku                                  | inventory_id  | product_variant_id | request_case |
      | random sku lp donate inventory api 1 | create by api | create by api      | 1            |
    And Admin create dispose donate request by API
      | comment      | region_id | request_type | vendor_company_id |
      | Auto comment | 26        | disposal     | 1847              |
#    Approved Disposal
    And Admin approved dispose donate request by API

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Donate/Dispose Inventory" tab
    And LP search "All" dispose donate inventory
      | number        | vendorCompany       | brand                     | type     | region              |
      | create by api | Auto vendor company | Auto brand create product | Disposal | Chicagoland Express |
    Then LP verify result Dispose Donate inventory after search
      | number        | brand                     | type     | status   |
      | create by api | Auto brand create product | Disposal | Approved |
    And LP go to details dispose donate request "create by api"
    And LP verify details dispose donate request
      | number        | vendorCompany       | requestDate | status   | type     | date        | region              | document         |
      | create by api | Auto vendor company | currentDate | Approved | Disposal | currentDate | Chicagoland Express | Add new document |
    And LP verify items detail dispose donate request
      | sku                                  | skuID         | cases | lotcode                                 | brand                     | product                                  | image       | expiryDate | pullDate |
      | random sku lp donate inventory api 1 | create by api | 1     | random sku lp donate inventory 27 api 1 | Auto brand create product | random product lp donate inventory api 1 | anhJPG2.jpg | Plus1      | Minus54  |
    And LP add documents to dispose donate request
      | anhJPEG.jpg |
      | anhJPG2.jpg |
    And LP mark complete dispose donate request
    And LP verify details dispose donate request
      | number        | vendorCompany       | requestDate | status    | type     | date        | region              | document         |
      | create by api | Auto vendor company | currentDate | Completed | Disposal | currentDate | Chicagoland Express | Add new document |
    And LP verify items detail dispose donate request
      | sku                                  | skuID         | cases | lotcode                                 | brand                     | product                                  | image       | expiryDate | pullDate |
      | random sku lp donate inventory api 1 | create by api | 1     | random sku lp donate inventory 27 api 1 | Auto brand create product | random product lp donate inventory api 1 | anhJPG2.jpg | Plus1      | Minus54  |

  @LP_DONATE_DISPOSE_INVENTORY_24
  Scenario: Check displayed information on each Donate / Dispose request in the list and in the details
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
      # Delete dispose donate request
    And Admin search dispose donate request by API
      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[request_type] | q[status] | q[start_date] | q[end_date] | page |
      | [blank]   | 1847                 | [blank]     | [blank]      | [blank]         | [blank]   | [blank]       | [blank]     | 1    |
    And Admin delete all inventory request by API
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product lp donate inventory api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product lp donate inventory api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product lp donate inventory api" by api
    And Admin search product name "random product lp donate inventory api" by api
    And Admin delete product name "random product lp donate inventory api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                     | brand_id |
      | random product lp donate inventory api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp donate inventory api 1" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code                                | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp donate inventory api 1 | random             | 5        | random sku lp donate inventory 24 api 1 | 99           | Plus1        | Plus1       | [blank] |

#    SKU 2
    And Admin create a "active" SKU from admin with name "random sku lp donate inventory api 2" of product ""
    And Admin create inventory api1
      | index | sku                                  | product_variant_id | quantity | lot_code                                | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp donate inventory api 2 | random             | 5        | random sku lp donate inventory 24 api 2 | 99           | Plus1        | Plus1       | [blank] |
    And Admin set inventory request items API
      | index | sku                                  | inventory_id  | product_variant_id | request_case |
      | 1     | random sku lp donate inventory api 2 | create by api | create by api      | 5            |
      | 1     | random sku lp donate inventory api 1 | create by api | create by api      | 1            |

    And Admin create dispose donate request by API
      | comment      | region_id | request_type | vendor_company_id |
      | Auto comment | 26        | disposal     | 1847              |
#    Approved Disposal
    And Admin approved dispose donate request by API

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Donate/Dispose Inventory" tab
    And LP search "All" dispose donate inventory
      | number        | vendorCompany       | brand                     | type     | region              |
      | create by api | Auto vendor company | Auto brand create product | Disposal | Chicagoland Express |
    Then LP verify result Dispose Donate inventory after search
      | number        | brand                     | type     | status   |
      | create by api | Auto brand create product | Disposal | Approved |
    And LP go to details dispose donate request "create by api"
    And LP verify details dispose donate request
      | number        | vendorCompany       | requestDate | status   | type     | date        | region              | document         |
      | create by api | Auto vendor company | currentDate | Approved | Disposal | currentDate | Chicagoland Express | Add new document |
    And LP verify items detail dispose donate request
      | sku                                  | skuID         | cases | lotcode                                 | brand                     | product                                  | image       | expiryDate | pullDate |
      | random sku lp donate inventory api 1 | create by api | 1     | random sku lp donate inventory 24 api 1 | Auto brand create product | random product lp donate inventory api 1 | anhJPG2.jpg | Plus1      | Minus54  |
      | random sku lp donate inventory api 2 | create by api | 5     | random sku lp donate inventory 24 api 2 | Auto brand create product | random product lp donate inventory api 1 | anhJPG2.jpg | Plus1      | Minus54  |


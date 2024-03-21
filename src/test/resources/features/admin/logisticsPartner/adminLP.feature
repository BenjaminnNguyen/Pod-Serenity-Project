@feature=AdminLP
Feature: Admin logistics partner

  @AD_LP_COMPANIES_1
  Scenario: All LP companies list
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name            | contact_number | roles_name |
      | Auto create LP company 1 | [blank]        | [blank]    |
    And Admin delete lp company by api
    Then Admin create lp company by api
      | business_name            | contact_number | roles_name           |
      | Auto create LP company 1 | 0123456789     | driver , warehousing |

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "LP companies" by sidebar
    And Admin search LP company
      | businessName           | contactNumber | roles       |
      | Auto create LP company | 0123456789    | Warehousing |
    And Admin check LP company list
      | id            | businessName             | contactNumber | roles             |
      | create by api | Auto create LP company 1 | 0123456789    | DriverWarehousing |

    Then Admin create lp company by api
      | business_name            | contact_number | roles_name  |
      | Auto create LP company 2 | 0123456789     | warehousing |
    And Admin wait 2000 mini seconds
    And Admin refresh LP company list
    And Admin check LP company list
      | id            | businessName             | contactNumber | roles             |
      | create by api | Auto create LP company 2 | 0123456789    | Warehousing       |
      | create by api | Auto create LP company 1 | 0123456789    | DriverWarehousing |
    And Admin reset filter
    And Admin search LP company
      | businessName           | contactNumber | roles  |
      | Auto create LP company | 0123456789    | Driver |
    And Admin check LP company list
      | id            | businessName             | contactNumber | roles             |
      | create by api | Auto create LP company 1 | 0123456789    | DriverWarehousing |

  @AD_LP_COMPANIES_12
  Scenario: Check the Delete a LP company function
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name            | contact_number | roles_name |
      | Auto create LP company 1 | [blank]        | [blank]    |
    And Admin delete lp company by api
    Then Admin create lp company by api
      | business_name             | contact_number | roles_name |
      | Auto create LP company 12 | 0123456789     | driver     |

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "LP companies" by sidebar
    And Admin search LP company
      | businessName              | contactNumber | roles  |
      | Auto create LP company 12 | 0123456789    | Driver |
    And Admin check LP company list
      | id            | businessName              | contactNumber | roles  |
      | create by api | Auto create LP company 12 | 0123456789    | Driver |

    And Admin "Cancel" delete LP company "Auto create LP company 12"
    And Admin check LP company list
      | id            | businessName              | contactNumber | roles  |
      | create by api | Auto create LP company 12 | 0123456789    | Driver |

    And Admin "Understand & Continue" delete LP company "Auto create LP company 12"
    And Admin check LP company "Auto create LP company 12" not show on list

  @AD_LP_COMPANIES_6
  Scenario: Create new LP company form
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name          | contact_number | roles_name |
      | Auto create LP company | [blank]        | [blank]    |
    And Admin delete lp company by api

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "LP companies" by sidebar
    And Admin create LP company
      | businessName             | contactNumber | roles               |
      | Auto create LP company 6 | 0123456789    | Driver, Warehousing |
    And Admin check create LP company "Auto create LP company 6" success and "Back to LP companies list"
    And Admin check LP company list
      | id      | businessName             | contactNumber | roles             |
      | [blank] | Auto create LP company 6 | 0123456789    | DriverWarehousing |

    And Admin create LP company
      | businessName             | contactNumber | roles               |
      | Auto create LP company 7 | 0123456789    | Driver, Warehousing |
    And Admin check create LP company "Auto create LP company 7" success and "Create logistics partner for this LP company"
    And BAO_ADMIN7 check value of field
      | field      | value                    |
      | LP company | Auto create LP company 7 |
    And Admin create new logistics partner
      | firstName | lastName  | email                            | contactNumber | password  | lpCompany |
      | Auto      | CreateLP6 | ngoctx+autolpcreate6@podfoods.co | 0123456789    | 12345678a | [blank]   |
    And BAO_ADMIN7 navigate to "Logistics Partners" to "LP companies" by sidebar
    And Admin create LP company
      | businessName             | contactNumber | roles               |
      | Auto create LP company 6 | 0123456789    | Driver, Warehousing |
    And BAO_ADMIN7 check alert message
      | Business name has already been taken |

  @AD_LP_COMPANIES_13
  Scenario: Check the Delete a LP company function 2
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
     # Delete inventory
    And Admin delete order by sku of product "random product create lp 13" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product create lp 13 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product create lp 13" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product create lp 13" by api
    And Admin delete product name "" by api
    Then Admin search lp company by api
      | business_name          | contact_number | roles_name |
      | Auto create LP company | [blank]        | [blank]    |
    And Admin delete lp company by api
#    When Admin search distribution center "Auto create LP company warehouse 13" by api
#    And Admin delete distribution center "" by api

    Then Admin create lp company by api
      | business_name             | contact_number | roles_name          |
      | Auto create LP company 13 | 0123456789     | driver, warehousing |
    Then Admin create lp by api
      | first_name | last_name      | contact_number | email                             | password  | logistics_company_id |
      | Auto       | AutoCreateLP13 | 0123456789     | ngoctx+autolpcreate13@podfoods.co | 12345678a | create by api        |

    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | random product create lp 13 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku lp create lp 13" of product ""

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Regions" to "Distribution Centers" by sidebar
    And Admin verify default of create new distribution center
    And Admin verify error empty when create new distribution center
    And Admin fill info to create distribution center
      | region              | warehouse                 | timeZone                   | name                                | attn | street1            | street2  | city     | state    | zip   | phone      |
      | Chicagoland Express | Auto create LP company 13 | Pacific Time (US & Canada) | Auto create LP company warehouse 13 | 123  | 455 Madison Avenue | street 2 | New York | New York | 10022 | 1234567890 |
    And Admin create distribution center success

    When Admin search distribution center "Auto create LP company warehouse 13" by api
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin run job UpdateStorePreferredWarehouseJob with warehouse id "create by api" in sidekiq

#    Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code                   | warehouse_id  | receive_date | expiry_date | comment      |
      | 1     | random sku lp create lp 13 | random             | 5        | random sku lp create lp 13 | create by api | currentDate  | Plus1       | Auto comment |
#
    #Create order unfulfilled
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
  # Create purchase order
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | api                  |

    And BAO_ADMIN7 navigate to "Logistics Partners" to "LP companies" by sidebar
    And Admin search LP company
      | businessName              | contactNumber | roles  |
      | Auto create LP company 13 | 0123456789    | Driver |
    And Admin check LP company list
      | id            | businessName              | contactNumber | roles  |
      | create by api | Auto create LP company 13 | 0123456789    | Driver |

    And Admin "Understand & Continue" delete LP company "Auto create LP company 13"
    And BAO_ADMIN7 check alert message
      | This LP company could not be deleted because the LP company was assigned to at least 1 PO and/or owns a warehouse that was assigned to at least 1 line item before. You must delete all associated entities before deleting this one. |
    And Admin check LP company list
      | id            | businessName              | contactNumber | roles  |
      | create by api | Auto create LP company 13 | 0123456789    | Driver |

  # Delete inventory
    And Admin delete order by sku of product "random product create lp 13" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product create lp 13 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product create lp 13" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product create lp 13" by api
    And Admin delete product name "" by api
    Then Admin search lp company by api
      | business_name          | contact_number | roles_name |
      | Auto create LP company | [blank]        | [blank]    |
    And Admin delete lp company by api

  @AD_LP_COMPANIES_7
  Scenario: Create new LP company form - validate
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name                | contact_number | roles_name |
      | auto check create lp company | [blank]        | [blank]    |
    And Admin delete lp company by api

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "LP companies" by sidebar
    And Admin create LP company
      | businessName | contactNumber | roles   |
      | [blank]      | [blank]       | [blank] |
    And BAO_ADMIN7 check error message is showing of fields
      | field         | message                                           |
      | Business name | Please input business name for this LP company    |
      | Roles         | Please select at least 1 role for this LP company |
    And Admin create LP company
      | businessName | contactNumber | roles   |
      | [blank]      | 123456789     | [blank] |
    And BAO_ADMIN7 check error message is showing of fields
      | field          | message                                           |
      | Business name  | Please input business name for this LP company    |
      | Roles          | Please select at least 1 role for this LP company |
      | Contact number | Please enter a valid 10-digits phone number       |
    And Admin create LP company
      | businessName                 | contactNumber | roles  |
      | auto check create lp company | 1234567890    | Driver |
    And BAO_ADMIN7 check error message not showing of fields
      | field          | message                                           |
      | Business name  | Please input business name for this LP company    |
      | Roles          | Please select at least 1 role for this LP company |
      | Contact number | Please enter a valid 10-digits phone number       |

  @AD_LP_COMPANIES_22
  Scenario: LP company details page
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name             | contact_number | roles_name |
      | Auto create LP company 22 | [blank]        | [blank]    |
    And Admin delete lp company by api
    Then Admin create lp company by api
      | business_name              | contact_number | roles_name           |
      | Auto create LP company 221 | 0123456789     | driver , warehousing |
    Then Admin create lp company by api
      | business_name             | contact_number | roles_name           |
      | Auto create LP company 22 | 0123456789     | driver , warehousing |

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "LP companies" by sidebar
    And Admin search LP company
      | businessName              | contactNumber | roles   |
      | Auto create LP company 22 | 0123456789    | [blank] |
    And Admin check LP company list
      | id      | businessName              | contactNumber | roles             |
      | [blank] | Auto create LP company 22 | 0123456789    | DriverWarehousing |
    And Admin go to detail of LP company and check information
      | businessName              | contactNumber | roles             |
      | Auto create LP company 22 | 0123456789    | DriverWarehousing |
    And Admin click on field "Business name"
    And Click on tooltip button "Update"
    And Admin go to detail of LP company and check information
      | businessName              | contactNumber | roles             |
      | Auto create LP company 22 | 0123456789    | DriverWarehousing |
    And Admin click on field "Business name"
    And Click on tooltip button "Cancel"
    And Admin go to detail of LP company and check information
      | businessName              | contactNumber | roles             |
      | Auto create LP company 22 | 0123456789    | DriverWarehousing |
    And Admin click on field "Business name"
    And Admin enter text " " on text box tooltip
    And Click on tooltip button "Update"
    And BAO_ADMIN7 check alert message
      | Business name can't be blank |
    And Click on tooltip button "Cancel"
    And Admin go to detail of LP company and check information
      | businessName              | contactNumber | roles             |
      | Auto create LP company 22 | 0123456789    | DriverWarehousing |
    And Admin click on field "Business name"
    And Admin enter text "Auto create LP company 221" on text box tooltip
    And Click on tooltip button "Update"
    And BAO_ADMIN7 check alert message
      | Business name has already been taken |
    And Click on tooltip button "Cancel"
    And Admin go to detail of LP company and check information
      | businessName              | contactNumber | roles             |
      | Auto create LP company 22 | 0123456789    | DriverWarehousing |
#    Edit contact Number
    And Admin click on field "Contact number"
    And Admin enter text " " on text box tooltip
    And Click on tooltip button "Update"
    And Admin go to detail of LP company and check information
      | businessName              | contactNumber | roles             |
      | Auto create LP company 22 | Empty         | DriverWarehousing |
    And Admin click on field "Contact number"
    And Admin enter text "1" on text box tooltip
    And Click on tooltip button "Update"
    And BAO_ADMIN7 check alert message
      | Contact number is the wrong length (should be 10 characters) |
    And Admin go to detail of LP company and check information
      | businessName              | contactNumber | roles             |
      | Auto create LP company 22 | Empty         | DriverWarehousing |
#    And Admin click on field "Contact number"
    And Admin enter text "1234567890" on text box tooltip
    And Click on tooltip button "Update"
    And Admin go to detail of LP company and check information
      | businessName              | contactNumber | roles             |
      | Auto create LP company 22 | 1234567890    | DriverWarehousing |
 #    Edit roles
    And Admin click on field "Roles"
    And Admin remove value "Driver" on text box dropdown tooltip
    And Click on tooltip button "Update"
    And Admin go to detail of LP company and check information
      | businessName              | contactNumber | roles       |
      | Auto create LP company 22 | 1234567890    | Warehousing |
    And Admin click on field "Roles"
    And Admin remove value "Warehousing" on text box dropdown tooltip
    And Click on tooltip button "Update"
    And BAO_ADMIN7 check alert message
      | Roles name can't be blank |
    And Admin choose value "Warehousing" on text box dropdown tooltip
    And Click on tooltip button "Update"
    And Admin go to detail of LP company and check information
      | businessName              | contactNumber | roles       |
      | Auto create LP company 22 | 1234567890    | Warehousing |


  @AD_LP_COMPANIES_33
  Scenario: Check upload new document successfully
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name             | contact_number | roles_name |
      | Auto create LP company 33 | [blank]        | [blank]    |
    And Admin delete lp company by api
    Then Admin create lp company by api
      | business_name             | contact_number | roles_name           |
      | Auto create LP company 33 | 0123456789     | driver , warehousing |

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "LP companies" by sidebar
    And Admin search LP company
      | businessName              | contactNumber | roles   |
      | Auto create LP company 33 | 0123456789    | [blank] |
    And Admin go to detail of LP company and check information
      | businessName              | contactNumber | roles             |
      | Auto create LP company 33 | 0123456789    | DriverWarehousing |
    And Admin upload documents for LP company
      | document    | documentName | startDate   | expiryDate  |
      | anhJPEG.jpg | jpeg         | currentDate | currentDate |
      | anhJPG2.jpg | jpg          | currentDate | currentDate |
      | BOL.pdf     | pdf          | currentDate | currentDate |
      | anhPNG.png  | png          | currentDate | currentDate |
      | test.docx   | docx         | currentDate | currentDate |
    And Admin check documents for LP company
      | document    | documentName | startDate   | expiryDate  |
      | anhJPEG.jpg | jpeg         | currentDate | currentDate |
      | anhJPG2.jpg | jpg          | currentDate | currentDate |
      | BOL.pdf     | pdf          | currentDate | currentDate |
      | anhPNG.png  | png          | currentDate | currentDate |
      | test.docx   | docx         | currentDate | currentDate |
    And Admin remove documents for LP company
    And Admin check documents for LP company
      | document    | documentName | startDate   | expiryDate  |
      | anhJPG2.jpg | jpg          | currentDate | currentDate |
      | BOL.pdf     | pdf          | currentDate | currentDate |
      | anhPNG.png  | png          | currentDate | currentDate |
      | test.docx   | docx         | currentDate | currentDate |
    And Admin download documents "anhJPG2.jpg" of LP company

  @AD_LP_COMPANIES_41
  Scenario: Verify the LOGISTICS PARTNERS section
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name             | contact_number | roles_name |
      | Auto create LP company 41 | [blank]        | [blank]    |
    And Admin delete lp company by api
    Then Admin create lp company by api
      | business_name             | contact_number | roles_name           |
      | Auto create LP company 41 | 0123456789     | driver , warehousing |
    Then Admin create lp by api
      | first_name | last_name      | contact_number | email                             | password  | logistics_company_id |
      | Auto       | AutoCreateLP41 | 0123456789     | ngoctx+autolpcreate41@podfoods.co | 12345678a | create by api        |
    Then Admin create lp by api
      | first_name | last_name      | contact_number | email                             | password  | logistics_company_id |
      | Auto       | AutoCreateLP42 | 0123456789     | ngoctx+autolpcreate42@podfoods.co | 12345678a | create by api        |

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "LP companies" by sidebar
    And Admin search LP company
      | businessName           | contactNumber | roles       |
      | Auto create LP company | 0123456789    | Warehousing |
    And Admin check LP company list
      | id            | businessName              | contactNumber | roles             |
      | create by api | Auto create LP company 41 | 0123456789    | DriverWarehousing |
    And Admin go to detail of LP company and check information
      | businessName              | contactNumber | roles             |
      | Auto create LP company 41 | 0123456789    | DriverWarehousing |
    And Admin check logistics partner of LP company
      | lpName              | email                             | contact    |
      | Auto AutoCreateLP41 | ngoctx+autolpcreate41@podfoods.co | 0123456789 |
      | Auto AutoCreateLP42 | ngoctx+autolpcreate42@podfoods.co | 0123456789 |
    And Click on button "Add a logistics partner"
    And BAO_ADMIN7 check value of field
      | field      | value                     |
      | LP company | Auto create LP company 41 |
    And Admin create new logistics partner
      | firstName | lastName       | email                             | contactNumber | password  | lpCompany |
      | Auto      | AutoCreateLP43 | ngoctx+autolpcreate43@podfoods.co | 0123456789    | 12345678a | [blank]   |
    And BAO_ADMIN7 navigate to "Logistics Partners" to "LP companies" by sidebar
    And Admin search LP company
      | businessName              | contactNumber | roles   |
      | Auto create LP company 41 | 0123456789    | [blank] |
    And Admin go to detail of LP company and check information
      | businessName              | contactNumber | roles             |
      | Auto create LP company 41 | 0123456789    | DriverWarehousing |
    And Admin check logistics partner of LP company
      | lpName              | email                             | contact    |
      | Auto AutoCreateLP41 | ngoctx+autolpcreate41@podfoods.co | 0123456789 |
      | Auto AutoCreateLP42 | ngoctx+autolpcreate42@podfoods.co | 0123456789 |
      | Auto AutoCreateLP43 | ngoctx+autolpcreate43@podfoods.co | 0123456789 |

  @AD_LP_1
  Scenario: Create new logistics partner form
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name   | contact_number | roles_name |
      | Auto create LP1 | [blank]        | [blank]    |
    And Admin delete lp company by api
    Then Admin create lp company by api
      | business_name   | contact_number | roles_name           |
      | Auto create LP1 | 0123456789     | driver , warehousing |

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "All logistics partners" by sidebar
    And Admin search LP
      | fullName            | lpCompany       | email                             | contactNumber | status |
      | Auto AutoCreateLP10 | Auto create LP1 | ngoctx+autolpcreate10@podfoods.co | 0123456789    | Active |
    And Admin check no data found
    And Admin create new logistics partner
      | firstName | lastName       | email                             | contactNumber | password  | lpCompany       |
      | Auto      | AutoCreateLP10 | ngoctx+autolpcreate10@podfoods.co | 0123456789    | 12345678a | Auto create LP1 |
    And Admin search LP
      | fullName            | lpCompany       | email                             | contactNumber | status |
      | Auto AutoCreateLP10 | Auto create LP1 | ngoctx+autolpcreate10@podfoods.co | 0123456789    | Active |
    And Admin check LP list
      | id      | name                | lpCompany       | email                             | contactNumber | status |
      | [blank] | Auto AutoCreateLP10 | Auto create LP1 | ngoctx+autolpcreate10@podfoods.co | 0123456789    | Active |

  @AD_LP_2
  Scenario: Create new logistics partner form - validate
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name   | contact_number | roles_name |
      | Auto create LP1 | [blank]        | [blank]    |
    And Admin delete lp company by api
    Then Admin create lp company by api
      | business_name   | contact_number | roles_name |
      | Auto create LP1 | 0123456789     | driver     |
    Then Admin create lp by api
      | first_name | last_name      | contact_number | email                             | password  | logistics_company_id |
      | Auto       | AutoCreateLP11 | 0123456789     | ngoctx+autolpcreate11@podfoods.co | 12345678a | create by api        |

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "All logistics partners" by sidebar
    And Admin create new logistics partner
      | firstName | lastName | email   | contactNumber | password | lpCompany |
      | [blank]   | [blank]  | [blank] | [blank]       | [blank]  | [blank]   |
    And BAO_ADMIN7 check error message is showing of fields
      | field      | message                                                          |
      | Name       | Please input first name and last name for this logistics partner |
      | Email      | Please input a valid email address                               |
      | Password   | password is required                                             |
      | LP company | Please select logistics partner company                          |
    And Admin create new logistics partner
      | firstName | lastName | email | contactNumber | password | lpCompany |
      | a         | b c      | a@b.c | a             | aaaaaaaa | [blank]   |
    And BAO_ADMIN7 check error message is showing of fields
      | field          | message                                            |
      | Email          | Please input a valid email address                 |
      | Contact number | Please enter a valid 10-digits phone number        |
      | Password       | At least 1 letter, a number, at least 8 characters |
      | LP company     | Please select logistics partner company            |
    And Admin create new logistics partner
      | firstName | lastName       | email                             | contactNumber | password                                                                                                                                                                                                                                                          | lpCompany       |
      | Auto      | AutoCreateLP11 | ngoctx+autolpcreate11@podfoods.co | 0123456789    | THIS STRING IS 256 CHARACTERS xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx | Auto create LP1 |
    And BAO_ADMIN7 check error message is showing of fields
      | field    | message                                          |
      | Password | Password is too long (maximum is 256 characters) |
    And Admin create new logistics partner
      | firstName | lastName | email  | contactNumber | password | lpCompany       |
      | a         | b c      | a@b.co | 1234567890    | aaaaaaa1 | Auto create LP1 |
    And BAO_ADMIN7 check alert message
      | Last name is invalid |
    And Admin create new logistics partner
      | firstName | lastName       | email                             | contactNumber | password  | lpCompany       |
      | Auto      | AutoCreateLP11 | ngoctx+autolpcreate11@podfoods.co | 0123456789    | 12345678a | Auto create LP1 |
    And BAO_ADMIN7 check alert message
      | Email has already been taken |

  @AD_LP_9
  Scenario: All LP companies list
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name   | contact_number | roles_name |
      | Auto create LP9 | [blank]        | [blank]    |
    And Admin delete lp company by api
    Then Admin create lp company by api
      | business_name   | contact_number | roles_name           |
      | Auto create LP9 | 0123456789     | driver , warehousing |
    Then Admin create lp by api
      | first_name | last_name      | contact_number | email                             | password  | logistics_company_id |
      | Auto       | AutoCreateLP92 | 0123456789     | ngoctx+autolpcreate92@podfoods.co | 12345678a | create by api        |
    Then Admin create lp by api
      | first_name | last_name      | contact_number | email                             | password  | logistics_company_id |
      | Auto       | AutoCreateLP91 | 0123456789     | ngoctx+autolpcreate91@podfoods.co | 12345678a | create by api        |

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "All logistics partners" by sidebar
    And Admin check LP list
      | id            | name                | lpCompany       | email                             | contactNumber | status |
      | create by api | Auto AutoCreateLP91 | Auto create LP9 | ngoctx+autolpcreate91@podfoods.co | 0123456789    | Active |
      | create by api | Auto AutoCreateLP92 | Auto create LP9 | ngoctx+autolpcreate92@podfoods.co | 0123456789    | Active |
    And Admin search LP
      | fullName           | lpCompany | email   | contactNumber | status   |
      | Auto AutoCreateLP9 | [blank]   | [blank] | [blank]       | Inactive |
    And Admin check no data found
    And Admin search LP
      | fullName           | lpCompany | email   | contactNumber | status |
      | Auto AutoCreateLP9 | [blank]   | [blank] | [blank]       | Active |
    And Admin check LP list
      | id            | name                | lpCompany       | email                             | contactNumber | status |
      | create by api | Auto AutoCreateLP91 | Auto create LP9 | ngoctx+autolpcreate91@podfoods.co | 0123456789    | Active |
      | create by api | Auto AutoCreateLP92 | Auto create LP9 | ngoctx+autolpcreate92@podfoods.co | 0123456789    | Active |
    And Admin reset filter
    And Admin search LP
      | fullName | lpCompany       | email   | contactNumber | status  |
      | [blank]  | Auto create LP9 | [blank] | [blank]       | [blank] |
    And Admin check LP list
      | id            | name                | lpCompany       | email                             | contactNumber | status |
      | create by api | Auto AutoCreateLP91 | Auto create LP9 | ngoctx+autolpcreate91@podfoods.co | 0123456789    | Active |
      | create by api | Auto AutoCreateLP92 | Auto create LP9 | ngoctx+autolpcreate92@podfoods.co | 0123456789    | Active |
    And Admin reset filter
    And Admin search LP
      | fullName | lpCompany | email                | contactNumber | status  |
      | [blank]  | [blank]   | ngoctx+autolpcreate9 | [blank]       | [blank] |
    And Admin check LP list
      | id            | name                | lpCompany       | email                             | contactNumber | status |
      | create by api | Auto AutoCreateLP91 | Auto create LP9 | ngoctx+autolpcreate91@podfoods.co | 0123456789    | Active |
      | create by api | Auto AutoCreateLP92 | Auto create LP9 | ngoctx+autolpcreate92@podfoods.co | 0123456789    | Active |
    And Admin reset filter
    And Admin search LP
      | fullName | lpCompany | email                 | contactNumber | status  |
      | [blank]  | [blank]   | ngoctx+autolpcreate93 | [blank]       | [blank] |
    And Admin check no data found

  @AD_LP_14
  Scenario:Check deleting a LP successfully
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name    | contact_number | roles_name |
      | Auto create LP14 | [blank]        | [blank]    |
    And Admin delete lp company by api
    Then Admin create lp company by api
      | business_name    | contact_number | roles_name           |
      | Auto create LP14 | 0123456789     | driver , warehousing |
    Then Admin create lp by api
      | first_name | last_name       | contact_number | email                              | password  | logistics_company_id |
      | Auto       | AutoCreateLP142 | 0123456789     | ngoctx+autolpcreate142@podfoods.co | 12345678a | create by api        |
    Then Admin create lp by api
      | first_name | last_name       | contact_number | email                              | password  | logistics_company_id |
      | Auto       | AutoCreateLP141 | 0123456789     | ngoctx+autolpcreate141@podfoods.co | 12345678a | create by api        |

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "All logistics partners" by sidebar
    And Admin search LP
      | fullName | lpCompany | email                 | contactNumber | status  |
      | [blank]  | [blank]   | ngoctx+autolpcreate14 | [blank]       | [blank] |
    And Admin check LP list
      | id            | name                 | lpCompany        | email                              | contactNumber | status |
      | create by api | Auto AutoCreateLP141 | Auto create LP14 | ngoctx+autolpcreate141@podfoods.co | 0123456789    | Active |
      | create by api | Auto AutoCreateLP142 | Auto create LP14 | ngoctx+autolpcreate142@podfoods.co | 0123456789    | Active |
    And Admin "Cancel" delete LP "Auto AutoCreateLP141"
    And Admin check LP list
      | id            | name                 | lpCompany        | email                              | contactNumber | status |
      | create by api | Auto AutoCreateLP141 | Auto create LP14 | ngoctx+autolpcreate141@podfoods.co | 0123456789    | Active |
      | create by api | Auto AutoCreateLP142 | Auto create LP14 | ngoctx+autolpcreate142@podfoods.co | 0123456789    | Active |
    And Admin "Understand & Continue" delete LP "Auto AutoCreateLP141"
    And Admin search LP
      | fullName | lpCompany | email                              | contactNumber | status  |
      | [blank]  | [blank]   | ngoctx+autolpcreate141@podfoods.co | [blank]       | [blank] |
    And Admin check no data found

  @AD_LP_24
  Scenario:Check information displayed for a LP details page
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name    | contact_number | roles_name |
      | Auto create LP24 | [blank]        | [blank]    |
    And Admin delete lp company by api
    Then Admin create lp company by api
      | business_name    | contact_number | roles_name           |
      | Auto create LP24 | 0123456789     | driver , warehousing |
    Then Admin create lp by api
      | first_name | last_name       | contact_number | email                              | password  | logistics_company_id |
      | Auto       | AutoCreateLP242 | 0123456789     | ngoctx+autolpcreate242@podfoods.co | 12345678a | create by api        |
    Then Admin create lp by api
      | first_name | last_name      | contact_number | email                             | password  | logistics_company_id |
      | Auto       | AutoCreateLP24 | 0123456789     | ngoctx+autolpcreate24@podfoods.co | 12345678a | create by api        |
    Then Admin create lp company by api
      | business_name     | contact_number | roles_name           |
      | Auto create LP242 | 0123456789     | driver , warehousing |

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "All logistics partners" by sidebar
    And Admin search LP
      | fullName | lpCompany | email                 | contactNumber | status  |
      | [blank]  | [blank]   | ngoctx+autolpcreate24 | [blank]       | [blank] |
    And Admin go to detail of LP "Auto AutoCreateLP24"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | 0123456789    | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |
    And Admin click on field "Email"
    And Click on tooltip button "Update"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | 0123456789    | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |
    And Admin click on field "Email"
    And Click on tooltip button "Cancel"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | 0123456789    | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |
    And Admin click on field "Email"
    And Admin enter text " " on text box tooltip
    And Click on tooltip button "Update"
    And BAO_ADMIN7 check alert message
      | Email is invalid |
    And Click on tooltip button "Cancel"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | 0123456789    | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |
    And Admin click on field "Email"
    And Admin enter text "ngoctx+autolpcreate242@podfoods.co" on text box tooltip
    And Click on tooltip button "Update"
    And BAO_ADMIN7 check alert message
      | Email has already been taken |
    And Click on tooltip button "Cancel"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | 0123456789    | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |
    And Admin click on field "First name"
    And Admin enter text "Auto a" on text box tooltip
    And Click on tooltip button "Update"
    And BAO_ADMIN7 check alert message
      | First name is invalid |
    And Click on tooltip button "Cancel"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | 0123456789    | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |
    And Admin click on field "First name"
    And Admin clear field tooltip
    And Click on tooltip button "Update"
    And BAO_ADMIN7 check alert message
      | First name is too short (minimum is 1 character) |
    And Click on tooltip button "Cancel"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | 0123456789    | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |
    And Admin click on field "Last name"
    And Admin enter text "Auto a" on text box tooltip
    And Click on tooltip button "Update"
    And BAO_ADMIN7 check alert message
      | Last name is invalid |
    And Click on tooltip button "Cancel"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | 0123456789    | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |
    And Admin click on field "Last name"
    And Admin clear field tooltip
    And Click on tooltip button "Update"
    And BAO_ADMIN7 check alert message
      | Last name is too short (minimum is 1 character) |
    And Click on tooltip button "Cancel"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | 0123456789    | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |

    And Admin click on field "Contact number"
    And Admin clear field tooltip
    And Click on tooltip button "Update"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | Empty         | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |
    And Admin click on field "Contact number"
    And Admin enter text "1" on text box tooltip
    And Click on tooltip button "Update"
    And BAO_ADMIN7 check alert message
      | Contact number is the wrong length (should be 10 characters) |
    And Click on tooltip button "Cancel"
    And Admin click on field "Contact number"
    And Admin enter text "aaaaaaaaaa" on text box tooltip
    And Click on tooltip button "Update"
    And BAO_ADMIN7 check alert message
      | Contact number is not a number |
    And Click on tooltip button "Cancel"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | Empty         | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |
    And Admin click on field "Contact number"
    And Admin enter text "1234567890" on text box tooltip
    And Click on tooltip button "Update"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | 1234567890    | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |
    And Admin click on field "LP company"
    And Click on tooltip button "Cancel"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | 1234567890    | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |
    And Admin click on field "LP company"
    And Admin choose value "Auto create LP242" on text box dropdown input tooltip
    And Click on tooltip button "Update"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany         |
      | Auto      | AutoCreateLP24 | 1234567890    | ngoctx+autolpcreate24@podfoods.co | Auto create LP242 |
    And Admin click on field "Email"
    And Admin enter text "ngoctx+autolpcreate241@podfoods.co" on text box tooltip
    And Click on tooltip button "Update"
    And Admin click on field "First name"
    And Admin enter text "Auto1" on text box tooltip
    And Click on tooltip button "Update"
    And Admin click on field "Last name"
    And Admin enter text "AutoCreateLP241" on text box tooltip
    And Click on tooltip button "Update"
    And Admin check information of LP
      | firstName | lastName        | contactNumber | email                              | lpCompany         |
      | Auto1     | AutoCreateLP241 | 1234567890    | ngoctx+autolpcreate241@podfoods.co | Auto create LP242 |

  @AD_LP_25
  Scenario:Check information displayed for a LP details page - change password
    Given BAO_ADMIN7 login web admin by api
      | email            | password  |
      | bao7@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name    | contact_number | roles_name |
      | Auto create LP24 | [blank]        | [blank]    |
    And Admin delete lp company by api
    Then Admin create lp company by api
      | business_name    | contact_number | roles_name           |
      | Auto create LP24 | 0123456789     | driver , warehousing |
    Then Admin create lp by api
      | first_name | last_name      | contact_number | email                             | password  | logistics_company_id |
      | Auto       | AutoCreateLP24 | 0123456789     | ngoctx+autolpcreate24@podfoods.co | 12345678a | create by api        |

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "All logistics partners" by sidebar
    And Admin search LP
      | fullName | lpCompany | email                 | contactNumber | status  |
      | [blank]  | [blank]   | ngoctx+autolpcreate24 | [blank]       | [blank] |
    And Admin go to detail of LP "Auto AutoCreateLP24"
    And Admin check information of LP
      | firstName | lastName       | contactNumber | email                             | lpCompany        |
      | Auto      | AutoCreateLP24 | 0123456789    | ngoctx+autolpcreate24@podfoods.co | Auto create LP24 |
    And Click on button "Change password"
    And Click on tooltip button "Update"

    Given LP open web LP
    When login to beta web with email "ngoctx+autolpcreate24@podfoods.co" pass "12345678a" role "LP"
    And LP check Privacy Policy and accept

    And Switch to actor BAO_ADMIN7
    And Click on button "Change password"
    And Admin enter text "123456789a" on text box tooltip
    And Click on tooltip button "Update"
    And Check any button "not" showing on screen
      | Update |

    And Switch to actor LP
    And LP refresh browser
    When login to beta web with email "ngoctx+autolpcreate24@podfoods.co" pass "123456789a" role "LP"
    And LP Navigate to "Inventory" by sidebar

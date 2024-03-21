@feature=AdminVendor
Feature: Admin Vendor
  # nếu tag id = private brand tag thì key account = Yes
  @AdminVendor_01 @AdminVendor
  Scenario: Verify Create Custom Field
    Given NGOCTX17 login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |

    Given NGOC_ADMIN_17 open web admin
    When NGOC_ADMIN_17 login to web with role Admin
    And NGOC_ADMIN_17 navigate to "Vendors" to "All vendors" by sidebar
    And Admin verify default create custom field

  @AdminVendor_02 @AdminVendor
  Scenario: Verify Create New Vendor
    Given NGOCTX17 login web admin by api
      | email                | password  |
      | ngoctx01@podfoods.co | 12345678a |
    And Admin search all vendor by API
      | q[vendor_company_id] | q[brand_id] | q[full_name]        | q[email] | region_id | q[vendor_company_address_city] | q[vendor_company_address_address_state_id] | q[tag_ids][] | q[approved] |
      | [blank]              | [blank]     | AT Create Vendor 01 | [blank]  | [blank]   | [blank]                        | [blank]                                    | [blank]      | [blank]     |
    And Admin delete vendor by API
    And Admin search all vendor by API
      | q[vendor_company_id] | q[brand_id] | q[full_name]                     | q[email] | region_id | q[vendor_company_address_city] | q[vendor_company_address_address_state_id] | q[tag_ids][] | q[approved] |
      | [blank]              | [blank]     | AT Create Vendor 01 Edit 01 Edit | [blank]  | [blank]   | [blank]                        | [blank]                                    | [blank]      | [blank]     |
    And Admin delete vendor by API

    Given NGOC_ADMIN_17 open web admin
    When NGOC_ADMIN_17 login to web with role Admin
    And NGOC_ADMIN_17 navigate to "Vendors" to "All vendors" by sidebar
    And Admin verify default create vendor field
    And Admin go to create new vendor
    And Admin fill info to create new vendor
      | firstName | lastName  | email                                | company              | password  |
      | Auto Text | Auto Text | ngoctx+vendorstatement03@podfoods.co | ngoctx vcstatement03 | 12345678a |
    And Admin add tags in create new vendor
      | tags                |
      | all private target  |
      | Private tag for all |
    And Admin create vendor and verify message error "Email has already been taken"
    And Admin fill info to create new vendor
      | firstName | lastName  | email                                | company              | password                                                                                                                                                                                                                                                                                                 |
      | Auto Text | Auto Text | ngoctx+vendorstatement03@podfoods.co | ngoctx vcstatement03 | 1111111111111111123123124121111111111111111112312311111111111111111111111111111133333333333333333333333333312312341234444444444444a44444444433333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333a |
    And Admin verify password message error "Password is too long (maximum is 256 characters)"
    And Admin delete tags in create new vendor
      | tags               |
      | all private target |
    And Admin fill info to create new vendor
      | firstName        | lastName | email                               | company                     | password  |
      | AT Create Vendor | 01       | ngoctx+atCreateVendor01@podfoods.co | AT Create Vendor Company 01 | 12345678a |
    And Admin fill info custom to create new vendor
      | boolean | date        | numeric   | text        | file        |
      | Yes     | currentDate | 123456789 | Custom text | anhJPEG.jpg |
    And Admin create vendor success
    # Search vendor with fullname criteria
    And NGOC_ADMIN_17 navigate to "Vendors" to "All vendors" by sidebar
    And Admin search vendors
      | fullName               | email   | vendorCompany | brand   | region  | address | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01111 | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin no found vendor "AT Create Vendor 01" in result
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand   | region  | address | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin verify vendor in result
      | name                | email                               | vendorCompany               | address                              | shopify |
      | AT Create Vendor 01 | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, 10023 | [blank] |
    # Search vendor with email criteria
    And Admin search vendors
      | fullName | email                                     | vendorCompany | brand   | region  | address | state   | tags    | approved | shopify | status  |
      | [blank]  | ngoctx+atcreatevendor01231231@podfoods.co | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin no found vendor "AT Create Vendor 01" in result
    And Admin search vendors
      | fullName | email                               | vendorCompany | brand   | region  | address | state   | tags    | approved | shopify | status  |
      | [blank]  | ngoctx+atcreatevendor01@podfoods.co | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin verify vendor in result
      | name                | email                               | vendorCompany               | address                              | shopify |
      | AT Create Vendor 01 | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, 10023 | [blank] |
    # Search vendor with vendor company criteria
    And Admin search vendors
      | fullName            | email   | vendorCompany        | brand   | region  | address | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | ngoctx vcstatement03 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin no found vendor "AT Create Vendor 01" in result
    And Admin search vendors
      | fullName            | email   | vendorCompany               | brand   | region  | address | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | AT Create Vendor Company 01 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin verify vendor in result
      | name                | email                               | vendorCompany               | address                              | shopify |
      | AT Create Vendor 01 | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, 10023 | [blank] |
    # Search vendor with brand criteria
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand                        | region  | address | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | AT Brand Vendor Statement 01 | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin no found vendor "AT Create Vendor 01" in result
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand                             | region  | address | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | AT Brand Create Vendor Company 01 | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin verify vendor in result
      | name                | email                               | vendorCompany               | address                              | shopify |
      | AT Create Vendor 01 | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, 10023 | [blank] |
      # Search vendor with region criteria
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand   | region              | address | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | [blank] | Chicagoland Express | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin no found vendor "AT Create Vendor 01" in result
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand   | region           | address | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | [blank] | New York Express | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin verify vendor in result
      | name                | email                               | vendorCompany               | address                              | shopify |
      | AT Create Vendor 01 | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, 10023 | [blank] |
    # Search vendor with address criteria
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand   | region  | address                              | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | [blank] | [blank] | 281 Columbus Avenue, New York, 11111 | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin no found vendor "AT Create Vendor 01" in result
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand   | region  | address  | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | [blank] | [blank] | New York | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin verify vendor in result
      | name                | email                               | vendorCompany               | address                              | shopify |
      | AT Create Vendor 01 | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, 10023 | [blank] |
     # Search vendor with state criteria
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand   | region  | address | state      | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | [blank] | [blank] | [blank] | New Jersey | [blank] | [blank]  | [blank] | [blank] |
    And Admin no found vendor "AT Create Vendor 01" in result
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand   | region  | address | state    | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | [blank] | [blank] | [blank] | New York | [blank] | [blank]  | [blank] | [blank] |
    And Admin verify vendor in result
      | name                | email                               | vendorCompany               | address                              | shopify |
      | AT Create Vendor 01 | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, 10023 | [blank] |
    # Search vendor with tag criteria
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand   | region  | address | state   | tags               | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank] | all private target | [blank]  | [blank] | [blank] |
    And Admin no found vendor "AT Create Vendor 01" in result
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand   | region  | address | state   | tags                | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank] | Private tag for all | [blank]  | [blank] | [blank] |
    And Admin verify vendor in result
      | name                | email                               | vendorCompany               | address                              | shopify |
      | AT Create Vendor 01 | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, 10023 | [blank] |
      # Search vendor with approved criteria
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand   | region  | address | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank] | No       | [blank] | [blank] |
    And Admin no found vendor "AT Create Vendor 01" in result
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand   | region  | address | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank] | Yes      | [blank] | [blank] |
    And Admin verify vendor in result
      | name                | email                               | vendorCompany               | address                              | shopify |
      | AT Create Vendor 01 | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, 10023 | [blank] |
      # Search vendor with all criteria
    And Admin search vendors
      | fullName            | email                               | vendorCompany               | brand                             | region           | address  | state    | tags                | approved | shopify | status |
      | AT Create Vendor 01 | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor Company 01 | AT Brand Create Vendor Company 01 | New York Express | New York | New York | Private tag for all | Yes      | [blank] | Active |
    And Admin verify vendor in result
      | name                | email                               | vendorCompany               | address                              | shopify |
      | AT Create Vendor 01 | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, 10023 | [blank] |
    And Admin go to vendor detail "AT Create Vendor 01"
    And Admin verify general information in vendor detail
      | email                               | firstName        | lastName | company                     | address                                        |
      | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor | 01       | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, New York, 10023 |
    And Admin verify tags in vendor detail
      | tag                 |
      | Private tag for all |
    And Admin verify edit email field in vendor detail
      | email                                   | message                      |
      | [blank]                                 | Email can't be blank         |
      | 123                                     | Email is not an email        |
      | ngoctx+vendorstatement03@podfoods.co    | Email has already been taken |
      | ngoctx+atcreatevendor01edit@podfoods.co | success                      |
    And Admin verify edit first name field in vendor detail
      | firstName                | message                   |
      | [blank]                  | First name can't be blank |
      | AT CREATE VENDOR!@#$%    | success                   |
      | 01                       | success                   |
      | AT Create Vendor 01 Edit | success                   |
    And Admin verify edit last name field in vendor detail
      | lastName | message                  |
      | [blank]  | Last name can't be blank |
      | 01!@#$%  | success                  |
      | 01       | success                  |
      | 01 Edit  | success                  |
    And Admin verify edit company field in vendor detail
      | company                     | address                                         |
      | AT Vendor Order             | 1544 West 18th Street, Chicago, Illinois, 60608 |
      | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, New York, 10023  |
    And Admin verify default popup tag field in vendor detail
      | tag                 |
      | Private tag for all |
    And Admin remove tag field in vendor detail
      | tag                 |
      | Private tag for all |
    And Admin add tag field in vendor detail
      | tag                 | expiryDate  |
      | all private target  | currentDate |
      | Private tag for all | currentDate |
    And Admin verify password field in vendor detail
      | message                                                              | password                                                                                                                                                                                                                                                                                                                          |
      | Password must be at least 1 letter, a number, at least 8 characters. | adddddaaaaaa                                                                                                                                                                                                                                                                                                                      |
      | Password must be at least 1 letter, a number, at least 8 characters. | 123123123123                                                                                                                                                                                                                                                                                                                      |
      | Password must be at least 1 letter, a number, at least 8 characters. | 12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890a |
    And Admin change password to "123456789a" success in vendor detail
    And Admin verify custom field in vendor detail
      | boolean | date        | numeric   | text        | file        |
      | Yes     | currentDate | 123456789 | Custom text | anhJPEG.jpg |
    And Admin edit custom field in vendor detail
      | boolean | date  | numeric    | text             | file        |
      | No      | Plus1 | 1234567890 | Custom text edit | anhJPG2.jpg |
    And Admin verify custom field in vendor detail
      | boolean | date  | numeric    | text             | file        |
      | No      | Plus1 | 1234567890 | Custom text edit | anhJPG2.jpg |
    And Admin navigate relate product in vendor detail
    And Admin check list of product after searching
      | term                        | productState | brandName                         | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | AT Product Create Vendor 01 | Active       | AT Brand Create Vendor Company 01 | Auto vendor company | Water       | Bulk        | [blank]    | [blank]     | [blank] |
    And NGOC_ADMIN_17 navigate to "Vendors" to "All vendors" by sidebar
    And Admin search vendors
      | fullName                         | email   | vendorCompany | brand   | region  | address | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01 Edit 01 Edit | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin go to vendor detail "AT Create Vendor 01 Edit 01 Edit"
    # Deactivate vendor
    When Admin "deactivate" this vendor
    And Admin go back with button
    And Admin search vendors
      | fullName                         | email   | vendorCompany | brand   | region  | address | state   | tags    | approved | shopify | status   | status  |
      | AT Create Vendor 01 Edit 01 Edit | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | Inactive | [blank] |
    And Admin verify vendor in result
      | name                             | email                               | vendorCompany               | address                              | shopify |
      | AT Create Vendor 01 Edit 01 Edit | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, 10023 | [blank] |
    And Admin go to vendor detail "AT Create Vendor 01 Edit 01 Edit"
    # Activate vendor
    When Admin "activate" this vendor
    And Admin go back with button
    And Admin search vendors
      | fullName                         | email   | vendorCompany | brand   | region  | address | state   | tags    | approved | shopify | status   | status  |
      | AT Create Vendor 01 Edit 01 Edit | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | Activate | [blank] |
    And Admin verify vendor in result
      | name                             | email                               | vendorCompany               | address                              | shopify |
      | AT Create Vendor 01 Edit 01 Edit | ngoctx+atcreatevendor01@podfoods.co | AT Create Vendor Company 01 | 281 Columbus Avenue, New York, 10023 | [blank] |
    # Delete vendor
    And Admin delete vendor "AT Create Vendor 01 Edit 01 Edit" in result
    And Admin search vendors
      | fullName            | email   | vendorCompany | brand   | region  | address | state   | tags    | approved | shopify | status  |
      | AT Create Vendor 01 | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] |
    And Admin no found data in result

  @AdminVendor_03 @AdminVendor
  Scenario: Verify Create New Vendor Company
    Given NGOCTX17 login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
       # Delete vendor company
    And Admin search vendor company by API
      | q[name]                     |
      | AT Create Vendor Company 02 |
    And Admin delete vendor company by API
  # Delete vendor company
    And Admin search vendor company by API
      | q[name]                          |
      | AT Create Vendor Company 02 Edit |
    And Admin delete vendor company by API

    Given NGOC_ADMIN_17 open web admin
    When NGOC_ADMIN_17 login to web with role Admin
    And NGOC_ADMIN_17 navigate to "Vendors" to "Companies" by sidebar
    And Admin go to create new vendor company popup
    And Admin verify detect duplicates create vendor company "AT Create Vendor Company 01"
    And Admin verify empty field in create new vendor company popup
    And Admin fill info to create new vendor company
      | name                        | street1             | street2 | city     | state    | zip   | limitType |
      | AT Create Vendor Company 02 | 281 Columbus Avenue | street2 | New York | New York | 10023 | MOQ       |
    And Admin fill info optional to create new vendor company
      | legalName         | email              | website          | ein        | contact    | companySize | ach | prepayment | showAllTab | hideBrand | manageBy | launchBy | referredBy     | tags               |
      | Legal Entity Name | ngoctx@podfoods.co | https://ngoc.com | 01-1234567 | 1234567890 | <25k        | Yes | Yes        | Yes        | Yes       | ngoctx17 | ngoctx17 | ngoc cpn claim | all private target |
    # Verify custom field
    And Admin fill info custom field to create new vendor company
      | boolean | date        | file        | numeric   | text        |
      | Yes     | currentDate | anhJPEG.jpg | 123456789 | Custom text |
    And Admin create new vendor company success
    # Verify search name criteria
    And Admin search vendor company
      | name                                | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 0124123123 | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin no found data in result
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin verify info vendor company
      | name                        | region  | email              | ein        | website  | managedBy | launchBy | legalName         | prePayment |
      | AT Create Vendor Company 02 | [blank] | ngoctx@podfoods.co | 01-1234567 | ngoc.com | ngoctx17  | ngoctx17 | Legal Entity Name | Yes        |
    # Verify search prepayment criteria
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | No         | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin no found data in result
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | Yes        | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin verify info vendor company
      | name                        | region  | email              | ein        | website  | managedBy | launchBy | legalName         | prePayment |
      | AT Create Vendor Company 02 | [blank] | ngoctx@podfoods.co | 01-1234567 | ngoc.com | ngoctx17  | ngoctx17 | Legal Entity Name | Yes        |
     # Verify search region criteria
    And Admin search vendor company
      | name                        | prepayment | region          | website | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | [blank]    | Florida Express | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin no found data in result
    And Admin search vendor company
      | name                 | prepayment | region           | website | ein     | email   | managedBy | ach     | tag     |
      | ngoctx vcstatement03 | [blank]    | New York Express | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin verify info vendor company
      | name                 | region | email   | ein     | website | managedBy | launchBy | prePayment |
      | ngoctx vcstatement03 | NY     | [blank] | [blank] | [blank] | [blank]   | [blank]  | No         |
     # Verify search website criteria
    And Admin search vendor company
      | name                        | prepayment | region  | website  | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | No         | [blank] | test.com | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin no found data in result
    And Admin search vendor company
      | name                        | prepayment | region  | website  | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | [blank]    | [blank] | ngoc.com | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin verify info vendor company
      | name                        | region  | email              | ein        | website  | managedBy | launchBy | legalName         | prePayment |
      | AT Create Vendor Company 02 | [blank] | ngoctx@podfoods.co | 01-1234567 | ngoc.com | ngoctx17  | ngoctx17 | Legal Entity Name | Yes        |
    # Verify search EIN criteria
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | No         | [blank] | [blank] | 3216549 | [blank] | [blank]   | [blank] | [blank] |
    And Admin no found data in result
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein        | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | [blank]    | [blank] | [blank] | 01-1234567 | [blank] | [blank]   | [blank] | [blank] |
    And Admin verify info vendor company
      | name                        | region  | email              | ein        | website  | managedBy | launchBy | legalName         | prePayment |
      | AT Create Vendor Company 02 | [blank] | ngoctx@podfoods.co | 01-1234567 | ngoc.com | ngoctx17  | ngoctx17 | Legal Entity Name | Yes        |
    # Verify search email criteria
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email                   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | No         | [blank] | [blank] | [blank] | ngoctx12124@podfoods.co | [blank]   | [blank] | [blank] |
    And Admin no found data in result
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email              | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | [blank]    | [blank] | [blank] | [blank] | ngoctx@podfoods.co | [blank]   | [blank] | [blank] |
    And Admin verify info vendor company
      | name                        | region  | email              | ein        | website  | managedBy | launchBy | legalName         | prePayment |
      | AT Create Vendor Company 02 | [blank] | ngoctx@podfoods.co | 01-1234567 | ngoc.com | ngoctx17  | ngoctx17 | Legal Entity Name | Yes        |
      # Verify search managedBy criteria
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | No         | [blank] | [blank] | [blank] | [blank] | ngoctx15  | [blank] | [blank] |
    And Admin no found data in result
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | [blank]    | [blank] | [blank] | [blank] | [blank] | ngoctx17  | [blank] | [blank] |
    And Admin verify info vendor company
      | name                        | region  | email              | ein        | website  | managedBy | launchBy | legalName         | prePayment |
      | AT Create Vendor Company 02 | [blank] | ngoctx@podfoods.co | 01-1234567 | ngoc.com | ngoctx17  | ngoctx17 | Legal Entity Name | Yes        |
  # Verify search managedBy criteria
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | No         | [blank] | [blank] | [blank] | [blank] | ngoctx15  | [blank] | [blank] |
    And Admin no found data in result
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | [blank]    | [blank] | [blank] | [blank] | [blank] | ngoctx17  | [blank] | [blank] |
    And Admin verify info vendor company
      | name                        | region  | email              | ein        | website  | managedBy | launchBy | legalName         | prePayment |
      | AT Create Vendor Company 02 | [blank] | ngoctx@podfoods.co | 01-1234567 | ngoc.com | ngoctx17  | ngoctx17 | Legal Entity Name | Yes        |
    # Verify search ACH criteria
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email   | managedBy | ach | tag     |
      | AT Create Vendor Company 02 | No         | [blank] | [blank] | [blank] | [blank] | [blank]   | No  | [blank] |
    And Admin no found data in result
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email   | managedBy | ach | tag     |
      | AT Create Vendor Company 02 | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | Yes | [blank] |
    And Admin verify info vendor company
      | name                        | region  | email              | ein        | website  | managedBy | launchBy | legalName         | prePayment |
      | AT Create Vendor Company 02 | [blank] | ngoctx@podfoods.co | 01-1234567 | ngoc.com | ngoctx17  | ngoctx17 | Legal Entity Name | Yes        |
     # Verify search tags criteria
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email   | managedBy | ach     | tag                    |
      | AT Create Vendor Company 02 | No         | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | private vendor company |
    And Admin no found data in result
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email   | managedBy | ach     | tag                |
      | AT Create Vendor Company 02 | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | all private target |
    And Admin verify info vendor company
      | name                        | region  | email              | ein        | website  | managedBy | launchBy | legalName         | prePayment |
      | AT Create Vendor Company 02 | [blank] | ngoctx@podfoods.co | 01-1234567 | ngoc.com | ngoctx17  | ngoctx17 | Legal Entity Name | Yes        |
    # Verify search all criteria
    And Admin search vendor company
      | name                        | prepayment | region  | website  | ein        | email              | managedBy | ach | tag                |
      | AT Create Vendor Company 02 | Yes        | [blank] | ngoc.com | 01-1234567 | ngoctx@podfoods.co | ngoctx17  | Yes | all private target |
    And Admin verify info vendor company
      | name                        | region  | email              | ein        | website  | managedBy | launchBy | legalName         | prePayment |
      | AT Create Vendor Company 02 | [blank] | ngoctx@podfoods.co | 01-1234567 | ngoc.com | ngoctx17  | ngoctx17 | Legal Entity Name | Yes        |
    # Verify refesh page
    And Admin refresh page vendor company by button
    And Admin search vendor company
      | name                        | prepayment | region  | website  | ein        | email              | managedBy | ach | tag                |
      | AT Create Vendor Company 02 | Yes        | [blank] | ngoc.com | 01-1234567 | ngoctx@podfoods.co | ngoctx17  | Yes | all private target |
    And Admin verify info vendor company
      | name                        | region  | email              | ein        | website  | managedBy | launchBy | legalName         | prePayment |
      | AT Create Vendor Company 02 | [blank] | ngoctx@podfoods.co | 01-1234567 | ngoc.com | ngoctx17  | ngoctx17 | Legal Entity Name | Yes        |
    And Admin go to detail vendor company "AT Create Vendor Company 02"
    Then Admin verify general info vendor company
      | state  | name                        | ein        | companySize | avg     | manager | launcher | referredName | legalName         | website  | ach | prepayment | showTab | hideBrand |
      | Active | AT Create Vendor Company 02 | 01-1234567 | <25k        | [blank] | [blank] | [blank]  | Empty        | Legal Entity Name | ngoc.com | Yes | Yes        | Yes     | Yes       |
    # Verify edit button after search
    And NGOC_ADMIN_17 navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name                        | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin go to detail vendor company "AT Create Vendor Company 02" by edit button
    And Admin verify edit name field in vendor company detail
      | name                                  | message                     |
      | [blank]                               | Name can't be blank         |
      | ngoctx vcstatement03                  | Name has already been taken |
      | AT Create Vendor Company 02!@#$%^&*() | success                     |
      | AT Create Vendor Company 02 Edit      | success                     |
    And Admin verify edit legal entity name field in vendor company detail
      | legalName                   | message                                  |
      | Legal Entity Name1          | Legal entity name has already been taken |
      | [blank]                     | success                                  |
      | Legal Entity Name!@#$%^&*() | success                                  |
      | Legal Entity Name Edit      | success                                  |
    And Admin verify edit ein field in vendor company detail
      | ein        |
      | [blank]    |
      | 123456789  |
      | 01-1234567 |
    And Admin verify edit company size field in vendor company detail
      | companySize |
      | <25k        |
      | 25k-50k     |
      | 50k-100k    |
      | 100k-500k   |
      | 500k+       |
      | <25k        |
    And Admin verify edit managed by field in vendor company detail
      | manageBy |
      | [blank]  |
      | ngoctx15 |
    And Admin verify edit launched by field in vendor company detail
      | launchBy |
      | [blank]  |
      | ngoctx15 |
    And Admin verify default popup tag field in vendor company detail
      | tag                |
      | all private target |
    And Admin remove tag field in vendor detail
      | tag                |
      | all private target |
    And Admin add tag field in vendor detail
      | tag                 | expiryDate  |
      | all private target  | currentDate |
      | Private tag for all | currentDate |
    And Admin verify edit referred by field in vendor company detail
      | referredBy     |
      | [blank]        |
      | ngoc cpn claim |
    And Admin verify edit email by field in vendor company detail
      | email                            | message                      |
      | [blank]                          | Email can't be blank         |
      | 123123                           | Email is invalid             |
      | ngoctx+vcstatement02@podfoods.co | Email has already been taken |
      | ngoctx+edit@podfoods.co          | success                      |
    And Admin verify edit website by field in vendor company detail
      | website      |
      | [blank]      |
      | 123!@#       |
      | ngocedit.com |
    And Admin verify edit address by field in vendor company detail
      | street1               | street2 | city    | state    | zip   |
      | 1544 West 18th Street | street2 | Chicago | Illinois | 60608 |
    And Admin update "ACH" of vendor company
    And Admin update "Prepayment" of vendor company
    And Admin update "Show all tabs" of vendor company
    And Admin update "Hide Brands" of vendor company
    Then Admin verify general info vendor company
      | state  | name                             | ein        | companySize | avg     | manager | launcher | referredName   | legalName              | website      | ach | prepayment | showTab | hideBrand | address                                                  |
      | Active | AT Create Vendor Company 02 Edit | 01-1234567 | <25k        | [blank] | [blank] | [blank]  | ngoc cpn claim | Legal Entity Name Edit | ngocedit.com | No  | No         | No      | No        | 1544 West 18th Street, street2, Chicago, Illinois, 60608 |
    # Verify custom field
    And Admin verify custom field in vendor company detail
      | boolean | date        | numeric   | text        | file        |
      | Yes     | currentDate | 123456789 | Custom text | anhJPEG.jpg |
    And Admin edit custom field in vendor company detail
      | boolean | date  | numeric    | text             | file        |
      | No      | Plus1 | 1234567890 | Custom text edit | anhJPG2.jpg |
    And Admin verify custom field in vendor company detail
      | boolean | date  | numeric    | text             | file        |
      | No      | Plus1 | 1234567890 | Custom text edit | anhJPG2.jpg |
    And Admin refresh page by button
    And Admin "deactivate" vendor company
    Then Admin verify history active vendor company
      | state             | updateBy        | updateOn    |
      | Active → Inactive | Admin: ngoctx17 | currentDate |
    And Admin refresh page by button
    And Admin "activate" vendor company
    Then Admin verify history active vendor company
      | state             | updateBy        | updateOn    |
      | Inactive → Active | Admin: ngoctx17 | currentDate |
    # Verify COI
    And Admin refresh page by button
    And Admin verify COI tab
    And Admin verify link Vendor Service Agreement in coi popup
    And Admin verify error message of coi
    And Admin verify other tab in company document
    And Admin add file other tab in company document
      | file      | description |
      | claim.jpg | Autotest    |

    And NGOC_ADMIN_17 navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name                        | prepayment | region  | website  | ein        | email              | managedBy | ach | tag                |
      | AT Create Vendor Company 02 | Yes        | [blank] | ngoc.com | 01-1234567 | ngoctx@podfoods.co | ngoctx17  | Yes | all private target |
    And Admin delete vendor company "AT Create Vendor Company 02 Edit" in result
    And Admin search vendor company
      | name                             | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Create Vendor Company 02 Edit | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin no found data in result

  @AdminVendor_05 @AdminVendor
  Scenario: Verify Vendor success form
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "44203" by api
    And Admin delete order of sku "44203" by api
     # Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 104987             | 44203              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3486     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Edit buyer company in admin vendor create new success form
    And Admin edit store list in success form by API
      | vendor_company_id | buyer_company_id | buyer_company_name      | store_type    | key_account | region_id | is_current_store | distribution_type | is_contacted | sample_sent | note    |
      | 1993              | 2588             | AT Buyer Cpn Success 01 | Grocery Store | false       | 53        | Yes              | pod_distributor   | false        | false       | [blank] |

    Given NGOC_ADMIN_17 open web admin
    When NGOC_ADMIN_17 login to web with role Admin
    And NGOC_ADMIN_17 navigate to "Vendors" to "Success forms" by sidebar
    And Admin go to create new vendor success form
    # Search buyer company with criteria buyer company
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | Yes        | Yes          | Pod is Distributor | No        | No         | [blank] |
     # Search buyer company with criteria region
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region              | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | Chicagoland Express | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin no found data in result
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region           | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | New York Express | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | Yes        | Yes          | Pod is Distributor | No        | No         | [blank] |
      # Search buyer company with criteria store type
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | Others    | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin no found data in result
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType     | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | Grocery Store | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | Yes        | Yes          | Pod is Distributor | No        | No         | [blank] |
    # Search buyer company with criteria key account
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | [blank]   | No         | [blank]          | [blank]          | [blank]      |
    And Admin no found data in result
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | [blank]   | Yes        | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | Yes        | Yes          | Pod is Distributor | No        | No         | [blank] |
     # Search buyer company with criteria distribution type
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | [blank]   | [blank]    | Self deliver     | [blank]          | [blank]      |
    And Admin no found data in result
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType   | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | [blank]   | [blank]    | Pod is Distributor | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | Yes        | Yes          | Pod is Distributor | No        | No         | [blank] |
       # Search buyer company with criteria filled or unfilled
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | [blank]   | [blank]    | [blank]          | Unfilled         | [blank]      |
    And Admin no found data in result
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | [blank]   | [blank]    | [blank]          | Filled           | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | Yes        | Yes          | Pod is Distributor | No        | No         | [blank] |
     # Search buyer company with criteria current store
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | In progress  |
    And Admin no found data in result
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | Yes          |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | Yes        | Yes          | Pod is Distributor | No        | No         | [blank] |
       # Search buyer company with all criteria
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region           | storeType     | keyAccount | distributionType   | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | New York Express | Grocery Store | Yes        | Pod is Distributor | Filled           | Yes          |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | Yes        | Yes          | Pod is Distributor | No        | No         | [blank] |
    # Edit filled store
    And Admin edit store list in create new form
      | buyerCompany            | currentStore | distributionType | contacted | sampleSent | note     |
      | AT Buyer Cpn Success 01 | In progress  | [blank]          | Yes       | Yes        | Autotest |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note     |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | Yes        | In progress  | Pod is Distributor | Yes       | Yes        | Autotest |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+successformv01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany            | region           | storeType | keyAccount | distributionType |
      | AT Buyer Cpn Success 01 | New York Express | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany            | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note     | podFoodsNotes |
      | AT Buyer Cpn Success 01 | Grocery Store | Yes        | In progress  | Pod is Distributor | Yes       | Yes        | Autotest | [blank]       |

    And Switch to actor NGOC_ADMIN_17
    And NGOC_ADMIN_17 refresh browser
    # Search store list with criteria vendor company
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail                           | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | atvendorsuccessform011231@podfoods.co | [blank]          | [blank]      | [blank]   |
    And Admin no found data in result
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | [blank]     | [blank]          | [blank]      | [blank]   |
    Then Admin verify store list after search in success form
      | vendorCompany             | vendorName | submittedDate | buyerCompany            | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note     |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | AT Buyer Cpn Success 01 | New York Express | Grocery Store | Yes        | In progress  | Pod is Distributor | Yes       | Yes        | [blank] | Autotest |

  @AdminVendor_06 @AdminVendor
  Scenario: Verify create new form of buyer company has only "Pending finance approval" orders
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "44203" by api
    And Admin delete order of sku "44203" by api
     # Change credit limit
    And Admin change credit limit of buyer company "2589" by API
      | buyer_company_id | id   | limit_value |
      | 2589             | 1133 | 10000       |
     # Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 104987             | 44203              | 11       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3498     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_17 open web admin
    When NGOC_ADMIN_17 login to web with role Admin
    And NGOC_ADMIN_17 navigate to "Vendors" to "Success forms" by sidebar
    And Admin go to create new vendor success form
    # Search buyer company with criteria buyer company
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany                 | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | ngoctx cpn financial pending | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany                 | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | ngoctx cpn financial pending | NY     | Grocery Store | No         | Yes          | Pod is Distributor | [blank]   | No         | [blank] |
    And NGOC_ADMIN_17 refresh browser
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | [blank]     | [blank]          | [blank]      | [blank]   |
    Then Admin verify store list after search in success form
      | vendorCompany             | vendorName | submittedDate | buyerCompany                 | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note    |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | ngoctx cpn financial pending | New York Express | Grocery Store | No         | Yes          | Pod is Distributor | [blank]   | No         | [blank] | [blank] |

  @AdminVendor_07 @AdminVendor
  Scenario: Check display of new created buyer companies / stores
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
       # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api
      # Delete buyer
    And Admin search buyer by API
      | q[any_text]           | q[full_name]          |
      | ngoctx successbuyer02 | ngoctx successbuyer02 |
    And Admin delete buyer all by API
          # Delete buyer
    And Admin search buyer by API
      | q[any_text]                | q[full_name]               |
      | ngoctx successbuyer02chi01 | ngoctx successbuyer02chi01 |
    And Admin delete buyer all by API
      # Delete buyer company
    When Admin search buyer company by API
      | buyerCompany            | managedBy | onboardingState | tag     |
      | AT Buyer Cpn Success 02 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API

     # Create buyer company by api
    And Admin create buyer company by API
      | name                    | ein    | launcher_id | manager_id | website                        | store_type_id |
      | AT Buyer Cpn Success 02 | 01-123 | 90          | 90         | https://auto.podfoods.co/login | 2             |
     # Create store by api
    And Admin create store by API
      | name                | email                             | region_id | time_zone                  | store_size | buyer_company_id | phone_number | city     | street1        | address_state_id | zip   | number | street           |
      | AT Store success 02 | ngoctx+storesuccess02@podfoods.co | 53        | Pacific Time (US & Canada) | <50k       | create by api    | 1234567890   | New York | 281 9th Avenue | 33               | 10001 | 1554   | West 18th Street |
     # Create buyer account
    And Admin create "store" buyer account by API
      | first_name | last_name      | email                             | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | ngoctx     | successbuyer02 | ngoctx+successbuyer02@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |

      # Create store by api
    And Admin create store by API
      | name                      | email                                  | region_id | time_zone                  | store_size | buyer_company_id | phone_number | city     | street1               | address_state_id | zip   | number | street           |
      | AT Store success 02 chi01 | ngoctx+storesuccess02chi01@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | create by api    | 1234567890   | New York | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
     # Create buyer account
    And Admin create "store" buyer account by API
      | first_name | last_name           | email                                  | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | ngoctx     | successbuyer02chi01 | ngoctx+successbuyer02chi01@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |

    Given NGOC_ADMIN_17 open web admin
    When NGOC_ADMIN_17 login to web with role Admin
    And NGOC_ADMIN_17 navigate to "Vendors" to "Success forms" by sidebar
     # Search store list with criteria vendor company
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | [blank]     | [blank]          | [blank]      | [blank]   |
    And Admin verify no found store "AT Buyer Cpn Success 02" list after search in success form

    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 03 | 44468              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

     # Create order
    Given Buyer login web with by api
      | email                             | password  |
      | ngoctx+successbuyer02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 44468 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+successformv01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany            | region           | storeType | keyAccount | distributionType |
      | AT Buyer Cpn Success 02 | New York Express | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany            | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note    | podFoodsNotes |
      | AT Buyer Cpn Success 02 | Grocery Store | -          | -            | -                | -         | No         | [blank] | [blank]       |

    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
    # Change info buyer company
    And Admin change info of buyer company "create by api" by API
      | store_type_id |
      | 3             |
    # Change tag buyer company
    And Admin add tag to buyer company "create by api" by API
      | tag_id | tag_name          |
      | 6      | private brand tag |
    # Verify store list of vendor after change info of buyer company
    And Switch to actor VENDOR
    And Vendor search info of store list
      | buyerCompany            | region           | storeType | keyAccount | distributionType |
      | AT Buyer Cpn Success 02 | New York Express | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany            | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note    | podFoodsNotes |
      | AT Buyer Cpn Success 02 | Grocery Store | -          | -            | -                | -         | No         | [blank] | [blank]       |

    And Switch to actor NGOC_ADMIN_17
    And Admin go to create new vendor success form
    And Admin verify message "Vendor company must exist" when edit buyer "AT Buyer Cpn Success 02" without vendor company in create new entity of success form
    # Search buyer company with criteria buyer company
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 02 | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
        # Edit filled store
    And Admin edit store list in create new form
      | buyerCompany            | currentStore | distributionType   | contacted | sampleSent | note     |
      | AT Buyer Cpn Success 02 | In progress  | Pod is Distributor | Yes       | Yes        | Autotest |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType | keyAccount | currentStore | distributionType   | contacted | sampleSent | note     |
      | AT Buyer Cpn Success 02 | NY     | Others    | Yes        | In progress  | Pod is Distributor | Yes       | Yes        | Autotest |

    And Switch to actor VENDOR
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany            | region           | storeType | keyAccount | distributionType |
      | AT Buyer Cpn Success 02 | New York Express | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany            | storeType | keyAccount | currentStore | distributionType   | contacted | sampleSent | note     | podFoodsNotes |
      | AT Buyer Cpn Success 02 | Others    | Yes        | In progress  | Pod is Distributor | Yes       | Yes        | Autotest | [blank]       |

    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
       # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api

    And Switch to actor VENDOR
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany            | region           | storeType | keyAccount | distributionType |
      | AT Buyer Cpn Success 02 | New York Express | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany            | storeType | keyAccount | currentStore | distributionType   | contacted | sampleSent | note     | podFoodsNotes |
      | AT Buyer Cpn Success 02 | Others    | Yes        | In progress  | Pod is Distributor | Yes       | Yes        | Autotest | [blank]       |

  @AdminVendor_07 @AdminVendor
  Scenario: Buyer company has only orders with only OOS / LS items
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
     # Delete order
    When Search order by sku "44476" by api
    And Admin delete order of sku "44476" by api
     # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 03 | 44468              | 1        | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 105357             | 44476              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3511     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_17 open web admin
    When NGOC_ADMIN_17 login to web with role Admin
    And NGOC_ADMIN_17 navigate to "Vendors" to "Success forms" by sidebar
     # Search store list with criteria vendor company
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | [blank]     | [blank]          | [blank]      | [blank]   |
    Then Admin verify store list after search in success form
      | vendorCompany             | vendorName | submittedDate | buyerCompany          | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note    |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | AT Buyer Cpn only oos | New York Express | Grocery Store | No         | Yes          | Pod is Distributor | [blank]   | No         | [blank] | [blank] |
    And Admin go to create new vendor success form
    # Search buyer company with criteria buyer company
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany          | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn only oos | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany          | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn only oos | NY     | Grocery Store | No         | Yes          | Pod is Distributor | [blank]   | No         | [blank] |

  @AdminVendor_09 @AdminVendor
  Scenario: Buyer company has only orders with only deleted item items
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
    # Change info buyer company
    And Admin change info of buyer company "2601" by API
      | store_type_id |
      | 2             |
     # Delete order
    When Search order by sku "44203" by api
    And Admin delete order of sku "44203" by api
      # Create inventory
    And Admin create inventory api1
      | index | sku                    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Success Form 01 | 44203              | 1        | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 104987             | 44203              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3512     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_17 open web admin
    When NGOC_ADMIN_17 login to web with role Admin
    And NGOC_ADMIN_17 navigate to "Vendors" to "Success forms" by sidebar
     # Search store list with criteria vendor company
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | [blank]     | [blank]          | [blank]      | [blank]   |
    Then Admin verify store list after search in success form
      | vendorCompany             | vendorName | submittedDate | buyerCompany             | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note    |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | AT Buyer Cpn only delete | New York Express | Grocery Store | No         | Yes          | Pod is Distributor | [blank]   | No         | [blank] | [blank] |
    And Admin go to create new vendor success form
    # Search buyer company with criteria buyer company
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany             | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn only delete | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany             | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn only delete | NY     | Grocery Store | No         | Yes          | Pod is Distributor | [blank]   | No         | [blank] |

    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
    # Change info buyer company
    And Admin change info of buyer company "2601" by API
      | store_type_id |
      | 3             |
    # Change tag buyer company
    And Admin add tag to buyer company "2601" by API
      | tag_id | tag_name          |
      | 6      | private brand tag |

    And Switch to actor NGOC_ADMIN_17
    And NGOC_ADMIN_17 refresh browser
    # Search store list with criteria vendor company
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | [blank]     | [blank]          | [blank]      | [blank]   |
    Then Admin verify store list after search in success form
      | vendorCompany             | vendorName | submittedDate | buyerCompany             | region           | storeType | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note    |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | AT Buyer Cpn only delete | New York Express | Others    | Yes        | Yes          | Pod is Distributor | [blank]   | No         | [blank] | [blank] |
    And Admin go to create new vendor success form
    # Search buyer company with criteria buyer company
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany             | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn only delete | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany             | region | storeType | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn only delete | NY     | Others    | Yes        | Yes          | Pod is Distributor | [blank]   | No         | [blank] |

    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
    # Change tag buyer company
    And Admin remove tag to buyer company "2601" by API
    And Switch to actor NGOC_ADMIN_17
    And NGOC_ADMIN_17 refresh browser
    # Search store list with criteria vendor company
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | [blank]     | [blank]          | [blank]      | [blank]   |
    Then Admin verify store list after search in success form
      | vendorCompany             | vendorName | submittedDate | buyerCompany             | region           | storeType | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note    |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | AT Buyer Cpn only delete | New York Express | Others    | No         | Yes          | Pod is Distributor | [blank]   | No         | [blank] | [blank] |
    And Admin go to create new vendor success form
    # Search buyer company with criteria buyer company
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany             | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn only delete | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany             | region | storeType | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn only delete | NY     | Others    | No         | Yes          | Pod is Distributor | [blank]   | No         | [blank] |

  @AdminVendor_10 @AdminVendor
  Scenario: Check display of buyer companies when they has requested a sample of the vendor brands
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
    And Admin search store list in success form by API
      | q[vendor_company_id] |
      | 1993                 |
     # Edit buyer company in admin vendor create new success form
    And Admin edit store list "AT Buyer Cpn Success 01" in success form detail by API
      | buyer_company_name      | vendor_company_name       | vendor_name | distribution_type | is_contacted | is_current_store | key_account | note     | region_name      | sample_sent | show_admin_note | status  | store_type    | submitted_date | admin_note |
      | AT Buyer Cpn Success 01 | AT Vendor Success Form 01 | [blank]     | pod_distributor   | true         | true             | false       | Autotest | New York Express | true        | false           | [blank] | Grocery Store | [blank]        | [blank]    |
    # Delete order
    When Search order by sku "44203" by api
    And Admin delete order of sku "44203" by api
      # Create inventory
    And Admin create inventory api1
      | index | sku                    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Success Form 01 | 44203              | 1        | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 104987             | 44203              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3486     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create sample
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | 44203              | 104987             |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1             | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state |
      | 3486      | 3486     | 15203       | 3191     | 1993              | invoice      | [blank] | 281 Columbus Avenue | New York | 33               | NY                 | New York           | 10001 | [blank]          | pending           |

    Given NGOC_ADMIN_17 open web admin
    When NGOC_ADMIN_17 login to web with role Admin
    And NGOC_ADMIN_17 navigate to "Vendors" to "Success forms" by sidebar
     # Search store list with criteria vendor company
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | [blank]     | [blank]          | [blank]      | [blank]   |
    Then Admin verify store list after search in success form
      | vendorCompany             | vendorName | submittedDate | buyerCompany            | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note    |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | AT Buyer Cpn Success 01 | New York Express | Grocery Store | No         | Yes          | Pod is Distributor | [blank]   | Yes        | [blank] | [blank] |
    And Admin go to create new vendor success form
    # Search buyer company with criteria buyer company
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | No         | Yes          | Pod is Distributor | [blank]   | Yes        | [blank] |
    # Cancel sample request
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
    And Admin search sample request by API
      | field                | value   |
      | q[brand_id]          | 3368    |
      | q[region_id]         | 53      |
      | q[store_id]          | 3191    |
      | q[fulfillment_state] | pending |
    And Admin cancel all sample request by API

    And Switch to actor NGOC_ADMIN_17
    And NGOC_ADMIN_17 refresh browser
    And NGOC_ADMIN_17 navigate to "Vendors" to "Success forms" by sidebar
    And Admin go to create new vendor success form
    # Search buyer company with criteria buyer company
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | No         | Yes          | Pod is Distributor | [blank]   | Yes        | [blank] |
    And Admin close popup create new vendor success form
    # Search store list with criteria vendor company
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | [blank]     | [blank]          | [blank]      | [blank]   |
    Then Admin verify store list after search in success form
      | vendorCompany             | vendorName | submittedDate | buyerCompany            | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note    |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | AT Buyer Cpn Success 01 | New York Express | Grocery Store | No         | Yes          | Pod is Distributor | [blank]   | Yes        | [blank] | [blank] |
    And Admin go to edit store list "AT Buyer Cpn Success 01" in success form
    Then Admin verify edit detail in success form
      | vendorCompany             | buyerCompany            | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note     | adminNote | showOnVendor |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | New York Express | Grocery Store | No         | Yes          | Pod is Distributor | Yes       | Yes        | [blank] | Autotest | [blank]   | No           |
    And Admin edit detail store list "AT Buyer Cpn Success 01" in success form
      | currentStore | distributionType | contacted | sampleSent | status   | adminNote       | showOnVendor |
      | In progress  | Self deliver     | No        | No         | Accepted | Admin Auto Test | [blank]      |
    And Admin update edit detail store list error in success form then see message "Distribution type cannot be updated once it's"
    And Admin edit detail store list "AT Buyer Cpn Success 01" in success form
      | currentStore | distributionType   | contacted | sampleSent | status   | adminNote       | showOnVendor |
      | In progress  | Pod is Distributor | No        | No         | Accepted | Admin Auto Test | Yes          |
    And Admin update success edit detail store list in success form
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | [blank]     | [blank]          | [blank]      | [blank]   |
    Then Admin verify store list after search in success form
      | vendorCompany             | vendorName | submittedDate | buyerCompany            | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status   | note     |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | AT Buyer Cpn Success 01 | New York Express | Grocery Store | No         | In progress  | Pod is Distributor | No        | No         | Accepted | Autotest |

    And Admin go to create new vendor success form
    # Search buyer company with criteria buyer company
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note     |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | No         | In progress  | Pod is Distributor | No        | No         | Autotest |
    And Admin close popup create new vendor success form

    Given VENDOR open web user
    When login to beta web with email "ngoctx+successformv01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany            | region           | storeType | keyAccount | distributionType |
      | AT Buyer Cpn Success 01 | New York Express | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany            | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note     | podFoodsNotes   |
      | AT Buyer Cpn Success 01 | Grocery Store | -          | In progress  | Pod is Distributor | No        | No         | Autotest | Admin Auto Test |

  @AdminVendor_11 @AdminVendor
  Scenario: Verify editing a success form on the Mass editing form
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
    And Admin search store list in success form by API
      | q[vendor_company_id] |
      | 1993                 |
     # Edit buyer company in admin vendor create new success form
    And Admin edit store list "AT Buyer Cpn Success 01" in success form detail by API
      | buyer_company_name      | vendor_company_name       | vendor_name | distribution_type | is_contacted | is_current_store | key_account | note     | region_name      | sample_sent | show_admin_note | status  | store_type    | submitted_date | admin_note |
      | AT Buyer Cpn Success 01 | AT Vendor Success Form 01 | [blank]     | pod_distributor   | true         | false            | false       | Autotest | New York Express | true        | false           | [blank] | Grocery Store | [blank]        | [blank]    |

    Given NGOC_ADMIN_17 open web admin
    When NGOC_ADMIN_17 login to web with role Admin
    And NGOC_ADMIN_17 navigate to "Buyers" to "Buyer companies" by sidebar
    # Search by name
    And Admin search buyer company
      | name                    | managedBy | status  | tag     |
      | AT Buyer Cpn Success 02 | [blank]   | [blank] | [blank] |
    And Admin go to detail of buyer company "AT Buyer Cpn Success 02"
    And Admin verify edit store type field in buyer company detail
      | storeType     |
      | Grocery Store |
    And Admin remove tag field in buyer company detail
      | tag               |
      | private brand tag |

    And NGOC_ADMIN_17 navigate to "Vendors" to "Success forms" by sidebar
    And Admin go to mass editing in success form
    # Search by criteria Vendor company
    And Admin search store list in mass editing popup
      | vendorCompany             | buyerCompany | region  | storeType | distributionType | filledOrUnfilled |
      | AT Vendor Success Form 01 | [blank]      | [blank] | [blank]   | [blank]          | [blank]          |
    And Admin verify store list in mass editing popup
      | buyerCompany            | region           | storeType     | currentStore | distributionType   |
      | AT Buyer Cpn Success 01 | New York Express | Grocery Store | In progress  | Pod is Distributor |
      | AT Buyer Cpn Success 02 | New York Express | Grocery Store | In progress  | Pod is Distributor |
     # Search by criteria Buyer Company
    And Admin search store list in mass editing popup
      | vendorCompany | buyerCompany            | region  | storeType | distributionType | filledOrUnfilled |
      | [blank]       | AT Buyer Cpn Success 01 | [blank] | [blank]   | [blank]          | [blank]          |
    And Admin verify store list in mass editing popup
      | buyerCompany            | region           | storeType     | currentStore | distributionType   |
      | AT Buyer Cpn Success 01 | New York Express | Grocery Store | In progress  | Pod is Distributor |
    # Search by criteria Region
    And Admin search store list in mass editing popup
      | vendorCompany | buyerCompany            | region          | storeType | distributionType | filledOrUnfilled |
      | [blank]       | AT Buyer Cpn Success 01 | Florida Express | [blank]   | [blank]          | [blank]          |
    And Admin no found data in popup result
    And Admin search store list in mass editing popup
      | vendorCompany | buyerCompany            | region           | storeType | distributionType | filledOrUnfilled |
      | [blank]       | AT Buyer Cpn Success 01 | New York Express | [blank]   | [blank]          | [blank]          |
    And Admin verify store list in mass editing popup
      | buyerCompany            | region           | storeType     | currentStore | distributionType   |
      | AT Buyer Cpn Success 01 | New York Express | Grocery Store | In progress  | Pod is Distributor |
    # Search by criteria Store type
    And Admin search store list in mass editing popup
      | vendorCompany | buyerCompany            | region  | storeType         | distributionType | filledOrUnfilled |
      | [blank]       | AT Buyer Cpn Success 01 | [blank] | Grocery Storezz<> | [blank]          | [blank]          |
    And Admin no found data in popup result
    And Admin search store list in mass editing popup
      | vendorCompany | buyerCompany            | region           | storeType     | distributionType | filledOrUnfilled |
      | [blank]       | AT Buyer Cpn Success 01 | New York Express | Grocery Store | [blank]          | [blank]          |
    And Admin verify store list in mass editing popup
      | buyerCompany            | region           | storeType     | currentStore | distributionType   |
      | AT Buyer Cpn Success 01 | New York Express | Grocery Store | In progress  | Pod is Distributor |
    # Search by criteria Distribution type
    And Admin search store list in mass editing popup
      | vendorCompany | buyerCompany            | region  | storeType | distributionType | filledOrUnfilled |
      | [blank]       | AT Buyer Cpn Success 01 | [blank] | [blank]   | Self deliver     | [blank]          |
    And Admin no found data in popup result
    And Admin search store list in mass editing popup
      | vendorCompany | buyerCompany            | region           | storeType | distributionType   | filledOrUnfilled |
      | [blank]       | AT Buyer Cpn Success 01 | New York Express | [blank]   | Pod is Distributor | [blank]          |
    And Admin verify store list in mass editing popup
      | buyerCompany            | region           | storeType     | currentStore | distributionType   |
      | AT Buyer Cpn Success 01 | New York Express | Grocery Store | In progress  | Pod is Distributor |
     # Search by criteria Filled Or Unfilled
    And Admin search store list in mass editing popup
      | vendorCompany | buyerCompany            | region  | storeType | distributionType | filledOrUnfilled |
      | [blank]       | AT Buyer Cpn Success 01 | [blank] | [blank]   | [blank]          | Unfilled         |
    And Admin no found data in popup result
    And Admin search store list in mass editing popup
      | vendorCompany | buyerCompany            | region           | storeType | distributionType | filledOrUnfilled |
      | [blank]       | AT Buyer Cpn Success 01 | New York Express | [blank]   | [blank]          | Filled           |
    And Admin verify store list in mass editing popup
      | buyerCompany            | region           | storeType     | currentStore | distributionType   |
      | AT Buyer Cpn Success 01 | New York Express | Grocery Store | In progress  | Pod is Distributor |
     # Search by all criteria
    And Admin search store list in mass editing popup
      | vendorCompany             | buyerCompany            | region           | storeType     | distributionType   | filledOrUnfilled |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | New York Express | Grocery Store | Pod is Distributor | Filled           |
    And Admin verify store list in mass editing popup
      | buyerCompany            | region           | storeType     | currentStore | distributionType   |
      | AT Buyer Cpn Success 01 | New York Express | Grocery Store | In progress  | Pod is Distributor |
    And Admin choose store list to edit in mass editing
      | buyerCompany            |
      | AT Buyer Cpn Success 01 |
    And Admin edit detail store list in mass editing
      | currentStore | distributionType | contacted | sampleSent | note           |
      | Yes          | Self deliver     | Yes       | Yes        | Auto Mass Edit |
    And Admin update after edit detail store list in mass editing then see error "Validation failed: Distribution type cannot be updated once it's"
    And Admin edit detail store list in mass editing
      | currentStore | distributionType   | contacted | sampleSent | note           |
      | Yes          | Pod is Distributor | Yes       | Yes        | Auto Mass Edit |
    And Admin update after edit detail store list in mass editing
    # Verify after edit
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | [blank]     | [blank]          | [blank]      | [blank]   |
    Then Admin verify store list after search in success form
      | vendorCompany             | vendorName | submittedDate | buyerCompany            | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note           |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | AT Buyer Cpn Success 01 | New York Express | Grocery Store | No         | Yes          | Pod is Distributor | [blank]   | Yes        | [blank] | Auto Mass Edit |
    And Admin go to edit store list "AT Buyer Cpn Success 01" in success form
    Then Admin verify edit detail in success form
      | vendorCompany             | buyerCompany            | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note           | adminNote | showOnVendor |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | New York Express | Grocery Store | No         | Yes          | Pod is Distributor | Yes       | Yes        | [blank] | Auto Mass Edit | [blank]   | [blank]      |
    And NGOC_ADMIN_17 refresh browser
    And Admin go to create new vendor success form
    # Search buyer company with criteria buyer company
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note           |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | No         | Yes          | Pod is Distributor | Yes       | Yes        | Auto Mass Edit |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+successformv01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany            | region           | storeType | keyAccount | distributionType |
      | AT Buyer Cpn Success 01 | New York Express | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany            | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note           | podFoodsNotes |
      | AT Buyer Cpn Success 01 | Grocery Store | -          | Yes          | Pod is Distributor | Yes       | Yes        | Auto Mass Edit | -             |

  @AdminVendor_12 @AdminVendor
  Scenario: Verify editing multi line item a success form on the Mass editing form
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
    And Admin search store list in success form by API
      | q[vendor_company_id] |
      | 1993                 |
     # Edit buyer company in admin vendor create new success form
    And Admin edit store list "AT Buyer Cpn Success 01" in success form detail by API
      | buyer_company_name      | vendor_company_name       | vendor_name | distribution_type | is_contacted | is_current_store | key_account | note     | region_name      | sample_sent | show_admin_note | status  | store_type    | submitted_date | admin_note |
      | AT Buyer Cpn Success 01 | AT Vendor Success Form 01 | [blank]     | pod_distributor   | true         | false            | false       | Autotest | New York Express | true        | false           | [blank] | Grocery Store | [blank]        | [blank]    |
     # Edit buyer company in admin vendor create new success form
    And Admin edit store list "AT Buyer Cpn Success 02" in success form detail by API
      | buyer_company_name      | vendor_company_name       | vendor_name | distribution_type | is_contacted | is_current_store | key_account | note     | region_name      | sample_sent | show_admin_note | status  | store_type    | submitted_date | admin_note |
      | AT Buyer Cpn Success 02 | AT Vendor Success Form 02 | [blank]     | pod_distributor   | true         | false            | false       | Autotest | New York Express | true        | false           | [blank] | Grocery Store | [blank]        | [blank]    |

    Given NGOC_ADMIN_17 open web admin
    When NGOC_ADMIN_17 login to web with role Admin
    And NGOC_ADMIN_17 navigate to "Vendors" to "Success forms" by sidebar
    And Admin go to mass editing in success form
    # Search by criteria Vendor company
    And Admin search store list in mass editing popup
      | vendorCompany             | buyerCompany | region  | storeType | distributionType | filledOrUnfilled |
      | AT Vendor Success Form 01 | [blank]      | [blank] | [blank]   | [blank]          | [blank]          |
    And Admin verify store list in mass editing popup
      | buyerCompany            | region           | storeType     | currentStore | distributionType   |
      | AT Buyer Cpn Success 01 | New York Express | Grocery Store | In progress  | Pod is Distributor |
      | AT Buyer Cpn Success 02 | New York Express | Grocery Store | In progress  | Pod is Distributor |
    # edit store list without selected any checkbox
    And Admin edit detail store list in mass editing
      | currentStore | distributionType   | contacted | sampleSent | note           |
      | Yes          | Pod is Distributor | Yes       | Yes        | Auto Mass Edit |
    And Admin update after edit detail store list in mass editing
      # Verify after edit
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | [blank]     | [blank]          | [blank]      | [blank]   |
    Then Admin verify store list after search in success form
      | vendorCompany             | vendorName | submittedDate | buyerCompany            | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note     |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | AT Buyer Cpn Success 01 | New York Express | Grocery Store | No         | In progress  | Pod is Distributor | [blank]   | Yes        | [blank] | Autotest |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | AT Buyer Cpn Success 02 | New York Express | Grocery Store | No         | In progress  | Pod is Distributor | [blank]   | Yes        | [blank] | Autotest |
    And Admin go to mass editing in success form
    # Search by criteria Vendor company
    And Admin search store list in mass editing popup
      | vendorCompany             | buyerCompany | region  | storeType | distributionType | filledOrUnfilled |
      | AT Vendor Success Form 01 | [blank]      | [blank] | [blank]   | [blank]          | [blank]          |
    And Admin verify store list in mass editing popup
      | buyerCompany            | region           | storeType     | currentStore | distributionType   |
      | AT Buyer Cpn Success 01 | New York Express | Grocery Store | In progress  | Pod is Distributor |
      | AT Buyer Cpn Success 02 | New York Express | Grocery Store | In progress  | Pod is Distributor |
    And Admin choose store list to edit in mass editing
      | buyerCompany            |
      | AT Buyer Cpn Success 01 |
      | AT Buyer Cpn Success 02 |
    And Admin edit detail store list in mass editing
      | currentStore | distributionType | contacted | sampleSent | note           |
      | Yes          | Self deliver     | Yes       | Yes        | Auto Mass Edit |
    And Admin update after edit detail store list in mass editing then see error "Validation failed: Distribution type cannot be updated once it's"
    And Admin edit detail store list in mass editing
      | currentStore | distributionType   | contacted | sampleSent | note           |
      | Yes          | Pod is Distributor | Yes       | Yes        | Auto Mass Edit |
    And Admin update after edit detail store list in mass editing
    # Verify after edit
    And Admin search store list in success form
      | vendorCompany             | brand   | vendor  | vendorEmail | distributionType | currentStore | managedBy |
      | AT Vendor Success Form 01 | [blank] | [blank] | [blank]     | [blank]          | [blank]      | [blank]   |
    Then Admin verify store list after search in success form
      | vendorCompany             | vendorName | submittedDate | buyerCompany            | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note           |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | AT Buyer Cpn Success 01 | New York Express | Grocery Store | No         | Yes          | Pod is Distributor | [blank]   | Yes        | [blank] | Auto Mass Edit |
      | AT Vendor Success Form 01 | [blank]    | [blank]       | AT Buyer Cpn Success 02 | New York Express | Grocery Store | No         | Yes          | Pod is Distributor | [blank]   | Yes        | [blank] | Auto Mass Edit |

    And Admin go to edit store list "AT Buyer Cpn Success 01" in success form
    Then Admin verify edit detail in success form
      | vendorCompany             | buyerCompany            | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note           | adminNote | showOnVendor |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 01 | New York Express | Grocery Store | No         | Yes          | Pod is Distributor | Yes       | Yes        | [blank] | Auto Mass Edit | [blank]   | [blank]      |
    And Admin close popup store list detail in success form

    And Admin go to edit store list "AT Buyer Cpn Success 02" in success form
    Then Admin verify edit detail in success form
      | vendorCompany             | buyerCompany            | region           | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | status  | note           | adminNote | showOnVendor |
      | AT Vendor Success Form 01 | AT Buyer Cpn Success 02 | New York Express | Grocery Store | No         | Yes          | Pod is Distributor | Yes       | Yes        | [blank] | Auto Mass Edit | [blank]   | [blank]      |
    And Admin close popup store list detail in success form

    And NGOC_ADMIN_17 refresh browser
    And Admin go to create new vendor success form
    # Search buyer company with criteria buyer company
    And Admin search buyer in create new entity of success form
      | vendorCompany             | buyerCompany | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | AT Vendor Success Form 01 | [blank]      | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note           |
      | AT Buyer Cpn Success 01 | NY     | Grocery Store | No         | Yes          | Pod is Distributor | Yes       | Yes        | Auto Mass Edit |
      | AT Buyer Cpn Success 02 | NY     | Grocery Store | No         | Yes          | Pod is Distributor | Yes       | Yes        | Auto Mass Edit |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+successformv01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany            | region           | storeType | keyAccount | distributionType |
      | AT Buyer Cpn Success 01 | New York Express | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany            | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note           | podFoodsNotes |
      | AT Buyer Cpn Success 01 | Grocery Store | -          | Yes          | Pod is Distributor | Yes       | Yes        | Auto Mass Edit | -             |
    And Vendor search info of store list
      | buyerCompany            | region           | storeType | keyAccount | distributionType |
      | AT Buyer Cpn Success 02 | New York Express | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany            | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note           | podFoodsNotes |
      | AT Buyer Cpn Success 02 | Grocery Store | -          | Yes          | Pod is Distributor | Yes       | Yes        | Auto Mass Edit | -             |

  @AdminVendor_13 @AdminVendor
  Scenario: Verify adding special buyer company
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
    And Admin get id special buyer company by API
    And Admin delete special buyer company by API
    # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api
    # Create order
    Given Buyer login web with by api
      | email                             | password  |
      | ngoctx+successbuyer02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 44468 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_17 open web admin
    When NGOC_ADMIN_17 login to web with role Admin
    And NGOC_ADMIN_17 navigate to "Vendors" to "Success forms" by sidebar
    And Admin go to add special buyer company in success form
    And Admin add special buyer company in success form
      | buyerCompany            | region          |
      | AT Buyer Cpn Success 02 | Florida Express |
    Then Admin add special buyer company in success form then see message "There is no active stores in this region"
    And Admin add special buyer company in success form
      | buyerCompany            | region           |
      | AT Buyer Cpn Success 02 | New York Express |
    Then Admin add special buyer company in success form then see message "Store list have been added successfully!"
    And Admin add special buyer company in success form
      | buyerCompany            | region           |
      | AT Buyer Cpn Success 02 | New York Express |
    Then Admin add special buyer company in success form then see message "Region has already been taken"
    And Admin verify buyer company in add special in success form
      | store                   | region | storeType     | date        | managedBy |
      | AT Buyer Cpn Success 02 | NY     | Grocery Store | currentDate | ngoctx16  |

    And NGOC_ADMIN_17 refresh browser
    And Admin go to create new vendor success form
    # Search buyer company with criteria buyer company
    And Admin search buyer in create new entity of success form
      | vendorCompany | buyerCompany            | region  | storeType | keyAccount | distributionType | filledOrUnfilled | currentStore |
      | [blank]       | AT Buyer Cpn Success 02 | [blank] | [blank]   | [blank]    | [blank]          | [blank]          | [blank]      |
    And Admin verify buyer after search in create new entity of success form
      | buyerCompany            | region | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note    |
      | AT Buyer Cpn Success 02 | NY     | Grocery Store | No         | [blank]      | [blank]          | [blank]   | No         | [blank] |
    # Delete special buyer company
    And NGOC_ADMIN_17 refresh browser
    And Admin go to add special buyer company in success form
    And Admin delete special buyer company "AT Buyer Cpn Success 02" in success form

  @AdminVendor_14 @AdminVendor
  Scenario: Verify admin bulk update vendor companies
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
    # Change general information of vendor company
    And Admin change general information of vendor company "2024"
      | manager_id | launcher_id | referral_buyer_company_ids |
      | [blank]    | [blank]     | [blank]                    |

    Given NGOC_ADMIN_17 open web admin
    When NGOC_ADMIN_17 login to web with role Admin
    And NGOC_ADMIN_17 navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name                      | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Vendor Company Bulk 01 | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin select vendor company in result
      | vendorCompany             |
      | AT Vendor Company Bulk 01 |
    And Admin search vendor company
      | name                      | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Vendor Company Bulk 02 | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin select vendor company in result
      | vendorCompany             |
      | AT Vendor Company Bulk 02 |
    And Admin clear section bulk edit in result
    And Admin search vendor company
      | name                      | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Vendor Company Bulk 01 | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin select vendor company in result
      | vendorCompany             |
      | AT Vendor Company Bulk 01 |
    And Admin search vendor company
      | name                      | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | AT Vendor Company Bulk 02 | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin select vendor company in result
      | vendorCompany             |
      | AT Vendor Company Bulk 02 |
    And Admin go to bulk edit in result
    And Admin update bulk vendor company
      | managedBy | launchedBy | referredBy     |
      | ngoctx17  | ngoctx17   | ngoc cpn claim |
    And Admin update bulk vendor company success

    And Admin go to detail vendor company "AT Vendor Company Bulk 02"
    Then Admin verify general info vendor company
      | state  | name                      | ein     | companySize | avg     | manager  | launcher | referredName   |
      | Active | AT Vendor Company Bulk 02 | [blank] | <25k        | [blank] | ngoctx17 | ngoctx17 | ngoc cpn claim |
    And Admin go to vendor company "2023" by url
    Then Admin verify general info vendor company
      | state  | name                      | ein     | companySize | avg     | manager  | launcher | referredName   |
      | Active | AT Vendor Company Bulk 01 | [blank] | <25k        | [blank] | ngoctx17 | ngoctx17 | ngoc cpn claim |

  @AdminVendor_15
  Scenario: Admin verify filter admin vendor
    Given NGOCTX27 login web admin by api
      | email                | password  |
      | ngoctx17@podfoods.co | 12345678a |
     # Reset search filter full textbox
    And Admin filter visibility with id "14" by api
      | q[full_name]                               |
      | q[email]                                   |
      | q[vendor_company_id]                       |
      | q[brand_id]                                |
      | region_id                                  |
      | q[vendor_company_address_city]             |
      | q[vendor_company_address_address_state_id] |
      | q[tag_ids][]                               |
      | q[approved]                                |
      | q[active_state]                            |
      | q[shopify]                                 |

    Given NGOC_ADMIN_27 open web admin
    When login to beta web with email "ngoctx17@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_27 navigate to "Vendors" to "All vendors" by sidebar
     # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | fullName | email   | vendorCompany | brand   | region  | addressCity | addressState | tags    | approved | shopify | status  |
      | [blank]  | [blank] | [blank]       | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank]  | [blank] | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | fullName | email   | vendorCompany | brand   | region  | addressCity | addressState | tags    | approved | shopify | active_state_vendor |
      | [blank]  | [blank] | [blank]       | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank]  | [blank] | [blank]             |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | fullName | email   | vendorCompany | brand   | region  | addressCity | addressState | tags    | approved | shopify | status  |
      | [blank]  | [blank] | [blank]       | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank]  | [blank] | [blank] |
    Then Admin verify field search in edit visibility
      | fullName | email   | vendorCompany | brand   | region  | addressCity | addressState | tags    | approved | shopify | active_state_vendor |
      | [blank]  | [blank] | [blank]       | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank]  | [blank] | [blank]             |
    # Verify save new filter
    And Admin search vendors
      | fullName    | email                   | vendorCompany | brand          | region              | address                  | state    | tags               | approved | shopify | status |
      | ngoctx v101 | ngoctx+v101@podfoods.co | ngoc vc 1     | AT Brand Order | Chicagoland Express | 1455 West Cellular Drive | Illinois | all private target | Yes      | Yes     | Active |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | fullName    | email                   | vendorCompany | brand          | region              | address                  | state    | tags               | approved | shopify | activeState |
      | ngoctx v101 | ngoctx+v101@podfoods.co | ngoc vc 1     | AT Brand Order | Chicagoland Express | 1455 West Cellular Drive | Illinois | all private target | Yes      | Yes     | Active      |
    # Verify save as filter
    And Admin search vendors
      | fullName    | email                   | vendorCompany | brand          | region          | address                  | state   | tags               | approved | shopify | status   |
      | ngoctx v102 | ngoctx+v102@podfoods.co | ngoc vc 1     | AT Brand Order | Atlanta Express | 1455 West Cellular Drive | Florida | all private target | No       | No      | Inactive |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | fullName    | email                   | vendorCompany | brand          | region              | address                  | state    | tags               | approved | shopify | activeState |
      | ngoctx v101 | ngoctx+v101@podfoods.co | ngoc vc 1     | AT Brand Order | Chicagoland Express | 1455 West Cellular Drive | Illinois | all private target | Yes      | Yes     | Active      |


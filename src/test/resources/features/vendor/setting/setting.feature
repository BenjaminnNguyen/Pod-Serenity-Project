@feature=Setting
Feature: Setting

  @VendorSetting01 @Setting
  Scenario: Verify vendor general setting
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx25@podfoods.co | 12345678a |
     # Change general information of vendor company
    And Admin change general information of vendor company "2035"
      | manager_id | launcher_id | referral_buyer_company_ids | email                       | contact_number | website       | legal_entity_name | ein    | company_size | show_all_tabs |
      | [blank]    | [blank]     | [blank]                    | ngocvcsetting01@podfoods.co | 1234567890     | vcsetting.com | setting legal     | 123456 | <25k         | false         |
    And Admin change address of vendor company "2035"
      | attn    | full_name | street1        | street2 | city     | address_state_id | zip   | phone_number | address_state_code | address_state_name | lat     | lng     | number | street     |
      | [blank] | [blank]   | 281 9th Avenue | [blank] | New York | 33               | 10001 | [blank]      | IL                 | Illinois           | [blank] | [blank] | 281    | 9th Avenue |
     # Change general information of vendor
    And Admin change info of vendor "2013"
      | email                          | first_name | last_name   | password  |
      | ngoctx+vcsetting01@podfoods.co | ngoctx     | vcsetting01 | 12345678a |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+vcsetting01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Settings" by sidebar
    And Vendor go to general
    # Verify company information
    And Vendor verify company information in general settings
      | companyName        | ein    | email                       | phone      | website       | size | street         | apt     | city     | state    | zip   |
      | ngoc vc setting 01 | 123456 | ngocvcsetting01@podfoods.co | 1234567890 | vcsetting.com | <25k | 281 9th Avenue | [blank] | New York | New York | 10001 |
    Then Admin verify field company name in edit company info of setting
    Then Admin verify field company zip code in edit company info of setting
    And Vendor go to edit company information in general settings
    And Vendor verify info of edit company information in general settings
      | companyName        | ein    | email                       | phone      | website       | size | street         | apt     | city     | state    | zip   |
      | ngoc vc setting 01 | 123456 | ngocvcsetting01@podfoods.co | 1234567890 | vcsetting.com | <25k | 281 9th Avenue | [blank] | New York | New York | 10001 |
    And Vendor edit company information in general settings
      | companyName             | ein       | size    | email                           | phone      | website           | street                | apt | city    | state    | zip   |
      | ngoc vc setting 01 edit | 123456789 | 25k-50k | ngocvcsetting01edit@podfoods.co | 1234567891 | vcsettingedit.com | 1554 West 18th Street | apt | Chicago | Illinois | 60608 |
    And Vendor edit success in general settings
    And Vendor verify company information in general settings
      | companyName             | ein       | email                           | phone      | website           | size    | street                | apt | city    | state    | zip   |
      | ngoc vc setting 01 edit | 123456789 | ngocvcsetting01edit@podfoods.co | 1234567891 | vcsettingedit.com | 25k-50k | 1554 West 18th Street | apt | Chicago | Illinois | 60608 |
    # Verify personal
    Then Vendor verify personal in general settings
      | firstName | lastName    | email                          |
      | ngoctx    | vcsetting01 | ngoctx+vcsetting01@podfoods.co |
    Then Admin verify field in edit personal info of setting
    And Vendor go to edit personal in general settings
    Then Vendor verify edit personal in general settings
      | firstName | lastName    | email                          |
      | ngoctx    | vcsetting01 | ngoctx+vcsetting01@podfoods.co |
    When Vendor edit personal in general settings
      | firstName  | lastName        | email                              |
      | ngoctxEdit | vcsetting01Edit | ngoctx+vcsetting01edit@podfoods.co |
    And Vendor edit success in general settings
    Then Vendor verify personal in general settings
      | firstName  | lastName        | email                              |
      | ngoctxEdit | vcsetting01Edit | ngoctx+vcsetting01edit@podfoods.co |
    And VENDOR refresh browser

    When login to beta web with email "ngoctx+vcsetting01edit@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Settings" by sidebar
    And Vendor go to general
    When Vendor go to change password in general settings
    And Vendor change password in general settings
      | currentPassword | newPassword | confirm   |
      | 12345678        | 12345678a   | 12345678a |
    And Vendor change password error then see message "Current password is invalid"
    And Vendor change password in general settings
      | currentPassword | newPassword | confirm    |
      | 12345678a       | 123456789a  | 123456789a |
    And Vendor change password success
#
    When login to beta web with email "ngoctx+vcsetting01edit@podfoods.co" pass "123456789a" role "vendor"
    And VENDOR Navigate to "Settings" by sidebar
    And Vendor go to minimums
    And Vendor go to choose minimum type "Minimum Order Value (MOV)"
    And Vendor edit minimum type mov in minimum
      | pdw        | pde        | pdc        | pdn        | pdm        |
      | 1234567890 | 1234567890 | 1234567890 | 1234567890 | 1234567890 |
    Then Vendor update minimum type then see message "Vendor company region mov cents must less than or equal to 20000000"
    And Vendor edit minimum type mov in minimum
      | pdw | pde | pdc | pdn | pdm |
      | 100 | 100 | 100 | 100 | 100 |
    Then Vendor update minimum type success

    Given NGOC_ADMIN_25 open web admin
    When NGOC_ADMIN_25 login to web with role Admin
    And NGOC_ADMIN_25 wait 2000 mini seconds
    And NGOC_ADMIN_25 open url "vendors/companies/2035?redirect_url=%2Fvendors%2Fcompanies"
    And Admin check region MOV of vendor company
      | region             | value |
      | Pod Direct Central | 100   |
      | Pod Direct East    | 100   |
#      | Pod Direct Southeast           | 100   |
#      | Pod Direct Southwest & Rockies | 100   |
      | Pod Direct West    | 100   |

    And Switch to actor VENDOR
    And Vendor go to choose minimum type "Minimum Order Quantity (MOQ)"
    Then Vendor update minimum type success

    And Switch to actor NGOC_ADMIN_25
    And NGOC_ADMIN_25 refresh browser
    And Admin check region MOQ of vendor company

    And Switch to actor VENDOR
    And VENDOR Navigate to "Settings" by sidebar
    And Vendor go to invite colleagues
    And Vendor verify field in invite colleagues

    And VENDOR Navigate to "Settings" by sidebar
    And Vendor go to payments tab
    And Vendor verify pink payment is display

    And Switch to actor NGOC_ADMIN_25
    And NGOC_ADMIN_25 open url "vendors/companies/2035"
    And NGOC_ADMIN_25 wait 2000 mini seconds
    And Admin update "Show all tabs" of vendor company

    And Switch to actor VENDOR
    And VENDOR refresh browser
    And Vendor verify pink payment is not display
    # verify credit account
    And Buyer delete current card
    And Vendor go to add credit card
    And Buyer create New Credit Cart
      | name | address     | card             | expiryDate | city     | cvc | state   | zip   |
      | Auto | 123 address | 4242424242424242 | 1133       | New York | 123 | Alabama | 12345 |
    And Buyer create New Credit Cart success

    # verify bank account type 1
    And Buyer delete current card
    And Vendor go to add bank account
    And Vendor add bank account type 1
    Then Vendor verify current bank account
      | last4 | cardName         |
      | 6789  | STRIPE TEST BANK |
     # verify bank account type 3
    And Vendor go to replace current bank account
    And VENDOR wait 10000 mini seconds
    And Vendor add bank account type 3
    Then Vendor verify current bank account
      | last4 | cardName         |
      | 6789  | STRIPE TEST BANK |

  @VendorSetting02 @Setting
  Scenario: Verify lp general setting
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx25@podfoods.co | 12345678a |
    # Change general information of lp company
    And Admin change general information of lp company "226"
      | business_name      | contact_number |
      | AT Ngoc LP Setting | 1234567890     |
     # Change general information of lp
    And Admin change general information of lp "247"
      | email                          | first_name | last_name   | logistics_company_id | contact_number | password  |
      | ngoctx+lpsetting01@podfoods.co | ngoctx     | lpsetting01 | 226                  | 1234567890     | 12345678a |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lpsetting01@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Settings" by sidebar
    And Vendor go to general
    And LP verify personal in general settings
      | firstName | lastName    | email                          | contactNumber |
      | ngoctx    | lpsetting01 | ngoctx+lpsetting01@podfoods.co | 1234567890    |
    Then LP verify field in edit personal info of setting
    And Vendor go to edit personal in general settings
    Then Vendor verify edit personal in general settings
      | firstName | lastName    | email                          | contactNumber |
      | ngoctx    | lpsetting01 | ngoctx+lpsetting01@podfoods.co | 1234567890    |
    When Vendor edit personal in general settings
      | firstName  | lastName    | email                              | contactNumber |
      | ngoctxEdit | lpsetting01 | ngoctx+lpsetting01edit@podfoods.co | 1234567891    |
    And Vendor edit success in general settings
    Then LP verify personal in general settings
      | firstName  | lastName    | email                              | contactNumber |
      | ngoctxEdit | lpsetting01 | ngoctx+lpsetting01edit@podfoods.co | 1234567891    |
    And USER_LP refresh browser

    When login to beta web with email "ngoctx+lpsetting01edit@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Settings" by sidebar
    And Vendor go to general
    When Vendor go to change password in general settings
    And Vendor change password in general settings
      | currentPassword | newPassword | confirm   |
      | 12345678        | 12345678a   | 12345678a |
    And Vendor change password error then see message "Current password is invalid"
    And Vendor change password in general settings
      | currentPassword | newPassword | confirm    |
      | 12345678a       | 123456789a  | 123456789a |
    And Vendor change password success

    When login to beta web with email "ngoctx+lpsetting01edit@podfoods.co" pass "123456789a" role "LP"
    And USER_LP Navigate to "Settings" by sidebar
    And Vendor go to general
    And LP verify company in general settings
      | companyName        | contactNumber |
      | AT Ngoc LP Setting | 1234567890    |
    Then LP verify field in edit personal info of setting
    And LP go to edit company in general settings
    Then LP verify edit personal in general settings
      | companyName        | contactNumber |
      | AT Ngoc LP Setting | 1234567890    |
    When LP edit personal in general settings
      | companyName             | contactNumber |
      | AT Ngoc LP Setting Edit | 1234567891    |
    And Vendor edit success in general settings
    And LP verify company in general settings
      | companyName             | contactNumber |
      | AT Ngoc LP Setting Edit | 1234567891    |
    # Verify document
    Then LP verify field in edit personal info of setting
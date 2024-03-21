@feature=AdminBuyer
Feature: Buyer Flow

  @B_FLOW_01 @AdminBuyer
  Scenario: Create Buyer company > Store > head buyer
    # Delete buyer company
    Given NGOCTX13 login web admin by api
      | email                | password  |
      | ngoctx13@podfoods.co | 12345678a |
    When Admin search buyer company by API
      | buyerCompany        | managedBy | onboardingState | tag     |
      | AT Buyer Company 01 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API

    Given NGOC_ADMIN_13 open web admin
    When NGOC_ADMIN_13 login to web with role Admin
    And NGOC_ADMIN_13 navigate to "Buyers" to "Buyer companies" by sidebar
    # Create buyer company
    And Admin go to create buyer company
    And Admin create buyer company
      | name                | storeType     | managedBy  | launchBy   | ein    | website                        | edi | fuelSurcharge |
      | AT Buyer Company 01 | Grocery Store | ngoctx1318 | ngoctx1318 | 01-123 | https://adminbeta.podfoods.co/ | Yes | Yes           |
    And Admin create buyer company "AT Buyer Company 01" success
    And Admin verify buyer company in result
      | buyerCompany        | ein    | website                        | status   |
      | AT Buyer Company 01 | 01-123 | https://adminbeta.podfoods.co/ | Approved |
    And NGOC_ADMIN_13 navigate to "Stores" to "All stores" by sidebar
    And Admin go to create store
    And Admin fill info to create store
      | name          | email                     | region              | timeZone                   | storeSize | storeType     | buyerCompany        | phone      | street                | city    | state    | zip   |
      | at storechi01 | at+storechi01@podfoods.co | Chicagoland Express | Pacific Time (US & Canada) | <50k      | Grocery Store | AT Buyer Company 01 | 1234567890 | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin create store success
    # Create store
    And NGOC_ADMIN_13 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name          | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | at storechi01 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store         | region | sos | size | type          | contact                                         | delivery | managedBy  | launchedBy |
      | at storechi01 | CHI    | Yes | <50k | Grocery Store | 1544 West 18th Street, Chicago, Illinois, 60608 | [blank]  | ngoctx1318 | ngoctx1318 |
    # Create head buyer
    And NGOC_ADMIN_13 navigate to "Buyers" to "All buyers" by sidebar
    And Admin go to create buyer
    And Admin create new buyer account
      | firstName  | lastName | email                       | role       | buyerCompany        | region           | department | contactNumber | password  |
      | atbuyeracc | hb01     | atbuyeracc+hb01@podfoods.co | Head buyer | AT Buyer Company 01 | New York Express | Department | 1234567890    | 12345678a |
    And Admin create new buyer account success
    And NGOC_ADMIN_13 navigate to "Buyers" to "All buyers" by sidebar
    And Admin search all buyer
      | anyText         | fullName        | email                       | role       | store   | managedBy | tag     | status  |
      | atbuyeracc hb01 | atbuyeracc hb01 | atbuyeracc+hb01@podfoods.co | Head buyer | [blank] | [blank]   | [blank] | [blank] |
    Then Admin verify result all buyer
      | name            | region | role       | email                       | status |
      | atbuyeracc hb01 | CHI    | Head buyer | atbuyeracc+hb01@podfoods.co | Active |

  @B_FLOW_02 @AdminBuyer
  Scenario: Create Buyer company > Store > head buyer buy api
    # Delete buyer company
    Given NGOCTX13 login web admin by api
      | email                | password  |
      | ngoctx13@podfoods.co | 12345678a |
    When Admin search buyer company by API
      | buyerCompany        | managedBy | onboardingState | tag     |
      | AT Buyer Company 02 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    When Admin search buyer company by API
      | buyerCompany        | managedBy | onboardingState | tag     |
      | AT Buyer Company 01 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    # Create buyer company by api
    And Admin create buyer company by API
      | name                | ein    | launcher_id | manager_id | website                        | store_type_id | edi | fuelSurcharge |
      | AT Buyer Company 02 | 01-123 | 83          | 83         | https://beta.podfoods.co/login | 2             | Yes | Yes           |
    # Create store by api
    And Admin create store by API
      | name          | email                     | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | at storechi02 | at+storechi02@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
    # Create head buyer account
    And Admin create "head" buyer account by API
      | first_name | last_name | email                       | role       | buyer_company_id | region | business_name | contact_number | tag     | store_id | manager_id | password  |
      | atbuyeracc | hb02      | atbuyeracc+hb02@podfoods.co | head_buyer | create by api    | 53     | Department    | 1234567890     | [blank] | [blank]  | [blank]    | 12345678a |
     # Create buyer account
    And Admin create "store" buyer account by API
      | first_name | last_name | email                      | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atbuyeracc | b02       | atbuyeracc+b02@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |
    # Create sub buyer account
    And Admin create "sub" buyer account by API
      | first_name | last_name | email                      | role    | business_name | contact_number | tag     | store_id      | manager_id    | password  |
      | atbuyeracc | s02       | atbuyeracc+s02@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | create by api | 12345678a |

#  @AdminBuyer_07 @AdminBuyer
#  Scenario: Verify create custom field in buyer company
#    Given NGOC_ADMIN_13 open web admin
#    When NGOC_ADMIN_13 login to web with role Admin
#    And NGOC_ADMIN_13 navigate to "Buyers" to "Buyer companies" by sidebar
#    And Admin create custom field text of buyer company
#      | email                | password  |
#      | ngoctx13@podfoods.co | 12345678a |

  @AdminBuyer_01 @AdminBuyer
  Scenario: Verify create buyer company
    Given NGOCTX13 login web admin by api
      | email                | password  |
      | ngoctx13@podfoods.co | 12345678a |
    # Delete buyer
    And Admin search buyer by API
      | q[any_text]    | q[full_name]         |
      | atbuyeracc s01 | atcreatebuyeracc b01 |
    And Admin delete buyer all by API
    # Delete buyer company
    When Admin search buyer company by API
      | buyerCompany        | managedBy | onboardingState | tag     |
      | AT Buyer Company 01 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API

    Given NGOC_ADMIN_13 open web admin
    When NGOC_ADMIN_13 login to web with role Admin
    And NGOC_ADMIN_13 navigate to "Buyers" to "Buyer companies" by sidebar
      # Create buyer company
    And Admin go to create buyer company
    And Admin verify default form create buyer company
    And Admin verify detect duplicates create buyer company "ngoc cpn claim"
    And Admin create buyer company
      | name                | storeType     | managedBy  | launchBy   | ein    | website                        | edi | fuelSurcharge |
      | AT Buyer Company 01 | Grocery Store | ngoctx1301 | ngoctx1301 | 01-123 | https://auto.podfoods.co/login | Yes | Yes           |
    And Admin add tags to create buyer company
      | tags               |
      | all private target |
      | private brand tag  |
    And Admin create buyer company "AT Buyer Company 01" success
    And Admin verify buyer company in result
      | buyerCompany        | ein    | website                        | status   |
      | AT Buyer Company 01 | 01-123 | https://auto.podfoods.co/login | Approved |
    And NGOC_ADMIN_13 navigate to "Buyers" to "Buyer companies" by sidebar
    # Search by name
    And Admin search buyer company
      | name                   | managedBy | status  | tag     |
      | AT Buyer Company 01111 | [blank]   | [blank] | [blank] |
    And Admin no found data in result
      # Search by name
    And Admin search buyer company
      | name                | managedBy | status  | tag     |
      | AT Buyer Company 01 | [blank]   | [blank] | [blank] |
    Then Admin verify result buyer company
      | name                | ein    | website                        | status   |
      | AT Buyer Company 01 | 01-123 | https://auto.podfoods.co/login | Approved |
      # Search by Managed by
    And Admin search buyer company
      | name                | managedBy  | status  | tag     |
      | AT Buyer Company 01 | ngoctx1201 | [blank] | [blank] |
    And Admin no found data in result
    And Admin search buyer company
      | name                | managedBy  | status  | tag     |
      | AT Buyer Company 01 | ngoctx1301 | [blank] | [blank] |
    Then Admin verify result buyer company
      | name                | ein    | website                        | status   |
      | AT Buyer Company 01 | 01-123 | https://auto.podfoods.co/login | Approved |
    # Search by Onboarding status
    And Admin search buyer company
      | name                | managedBy | status    | tag     |
      | AT Buyer Company 01 | [blank]   | In Review | [blank] |
    And Admin no found data in result
    And Admin search buyer company
      | name                | managedBy | status   | tag     |
      | AT Buyer Company 01 | [blank]   | Approved | [blank] |
    Then Admin verify result buyer company
      | name                | ein    | website                        | status   |
      | AT Buyer Company 01 | 01-123 | https://auto.podfoods.co/login | Approved |
    # Search by Onboarding status
    And Admin search buyer company
      | name                | managedBy | status    | tag     |
      | AT Buyer Company 01 | [blank]   | In Review | [blank] |
    And Admin no found data in result
    And Admin search buyer company
      | name                | managedBy | status   | tag     |
      | AT Buyer Company 01 | [blank]   | Approved | [blank] |
    Then Admin verify result buyer company
      | name                | ein    | website                        | status   |
      | AT Buyer Company 01 | 01-123 | https://auto.podfoods.co/login | Approved |
        # Search by Tags
    And Admin search buyer company
      | name                | managedBy | status  | tag |
      | AT Buyer Company 01 | [blank]   | [blank] | DNS |
    And Admin no found data in result
    And Admin search buyer company
      | name                | managedBy | status  | tag                |
      | AT Buyer Company 01 | [blank]   | [blank] | all private target |
    Then Admin verify result buyer company
      | name                | ein    | website                        | status   |
      | AT Buyer Company 01 | 01-123 | https://auto.podfoods.co/login | Approved |
       # Search by all criteria
    And Admin search buyer company
      | name                | managedBy  | status   | tag                |
      | AT Buyer Company 01 | ngoctx1301 | Approved | all private target |
    Then Admin verify result buyer company
      | name                | ein    | website                        | status   |
      | AT Buyer Company 01 | 01-123 | https://auto.podfoods.co/login | Approved |
    And Admin go to detail of buyer company "AT Buyer Company 01"
    Then Admin verify general information of buyer company
      | state  | name                | managedBy  | launchedBy | storeType     | ein    | website                        | limit     | onboardStatus | edi | fuel |
      | Active | AT Buyer Company 01 | ngoctx1301 | ngoctx1301 | Grocery Store | 01-123 | https://auto.podfoods.co/login | $1,000.00 | Approved      | Yes | Yes  |
    And Admin verify edit name field in buyer company detail
      | name                          | message                     |
      | [blank]                       | Name can't be blank         |
      | ngoc cpn claim                | Name has already been taken |
      | AT Buyer Company 01!@#$%^&*() | success                     |
      | AT Buyer Company 01 Edit      | success                     |
    And Admin verify edit managed by field in buyer company detail
      | manageBy |
      | [blank]  |
      | ngoctx15 |
    And Admin verify edit launched by field in buyer company detail
      | launchBy |
      | [blank]  |
      | ngoctx15 |
    And Admin verify edit store type field in buyer company detail
      | storeType |
      | Others    |
    And Admin verify edit ein field in buyer company detail
      | ein    |
      | 123456 |
      | 01-321 |
    And Admin verify edit website by field in buyer company detail
      | website                             |
      | [blank]                             |
      | 123!@#                              |
      | https://adminauto.podfoods.co/login |
    And Admin verify edit edi and fuel by field in buyer company detail
      | edi | fuel |
      | No  | No   |
    And Admin verify default popup tag field in buyer company detail
      | tag                |
      | all private target |
      | private brand tag  |
    And Admin remove tag field in buyer company detail
      | tag                |
      | all private target |
    And Admin add tag field in buyer company detail
      | tag                 | expiryDate  |
      | all private target  | currentDate |
      | Private tag for all | currentDate |
    And NGOC_ADMIN_13 navigate to "Financial" to "Credit limit" by sidebar
    And Admin fill password to authen permission
    And Admin search buyer company in credit limit
      | buyerCompany             | diff    |
      | AT Buyer Company 01 Edit | [blank] |
    And Admin go to buyer company "AT Buyer Company 01 Edit" credit limit
    And Admin set buyer company credit limit is "10000"
    And Admin update credit limit

    And NGOC_ADMIN_13 navigate to "Buyers" to "Buyer companies" by sidebar
    And Admin search buyer company
      | name                     | managedBy | status  | tag     |
      | AT Buyer Company 01 Edit | [blank]   | [blank] | [blank] |
    And Admin go to detail of buyer company "AT Buyer Company 01"
    Then Admin verify general information of buyer company
      | state  | name                     | managedBy | launchedBy | storeType | ein    | website                             | limit      | onboardStatus | edi | fuel |
      | Active | AT Buyer Company 01 Edit | ngoctx15  | ngoctx15   | Others    | 01-321 | https://adminauto.podfoods.co/login | $10,000.00 | Approved      | No  | No   |
    # Verify company document
    And Admin verify company document tab in buyer company detail
    And Admin verify error message of company document
    And Admin upload company document multi in row
      | index | file        | description             |
      | 1     | anhJPEG.jpg | Auto company document   |
      | 1     | anhJPG2.jpg | Auto company document 1 |
    And Admin upload company document
      | index | file        | description             |
      | 2     | anhJPEG.jpg | Auto company document 2 |
    And Admin remove company document
      | index |
      | 2     |
    And Admin verify after upload company document
      | index | file        | description             |
      | 1     | anhJPG2.jpg | Auto company document 1 |
    # verify business license certificates
    And Admin verify business license certificates tab in buyer company detail
    And Admin verify error message of business license certificates
    And Admin upload business license certificates multi in row
      | index | file        | description                          |
      | 1     | anhJPEG.jpg | Auto business license certificates   |
      | 1     | anhPNG.png  | Auto business license certificates 1 |
    And Admin upload business license certificates
      | index | file        | description                          |
      | 2     | anhJPEG.jpg | Auto business license certificates 2 |
    And Admin remove business license certificate
      | index |
      | 2     |
    And Admin verify after business license certificates
      | index | file       | description                          |
      | 1     | anhPNG.png | Auto business license certificates 1 |
    # verify resale certificates
    And Admin verify resale certificates tab in buyer company detail
    And Admin verify error message of resale certificates
    And Admin upload resale certificates multi in row
      | index | file        | description                |
      | 1     | anhJPG2.jpg | Auto resale certificates   |
      | 1     | anhJPEG.jpg | Auto resale certificates 1 |
    And Admin upload resale certificates
      | index | file        | description                |
      | 2     | anhJPEG.jpg | Auto resale certificates 2 |
    And Admin remove resale certificates
      | index |
      | 2     |
    And Admin verify after resale certificates
      | index | file        | description                |
      | 1     | anhJPEG.jpg | Auto resale certificates 1 |

    Given NGOCTX13 login web admin by api
      | email                | password  |
      | ngoctx13@podfoods.co | 12345678a |
   # Create store by api
    And Admin create store by API
      | name                | email                           | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | at createstorechi01 | at+createstorechi01@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
    # Create buyer account
    And Admin create "store" buyer account by API
      | first_name       | last_name | email                            | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atcreatebuyeracc | b03       | atcreatebuyeracc+b03@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |

   # verify Set Referrer Vendor Company
    And Switch to actor NGOC_ADMIN_13
    And Admin set referrer vendor company is "ngoc vc 1"
    And NGOC_ADMIN_13 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name                | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | at createstorechi01 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin go to detail of store "at createstorechi01"
    And Admin verify general information of all store
      | name                | nameCompany              | stateStore | storeSize | storeType | invoiceOption | sendInvoice                                      | threshold | region              | street                | city    | state    | zip   | email                           | apEmail | phone      | timezone                   | day     | start   | end     | route   | referredBy |
      | at createstorechi01 | AT Buyer Company 01 Edit | Active     | <50k      | Others    | Yes           | One day after sub-invoice is marked as fulfilled | 35 day(s) | Chicagoland Express | 1544 West 18th Street | Chicago | Illinois | 60608 | at+createstorechi01@podfoods.co | [blank] | 1234567890 | Pacific Time (US & Canada) | [blank] | [blank] | [blank] | [blank] | ngoc vc 1  |

    # Verify info after edit in buyer
    Given BUYER open web user
    When login to beta web with email "atcreatebuyeracc+b03@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Settings" by sidebar
    And Buyer go to general
    And Buyer verify company information in general settings
      | companyName              | ein    |
      | AT Buyer Company 01 Edit | 01-321 |
    And Buyer verify company document in general settings
      | link        | description             |
      | anhJPG2.jpg | Auto company document 1 |
    And Buyer verify business license certificates in general settings
      | link       | description |
      | anhPNG.png | anhPNG.png  |
    And Buyer verify resale certificates in general settings
      | link        | description |
      | anhJPEG.jpg | anhJPEG.jpg |

    And NGOC_ADMIN_13 navigate to "Buyers" to "Buyer companies" by sidebar
    And Admin search buyer company
      | name                     | managedBy | status  | tag     |
      | AT Buyer Company 01 Edit | [blank]   | [blank] | [blank] |
    And Admin go to detail of buyer company "AT Buyer Company 01"
    And Admin "deactivate" buyer company
    Then Admin verify history active buyer company
      | state           | updateBy        | updateOn    |
      | Active→Inactive | Admin: ngoctx13 | currentDate |
    And Admin refresh page by button
    And Admin "activate" buyer company
    Then Admin verify history active buyer company
      | state           | updateBy        | updateOn    |
      | Inactive→Active | Admin: ngoctx13 | currentDate |

    And NGOC_ADMIN_13 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name                | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | at createstorechi01 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin go to detail of store "at createstorechi01"
    And Admin "Activate this store" in store detail

  @AdminBuyer_02 @AdminBuyer
  Scenario: Verify create buyer
    Given NGOCTX13 login web admin by api
      | email                | password  |
      | ngoctx13@podfoods.co | 12345678a |
    # Delete buyer
    And Admin search buyer by API
      | q[any_text]          | q[full_name]         |
      | atcreatebuyeracc b01 | atcreatebuyeracc b01 |
    And Admin delete buyer all by API
    # Delete buyer
    And Admin search buyer by API
      | q[any_text]                  | q[full_name]                 |
      | atcreatebuyeraccEdit b01Edit | atcreatebuyeraccEdit b01Edit |
    And Admin delete buyer all by API

    Given NGOC_ADMIN_13 open web admin
    When NGOC_ADMIN_13 login to web with role Admin
    And NGOC_ADMIN_13 navigate to "Buyers" to "All buyers" by sidebar
    And Admin go to create buyer
    And Admin verify default form create buyer
    And Admin create new buyer account
      | firstName   | lastName | email                         | role          | store          | region           | department | contactNumber | password  |
      | at buyeracc | hb01     | atcreatebuyer+b01@podfoods.co | Store manager | ngoctx stclaim | New York Express | Department | 1234567890    | 12345678a |
    And Admin create new buyer account with error "First name is invalid"
    And Admin create new buyer account
      | firstName     | lastName | email                         | role          | store          | region           | department | contactNumber | password  |
      | atcreatebuyer | b  01    | atcreatebuyer+b01@podfoods.co | Store manager | ngoctx stclaim | New York Express | Department | 1234567890    | 12345678a |
    And Admin create new buyer account with error "Last name is invalid"
    And Admin verify email field in create buyer
    And Admin create new buyer account
      | firstName     | lastName | email                          | role          | store          | region           | department | contactNumber | password  |
      | atcreatebuyer | b01      | ngoctx+stclaimny01@podfoods.co | Store manager | ngoctx stclaim | New York Express | Department | 1234567890    | 12345678a |
    And Admin create new buyer account with error "Email currently exists on Pod Foods! Please reach out to hi@podfoods.co for any questions."
    And Admin create new buyer account
      | firstName     | lastName | email                                | role          | store          | region           | department | contactNumber | password  |
      | atcreatebuyer | b01      | ngoctx+staordersum01ny01@podfoods.co | Store manager | ngoctx stclaim | New York Express | Department | 1234567890    | 12345678a |
    And Admin create new buyer account with error "Email currently exists on Pod Foods! Please reach out to hi@podfoods.co for any questions."
    And Admin verify manager field in create buyer
    And Admin verify manager contact in create head buyer
    And Admin create new buyer account
      | firstName     | lastName | email                                | role       | buyerCompany   | region           | department | contactNumber | password  |
      | atcreatebuyer | b01      | ngoctx+staordersum01ny01@podfoods.co | Head buyer | ngoc cpn claim | New York Express | Department | 1234567890    | 12345678a |
    And Admin remove region "New York Express" in create head buyer
    And Admin add tags in create buyer
      | tags                  | expiryDate  |
      | all private target    | currentDate |
      | Buyer & Buyer Company | currentDate |
    And Admin create new buyer account
      | firstName        | lastName | email                            | role          | store               | region              | department | contactNumber | password  |
      | atcreatebuyeracc | b01      | atcreatebuyeracc+b01@podfoods.co | Store manager | at createstorechi01 | Chicagoland Express | Department | 1234567890    | 12345678a |
    And Admin create new buyer account success
    # search with criteria Any text
    And Admin search all buyer
      | anyText                    | fullName | email   | role    | store   | managedBy | tag     | status  |
      | atcreatebuyeracc b01123123 | [blank]  | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin no found data in result
    And Admin search all buyer
      | anyText              | fullName | email   | role    | store   | managedBy | tag     | status  |
      | atcreatebuyeracc b01 | [blank]  | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    Then Admin verify result all buyer
      | name                 | region | role          | email                            | store               | status |
      | atcreatebuyeracc b01 | CHI    | Store manager | atcreatebuyeracc+b01@podfoods.co | at createstorechi01 | Active |
     # search with criteria fullname
    And Admin search all buyer
      | anyText | fullName                   | email   | role          | store   | managedBy | tag     | status  |
      | [blank] | atcreatebuyeracc b01123123 | [blank] | Store manager | [blank] | [blank]   | [blank] | [blank] |
    And Admin no found data in result
    And Admin search all buyer
      | anyText | fullName             | email   | role    | store   | managedBy | tag     | status  |
      | [blank] | atcreatebuyeracc b01 | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    Then Admin verify result all buyer
      | name                 | region | role          | email                            | store               | status |
      | atcreatebuyeracc b01 | CHI    | Store manager | atcreatebuyeracc+b01@podfoods.co | at createstorechi01 | Active |
     # search with criteria email
    And Admin search all buyer
      | anyText | fullName | email                                  | role    | store   | managedBy | tag     | status  |
      | [blank] | [blank]  | atcreatebuyeracc+b01123123@podfoods.co | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin no found data in result
    And Admin search all buyer
      | anyText | fullName | email                            | role    | store   | managedBy | tag     | status  |
      | [blank] | [blank]  | atcreatebuyeracc+b01@podfoods.co | [blank] | [blank] | [blank]   | [blank] | [blank] |
    Then Admin verify result all buyer
      | name                 | region | role          | email                            | store               | status |
      | atcreatebuyeracc b01 | CHI    | Store manager | atcreatebuyeracc+b01@podfoods.co | at createstorechi01 | Active |
     # search with criteria Role
    And Admin search all buyer
      | anyText              | fullName | email   | role       | store   | managedBy | tag     | status  |
      | atcreatebuyeracc b01 | [blank]  | [blank] | Head buyer | [blank] | [blank]   | [blank] | [blank] |
    And Admin no found data in result
    And Admin search all buyer
      | anyText              | fullName | email   | role          | store   | managedBy | tag     | status  |
      | atcreatebuyeracc b01 | [blank]  | [blank] | Store manager | [blank] | [blank]   | [blank] | [blank] |
    Then Admin verify result all buyer
      | name                 | region | role          | email                            | store               | status |
      | atcreatebuyeracc b01 | CHI    | Store manager | atcreatebuyeracc+b01@podfoods.co | at createstorechi01 | Active |
     # search with criteria Store
    And Admin search all buyer
      | anyText              | fullName | email   | role    | store            | managedBy | tag     | status  |
      | atcreatebuyeracc b01 | [blank]  | [blank] | [blank] | ngoctx ststate05 | [blank]   | [blank] | [blank] |
    And Admin no found data in result
    And Admin search all buyer
      | anyText              | fullName | email   | role    | store               | managedBy | tag     | status  |
      | atcreatebuyeracc b01 | [blank]  | [blank] | [blank] | at createstorechi01 | [blank]   | [blank] | [blank] |
    Then Admin verify result all buyer
      | name                 | region | role          | email                            | store               | status |
      | atcreatebuyeracc b01 | CHI    | Store manager | atcreatebuyeracc+b01@podfoods.co | at createstorechi01 | Active |
     # search with criteria Manager by
    And Admin search all buyer
      | anyText              | fullName | email   | role    | store   | managedBy | tag     | status  |
      | atcreatebuyeracc b01 | [blank]  | [blank] | [blank] | [blank] | ngoctx14  | [blank] | [blank] |
    And Admin no found data in result
    And Admin search all buyer
      | anyText              | fullName | email   | role    | store   | managedBy | tag     | status  |
      | atcreatebuyeracc b01 | [blank]  | [blank] | [blank] | [blank] | ngoctx15  | [blank] | [blank] |
    Then Admin verify result all buyer
      | name                 | region | role          | email                            | store               | status |
      | atcreatebuyeracc b01 | CHI    | Store manager | atcreatebuyeracc+b01@podfoods.co | at createstorechi01 | Active |
      # search with criteria Tags
    And Admin search all buyer
      | anyText              | fullName | email   | role    | store   | managedBy | tag                | status  |
      | atcreatebuyeracc b01 | [blank]  | [blank] | [blank] | [blank] | [blank]   | private buyer only | [blank] |
    And Admin no found data in result
    And Admin search all buyer
      | anyText              | fullName | email   | role    | store   | managedBy | tag                | status  |
      | atcreatebuyeracc b01 | [blank]  | [blank] | [blank] | [blank] | [blank]   | all private target | [blank] |
    Then Admin verify result all buyer
      | name                 | region | role          | email                            | store               | status |
      | atcreatebuyeracc b01 | CHI    | Store manager | atcreatebuyeracc+b01@podfoods.co | at createstorechi01 | Active |
     # search with criteria status
    And Admin search all buyer
      | anyText              | fullName | email   | role    | store   | managedBy | tag     | status   |
      | atcreatebuyeracc b01 | [blank]  | [blank] | [blank] | [blank] | [blank]   | [blank] | Inactive |
    And Admin no found data in result
    And Admin search all buyer
      | anyText              | fullName | email   | role    | store   | managedBy | tag     | status |
      | atcreatebuyeracc b01 | [blank]  | [blank] | [blank] | [blank] | [blank]   | [blank] | Active |
    Then Admin verify result all buyer
      | name                 | region | role          | email                            | store               | status |
      | atcreatebuyeracc b01 | CHI    | Store manager | atcreatebuyeracc+b01@podfoods.co | at createstorechi01 | Active |
     # search with all criteria status
    And Admin search all buyer
      | anyText              | fullName             | email                            | role          | store               | managedBy | tag                | status |
      | atcreatebuyeracc b01 | atcreatebuyeracc b01 | atcreatebuyeracc+b01@podfoods.co | Store manager | at createstorechi01 | ngoctx15  | all private target | Active |
    Then Admin verify result all buyer
      | name                 | region | role          | email                            | store               | status |
      | atcreatebuyeracc b01 | CHI    | Store manager | atcreatebuyeracc+b01@podfoods.co | at createstorechi01 | Active |
    And Admin go to detail of buyer "atcreatebuyeracc b01"
    And Admin verify general information of all buyer
      | email                            | firstName        | lastName | contact    | region              | department | store               | role          |
      | atcreatebuyeracc+b01@podfoods.co | atcreatebuyeracc | b01      | 1234567890 | Chicagoland Express | Department | at createstorechi01 | Store manager |
    And Admin verify tag in buyer detail
      | tag                   | expiry      |
      | all private target    | currentDate |
      | Buyer & Buyer Company | currentDate |
    And Admin verify email setting of buyer detail
    # Edit
    And Admin edit general information of store buyer
      | email                                | firstName            | lastName | contact    | department      | store               | role            | manager            |
      | atcreatebuyeracc+b01edit@podfoods.co | atcreatebuyeraccEdit | b01Edit  | 1234567891 | Department Edit | ngoctx stclaim1ny01 | Store sub-buyer | ngoctx stclaimny01 |
    And Admin delete tags in buyer detail
      | tag                   |
      | all private target    |
      | Buyer & Buyer Company |
    And Admin add tag field in buyer detail
      | tag                   | expiryDate  |
      | all private target    | currentDate |
      | Buyer & Buyer Company | currentDate |
    And Admin verify general information of all buyer
      | email                                | firstName            | lastName | contact    | region              | department      | store               | role            | manager            |
      | atcreatebuyeracc+b01edit@podfoods.co | atcreatebuyeraccEdit | b01Edit  | 1234567891 | Chicagoland Express | Department Edit | ngoctx stclaim1ny01 | Store sub-buyer | ngoctx stclaimny01 |
    And Admin verify tag in buyer detail
      | tag                   | expiry      |
      | all private target    | currentDate |
      | Buyer & Buyer Company | currentDate |
    And Admin navigate relate buyer order in buyer detail "atcreatebuyeracc b01"
    And Admin go back by browser
    And Admin navigate relate sample request in buyer detail "atcreatebuyeracc b01"
    And Admin go back by browser
    And Admin navigate relate credit memo in buyer detail "atcreatebuyeracc b01"
    And Admin go back by browser
    And Admin "deactivate" this buyer
    And NGOC_ADMIN_13 navigate to "Buyers" to "All buyers" by sidebar
    And Admin search all buyer
      | anyText                      | fullName | email   | role    | store   | managedBy | tag     | status   |
      | atcreatebuyeraccEdit b01Edit | [blank]  | [blank] | [blank] | [blank] | [blank]   | [blank] | Inactive |
    And Admin go to detail of buyer "atcreatebuyeraccEdit b01Edit"

    And Admin "activate" this buyer
    And NGOC_ADMIN_13 navigate to "Buyers" to "All buyers" by sidebar
    And Admin search all buyer
      | anyText                      | fullName | email   | role    | store   | managedBy | tag     | status |
      | atcreatebuyeraccEdit b01Edit | [blank]  | [blank] | [blank] | [blank] | [blank]   | [blank] | Active |
    And Admin go to detail of buyer "atcreatebuyeraccEdit b01Edit"
    And Admin verify email field in buyer detail
      | value                              | message                                                                                    |
      | 124124                             | Email is not an email                                                                      |
      | ngoctx+storder174chi01@podfoods.co | Email currently exists on Pod Foods! Please reach out to hi@podfoods.co for any questions. |
    And Admin verify first name in buyer detail
      | value                                               | message                                           |
      | 123456789012345678901234567890123456789012345678901 | First name is too long (maximum is 50 characters) |
      | ngoctx ngoctx                                       | First name is invalid                             |
    And Admin verify last name in buyer detail
      | value                                               | message                                          |
      | 123456789012345678901234567890123456789012345678901 | Last name is too long (maximum is 50 characters) |
      | ngoctx ngoctx                                       | Last name is invalid                             |
    And Admin verify contact number field in buyer detail
      | value                                               | message                                          |
      | 123456789012345678901234567890123456789012345678901 | Last name is too long (maximum is 50 characters) |
      | ngoctx ngoctx                                       | Last name is invalid                             |

  @AdminBuyer_03 @AdminBuyer
  Scenario: Verify create head buyer
    Given NGOCTX13 login web admin by api
      | email                | password  |
      | ngoctx13@podfoods.co | 12345678a |
    # Delete buyer
    And Admin search buyer by API
      | q[any_text]        | q[full_name]       |
      | atcreatebuyer hb01 | atcreatebuyer hb01 |
    And Admin delete head buyer all by API

    And Admin search buyer by API
      | q[any_text]                | q[full_name]               |
      | atcreatebuyerEdit hb01Edit | atcreatebuyerEdit hb01Edit |
    And Admin delete head buyer all by API

    Given NGOC_ADMIN_13 open web admin
    When NGOC_ADMIN_13 login to web with role Admin
    And NGOC_ADMIN_13 navigate to "Buyers" to "All buyers" by sidebar
    And Admin go to create buyer
    And Admin create new buyer account
      | firstName     | lastName | email                             | role       | buyerCompany   | region          | department | contactNumber | password  |
      | atcreatebuyer | hb01     | atcreatebuyeracc+hb01@podfoods.co | Head buyer | ngoc cpn claim | Atlanta Express | Department | 1234567890    | 12345678a |
    And Admin add tags in create buyer
      | tags                  | expiryDate  |
      | all private target    | currentDate |
      | Buyer & Buyer Company | currentDate |
    And Admin create new buyer account success
      # search with all criteria status
    And Admin search all buyer
      | anyText            | fullName           | email                             | role       | store   | managedBy | tag                | status |
      | atcreatebuyer hb01 | atcreatebuyer hb01 | atcreatebuyeracc+hb01@podfoods.co | Head buyer | [blank] | [blank]   | all private target | Active |
    Then Admin verify result all buyer
      | name               | region | role       | email                             | status |
      | atcreatebuyer hb01 | NY     | Head buyer | atcreatebuyeracc+hb01@podfoods.co | Active |
    And Admin go to detail of buyer "atcreatebuyeracc hb01"
    And Admin verify general information of head buyer detail
      | email                             | firstName     | lastName | contact    | autoRegion       | manualRegion    | buyerCompany   | department | role       |
      | atcreatebuyeracc+hb01@podfoods.co | atcreatebuyer | hb01     | 1234567890 | New York Express | Atlanta Express | ngoc cpn claim | Department | Head buyer |
    And Admin verify tag in buyer detail
      | tag                   | expiry      |
      | all private target    | currentDate |
      | Buyer & Buyer Company | currentDate |
    And Admin edit general information of head buyer
      | email                                | firstName         | lastName | contact    | department      | manualRegion        |
      | atcreatebuyeracc+b01edit@podfoods.co | atcreatebuyerEdit | hb01Edit | 1234567891 | Department Edit | Chicagoland Express |
    And Admin verify general information of head buyer detail
      | email                                | firstName         | lastName | contact    | autoRegion       | manualRegion        | buyerCompany   | department      | role       |
      | atcreatebuyeracc+b01edit@podfoods.co | atcreatebuyerEdit | hb01Edit | 1234567891 | New York Express | Chicagoland Express | ngoc cpn claim | Department Edit | Head buyer |
    And Admin navigate relate buyer order in buyer detail "atcreatebuyerEdit hb01Edit"
    And Admin go back by browser
    And Admin navigate relate sample request in buyer detail "atcreatebuyerEdit hb01Edit"
    And Admin go back by browser
    And Admin navigate relate credit memo in buyer detail "atcreatebuyerEdit hb01Edit"
    And Admin go back by browser
    And Admin verify email field in buyer detail
      | value                              | message                                                                                    |
      | 124124                             | Email is not an email                                                                      |
      | ngoctx+storder174chi01@podfoods.co | Email currently exists on Pod Foods! Please reach out to hi@podfoods.co for any questions. |
    And Admin verify first name in buyer detail
      | value                                               | message                                           |
      | 123456789012345678901234567890123456789012345678901 | First name is too long (maximum is 50 characters) |
      | ngoctx ngoctx                                       | First name is invalid                             |
    And Admin verify last name in buyer detail
      | value                                               | message                                          |
      | 123456789012345678901234567890123456789012345678901 | Last name is too long (maximum is 50 characters) |
      | ngoctx ngoctx                                       | Last name is invalid                             |
    And Admin verify contact number field in buyer detail
      | value                                               | message                                          |
      | 123456789012345678901234567890123456789012345678901 | Last name is too long (maximum is 50 characters) |
      | ngoctx ngoctx                                       | Last name is invalid                             |
    And Admin change password to "123456789a" success in vendor detail
    And Admin delete tags in buyer detail
      | tag                   |
      | all private target    |
      | Buyer & Buyer Company |
    And Admin add tag field in buyer detail
      | tag                   | expiryDate  |
      | all private target    | currentDate |
      | Buyer & Buyer Company | currentDate |
    And Admin verify general information of all buyer
      | email                                | firstName            | lastName | contact    | region              | department      | store               | role            | manager            |
      | atcreatebuyeracc+b01edit@podfoods.co | atcreatebuyeraccEdit | b01Edit  | 1234567891 | Chicagoland Express | Department Edit | ngoctx stclaim1ny01 | Store sub-buyer | ngoctx stclaimny01 |
    And Admin verify tag in buyer detail
      | tag                   | expiry      |
      | all private target    | currentDate |
      | Buyer & Buyer Company | currentDate |

    # verify login
    Given HEAD_BUYER open web user
    When login to beta web with email "atcreatebuyeracc+b01edit@podfoods.co" pass "12345678a" role "buyer"
    # Delete buyer
    And Switch to actor NGOC_ADMIN_13
    And NGOC_ADMIN_13 navigate to "Buyers" to "All buyers" by sidebar
    And Admin search all buyer
      | anyText                    | fullName | email   | role    | store   | managedBy | tag     | status  |
      | atcreatebuyerEdit hb01Edit | [blank]  | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin delete buyer "atcreatebuyerEdit hb01Edit" in result
    And Admin search all buyer
      | anyText                    | fullName | email   | role    | store   | managedBy | tag     | status  |
      | atcreatebuyerEdit hb01Edit | [blank]  | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin no found data in result

  @AdminBuyer_04 @AdminBuyer
  Scenario: Verify create sub buyer
    Given NGOCTX13 login web admin by api
      | email                | password  |
      | ngoctx13@podfoods.co | 12345678a |
    # Delete buyer
    And Admin search buyer by API
      | q[any_text]        | q[full_name]       |
      | atcreatebuyer sb01 | atcreatebuyer sb01 |
    And Admin delete buyer all by API

    # Delete buyer
    And Admin search buyer by API
      | q[any_text]                | q[full_name]               |
      | atcreatebuyerEdit sb01Edit | atcreatebuyerEdit sb01Edit |

    And Admin delete buyer all by API
    Given NGOC_ADMIN_13 open web admin
    When NGOC_ADMIN_13 login to web with role Admin
    And NGOC_ADMIN_13 navigate to "Buyers" to "All buyers" by sidebar
    And Admin go to create buyer
    And Admin create new buyer account
      | firstName     | lastName | email                          | role            | manager            | store               | region              | department | contactNumber | password  |
      | atcreatebuyer | sb01     | atcreatebuyer+sb01@podfoods.co | Store sub-buyer | ngoctx stclaimny01 | at createstorechi01 | Chicagoland Express | Department | 1234567890    | 12345678a |
    And Admin add tags in create buyer
      | tags                  | expiryDate  |
      | all private target    | currentDate |
      | Buyer & Buyer Company | currentDate |
    And Admin create new buyer account success
    # search with criteria Any text
    And Admin search all buyer
      | anyText            | fullName | email   | role    | store   | managedBy | tag     | status  |
      | atcreatebuyer sb01 | [blank]  | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    Then Admin verify result all buyer
      | name               | region | role            | email                          | store               | status |
      | atcreatebuyer sb01 | CHI    | Store sub-buyer | atcreatebuyer+sb01@podfoods.co | at createstorechi01 | Active |
    And Admin navigate store "at createstorechi01" in buyer list
    And Admin go back with button
    And Admin go to detail of buyer "atcreatebuyer sb01"
    And Admin verify general information of all buyer
      | email                          | firstName     | lastName | contact    | region              | department | store               | role            | manager            |
      | atcreatebuyer+sb01@podfoods.co | atcreatebuyer | sb01     | 1234567890 | Chicagoland Express | Department | at createstorechi01 | Store sub-buyer | ngoctx stclaimny01 |
    And Admin verify tag in buyer detail
      | tag                   | expiry      |
      | all private target    | currentDate |
      | Buyer & Buyer Company | currentDate |
    And Admin verify email setting of buyer detail
    # Edit
    And Admin edit general information of store buyer
      | email                              | firstName         | lastName | contact    | department      | store               | role    | manager |
      | atcreatebuyer+sb01edit@podfoods.co | atcreatebuyerEdit | sb01Edit | 1234567891 | Department Edit | ngoctx stclaim1ny01 | [blank] | [blank] |
    And Admin delete tags in buyer detail
      | tag                   |
      | all private target    |
      | Buyer & Buyer Company |
    And Admin add tag field in buyer detail
      | tag                   | expiryDate  |
      | all private target    | currentDate |
      | Buyer & Buyer Company | currentDate |
    And Admin verify general information of all buyer
      | email                              | firstName         | lastName | contact    | region           | department      | store               | role            | manager            |
      | atcreatebuyer+sb01edit@podfoods.co | atcreatebuyerEdit | sb01Edit | 1234567891 | New York Express | Department Edit | ngoctx stclaim1ny01 | Store sub-buyer | ngoctx stclaimny01 |
    And Admin verify tag in buyer detail
      | tag                   | expiry      |
      | all private target    | currentDate |
      | Buyer & Buyer Company | currentDate |
    And Admin change password to "123456789a" success in vendor detail
    And Admin navigate store "ngoctx stclaim" in buyer detail
    And Admin go back by browser
    And Admin navigate relate buyer order in buyer detail "atcreatebuyerEdit sb01Edit"
    And Admin go back by browser
    And Admin navigate relate sample request in buyer detail "atcreatebuyerEdit sb01Edit"
    And Admin go back by browser
    And Admin navigate relate credit memo in buyer detail "atcreatebuyerEdit sb01Edit"
    And Admin go back by browser
    And Admin go back with button

    # verify login
    Given BUYER open web user
    When login to beta web with email "atcreatebuyer+sb01edit@podfoods.co" pass "123456789a" role "buyer"
    # Delete buyer
    And Switch to actor NGOC_ADMIN_13
    And Admin search all buyer
      | anyText            | fullName | email   | role    | store   | managedBy | tag     | status  |
      | atcreatebuyer sb01 | [blank]  | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin delete buyer "atcreatebuyer sb01" in result
    And Admin search all buyer
      | anyText            | fullName | email   | role    | store   | managedBy | tag     | status  |
      | atcreatebuyer sb01 | [blank]  | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin no found data in result

  @AdminBuyer_05 @AdminBuyer
  Scenario: Verify can not delete buyer have order
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx13@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_13 open web admin
    When NGOC_ADMIN_13 login to web with role Admin
    And NGOC_ADMIN_13 navigate to "Buyers" to "All buyers" by sidebar
    And Admin search all buyer
      | anyText                  | fullName | email   | role    | store   | managedBy | tag     | status  |
      | ngoctx staordersum01ny01 | [blank]  | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin delete buyer "ngoctx staordersum01ny01" in result and verify message "This buyer could not be deleted because he/she has been placed at least 1 order. You must delete all associated entities before deleting this one."

#  @AdminBuyer_06 @AdminBuyer
#  Scenario: Verify buyer onboarding
#    Given USER open web user
#    And User register onboard
#      | nameCompany          | email                       | website               | hear     | comment |
#      | Auto Onboard Ngoc 02 | auto_onboard_ngoc@gmail.com | auto_onboard_ngoc.com | Retailer | Comment |
#    And User choose contact type and fill info
#      | role     | firstname | lastname | phone      | contactRole | storeLocation | businessAddress              | ein       |
#      | Retailer | Auto      | Test     | 0123456789 | QA Auto     | Chicagoland   | 81 Columbus Avenue, New York | 123456789 |
#    And User choose region store located in
#      | region      |
#      | Chicagoland |
#    And User choose category
#      | category     |
#      | Baby & Child |
#    And User go to Next
#    Then User verify about your company
#      | nameCompany          | email                       |
#      | Auto Onboard Ngoc 02 | auto_onboard_ngoc@gmail.com |
#    And User fill info about company
#      | nameCompany | nameCompanyDBA | date     | fein      | email                 | storePhone | storeSize | storeTypes    |
#      | random      | random         | 05/01/20 | 123456789 | mailCompany@gmail.com | 0123456789 | <50k      | Grocery Store |
#    And User fill info your company address
#      | address1               | address2 | city    | state    | zip   | timeZone                   |
#      | 700 North Clark Street | [blank]  | Chicago | Illinois | 60654 | Central Time (US & Canada) |
#    Then User verify about your account
#      | firstName | lastName | phone    |
#      | Auto      | Test     | 01234567 |
#    And User fill info your account
#      | firstName | lastName | email  | phone      | password  | confirmPass |
#      | Auto      | Onboard  | random | 0123456789 | 12345678a | 12345678a   |
#    And User get started
#    And User verify onboard login screen
#      | email  | role  |
#      | random | buyer |
#    When login to onboard web
#    Then User verify info Receiving in Retailer Details
#      | address                | city    | state    | zip   | phone      |
#      | 700 North Clark Street | Chicago | Illinois | 60654 | 0123456789 |
#    When User fill info Receiving in Retailer Details
#      | receivingDay | earliestTime | latestTime | deliveryInstructions  | deliveryNote  | liftDate | pallets |
#      | Monday       | 00:00        | 06:00      | Delivery Instructions | Delivery Note | Yes      | No      |
#    Then User verify field empty Buying in Retailer Details
#    When User fill info Buying in Retailer Details
#      | prefered | category | departmentBuyerName   | departmentBuyerEmail | departmentBuyerPhone | additionalDepartment  | additionalDepartmentBuyerName    | additionalDepartmentBuyerEmail | additionalDepartmentBuyerInfo    | interested |
#      | Email    | Dairy    | Department Buyer Name | autotest@gmail.com   | 0123456789           | Additional Department | Additional Department Buyer Name | autoOnboard@gmail.com          | Additional Department Infomation | Yes        |
#    Then User verify field empty Trade references in Retailer Details
#    When User fill info Trade references in Retailer Details
#      | trade1                 | trade2                 | trade3                 |
#      | Auto Trade Reference 1 | Auto Trade Reference 2 | Auto Trade Reference 3 |
#    Then User verify field empty Financial in Retailer Details
#    When User fill info Financial in Retailer Details
#      | accountPlayableName | accountPlayableEmail          | accountPlayablePhone | accountPlayableMailingAddress | bankruptcy | receiveInvoice |
#      | Auto AP 1105        | ngoc+auto_ap_1105@podfoods.co | 0987654321           | [blank]                       | Yes        | Yes            |
#    Then User verify empty in Certificate
#    When User upload file Certificated
#      | businessCertificate | resaleCertificate |
#      | anhJPEG.jpg         | anhPNG.png        |
#    When User verify after upload in Certificate
#    Then User verify Review Tos in Certificate
#      | name         | date        |
#      | Auto Onboard | currentDate |
#    When User check Term in Review Tos
#    And User summit to finish
#
#
#    Given NGOC_ADMIN_13 open web admin
#    When NGOC_ADMIN_13 login to web with role Admin
#    And NGOC_ADMIN_13 navigate to "Buyers" to "Buyer companies" by sidebar
#    And Admin search buyer company
#      | name   | managedBy | status  | tag     |
#      | random | [blank]   | [blank] | [blank] |
#    Then Admin verify result buyer company
#      | name        | ein       | website               | status    |
#      | AutoOnboard | 123456789 | auto_onboard_ngoc.com | In review |
#    When Admin go to detail of buyer company "AutoOnboard"
#    Then Admin verify general information of buyer company
#      | state  | name   | managedBy | launchedBy | storeType     | ein       | website               | limit     | onboardStatus | edi | fuel |
#      | Active | random | [blank]   | [blank]    | Grocery Store | 123456789 | auto_onboard_ngoc.com | $1,000.00 | In review     | Yes | Yes  |
#
#    And NGOC_ADMIN_13 navigate to "Buyers" to "All buyers" by sidebar
#    And Admin search all buyer
#      | anyText | fullName | email   | role          | store  | managedBy | tag     | status  |
#      | random  | [blank]  | [blank] | Store manager | random | [blank]   | [blank] | [blank] |
#    Then Admin verify result all buyer
#      | name         | region | role          | email       | store       |
#      | Auto Onboard | N      | Store manager | autoonboard | AutoOnboard |
#    When Admin go to detail of buyer "Auto Onboard"
#    And Admin verify general information of all buyer
#      | email  | firstName | lastName | contact    | region | store  | role          | department |
#      | random | Auto      | Onboard  | 0123456789 | N/A    | random | Store manager | [blank]    |
#    And NGOC_ADMIN_13 navigate to "Financial" to "Store statements" by sidebar
#    And Admin fill password to authen permission
#    And Admin search store statements
#      | buyerCompany | store   | buyer   | statementMonth | region  | managedBy |
#      | onboard      | [blank] | [blank] | currentDate    | [blank] | [blank]   |
#    And Admin no found data in result

  @AdminBuyer_07 @AdminBuyer
  Scenario: Verify admin bulk update buyer
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx13@podfoods.co | 12345678a |
    # Change general information of buyer company
    And Admin change info of buyer company "2654" by API
      | store_type_id | manager_id | launcher_id |
      | 2             | [blank]    | [blank]     |

    Given NGOC_ADMIN_13 open web admin
    When NGOC_ADMIN_13 login to web with role Admin
    And NGOC_ADMIN_13 navigate to "Buyers" to "Buyer companies" by sidebar
    And Admin search buyer company
      | name                     | managedBy | status  | tag     |
      | AT Buyer Company Bulk 01 | [blank]   | [blank] | [blank] |
    And Admin select buyer company in result
      | buyerCompany             |
      | AT Buyer Company Bulk 01 |
    And Admin search buyer company
      | name                     | managedBy | status  | tag     |
      | AT Buyer Company Bulk 02 | [blank]   | [blank] | [blank] |
    And Admin select buyer company in result
      | buyerCompany             |
      | AT Buyer Company Bulk 02 |
    And Admin clear section bulk edit in result
    And Admin search buyer company
      | name                     | managedBy | status  | tag     |
      | AT Buyer Company Bulk 01 | [blank]   | [blank] | [blank] |
    And Admin select buyer company in result
      | buyerCompany             |
      | AT Buyer Company Bulk 01 |
    And Admin search buyer company
      | name                     | managedBy | status  | tag     |
      | AT Buyer Company Bulk 02 | [blank]   | [blank] | [blank] |
    And Admin select buyer company in result
      | buyerCompany             |
      | AT Buyer Company Bulk 02 |

    And Admin go to bulk edit in result
    And Admin update bulk buyer company
      | managedBy  | launchedBy | storeType |
      | ngoctx1318 | ngoctx1318 | Others    |
    And Admin update bulk vendor company success

    And Admin go to detail of buyer company "AT Buyer Company Bulk 02"
    Then Admin verify general information of buyer company
      | state  | name                     | managedBy  | launchedBy | storeType | ein     | website | limit     | onboardStatus | edi | fuel |
      | Active | AT Buyer Company Bulk 02 | ngoctx1318 | ngoctx1318 | Others    | [blank] | [blank] | $1,000.00 | Approved      | Yes | Yes  |
    And Admin go to buyer company "2654" by url
    Then Admin verify general information of buyer company
      | state  | name                     | managedBy  | launchedBy | storeType | ein     | website | limit     | onboardStatus | edi | fuel |
      | Active | AT Buyer Company Bulk 01 | ngoctx1318 | ngoctx1318 | Others    | [blank] | [blank] | $1,000.00 | Approved      | Yes | Yes  |

  @AdminBuyer_08 @AdminBuyer
  Scenario: Verify filter of buyer company
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx13@podfoods.co | 12345678a |
    # Reset search filter full textbox
    And Admin filter visibility with id "75" by api
      | q[name]             |
      | q[manager_id]       |
      | q[onboarding_state] |
      | q[tag_ids][]        |

    Given NGOC_ADMIN_13 open web admin
    When NGOC_ADMIN_13 login to web with role Admin
    And NGOC_ADMIN_13 navigate to "Buyers" to "Buyer companies" by sidebar
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | name | managedBy | onboardStatus | tags |
      | Yes  | Yes       | Yes           | Yes  |
    Then Admin verify field search uncheck all in edit visibility
      | name | managedByStore | onboardStatus | tags |
      | Yes  | Yes            | Yes           | Yes  |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    When Admin uncheck field of edit visibility in search
      | name | managedBy | onboardStatus | tags |
      | Yes  | Yes       | Yes           | Yes  |
    Then Admin verify field search in edit visibility
      | name | managedByStore | onboardStatus | tags |
      | Yes  | Yes            | Yes           | Yes  |
    # Verify save new filter
    And Admin search buyer company
      | name                     | managedBy  | status   | tag                |
      | AT Buyer Company 01 Edit | ngoctx1301 | Approved | all private target |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in buyer company
      | name                     | managedBy  | onboardStatus | tag                |
      | AT Buyer Company 01 Edit | ngoctx1301 | Approved      | all private target |
    # Verify save as filter
    And Admin search buyer company
      | name                     | managedBy  | status    | tag                |
      | AT Buyer Company 01 Edit | ngoctx1301 | In Review | all private target |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in buyer company
      | name                     | managedBy  | onboardStatus | tag                |
      | AT Buyer Company 01 Edit | ngoctx1301 | Approved      | all private target |

    Given NGOC_ADMIN_161 open web admin
    When login to beta web with email "ngoctx1623@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_161 navigate to "Buyers" to "Buyer companies" by sidebar
    And Admin search buyer company
      | name    | managedBy | status  | tag     |
      | [blank] | [blank]   | [blank] | [blank] |
    Then Admin verify filter "AutoTest1" is not display

    And Switch to actor NGOC_ADMIN_13
    And Admin delete filter preset is "AutoTest1"
    Then Admin verify filter "AutoTest1" is not display

  @AdminBuyer_09 @AdminBuyer
  Scenario: Verify filter of buyer
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx13@podfoods.co | 12345678a |
    # Reset search filter full textbox
    And Admin filter visibility with id "12" by api
      | q[any_text]         |
      | q[full_name]        |
      | q[email]            |
      | q[role]             |
      | q[store_id]         |
      | q[store_manager_id] |
      | q[tag_ids][]        |
      | q[active_state]     |

    Given NGOC_ADMIN_13 open web admin
    When NGOC_ADMIN_13 login to web with role Admin
    And NGOC_ADMIN_13 navigate to "Buyers" to "All buyers" by sidebar
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | anyText | fullName | email | role | store | managedBy | tags | status |
      | Yes     | Yes      | Yes   | Yes  | Yes   | Yes       | Yes  | Yes    |
    Then Admin verify field search uncheck all in edit visibility
      | anyText | fullName | email | role | store | managedBy | tags | active_state_vendor |
      | Yes     | Yes      | Yes   | Yes  | Yes   | Yes       | Yes  | Yes                 |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    When Admin uncheck field of edit visibility in search
      | anyText | fullName | email | role | store | managedBy | tags | status |
      | Yes     | Yes      | Yes   | Yes  | Yes   | Yes       | Yes  | Yes    |
    Then Admin verify field search in edit visibility
      | anyText | fullName | email | role | store | managedBy | tags | active_state_vendor |
      | Yes     | Yes      | Yes   | Yes  | Yes   | Yes       | Yes  | Yes                 |
    # Verify save new filter
    And Admin search all buyer
      | anyText        | fullName       | email                      | role          | store             | managedBy | tag                | status   |
      | ngoctx mailb01 | ngoctx mailb01 | ngoctx+mailb01@podfoods.co | Store manager | ngoctx stOrder173 | ngoctx666 | all private target | Inactive |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in buyer
      | anyText        | fullName       | email                      | role          | store             | managedBy | tag                | status   |
      | ngoctx mailb01 | ngoctx mailb01 | ngoctx+mailb01@podfoods.co | Store manager | ngoctx stOrder173 | ngoctx666 | all private target | Inactive |
    # Verify save as filter
    And Admin search all buyer
      | anyText        | fullName       | email                      | role       | store             | managedBy | tag                | status |
      | ngoctx mailb01 | ngoctx mailb01 | ngoctx+mailb01@podfoods.co | Head buyer | ngoctx stOrder173 | ngoctx666 | all private target | Active |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in buyer
      | anyText        | fullName       | email                      | role       | store             | managedBy | tag                | status |
      | ngoctx mailb01 | ngoctx mailb01 | ngoctx+mailb01@podfoods.co | Head buyer | ngoctx stOrder173 | ngoctx666 | all private target | Active |

    Given NGOC_ADMIN_161 open web admin
    When login to beta web with email "ngoctx1623@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_161 navigate to "Buyers" to "All buyers" by sidebar
    And Admin search buyer company
      | name    | managedBy | status  | tag     |
      | [blank] | [blank]   | [blank] | [blank] |
    Then Admin verify filter "AutoTest1" is not display

    And Switch to actor NGOC_ADMIN_13
    And Admin delete filter preset is "AutoTest1"
    Then Admin verify filter "AutoTest1" is not display

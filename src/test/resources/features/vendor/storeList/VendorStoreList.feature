#mvn clean verify -Dtestsuite="AddToCartTestSuite" -Dcucumber.options="src/test/resources/features/addtocart" -Denvironments=product
@feature=vendorStoreList
Feature: Vendor Store List

  @V_STORELIST_1
  Scenario: Check displayed information on the page
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor check warning on store list page

  @V_STORELIST_6
  Scenario: Check displayed information on the Create form
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Click on button "New Account"
    And Check any text "is" showing on screen
      | Store not on the list? Use this form to enter information we can use to start the process of onboarding a new store you would like us to distribute to. |
      | Either one of email or phone number should be entered                                                                                                   |
    And Vendor create account store list
      | storeName | storeAddress | skuList | buyerName | email   | phone   | confirmation | distribution |
      | [blank]   | [blank]      | [blank] | [blank]   | [blank] | [blank] | [blank]      | [blank]      |
    And Vendor check error message is showing of fields
      | field                   | message                    |
      | Store name              | This field cannot be blank |
      | Buyer name              | This field cannot be blank |
      | Email                   | This field cannot be blank |
      | Phone number            | This field cannot be blank |
      | Confirmation from buyer | This field cannot be blank |
    And Vendor create account store list
      | storeName       | storeAddress | skuList | buyerName       | email   | phone | confirmation | distribution |
      | Auto store list | [blank]      | [blank] | Auto buyer name | auto.co | a     | Yes          | [blank]      |
    And Vendor check error message not showing of fields
      | field                   | message                    |
      | Store name              | This field cannot be blank |
      | Buyer name              | This field cannot be blank |
      | Confirmation from buyer | This field cannot be blank |
    And Vendor check error message is showing of fields
      | field        | message                                     |
      | Email        | Please enter a valid email                  |
      | Phone number | Please enter a valid 10-digits phone number |
    And Vendor create account store list
      | storeName | storeAddress | skuList | buyerName | email | phone     | confirmation | distribution |
      | [blank]   | [blank]      | [blank] | [blank]   | auto@ | 012345678 | [blank]      | [blank]      |
    And Vendor check error message is showing of fields
      | field        | message                                     |
      | Email        | Please enter a valid email                  |
      | Phone number | Please enter a valid 10-digits phone number |
    And Vendor create account store list
      | storeName | storeAddress | skuList | buyerName | email     | phone       | confirmation | distribution |
      | [blank]   | [blank]      | [blank] | [blank]   | auto@auto | 01234567890 | [blank]      | [blank]      |
    And Vendor check error message is showing of fields
      | field        | message                                     |
      | Email        | Please enter a valid email                  |
      | Phone number | Please enter a valid 10-digits phone number |
    And Vendor create account store list
      | storeName | storeAddress | skuList  | buyerName | email            | phone      | confirmation | distribution    |
      | [blank]   | [blank]      | Auto SKU | [blank]   | auto@podfoods.co | 0123456789 | [blank]      | Auto distribute |
    And Vendor check alert message
      | Thank you for referring the new account to Pod Foods. We will reach out to this account shortly. |
    And Click on button "New Account"
    And Vendor create account store list
      | storeName       | storeAddress | skuList | buyerName       | email            | phone      | confirmation | distribution |
      | Auto store list | [blank]      | [blank] | Auto buyer name | auto@podfoods.co | 0123456789 | No           | [blank]      |
    And Vendor check alert message
      | Thank you for referring the new account to Pod Foods. We will reach out to this account shortly. |


  @V_STORELIST_23
  Scenario: Verify Search and Filter function
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany            | region                   | storeType     | keyAccount | distributionType   |
      | AT Buyer Cpn Success 01 | [blank]                  | [blank]       | [blank]    | [blank]            |
      | [blank]                 | Chicagoland Express      | [blank]       | [blank]    | [blank]            |
      | [blank]                 | Florida Express          | [blank]       | [blank]    | [blank]            |
      | [blank]                 | Mid Atlantic Express     | [blank]       | [blank]    | [blank]            |
      | [blank]                 | New York Express         | [blank]       | [blank]    | [blank]            |
      | [blank]                 | North California Express | [blank]       | [blank]    | [blank]            |
      | [blank]                 | South California Express | [blank]       | [blank]    | [blank]            |
      | [blank]                 | Dallas Express           | [blank]       | [blank]    | [blank]            |
      | [blank]                 | Pod Direct Central       | [blank]       | [blank]    | [blank]            |
      | [blank]                 | Pod Direct East          | [blank]       | [blank]    | [blank]            |
#      | [blank]                 | Pod Direct Southeast           | [blank]       | [blank]    | [blank]            |
#      | [blank]                 | Pod Direct Southwest & Rockies | [blank]       | [blank]    | [blank]            |
      | [blank]                 | Pod Direct West          | [blank]       | [blank]    | [blank]            |
      | [blank]                 | [blank]                  | Grocery Store | [blank]    | [blank]            |
      | [blank]                 | [blank]                  | [blank]       | Yes        | [blank]            |
      | [blank]                 | [blank]                  | [blank]       | No         | [blank]            |
      | [blank]                 | [blank]                  | [blank]       | [blank]    | Self deliver       |
      | [blank]                 | [blank]                  | [blank]       | [blank]    | Other distributor  |
      | [blank]                 | [blank]                  | [blank]       | [blank]    | Transfer to Pod    |
      | [blank]                 | [blank]                  | [blank]       | [blank]    | Pod is Distributor |
      | AT Buyer Cpn Success 01 | New York Express         | Grocery Store | Yes        | Self deliver       |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |

  @V_STORELIST_41
  Scenario: Verify the Store List
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
     # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api

    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | Auto bcn store list 1 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | Auto bcn store list 2 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
   # Create buyer company by api
    And Admin create buyer company by API
      | name                  | ein    | launcher_id | manager_id | website                        | store_type_id |
      | Auto bcn store list 1 | 01-123 | [blank]     | [blank]    | https://auto.podfoods.co/login | 2             |
    # Create store by api
    And Admin create store by API
      | name                    | email                     | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | Auto store store list 1 | at+storelist1@podfoods.co | 53        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
  # Create store by api
    And Admin create store by API
      | name                    | email                     | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | Auto store store list 2 | at+storelist2@podfoods.co | 53        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 1 | [blank] | [blank]   | [blank]    | [blank]          |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |
  # Create buyer account
    And Admin create "store" buyer account by API
      | first_name       | last_name  | email                                 | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atbuyerstorelist | storelist1 | ngoctx+atbuyerstorelist01@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |

     # Create order
    Given Buyer login web with by api
      | email                                 | password  |
      | ngoctx+atbuyerstorelist01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 44468 | 1        |
    And Checkout cart with payment by "invoice" by API

    And VENDOR refresh browser
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 1 | [blank] | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany          | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note    | podFoodsNotes |
      | Auto bcn store list 1 | Grocery Store | -          | -            | -                | -         | No         | [blank] | -             |
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 1 | [blank] | [blank]   | [blank]    | [blank]          |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |

    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 1 | [blank] | [blank]   | [blank]    | [blank]          |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |
 # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api
    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | Auto bcn store list 2 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | Auto bcn store list 1 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
#    Then Vendor verify store list after search
#      | buyerCompany          | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note    | podFoodsNotes |
#      | Auto bcn store list 1 | Grocery Store | -          | -            | -                | -         | No         | [blank] | -             |

  @V_STORELIST_44
  Scenario: Verify the Store List 2
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
     # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api

    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | Auto bcn store list 3 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
   # Create buyer company by api
    And Admin create buyer company by API
      | name                  | ein    | launcher_id | manager_id | website                        | store_type_id |
      | Auto bcn store list 3 | 01-123 | [blank]     | [blank]    | https://auto.podfoods.co/login | 2             |
    # Create store by api
    And Admin create store by API
      | name                    | email                     | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | Auto store store list 3 | at+storelist3@podfoods.co | 53        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 3 | [blank] | [blank]   | [blank]    | [blank]          |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |
  # Create buyer account
    And Admin create "store" buyer account by API
      | first_name       | last_name  | email                                 | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atbuyerstorelist | storelist3 | ngoctx+atbuyerstorelist03@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |

     # Create order
    Given Buyer login web with by api
      | email                                 | password  |
      | ngoctx+atbuyerstorelist03@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 44468 | 101      |
    And Checkout cart with payment by "invoice" by API

    And VENDOR refresh browser
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 3 | [blank] | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany          | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note    | podFoodsNotes |
      | Auto bcn store list 3 | Grocery Store | -          | -            | -                | -         | No         | [blank] | -             |
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 3 | [blank] | [blank]   | [blank]    | [blank]          |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
#     # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 3 | [blank] | [blank]   | [blank]    | [blank]          |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |
 # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api
    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | Auto bcn store list 3 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API

  @V_STORELIST_47
  Scenario: Verify the Store List 4
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
     # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api

    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | Auto bcn store list 4 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
   # Create buyer company by api
    And Admin create buyer company by API
      | name                  | ein    | launcher_id | manager_id | website                        | store_type_id |
      | Auto bcn store list 4 | 01-123 | [blank]     | [blank]    | https://auto.podfoods.co/login | 2             |
    # Create store by api
    And Admin create store by API
      | name                    | email                     | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | Auto store store list 4 | at+storelist4@podfoods.co | 53        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
    # Create buyer account
    And Admin create "store" buyer account by API
      | first_name       | last_name  | email                                 | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atbuyerstorelist | storelist4 | ngoctx+atbuyerstorelist04@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |
     # Create order
    Given Buyer login web with by api
      | email                                 | password  |
      | ngoctx+atbuyerstorelist04@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 44468 | 1        |
    And Checkout cart with payment by "invoice" by API
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    And Admin change state of store "create by api" to "inactive"
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 4 | [blank] | [blank]   | [blank]    | [blank]          |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |
    #    Change buyer company to "inactive"
    And Admin change state of buyer company "create by api" to "inactive" by API
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 4 | [blank] | [blank]   | [blank]    | [blank]          |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |
     # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api
    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | Auto bcn store list 4 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API

  @V_STORELIST_49 @V_STORELIST_55
  Scenario: Check display of a buyer company record in the list
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
     # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api
    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | Auto bcn store list 5 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
   # Create buyer company by api
    And Admin create buyer company by API
      | name                  | ein    | launcher_id | manager_id | website                        | store_type_id |
      | Auto bcn store list 5 | 01-123 | [blank]     | [blank]    | https://auto.podfoods.co/login | 2             |
    # Create store by api
    And Admin create store by API
      | name                    | email                     | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | Auto store store list 5 | at+storelist5@podfoods.co | 53        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
    # Create buyer account
    And Admin create "store" buyer account by API
      | first_name       | last_name  | email                                 | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atbuyerstorelist | storelist5 | ngoctx+atbuyerstorelist05@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |

    Given BAO_ADMIN12 open web admin
    When BAO_ADMIN12 login to web with role Admin
    And BAO_ADMIN12 navigate to "Vendors" to "Success forms" by sidebar
    And Admin go to add special buyer company in success form
    And Admin add special buyer company in success form
      | buyerCompany          | region           |
      | Auto bcn store list 5 | New York Express |
    Then Admin add special buyer company in success form then see message "Store list have been added successfully!"

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 5 | [blank] | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany          | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note    | podFoodsNotes |
      | Auto bcn store list 5 | Grocery Store | -          | -            | -                | -         | No         | [blank] | -             |
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 5 | [blank] | [blank]   | [blank]    | [blank]          |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |

       # Create order
    Given Buyer login web with by api
      | email                                 | password  |
      | ngoctx+atbuyerstorelist05@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 44468 | 1        |
    And Checkout cart with payment by "invoice" by API
    And VENDOR refresh browser
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 5 | [blank] | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany          | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note    | podFoodsNotes |
      | Auto bcn store list 5 | Grocery Store | -          | -            | -                | -         | No         | [blank] | -             |
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 5 | [blank] | [blank]   | [blank]    | [blank]          |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |

    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    And Admin update buyer company "api" by API
      | field                        | value |
      | buyer_company[store_type_id] | 3     |
    # Change tag buyer company
    And Admin add tag to buyer company "create by api" by API
      | tag_id | tag_name          |
      | 6      | private brand tag |
    And VENDOR refresh browser
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 5 | [blank] | [blank]   | [blank]    | [blank]          |
    Then Vendor verify store list after search
      | buyerCompany          | storeType | keyAccount | currentStore | distributionType | contacted | sampleSent | note    | podFoodsNotes |
      | Auto bcn store list 5 | Others    | Yes        | -            | -                | -         | No         | [blank] | -             |
    And Vendor check redirect link to buyer company on store list
      | Auto bcn store list 5 |
#     # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api
    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | Auto bcn store list 5 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API

  @V_STORELIST_69
  Scenario: Check EDIT a buyer company record one by one in the list
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
     # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api
    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | Auto bcn store list 7 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
   # Create buyer company by api
    And Admin create buyer company by API
      | name                  | ein    | launcher_id | manager_id | website                        | store_type_id |
      | Auto bcn store list 7 | 01-123 | [blank]     | [blank]    | https://auto.podfoods.co/login | 2             |
    # Create store by api
    And Admin create store by API
      | name                    | email                     | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | Auto store store list 7 | at+storelist7@podfoods.co | 53        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
    # Create buyer account
    And Admin create "store" buyer account by API
      | first_name       | last_name  | email                                 | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atbuyerstorelist | storelist7 | ngoctx+atbuyerstorelist07@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |
     # Create order
    Given Buyer login web with by api
      | email                                 | password  |
      | ngoctx+atbuyerstorelist07@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 44468 | 1        |
    And Checkout cart with payment by "invoice" by API
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 7 | [blank] | [blank]   | [blank]    | [blank]          |
    And Vendor verify store list after search
      | buyerCompany          | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note    | podFoodsNotes |
      | Auto bcn store list 7 | Grocery Store | -          | -            | -                | -         | No         | [blank] | -             |
    Then Vendor edit record store list
      | buyerCompany          | currentStore | distributionType | contacted | sampleSent | note      |
      | Auto bcn store list 7 | Yes          | Self deliver     | Yes       | Yes        | Auto note |
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 7 | [blank] | [blank]   | [blank]    | [blank]          |
    And Vendor verify store list after search
      | buyerCompany          | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note      | podFoodsNotes |
      | Auto bcn store list 7 | Grocery Store | -          | Yes          | Self deliver     | Yes       | Yes        | Auto note | -             |
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 7 | [blank] | [blank]   | [blank]    | [blank]          |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |

  @V_STORELIST_56
  Scenario: Check display of buyer companies when they has bought brands of the vendor => Means the Current Store and the Distribution Type are changed automatically
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
     # Delete order
#    When Search order by sku "44468" by api
#    And Admin delete order of sku "44468" by api
    And Admin delete order by sku of product "random product store list 1 api" by api
    And Admin search product name "random product store list 1 api" by api
    And Admin delete product name "random product store list 1 api" by api
    When Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | Auto bcn store list 8 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
   # Create buyer company by api
    And Admin create buyer company by API
      | name                  | ein    | launcher_id | manager_id | website                        | store_type_id |
      | Auto bcn store list 8 | 01-123 | [blank]     | [blank]    | https://auto.podfoods.co/login | 2             |
     # Create store by api
    And Admin create store by API
      | name                    | email                     | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | Auto store store list 8 | at+storelist8@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
       # Create buyer account
    And Admin create "store" buyer account by API
      | first_name       | last_name   | email                                  | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atbuyerstorelist | storelist82 | ngoctx+atbuyerstorelist082@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |

      # Create store by api
    And Admin create store by API
      | name                    | email                     | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | Auto store store list 9 | at+storelist9@podfoods.co | 53        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
    # Create buyer account
    And Admin create "store" buyer account by API
      | first_name       | last_name   | email                                  | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atbuyerstorelist | storelist81 | ngoctx+atbuyerstorelist081@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |

    And Create product by api with file "CreateProduct.json" and info
      | name                            | brand_id |
      | random product store list 1 api | 3018     |
    And Info of Region
      | region           | id | state  | availability | casePrice | msrp |
      | New York Express | 53 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku store list 1 api" of product ""
     # Create order
    Given Buyer login web with by api
      | email                                  | password  |
      | ngoctx+atbuyerstorelist081@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | [blank]   | [blank] | 1        |
    And Checkout cart with payment by "invoice" by API
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    And Create product by api with file "CreateProduct.json" and info
      | name                            | brand_id |
      | random product store list 1 api | 2811     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku store list 1 api" of product ""
      # Create order
    Given Buyer login web with by api
      | email                                  | password  |
      | ngoctx+atbuyerstorelist082@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | [blank]   | [blank] | 1        |
    And Checkout cart with payment by "invoice" by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 8 | [blank] | [blank]   | [blank]    | [blank]          |
    And Vendor verify store list after search
      | buyerCompany          | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note    | podFoodsNotes | region |
      | Auto bcn store list 8 | Grocery Store | -          | -            | -                | -         | No         | [blank] | -             | CHI    |
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 8 | [blank] | [blank]   | [blank]    | [blank]          |
    And Vendor verify store list after search
      | buyerCompany          | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    | podFoodsNotes | region |
      | Auto bcn store list 8 | Grocery Store | -          | Yes          | Pod is Distributor | -         | No         | [blank] | -             | NY     |
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
     # Delete order
    And Admin delete order by sku of product "random product store list 1 api" by api

    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 8 | [blank] | [blank]   | [blank]    | [blank]          |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany          | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 8 | [blank] | [blank]   | [blank]    | [blank]          |
    And Check any text "is" showing on screen
      | No stores found...            |
      | We couldn't find any matches. |
    And Admin search product name "random product store list 1 api" by api
    And Admin delete product name "random product store list 1 api" by api
    And Admin search buyer company by API
      | buyerCompany          | managedBy | onboardingState | tag     |
      | Auto bcn store list 8 | [blank]   | [blank]         | [blank] |
    And Vendor go to "Unfilled" of store list
    And Admin delete buyer company "" by API


  @V_STORELIST_87
  Scenario: Check MASS EDITING buyer companies in the list
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
     # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api
    When Admin search buyer company by API
      | buyerCompany            | managedBy | onboardingState | tag     |
      | Auto bcn store list 121 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    And Admin search buyer company by API
      | buyerCompany            | managedBy | onboardingState | tag     |
      | Auto bcn store list 122 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
   # Create buyer company by api
    And Admin create buyer company by API
      | name                    | ein    | launcher_id | manager_id | website                        | store_type_id |
      | Auto bcn store list 121 | 01-123 | [blank]     | [blank]    | https://auto.podfoods.co/login | 2             |
    # Create store by api
    And Admin create store by API
      | name                     | email                       | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | Auto store store list 12 | at+storelist121@podfoods.co | 53        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
    # Create buyer account
    And Admin create "store" buyer account by API
      | first_name       | last_name    | email                                  | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atbuyerstorelist | storelist121 | ngoctx+atbuyerstorelist121@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |
 # Admin Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 105349             | 44468              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id      | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | create by api | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

     # Create buyer company by api 2
    And Admin create buyer company by API
      | name                    | ein    | launcher_id | manager_id | website                        | store_type_id |
      | Auto bcn store list 122 | 01-123 | [blank]     | [blank]    | https://auto.podfoods.co/login | 2             |
    # Create store by api
    And Admin create store by API
      | name                      | email                           | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | Auto store store list 122 | ngoctx+storelist122@podfoods.co | 53        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
    # Create buyer account
    And Admin create "store" buyer account by API
      | first_name       | last_name    | email                                  | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atbuyerstorelist | storelist122 | ngoctx+atbuyerstorelist122@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |

     #Buyer Create order
    Given Buyer login web with by api
      | email                                  | password  |
      | ngoctx+atbuyerstorelist122@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 44468 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Unfilled" of store list
#    And Vendor search info of store list
#      | buyerCompany           | region  | storeType | keyAccount | distributionType |
#      | Auto bcn store list 12 | [blank] | [blank]   | [blank]    | [blank]          |
    And Vendor verify store list after search
      | buyerCompany            | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note    | podFoodsNotes |
      | Auto bcn store list 121 | Grocery Store | -          | -            | -                | -         | No         | [blank] | -             |
      | Auto bcn store list 122 | Grocery Store | -          | -            | -                | -         | No         | [blank] | -             |
    And Vendor choose "a" buyer company mass editing store list
      | buyerCompany            |
      | Auto bcn store list 121 |
    And Vendor mass editing store list
      | currentStore | distributionType | contacted | sampleSent | note    |
      | [blank]      | [blank]          | [blank]   | [blank]    | [blank] |
    And Vendor check alert message
      | Stores updated successfully. |
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany            | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 121 | [blank] | [blank]   | [blank]    | [blank]          |
    And Vendor verify store list after search
      | buyerCompany            | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note    | podFoodsNotes |
      | Auto bcn store list 121 | Grocery Store | -          | -            | -                | -         | No         | [blank] | -             |
    And Vendor go to "Unfilled" of store list
    And Vendor search info of store list
      | buyerCompany            | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 122 | [blank] | [blank]   | [blank]    | [blank]          |
    And Vendor choose "a" buyer company mass editing store list
      | buyerCompany            |
      | Auto bcn store list 122 |
    And Check any text "is" showing on screen
      | 1 selected |
    And Click on any text "Unselect all"
    And Check any text "is" showing on screen
      | 0 selected |
    And Vendor choose "all" buyer company mass editing store list
      | buyerCompany            |
      | Auto bcn store list 122 |
    And Check any text "is" showing on screen
      | 1 selected |
    And Vendor mass editing store list
      | currentStore | distributionType | contacted | sampleSent | note      |
      | Yes          | Self deliver     | Yes       | Yes        | Auto note |
    And Vendor check alert message
      | Stores updated successfully. |
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany            | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 122 | [blank] | [blank]   | [blank]    | [blank]          |
    And Vendor verify store list after search
      | buyerCompany            | storeType     | keyAccount | currentStore | distributionType | contacted | sampleSent | note      | podFoodsNotes |
      | Auto bcn store list 122 | Grocery Store | -          | Yes          | Self deliver     | Yes       | Yes        | Auto note | -             |
    And Vendor choose "a" buyer company mass editing store list
      | buyerCompany            |
      | Auto bcn store list 122 |
    And Vendor mass editing store list
      | currentStore | distributionType  | contacted | sampleSent | note    |
      | In progress  | Other distributor | No        | No         | [blank] |
    And Vendor check alert message
      | Stores updated successfully. |
    And Vendor verify store list after search
      | buyerCompany            | storeType     | keyAccount | currentStore | distributionType  | contacted | sampleSent | note      | podFoodsNotes |
      | Auto bcn store list 122 | Grocery Store | -          | In progress  | Other distributor | No        | No         | Auto note | -             |
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
     # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api
    When Admin search buyer company by API
      | buyerCompany            | managedBy | onboardingState | tag     |
      | Auto bcn store list 121 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    And Admin search buyer company by API
      | buyerCompany            | managedBy | onboardingState | tag     |
      | Auto bcn store list 122 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API


  @V_STORELIST_113
  Scenario: Check when user try to mass editing Distribution type = Pod is Distributor
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product store list 1 api" by api
    And Admin search product name "random product store list 1 api" by api
    And Admin delete product name "random product store list 1 api" by api
    When Admin search buyer company by API
      | buyerCompany            | managedBy | onboardingState | tag     |
      | Auto bcn store list 113 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
   # Create buyer company by api
    And Admin create buyer company by API
      | name                    | ein    | launcher_id | manager_id | website                        | store_type_id |
      | Auto bcn store list 113 | 01-123 | [blank]     | [blank]    | https://auto.podfoods.co/login | 2             |
     # Create store by api
    And Admin create store by API
      | name                      | email                       | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | Auto store store list 113 | at+storelist113@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
       # Create buyer account
    And Admin create "store" buyer account by API
      | first_name       | last_name    | email                                  | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atbuyerstorelist | storelist113 | ngoctx+atbuyerstorelist113@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |

    And Create product by api with file "CreateProduct.json" and info
      | name                            | brand_id |
      | random product store list 1 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku store list 1 api" of product ""
     # Create order
    Given Buyer login web with by api
      | email                                  | password  |
      | ngoctx+atbuyerstorelist113@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | [blank]   | [blank] | 1        |
    And Checkout cart with payment by "invoice" by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Store List" by sidebar
    And Vendor go to "Filled" of store list
    And Vendor search info of store list
      | buyerCompany            | region  | storeType | keyAccount | distributionType |
      | Auto bcn store list 113 | [blank] | [blank]   | [blank]    | [blank]          |
    And Vendor verify store list after search
      | buyerCompany            | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    | podFoodsNotes | region |
      | Auto bcn store list 113 | Grocery Store | -          | Yes          | Pod is Distributor | -         | No         | [blank] | -             | CHI    |
    And Vendor choose "all" buyer company mass editing store list
      | buyerCompany            |
      | Auto bcn store list 113 |
    And Vendor mass editing store list
      | currentStore | distributionType | contacted | sampleSent | note    |
      | [blank]      | Transfer to Pod  | [blank]   | [blank]    | [blank] |
    And Vendor check cannot mass editing store list and unselect above stores
      | buyerCompany                                    |
      | - Auto bcn store list 113 (Chicagoland Express) |
    And Check button "Mass Editing" is disable
    And Vendor choose "a" buyer company mass editing store list
      | buyerCompany            |
      | Auto bcn store list 113 |
    And Vendor mass editing store list
      | currentStore | distributionType | contacted | sampleSent | note    |
      | Yes          | [blank]          | [blank]   | [blank]    | [blank] |
    And Vendor check alert message
      | Stores updated successfully. |
    And Vendor verify store list after search
      | buyerCompany            | storeType     | keyAccount | currentStore | distributionType   | contacted | sampleSent | note    | podFoodsNotes | region |
      | Auto bcn store list 113 | Grocery Store | -          | Yes          | Pod is Distributor | -         | No         | [blank] | -             | CHI    |
    Given NGOCTX23 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product store list 1 api" by api
    And Admin search product name "random product store list 1 api" by api
    And Admin delete product name "random product store list 1 api" by api
    When Admin search buyer company by API
      | buyerCompany            | managedBy | onboardingState | tag     |
      | Auto bcn store list 113 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
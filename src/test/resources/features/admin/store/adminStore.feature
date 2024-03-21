@feature=AdminStore
Feature: Admin Store

  @AdminStore_01 @AdminStore
  Scenario: Verify store type
    Given NGOCTX18 login web admin by api
      | email                | password  |
      | ngoctx18@podfoods.co | 12345678a |
    # Delete store type
    And Admin get store type "Auto Type" by API
    And Admin delete store type by API
    # Delete store type
    And Admin get store type "Auto Type Edit" by API
    And Admin delete store type by API

    Given NGOC_ADMIN_18 open web admin
    When NGOC_ADMIN_18 login to web with role Admin
    And NGOC_ADMIN_18 navigate to "Stores" to "Store types" by sidebar
    And Admin go to create store type
    And Admin fill info to create store type
      | name      |
      | Auto Type |
    And Admin Create store type success
    Then Admin verify store type
      | name      |
      | Auto Type |
    When Admin go to edit store type "Auto Type"
    Then Admin verify store type in popup detail
      | name      |
      | Auto Type |
    And Admin fill info to edit store type
      | name           |
      | Auto Type Edit |
    And Admin Update store type success
    Then Admin verify store type
      | name           |
      | Auto Type Edit |
    And Admin delete store type "Auto Type Edit"
    Then Admin verify no found store type "Auto Type Edit" in result
    And Admin delete store type "Grocery Store"
    And Admin verify message error "This store type could not be deleted because it has been set to at least 1 buyer company. You must delete all associated entities before deleting this one."

  @AdminStore_02 @AdminStore
  Scenario: Verify create new store
    Given NGOCTX18 login web admin by api
      | email                | password  |
      | ngoctx18@podfoods.co | 12345678a |
    When Admin search store by API
      | q[name]           | q[has_surcharge] | q[store_size] | q[store_type_id] | q[city] | q[state] | q[receiving_week_day] | q[region_ids] | q[route_id] |
      | ngoctx ststate041 | [blank]          | [blank]       | [blank]          | [blank] | [blank]  | [blank]               | [blank]       | [blank]     |
    And Admin delete store "" by api
    When Admin search store by API
      | q[name]               | q[has_surcharge] | q[store_size] | q[store_type_id] | q[city] | q[state] | q[receiving_week_day] | q[region_ids] | q[route_id] |
      | ngoctx ststate041Edit | [blank]          | [blank]       | [blank]          | [blank] | [blank]  | [blank]               | [blank]       | [blank]     |
    And Admin delete store "" by api
    When Admin search store by API
      | q[name]                   | q[has_surcharge] | q[store_size] | q[store_type_id] | q[city] | q[state] | q[receiving_week_day] | q[region_ids] | q[route_id] |
      | Autotest1 !@#$%^&*()_+,.. | [blank]          | [blank]       | [blank]          | [blank] | [blank]  | [blank]               | [blank]       | [blank]     |
    And Admin delete store "" by api

    Given NGOC_ADMIN_18 open web admin
    When NGOC_ADMIN_18 login to web with role Admin
    And NGOC_ADMIN_18 navigate to "Stores" to "All stores" by sidebar
    And Admin go to create store
    And Admin verify error field when create store
    And Admin fill info to create store
      | name             | email                        | region              | timeZone                   | storeSize | buyerCompany | phone      | street                | city    | state    | zip   |
      | ngoctx ststate04 | ngoctx+ststate01@podfoods.co | Chicagoland Express | Pacific Time (US & Canada) | <50k      | ngoc cpn1    | 0123456789 | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin create store success
    And Admin verify message error "Validation failed: Name has already been taken"
    And Admin fill info to create store
      | name              | email                        | apEmail                        | region              | timeZone                   | storeSize | buyerCompany | phone      | street                | city    | state    | zip   |
      | ngoctx ststate041 | ngoctx+ststate01@podfoods.co | ngoctx+apststate01@podfoods.co | Chicagoland Express | Pacific Time (US & Canada) | <50k      | ngoc cpn1    | 0123456789 | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin fill info receiving section to create store
      | expressReceivingNote | directReceivingNote | possibleDeliveryDay | setReceivingDay | startTime | endTime |
      | expressReceivingNote | directReceivingNote | Monday              | Monday          | 00:30     | 01:00   |
      |                      |                     | Tuesday             | Tuesday         |           |         |
      |                      |                     | Wednesday           | Wednesday       |           |         |
      |                      |                     | Thursday            | Thursday        |           |         |
      |                      |                     | Friday              | Friday          |           |         |
      |                      |                     | Saturday            | Saturday        |           |         |
      |                      |                     | Sunday              | Sunday          |           |         |
    And Admin fill info shipping address section to create store
      | sos | defaultSOS | sosThreshold | sosAmount | mileage | attn |
      | Yes | Yes        | [blank]      | [blank]   | [blank] | ATTN |
    And Admin add tags in create store
      | tags                | expiryDate  |
      | all private target  | currentDate |
      | Private tag for all | currentDate |
    And Admin delete tags in create store
      | tag                 |
      | Private tag for all |
    And Admin create store success

    And NGOC_ADMIN_18 navigate to "Stores" to "All stores" by sidebar
  # Verify search by Name criteria
    And Admin search all store
      | name                  | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate0411231 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin no found data in result
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type          | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | Grocery Store | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
 # Verify search by SOS criteria
    And Admin search all store
      | name              | sos | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | No  | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin no found data in result
    And Admin search all store
      | name              | sos | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | Yes | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type          | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | Grocery Store | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Verify search by Size criteria
    And Admin search all store
      | name              | sos     | size     | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | 50k-100k | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin no found data in result
    And Admin search all store
      | name              | sos     | size | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | <50k | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type          | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | Grocery Store | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Verify search by Type criteria
    And Admin search all store
      | name              | sos     | size    | type   | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | Others | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin no found data in result
    And Admin search all store
      | name              | sos     | size    | type          | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | Grocery Store | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type          | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | Grocery Store | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Verify search by City criteria
    And Admin search all store
      | name              | sos     | size    | type    | city     | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | New York | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin no found data in result
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | Chicago | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type          | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | Grocery Store | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Verify search by State criteria
    And Admin search all store
      | name              | sos     | size    | type    | city    | state    | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | Michigan | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin no found data in result
    And Admin search all store
      | name              | sos     | size    | type    | city    | state    | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | Illinois | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type    | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Verify search by delivery criteria
    # Monday
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | Monday  | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type    | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Tuesday
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | Tuesday | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type    | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Wednesday
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive   | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | Wednesday | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type    | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Thursday
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive  | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | Thursday | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type    | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Friday
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | Friday  | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type    | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Saturday
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive  | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | Saturday | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type    | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Sunday
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | Sunday  | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type    | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
      # Verify search by Region criteria
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region           | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | New York Express | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin no found data in result
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region              | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | Chicagoland Express | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type    | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Verify search by Route criteria
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route      | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | Unassigned | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type    | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Verify search by Managed by criteria
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | ngoctx18  | [blank] | [blank]      | [blank] |
    And Admin no found data in result
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy     | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | thuy_admin123 | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type    | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Verify search by Tag criteria
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag                 | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | Private tag for all | [blank]      | [blank] |
    And Admin no found data in result
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag                | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | all private target | [blank]      | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type    | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    # Verify search by buyer company criteria
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region           | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | New York Express | [blank] | [blank]   | [blank] | ngoc cpn2    | [blank] |
    And Admin no found data in result
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | ngoc cpn1    | [blank] |
    Then Admin verify result all store
      | store             | region | sos | size | type    | contact                                         | delivery              | managedBy     | launchedBy    |
      | ngoctx ststate041 | CHI    | Yes | <50k | [blank] | 1544 West 18th Street, Chicago, Illinois, 60608 | MonTueWedThuFriSatSun | thuy_admin123 | thuy_admin123 |
    And Admin go to detail of store "ngoctx ststate041"
      # Verify general information
    And Admin verify general information of all store
      | name              | nameCompany | stateStore | storeSize | storeType     | invoiceOption | sendInvoice | threshold | region              | street                | city    | state    | zip   | email                        | apEmail | phone      | timezone                   | day     | start | end   | route   | referredBy | liftgateRequired |
      | ngoctx ststate041 | ngoc cpn1   | Active     | <50k      | Grocery Store | Yes           | No          | 35 day(s) | Chicagoland Express | 1544 West 18th Street | Chicago | Illinois | 60608 | ngoctx+ststate01@podfoods.co | [blank] | 0123456789 | Pacific Time (US & Canada) | [blank] | 00:30 | 01:00 | [blank] | [blank]    | No               |
    And Admin verify ap email of store detail
      | apEmail                        |
      | ngoctx+apststate01@podfoods.co |
    And Admin verify small order surcharge of store detail
      | applySOS | sosThreshold | sosAmount |
      | Yes      | $500.00      | $30.00    |
    And Admin verify name field in store detail
      | value                     | message                                        |
      | Autotest1 !@#$%^&*()_+,.. | success                                        |
      | ngoctx ststate04          | Validation failed: Name has already been taken |
    And Admin verify email field in store detail
      | value   | message                             |
      | [blank] | Validation failed: Email is invalid |
    And Admin verify phone field in store detail
      | value            | message                                                                       |
      | 123              | Validation failed: Phone number is the wrong length (should be 10 characters) |
      | [blank]          | Validation failed: Phone number is not a number                               |
      | abcba            | Validation failed: Phone number is not a number                               |
      | 1231241231241234 | Validation failed: Phone number is the wrong length (should be 10 characters) |
    And Admin verify All possible delivery days field in store detail error "Validation failed: All possible delivery days have to contain the set of delivery week days"
    And Admin verify preferred warehouses in store detail
      | warehouse                     | address                                  | distance  |
      | Auto Ngoc Distribution CHI 01 | 1060 West Addison Street, Chicago, 60613 | 8.5 miles |
    # Edit general information
    And Admin change set receiving day in store detail
      | date     | mon     | tue     | wed     | thu     | fri     | sat     | sun     |
      | Full day | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] |
    And Admin change possible delivery day
      | date     | mon     | tue     | wed     | thu     | fri     | sat     | sun     |
      | Full day | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] |
    # Change address then verify preferred warehouse
    And Admin edit address in store detail
      | attn      | street1              | street2 | city     | state    | zip   |
      | ATTN Edit | 100 West 18th Street | street2 | New York | New York | 10011 |
    And Admin verify preferred warehouses in store detail
      | warehouse                     | address                                  | distance  |
      | Auto Ngoc Distribution CHI 01 | 1060 West Addison Street, Chicago, 60613 | 8.5 miles |

#    # Run job to change warehouse
#    Given ADMIN_OLD open web admin old
#    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
#    And Admin run job StripeChargeSubInvoiceJob in sidekiq
    # Edit General info
    And Admin edit general information of store
      | name                  | storeSize | invoiceOption | dateThreshold | mile | referredBy | region           | route             | email                            | phone      | timeZone                    | expressNote              | directNote              | liftGate | retailerStore |
      | ngoctx ststate041Edit | 50k-100k  | Yes           | 30            | 10   | ngoc vc 1  | New York Express | Auto Bao New York | ngoctx+ststate01edit@podfoods.co | 1234567890 | Mountain Time (US & Canada) | expressReceivingNoteEdit | directReceivingNoteEdit | Yes      | 18021993      |
    And Admin change receiving time in store detail
      | startTime | endTime |
      | 01:30     | 02:00   |
    And Admin verify general information of all store
      | name                  | nameCompany | stateStore | storeSize | storeType     | invoiceOption | sendInvoice | threshold | mile       | region           | attn      | street               | street2 | city     | state    | zip   | email                            | apEmail | phone      | timezone                    | day     | start | end   | route             | referredBy | liftgateRequired | retailerStore |
      | ngoctx ststate041Edit | ngoc cpn1   | Active     | 50k-100k  | Grocery Store | No            | No          | 30 day(s) | 10 mile(s) | New York Express | ATTN Edit | 100 West 18th Street | street2 | New York | New York | 10011 | ngoctx+ststate01edit@podfoods.co | [blank] | 1234567890 | Mountain Time (US & Canada) | [blank] | 01:30 | 02:00 | Auto Bao New York | ngoc vc 1  | Yes              | 18021993      |
    # Verify SOS
    And Admin turn off small order surcharge of store detail
    And Admin verify small order surcharge of store detail has been turn off
    And Admin turn on small order surcharge of store detail
    And Admin edit small order surcharge of store detail
      | value       | message                                                                                  |
      | 0           | Validation failed: Small order surcharge amount cents must be greater than or equal to 1 |
      | abc         | Validation failed: Small order surcharge amount cents must be greater than or equal to 1 |
      | 50000000000 | 5000000000000 is out of range for ActiveModel::Type::Integer with limit 4 bytes          |
    And Admin verify navigate footer link
      | link                             | title           |
      | Find all store's orders          | Orders          |
      | Find all store's sample requests | Sample requests |
      | Find all store's credit memo     | Credit memos    |
    And Admin verify name field in store detail
      | value             | message |
      | ngoctx ststate041 | success |
    # Verify history of mileage
    Then Admin verify history of mileage in store
      | state        | updateBy        | updateOn    |
      | 0.00 → 10.00 | Admin: ngoctx18 | currentDate |

    Given NGOCTX18 login web admin by api
      | email                | password  |
      | ngoctx18@podfoods.co | 12345678a |
       # Create buyer account
    And Admin create "store" buyer account by API
      | first_name  | last_name | email                       | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atadstoreba | b01       | atadstoreba+b01@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |
    # Create sub buyer account
    And Admin create "sub" buyer account by API
      | first_name  | last_name | email                       | role      | business_name | contact_number | tag     | store_id      | manager_id    | password  |
      | atadstoreba | s01       | atadstoreba+s01@podfoods.co | sub_buyer | Department    | 1234567890     | [blank] | create by api | create by api | 12345678a |

#    # Create credit memos Not used
    And Switch to actor NGOC_ADMIN_18
    And NGOC_ADMIN_18 navigate to "Financial" to "Credit memos" by sidebar
    When Admin create credit memo with info
      | buyer           | orderID | type              | amount | description      | file                 |
      | atadstoreba b01 | [blank] | Credit memo test1 | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    And Admin create credit memo success

    And NGOC_ADMIN_18 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | ngoc cpn1    | [blank] |
    And Admin go to detail of store "ngoctx ststate041"
    And Admin verify credit memos of store detail
      | creditMemo    | state    |
      | create by api | Not used |

     # Create credit memos Used
    And NGOC_ADMIN_18 navigate to "Financial" to "Credit memos" by sidebar
    When Admin search credit memo
      | number  | buyerEmail | buyer   | store            | buyerCompany | state |
      | [blank] | [blank]    | [blank] | ngoctx ststate01 | [blank]      | Used  |
    And Admin verify first credit memo after search
      | number  | store            | buyer                 |
      | [blank] | ngoctx ststate01 | ngoctx ststate01chi01 |

    And NGOC_ADMIN_18 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name             | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate01 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | ngoc cpn1    | [blank] |
    And Admin go to detail of store "ngoctx ststate01"
    And Admin verify credit memos of store detail
      | creditMemo    | state |
      | create by api | Used  |

    # Create credit memos Cancel
    And NGOC_ADMIN_18 navigate to "Financial" to "Credit memos" by sidebar
    When Admin create credit memo with info
      | buyer           | orderID | type              | amount | description      | file                 |
      | atadstoreba b01 | [blank] | Credit memo test1 | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    And Admin create credit memo success
    And Admin cancel this credit memo

    And NGOC_ADMIN_18 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | ngoc cpn1    | [blank] |
    And Admin go to detail of store "ngoctx ststate041"
    And Admin verify credit memos of store detail
      | creditMemo    | state  |
      | create by api | Cancel |

    # Create credit memos Not used of Sub buyer
    And NGOC_ADMIN_18 navigate to "Financial" to "Credit memos" by sidebar
    When Admin create credit memo with info
      | buyer           | orderID | type              | amount | description      | file                 |
      | atadstoreba s01 | [blank] | Credit memo test1 | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    And Admin create credit memo success

    And NGOC_ADMIN_18 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | ngoc cpn1    | [blank] |
    And Admin go to detail of store "ngoctx ststate041"
    And Admin verify credit memos of store detail
      | creditMemo    | state    |
      | create by api | Not used |

  @AdminStore_03 @AdminStore
  Scenario Outline: Create new store
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx512@podfoods.co | 12345678a |

    # Create store by api
    And Admin create store by API
      | name        | email        | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street                               |
      | <nameStore> | <emailStore> | 64        | Pacific Time (US & Canada) | <50k       | 2             | 2970             | 1234567890   | Chicago | 1544 West 18th Street | 11               | 30303 | 1554   | 80 Jesse Hill Junior Drive Southeast |
     # Create buyer account
    And Admin create "store" buyer account by API
      | first_name | last_name   | email        | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | ngoctx     | <nameBuyer> | <emailBuyer> | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |
    Examples:
      | nameStore        | emailStore                       | nameBuyer      | emailBuyer                        |
      | AT SproutsATL101 | ngoctx+sproutsATL101@podfoods.co | bsproutsatl101 | ngoctx+bsproutsatl101@podfoods.co |

  @AdminStore_04 @AdminStore
  Scenario: Verify edit visibility search in store
    Given NGOCTX18 login web admin by api
      | email                | password  |
      | ngoctx18@podfoods.co | 12345678a |
    # Reset search filter full textbox
    And Admin filter visibility with id "13" by api
      | q[name]               |
      | q[has_surcharge]      |
      | q[store_size]         |
      | q[store_type_id]      |
      | q[city]               |
      | q[state]              |
      | q[receiving_week_day] |
      | q[region_ids]         |
      | q[route_id]           |
      | q[manager_id]         |
      | q[tag_ids][]          |
      | q[store_state]        |
      | q[buyer_company_id]   |

    Given NGOC_ADMIN_18 open web admin
    When NGOC_ADMIN_18 login to web with role Admin
    And NGOC_ADMIN_18 navigate to "Stores" to "All stores" by sidebar
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | name | sos | size | type | city | state | deliveryWeekDay | region | route | managedBy | tags | buyercompany | status |
      | Yes  | Yes | Yes  | Yes  | Yes  | Yes   | Yes             | Yes    | Yes   | Yes       | Yes  | Yes          | Yes    |
    Then Admin verify field search uncheck all in edit visibility
      | name | sos | storeSize | storeType | city | statusInprocess | deliveryWeekDay | region | route | managedByStore | tag | buyerCompany | statusStore |
      | Yes  | Yes | Yes       | Yes       | Yes  | Yes             | Yes             | Yes    | Yes   | Yes            | Yes | Yes          | Yes         |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    When Admin uncheck field of edit visibility in search
      | name | sos | size | type | city | state | deliveryWeekDay | region | route | managedBy | tags | buyercompany | status |
      | Yes  | Yes | Yes  | Yes  | Yes  | Yes   | Yes             | Yes    | Yes   | Yes       | Yes  | Yes          | Yes    |
    Then Admin verify field search in edit visibility
      | name | sos | storeSize | storeType | city | statusInprocess | deliveryWeekDay | region | route | managedByStore | tag | buyerCompany | statusStore |
      | Yes  | Yes | Yes       | Yes       | Yes  | Yes             | Yes             | Yes    | Yes   | Yes            | Yes | Yes          | Yes         |
    # Verify save new filter
    And Admin search all store
      | name              | sos | size | type          | city     | state    | receive | region           | route      | managedBy | tag                | buyerCompany | status |
      | ngoctx ststate041 | Yes | <50k | Grocery Store | New York | New York | Monday  | New York Express | Unassigned | ngoctx18  | all private target | ngoc cpn1    | Active |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in store
      | name              | sos | size | type          | city     | state    | receive | region           | route      | managedBy | tag                | buyerCompany | status |
      | ngoctx ststate041 | Yes | <50k | Grocery Store | New York | New York | Monday  | New York Express | Unassigned | ngoctx18  | all private target | ngoc cpn1    | Active |
    # Verify save as filter
    And Admin search all store
      | name              | sos | size     | type          | city     | state    | receive | region           | route      | managedBy | tag                | buyerCompany | status   |
      | ngoctx ststate041 | No  | 50k-100k | Grocery Store | New York | New York | Monday  | New York Express | Unassigned | ngoctx18  | all private target | ngoc cpn1    | Inactive |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in store
      | name              | sos | size     | type          | city     | state    | receive | region           | route      | managedBy | tag                | buyerCompany | status   |
      | ngoctx ststate041 | No  | 50k-100k | Grocery Store | New York | New York | Monday  | New York Express | Unassigned | ngoctx18  | all private target | ngoc cpn1    | Inactive |

    Given NGOC_ADMIN_161 open web admin
    When login to beta web with email "ngoctx1623@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_161 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate041 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify filter "AutoTest1" is not display

    And Switch to actor NGOC_ADMIN_18
    And Admin delete filter preset is "AutoTest1"
    Then Admin verify filter "AutoTest1" is not display









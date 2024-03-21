@feature=AdminBrand
Feature: Admin Brand

  @AdminBrand_01 @AdminBrand
  Scenario: Create a new brand form
    Given NGOCTX22 login web admin by api
      | email                | password  |
      | ngoctx22@podfoods.co | 12345678a |
   # Delete brand
    And Admin search brand name "AT Brand Create 02" by api
    And Admin delete brand by API

    Given NGOC_ADMIN_22 open web admin
    When NGOC_ADMIN_22 login to web with role Admin
    And NGOC_ADMIN_22 navigate to "Brands" to "All brands" by sidebar
    And Admin go to create brand
    And Admin verify default form create brand
    # Verify brand exist other vendor company
    And Admin create new brand
      | name                     | description | microDescriptions | city    | state   | vendorCompany             | inboundInventoryMOQ |
      | AT Brand Success Form 01 | [blank]     | [blank]           | [blank] | [blank] | AT Vendor Success Form 01 | 1                   |
    And Admin create brand and verify message error "Name has already been taken"
    # Verify brand exist other same company
    And Admin create new brand
      | name               | description | microDescriptions | city    | state   | vendorCompany         | inboundInventoryMOQ |
      | AT Brand Create 01 | [blank]     | [blank]           | [blank] | [blank] | AT Create Brand vc 01 | 1                   |
    And Admin create brand and verify message error "Name has already been taken"
    And Admin create new brand
      | name               | description | microDescriptions | city    | state   | vendorCompany         | inboundInventoryMOQ |
      | AT Brand Create 02 | [blank]     | [blank]           | [blank] | [blank] | AT Create Brand vc 01 | 1                   |
    And Admin verify field description in create brand
    And Admin verify field micro description in create brand
    And Admin verify field inbound inventory MOQ in create brand

    And Admin close create brand
    And Admin go to create brand
    And Admin create new brand
      | name               | description | microDescriptions | city     | state    | vendorCompany         | inboundInventoryMOQ |
      | AT Brand Create 02 | description | microDescriptions | New York | New York | AT Create Brand vc 01 | 1                   |
    And Admin add tags in create brand
      | tags                |
      | all private target  |
      | Private tag for all |
    And Admin delete tags in create new brand
      | tags               |
      | all private target |
    And Admin create brand success

    # Search brand by search term
    And NGOC_ADMIN_22 navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info
      | name               | vendorCompany | state   | managedBy | tags    |
      | AT Brand Create 02 | [blank]       | [blank] | [blank]   | [blank] |
    And Admin verify brand in result search
      | state  | brandName          | pricing | address            | managedBy | launchedBy |
      | Active | AT Brand Create 02 | 25.00%  | New York, New York | ngoctx22  | ngoctx22   |
#     # Search brand by search vendor company
#    And Admin search the brand by info
#      | name               | vendorCompany               | state   | managedBy | tags    |
#      | AT Brand Create 02 | AT Create Vendor Company 01 | [blank] | [blank]   | [blank] |
#    Then Admin no found order in result
#    And Admin search the brand by info
#      | name               | vendorCompany         | state   | managedBy | tags    |
#      | AT Brand Create 02 | AT Create Brand vc 01 | [blank] | [blank]   | [blank] |
#    And Admin verify brand in result search
#      | state  | brandName          | pricing | address            | managedBy | launchedBy |
#      | Active | AT Brand Create 02 | 25.00%  | New York, New York | ngoctx22  | ngoctx22   |
#    # Search brand by search state
#    And Admin search the brand by info
#      | name               | vendorCompany | state    | managedBy | tags    |
#      | AT Brand Create 02 | [blank]       | Inactive | [blank]   | [blank] |
#    Then Admin no found order in result
#    And Admin search the brand by info
#      | name               | vendorCompany         | state  | managedBy | tags    |
#      | AT Brand Create 02 | AT Create Brand vc 01 | Active | [blank]   | [blank] |
#    And Admin verify brand in result search
#      | state  | brandName          | pricing | address            | managedBy | launchedBy |
#      | Active | AT Brand Create 02 | 25.00%  | New York, New York | ngoctx22  | ngoctx22   |
#    # Search brand by search managed by
#    And Admin search the brand by info
#      | name               | vendorCompany | state   | managedBy | tags    |
#      | AT Brand Create 02 | [blank]       | [blank] | ngoctx21  | [blank] |
#    Then Admin no found order in result
#    And Admin search the brand by info
#      | name               | vendorCompany         | state   | managedBy | tags    |
#      | AT Brand Create 02 | AT Create Brand vc 01 | [blank] | ngoctx22  | [blank] |
#    And Admin verify brand in result search
#      | state  | brandName          | pricing | address            | managedBy | launchedBy |
#      | Active | AT Brand Create 02 | 25.00%  | New York, New York | ngoctx22  | ngoctx22   |
#     # Search brand by search tag
#    And Admin search the brand by info
#      | name               | vendorCompany | state   | managedBy | tags               |
#      | AT Brand Create 02 | [blank]       | [blank] | [blank]   | all private target |
#    Then Admin no found order in result
#    And Admin search the brand by info
#      | name               | vendorCompany | state   | managedBy | tags                |
#      | AT Brand Create 02 | [blank]       | [blank] | [blank]   | Private tag for all |
#    And Admin verify brand in result search
#      | state  | brandName          | pricing | address            | managedBy | launchedBy |
#      | Active | AT Brand Create 02 | 25.00%  | New York, New York | ngoctx22  | ngoctx22   |
    And Admin go to brand "AT Brand Create 02" detail from edit
    And Admin verify general information in brand detail
      | status | name               | description | microDescriptions | inboundInventoryMOQ | city     | state    | vendorCompany         | launchedBy | managedBy |
      | Active | AT Brand Create 02 | description | microDescriptions | 1                   | New York | New York | AT Create Brand vc 01 | ngoctx22   | ngoctx22  |
    And Admin verify edit name field in brand detail
      | brandName                | message                     |
      | [blank]                  | Name can't be blank         |
      | AT Brand Success Form 01 | Name has already been taken |
      | !@##$%^&                 | success                     |
      | AT Brand Create 02 Edit  | success                     |
    And Admin verify edit inbound inventory MOQ field in brand detail
      | inbound | message                                      |
      | 0       | Inbound inventory moq must be greater than 0 |
    And Admin edit general information in brand detail
      | brandName               | description      | microDescriptions      | inboundInventoryMOQ | city    | state    | vendorCompany         |
      | AT Brand Create 02 Edit | description edit | microDescriptions edit | 2                   | Chicago | Illinois | AT Create Brand vc 01 |
    And Admin verify general information in brand detail
      | status | name                    | description      | microDescriptions      | inboundInventoryMOQ | city    | state    | vendorCompany         | launchedBy | managedBy |
      | Active | AT Brand Create 02 Edit | description edit | microDescriptions edit | 2                   | Chicago | Illinois | AT Create Brand vc 01 | ngoctx22   | ngoctx22  |
    # verify tag
    And Admin verify default popup tag field in brand detail
      | tag                 |
      | Private tag for all |
    And Admin remove tag field in brand detail
      | tag                 |
      | Private tag for all |
    And Admin add tag field in vendor detail
      | tag                 | expiryDate  |
      | all private target  | currentDate |
      | Private tag for all | currentDate |
    # Verify image logo and cover
    And Admin verify upload image logo in brand detail
    And Upload image of brands
      | logo        | cover      |
      | anhJPEG.jpg | anhPNG.png |
    And Admin verify upload image cover in brand detail
    And Upload image of brands
      | logo        | cover      |
      | anhJPEG.jpg | anhPNG.png |
    # Verify add sub image
    And Admin verify sub image of brands
    And Admin refresh page by button
    And Admin add sub image of brands
      | subImage    |
      | anhJPEG.jpg |
      | anhPNG.png  |

    And NGOC_ADMIN_22 refresh browser
    And Admin verify image in brands detail
      | logo        | cover      |
      | anhJPEG.jpg | anhPNG.png |
    And Admin verify sub image of brands detail
      | subImage    |
      | anhJPEG.jpg |
      | anhPNG.png  |
    # Navigate brand link
    And Admin navigate footer link of brand "AT Brand Create 02" in detail

    # Deactivate brand
    And Admin deactivate brand choose "Yes"
    Then Admin verify history active brand
      | state           | updateBy        | updateOn    |
      | Active→Inactive | Admin: ngoctx22 | currentDate |
    And NGOC_ADMIN_22 wait 2000 mini seconds
    And Admin go to vendor company "2019" by url
    And Admin verify state of vendor company is "Inactive"
     # Activate brand
    And Admin go back by browser
    And Admin activate brand
    Then Admin verify history active brand
      | state           | updateBy        | updateOn    |
      | Inactive→Active | Admin: ngoctx22 | currentDate |
    # Deactivate brand
    And Admin deactivate brand choose "No"
    Then Admin verify history active brand
      | state           | updateBy        | updateOn    |
      | Active→Inactive | Admin: ngoctx22 | currentDate |
    And Admin go to vendor company "2019" by url
    And Admin verify state of vendor company is "Active"

    Given BUYER open web user
    When login to beta web with email "ngoctx+stclaimny02@podfoods.co" pass "12345678a" role "buyer"
    And Search Brands by name "AT Brand Create 02 Edit" then no found

  @AdminBrand_02 @AdminBrand
  Scenario: Create a new brand form
    Given NGOCTX22 login web admin by api
      | email                | password  |
      | ngoctx22@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "44468" by api
    And Admin delete order of sku "44468" by api
    # Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 105349             | 44468              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3334     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_22 open web admin
    When NGOC_ADMIN_22 login to web with role Admin
    And NGOC_ADMIN_22 navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info
      | name              | vendorCompany | state   | managedBy | tags    |
      | AT Brand Claim 01 | [blank]       | [blank] | [blank]   | [blank] |
    And Admin delete brand "AT Brand Claim 01" in result
    Then Admin verify message error "This brand could not be deleted because one of its SKUs has been ordered. You must delete all associated entities before deleting this one."
    And NGOC_ADMIN_22 wait 5000 mini seconds
    And Go to brand detail
    And Admin delete brand in detail
    Then Admin verify message error "This brand could not be deleted because one of its SKUs has been ordered. You must delete all associated entities before deleting this one."

  @AdminBrand_03 @AdminBrand
  Scenario: Check information shown for brand referrals which created by a head buyer with one brand only
    Given NGOCTX22 login web admin by api
      | email                | password  |
      | ngoctx22@podfoods.co | 12345678a |
    # Delete brand
    And Change state of Brand id: "3595" to "active"
    # Search brand referral
    And Admin search brand referral by api
      | q[brand_name]      | q[store_id] |
      | AT Brand Create 01 | 3340        |
    And Admin delete brand referral by api

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcreatebrand01chi01@podfoods.co" pass "12345678a" role "Buyer"
    And Buyer go to "Refer a Brand" from menu bar
    And Check Refer Brand Page
    And Buyer enter Refer Brand info
      | brandName          | email              | contact | currentBrand |
      | AT Brand Create 01 | ngoctx@podfoods.co | ngoctx  | true         |
    And Click on button "Invite"
    And BUYER check dialog message
      | Thank you! |
    And BUYER check dialog message
      | Your form has been submitted. Brands will be invited to Pod Foods by email. Our team will also reach out promptly. Have questions? Email |

    Given NGOC_ADMIN_22 open web admin
    When NGOC_ADMIN_22 login to web with role Admin
    And NGOC_ADMIN_22 navigate to "Brands" to "Brand referrals" by sidebar
    # verify search filter brand
    And Admin search brand referral with info
      | brand              | store   | email   | contact | onboarded | vendorCompany |
      | AT Brand Create 02 | [blank] | [blank] | [blank] | [blank]   | [blank]       |
    And Admin no found brand referral "AT Brand Create 01" in result
    And Admin search brand referral with info
      | brand              | store   | email   | contact | onboarded | vendorCompany |
      | AT Brand Create 01 | [blank] | [blank] | [blank] | [blank]   | [blank]       |
    Then Admin verify result brand referrals
      | date        | store                  | buyer                       | brand              | email              | contactName | working | onboarded | vendorCompany |
      | currentDate | ngoctx stcreateBrand01 | ngoctx stcreateBrand01chi01 | AT Brand Create 01 | ngoctx@podfoods.co | ngoctx      | yes     | no        | [blank]       |
    # verify search filter store
    And Admin search brand referral with info
      | brand              | store          | email   | contact | onboarded | vendorCompany |
      | AT Brand Create 02 | ngoctx stclaim | [blank] | [blank] | No        | [blank]       |
    And Admin no found brand referral "AT Brand Create 01" in result
    And Admin search brand referral with info
      | brand              | store                  | email   | contact | onboarded | vendorCompany |
      | AT Brand Create 01 | ngoctx stcreateBrand01 | [blank] | [blank] | No        | [blank]       |
    Then Admin verify result brand referrals
      | date        | store                  | buyer                       | brand              | email              | contactName | working | onboarded | vendorCompany |
      | currentDate | ngoctx stcreateBrand01 | ngoctx stcreateBrand01chi01 | AT Brand Create 01 | ngoctx@podfoods.co | ngoctx      | yes     | no        | [blank]       |
   # verify search filter email
    And Admin search brand referral with info
      | brand              | store   | email               | contact | onboarded | vendorCompany |
      | AT Brand Create 02 | [blank] | ngoctx1@podfoods.co | [blank] | No        | [blank]       |
    And Admin no found brand referral "AT Brand Create 01" in result
    And Admin search brand referral with info
      | brand              | store   | email              | contact | onboarded | vendorCompany |
      | AT Brand Create 01 | [blank] | ngoctx@podfoods.co | [blank] | No        | [blank]       |
    Then Admin verify result brand referrals
      | date        | store                  | buyer                       | brand              | email              | contactName | working | onboarded | vendorCompany |
      | currentDate | ngoctx stcreateBrand01 | ngoctx stcreateBrand01chi01 | AT Brand Create 01 | ngoctx@podfoods.co | ngoctx      | yes     | no        | [blank]       |
     # verify search filter contact
    And Admin search brand referral with info
      | brand              | store   | email   | contact  | onboarded | vendorCompany |
      | AT Brand Create 02 | [blank] | [blank] | ngoctx01 | No        | [blank]       |
    And Admin no found brand referral "AT Brand Create 01" in result
    And Admin search brand referral with info
      | brand              | store   | email   | contact | onboarded | vendorCompany |
      | AT Brand Create 01 | [blank] | [blank] | ngoctx  | No        | [blank]       |
    Then Admin verify result brand referrals
      | date        | store                  | buyer                       | brand              | email              | contactName | working | onboarded | vendorCompany |
      | currentDate | ngoctx stcreateBrand01 | ngoctx stcreateBrand01chi01 | AT Brand Create 01 | ngoctx@podfoods.co | ngoctx      | yes     | no        | [blank]       |
    # verify search filter onboarded
    And Admin search brand referral with info
      | brand              | store   | email   | contact | onboarded | vendorCompany |
      | AT Brand Create 02 | [blank] | [blank] | [blank] | Yes       | [blank]       |
    And Admin no found brand referral "AT Brand Create 01" in result
    And Admin search brand referral with info
      | brand              | store   | email   | contact | onboarded | vendorCompany |
      | AT Brand Create 01 | [blank] | [blank] | [blank] | No        | [blank]       |
    Then Admin verify result brand referrals
      | date        | store                  | buyer                       | brand              | email              | contactName | working | onboarded | vendorCompany |
      | currentDate | ngoctx stcreateBrand01 | ngoctx stcreateBrand01chi01 | AT Brand Create 01 | ngoctx@podfoods.co | ngoctx      | yes     | no        | [blank]       |
    And Admin delete brand referral "AT Brand Create 01"

  @AdminBrand_04 @AdminBrand
  Scenario: Check information shown for brand referals which created by a normal buyer (Store manager or Store sub-buyer) with multiple brand
    Given NGOCTX22 login web admin by api
      | email                | password  |
      | ngoctx22@podfoods.co | 12345678a |
    # Delete brand
    And Change state of Brand id: "3595" to "active"
    # Search brand referral
    And Admin search brand referral by api
      | q[brand_name]      | q[store_id] |
      | AT Brand Create 01 | 3340        |
    And Admin delete brand referral by api

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcreatebrand01chi01@podfoods.co" pass "12345678a" role "Buyer"
    And Buyer go to "Refer a Brand" from menu bar
    And Check Refer Brand Page
    And Buyer enter Refer Brand info
      | brandName          | email              | contact | currentBrand |
      | AT Brand Create 01 | ngoctx@podfoods.co | ngoctx  | true         |
      | AT Brand Create 02 | ngoctx@podfoods.co | ngoctx  | true         |
      | AT Brand Create 02 | [blank]            | [blank] | false        |
    And Click on button "Invite"
    And BUYER check dialog message
      | Thank you! |
    And BUYER check dialog message
      | Your form has been submitted. Brands will be invited to Pod Foods by email. Our team will also reach out promptly. Have questions? Email |

    Given NGOC_ADMIN_22 open web admin
    When NGOC_ADMIN_22 login to web with role Admin
    And NGOC_ADMIN_22 navigate to "Brands" to "Brand referrals" by sidebar
    # verify search filter brand
    And Admin search brand referral with info
      | brand   | store                  | email   | contact | onboarded | vendorCompany |
      | [blank] | ngoctx stcreateBrand01 | [blank] | [blank] | [blank]   | [blank]       |
    Then Admin verify result brand referrals
      | date        | store                  | buyer                       | brand              | email              | contactName | working | onboarded | vendorCompany |
      | currentDate | ngoctx stcreateBrand01 | ngoctx stcreateBrand01chi01 | AT Brand Create 01 | ngoctx@podfoods.co | ngoctx      | yes     | no        | [blank]       |
      | currentDate | ngoctx stcreateBrand01 | ngoctx stcreateBrand01chi01 | AT Brand Create 02 | ngoctx@podfoods.co | ngoctx      | yes     | no        | [blank]       |
      | currentDate | ngoctx stcreateBrand01 | ngoctx stcreateBrand01chi01 | AT Brand Create 02 | [blank]            | [blank]     | no      | no        | [blank]       |
    Then Admin verify general information of brand referral detail
      | store                  | buyer                       | date        |
      | ngoctx stcreateBrand01 | ngoctx stcreateBrand01chi01 | currentDate |
    And Admin verify brand field of brand referral
    And Admin edit info of brand referral
      | brand              | brandEdit   | email                          | contact           | work | vendorCompany | note      |
      | AT Brand Create 01 | AT_Brand_01 | ngoctx+AT_Brand_01@podfoods.co | Contact Ngoctx_01 | No   | [blank]       | Auto Note |
      | AT Brand Create 02 | AT_Brand_02 | ngoctx+AT_Brand_02@podfoods.co | Contact Ngoctx_02 | No   | [blank]       | Auto Note |
      | AT Brand Create 02 | AT_Brand_03 | ngoctx+AT_Brand_03@podfoods.co | Contact Ngoctx_03 | No   | [blank]       | Auto Note |
    And Admin remove brand in brand referral detail
      | brand       |
      | AT_Brand_03 |
    And Admin save action in brand referral
    And Admin choose brand, edit and mark as onboarded with vendor company "AT Create Brand vc 01"
      | choose | brand       |
      | Yes    | AT_Brand_01 |
      | Yes    | AT_Brand_02 |
    Then Admin verify result brand referrals after mark as onboarded
      | brand       | email                          | contactName       | working | onboarded | vendorCompany         | note      |
      | AT_Brand_01 | ngoctx+AT_Brand_01@podfoods.co | Contact Ngoctx_01 | No      | yes       | AT Create Brand vc 01 | Auto Note |
      | AT_Brand_02 | ngoctx+AT_Brand_02@podfoods.co | Contact Ngoctx_02 | No      | yes       | AT Create Brand vc 01 | Auto Note |
    And Admin redirect vendor company link in brand referral
      | index | vendorCompany         |
      | 1     | AT Create Brand vc 01 |
      | 2     | AT Create Brand vc 01 |

  @AdminBrand_05 @AdminBrand
  Scenario: Verify field
    Given NGOCTX22 login web admin by api
      | email                | password  |
      | ngoctx22@podfoods.co | 12345678a |
    # Delete brand
    And Change state of Brand id: "3595" to "active"
    # Search brand referral
    And Admin search brand referral by api
      | q[brand_name]      | q[store_id] |
      | AT Brand Create 01 | 3340        |
    And Admin delete brand referral by api

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcreatebrand01chi01@podfoods.co" pass "12345678a" role "Buyer"
    And Buyer go to "Refer a Brand" from menu bar
    And Check Refer Brand Page
    And Buyer enter Refer Brand info
      | brandName          | email              | contact | currentBrand |
      | AT Brand Create 01 | ngoctx@podfoods.co | ngoctx  | true         |
    And Click on button "Invite"
    And BUYER check dialog message
      | Thank you! |
    And BUYER check dialog message
      | Your form has been submitted. Brands will be invited to Pod Foods by email. Our team will also reach out promptly. Have questions? Email |

    Given NGOC_ADMIN_22 open web admin
    When NGOC_ADMIN_22 login to web with role Admin
    And NGOC_ADMIN_22 navigate to "Brands" to "Brand referrals" by sidebar
    # verify search filter brand
    And Admin search brand referral with info
      | brand   | store                  | email   | contact | onboarded | vendorCompany |
      | [blank] | ngoctx stcreateBrand01 | [blank] | [blank] | [blank]   | [blank]       |
    And Admin go to brand referrals details
    Then Admin verify general information of brand referral detail
      | store                  | buyer                       | date        |
      | ngoctx stcreateBrand01 | ngoctx stcreateBrand01chi01 | currentDate |
    And Admin verify brand field of brand referral

  @AdminBrand_06 @AdminBrand
  Scenario: Create brand referrel with headbuyer
    Given NGOCTX22 login web admin by api
      | email                | password  |
      | ngoctx22@podfoods.co | 12345678a |
    # Delete brand
    And Change state of Brand id: "3595" to "active"
    # Search brand referral
    And Admin search brand referral by api
      | q[brand_name]      | q[store_id] |
      | AT Brand Create 01 | 3340        |
    And Admin delete brand referral by api

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer49@podfoods.co" pass "12345678a" role "Buyer"
    And Buyer go to "Refer a Brand" from menu bar
    And Check Refer Brand Page
    And Buyer enter Refer Brand info
      | brandName          | email              | contact | currentBrand |
      | AT Brand Create 01 | ngoctx@podfoods.co | ngoctx  | true         |
    And Click on button "Invite"
    And BUYER check dialog message
      | Thank you! |
    And BUYER check dialog message
      | Your form has been submitted. Brands will be invited to Pod Foods by email. Our team will also reach out promptly. Have questions? Email |

    Given NGOC_ADMIN_22 open web admin
    When NGOC_ADMIN_22 login to web with role Admin
    And NGOC_ADMIN_22 navigate to "Brands" to "Brand referrals" by sidebar
    # verify search filter brand
    And Admin search brand referral with info
      | brand   | store                  | email   | contact | onboarded | vendorCompany |
      | [blank] | ngoctx stcreateBrand01 | [blank] | [blank] | [blank]   | [blank]       |
    And Admin go to brand referrals details
    Then Admin verify general information of brand referral detail
      | store                  | buyer                       | date        |
      | ngoctx stcreateBrand01 | ngoctx stcreateBrand01chi01 | currentDate |
    And Admin verify brand field of brand referral


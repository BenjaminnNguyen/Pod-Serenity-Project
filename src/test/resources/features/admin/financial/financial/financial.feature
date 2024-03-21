@feature=AdminFinancial
Feature: Admin Financial

  @AdminFinancial_01
  Scenario: Verify vendor adjustment type
    Given NGOCTX23 login web admin by api
      | email                | password  |
      | ngoctx23@podfoods.co | 12345678a |
    And Admin search vendor adjustment type "Ngoc Types 01" by api
    And Admin delete vendor adjustment type by api
    And Admin search vendor adjustment type "Ngoc Types Edit 01" by api
    And Admin delete vendor adjustment type by api
    And Admin search vendor adjustment type "Ngoc Types 02" by api
    And Admin delete vendor adjustment type by api
#
    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Vendor adjustment types" by sidebar
    And Admin fill password to authen permission
    And Admin go to create vendor adjustment types
    And Admin verify field name in create vendor adjustment type
    And Admin fill info to create vendor adjustment type is "Ngoc Types 01"
    And Admin create vendor adjustment type success
    And Admin search vendor adjustment type with name "Ngoc Types 01"
    And Admin go to vendor adjustment types "Ngoc Types 01" detail
    And Admin verify vendor adjustment types "Ngoc Types 01" in detail
    And Admin edit vendor adjustment types to "Ngoc Types Edit 01"
    And Admin edit vendor adjustment types success

    And NGOC_ADMIN_23 navigate to "Financial" to "Vendor adjustment types" by sidebar
    And Admin go to create vendor adjustment types
    And Admin fill info to create vendor adjustment type is "Ngoc Types Edit 01"
    And Admin create vendor adjustment type with error "Name has already been taken"
    And Admin fill info to create vendor adjustment type is "Ngoc Types 02"
    And Admin create vendor adjustment type success
    And Admin go to vendor adjustment types "Ngoc Types 02" detail
    And Admin edit vendor adjustment types to "Ngoc Types Edit 01"
    And Admin update vendor adjustment type with error "Name has already been taken"
    And Admin close popup edit adjustment

    And NGOC_ADMIN_23 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin verify adjustment type "Ngoc Types 02" in vendor statement

    And NGOC_ADMIN_23 refresh browser
    And NGOC_ADMIN_23 navigate to "Financial" to "Vendor adjustment types" by sidebar
    And Admin search vendor adjustment type with name "Ngoc Types 02"
    Then Admin delete vendor adjustment type with name "Ngoc Types 02"

  @AdminFinancial_02
  Scenario: Verify store adjustment type
    Given NGOCTX23 login web admin by api
      | email                | password  |
      | ngoctx23@podfoods.co | 12345678a |
    And Admin search store adjustment type "Ngoc Types 01" by api
    And Admin delete store adjustment type by api
    And Admin search store adjustment type "Ngoc Types Edit 01" by api
    And Admin delete store adjustment type by api
    And Admin search store adjustment type "Ngoc Types 02" by api
    And Admin delete store adjustment type by api

    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Store adjustment types" by sidebar
    And Admin fill password to authen permission
    And Admin go to create store adjustment types
    And Admin verify field name in create store adjustment type
    And Admin fill info to create store adjustment type is "Ngoc Types 01"
    And Admin create store adjustment type success
    And Admin search store adjustment type with name "Ngoc Types 01"
    And Admin go to store adjustment types "Ngoc Types 01" detail
    And Admin verify store adjustment types "Ngoc Types 01" in detail
    And Admin edit store adjustment types to "Ngoc Types Edit 01"
    And Admin edit store adjustment types success

    And NGOC_ADMIN_23 navigate to "Financial" to "Store adjustment types" by sidebar
    And Admin go to create store adjustment types
    And Admin fill info to create store adjustment type is "Ngoc Types Edit 01"
    And Admin create store adjustment type with error "Name has already been taken"
    And Admin fill info to create store adjustment type is "Ngoc Types 02"
    And Admin create store adjustment type success
    And Admin go to store adjustment types "Ngoc Types 02" detail
    And Admin edit store adjustment types to "Ngoc Types Edit 01"
    And Admin update store adjustment type with error "Name has already been taken"
    And Admin close popup edit adjustment

    And NGOC_ADMIN_23 navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store               | buyer   | statementMonth | region  | managedBy |
      | [blank]      | ngoc storestatement | [blank] | [blank]        | [blank] | [blank]   |
    And Admin go to detail of store statement "ngoc storestatement"
    And Admin verify adjustment type "Ngoc Types 02" in store statement

    And NGOC_ADMIN_23 refresh browser
    And NGOC_ADMIN_23 navigate to "Financial" to "Store adjustment types" by sidebar
    And Admin search store adjustment type with name "Ngoc Types 02"
    Then Admin delete store adjustment type with name "Ngoc Types 02"

  @AdminFinancial_03
  Scenario: Verify delete vendor adjustment type already used
    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany           | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | AT Vendor Adjustment 01 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "AT Vendor Adjustment 01"
    And Admin add an adjustment in vendor statement
      | value | type         | effectiveDate | description     |
      | 10    | Ngoc Type 03 | currentDate   | Auto Adjustment |

    And NGOC_ADMIN_23 navigate to "Financial" to "Vendor adjustment types" by sidebar
    And Admin search vendor adjustment type with name "Ngoc Type 03"
    Then Admin delete vendor adjustment type with name "Ngoc Type 03" and see message "This adjustment type could not be deleted because it affects some adjustments. You must delete all associated entities before deleting this one."

  @AdminFinancial_04
  Scenario: Verify delete store adjustment type already used
    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store                       | buyer   | statementMonth | region  | managedBy |
      | [blank]      | ngoctx stvendoradjustment01 | [blank] | [blank]        | [blank] | [blank]   |
    And Admin go to detail of store statement "ngoctx stvendoradjustment01"
    And Admin add an adjustment
      | value | type         | subInvoice | deliveryDate | description |
      | 10    | Ngoc Type 03 | [blank]    | [blank]      | [blank]     |

    And NGOC_ADMIN_23 navigate to "Financial" to "Store adjustment types" by sidebar
    And Admin search store adjustment type with name "Ngoc Type 03"
    Then Admin delete store adjustment type with name "Ngoc Type 03" and see message "This adjustment type could not be deleted because it affects some adjustments. You must delete all associated entities before deleting this one."

  @AdminFinancial_05
  Scenario: Verify credit memo types
    Given NGOCTX23 login web admin by api
      | email                | password  |
      | ngoctx23@podfoods.co | 12345678a |
    And Admin search credit memo type "Ngoc Types 01" by api
    And Admin delete credit memo type by api
    # Reset search filter full textbox
    And Admin filter visibility with id "26" by api
      | q[number]           |
      | q[buyer_id]         |
      | q[buyer_company_id] |
      | q[buyer_email]      |
      | q[store_id]         |
      | q[state]            |

    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit memo types" by sidebar
    And Admin fill password to authen permission
    And Admin go to create credit memo types
    And Admin verify field name in create credit memo type
    And Admin fill info to create credit memo type is "Ngoc Types 01"
    And Admin create credit memo type success
    And Admin search credit memo type with name "Ngoc Types 01"
    And Admin go to credit memo types "Ngoc Types 01" detail
    And Admin verify credit memo types "Ngoc Types 01" in detail
    And Admin edit credit memo types to "Ngoc Types Edit 01"
    And Admin edit credit memo types success

    And NGOC_ADMIN_23 refresh browser
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit memos" by sidebar
    When Admin verify credit memo type "Ngoc Types Edit 01" in create credit memo
    # Delete credit memo type

    And NGOC_ADMIN_23 navigate to "Financial" to "Credit memo types" by sidebar
    And Admin search credit memo type with name "Ngoc Types 01"
    And Admin delete credit memo type with name "Ngoc Types 01"

    And NGOC_ADMIN_23 navigate to "Financial" to "Credit memos" by sidebar
       # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | numberCreditMemo | buyer   | buyercompany | store   | buyerEmail | state   |
      | [blank]          | [blank] | [blank]      | [blank] | [blank]    | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | numberCreditMemo | buyer   | buyercompany | store   | buyerEmail | state   |
      | [blank]          | [blank] | [blank]      | [blank] | [blank]    | [blank] |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    When Admin uncheck field of edit visibility in search
      | numberCreditMemo | buyer   | buyercompany | store   | buyerEmail | state   |
      | [blank]          | [blank] | [blank]      | [blank] | [blank]    | [blank] |
    Then Admin verify field search in edit visibility
      | numberCreditMemo | buyer   | buyercompany | store   | buyerEmail | state   |
      | [blank]          | [blank] | [blank]      | [blank] | [blank]    | [blank] |

    # Verify save new filter
    When Admin search credit memo
      | number     | buyerEmail                           | buyer             | store                   | buyerCompany         | state    |
      | 1241231234 | ngoctx+sttestfinancial01@podfoods.co | AT ghostorder01ny | AT Store Ghost Order 01 | ngoc cpn a order sum | Not used |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | numberCreditMemo | buyerEmail                           | buyer             | store                   | buyerCompany         | state    |
      | 1241231234       | ngoctx+sttestfinancial01@podfoods.co | AT ghostorder01ny | AT Store Ghost Order 01 | ngoc cpn a order sum | Not used |
    # Verify save as filter
    When Admin search credit memo
      | number    | buyerEmail                           | buyer                     | store                   | buyerCompany     | state |
      | 124123123 | ngoctx+sttestfinancial02@podfoods.co | ngoctx stadminorder01ny01 | AT Store Ghost Order 02 | ngoc cpn b order | Used  |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | numberCreditMemo | buyerEmail                           | buyer                     | store                   | buyerCompany     | state |
      | 124123123        | ngoctx+sttestfinancial02@podfoods.co | ngoctx stadminorder01ny01 | AT Store Ghost Order 02 | ngoc cpn b order | Used  |

  @AdminFinancial_06
  Scenario: Verify credit memo with Cost covered by : Pod Foods
    Given NGOCTX23 login web admin by api
      | email                | password  |
      | ngoctx23@podfoods.co | 12345678a |
    And Admin search credit memo type "Ngoc Types 02" by api
    And Admin delete credit memo type by api
#
    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit memos" by sidebar
    And Admin fill password to authen permission
    When Admin create credit memo with info
      | buyer                       | orderID | type     | amount | description      | file                 |
      | ngoctx stvendoradjustment01 | [blank] | AutoTest | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    # Add cost covered by
    And Admin choose cost covered in create credit memo
      | value     |
      | Pod Foods |
    # Fill info
    And Admin fill info field cost covered "Pod Foods" in create credit memo
      | amount      |
      | 12345678900 |
    And Admin create credit memo error then see message "1234567890000 is out of range for ActiveModel::Type::Integer with limit 4 bytes"
   # Fill info
    And Admin fill info field cost covered "Pod Foods" in create credit memo
      | amount |
      | 100    |
    # Verify balance
    And Admin verify balance in create credit memo is "$90.00"
    And Admin create credit memo success
    And Admin verify general information of credit memo
      | created     | buyer                       | store                       | order   | description      | type     | expiryDate | status   | amount |
      | currentDate | ngoctx stvendoradjustment01 | ngoctx stvendoradjustment01 | [blank] | Auto Credit Memo | AutoTest | Plus1      | Not used | $10.00 |
    And Admin verify attachment in credit memo detail
      | file                 |
      | CreateCreditMemo.pdf |
    And Admin edit cost covered by pod foods in credit memo detail
      | amount |
      | 200    |
    And Admin edit cost covered by pod foods in credit memo detail
      | amount |
      | 200    |
    And Admin verify balance in create credit memo is "$190.00"

  @AdminFinancial_07
  Scenario: Verify credit memo with Cost covered by : Vendor company
    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit memos" by sidebar
    And Admin fill password to authen permission
    When Admin create credit memo with info
      | buyer                       | orderID | type     | amount | description      | file                 |
      | ngoctx stvendoradjustment01 | [blank] | AutoTest | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    # Add cost covered by
    And Admin choose cost covered in create credit memo
      | value          |
      | Vendor Company |
    And Admin fill info field cost covered "Vendor Company" in create credit memo
      | vendorCompany           | amount      |
      | AT Vendor Adjustment 01 | 12345678900 |
    And Admin verify field cost covered vendor company "AT Vendor Adjustment 01" exists in create credit memo
    And Admin create credit memo error then see message "1234567890000 is out of range for ActiveModel::Type::Integer with limit 4 bytes"
      # Remove cost covered by
    And Admin remove vendor company in cost covered by
      | vendorCompany           |
      | AT Vendor Adjustment 01 |
    # Add cost covered by
    And Admin fill info field cost covered "Vendor Company" in create credit memo
      | vendorCompany                | amount |
      | AT Vendor Adjustment 01      | 100    |
      | AT Vendor Buyer Checkout 12e | 100    |
    # Verify balance
    And Admin verify balance in create credit memo is "$190.00"
    And Admin create credit memo success
    And Admin verify general information of credit memo
      | created     | buyer                       | store                       | order   | description      | type     | expiryDate | status   | amount |
      | currentDate | ngoctx stvendoradjustment01 | ngoctx stvendoradjustment01 | [blank] | Auto Credit Memo | AutoTest | Plus1      | Not used | $10.00 |
    And Admin verify attachment in credit memo detail
      | file                 |
      | CreateCreditMemo.pdf |
    And Admin verify cost covered by in credit memo detail
      | title                        | amount |
      | AT Vendor Adjustment 01      | 100    |
      | AT Vendor Buyer Checkout 12e | 100    |
    And Admin verify balance in create credit memo is "$190.00"
    And Admin remove cost covered by vendor company in credit memo detail
      | vendorCompany                |
      | AT Vendor Adjustment 01      |
      | AT Vendor Buyer Checkout 12e |
        # Add cost covered by in detail
    And Admin fill info field cost covered "Vendor Company" in create credit memo
      | vendorCompany                | amount |
      | AT Vendor Adjustment 01      | 200    |
      | AT Vendor Buyer Checkout 12e | 200    |
    And Admin save action in credit memo detail
    And Admin verify balance in create credit memo is "$390.00"

  @AdminFinancial_08
  Scenario: Verify credit memo with Cost covered by : Logistics Partner
    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit memos" by sidebar
    And Admin fill password to authen permission
    When Admin create credit memo with info
      | buyer                       | orderID | type     | amount | description      | file                 |
      | ngoctx stvendoradjustment01 | [blank] | AutoTest | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    # Add cost covered by
    And Admin choose cost covered in create credit memo
      | value             |
      | Logistics Partner |
    And Admin fill info field cost covered "Logistics Partner" in create credit memo
      | logisticPartner | amount      |
      | ngoc lp1        | 12345678900 |
    And Admin verify field cost covered logistic partner "ngoc lp1" exists in create credit memo
    And Admin create credit memo error then see message "1234567890000 is out of range for ActiveModel::Type::Integer with limit 4 bytes"
      # Remove cost covered by
    And Admin remove vendor company in cost covered by
      | vendorCompany |
      | ngoc lp1      |
    # Add cost covered by
    And Admin fill info field cost covered "Logistics Partner" in create credit memo
      | logisticPartner | amount |
      | ngoc lp1        | 100    |
    # Verify balance
    And Admin verify balance in create credit memo is "$90.00"
    And Admin create credit memo success
    And Admin verify general information of credit memo
      | created     | buyer                       | store                       | order   | description      | type     | expiryDate | status   | amount |
      | currentDate | ngoctx stvendoradjustment01 | ngoctx stvendoradjustment01 | [blank] | Auto Credit Memo | AutoTest | Plus1      | Not used | $10.00 |
    And Admin verify attachment in credit memo detail
      | file                 |
      | CreateCreditMemo.pdf |
    And Admin verify cost covered by in credit memo detail
      | title    | amount |
      | ngoc lp1 | 100    |
    And Admin verify balance in create credit memo is "$90.00"
      # Remove cost covered by
    And Admin remove vendor company in cost covered by
      | vendorCompany |
      | ngoc lp1      |
    # Add cost covered by
    And Admin fill info field cost covered "Logistics Partner" in create credit memo
      | logisticPartner | amount |
      | ngoc lp1        | 100    |
      | ngoctx lp1      | 100    |
    And Admin verify balance in create credit memo is "$190.00"

  @AdminFinancial_09
  Scenario: Verify credit memo with Cost covered by : Logistics Partner + Vendor company + Pod Foods
    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit memos" by sidebar
    And Admin fill password to authen permission
    When Admin create credit memo with info
      | buyer                       | orderID | type     | amount | description      | file                 |
      | ngoctx stvendoradjustment01 | [blank] | AutoTest | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    # Add cost covered by
    And Admin choose cost covered in create credit memo
      | value             |
      | Logistics Partner |
    And Admin fill info field cost covered "Logistics Partner" in create credit memo
      | logisticPartner | amount |
      | ngoc lp1        | 100    |
    # Add cost covered by
    And Admin choose cost covered in create credit memo
      | value          |
      | Vendor Company |
    And Admin fill info field cost covered "Vendor Company" in create credit memo
      | vendorCompany           | amount |
      | AT Vendor Adjustment 01 | 100    |
    # Add cost covered by
    And Admin choose cost covered in create credit memo
      | value     |
      | Pod Foods |
    And Admin fill info field cost covered "Pod Foods" in create credit memo
      | amount |
      | 100    |

    # Verify balance
    And Admin verify balance in create credit memo is "$290.00"
    And Admin create credit memo success
    And Admin verify general information of credit memo
      | created     | buyer                       | store                       | order   | description      | type     | expiryDate | status   | amount |
      | currentDate | ngoctx stvendoradjustment01 | ngoctx stvendoradjustment01 | [blank] | Auto Credit Memo | AutoTest | Plus1      | Not used | $10.00 |
    And Admin verify attachment in credit memo detail
      | file                 |
      | CreateCreditMemo.pdf |
    And Admin verify cost covered by in credit memo detail
      | title                   | amount |
      | AT Vendor Adjustment 01 | 100    |
      | ngoc lp1                | 100    |
      | Podfoods                | 100    |
    And Admin verify balance in create credit memo is "$290.00"

  @AdminFinancial_10
  Scenario: Verify credit memo with Cost covered by : Not Determined
    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit memos" by sidebar
    And Admin fill password to authen permission
    When Admin create credit memo with info
      | buyer                       | orderID | type     | amount | description      | file                 |
      | ngoctx stvendoradjustment01 | [blank] | AutoTest | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    # Add cost covered by
    And Admin choose cost covered in create credit memo
      | value             |
      | Logistics Partner |
    And Admin fill info field cost covered "Logistics Partner" in create credit memo
      | logisticPartner | amount |
      | ngoc lp1        | 100    |
    # Add cost covered by
    And Admin choose cost covered in create credit memo
      | value          |
      | Vendor Company |
    And Admin fill info field cost covered "Vendor Company" in create credit memo
      | vendorCompany           | amount |
      | AT Vendor Adjustment 01 | 100    |
    # Add cost covered by
    And Admin choose cost covered in create credit memo
      | value     |
      | Pod Foods |
    And Admin fill info field cost covered "Pod Foods" in create credit memo
      | amount |
      | 100    |
    And Admin choose cost covered in create credit memo
      | value          |
      | Not Determined |
    And Admin create credit memo success
    And Admin verify general information of credit memo
      | created     | buyer                       | store                       | order   | description      | type     | expiryDate | status   | amount |
      | currentDate | ngoctx stvendoradjustment01 | ngoctx stvendoradjustment01 | [blank] | Auto Credit Memo | AutoTest | Plus1      | Not used | $10.00 |
    And Admin verify attachment in credit memo detail
      | file                 |
      | CreateCreditMemo.pdf |
    And Admin verify cost covered by not display in credit memo detail
      | title                   |
      | AT Vendor Adjustment 01 |
      | ngoc lp1                |
      | Podfoods                |
    And Admin edit general information of credit memo
      | amount | state   | order   | description           |
      | 200    | [blank] | [blank] | Auto Credit Memo Edit |
    And Admin verify general information of credit memo
      | created     | buyer                       | store                       | order   | description           | type     | expiryDate | status   | amount  |
      | currentDate | ngoctx stvendoradjustment01 | ngoctx stvendoradjustment01 | [blank] | Auto Credit Memo Edit | AutoTest | Plus1      | Not used | $200.00 |
    And Admin verify upload another attachment in credit memo detail
    And Admin update another attachment "BOL.pdf" in credit memo detail
    # Verify search by number
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit memos" by sidebar
    When Admin search credit memo
      | number | buyerEmail | buyer   | store   | buyerCompany | state   |
      | 999999 | [blank]    | [blank] | [blank] | [blank]      | [blank] |
    Then Admin no found data in result
    When Admin search credit memo
      | number          | buyerEmail | buyer   | store   | buyerCompany | state   |
      | create by admin | [blank]    | [blank] | [blank] | [blank]      | [blank] |
    And Admin verify credit memo in result
      | number          | store                       | buyer                       | email                                | amount  | state    |
      | create by admin | ngoctx stvendoradjustment01 | ngoctx stvendoradjustment01 | ngoctx+sttestfinancial01@podfoods.co | $200.00 | Not used |
    # Verify search by buyer email
    When Admin search credit memo
      | number  | buyerEmail                            | buyer   | store   | buyerCompany | state   |
      | [blank] | ngoctx1+sttestfinancial01@podfoods.co | [blank] | [blank] | [blank]      | [blank] |
    Then Admin no found data in result
    When Admin search credit memo
      | number  | buyerEmail                           | buyer   | store   | buyerCompany | state   |
      | [blank] | ngoctx+sttestfinancial01@podfoods.co | [blank] | [blank] | [blank]      | [blank] |
    And Admin verify credit memo in result
      | number          | store                       | buyer                       | email                                | amount  | state    |
      | create by admin | ngoctx stvendoradjustment01 | ngoctx stvendoradjustment01 | ngoctx+sttestfinancial01@podfoods.co | $200.00 | Not used |
    # Verify search by buyer
    When Admin search credit memo
      | number  | buyerEmail | buyer                | store   | buyerCompany | state   |
      | [blank] | [blank]    | ngoctx stbclaimchi01 | [blank] | [blank]      | [blank] |
    Then Admin no found data in result
    When Admin search credit memo
      | number  | buyerEmail | buyer                       | store   | buyerCompany | state   |
      | [blank] | [blank]    | ngoctx stvendoradjustment01 | [blank] | [blank]      | [blank] |
    And Admin verify credit memo in result
      | number          | store                       | buyer                       | email                                | amount  | state    |
      | create by admin | ngoctx stvendoradjustment01 | ngoctx stvendoradjustment01 | ngoctx+sttestfinancial01@podfoods.co | $200.00 | Not used |
     # Verify search by store
    When Admin search credit memo
      | number  | buyerEmail | buyer   | store          | buyerCompany | state   |
      | [blank] | [blank]    | [blank] | ngoctx stclaim | [blank]      | [blank] |
    Then Admin no found data in result
    When Admin search credit memo
      | number  | buyerEmail | buyer   | store                       | buyerCompany | state   |
      | [blank] | [blank]    | [blank] | ngoctx stvendoradjustment01 | [blank]      | [blank] |
    And Admin verify credit memo in result
      | number          | store                       | buyer                       | email                                | amount  | state    |
      | create by admin | ngoctx stvendoradjustment01 | ngoctx stvendoradjustment01 | ngoctx+sttestfinancial01@podfoods.co | $200.00 | Not used |
     # Verify search by buyer company
    When Admin search credit memo
      | number  | buyerEmail | buyer   | store   | buyerCompany   | state   |
      | [blank] | [blank]    | [blank] | [blank] | ngoc cpn claim | [blank] |
    Then Admin no found data in result
    When Admin search credit memo
      | number  | buyerEmail | buyer   | store   | buyerCompany | state   |
      | [blank] | [blank]    | [blank] | [blank] | ngoc cpn1    | [blank] |
    And Admin verify credit memo in result
      | number          | store                       | buyer                       | email                                | amount  | state    |
      | create by admin | ngoctx stvendoradjustment01 | ngoctx stvendoradjustment01 | ngoctx+sttestfinancial01@podfoods.co | $200.00 | Not used |
     # Verify search by state
    When Admin search credit memo
      | number          | buyerEmail | buyer   | store   | buyerCompany | state |
      | create by admin | [blank]    | [blank] | [blank] | [blank]      | Used  |
    Then Admin no found data in result
    When Admin search credit memo
      | number          | buyerEmail | buyer   | store   | buyerCompany | state    |
      | create by admin | [blank]    | [blank] | [blank] | [blank]      | Not used |
    And Admin verify credit memo in result
      | number          | store                       | buyer                       | email                                | amount  | state    |
      | create by admin | ngoctx stvendoradjustment01 | ngoctx stvendoradjustment01 | ngoctx+sttestfinancial01@podfoods.co | $200.00 | Not used |
    And Admin go to detail credit memo "create by admin"
    And Admin cancel this credit memo
    # Verify after cancel credit memo
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit memos" by sidebar
    When Admin search credit memo
      | number          | buyerEmail | buyer   | store   | buyerCompany | state   |
      | create by admin | [blank]    | [blank] | [blank] | [blank]      | [blank] |
    And Admin verify credit memo in result
      | number          | store                       | buyer                       | email                                | amount  | state    |
      | create by admin | ngoctx stvendoradjustment01 | ngoctx stvendoradjustment01 | ngoctx+sttestfinancial01@podfoods.co | $200.00 | Canceled |

  @AdminFinancial_11
  Scenario: Verify credit limit and delete buyer company
    Given NGOCTX23 login web admin by api
      | email                | password  |
      | ngoctx23@podfoods.co | 12345678a |
     # Create buyer company by api
    And Admin create buyer company by API
      | name                | ein    | launcher_id | manager_id | website                        | store_type_id |
      | AT Cpn Financial 02 | 01-123 | 90          | [blank]    | https://auto.podfoods.co/login | 2             |
    # Reset search filter full textbox
    And Admin filter visibility with id "27" by api
      | q[id]       |
      | q[diff_str] |

    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit limit" by sidebar
    And Admin fill password to authen permission
    And Admin search buyer company in credit limit
      | buyerCompany        | diff    |
      | AT Cpn Financial 02 | [blank] |
    Then Admin verify credit limit of buyer company in result
      | buyerCompany        | creditLimit | endingBalance | unfulfilledOrder | diff      |
      | AT Cpn Financial 02 | $1,000.00   | $0.00         | $0.00            | $1,000.00 |

    And NGOC_ADMIN_23 navigate to "Buyers" to "Buyer companies" by sidebar
    And Admin search buyer company
      | name                | managedBy | status  | tag     |
      | AT Cpn Financial 02 | [blank]   | [blank] | [blank] |
    Then Admin delete buyer company "AT Cpn Financial 02"

    And NGOC_ADMIN_23 navigate to "Financial" to "Credit limit" by sidebar
    And Admin verify search buyer company "AT Cpn Financial 02" deleted in credit limit

       # Verify uncheck all field search
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit limit" by sidebar
    And Admin uncheck field of edit visibility in search
      | buyercompany | diff    |
      | [blank]      | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | buyercompany | diff    |
      | [blank]      | [blank] |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    When Admin uncheck field of edit visibility in search
      | buyercompany | diff    |
      | [blank]      | [blank] |
    Then Admin verify field search in edit visibility
      | buyercompany | diff    |
      | [blank]      | [blank] |

    # Verify save new filter
    And Admin search buyer company in credit limit
      | buyerCompany        | diff  |
      | AT Cpn Financial 01 | Below |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | id                  | diff  |
      | AT Cpn Financial 01 | Below |
    # Verify save as filter
    And Admin search buyer company in credit limit
      | buyerCompany        | diff  |
      | AT Cpn Financial 01 | Above |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | id                  | diff  |
      | AT Cpn Financial 01 | Above |
    And Admin delete filter preset is "AutoTest1"
    Then Admin verify filter "AutoTest1" is not display

  @AdminFinancial_12
  Scenario: Verify credit limit with order unfulfill
    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit limit" by sidebar
    And Admin fill password to authen permission
    And Admin search buyer company in credit limit
      | buyerCompany        | diff    |
      | AT Cpn Financial 01 | [blank] |
    And Admin get unfulfill orders value of buyer company "AT Cpn Financial 01" in credit limit

    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx23@podfoods.co | 12345678a |
    When Search order by sku "55739" by api
    And Admin delete order of sku "55739" by api
     # Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 119599             | 55739              | 1        | false     | [blank]          |
      | 119600             | 55740              | 1        | false     | [blank]          |
      | 119601             | 55741              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3582     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx23@podfoods.co | 12345678a |
    When Search order by sku "55739" by api
    And Admin delete order of sku "55739" by api
     # Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 119599             | 55739              | 1        | false     | [blank]          |
      | 119600             | 55740              | 1        | false     | [blank]          |
      | 119601             | 55741              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3583     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    And Switch to actor NGOC_ADMIN_23
    And Admin search buyer company in credit limit
      | buyerCompany        | diff    |
      | AT Cpn Financial 01 | [blank] |
    And Admin verify unfulfill orders after order in credit limit
      | buyerCompany        | amountOrder |
      | AT Cpn Financial 01 | 90.0        |

  @AdminFinancial_13
  Scenario: Verify credit limit with buyer pending financial
    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit limit" by sidebar
    And Admin fill password to authen permission
    And Admin search buyer company in credit limit
      | buyerCompany                 | diff    |
      | ngoctx cpn financial pending | [blank] |
    And Admin get unfulfill orders value of buyer company "ngoctx cpn financial pending" in credit limit

    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx23@podfoods.co | 12345678a |
    When Search order by sku "55739" by api
    And Admin delete order of sku "55739" by api
     # Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 119599             | 55739              | 20       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3498     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    And Switch to actor NGOC_ADMIN_23
    And Admin search buyer company in credit limit
      | buyerCompany                 | diff  |
      | ngoctx cpn financial pending | Below |
    And Admin verify unfulfill orders after order in credit limit
      | buyerCompany                 | amountOrder |
      | ngoctx cpn financial pending | 0           |

  @AdminFinancial_14
  Scenario: Verify temporary credit
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx23@podfoods.co | 12345678a |
    When Search order by sku "55739" by api
    And Admin delete order of sku "55739" by api

    Given NGOC_ADMIN_23 open web admin
    When NGOC_ADMIN_23 login to web with role Admin
    And NGOC_ADMIN_23 navigate to "Financial" to "Credit limit" by sidebar
    And Admin fill password to authen permission
    And Admin search buyer company in credit limit
      | buyerCompany        | diff    |
      | AT Cpn Financial 01 | [blank] |
    And Admin get unfulfill orders value of buyer company "AT Cpn Financial 01" in credit limit
    And Admin go to buyer company "AT Cpn Financial 01" credit limit
    And Admin remove temporary credit limit of buyer company
    And Admin update credit limit
    And Admin go to buyer company "AT Cpn Financial 01" credit limit
    And Admin set buyer company credit limit is "2000000000000"
    And Admin update credit limit
    Then Admin see message "Credit limit limit value must less than or equal to 20000000" of credit limit
    And Admin set buyer company credit limit is "1000"
    And Admin go to add temporary credit limit
    And Admin add temporary credit limit of buyer company
      | temporary | startDate   | endDate |
      | 10        | currentDate | Minus1  |
    And Admin update credit limit
    Then Admin see message "Credit limit temps start date must be before or equal to " of credit limit
    And Admin add temporary credit limit of buyer company
      | temporary | startDate | endDate |
      | 10        | Minus2    | Minus1  |
    And Admin update credit limit
    And Admin go to buyer company "AT Cpn Financial 01" credit limit
    And Admin verify temporary credit limit of buyer company
      | temporary | startDate | endDate |
      | 10        | Minus2    | Minus1  |

    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx23@podfoods.co | 12345678a |
    When Search order by sku "55739" by api
    And Admin delete order of sku "55739" by api
     # Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 119599             | 55739              | 2        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3583     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    And Switch to actor NGOC_ADMIN_23
    And NGOC_ADMIN_23 refresh browser
    And Admin search buyer company in credit limit
      | buyerCompany        | diff    |
      | AT Cpn Financial 01 | [blank] |
    And Admin verify unfulfill orders after order in credit limit
      | buyerCompany        | amountOrder |
      | AT Cpn Financial 01 | 50.0        |
    And Admin go to buyer company "AT Cpn Financial 01" credit limit
    And Admin add temporary credit limit of buyer company
      | temporary | startDate | endDate |
      | 10        | Plus1     | Plus2   |
    And Admin update credit limit

    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx23@podfoods.co | 12345678a |
    When Search order by sku "55739" by api
    And Admin delete order of sku "55739" by api
     # Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 119599             | 55739              | 2        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3583     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    And Switch to actor NGOC_ADMIN_23
    And NGOC_ADMIN_23 refresh browser
    And Admin search buyer company in credit limit
      | buyerCompany        | diff    |
      | AT Cpn Financial 01 | [blank] |
    And Admin verify unfulfill orders after order in credit limit
      | buyerCompany        | amountOrder |
      | AT Cpn Financial 01 | 70.0        |
    And Admin go to buyer company "AT Cpn Financial 01" credit limit
    And Admin add temporary credit limit of buyer company
      | temporary | startDate | endDate |
      | 10        | Minus1    | Plus1   |
    And Admin update credit limit

    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx23@podfoods.co | 12345678a |
    When Search order by sku "55739" by api
    And Admin delete order of sku "55739" by api
     # Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 119599             | 55739              | 2        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3583     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    And Switch to actor NGOC_ADMIN_23
    And NGOC_ADMIN_23 refresh browser
    And Admin search buyer company in credit limit
      | buyerCompany        | diff    |
      | AT Cpn Financial 01 | [blank] |
    And Admin verify unfulfill orders after order in credit limit
      | buyerCompany        | amountOrder |
      | AT Cpn Financial 01 | 0           |
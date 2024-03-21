@feature=AdminTags
Feature: Admin Tags

  @AD_TAGS_1
  Scenario:  Create a new tag form
    Given BAO_ADMIN8 open web admin
    When BAO_ADMIN8 login to web with role Admin
    And Admin navigate to "Tags" on sidebar
    And Admin go to create tags
    And Click on button "Create"
    And BAO_ADMIN8 check error message is showing of fields on dialog
      | field           | message                           |
      | Name            | Please select a name for this tag |
      | Support targets | Please select at least one target |
    And Admin create tag with info
      | name | description | visibility |
      | Auto | [blank]     | [blank]    |
    And Admin create tag with support target
      | [blank] |
    And Click on dialog button "Create"
    And BAO_ADMIN8 check error message not showing of fields on dialog
      | field | message                           |
      | Name  | Please select a name for this tag |
    And Admin create tag with info
      | name                  | description      | visibility |
      | Auto Admin create tag | Auto description | Public     |
    And Admin create tag with support target
      | Product |
      | SKU     |
    And Click on dialog button "Create"
    And Admin go to create tags
    And Admin create tag with info
      | name                  | description      | visibility |
      | Auto Admin create tag | Auto description | Private    |
    And Admin create tag with support target
      | Buyer          |
      | Buyer Company  |
      | Store          |
      | Vendor         |
      | Vendor Company |
      | Brand          |
      | Product        |
      | SKU            |
    And Click on dialog button "Create"
    And BAO_ADMIN8 check alert message
      | Name has already been taken |

  @AD_TAGS_2
  Scenario: Tags list
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao8@podfoods.co | 12345678a |
    And Admin search tags by api
      | q[any_text]           |
      | Auto Admin create tag |
    And Admin remove assign tag by api "create by api"
    And Admin delete tag by api
    And Admin create tag by api
      | name                    | description   | permission | tag_target_ids |
      | Auto Admin create tag 1 | description 1 | catalog    | 7,8            |
    And Admin create tag by api
      | name                    | description   | permission | tag_target_ids |
      | Auto Admin create tag 2 | description 2 | admin      | 1,2            |

    Given BAO_ADMIN8 open web admin
    When BAO_ADMIN8 login to web with role Admin
    And Admin navigate to "Tags" on sidebar
    And Admin search tags
      | term                  | target  |
      | Auto Admin create tag | [blank] |
    And Admin check tags list
      | id            | name                    | description   | visibility |
      | create by api | Auto Admin create tag 2 | description 2 | Private    |
      | [blank]       | Auto Admin create tag 1 | description 1 | Public     |

    And Admin search tags
      | term                  | target |
      | Auto Admin create tag | Buyer  |
    And Admin check tags list
      | id            | name                    | description   | visibility |
      | create by api | Auto Admin create tag 2 | description 2 | Private    |
    And Admin search tags
      | term                  | target        |
      | Auto Admin create tag | Buyer Company |
    And Admin check tags list
      | id            | name                    | description   | visibility |
      | create by api | Auto Admin create tag 2 | description 2 | Private    |
    And Admin search tags
      | term                  | target |
      | Auto Admin create tag | Store  |
    And Admin check no data found
    And Admin search tags
      | term                  | target |
      | Auto Admin create tag | Vendor |
    And Admin check no data found
    And Admin search tags
      | term                  | target         |
      | Auto Admin create tag | Vendor Company |
    And Admin check no data found
    And Admin search tags
      | term                  | target |
      | Auto Admin create tag | Brand  |
    And Admin check no data found
    And Admin search tags
      | term                  | target  |
      | Auto Admin create tag | Product |
    And Admin check tags list
      | id      | name                    | description   | visibility |
      | [blank] | Auto Admin create tag 1 | description 1 | Public     |
    And Admin search tags
      | term                  | target |
      | Auto Admin create tag | SKU    |
    And Admin check tags list
      | id      | name                    | description   | visibility |
      | [blank] | Auto Admin create tag 1 | description 1 | Public     |
    And Admin search tags
      | term                  | target      |
      | Auto Admin create tag | Product,SKU |
    And Admin check tags list
      | id      | name                    | description   | visibility |
      | [blank] | Auto Admin create tag 1 | description 1 | Public     |
    And Admin search tags
      | term                  | target              |
      | Auto Admin create tag | Buyer,Buyer Company |
    And Admin check tags list
      | id            | name                    | description   | visibility |
      | create by api | Auto Admin create tag 2 | description 2 | Private    |
    And Admin search tags
      | term                  | target                      |
      | Auto Admin create tag | Buyer,Buyer Company,Product |
    And Admin check tags list
      | id            | name                    | description   | visibility |
      | create by api | Auto Admin create tag 2 | description 2 | Private    |
      | [blank]       | Auto Admin create tag 1 | description 1 | Public     |

  @AD_TAGS_12
  Scenario: Delete tag
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao8@podfoods.co | 12345678a |
    And Admin search tags by api
      | q[any_text]           |
      | Auto Admin create tag |
    And Admin remove assign tag by api "create by api"
    And Admin delete tag by api
    And Admin create tag by api
      | name                    | description   | permission | tag_target_ids |
      | Auto Admin create tag 1 | description 1 | catalog    | 7,8            |
    And Admin create tag by api
      | name                    | description   | permission | tag_target_ids |
      | Auto Admin create tag 2 | description 2 | admin      | 1,2            |

    Given BAO_ADMIN8 open web admin
    When BAO_ADMIN8 login to web with role Admin
    And Admin navigate to "Tags" on sidebar
    And Admin search tags
      | term                  | target  |
      | Auto Admin create tag | [blank] |
    And Admin check tags list
      | id            | name                    | description   | visibility |
      | create by api | Auto Admin create tag 2 | description 2 | Private    |
      | [blank]       | Auto Admin create tag 1 | description 1 | Public     |
    # Check refresh list
    And Admin create tag by api
      | name                    | description   | permission | tag_target_ids |
      | Auto Admin create tag 3 | description 3 | admin      | 3,4            |
    And Admin refresh tags list
    And BAO_ADMIN8 wait 3000 mini seconds
    And Admin check tags list
      | id      | name                    | description   | visibility |
      | [blank] | Auto Admin create tag 3 | description 3 | Private    |
      | [blank] | Auto Admin create tag 2 | description 2 | Private    |
      | [blank] | Auto Admin create tag 1 | description 1 | Public     |
    And Admin delete tag with name "Auto Admin create tag 3"
    And  BAO_ADMIN8 check dialog message
      | This will permanently delete this record. Continue? |
    And Click on dialog button "Cancel"
    And Admin check tags list
      | id      | name                    | description   | visibility |
      | [blank] | Auto Admin create tag 3 | description 3 | Private    |
      | [blank] | Auto Admin create tag 2 | description 2 | Private    |
      | [blank] | Auto Admin create tag 1 | description 1 | Public     |
    And Admin delete tag with name "Auto Admin create tag 3"
    And  BAO_ADMIN8 check dialog message
      | This will permanently delete this record. Continue? |
    And Click on dialog button "Understand & Continue"
    And BAO_ADMIN8 wait 3000 mini seconds
    And Admin check tags list
      | id      | name                    | description   | visibility |
#      | [blank] | Auto Admin create tag 3 | description 3 | Private    |
      | [blank] | Auto Admin create tag 2 | description 2 | Private    |
      | [blank] | Auto Admin create tag 1 | description 1 | Public     |
    And Admin search tags
      | term                    | target  |
      | Auto Admin create tag 3 | [blank] |
    And Admin check no data found

  @AD_TAGS_20
  Scenario: Edit tag
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao8@podfoods.co | 12345678a |
    And Admin search tags by api
      | q[any_text]           |
      | Auto Admin create tag |
    And Admin remove assign tag by api "create by api"
    And Admin delete tag by api
    And Admin create tag by api
      | name                    | description   | permission | tag_target_ids |
      | Auto Admin create tag 2 | description 2 | admin      | 1              |
    And Admin create tag by api
      | name                    | description   | permission | tag_target_ids |
      | Auto Admin create tag 1 | description 1 | admin      | 1              |

    Given BAO_ADMIN8 open web admin
    When BAO_ADMIN8 login to web with role Admin
    And Admin navigate to "Tags" on sidebar
    And Admin search tags
      | term                  | target  |
      | Auto Admin create tag | [blank] |
    And Admin check tags list
      | id            | name                    | description   | visibility |
      | create by api | Auto Admin create tag 1 | description 1 | Private    |
    And Admin open detail of tag and check info
      | name                    | description   | visibility | target |
      | Auto Admin create tag 1 | description 1 | Private    | Buyer  |

    And Admin create tag with info
      | name                           | description          | visibility |
      | Auto Admin create tag 1 edited | description 1 edited | [blank]    |
    And Click on dialog button "Update"
    And BAO_ADMIN8 check alert message
      | Master data updated |
    And Admin check tags list
      | id            | name                           | description          | visibility |
      | create by api | Auto Admin create tag 1 edited | description 1 edited | Private    |
    And Admin open detail of tag and check info
      | name                           | description          | visibility | target |
      | Auto Admin create tag 1 edited | description 1 edited | Private    | Buyer  |
    And Admin create tag with support target
      | Buyer |
    And Admin Clear field "Name"
    And Admin Clear field "Description"
    And Click on dialog button "Update"
    And BAO_ADMIN8 check error message is showing of fields on dialog
      | field           | message                           |
      | Name            | Please select a name for this tag |
      | Support targets | Please select at least one target |
    And Admin create tag with info
      | name                           | description          | visibility |
      | Auto Admin create tag 1 edited | description 1 edited | Public     |
    And Admin create tag with support target
      | Product |
      | SKU     |
    And Click on dialog button "Update"
    And BAO_ADMIN8 check alert message
      | Master data updated |
    And Admin check tags list
      | id            | name                           | description          | visibility |
      | create by api | Auto Admin create tag 1 edited | description 1 edited | Public     |
    And Admin open detail of tag and check info
      | name                    | description   | visibility | target |
      | Auto Admin create tag 2 | description 2 | Private    | Buyer  |
    And Admin create tag with info
      | name                           | description          | visibility |
      | Auto Admin create tag 1 edited | description 1 edited | Public     |
    And Admin create tag with support target
      | Product |
      | SKU     |
    And Click on dialog button "Update"
    And BAO_ADMIN8 check alert message
      | Name has already been taken |

  @AD_TAGS_24
  Scenario: Assign tag
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao8@podfoods.co | 12345678a |
    And Admin search tags by api
      | q[any_text]           |
      | Auto Admin create tag |
    And Admin remove assign tag by api "create by api"
    And Admin delete tag by api
    And Admin search product name "random product tag api" by api
    And Admin delete product name "random product tag api" by api
    And Admin create tag by api
      | name                     | description   | permission | tag_target_ids |
      | Auto Admin create tag242 | description 2 | admin      | 1,2,3,4,5,6    |
    And Admin create tag by api
      | name                     | description   | permission | tag_target_ids |
      | Auto Admin create tag241 | description 1 | catalog    | 7,8            |
    And Create product by api with file "CreateProduct.json" and info
      | name                   | brand_id |
      | random product tag api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random tag api1" of product ""

    Given BAO_ADMIN8 open web admin
    When BAO_ADMIN8 login to web with role Admin
    And Admin navigate to "Tags" on sidebar
    And Admin search tags
      | term                  | target  |
      | Auto Admin create tag | [blank] |
    And Admin check tags list
      | id      | name                     | description   | visibility |
      | [blank] | Auto Admin create tag241 | description 1 | Public     |
      | [blank] | Auto Admin create tag242 | description 2 | Private    |
    And Admin assign tag "Auto Admin create tag242"
      | target         | expiryDate  | value                   |
      | Buyer          | currentDate | Auto Buyer61            |
      | Buyer Company  | currentDate | Auto buyer company test |
      | Store          | Plus1       | Auto store Florida      |
      | Vendor         | currentDate | Auto Vendor 62          |
      | Vendor Company | currentDate | Auto vendor company mov |
      | Brand          | Plus1       | Auto Brand product mov  |
    And Admin close dialog form
    And Admin assign tag "Auto Admin create tag241"
      | target          | expiryDate  | value                  |
      | Product         | currentDate | random product tag api |
      | Product Variant | currentDate | sku random tag api1    |
    And Admin close dialog form
    And Admin assign tag "Auto Admin create tag242"
      | target | expiryDate | value        |
      | Buyer  | [blank]    | Auto Buyer63 |
    And Admin check assign tag of target "Buyer"
      | name         | expiryDate  |
      | Auto Buyer63 | [blank]     |
      | Auto Buyer61 | currentDate |
    And Admin check assign tag of target "Buyer Company"
      | name                    | expiryDate  |
      | Auto buyer company test | currentDate |
    And Admin check assign tag of target "Store"
      | name               | expiryDate |
      | Auto store Florida | Plus1      |
    And Admin check assign tag of target "Vendor"
      | name           | expiryDate  |
      | Auto Vendor 62 | currentDate |
    And Admin check assign tag of target "Vendor Company"
      | name                    | expiryDate  |
      | Auto vendor company mov | currentDate |
    And Admin check assign tag of target "Brand"
      | name                   | expiryDate |
      | Auto Brand product mov | Plus1      |
    And Admin close dialog form
    And Admin assign tag "Auto Admin create tag241"
      | target  | expiryDate | value   |
      | Product | [blank]    | [blank] |
    And Admin check assign tag of target "Product"
      | name                   | expiryDate  |
      | random product tag api | currentDate |
    And Admin check assign tag of target "Product"
      | name                      | expiryDate  |
      | Auto brand create product | currentDate |
    And Admin check assign tag of target "Product Variant"
      | name                | expiryDate  |
      | sku random tag api1 | currentDate |
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter with tags
      | tag                      |
      | Auto Admin create tag241 |
    And Buyer check product on catalog
      | status  | brand                     | product                | sku  |
      | showing | Auto brand create product | random product tag api | 1SKU |
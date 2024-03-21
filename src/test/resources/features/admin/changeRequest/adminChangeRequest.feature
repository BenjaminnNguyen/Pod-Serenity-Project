@feature=AdminChangeRequest
Feature: Buyer Flow

  @AdminChangeRequest_01 @AdminChangeRequest
  Scenario: Verify change request product
#    Given NGOCTX19 login web admin by api
#      | email                | password  |
#      | ngoctx24@podfoods.co | 12345678a |
#    And Admin search product name "AT Product Change Request 01" by api
#    And Admin delete product name "AT Product Change Request 01" by api
#    And Create product by api with file "CreateProduct.json" and info
#      | name                         | brand_id |
#      | AT Product Change Request 01 | 3801     |
#    And Info of Region
#      | region           | id | state  | availability | casePrice | msrp | arrivingDate |
#      | New York Express | 53 | active | in_stock     | 1000      | 1000 | [blank]      |
#    And Admin create a "active" SKU from admin with name "AT SKU Change Request 01" of product ""
#
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+vc2v2@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Products" by sidebar
#    And Vendor go to product detail by name "AT Product Change Request 01"
#    And Vendor "No" go to change request of field "Unit length"
#    And Vendor "Yes" go to change request of field "Unit length"
#    And Vendor check current Request information change of product
#      | field                | value |
#      | Unit length (inches) | 1     |
#      | Unit width (inches)  | 1     |
#      | Unit height (inches) | 1     |
#    And Vendor Request information change of product
#      | unitLength | unitWidth | unitHeight | note |
#      | 2          | 2         | 2          | auto |
#    And Vendor submit Request information change

    Given NGOC_ADMIN_24 open web admin
    When NGOC_ADMIN_24 login to web with role Admin
    And NGOC_ADMIN_24 navigate to "Change requests" to "All requests" by sidebar
    And Admin search change request by info1
      | productName                  | skuName | region  | vendorCompany | vendorBrand | requestFrom | requestTo | applyFrom | applyTo | type    | status  | store   | managedBy |
      | AT Product Change Request 01 | [blank] | [blank] | [blank]       | [blank]     | [blank]     | [blank]   | [blank]   | [blank] | [blank] | [blank] | [blank] | [blank]   |
    And Admin check list change request
      | requestedDate | effectiveDate | vendor       | brand                      | product                      | changesProduct                           | note |
      | currentDate   | Plus90        | ngoctx vc2v2 | AT Brand Change Request 01 | AT Product Change Request 01 | Size (L × W × H)1" x 1" x 1"2" x 2" x 2" | auto |
    And Admin get id change request first result
    And Admin go to detail change request id ""
    And Admin verify info change request detail
      | effectiveDate | sizeL | sizeW | sizeH | historyFrom  | historyTo    |
      | Plus90        | 2     | 2     | 2     | 1" x 1" x 1" | 2" x 2" x 2" |
    And Admin update change request
      | effectiveDate | sizeL | sizeW | sizeH |
      | Plus90        | 0     | 2     | 2     |
    And Admin update change request success
    And Admin verify message error "Unit length must be greater than 0"
    And Admin update change request
      | effectiveDate | sizeL | sizeW | sizeH |
      | Plus90        | 2     | 0     | 2     |
    And Admin update change request success
    And Admin verify message error "Unit weight must be greater than 0"
    And Admin update change request
      | effectiveDate | sizeL | sizeW | sizeH |
      | Plus90        | 2     | 2     | 0     |
    And Admin update change request success
    And Admin verify message error "Unit height must be greater than 0"
    And Admin update change request
      | effectiveDate | sizeL | sizeW | sizeH |
      | currentDate   | 3     | 3     | 3     |
    And Admin update change request success
    And Admin verify message error "Effective date must from"
    And Admin update change request
      | effectiveDate | sizeL | sizeW | sizeH |
      | Plus90        | 3     | 3     | 3     |
    And Admin update change request success
    And Admin check list change request
      | requestedDate | effectiveDate | vendor       | brand                      | product                      | changesProduct                           | note |
      | currentDate   | Plus90        | ngoctx vc2v2 | AT Brand Change Request 01 | AT Product Change Request 01 | Size (L × W × H)1" x 1" x 1"3" x 3" x 3" | auto |
    And Admin delete change request ""
    And Admin search change request by info1
      | productName                  | skuName | region  | vendorCompany | vendorBrand | requestFrom | requestTo | applyFrom | applyTo | type    | status  | store   | managedBy |
      | AT Product Change Request 01 | [blank] | [blank] | [blank]       | [blank]     | [blank]     | [blank]   | [blank]   | [blank] | [blank] | [blank] | [blank] | [blank]   |
    And Admin no found data in result

  @AdminChangeRequest_02 @AdminChangeRequest
  Scenario: Verify change request sku
    Given VENDOR open web user
    When login to beta web with email "ngoctx+vc2v2@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "AT Product Change Request 01"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "AT SKU Change Request 01"

    And Vendor "Yes" go to change request of field "Barcodes Type"
    And Vendor Request information change general info of SKU "sku random"
      | barcodes | unitCase | unit    | case    | note |
      | [blank]  | 2        | [blank] | [blank] | auto |
    And Vendor edit Request information change
    And Vendor check alert message after 60 seconds
      | Product change requested successfully. |

    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Change requests" to "All requests" by sidebar
    And Admin search change request by info1
      | field        | value                         | type  |
      | Product name | Auto vendor create product321 | input |
    And Admin check list change request
      | requestedDate | effectiveDate | vendor        | brand                  | product                       | changesSKU | note |
      | currentDate   | Plus90        | Auto Vendor56 | Auto Brand product mov | Auto vendor create product321 | sku random | auto |
    And Admin check list change request
      | requestedDate | effectiveDate | vendor  | brand   | product | changesSKU   | note    |
      | [blank]       | [blank]       | [blank] | [blank] | [blank] | Case units12 | [blank] |

    And Switch to actor VENDOR
    And Click on button "Cancel Request"
    And Vendor check alert message after 60 seconds
      | Product change request edited successfully. |
    And Vendor check current Request information change of product
      | field         | value        |
      | Barcodes Type | UPC          |
      | Units/case    | 1            |
      | Unit UPC      | 123123123123 |
      | Case UPC      | 123123123123 |
    And Vendor Request information change general info of SKU "sku random"
      | barcodes | unitCase | unit          | case          | note |
      | EAN      | 2        | 1212121212121 | 1212121212121 | auto |
    And Vendor Request information change region info of SKU
      | region              | price |
      | Chicagoland Express | 20    |
    And Vendor submit Request information change
    And Vendor check alert message after 60 seconds
      | Product change requested successfully. |
    And Vendor check after Request information change of product
      | field      | value                        | effective |
      | Units/case | 1 → 2                        | Plus90    |
      | Unit EAN   | 123123123123 → 1212121212121 | Plus90    |
      | Case EAN   | 123123123123 → 1212121212121 | Plus90    |
    And Vendor check after Request information change region of SKU
      | region              | price | effective |
      | Chicagoland Express | 20    | Plus90    |

    And Switch to actor BAO_ADMIN3
    And Admin search change request by info1
      | field        | value                         | type  |
      | Product name | Auto vendor create product321 | input |
    And Admin check list change request
      | requestedDate | effectiveDate | vendor        | brand                  | product                       | changesSKU | note |
      | currentDate   | Plus90        | Auto Vendor56 | Auto Brand product mov | Auto vendor create product321 | sku random | auto |
    And Admin check list change request
      | requestedDate | effectiveDate | vendor  | brand   | product | changesSKU                                                                                                                                 | note    |
      | [blank]       | [blank]       | [blank] | [blank] | [blank] | Unit UPC / EAN1231231231231212121212121Case UPC / EAN1231231231231212121212121UPC / EAN typeUpcEanCase units12Case price (CHI)$10.00$20.00 | [blank] |

    And Switch to actor VENDOR
    And Vendor go back product detail
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    And Vendor "Yes" go to change request of field "Unit UPC"
    And Vendor check after Request information change of product
      | field      | value                        | effective |
      | Units/case | 1 → 2                        | Plus90    |
      | Unit EAN   | 123123123123 → 1212121212121 | Plus90    |
      | Case EAN   | 123123123123 → 1212121212121 | Plus90    |
    And Vendor check after Request information change region of SKU
      | region              | price           | effective |
      | Chicagoland Express | $10.00 → $20.00 | Plus90    |

    And Click on button "Cancel Request"
    And Vendor check alert message after 60 seconds
      | Product change request canceled successfully. |
    And Vendor go back product detail
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    And Vendor "Yes" go to change request of field "Units/case"
    And Vendor Request information change general info of SKU "sku random"
      | barcodes | unitCase | unit         | case         | note    |
      | UPC      | 1        | 123123123123 | 123123123123 | [blank] |
    And Vendor check message is showing of fields when create product
      | field         | message                                              |
      | Barcodes Type | The current value and new value cannot be identical. |
      | Units/case    | The current value and new value cannot be identical. |
      | Unit UPC      | The current value and new value cannot be identical. |
      | Case UPC      | The current value and new value cannot be identical. |
    And Vendor submit Request information change
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field | message                    |
      | Note  | This field cannot be blank |
    And Vendor Request information change general info of SKU "sku random"
      | barcodes | unitCase | unit    | case    | note    |
      | [blank]  | 0        | [blank] | [blank] | [blank] |
    And Vendor check message is showing of fields when create product
      | field      | message                                  |
      | Units/case | Value must be greater than or equal to 1 |
    And Vendor Request information change general info of SKU "sku random"
      | barcodes | unitCase | unit        | case    | note |
      | [blank]  | [blank]  | 12121212121 | [blank] | aut0 |
    And Vendor submit Request information change
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field    | message                     |
      | Unit UPC | UPC must be 12-digit number |

    And Vendor Request information change general info of SKU "sku random"
      | barcodes | unitCase | unit         | case    | note |
      | EAN      | [blank]  | 121212121212 | [blank] | auto |
    And Vendor submit Request information change
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field    | message                     |
      | Unit EAN | EAN must be 13-digit number |
    And Vendor Request information change region info of SKU
      | region              | price |
      | Chicagoland Express | 0     |
    And Vendor submit Request information change
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field               | message                      |
      | Chicagoland Express | Value must be greater than 0 |

    And Switch to actor BAO_ADMIN3
    And Admin search change request by info1
      | field        | value                         | type  |
      | Product name | Auto vendor create product321 | input |
    And Admin check no data found
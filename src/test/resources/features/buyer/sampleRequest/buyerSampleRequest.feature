#mvn clean verify -Dtestsuite="LoginTestSuite" -Dcucumber.options="src/test/resources/features/addtocart" -Denvironments=product
@feature=buyerSampleRequest
Feature:Buyer Sample request

  @B_SAMPLE_REQUESTS_LIST_1 @HeadBuyer_PE
  Scenario: HeadBuyer_PE
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer27@podfoods.co" pass "12345678a" role "buyer"
#    And Search item "auto sku1 check sample request"
    And Search item and go to detail of first result
      | item                           | productName                       | productBrand   | pricePerUnit | pricePerCase | availability |
      | auto sku1 check sample request | Auto product check sample request | Auto Brand Bao | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                            |
      | auto sku1 check sample request |
      | auto sku2 check sample request |
    And Buyer submit sample request
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Check first Sample request in dashboard
      | requested   | number  | store                            | brand          | product                           | fulfillment |
      | currentDate | [blank] | Auto store3 check sample request | Auto Brand Bao | Auto product check sample request | Pending     |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName                        | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer27 | Auto store3 check sample request | ngoctx+autobuyer27@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName      | skuName                        | status | addCart | unitUPC                      | casePrice |
      | Auto Brand Bao | auto sku1 check sample request | Active | [blank] | Unit UPC / EAN: 123456724242 | $10.00    |
      | Auto Brand Bao | auto sku2 check sample request | Active | [blank] | Unit UPC / EAN: 123456724242 | $10.00    |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Sample Requests" to "All sample requests" by sidebar
    And Search sample request by info then system show result
      | number  | store                            | buyer        | vendor  | fulfillment | region |
      | [blank] | Auto store3 check sample request | Auto Buyer27 | [blank] | Pending     | NY     |
    And Admin go to sample detail with number ""
    And Check general information sample detail
      | created     | region           | vendor_company     | buyer_company     | store                            | buyer        | email                          | address                                       | fulfillmentState | fulfillmentDate | comment |
      | currentDate | New York Express | Auto_VendorCompany | Auto_BuyerCompany | Auto store3 check sample request | Auto Buyer27 | ngoctx+autobuyer27@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Pending          | [blank]         | comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | Empty   | Empty          |
    And Check SKUs in sample detail
      | brand          | product                           | variant                        | units        | comments | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto Brand Bao | Auto product check sample request | auto sku1 check sample request | 1 units/case | Empty    | 123456724242 | 123456724242 | $10.00    | $10.00    |
      | Auto Brand Bao | Auto product check sample request | auto sku2 check sample request | 1 units/case | Empty    | 123456724242 | 123456724242 | $10.00    | $10.00    |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor27@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Samples" by sidebar
    And Vendor search sample request on tab "All"
      | region  | store                            | requestFrom | requestTo |
      | [blank] | Auto store3 check sample request | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number  | store                            | brand          | products                          | fulfillment |
      | currentDate | [blank] | Auto store3 check sample request | Auto Brand Bao | Auto product check sample request | Pending     |
    And Vendor search sample request on tab "Fulfilled"
      | region  | store                            | requestFrom | requestTo |
      | [blank] | Auto store3 check sample request | currentDate | [blank]   |
    And Vendor check have no sample found
    And Vendor search sample request on tab "Pending"
      | region  | store                            | requestFrom | requestTo |
      | [blank] | Auto store3 check sample request | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number  | store                            | brand          | products                          | fulfillment |
      | currentDate | [blank] | Auto store3 check sample request | Auto Brand Bao | Auto product check sample request | Pending     |
    And Vendor go to sample detail of number: ""
    And Vendor Check info sample request detail
      | region           | requestDate | fulfillment | buyerName    | storeName                        | emailBuyer                     | address                                       | comment |
      | New York Express | currentDate | Pending     | Auto Buyer27 | Auto store3 check sample request | ngoctx+autobuyer27@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | comment |
    And Vendor Check items in sample request detail of product "Auto product check sample request"
      | brandName      | skuName                        | status | unitUPC                      |
      | Auto Brand Bao | auto sku1 check sample request | Active | Unit UPC / EAN: 123456724242 |
      | Auto Brand Bao | auto sku2 check sample request | Active | Unit UPC / EAN: 123456724242 |
    And Vendor select shipping method of sample
      | shippingMethod            | fulfillmentDate | carrier | trackingNumber |
      | Use my own shipping label | currentDate     | USPS    | 12345678       |
    And Click on button "Confirm Fulfillment Date"
    And VENDOR check alert message
      | Fulfillment date submitted successfully. |
    And Vendor Check info sample request detail
      | region           | requestDate | fulfillment | buyerName    | storeName                        | emailBuyer                     | address                                       | comment |
      | New York Express | currentDate | Fulfilled   | Auto Buyer27 | Auto store3 check sample request | ngoctx+autobuyer27@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | comment |
    And VENDOR Navigate to "Samples" by sidebar
    And Vendor search sample request on tab "All"
      | region  | store                            | requestFrom | requestTo |
      | [blank] | Auto store3 check sample request | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number  | store                            | brand          | products                          | fulfillment |
      | currentDate | [blank] | Auto store3 check sample request | Auto Brand Bao | Auto product check sample request | Fulfilled   |
    And Vendor search sample request on tab "Fulfilled"
      | region  | store                            | requestFrom | requestTo |
      | [blank] | Auto store3 check sample request | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number  | store                            | brand          | products                          | fulfillment |
      | currentDate | [blank] | Auto store3 check sample request | Auto Brand Bao | Auto product check sample request | Fulfilled   |
    And Vendor search sample request on tab "Pending"
      | region  | store                            | requestFrom | requestTo |
      | [blank] | Auto store3 check sample request | currentDate | [blank]   |
    And Vendor check have no sample found
    #Check on buyer after fulfill
    And BUYER Navigate to "Samples" by sidebar
    And Buyer search sample request on tab "All"
      | brand          | requestFrom | requestTo |
      | Auto Brand Bao | currentDate | [blank]   |
    And Buyer check records sample request
      | requested   | number  | store                            | brand          | product                           | fulfillment |
      | currentDate | [blank] | Auto store3 check sample request | Auto Brand Bao | Auto product check sample request | Fulfilled   |
    And Buyer search sample request on tab "Pending"
      | brand          | requestFrom | requestTo |
      | Auto Brand Bao | currentDate | [blank]   |
    And Buyer check have no sample found
    And Buyer search sample request on tab "Canceled"
      | brand          | requestFrom | requestTo |
      | Auto Brand Bao | currentDate | [blank]   |
    And Buyer check have no sample found
    And Buyer search sample request on tab "Fulfilled"
      | brand          | requestFrom | requestTo |
      | Auto Brand Bao | currentDate | [blank]   |
    And Buyer check records sample request
      | requested   | number  | store                            | brand          | product                           | fulfillment |
      | currentDate | [blank] | Auto store3 check sample request | Auto Brand Bao | Auto product check sample request | Fulfilled   |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName                        | emailBuyer                     | address                                       |
      | currentDate | Fulfilled   | Auto Buyer27 | Auto store3 check sample request | ngoctx+autobuyer27@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName      | skuName                        | status | addCart | unitUPC                      | casePrice |
      | Auto Brand Bao | auto sku1 check sample request | Active | [blank] | Unit UPC / EAN: 123456724242 | $10.00    |
      | Auto Brand Bao | auto sku2 check sample request | Active | [blank] | Unit UPC / EAN: 123456724242 | $10.00    |

    #Check on admin after fulfilled
    And ADMIN navigate to "Sample Requests" to "All sample requests" by sidebar
    And Search sample request by info then system show result
      | number  | store                            | buyer        | vendor  | fulfillment | region |
      | [blank] | Auto store3 check sample request | Auto Buyer27 | [blank] | Fulfilled   | NY     |
    And Admin go to sample detail with number ""
    And Check general information sample detail
      | created     | region           | vendor_company     | buyer_company     | store                            | buyer        | email                          | address                                       | fulfillmentState | fulfillmentDate | comment |
      | currentDate | New York Express | Auto_VendorCompany | Auto_BuyerCompany | Auto store3 check sample request | Auto Buyer27 | ngoctx+autobuyer27@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Fulfilled        | currentDate     | comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | USPS    | 12345678       |
    And Check SKUs in sample detail
      | brand          | product                           | variant                        | units        | comments | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto Brand Bao | Auto product check sample request | auto sku1 check sample request | 1 units/case | Empty    | 123456724242 | 123456724242 | $10.00    | $10.00    |
      | Auto Brand Bao | Auto product check sample request | auto sku2 check sample request | 1 units/case | Empty    | 123456724242 | 123456724242 | $10.00    | $10.00    |

  #  Check email to Admin
#    Given ADMIN_EMAIL open login gmail with email "bao@podfoods.co" pass "Baovip99"
#    And ADMIN_EMAIL search email with sender "Pod Foods Co Sample Request details"
#    And QA go to first email with title "Sample Request details"
#    And Verify email sample request
#      | title                                                                                                       | requestNum     | requestDate                | buyer             | managed | details                                                                                  | customInformation                                                                 |
#      | New sample request received!Auto Buyer27 from Auto store3 check sample request placed a new sample request. | Request Number | Pacific Time (US & Canada) | BuyerAuto Buyer27 | [blank] | Auto Brand Baoauto sku1 check sample requestAuto Brand Baoauto sku2 check sample request | Customer InformationShipping address455 Madison Avenue, New York, New York, 10022 |
#
##    Check email of Vendor
#    Given VENDOR_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
#    And VENDOR_EMAIL search email with sender "to:ngoctx+autovendor27@podfoods.co Sample Request details"
#    And QA go to first email with title ""
#    And Verify email sample request
#      | title                                                                                                                     | requestNum | requestDate | buyer   | managed | details                                                                                  | customInformation                                                                                                                                                                                                                                                                                                                                                             |
#      | You’ve received a sample request from Auto store3 check sample request.The store is interested in sampling the following: | [blank]    | [blank]     | [blank] | [blank] | Auto Brand Baoauto sku1 check sample requestAuto Brand Baoauto sku2 check sample request | Please send at least one retail unit (no need to send full cases!), ensuring the buyer is able to sample all requested SKUs.You’ll find sampling best practices in our Brand Guide, page 12.Click the button below to begin fulfillment of this sample request.Confirm Sample RequestIf you’re unable to fulfill this or future sample requests please reply directly to this |

  @B_SAMPLE_REQUESTS_LIST_1_1 @BUYER_SAMPLE_REQUEST_9
  Scenario: Verify the Sample Requests list Normal buyer
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample api" by api
    And Admin delete product name "random product buyer sample api" by api
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                            | brand_id |
      | random product buyer sample api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random product buyer sample" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | 3314      | 3314     | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Pending     |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Pending     |
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found

    And Admin edit sample request id "" by API
      | fulfillment_state | cancelled_reason |
      | fulfilled         | auto             |
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Fulfilled   |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Fulfilled   |

    #Canceled
    And Admin edit sample request id "" by API
      | fulfillment_state | cancelled_reason |
      | canceled          | auto             |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Canceled    |

  #Check record on tab Your store
    And Admin edit sample request id "" by API
      | fulfillment_state |
      | fulfilled         |
    And Buyer go to page "Your Store" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Fulfilled   |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Fulfilled   |
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found

#Canceled
    And Admin edit sample request id "" by API
      | fulfillment_state | cancelled_reason |
      | canceled          | auto             |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Canceled    |

    And Admin edit sample request id "" by API
      | fulfillment_state |
      | pending           |
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Pending     |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Pending     |
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
#Canceled
    And Admin edit sample request id "" by API
      | fulfillment_state | cancelled_reason |
      | canceled          | auto             |
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Canceled    |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Canceled    |

#    Create sample thuộc subbuyer
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | 3365      | 3365     | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |
    And Buyer go to page "Your Request" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer go to page "Your Store" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Pending     |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Pending     |
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found
    And Buyer go to page "Store Buyers" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Pending     |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                         | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample api | Pending     |
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And BUYER check sample number "create by api" not found

  @B_SAMPLE_REQUESTS_LIST_1_2
  Scenario: Verify the Sample Requests list Sub-Buyer
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random sub buyer product sample api" by api
    And Admin delete product name "random sub buyer product sample api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random sub buyer product sample api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random sub buyer product sample" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
  #    Create sample thuộc subbuyer
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | 3365      | 3365     | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Request" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                             | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random sub buyer product sample api | Pending     |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                             | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random sub buyer product sample api | Pending     |
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found

    And Buyer go to page "Your Store" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                             | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random sub buyer product sample api | Pending     |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                             | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random sub buyer product sample api | Pending     |
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found

    And Admin edit sample request id "" by API
      | fulfillment_state |
      | fulfilled         |
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                             | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random sub buyer product sample api | Fulfilled   |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                             | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random sub buyer product sample api | Fulfilled   |
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found

    And Buyer go to page "Your Store" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                             | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random sub buyer product sample api | Fulfilled   |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                             | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random sub buyer product sample api | Fulfilled   |
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found
#    Canceled
    And Admin edit sample request id "" by API
      | fulfillment_state | cancelled_reason |
      | canceled          | auto             |
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                             | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random sub buyer product sample api | Canceled    |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                             | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random sub buyer product sample api | Canceled    |
    And Buyer go to page "Your Request" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                             | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random sub buyer product sample api | Canceled    |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                             | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random sub buyer product sample api | Canceled    |

  @B_SAMPLE_REQUESTS_LIST_1_3
  Scenario: Verify the Sample Requests list Head-Buyer
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product head buyer sample api" by api
    And Admin delete product name "random product head buyer sample api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product head buyer sample api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random head buyer product sample" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
#    And Admin add buyer for sample request by API
#      | buyer_id |
#      | 3365     |
#      | 3314     |
#    Neu multiple buyer thi k can store id, address cung dc
#    And Admin create sample request by API2
#      | product_ids | store_id | vendor_company_id | payment_type | attn | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
#      | [blank]  | 2582     | 1936              | invoice      | [blank]  | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]  | pending           | comment |

    And Admin create sample request for Head Buyer by API
      | head_buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | 108           | [blank]     | [blank]  | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autoheadbuyer1@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "All Requests" sample request
    And Buyer search sample request on tab "All"
      | store   | brand                  | requestFrom | requestTo   |
      | [blank] | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store                  | brand                  | product                              | fulfillment |
      | currentDate | create by api | Auto Buyer Company Bao | Auto Brand product mov | random product head buyer sample api | Pending     |
    And Buyer search sample request on tab "Pending"
      | store   | brand                  | requestFrom | requestTo   |
      | [blank] | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store                  | brand                  | product                              | fulfillment |
      | currentDate | create by api | Auto Buyer Company Bao | Auto Brand product mov | random product head buyer sample api | Pending     |
    And Buyer search sample request on tab "Fulfilled"
      | store   | brand                  | requestFrom | requestTo   |
      | [blank] | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found

    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | brand                  | product                              | fulfillment |
      | currentDate | create by api | Auto Brand product mov | random product head buyer sample api | Pending     |
    And Buyer search sample request on tab "Pending"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | brand                  | product                              | fulfillment |
      | currentDate | create by api | Auto Brand product mov | random product head buyer sample api | Pending     |
    And Buyer search sample request on tab "Fulfilled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found
    And Buyer search sample request on tab "Canceled"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Buyer check sample number "create by api" not found

  @B_SAMPLE_REQUESTS_LIST_2_1 @B_SAMPLE_REQUEST_DETAILS_21_22
  Scenario: Verify the Sample Requests detail page
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 1 api" by api
    And Admin delete product name "random product buyer sample 1 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                              | brand_id |
      | random product buyer sample 1 api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample api 1" of product ""
#    And Admin add SKUs sample request by API
#      | product_variant_id | variants_region_id |
#      | [blank]            | [blank]            |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample api 2" of product ""
#    And Admin add SKUs sample request by API
#      | product_variant_id | variants_region_id |
#      | [blank]            | [blank]            |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample api 3" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id | skuName                           | region_id |
      | [blank]            | [blank]            | sku random buyer sku sample api 1 | 26        |
      | [blank]            | [blank]            | sku random buyer sku sample api 2 | 58        |
      | [blank]            | [blank]            | sku random buyer sku sample api 3 | 63        |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3314     |
    And Admin create sample request by API2
      | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | store   | brand                  | requestFrom | requestTo   |
      | [blank] | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                           | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample 1 api | Pending     |
    And Go to sample request detail with number "create by api"
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check any text "is" showing on screen
      | Hey Pod is now                                                                                                                     |
      | The only full-service wholesale marketplace now available at your fingertips. Download on the App Store and the Google Play Store. |
    And Check items in sample request detail
      | brandName              | skuName                           | status | addCart  | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample api 1 | Active | [blank]  | Unit UPC / EAN: 123123123123 | $10.00    |
      | Auto Brand product mov | sku random buyer sku sample api 2 | Active | [blank]  | Unit UPC / EAN: 123123123123 | $10.00    |
      | Auto Brand product mov | sku random buyer sku sample api 3 | Active | disabled | Unit UPC / EAN: 123123123123 | —         |
    And Check tag Express of sku "sku random buyer sku sample api 1" is "true"

#    Inactive region của sku
    And Admin change info of regions attributes of sku "sku random buyer sku sample api 1" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 26        | [blank]            | 10000            | 10000      | in_stock     | inactive |
#    Check lại sample
    And BUYER click Back to Sample requests
    And Go to sample request detail with number "create by api"
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       | canceledNote |
      | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | [blank]      |
    And Check any text "is" showing on screen
      | Hey Pod is now                                                                                                                     |
      | The only full-service wholesale marketplace now available at your fingertips. Download on the App Store and the Google Play Store. |
    And Check items in sample request detail
      | brandName              | skuName                           | status | addCart  | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample api 1 | Active | disabled | Unit UPC / EAN: 123123123123 | —         |
      | Auto Brand product mov | sku random buyer sku sample api 2 | Active | [blank]  | Unit UPC / EAN: 123123123123 | $10.00    |
      | Auto Brand product mov | sku random buyer sku sample api 3 | Active | disabled | Unit UPC / EAN: 123123123123 | —         |
    And Check tag Express of sku "sku random buyer sku sample api 1" is "false"

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor61@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Samples" by sidebar
    And Vendor search sample request on tab "All"
      | region              | store               | requestFrom | requestTo |
      | Chicagoland Express | Auto Store Chicago1 | currentDate | [blank]   |
    And Vendor go to sample detail of number: "by api"
    And Vendor Cancel sample request
      | reason | note      |
      | Other  | auto note |

    And Switch to actor BUYER
    And BUYER click Back to Sample requests
    And Buyer search sample request on tab "All"
      | store   | brand                  | requestFrom | requestTo   |
      | [blank] | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                           | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample 1 api | Canceled    |
    And Go to sample request detail with number "create by api"
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       | canceledNote |
      | currentDate | Canceled    | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | auto note    |
    And Check items in sample request detail
      | brandName              | skuName                           | status | addCart  | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample api 1 | Active | disabled | Unit UPC / EAN: 123123123123 | —         |
      | Auto Brand product mov | sku random buyer sku sample api 2 | Active | [blank]  | Unit UPC / EAN: 123123123123 | $10.00    |
      | Auto Brand product mov | sku random buyer sku sample api 3 | Active | disabled | Unit UPC / EAN: 123123123123 | —         |
    And Check tag Express of sku "sku random buyer sku sample api 1" is "false"

  @B_SAMPLE_REQUEST_DETAILS_7
  Scenario: Check displayed Shipping Address information on the General tab
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 7 api" by api
    And Admin delete product name "random product buyer sample 7 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                              | brand_id |
      | random product buyer sample 7 api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 7 api" of product ""

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "sku random buyer sku sample 7 api"
    And Search item and go to detail of first result
      | item                              | productName                       | productBrand           | pricePerUnit | pricePerCase | availability |
      | sku random buyer sku sample 7 api | random product buyer sample 7 api | Auto Brand product mov | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                               |
      | sku random buyer sku sample 7 api |
    And Buyer "use" Use default name and store address
      | store               | addressStamp                                  | storePhone |
      | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | 1234567890 |
    And Buyer submit sample request

    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Check first Sample request in dashboard
      | requested   | number  | store               | brand                  | product                           | fulfillment |
      | currentDate | [blank] | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample 7 api | Pending     |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |

    And Search item "sku random buyer sku sample 7 api"
    And Search item and go to detail of first result
      | item                              | productName                       | productBrand           | pricePerUnit | pricePerCase | availability |
      | sku random buyer sku sample 7 api | random product buyer sample 7 api | Auto Brand product mov | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                               |
      | sku random buyer sku sample 7 api |
    And Buyer "not" Use default name and store address
      | name | street             | attn | etc | city     | state    | postalZip | phoneNumber |
      | auto | 456 Madison Avenue | attn | etc | New York | New York | 10022     | 1234678913  |
    And Buyer submit sample request
#Check address after change
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |

    And Check first Sample request in dashboard
      | requested   | number  | store               | brand                  | product                           | fulfillment |
      | currentDate | [blank] | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample 7 api | Pending     |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                                  |
      | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | attn, 456 Madison Avenue, etc, New York, New York, 10022 |

  @B_SAMPLE_REQUESTS_LIST_9
  Scenario: Check displayed Delivery Details information on the General tab
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 1 api" by api
    And Admin delete product name "random product buyer sample 1 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                              | brand_id |
      | random product buyer sample 1 api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample api 1" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3314     |
    And Admin create sample request by API2
      | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |
    And Admin edit sample request id "" by API
      | fulfillment_state | fulfillment_date |
      | fulfilled         | currentDate      |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | store   | brand                  | requestFrom | requestTo   |
      | [blank] | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                           | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample 1 api | Fulfilled   |
    And Go to sample request detail with number "create by api"
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Fulfilled   | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check Delivery detail of sample request
      | fulfillmentDate | carrier | trackingNumber |
      | currentDate     | [blank] | [blank]        |
    And Check items in sample request detail
      | brandName              | skuName                           | status | addCart | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample api 1 | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
#Check co carrier
    And Admin edit sample request id "" by API
      | fulfillment_state | carrier | fulfillment_date |
      | fulfilled         | USPS    | currentDate      |
    And Buyer click Back to Sample requests
    And Go to sample request detail with number "create by api"
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Fulfilled   | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check Delivery detail of sample request
      | fulfillmentDate | carrier | trackingNumber |
      | currentDate     | USPS    | [blank]        |
#check co carrier, tracking number
    And Admin edit sample request id "" by API
      | fulfillment_state | carrier | tracking_number | fulfillment_date |
      | fulfilled         | USPS    | 12              | currentDate      |
    And Buyer click Back to Sample requests
    And Go to sample request detail with number "create by api"
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Fulfilled   | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check Delivery detail of sample request
      | fulfillmentDate | carrier | trackingNumber |
      | currentDate     | USPS    | 12             |

  @B_SAMPLE_REQUESTS_LIST_10
  Scenario: Check displayed Delivery Details information on the General tab
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 10 api" by api
    And Admin delete product name "random product buyer sample 10 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product buyer sample 10 api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample api 10" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3314     |
    And Admin create sample request by API2
      | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | store   | brand                  | requestFrom | requestTo   |
      | [blank] | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                            | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample 10 api | Pending     |
    And Go to sample request detail with number "create by api"
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor61@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Samples" by sidebar
    And Vendor search sample request on tab "All"
      | region  | store               | requestFrom | requestTo |
      | [blank] | Auto Store Chicago1 | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                           | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample 10 api | Pending     |
    And Vendor go to sample detail of number: "by api"
    And Vendor Check info sample request detail
      | region              | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       | comment |
      | Chicagoland Express | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | comment |
    And Vendor select shipping method of sample
      | shippingMethod            | fulfillmentDate | carrier | trackingNumber |
      | Use my own shipping label | currentDate     | USPS    | 12345678       |
    And Click on button "Confirm Fulfillment Date"
    And Vendor check alert message
      | Fulfillment date submitted successfully. |

    And Switch to actor BUYER
    And Buyer click Back to Sample requests
    And Go to sample request detail with number "create by api"
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Fulfilled   | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check Delivery detail of sample request
      | fulfillmentDate | carrier | trackingNumber |
      | currentDate     | USPS    | 12345678       |

  @B_SAMPLE_REQUEST_DETAILS_13
  Scenario:Check displayed information on each PE/PD item line
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 13 api" by api
    And Admin delete product name "random product buyer sample 13 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product buyer sample 13 api | 3087     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 13 api" of product ""
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 13 2 api" of product ""
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 13 3 api" of product ""

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer62@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "sku random buyer sku sample 13 api"
    And Search item and go to detail of first result
      | item                               | productName                        | productBrand           | pricePerUnit | pricePerCase | availability |
      | sku random buyer sku sample 13 api | random product buyer sample 13 api | Auto Brand product mov | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                                |
      | sku random buyer sku sample 13 api |
    And Check any text "not" showing on screen
      | sku random buyer sku sample 13 2 api |
      | sku random buyer sku sample 13 3 api |
    And Buyer "use" Use default name and store address
      | store              | addressStamp                                  | storePhone |
      | Auto store Florida | 455 Madison Avenue, New York, New York, 10022 | 1234567890 |
    And Buyer submit sample request
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Check first Sample request in dashboard
      | requested   | number  | store              | brand                  | product                            | fulfillment |
      | currentDate | [blank] | Auto store Florida | Auto Brand product mov | random product buyer sample 13 api | Pending     |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName              | skuName                            | status | addCart | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample 13 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
    And Hover on id of SKU "sku random buyer sku sample 13 api"

#    PD buyer
    Given BUYER2 open web user
    When login to beta web with email "ngoctx+autobuyer63@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "sku random buyer sku sample 13 api"
    And Search item and go to detail of first result
      | item                                 | productName                        | productBrand           | pricePerUnit | pricePerCase | availability |
      | sku random buyer sku sample 13 3 api | random product buyer sample 13 api | Auto Brand product mov | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                                  |
      | sku random buyer sku sample 13 3 api |
    And Check any text "not" showing on screen
      | sku random buyer sku sample 13 2 api |
      | sku random buyer sku sample 13 api   |
    And Buyer "use" Use default name and store address
      | store          | addressStamp                                   | storePhone |
      | Auto Store PDM | 920 South Harwood Street, Dallas, Texas, 75201 | 1234567890 |
    And Buyer submit sample request
    And BUYER2 Go to Dashboard
    And BUYER2 Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |

    And Check first Sample request in dashboard
      | requested   | number  | store          | brand                  | product                            | fulfillment |
      | currentDate | [blank] | Auto Store PDM | Auto Brand product mov | random product buyer sample 13 api | Pending     |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName      | emailBuyer                     | address                                        |
      | currentDate | Pending     | Auto Buyer63 | Auto Store PDM | ngoctx+autobuyer63@podfoods.co | 920 South Harwood Street, Dallas, Texas, 75201 |
    And Check items in sample request detail
      | brandName              | skuName                              | status | addCart | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample 13 3 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
    And Check tag Express of sku "sku random buyer sku sample 13 3 api" is "false"

  @B_SAMPLE_REQUEST_DETAILS_16
  Scenario: Check the item information is changed or not on the request details when admin/vendor edits them
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 17 api" by api
    And Admin delete product name "random product buyer sample 17 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product buyer sample 17 api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample api 17" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3314     |
    And Admin create sample request by API2
      | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                               | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | random product buyer sample 17 api | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to product detail from just searched
    And Admin edit info of product
      | name                                      | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type    | microDescription |
      | random product buyer sample 17 api edited | [blank]    | [blank]     | [blank]    | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | [blank]  | [blank]      | [blank]       | [blank]    | [blank] | [blank]          |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | store   | brand                  | requestFrom | requestTo   |
      | [blank] | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number        | store               | brand                  | product                                   | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample 17 api edited | Pending     |
    And Go to sample request detail with number "create by api"
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor Check items in sample request detail of product "random product buyer sample 17 api"
      | brandName              | skuName                            | status | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample api 17 | Active | Unit UPC / EAN: 123123123123 | $10.00    |

    And Switch to actor BAO_ADMIN2
    And Admin go to SKU detail "sku random buyer sku sample api 17"
    And Admin edit field general of SKU
      | field    | value                                     |
      | SKU name | sku random buyer sku sample api edited 17 |
    And Click Create
    And Admin verify alert when create product
      | Variant have been saved successfully !! |
    And Go to "Region-specific" tab
    And Admin edit region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 11        | 11       | In stock     | [blank]  |
    And Click Create
    And Admin verify alert when create product
      | Variant have been saved successfully !! |

    And Switch to actor BUYER
    And Buyer click Back to Sample requests
    And Go to sample request detail with number "create by api"
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Buyer Check items in sample request detail of product "random product buyer sample 17 api"
      | brandName              | skuName                            | status | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample api 17 | Active | Unit UPC / EAN: 123123123123 | $11.00    |

  @B_SAMPLE_REQUEST_DETAILS_17
  Scenario: Check display of price/case shown for each SKU
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 17 api" by api
    And Admin delete product name "random product buyer sample 17 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product buyer sample 17 api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Pod Direct Central  | 58 | active | in_stock     | 1100      | 1100 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample api 17" of product ""
#    And Admin add all SKUs just created to sample request by API
#      | product_variant_id | variants_region_id |
#      | [blank]  | [blank]  |
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3314     |
      | 3365     |
    And Admin create sample request by API2
      | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | [blank]     | [blank]  | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |
#  2582
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | store   | brand                  | requestFrom | requestTo   |
      | [blank] | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number                      | store               | brand                  | product                            | fulfillment |
      | currentDate | create by api of buyer 3314 | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample 17 api | Pending     |
    And Go to sample request detail with number "create by api of buyer 3314"
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor Check items in sample request detail of product "random product buyer sample 17 api"
      | brandName              | skuName                            | status | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample api 17 | Active | Unit UPC / EAN: 123123123123 | $10.00    |

    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3365     |
    And Admin create sample request by API2
      | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given BUYER2 open web user
    When login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER2 Go to Dashboard
    And BUYER2 Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | store   | brand                  | requestFrom | requestTo   |
      | [blank] | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number                      | store               | brand                  | product                            | fulfillment |
      | currentDate | create by api of buyer 3365 | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample 17 api | Pending     |
    And Go to sample request detail with number "create by api of buyer 3365"
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer61 | Auto Store Chicago1 | ngoctx+autobuyer61@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor Check items in sample request detail of product "random product buyer sample 17 api"
      | brandName              | skuName                            | status | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample api 17 | Active | Unit UPC / EAN: 123123123123 | —         |

  @B_SAMPLE_REQUEST_DETAILS_18
  Scenario: Check display of price/case shown for each SKU 2
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 18 api" by api
    And Admin delete product name "random product buyer sample 18 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product buyer sample 18 api | 3087     |
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
#      | Pod Direct Central  | 58 | active | in_stock     | 1100      | 1100 |
    And Info of Store specific
      | store_id | store_name          | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
      | 1762     | Auto Store PDM      | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 1100             | 1100       | in_stock     |
#      | 2576     | Auto Store North California | 2216             | Auto_BuyerCompany  | 25        | currentDate | currentDate | 1000             | 1000       | in_stock     |

    And Admin create a "active" SKU from admin with name "sku random buyer sku sample api 18" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3314     |
      | 3365     |
#      | 3391     |
#    3391 is sub-buyer of 3314 , region PDM
#    3365 is sub-buyer of 3314 , region CHI
    And Admin create sample request by API2
      | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | [blank]     | [blank]  | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given BUYER2 open web user
    When login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER2 Go to Dashboard
    And BUYER2 Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | store   | brand                  | requestFrom | requestTo   |
      | [blank] | Auto Brand product mov | currentDate | currentDate |
    And Buyer check records sample request
      | requested   | number                      | store               | brand                  | product                            | fulfillment |
      | currentDate | create by api of buyer 3365 | Auto Store Chicago1 | Auto Brand product mov | random product buyer sample 18 api | Pending     |
    And Go to sample request detail with number "create by api of buyer 3365"
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer61 | Auto Store Chicago1 | ngoctx+autobuyer61@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor Check items in sample request detail of product "random product buyer sample 18 api"
      | brandName              | skuName                            | status | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample api 18 | Active | Unit UPC / EAN: 123123123123 | —         |
#    Authorize sku cho store -> check hiển thị giá
    And Admin Authorized SKU id "" to Store id "2582"
    And Buyer click Back to Sample requests
    And Go to sample request detail with number "create by api of buyer 3365"
    And Vendor Check items in sample request detail of product "random product buyer sample 18 api"
      | brandName              | skuName                            | status | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample api 18 | Active | Unit UPC / EAN: 123123123123 | $10.00    |

  @B_SAMPLE_REQUEST_DETAILS_23 @BUYER_SAMPLE_REQUEST_39
  Scenario: Check the effect on the display of price/case field, SKU state and Add to cart button when Admin changes some things
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 23 api" by api
#    And Admin delete product name "random product buyer sample 23 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product buyer sample 23 api | 3087     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 23 api" of product ""
#    And Admin add SKUs sample request by API
#      | product_variant_id | variants_region_id |
#      | [blank]            | [blank]            |
    And Clear Info of Region api
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 23 2 api" of product ""
#    And Admin add SKUs sample request by API
#      | product_variant_id | variants_region_id |
#      | [blank]            | [blank]            |
    And Clear Info of Region api
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 23 3 api" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id | skuName                              | region_id |
      | [blank]            | [blank]            | sku random buyer sku sample 23 api   | 63        |
      | [blank]            | [blank]            | sku random buyer sku sample 23 2 api | 63        |
      | [blank]            | [blank]            | sku random buyer sku sample 23 3 api | 63        |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | 3387      | 3387     | [blank]     | 2859     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |


    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer62@podfoods.co" pass "12345678a" role "Buyer"
#    And Search item "sku random buyer sku sample 23 api"
#    And Search item and go to detail of first result
#      | item                               | productName                        | productBrand           | pricePerUnit | pricePerCase | availability |
#      | sku random buyer sku sample 23 api | random product buyer sample 23 api | Auto Brand product mov | $10.00       | $10.00       | In Stock     |
#    And Buyer create sample request with info
#      | comment |
#      | comment |
#    And Select Skus to sample
#      | sku                                  |
#      | sku random buyer sku sample 23 api   |
#      | sku random buyer sku sample 23 2 api |
#      | sku random buyer sku sample 23 3 api |
#    And Buyer submit sample request
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName              | skuName                              | status | addCart | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample 23 api   | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
      | Auto Brand product mov | sku random buyer sku sample 23 2 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
      | Auto Brand product mov | sku random buyer sku sample 23 3 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |

#  change availability của sku
    And Admin change info of regions attributes of sku "sku random buyer sku sample 23 2 api" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 63        | [blank]            | 10000            | 10000      | sold_out     | active |

    And Admin change info of regions attributes of sku "sku random buyer sku sample 23 3 api" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 63        | [blank]            | 10000            | 10000      | sold_out     | active |

    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName              | skuName                              | status | addCart  | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample 23 api   | Active | [blank]  | Unit UPC / EAN: 123123123123 | $10.00    |
      | Auto Brand product mov | sku random buyer sku sample 23 2 api | Active | disabled | Unit UPC / EAN: 123123123123 | —         |
      | Auto Brand product mov | sku random buyer sku sample 23 3 api | Active | disabled | Unit UPC / EAN: 123123123123 | —         |

    And Search item "sku random buyer sku sample 23 api"
    And Search item and go to detail of first result
      | item                               | productName                        | productBrand           | pricePerUnit | pricePerCase | availability |
      | sku random buyer sku sample 23 api | random product buyer sample 23 api | Auto Brand product mov | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                                |
      | sku random buyer sku sample 23 api |
    And Check any text "not" showing on screen
      | sku random buyer sku sample 23 2 api |
      | sku random buyer sku sample 23 3 api |
#    And Close popup add cart

  @B_SAMPLE_REQUEST_DETAILS_24
  Scenario: When admin unauthorized a line-item on request details
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 24 api" by api
#    And Admin delete product name "random product buyer sample 23 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product buyer sample 24 api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 24 api" of product ""

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "sku random buyer sku sample 24 api"
    And Search item and go to detail of first result
      | item                               | productName                        | productBrand           | pricePerUnit | pricePerCase | availability |
      | sku random buyer sku sample 24 api | random product buyer sample 24 api | Auto Brand product mov | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                                |
      | sku random buyer sku sample 24 api |

    And Buyer submit sample request
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer61 | Auto Store Chicago1 | ngoctx+autobuyer61@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName              | skuName                            | status | addCart | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample 24 api | Active | [blank] | Unit UPC / EAN: 123123123123 | —         |

  @B_SAMPLE_REQUEST_DETAILS_25
  Scenario: When admin drafts/ inactivates or deletes a line-item on request details
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 25 api" by api
    And Admin delete product name "random product buyer sample 25 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product buyer sample 25 api | 3087     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 25 api" of product ""

    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 25 2 api" of product ""

    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 25 3 api" of product ""
    And Admin Authorized SKU id "" to Store id "2582"
#
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer62@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "sku random buyer sku sample 25 api"
    And Search item and go to detail of first result
      | item                               | productName                        | productBrand           | pricePerUnit | pricePerCase | availability |
      | sku random buyer sku sample 25 api | random product buyer sample 25 api | Auto Brand product mov | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                                  |
      | sku random buyer sku sample 25 api   |
      | sku random buyer sku sample 25 2 api |
    And Buyer submit sample request
#Sub buyer
    Given BUYER2 open web user
    When login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "sku random buyer sku sample 25 3 api"
    And Search item and go to detail of first result
      | item                                 | productName                        | productBrand           | pricePerUnit | pricePerCase | availability |
      | sku random buyer sku sample 25 3 api | random product buyer sample 25 api | Auto Brand product mov | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                                  |
      | sku random buyer sku sample 25 3 api |
    And Buyer submit sample request

    And BUYER2 Go to Dashboard
    And BUYER2 Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer61 | Auto Store Chicago1 | ngoctx+autobuyer61@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName              | skuName                              | status | addCart | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample 25 3 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |

    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName              | skuName                              | status | addCart | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample 25 api   | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
      | Auto Brand product mov | sku random buyer sku sample 25 2 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |

#  change State của sku
    And Admin change info of regions attributes of sku "sku random buyer sku sample 25 2 api" state "inactive"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 63        | [blank]            | 1000             | 1000       | in_stock     | active |
    And Admin change info of regions attributes of sku "sku random buyer sku sample 25 api" state "draft"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 63        | [blank]            | 1000             | 1000       | in_stock     | active |
    And Admin change info of regions attributes of sku "sku random buyer sku sample 25 3 api" state "draft"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | active |
#
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName              | skuName                              | status        | addCart  | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample 25 api   | Not Available | disabled | Unit UPC / EAN: 123123123123 | —         |
      | Auto Brand product mov | sku random buyer sku sample 25 2 api | Not Available | disabled | Unit UPC / EAN: 123123123123 | —         |
    And Click on any text "random product buyer sample 25 api"
    And Buyer check page missing

    And BUYER2 Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer61 | Auto Store Chicago1 | ngoctx+autobuyer61@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName              | skuName                              | status        | addCart  | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample 25 3 api | Not Available | disabled | Unit UPC / EAN: 123123123123 | —         |
    And Click on any text "random product buyer sample 25 api"
    And Buyer check page missing

  @B_SAMPLE_REQUEST_DETAILS_26
  Scenario: When admin inactive product on request details
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 26 api" by api
    And Admin delete product name "random product buyer sample 26 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product buyer sample 26 api | 3087     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 26 api" of product ""
#
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer62@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "sku random buyer sku sample 26 api"
    And Search item and go to detail of first result
      | item                               | productName                        | productBrand           | pricePerUnit | pricePerCase | availability |
      | sku random buyer sku sample 26 api | random product buyer sample 26 api | Auto Brand product mov | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                                |
      | sku random buyer sku sample 26 api |
    And Buyer submit sample request

    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName              | skuName                            | status | addCart | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample 26 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |

#  change State của product
    And Admin change state of product id "random product buyer sample 26 api" to inactive by api

    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                  | requestFrom | requestTo   |
      | Auto Brand product mov | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName              | skuName                            | status        | addCart  | unitUPC                      | casePrice |
      | Auto Brand product mov | sku random buyer sku sample 26 api | Not Available | disabled | Unit UPC / EAN: 123123123123 | —         |
    And Click on any text "random product buyer sample 26 api"
    And Buyer check page missing

  @B_SAMPLE_REQUEST_DETAILS_27
  Scenario: When admin inactive brand on request details !
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 27 api" by api
    And Admin delete product name "random product buyer sample 27 api" by api
#    And Admin search vendor company "Auto vendor company sample request 1" by API
#    And Admin delete vendor company by API
    And Admin search brand name "Auto random Brand sample" by api
    And Admin delete brand by API

    And Admin set region mov for vendor company API
      | region_id | mov_cents |
      | 58        | 0         |
      | 55        | 0         |
#      | 60        | 0         |
#      | 59        | 0         |
      | 54        | 0         |
    And Admin create vendor company by API
      | name                                 | contact_number | show_all_tabs | email                             | limit_type | street1            | street2 | city     | address_state_id | zip   |
      | Auto vendor company sample request 1 | 1212121212     | true          | autovendorcompanyapi1@podfoods.co | mov        | 455 Madison Avenue | ertv    | New York | 33               | 10022 |

    And Admin create brand by API
      | name                     | description       | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand sample | Auto Brand sample | [blank]           | [blank] | 33               | [blank]           |

    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id      |
      | random product buyer sample 27 api | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 26 api" of product ""
#    And Admin add SKUs sample request by API
#      | product_variant_id | variants_region_id |
#      | [blank]  | [blank]  |
#    And Admin add buyer for sample request by API
#      | buyer_id |
#      | 3314     |
#    And Admin create sample request by API2
#      | product_ids | store_id | vendor_company_id | payment_type | attn | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
#      | [blank]  | 2582     | create by api     | invoice      | [blank]  | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]  | pending           | comment |

  @B_SAMPLE_REQUEST_DETAILS_27
  Scenario: When admin inactive brand on request details
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 27 api" by api
    And Admin delete product name "random product buyer sample 27 api" by api
    And Admin change state of brand "3208" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product buyer sample 27 api | 3208     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 27 api" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3387     |
    And Admin create sample request by API2
      | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | [blank]     | 2859     | 1972              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer62@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                   | requestFrom | requestTo   |
      | Auto Bao Brand sample 1 | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName               | skuName                            | status | addCart | unitUPC                      | casePrice |
      | Auto Bao Brand sample 1 | sku random buyer sku sample 27 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
#Deactive brand
    And Admin change state of brand "3208" to "inactive" by API
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
#    K search dc brand do brand inactived
#    And Buyer search sample request on tab "All"
#      | brand                      | requestFrom | requestTo   |
#      | Auto Bao Brand sample 1 | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName               | skuName                            | status        | addCart  | unitUPC                      | casePrice |
      | Auto Bao Brand sample 1 | sku random buyer sku sample 27 api | Not Available | disabled | Unit UPC / EAN: 123123123123 | —         |
    And Admin change state of brand "3208" to "active" by API

  @B_SAMPLE_REQUEST_DETAILS_30
  Scenario: Check display of promotion tag
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 30 api" by api
    And Admin delete product name "random product buyer sample 30 api" by api
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""
    And Admin change state of brand "3208" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product buyer sample 30 api | 3208     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 30 api" of product ""
    And Admin add region by API
      | region          | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | FLorida Express | 63        | random | 2859      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                      | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR sample Promotion | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       |

    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3387     |
    And Admin create sample request by API2
      | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | [blank]     | 2859     | 1972              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer62@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                   | requestFrom | requestTo   |
      | Auto Bao Brand sample 1 | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName               | skuName                            | status | addCart | unitUPC                      | casePrice |
      | Auto Bao Brand sample 1 | sku random buyer sku sample 30 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
    Then Verify promo preview "TPR" of sku "sku random buyer sku sample 30 api" is "show" in sample request page
      | name   | type | price | caseLimit |
      | random | TPR  | $8.00 | 1         |
#    Create them 1 promo
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                              | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Short-dated sample Promotion | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | currentDate   | false   |
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                   | requestFrom | requestTo   |
      | Auto Bao Brand sample 1 | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName               | skuName                            | status | addCart | unitUPC                      | casePrice |
      | Auto Bao Brand sample 1 | sku random buyer sku sample 30 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
    Then Verify promo preview "Short dated" of sku "sku random buyer sku sample 30 api" is "show" in sample request page
      | name   | type        | price | caseLimit | expiryDate  |
      | random | Short-dated | $5.00 | 1         | currentDate |
#    Craete buy-in promo
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""
    And Admin add stack deal of promotion by API
      | typeCharge                          | chargeValue | stack | minQty |
      | PromotionActions::FixRateAdjustment | 1000        | false | 1      |
    And Admin create promotion by api with info
      | type              | name                         | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::BuyIn | Auto buy in sample Promotion | Test API    | currentDate | currentDate | [blank]     | 1000       | 1                | true           | [blank] | default    | [blank]       |
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                   | requestFrom | requestTo   |
      | Auto Bao Brand sample 1 | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName               | skuName                            | status | addCart | unitUPC                      | casePrice |
      | Auto Bao Brand sample 1 | sku random buyer sku sample 30 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
    Then Verify promo preview "Buy in" of sku "sku random buyer sku sample 30 api" is "show" in sample request page
      | name   | type   | price | caseLimit |
      | random | Buy-in | $0.00 | 1         |
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""

  @B_SAMPLE_REQUEST_DETAILS_34
  Scenario: Check the display of promotion tag when usage limit of promotion is used up
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 34 api" by api
    And Admin delete product name "random product buyer sample 34 api" by api
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""
    And Admin change state of brand "3208" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product buyer sample 34 api | 3208     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 34 api" of product ""
    And Admin add region by API
      | region          | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | FLorida Express | 63        | random | 2859      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                      | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR sample Promotion | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | [blank]       |

    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3387     |
    And Admin create sample request by API2
      | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | [blank]     | 2859     | 1972              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer62@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                   | requestFrom | requestTo   |
      | Auto Bao Brand sample 1 | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName               | skuName                            | status | addCart | unitUPC                      | casePrice |
      | Auto Bao Brand sample 1 | sku random buyer sku sample 34 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
    Then Verify promo preview "TPR" of sku "sku random buyer sku sample 34 api" is "show" in sample request page
      | name   | type | price | caseLimit |
      | random | TPR  | $8.00 | 1         |
    And Add to cart sku "sku random buyer sku sample 34 api" from sample request
    And Go to Cart detail
    And Buyer close recommended items modal
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    Then Verify price promo in order buyer is "-$2.00"

    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName               | skuName                            | status | addCart | unitUPC                      | casePrice |
      | Auto Bao Brand sample 1 | sku random buyer sku sample 34 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
#    K show promotion
    Then Verify promo preview "TPR" of sku "sku random buyer sku sample 34 api" is "not show" in sample request page
      | name   | type | price | caseLimit |
      | random | TPR  | $8.00 | 1         |
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""

  @B_SAMPLE_REQUEST_DETAILS_42
  Scenario: Check showing show confirmation short-dated message whenever a buyer adds a SKU with short-dated promotion to cart
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product buyer sample 42 api" by api
    And Admin delete product name "random product buyer sample 42 api" by api
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""
    And Admin change state of brand "3208" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product buyer sample 42 api | 3208     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku sample 42 api" of product ""
    And Admin add region by API
      | region          | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | FLorida Express | 63        | random | 2859      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                              | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Short-dated sample Promotion | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3387     |
    And Admin create sample request by API2
      | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | [blank]     | 2859     | 1972              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer62@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                   | requestFrom | requestTo   |
      | Auto Bao Brand sample 1 | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName               | skuName                            | status | addCart | unitUPC                      | casePrice |
      | Auto Bao Brand sample 1 | sku random buyer sku sample 42 api | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
    Then Verify promo preview "Short dated" of sku "sku random buyer sku sample 42 api" is "show" in sample request page
      | name   | type        | price | caseLimit | expiryDate  |
      | random | Short-dated | $5.00 | 1         | currentDate |
    And Add to cart sku "sku random buyer sku sample 42 api" from sample request
    And Buyer check dialog message
      | This product is not a guaranteed sale and there are no refunds for expiration of this item. |
    And Click on dialog button "Cancel"
    And Add to cart sku "sku random buyer sku sample 42 api" from sample request
    And Buyer check dialog message
      | This product is not a guaranteed sale and there are no refunds for expiration of this item. |
    And Click on dialog button "I understand"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                   | product                            | sku                                | price | quantity | total |
      | Auto Bao Brand sample 1 | random product buyer sample 42 api | sku random buyer sku sample 42 api | $5.00 | 1        | $5.00 |
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""

  @B_MOV_ALERT_1
  Scenario: Check displayed information on the MOV alert
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |

    And Update regions info of SKU "30949"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82920 | 58        | 30949              | 1000             | 1200       | in_stock     | active |
    And Update regions info of SKU "30950"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82921 | 26        | 30950              | 2000             | 2400       | in_stock     | active |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer38@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search item "Auto SKU add to cart mov"
    And Search item and go to detail of first result
      | item                     | productName                  | productBrand               | pricePerUnit | pricePerCase | availability |
      | Auto SKU add to cart mov | Auto product add to cart mov | Auto brand add to cart mov | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                        |
      | Auto SKU add to cart mov   |
      | Auto SKU 2 add to cart mov |
    And Buyer submit sample request
#    And Clear cart to empty in cart before

    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                      | requestFrom | requestTo   |
      | Auto brand add to cart mov | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName                          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer38 | Auto store 2 check add to cart mov | ngoctx+autobuyer38@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName                  | skuName                    | status | addCart | unitUPC                      | casePrice |
      | Auto brand add to cart mov | Auto SKU add to cart mov   | Active | [blank] | Unit UPC / EAN: 121212121212 | $10.00    |
      | Auto brand add to cart mov | Auto SKU 2 add to cart mov | Active | [blank] | Unit UPC / EAN: 121212121212 | $20.00    |
    And Add to cart sku "Auto SKU add to cart mov" from sample request
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Add to cart sku "Auto SKU 2 add to cart mov" from sample request
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Add to cart sku "Auto SKU add to cart mov" from sample request
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Change quantity of skus in MOV alert
      | skuName                  | quantity |
      | Auto SKU add to cart mov | 50       |
    And Check button update cart is "enable" in MOV alert
    And Check notice disappear in MOV alert
    And Click on button "Update cart"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                      | product                      | sku                        | price  | quantity | total   |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU add to cart mov   | $10.00 | 50       | $500.00 |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU 2 add to cart mov | $20.00 | 1        | $20.00  |
    And Buyer remove sku "Auto SKU add to cart mov" in cart detail
    And Buyer remove sku "Auto SKU 2 add to cart mov" in cart detail

  @B_MOQ_ALERT_1
  Scenario: Check displayed information on the MOQ alert PE
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |

    And Update regions info of SKU "31025"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83034 | 58        | 31025              | 1000             | 1200       | in_stock     | active |
    And Update regions info of SKU "31026"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83045 | 26        | 31026              | 2000             | 2400       | in_stock     | active |
    And Admin search promotion by product Name "Auto product add to cart moq"
    And Admin delete promotion by skuName "Auto product add to cart moq"
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer43@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search item "Auto SKU add to cart moq "
    And Search item and go to detail of first result
      | item                     | productName                  | productBrand               | pricePerUnit | pricePerCase | availability |
      | Auto SKU add to cart moq | Auto product add to cart moq | Auto brand add to cart moq | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                        |
      | Auto SKU add to cart moq   |
      | Auto SKU 2 add to cart moq |
    And Buyer submit sample request
#    And Clear cart to empty in cart before

    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                      | requestFrom | requestTo   |
      | Auto brand add to cart moq | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName                          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer43 | Auto store 2 check add to cart moq | ngoctx+autobuyer43@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName                  | skuName                    | status | addCart | unitUPC                      | casePrice |
      | Auto brand add to cart moq | Auto SKU add to cart moq   | Active | [blank] | Unit UPC / EAN: 121212121212 | $10.00    |
      | Auto brand add to cart moq | Auto SKU 2 add to cart moq | Active | [blank] | Unit UPC / EAN: 121212121212 | $20.00    |
    And Add to cart sku "Auto SKU add to cart moq" from sample request
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Add to cart sku "Auto SKU 2 add to cart moq" from sample request
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Close popup add cart
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                      | product                      | sku                        | price  | quantity | total  |
      | Auto brand add to cart moq | Auto product add to cart moq | Auto SKU 2 add to cart moq | $20.00 | 1        | $20.00 |
    And Check MOQ not met in cart detail
      | sku                        | message                                   | counter |
      | Auto SKU 2 add to cart moq | Please order more cases to reach SKU MOQ. | MOQ: 5  |
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Go to sample request detail with number ""
    And Add to cart sku "Auto SKU add to cart moq" from sample request
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |

    And Change quantity of skus in MOQ alert
      | skuName                  | quantity |
      | Auto SKU add to cart moq | 7        |
    And Check button update cart is "enable" in MOQ alert
    And Check notice disappear in MOQ alert
    And Click on button "Update cart"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                      | product                      | sku                        | price  | quantity | total  |
      | Auto brand add to cart moq | Auto product add to cart moq | Auto SKU add to cart moq   | $10.00 | 7        | $70.00 |
      | Auto brand add to cart moq | Auto product add to cart moq | Auto SKU 2 add to cart moq | $20.00 | 1        | $20.00 |
    And Check MOQ not met in cart detail
      | sku                        | message                                   | counter |
      | Auto SKU 2 add to cart moq | Please order more cases to reach SKU MOQ. | MOQ: 5  |

    And Buyer remove sku "Auto SKU add to cart moq" in cart detail
    And Buyer remove sku "Auto SKU 2 add to cart moq" in cart detail

  @B_MOQ_ALERT_2
  Scenario: Check displayed information on the MOQ alert PD
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""
    And Update regions info of SKU "31044"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83070 | 58        | 31044              | 1000             | 1200       | in_stock     | active |
    And Update regions info of SKU "31045"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 91960 | 26        | 31045              | 2000             | 2400       | in_stock     | active |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer40@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search item "Auto SKU 5 add to cart moq"
    And Search item and go to detail of first result
      | item                       | productName                    | productBrand               | pricePerUnit | pricePerCase | availability |
      | Auto SKU 5 add to cart moq | Auto product 3 add to cart moq | Auto brand add to cart moq | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                        |
      | Auto SKU 5 add to cart moq |
    And Buyer submit sample request
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                      | requestFrom | requestTo   |
      | Auto brand add to cart moq | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName                        | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer40 | Auto store check add to cart moq | ngoctx+autobuyer40@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName                  | skuName                    | status | addCart | unitUPC                      | casePrice |
      | Auto brand add to cart moq | Auto SKU 5 add to cart moq | Active | [blank] | Unit UPC / EAN: 121212121212 | $10.00    |
    And Add to cart sku "Auto SKU 5 add to cart moq" from sample request
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart

    And Add to cart sku "Auto SKU 5 add to cart moq" from sample request
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |

    And Change quantity of skus in MOQ alert
      | skuName                    | quantity |
      | Auto SKU 5 add to cart moq | 7        |
    And Check button update cart is "enable" in MOQ alert
    And Check notice disappear in MOQ alert
    And Click on button "Update cart"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                      | product                        | sku                        | price  | quantity | total  |
      | Auto brand add to cart moq | Auto product 3 add to cart moq | Auto SKU 5 add to cart moq | $10.00 | 7        | $70.00 |
    And Buyer remove sku "Auto SKU 5 add to cart moq" in cart detail

  @B_MOQ_ALERT_9
  Scenario: Check display condition of promotion tag shown for each SKU
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""
    And Update regions info of SKU "31044"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83070 | 58        | 31044              | 1000             | 1200       | in_stock     | active |
#    And Update regions info of SKU "31030"
#      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
#      | 83069 | 26        | 31030              | 2000             | 2400       | in_stock     | active |
    And Admin add region by API
      | region             | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | 31044 | 2721      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                      | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR sample Promotion | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer40@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search item "Auto SKU 5 add to cart moq"
    And Search item and go to detail of first result
      | item                       | productName                    | productBrand               | pricePerUnit | pricePerCase | availability |
      | Auto SKU 5 add to cart moq | Auto product 3 add to cart moq | Auto brand add to cart moq | $8.00        | $8.00        | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                        |
      | Auto SKU 5 add to cart moq |
    And Buyer submit sample request
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Buyer search sample request on tab "All"
      | brand                      | requestFrom | requestTo   |
      | Auto brand add to cart moq | currentDate | currentDate |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName                        | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer40 | Auto store check add to cart moq | ngoctx+autobuyer40@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName                  | skuName                    | status | addCart | unitUPC                      | casePrice |
      | Auto brand add to cart moq | Auto SKU 5 add to cart moq | Active | [blank] | Unit UPC / EAN: 121212121212 | $10.00    |
    Then Verify promo preview "TPR" of sku "Auto SKU 5 add to cart moq" is "show" in sample request page
      | name                       | type | price | caseLimit |
      | Auto SKU 5 add to cart moq | TPR  | $8.00 | 1         |

    And Add to cart sku "Auto SKU 5 add to cart moq" from sample request
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    Then Verify promo preview "TPR" of sku "Auto SKU 5 add to cart moq" is "show" on add cart popup
      | name                       | type | price | caseLimit |
      | Auto SKU 5 add to cart moq | TPR  | $8.00 | 1         |
    And Close popup add cart
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""
#    Short-dated promo
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                              | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Short-dated sample Promotion | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Go to sample request detail with number ""
    Then Verify promo preview "Short dated" of sku "Auto SKU 5 add to cart moq" is "show" in sample request page
      | name                       | type        | price | caseLimit | expiryDate  |
      | Auto SKU 5 add to cart moq | Short-dated | $5.00 | 1         | currentDate |
    And Add to cart sku "Auto SKU 5 add to cart moq" from sample request
    And Click on button "I understand"
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    Then Verify promo preview "Short dated" of sku "Auto SKU 5 add to cart moq" is "show" on add cart popup
      | name                       | type        | price | caseLimit | expiryDate  |
      | Auto SKU 5 add to cart moq | Short-dated | $5.00 | 1         | currentDate |
    And Close popup add cart
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""

  @B_MOV_ALERT_11
  Scenario: Check display condition of promotion tag shown for each SKU MOV
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""
    And Update regions info of SKU "30949"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82920 | 58        | 30949              | 1000             | 1200       | in_stock     | active |
    And Update regions info of SKU "30950"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82921 | 26        | 30950              | 2000             | 2400       | in_stock     | active |

    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 30949 | 2709      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                      | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR sample Promotion | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | [blank]       |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer38@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search item and go to detail of first result
      | item                     | productName                  | productBrand               | pricePerUnit | pricePerCase | availability |
      | Auto SKU add to cart mov | Auto product add to cart mov | Auto brand add to cart mov | $8.00        | $8.00        | In Stock     |
    And Buyer create sample request with info
      | comment |
      | comment |
    And Select Skus to sample
      | sku                      |
      | Auto SKU add to cart mov |
    And Buyer submit sample request

    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName                          | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer38 | Auto store 2 check add to cart mov | ngoctx+autobuyer38@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName                  | skuName                  | status | addCart | unitUPC                      | casePrice |
      | Auto brand add to cart mov | Auto SKU add to cart mov | Active | [blank] | Unit UPC / EAN: 121212121212 | $10.00    |
    And Add to cart sku "Auto SKU add to cart mov" from sample request
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $492.00 |
    Then Verify promo preview "TPR" of sku "Auto SKU add to cart mov" is "show" on add cart popup
      | name                     | type | price | caseLimit |
      | Auto SKU add to cart mov | TPR  | $8.00 | 1         |
    And Close popup add cart

#    Short-dated promo
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                              | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Short-dated sample Promotion | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |
    And BUYER Navigate to "Samples" by sidebar
    And Buyer go to page "Your Requests" sample request
    And Go to sample request detail with number ""
    Then Verify promo preview "Short dated" of sku "Auto SKU add to cart mov" is "show" in sample request page
      | name                     | type        | price | caseLimit | expiryDate  |
      | Auto SKU add to cart mov | Short-dated | $5.00 | 1         | currentDate |
    And Add to cart sku "Auto SKU add to cart mov" from sample request
    And Click on dialog button "I understand"
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $495.00 |
    Then Verify promo preview "Short dated" of sku "Auto SKU add to cart mov" is "show" on add cart popup
      | name                     | type        | price | caseLimit | expiryDate  |
      | Auto SKU add to cart mov | Short-dated | $5.00 | 1         | currentDate |
    And Admin search promotion by Promotion Name "sample Promotion"
    And Admin delete promotion by skuName ""
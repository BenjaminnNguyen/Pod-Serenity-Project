#mvn clean verify -Dtestsuite="LoginTestSuite" -Dcucumber.options="src/test/resources/features/addtocart" -Denvironments=product
@feature=vendorSampleRequest
Feature:Vendor Sample request

  @Vendor_Fulfilled_sample_request_successfully_HeadBuyer_PE @V_SAMPLE_REQUESTS_LIST_1 @V_SAMPLE_REQUESTS_LIST_9
  Scenario: Vendor fulfilled a sample request successfully_HeadBuyer_PE
    Given ADMIN login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Update regions info of SKU "30673"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82346 | 53        | 30673              | 1000             | 1200       | in_stock     | active |
    And Update regions info of SKU "30674"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82347 | 53        | 30674              | 1000             | 1200       | in_stock     | active |
#      | 82348 | 60        | 30674              | 1000             | 1200       | in_stock     | inactive |
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
      | currentDate | New York Express | Auto_VendorCompany | Auto_BuyerCompany | Auto store3 check sample request | Auto Buyer27 | ngoctx+autobuyer27@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Pending          | [blank]         | comment |
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
    And Vendor check alert message
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
      | currentDate | New York Express | Auto_VendorCompany | Auto_BuyerCompany | Auto store3 check sample request | Auto Buyer27 | ngoctx+autobuyer27@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Fulfilled        | currentDate     | comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | USPS    | 12345678       |
    And Check SKUs in sample detail
      | brand          | product                           | variant                        | units        | comments | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto Brand Bao | Auto product check sample request | auto sku1 check sample request | 1 units/case | Empty    | 123456724242 | 123456724242 | $10.00    | $10.00    |
      | Auto Brand Bao | Auto product check sample request | auto sku2 check sample request | 1 units/case | Empty    | 123456724242 | 123456724242 | $10.00    | $10.00    |

#  #  Check email to Admin
#    Given ADMIN_EMAIL open login gmail with email "bao@podfoods.co" pass "Baovip99"
#    And ADMIN_EMAIL search email with sender "Pod Foods Co Sample Request details"
#    And QA go to first email with title "Sample Request details"
#    And Verify email sample request
#      | title                                                                                                       | requestNum     | requestDate                | buyer             | managed | details                                                                                  | customInformation                                                                 |
#      | New sample request received!Auto Buyer27 from Auto store3 check sample request placed a new sample request. | Request Number | Pacific Time (US & Canada) | BuyerAuto Buyer27 | [blank]  | Auto Brand Baoauto sku1 check sample requestAuto Brand Baoauto sku2 check sample request | Customer InformationShipping address455 Madison Avenue, New York, New York, 10022 |
#
##    Check email of Vendor
#    Given VENDOR_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
#    And VENDOR_EMAIL search email with sender "to:ngoctx+autovendor27@podfoods.co Sample Request details"
#    And QA go to first email with title ""
#    And Verify email sample request
#      | title                                                                                                                     | requestNum | requestDate | buyer | managed | details                                                                                  | customInformation                                                                                                                                                                                                                                                                                                                                                             |
#      | You’ve received a sample request from Auto store3 check sample request.The store is interested in sampling the following: | [blank]  | [blank]  | [blank]  | [blank]  | Auto Brand Baoauto sku1 check sample requestAuto Brand Baoauto sku2 check sample request | Please send at least one retail unit (no need to send full cases!), ensuring the buyer is able to sample all requested SKUs.You’ll find sampling best practices in our Brand Guide, page 12.Click the button below to begin fulfillment of this sample request.Confirm Sample RequestIf you’re unable to fulfill this or future sample requests please reply directly to this |

  @Vendor_Fulfilled_sample_request_successfully_HeadBuyer_PD
  Scenario: Vendor fulfilled a sample request successfully HeadBuyer_PD
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer25@podfoods.co" pass "12345678a" role "buyer"
#    And Search item "auto sku1 check sample request"
    And Search item and go to detail of first result
      | item                            | productName                       | productBrand   | pricePerUnit | pricePerCase | availability |
      | auto sku 3 check sample request | Auto product check sample request | Auto Brand Bao | $10.00       | $10.00       | In Stock     |
    And Buyer create sample request with info
      | shippingAddress | comment | name         | attn | street                 | apt | city   | state | zip   | phone      |
      | address         | comment | Check sample | attn | 3888 Oak Lawn Ave #100 | apt | Dallas | Texas | 75219 | 1234567890 |

    And Select Skus to sample
      | sku                             |
      | auto sku 3 check sample request |
    And Buyer submit sample request
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Check first Sample request in dashboard
      | requested   | number  | store                              | brand          | product                           | fulfillment |
      | currentDate | [blank] | Auto store check Order PD Print SL | Auto Brand Bao | Auto product check sample request | Pending     |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName                          | emailBuyer                     | address                                                 |
      | currentDate | Pending     | Auto Buyer25 | Auto store check Order PD Print SL | ngoctx+autobuyer25@podfoods.co | attn, 3888 Oak Lawn Ave #100, apt, Dallas, Texas, 75219 |
    And Check items in sample request detail
      | brandName      | skuName                         | status | addCart | unitUPC                      | casePrice |
      | Auto Brand Bao | auto sku 3 check sample request | Active | [blank] | Unit UPC / EAN: 123456724242 | $10.00    |
#      |shippingAddress| comment | name | attn | street | apt | city | state | zip | phone |
#      | [blank]  | comment | name | attn | street | apt | city | state | zip | phone |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Sample Requests" to "All sample requests" by sidebar
    And Search sample request by info then system show result
      | number  | store                              | buyer        | vendor  | fulfillment | region |
      | [blank] | Auto store check Order PD Print SL | Auto Buyer25 | [blank] | Pending     | PDC    |
    And Admin go to sample detail with number ""
    And Check general information sample detail
      | created     | region             | vendor_company     | buyer_company          | store                              | buyer        | email                          | address                                                 | fulfillmentState | fulfillmentDate | comment |
      | currentDate | Pod Direct Central | Auto_VendorCompany | Auto Buyer Company Bao | Auto store check Order PD Print SL | Auto Buyer25 | ngoctx+autobuyer25@podfoods.co | attn, 3888 Oak Lawn Ave #100, apt, Dallas, Texas, 75219 | Pending          | [blank]         | comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | Empty   | Empty          |
    And Check SKUs in sample detail
      | brand          | product                           | variant                         | units        | comments | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto Brand Bao | Auto product check sample request | auto sku 3 check sample request | 1 units/case | Empty    | 123456724242 | 123456724242 | $10.00    | $10.00    |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Samples" by sidebar
    And Vendor search sample request on tab "All"
      | region  | store                              | requestFrom | requestTo |
      | [blank] | Auto store check Order PD Print SL | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number  | store                              | brand          | products                          | fulfillment |
      | currentDate | [blank] | Auto store check Order PD Print SL | Auto Brand Bao | Auto product check sample request | Pending     |
    And Vendor search sample request on tab "Fulfilled"
      | region  | store                              | requestFrom | requestTo |
      | [blank] | Auto store check Order PD Print SL | currentDate | [blank]   |
    And Vendor check have no sample found
    And Vendor search sample request on tab "Pending"
      | region  | store                              | requestFrom | requestTo |
      | [blank] | Auto store check Order PD Print SL | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number  | store                              | brand          | products                          | fulfillment |
      | currentDate | [blank] | Auto store check Order PD Print SL | Auto Brand Bao | Auto product check sample request | Pending     |
    And Vendor go to sample detail of number: ""
    And Vendor Check info sample request detail
      | region             | requestDate | fulfillment | buyerName    | storeName                          | emailBuyer                     | address                                                                | comment |
      | Pod Direct Central | currentDate | Pending     | Auto Buyer25 | Auto store check Order PD Print SL | ngoctx+autobuyer25@podfoods.co | attn, 3888 Oak Lawn Ave #100, apt, Dallas, Texas, 75219, U.S1234567890 | comment |
    And Vendor Check items in sample request detail of product "Auto product check sample request"
      | brandName      | skuName                         | status | unitUPC                      |
      | Auto Brand Bao | auto sku 3 check sample request | Active | Unit UPC / EAN: 123456724242 |
    And Vendor select shipping method of sample
      | shippingMethod            | fulfillmentDate | carrier | trackingNumber |
      | Use my own shipping label | currentDate     | USPS    | 12345678       |
    And Click on button "Confirm Fulfillment Date"
    And Vendor check alert message
      | Fulfillment date submitted successfully. |
    And Vendor Check info sample request detail
      | region             | requestDate | fulfillment | buyerName    | storeName                          | emailBuyer                     | address                                                                | comment |
      | Pod Direct Central | currentDate | Fulfilled   | Auto Buyer25 | Auto store check Order PD Print SL | ngoctx+autobuyer25@podfoods.co | attn, 3888 Oak Lawn Ave #100, apt, Dallas, Texas, 75219, U.S1234567890 | comment |
    And VENDOR Navigate to "Samples" by sidebar
    And Vendor search sample request on tab "All"
      | region  | store                              | requestFrom | requestTo |
      | [blank] | Auto store check Order PD Print SL | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number  | store                              | brand          | products                          | fulfillment |
      | currentDate | [blank] | Auto store check Order PD Print SL | Auto Brand Bao | Auto product check sample request | Fulfilled   |
    And Vendor search sample request on tab "Fulfilled"
      | region  | store                              | requestFrom | requestTo |
      | [blank] | Auto store check Order PD Print SL | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number  | store                              | brand          | products                          | fulfillment |
      | currentDate | [blank] | Auto store check Order PD Print SL | Auto Brand Bao | Auto product check sample request | Fulfilled   |
    And Vendor search sample request on tab "Pending"
      | region  | store                              | requestFrom | requestTo |
      | [blank] | Auto store check Order PD Print SL | currentDate | [blank]   |
    And Vendor check have no sample found

    #Check on buyer after fulfill
    And BUYER Navigate to "Samples" by sidebar
    And Buyer search sample request on tab "All"
      | brand          | requestFrom | requestTo |
      | Auto Brand Bao | currentDate | [blank]   |
    And Buyer check records sample request
      | requested   | number  | store                              | brand          | product                           | fulfillment |
      | currentDate | [blank] | Auto store check Order PD Print SL | Auto Brand Bao | Auto product check sample request | Fulfilled   |
    And Buyer search sample request on tab "Pending"
      | brand          | requestFrom | requestTo |
      | Auto Brand Bao | currentDate | [blank]   |
    And Buyer check have no sample found
    And Buyer search sample request on tab "Fulfilled"
      | brand          | requestFrom | requestTo |
      | Auto Brand Bao | currentDate | [blank]   |
    And Buyer check records sample request
      | requested   | number  | store                              | brand          | product                           | fulfillment |
      | currentDate | [blank] | Auto store check Order PD Print SL | Auto Brand Bao | Auto product check sample request | Fulfilled   |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName                          | emailBuyer                     | address                                                      |
      | currentDate | Fulfilled   | Auto Buyer25 | Auto store check Order PD Print SL | ngoctx+autobuyer25@podfoods.co | attn, 3888 Oak Lawn Ave #100, apt, Dallas, Texas, 75219, U.S |
    And Check items in sample request detail
      | brandName      | skuName                         | status | addCart | unitUPC                      | casePrice |
      | Auto Brand Bao | auto sku 3 check sample request | Active | [blank] | Unit UPC / EAN: 123456724242 | $10.00    |

    #Check on admin after fulfilled
    And ADMIN navigate to "Sample Requests" to "All sample requests" by sidebar
    And Search sample request by info then system show result
      | number  | store                              | buyer        | vendor  | fulfillment | region |
      | [blank] | Auto store check Order PD Print SL | Auto Buyer25 | [blank] | Fulfilled   | PDC    |
    And Admin go to sample detail with number ""
    And Check general information sample detail
      | created     | region             | vendor_company     | buyer_company          | store                              | buyer        | email                          | address                                                 | fulfillmentState | fulfillmentDate | comment |
      | currentDate | Pod Direct Central | Auto_VendorCompany | Auto Buyer Company Bao | Auto store check Order PD Print SL | Auto Buyer25 | ngoctx+autobuyer25@podfoods.co | attn, 3888 Oak Lawn Ave #100, apt, Dallas, Texas, 75219 | Fulfilled        | currentDate     | comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | USPS    | 12345678       |
    And Check SKUs in sample detail
      | brand          | product                           | variant                         | units        | comments | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto Brand Bao | Auto product check sample request | auto sku 3 check sample request | 1 units/case | Empty    | 123456724242 | 123456724242 | $10.00    | $10.00    |

  #  Check email to Admin
#    Given ADMIN_EMAIL open login gmail with email "bao@podfoods.co" pass "Baovip99"
#    And ADMIN_EMAIL search email with sender "Pod Foods Co Sample Request details"
#    And QA go to first email with title "Sample Request details"
#    And Verify email sample request
#      | title                                                                                                         | requestNum     | requestDate                | buyer             | managed | details                                      | customInformation                                                                           |
#      | New sample request received!Auto Buyer25 from Auto store check Order PD Print SL placed a new sample request. | Request Number | Pacific Time (US & Canada) | BuyerAuto Buyer25 | [blank]  | Auto Brand Baoauto sku2 check sample request | Customer InformationShipping addressattn, 3888 Oak Lawn Ave #100, apt, Dallas, Texas, 75219 |
#
##    Check email of Vendor
#    Given VENDOR_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
#    And VENDOR_EMAIL search email with sender "to:ngoctx+autovendor25@podfoods.co Sample Request details"
#    And QA go to first email with title ""
#    And Verify email sample request
#      | title                                                                                                                       | requestNum | requestDate | buyer | managed | details                                      | customInformation                                                                                                                                                                                                                                                                                                                                                             |
#      | You’ve received a sample request from Auto store check Order PD Print SL.The store is interested in sampling the following: | [blank]  | [blank]  | [blank]  | [blank]  | Auto Brand Baoauto sku2 check sample request | Please send at least one retail unit (no need to send full cases!), ensuring the buyer is able to sample all requested SKUs.You’ll find sampling best practices in our Brand Guide, page 12.Click the button below to begin fulfillment of this sample request.Confirm Sample RequestIf you’re unable to fulfill this or future sample requests please reply directly to this |

  @V_SAMPLE_REQUESTS_LIST_1_1
  Scenario: FN_1 - Verify the Sample Requests list
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search product name "random product 1 sample api" by api
    And Admin delete product name "random product 1 sample api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | random product 1 sample api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state |
      | 3314      | 3314     | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor61@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Samples" by sidebar
    And Vendor search sample request on tab "All"
      | region              | store   | requestFrom | requestTo |
      | Chicagoland Express | [blank] | [blank]     | [blank]   |
#      | Florida Express                | [blank] | [blank]     | [blank]   |
#      | Mid Atlantic Express           | [blank] | [blank]     | [blank]   |
#      | New York Express               | [blank] | [blank]     | [blank]   |
#      | North California Express       | [blank] | [blank]     | [blank]   |
#      | South California Express       | [blank] | [blank]     | [blank]   |
#      | Texas Express                  | [blank] | [blank]     | [blank]   |
#      | Pod Direct Midwest             | [blank] | [blank]     | [blank]   |
#      | Pod Direct Northeast           | [blank] | [blank]     | [blank]   |
#      | Pod Direct Southeast           | [blank] | [blank]     | [blank]   |
#      | Pod Direct Southwest & Rockies | [blank] | [blank]     | [blank]   |
#      | Pod Direct West                | [blank] | [blank]     | [blank]   |
    And VENDOR clear filter on field "Region"
#    And Vendor search sample request on tab "All"
#      | region  | store                            | requestFrom | requestTo |
#      | [blank] | Auto Store Chicago1 | [blank]     | [blank]   |
#    And Vendor check have no sample found
#    And VENDOR clear filter on field "Store"
    And VENDOR input invalid "Store"
      | value    |
      | abcdefgh |
    And Vendor search sample request on tab "All"
      | region  | store   | requestFrom | requestTo |
      | [blank] | [blank] | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                    | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product 1 sample api | Pending     |
    And VENDOR clear filter on field "Requested (from)"
    And Vendor search sample request on tab "All"
      | region  | store   | requestFrom | requestTo   |
      | [blank] | [blank] | [blank]     | currentDate |
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                    | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product 1 sample api | Pending     |
    And Vendor search sample request on tab "Pending"
      | region  | store   | requestFrom | requestTo   |
      | [blank] | [blank] | [blank]     | currentDate |
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                    | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product 1 sample api | Pending     |
    And Vendor search sample request on tab "Fulfilled"
      | region  | store   | requestFrom | requestTo |
      | [blank] | [blank] | currentDate | [blank]   |
    And Vendor check sample number "create by api" not found
    And Vendor search sample request on tab "Canceled"
      | region  | store   | requestFrom | requestTo |
      | [blank] | [blank] | currentDate | [blank]   |
    And Vendor check sample number "create by api" not found

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin edit sample request id "" by API
      | fulfillment_state | cancelled_reason |
      | canceled          | auto             |
#    Check trên vendor k hiển thị sample =  canceled
    And Vendor search sample request on tab "All"
      | region              | store   | requestFrom | requestTo | showCanceled |
      | Chicagoland Express | [blank] | currentDate | [blank]   | Yes          |
#    And  Vendor check sample number "create by api" not found
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                    | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product 1 sample api | Canceled    |
    And Vendor search sample request on tab "Pending"
      | region  | store   | requestFrom | requestTo   |
      | [blank] | [blank] | [blank]     | currentDate |
    And Vendor search sample request on tab "Fulfilled"
      | region  | store   | requestFrom | requestTo |
      | [blank] | [blank] | currentDate | [blank]   |
#    And Vendor check sample number "create by api" not found
    And Vendor search sample request on tab "Canceled"
      | region              | store   | requestFrom | requestTo |
      | Chicagoland Express | [blank] | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                    | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product 1 sample api | Canceled    |
    And Admin edit sample request id "" by API
      | fulfillment_state |
      | fulfilled         |
    #    Check trên vendor hiển thị sample =  fulfilled
    And VENDOR clear filter on field "Requested (from)"
    And Vendor search sample request on tab "All"
      | region  | store   | requestFrom | requestTo |
      | [blank] | [blank] | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                    | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product 1 sample api | Fulfilled   |
    And Vendor search sample request on tab "Pending"
      | region  | store   | requestFrom | requestTo   |
      | [blank] | [blank] | [blank]     | currentDate |
    And Vendor check sample number "create by api" not found
    And Vendor search sample request on tab "Fulfilled"
      | region  | store   | requestFrom | requestTo |
      | [blank] | [blank] | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                    | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product 1 sample api | Fulfilled   |

    And Vendor search sample request on tab "All"
      | region  | store   | requestFrom | requestTo |
      | [blank] | [blank] | [blank]     | Minus1    |
#    And Vendor check sample number "create by api" not found
##    And Vendor check records sample request
##      | requested   | number        | store               | brand                  | products                    | fulfillment |
##      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product 1 sample api | Pending     |
    And Vendor search sample request on tab "All"
      | region  | store   | requestFrom | requestTo |
      | [blank] | [blank] | [blank]     | Plus1     |
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                    | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product 1 sample api | Fulfilled   |
    And VENDOR clear filter on field "Requested (to)"
    And Vendor search sample request on tab "All"
      | region  | store   | requestFrom | requestTo |
      | [blank] | [blank] | Plus1       | Minus1    |
    And Vendor check sample number "create by api" not found
    And Admin edit sample request id "" by API
      | fulfillment_state | cancelled_reason |
      | canceled          | auto             |

  @V_SAMPLE_REQUEST_DETAILS_1
  Scenario: FN_2 - Verify the Sample Request details page
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
#    And Admin search sample request by API
#      | field                | value   |
#      | q[brand_id]          | 3087    |
#      | q[region_id]         | 26      |
#      | q[store_id]          | 2582    |
#      | q[fulfillment_state] | pending |
#    And Admin cancel all sample request by API
#    And Admin search sample request by API
#      | field                | value     |
#      | q[brand_id]          | 3087      |
#      | q[region_id]         | 26        |
#      | q[store_id]          | 2582      |
#      | q[fulfillment_state] | fulfilled |
#    And Admin cancel all sample request by API
    And Admin search product name "random product sample api" by api
    And Admin delete product name "random product sample api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | random product sample api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
#    And Admin add SKUs sample request by API
#      | product_variant_id | variants_region_id |
#      | [blank]            | [blank]            |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | coming_soon  | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku 2 random" of product ""
#    And Admin add SKUs sample request by API
#      | product_variant_id | variants_region_id |
#      | [blank]            | [blank]            |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku 3 random" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id | skuName      | region_id |
      | [blank]            | [blank]            | sku random   | 26        |
      | [blank]            | [blank]            | sku 2 random | 63        |
      | [blank]            | [blank]            | sku 3 random | 58        |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | 3314      | 3314     | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor61@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Samples" by sidebar
    And Vendor search sample request on tab "All"
      | region  | store               | requestFrom | requestTo |
      | [blank] | Auto Store Chicago1 | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                  | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product sample api | Pending     |

    And Vendor go to sample detail of number: "by api"
    And Vendor Check info sample request detail
      | region              | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       | comment |
      | Chicagoland Express | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | comment |
    And Vendor Check items in sample request detail of product "random product sample api"
      | brandName              | skuName      | status | unitUPC                      |
      | Auto Brand product mov | sku random   | Active | Unit UPC / EAN: 123123123123 |
      | Auto Brand product mov | sku 2 random | Active | Unit UPC / EAN: 123123123123 |
      | Auto Brand product mov | sku 3 random | Active | Unit UPC / EAN: 123123123123 |
# Inactive sku
    And Change state of SKU id: "sku 2 random" to "inactive"

    And Click on any text "< Back to Sample Requests"
    And Vendor go to sample detail of number: "by api"
    And Vendor Check info sample request detail
      | region              | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       | comment |
      | Chicagoland Express | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | comment |
    And Vendor Check items in sample request detail of product "random product sample api"
      | brandName              | skuName      | status        | unitUPC                      |
      | Auto Brand product mov | sku random   | Active        | Unit UPC / EAN: 123123123123 |
      | Auto Brand product mov | sku 2 random | Not Available | Unit UPC / EAN: 123123123123 |
      | Auto Brand product mov | sku 3 random | Active        | Unit UPC / EAN: 123123123123 |
##Delete sku
#    And Admin delete sku "sku 3 random" in product "" by api
#
#    And Click on any text "< Back to Sample Requests"
#    And Vendor go to sample detail of number: "by api"
#    And Vendor Check info sample request detail
#      | region              | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       | comment |
#      | Chicagoland Express | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | comment |
#    And Vendor Check items in sample request detail of product "random product sample api"
#      | brandName              | skuName      | status        | unitUPC                      |
#      | Auto Brand product mov | sku random   | Active        | Unit UPC / EAN: 123123123123 |
#      | Auto Brand product mov | sku 2 random | Not Available | Unit UPC / EAN: 123123123123 |
#      | Auto Brand product mov | sku 3 random | Not Available | Unit UPC / EAN: 123123123123 |
#    Inactive product
    And Admin change state of product id "random" to inactive by api

    And Click on any text "< Back to Sample Requests"
    And Vendor go to sample detail of number: "by api"
    And Vendor Check info sample request detail
      | region              | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       | comment |
      | Chicagoland Express | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | comment |
    And Vendor Check items in sample request detail of product "random product sample api"
      | brandName              | skuName      | status        | unitUPC                      |
      | Auto Brand product mov | sku random   | Not Available | Unit UPC / EAN: 123123123123 |
      | Auto Brand product mov | sku 2 random | Not Available | Unit UPC / EAN: 123123123123 |
      | Auto Brand product mov | sku 3 random | Not Available | Unit UPC / EAN: 123123123123 |

    And Admin search product name "random product sample api" by api
    And Admin delete product name "random product sample api" by api

  @V_SAMPLE_REQUEST_DETAILS_19
  Scenario: Verify fulfill a sample request using "Use my own shipping label" shipping method
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product sample 19 api" by api
    And Admin delete product name "random product sample 19 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | random product sample 19 api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | 3314      | 3314     | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor61@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Samples" by sidebar

    And Vendor search sample request on tab "All"
      | region  | store               | requestFrom | requestTo |
      | [blank] | Auto Store Chicago1 | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                     | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product sample 19 api | Pending     |
    And Vendor go to sample detail of number: "by api"
    And Vendor Check info sample request detail
      | region              | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       | comment |
      | Chicagoland Express | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | comment |
    And Vendor Check items in sample request detail of product "random product sample 19 api"
      | brandName              | skuName    | status | unitUPC                      |
      | Auto Brand product mov | sku random | Active | Unit UPC / EAN: 123123123123 |

    And Vendor select shipping method of sample
      | shippingMethod            | fulfillmentDate | carrier | trackingNumber |
      | Use my own shipping label | [blank]         | [blank] | [blank]        |
    And Click on button "Confirm Fulfillment Date"
    And Vendor check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor select shipping method of sample
      | shippingMethod            | fulfillmentDate | carrier | trackingNumber |
      | Use my own shipping label | Minus2          | [blank] | [blank]        |
    And Click on button "Confirm Fulfillment Date"
    And Vendor check alert message
      | Fulfillment date must be after or equal to request date |

    And Vendor select shipping method of sample
      | shippingMethod            | fulfillmentDate | carrier | trackingNumber |
      | Use my own shipping label | Plus1           | USPS    | [blank]        |
    And Click on button "Confirm Fulfillment Date"
    And Vendor check alert message
      | Fulfillment date submitted successfully. |
#    And Check any text "is" showing on screen
#      | Expected fulfillment date                                                                    |
#      | If you wish to change it, pick a date from the calendar below & press  Confirm  button below |
    And Check any text "is date" showing on screen
      | Plus1 |
    And Vendor select shipping method of sample
      | shippingMethod            | fulfillmentDate | carrier | trackingNumber |
      | Use my own shipping label | currentDate     | USPS    | 12345678       |
    And Click on button "Confirm Fulfillment Date"
    And Vendor check alert message
      | Fulfillment date submitted successfully. |
    And Vendor Check info sample request detail
      | region              | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       | comment |
      | Chicagoland Express | currentDate | Fulfilled   | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | comment |
    And Vendor check fulfillment detail
      | fulfilledOn | carrier | trackingNumber |
      | currentDate | USPS    | 12345678       |

  @V_SAMPLE_REQUEST_DETAILS_24
  Scenario: Verify information showing on the section when vendor choosing "Buy and Print shipping" shipping method
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product sample 24 api" by api
    And Admin delete product name "random product sample 24 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | random product sample 24 api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | 3314      | 3314     | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor61@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Samples" by sidebar

    And Vendor search sample request on tab "All"
      | region  | store               | requestFrom | requestTo |
      | [blank] | Auto Store Chicago1 | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                     | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product sample 24 api | Pending     |
    And Vendor go to sample detail of number: "by api"
    And Vendor Check info sample request detail
      | region              | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       | comment |
      | Chicagoland Express | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | comment |
    And Vendor Check items in sample request detail of product "random product sample 24 api"
      | brandName              | skuName    | status | unitUPC                      |
      | Auto Brand product mov | sku random | Active | Unit UPC / EAN: 123123123123 |
    And Vendor select shipping method of sample
      | shippingMethod               | width   | height  | length  | weight  | distance | mass    | name    | company | address1 | city    | zipcode | state   | country |
      | Buy and Print shipping label | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] | [blank] | [blank] |
    And Vendor check address to fulfillment detail
      | name                | company | address1           | address2 | city     | zipcode | state    | country |
      | Auto Store Chicago1 | [blank] | 455 Madison Avenue | [blank]  | New York | 10022   | New York | US      |
    And Click on any text "When your address doesn't work"
    And Click on any text "https://tools.usps.com/go/ZipLookupAction_input"
    And Switch to tab by title "ZIP Code™ Lookup | USPS"
    And Verify URL of current site
      | https://tools.usps.com/go/ZipLookupAction_input |
#    And Switch to tab by title "Sample "
    And Switch to default tab
    And Switch to tab by title "Sample #"

    And Vendor select shipping method of sample
      | shippingMethod               | width   | height  | length  | weight  | distance | mass    | name    | company | address1 | city    | zipcode | state   | country |
      | Buy and Print shipping label | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] | [blank] | [blank] |
    And Click on button "Get Rates"
    And Vendor check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check error message is showing of fields
      | field            | message                    |
      | Width            | This field cannot be blank |
      | Height           | This field cannot be blank |
      | Length           | This field cannot be blank |
      | Weight           | This field cannot be blank |
      | Distance Unit    | This field cannot be blank |
      | Mass Unit        | This field cannot be blank |
      | Name             | This field cannot be blank |
      | Address street 1 | This field cannot be blank |
      | City             | This field cannot be blank |
#      | State            | This field cannot be blank |
      | Zipcode          | This field cannot be blank |
      | Country          | This field cannot be blank |

    And Vendor select shipping method of sample
      | shippingMethod               | width | height | length | weight | distance | mass | name     | company | address1              | city    | zipcode | state    | country |
      | Buy and Print shipping label | 0     | 0      | 0      | 0      | cm       | g    | AutoTest | company | 1554 West 18th Street | Chicago | 60608   | Illinois | US      |
    And Click on button "Get Rates"
    And Vendor check alert message
      | Parcels length must be greater than 0 |
    And Vendor select shipping method of sample
      | shippingMethod               | width | height | length | weight | distance | mass | name     | company | address1              | city    | zipcode | state    | country |
      | Buy and Print shipping label | -1    | -1     | -1     | -1     | cm       | g    | AutoTest | company | 1554 West 18th Street | Chicago | 60608   | Illinois | US      |
    And Click on button "Get Rates"
    And Vendor check alert message
      | Parcels length must be greater than 0 |
    And Vendor select shipping method of sample
      | shippingMethod               | width | height | length | weight | distance | mass | name     | company | address1              | city    | zipcode | state    | country | email           |
      | Buy and Print shipping label | 1     | 1      | 1      | 1      | cm       | g    | AutoTest | company | 1554 West 18th Street | Chicago | 0       | Illinois | US      | bao@podfoods.co |
    And Click on button "Get Rates"
    And Vendor check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check error message is showing of fields
      | field   | message                                |
      | Zipcode | Please enter a valid 5-digits zip code |

    And Vendor select shipping method of sample
      | shippingMethod               | width | height | length | weight | distance | mass | name     | company | address1              | city    | zipcode | state    | country | email           |
      | Buy and Print shipping label | 2     | 3      | 4      | 5      | cm       | g    | AutoTest | company | 1554 West 18th Street | Chicago | 60608   | Illinois | US      | bao@podfoods.co |
    And Click on button "Get Rates"
    And Vendor select shippo and then confirm
    And Click on button "Buy"
#    And Vendor check alert message
#      | You can't use this method until a chargeable credit card is set |
#    And Click on button "Back"
#
    And Vendor check information after confirm
      | provider | tracking                    | eta    | status                    | size                       | weight     | line                 | price     |
      | USPS     | #92701901755477000000000011 | ETA: - | Tracking status:  UNKNOWN | Size: 4.00 x 3.00 x 2.00cm | Weight: 5g | 1 line item (1 case) | 23.50 USD |
#
#    And Vendor choose shipping method
#      | shippingMethod               | width | height | length | weight | distance | mass | name     | company | address1              | city    | zipcode | state    | country |
#      | Buy and Print shipping label | 2     | 3      | 4      | 5      | cm       | g    | AutoTest | company | 1554 West 18th Street | Chicago | 60608   | Illinois | US      |
#    And Vendor select shippo and then confirm
#    And Vendor check information after confirm
#      | provider | tracking                    | eta    | status                    | size                       | weight     | line                 | price     |
#      | USPS     | #92701901755477000000000011 | ETA: - | Tracking status:  UNKNOWN | Size: 4.00 x 3.00 x 2.00cm | Weight: 5g | 1 line item (1 case) | 23.50 USD |

#    And Check any text is showing on screen
#      | Expected fulfillment date                                                                    |
#      | If you wish to change it, pick a date from the calendar below & press  Confirm  button below |


  @V_SAMPLE_REQUEST_DETAILS_
  Scenario: Vendor cancel sample request
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "random product sample 24 api" by api
    And Admin delete product name "random product sample 24 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | random product sample 24 api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | 3314      | 3314     | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor61@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Samples" by sidebar
    And Vendor search sample request on tab "All"
      | region              | store               | requestFrom | requestTo |
      | Chicagoland Express | Auto Store Chicago1 | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                     | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product sample 24 api | Pending     |
    And Vendor go to sample detail of number: "by api"
    And Vendor Cancel sample request
      | reason | note      |
      | Other  | auto note |

    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "All sample requests" by sidebar
    And Admin search sample request
      | number  | store               | buyer        | vendorCompany | buyerCompany | brand                  | fulfillment | region  | managedBy | startDate   | endDate |
      | [blank] | Auto Store Chicago1 | Auto Buyer59 | [blank]       | [blank]      | Auto Brand product mov | [blank]     | [blank] | [blank]   | currentDate | [blank] |
    And Admin go to sample detail with number "create by api"
    And Check general information sample detail
      | created     | region              | store               | vendor_company          | buyer_company     | buyer        | email                          | address                                       | fulfillmentState | fulfillmentDate | comment | canceledReason | cancelationNote |
      | currentDate | Chicagoland Express | Auto Store Chicago1 | Auto vendor company mov | Auto_BuyerCompany | Auto Buyer59 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Canceled         | [blank]         | comment | Other          | auto note       |

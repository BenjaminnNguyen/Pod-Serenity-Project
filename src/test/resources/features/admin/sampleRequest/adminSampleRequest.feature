@feature=AdminSampleRequest
Feature: AdminSampleRequest

  @CREATE_SAMPLE_REQUESTS_181
  Scenario: Create new Sample Requests for head buyers
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto product create sample 1" by api
    And Admin search product name "auto product create sample 1" by api
    And Admin delete product name "auto product create sample 1" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""
    And Admin create a "active" SKU from admin with name "auto sku create sample 2" of product ""
    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "Create new sample requests" by sidebar
    And Admin create new sample request for Head buyer
      | fulfillment | fulfillmentDate | comment      | headBuyer       | brand                     |
      | Pending     | currentDate     | Auto comment | Auto HeadBuyer1 | Auto brand create product |
    And Admin add SKUs of product "auto product create sample 1" to new sample request
      | sku                      | comment       |
      | auto sku create sample 1 | comment sku 1 |
      | auto sku create sample 2 | comment sku 2 |
    And Admin use default head buyer store address
      | store                      | address             |
      | Auto Store check Orrder NY | 455 Madison Avenue, |
    And Admin create sample request success

#    And Admin go to sample detail with number ""
    And Check general information sample detail
      | created     | vendor_company      | buyer_company          | buyer           | email                             | address                                       | fulfillmentState | fulfillmentDate | comment      |
      | currentDate | Auto vendor company | Auto Buyer Company Bao | Auto HeadBuyer1 | ngoctx+autoheadbuyer1@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Pending          | currentDate     | Auto comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | Empty   | Empty          |
    And Check SKUs in sample detail
      | brand                     | product                      | variant                  | units        | comments      | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 units/case | comment sku 1 | 123123123123 | 123123123123 | [blank]   | [blank]   |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 2 | 1 units/case | comment sku 2 | 123123123123 | 123123123123 | [blank]   | [blank]   |

  @CREATE_SAMPLE_REQUESTS_19
  Scenario: Create new Sample Requests for head buyers - Check validation of all fields in the GENERAL section
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto product create sample 1" by api
    And Admin search product name "auto product create sample 1" by api
    And Admin delete product name "auto product create sample 1" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""
    And Admin create a "active" SKU from admin with name "auto sku create sample 2" of product ""
    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "Create new sample requests" by sidebar
    And Admin create new sample request for Head buyer
      | fulfillment | fulfillmentDate | comment | headBuyer | brand   |
      | [blank]     | [blank]         | [blank] | [blank]   | [blank] |
    And Check any text "is" showing on screen
      | No SKU available, please select another product. |
    And Admin create sample request success
    And Admin check message showing of field
      | field              | message                                              |
      | Add Product & SKUs | Please select at least 1 SKU for this sample request |
    And Check field "Add Product & SKUs" is disabled
    And Admin input invalid "Head buyer"
      | value             |
      | Auto HeadBuyer123 |
    And Check field "Add Product & SKUs" is disabled
    And Admin create new sample request for Head buyer
      | fulfillment | fulfillmentDate | comment | headBuyer       | brand   |
      | [blank]     | [blank]         | [blank] | Auto HeadBuyer1 | [blank] |
    And Admin create sample request success
    And Check any text "is" showing on screen
      | Please select a shipping address for this sample request |
    And Admin check message showing of field
      | field              | message                                              |
      | Add Product & SKUs | Please select at least 1 SKU for this sample request |
    And Admin Check place holder of field
      | field              | placeHolder                       |
      | Head buyer         | Select                            |
      | Brand              | Select a brand                    |
      | Add Product & SKUs | Select head buyer and brand first |
    And Admin input invalid "Brand"
      | value                        |
      | Auto brand create product123 |
    And Admin create new sample request for Head buyer
      | fulfillment | fulfillmentDate | comment | headBuyer | brand                     |
      | [blank]     | [blank]         | [blank] | [blank]   | Auto brand create product |
    And Admin add SKUs of product "auto product create sample 1" to new sample request
      | sku                      | comment |
      | auto sku create sample 1 | [blank] |
      | auto sku create sample 2 | [blank] |
    And Admin add another address to sample request
      | name    | attn    | street1 | street2 | city    | state   | zip     | phoneNumber |
      | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]     |
#    And Admin check message showing of field
#      | field                      | message                       |
#      | Street                     | Please enter street address   |
#      | City                       | Please enter city name        |
#      | State (Province/Territory) | Please select address state   |
#      | Zip                        | Please enter a valid zip code |
    And Admin add another address to sample request
      | name    | attn    | street1 | street2 | city    | state   | zip  | phoneNumber |
      | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | 1111 | [blank]     |
    And Admin check message showing of field
      | field | message                                |
      | Zip   | Please enter a valid 5-digits zip code |
    And Admin add another address to sample request
      | name    | attn    | street1 | street2 | city    | state   | zip    | phoneNumber |
      | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | 111111 | [blank]     |
    And Admin check message showing of field
      | field | message                                |
      | Zip   | Please enter a valid 5-digits zip code |

  @CREATE_SAMPLE_REQUESTS_24 @ADMIN_SAMPLE_REQUEST_9 @ADMIN_SAMPLE_REQUEST_24
  Scenario: Create new Sample Requests for head and normal buyers - Check validation of all fields in the PRODUCTS & SKUS section
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto product create sample" by api
    And Admin search product name "auto product create sample" by api
    And Admin delete product name "auto product create sample" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp | out_of_stock_reason | auto_out_of_stock_reason |
      | Pod Direct Central | 58 | active | sold_out     | 1000      | 1000 | vendor_short_term   | vendor_short_term        |
    And Admin create a "active" SKU from admin with name "auto sku create sample 2" of product ""
#  Product2
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 2 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | coming_soon  | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 3" of product ""
    And Clear Info of Region api
#    Product 3 not have SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 3 | 3018     |
#    Product 4
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 4 | 3018     |
#  + SKU_4 is active, has only availability in a store-specific (store whose company is the same with head buyer) = In stock / LS
    And Info of Store specific
      | store_id | store_name                  | buyer_company_id | buyer_company_name     | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2729     | Auto store 2 switch mov moq | 2360             | Auto Buyer Company Bao | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "auto sku create sample 4" of product ""
#  SKU_5 is active, has only availability in a store-specific (store whose company is the same with head buyer) = OOS
    And Info of Store specific
      | store_id | store_name                  | buyer_company_id | buyer_company_name     | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2729     | Auto store 2 switch mov moq | 2360             | Auto Buyer Company Bao | 26        | currentDate | currentDate | 1000             | 1000       | sold_out     |
    And Admin create a "active" SKU from admin with name "auto sku create sample 5" of product ""
#  + SKU_6 is active, has availability in a buyer-company-specific (e.g: For PDN) =  In stock / LS
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name     | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2360             | Auto Buyer Company Bao | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "auto sku create sample 6" of product ""
#  + SKU_7 is active, has availability in a buyer-company-specific (e.g: For TX) =  OOS
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name     | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2360             | Auto Buyer Company Bao | 26        | currentDate | currentDate | 1000             | 1000       | sold_out     |
    And Admin create a "active" SKU from admin with name "auto sku create sample 7" of product ""
#  + SKU_8 is active, has availability in SF region-specific = In stock; a buyer-company-specific in SF = LS; store-specific (store in SF whose company is the same with head buyer) = OOS
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name     | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2360             | Auto Buyer Company Bao | 26        | currentDate | currentDate | 1000             | 1000       | coming_soon  |
    And Info of Store specific
      | store_id | store_name                  | buyer_company_id | buyer_company_name     | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2729     | Auto store 2 switch mov moq | 2360             | Auto Buyer Company Bao | 26        | currentDate | currentDate | 1000             | 1000       | sold_out     |
    And Admin create a "active" SKU from admin with name "auto sku create sample 8" of product ""
#  + SKU_9 is draft
#  + SKU_10 is inactive
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "draft" SKU from admin with name "auto sku create sample 9" of product ""
    And Admin create a "inactive" SKU from admin with name "auto sku create sample 10" of product ""

    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "Create new sample requests" by sidebar
    And Admin create new sample request for Head buyer
      | fulfillment | fulfillmentDate | comment      | headBuyer       | brand                     |
      | Pending     | currentDate     | Auto comment | Auto HeadBuyer1 | Auto brand create product |
    And Admin input invalid "Add Product & SKUs"
      | value                      |
      | Auto brand create product3 |
    And Admin add SKUs of product "auto product create sample 1" to new sample request
      | sku     | comment |
      | [blank] | [blank] |
    And Admin add SKUs of product "auto product create sample 2" to new sample request
      | sku     | comment |
      | [blank] | [blank] |
    And Admin add SKUs of product "auto product create sample 4" to new sample request
      | sku     | comment |
      | [blank] | [blank] |
    And Admin check SKUs of product after add product to new sample request
      | sku                      | product                      | image       |
      | auto sku create sample 1 | auto product create sample 1 | anhJPG2.jpg |
      | auto sku create sample 3 | auto product create sample 2 | anhJPG2.jpg |
      | auto sku create sample 4 | auto product create sample 4 | anhJPG2.jpg |
      | auto sku create sample 6 | auto product create sample 4 | anhJPG2.jpg |
      | auto sku create sample 8 | auto product create sample 4 | anhJPG2.jpg |

#    For normal buyer
    And BAO_ADMIN4 navigate to "Sample Requests" to "All sample requests" by sidebar
    And BAO_ADMIN4 navigate to "Sample Requests" to "Create new sample requests" by sidebar
    And Admin create new sample request for Normal buyer
      | fulfillment | fulfillmentDate | comment      | region              |
      | Pending     | Minus1          | Auto comment | Chicagoland Express |
    And Admin add buyer to new sample request for Normal buyer
      | buyer        | region | store                       | brand                     |
      | Auto Buyer46 | CHI    | Auto store 2 switch mov moq | Auto brand create product |
    And Admin input invalid "Add Product & SKUs"
      | value                      |
      | Auto brand create product3 |
    And Admin add SKUs of product "auto product create sample 1" to new sample request
      | sku     | comment |
      | [blank] | [blank] |
    And Admin add SKUs of product "auto product create sample 2" to new sample request
      | sku     | comment |
      | [blank] | [blank] |
    And Admin add SKUs of product "auto product create sample 4" to new sample request
      | sku     | comment |
      | [blank] | [blank] |
    And Admin check SKUs of product after add product to new sample request
      | sku                      | product                      | image       |
      | auto sku create sample 1 | auto product create sample 1 | anhJPG2.jpg |
      | auto sku create sample 3 | auto product create sample 2 | anhJPG2.jpg |
      | auto sku create sample 4 | auto product create sample 4 | anhJPG2.jpg |
      | auto sku create sample 6 | auto product create sample 4 | anhJPG2.jpg |
      | auto sku create sample 8 | auto product create sample 4 | anhJPG2.jpg |

  @CREATE_SAMPLE_REQUESTS_1
  Scenario: Create new Sample Requests for normal buyers
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto product create sample 1" by api
    And Admin search product name "auto product create sample 1" by api
    And Admin delete product name "auto product create sample 1" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""
    And Admin create a "active" SKU from admin with name "auto sku create sample 2" of product ""
    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "Create new sample requests" by sidebar
    And Admin create new sample request for Normal buyer
      | fulfillment | fulfillmentDate | comment      | region              |
      | Pending     | Minus1          | Auto comment | Chicagoland Express |
    And Admin add buyer to new sample request for Normal buyer
      | buyer        | region | store               | brand                     |
      | Auto Buyer59 | CHI    | Auto Store Chicago1 | Auto brand create product |
    And Admin check buyers added to sample request
      | buyer        |
      | Auto Buyer59 |
    And Check any text "is" showing on screen
      | Fill buyer address and receiving options |
    And Click on any text "Fill buyer address and receiving options"
    And Admin check receiving when create sample request
      | name    | attn    | street1            | street2 | city     | state    | zip   | phoneNumber |
      | [blank] | [blank] | 455 Madison Avenue | [blank] | New York | New York | 10022 | [blank]     |
    And Admin add SKUs of product "auto product create sample 1" to new sample request
      | sku                      | comment       |
      | auto sku create sample 1 | comment sku 1 |
      | auto sku create sample 2 | comment sku 2 |
    And Admin create sample request success
    And Admin check alert message
      | Validation failed: Fulfillment date must be after or equal to request date |
    And Admin create new sample request for Normal buyer
      | fulfillment | fulfillmentDate | comment | region  |
      | [blank]     | currentDate     | [blank] | [blank] |
    And Admin create sample request success
    And Check general information sample detail
      | created     | region              | store               | vendor_company      | buyer_company     | buyer        | email                          | address                                       | fulfillmentState | fulfillmentDate | comment      |
      | currentDate | Chicagoland Express | Auto Store Chicago1 | Auto vendor company | Auto_BuyerCompany | Auto Buyer59 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Pending          | currentDate     | Auto comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | Empty   | Empty          |
    And Check SKUs in sample detail
      | brand                     | product                      | variant                  | units        | comments      | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 units/case | comment sku 1 | 123123123123 | 123123123123 | $10.00    | $10.00    |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 2 | 1 units/case | comment sku 2 | 123123123123 | 123123123123 | $10.00    | $10.00    |

  @CREATE_SAMPLE_REQUESTS_2
  Scenario: Create new Sample Requests for normal buyers - with multiple buyer
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto product create sample 1" by api
    And Admin search product name "auto product create sample 1" by api
    And Admin delete product name "auto product create sample 1" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""
    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "All sample requests" by sidebar
    And Click on button "Create"
    And Admin create new sample request for Normal buyer
      | fulfillment | fulfillmentDate | comment      | region              |
      | Pending     | currentDate     | Auto comment | Chicagoland Express |
    And Admin add buyer to new sample request for Normal buyer
      | buyer        | region | store               | brand                     |
      | Auto Buyer59 | CHI    | Auto Store Chicago1 | Auto brand create product |
      | Auto Buyer61 | CHI    | Auto Store Chicago1 | Auto brand create product |
    And Admin check buyers added to sample request
      | buyer        |
      | Auto Buyer59 |
      | Auto Buyer61 |
    And Check any text "not" showing on screen
      | Fill buyer address and receiving options |
    And Admin remove buyers added to sample request
      | buyer        |
      | Auto Buyer59 |
    And Admin check buyers added to sample request
      | buyer        |
      | Auto Buyer61 |
    And Check any text "is" showing on screen
      | Fill buyer address and receiving options |
    And Admin add buyer to new sample request for Normal buyer
      | buyer        | region | store               | brand                     |
      | Auto Buyer59 | CHI    | Auto Store Chicago1 | Auto brand create product |
    And Admin check buyers added to sample request
      | buyer        |
      | Auto Buyer59 |
      | Auto Buyer61 |
    And Check any text "not" showing on screen
      | Fill buyer address and receiving options |
    And Admin add SKUs of product "auto product create sample 1" to new sample request
      | sku                      | comment       |
      | auto sku create sample 1 | comment sku 1 |
    And Admin create sample request success
    And Admin check alert message
      | Sample requests have been created successfully !! |
    And Admin search sample request
      | number  | store               | buyer   | vendorCompany | buyerCompany | brand                     | fulfillment | region  | managedBy | startDate   | endDate     |
      | [blank] | Auto Store Chicago1 | [blank] | [blank]       | [blank]      | Auto brand create product | [blank]     | [blank] | [blank]   | currentDate | currentDate |
    And Admin check list of sample request after search
      | number  | store               | buyer        | buyerCompany      | fulfillment | region |
      | [blank] | Auto Store Chicago1 | Auto Buyer61 | Auto_BuyerCompany | Pending     | CHI    |
      | [blank] | Auto Store Chicago1 | Auto Buyer59 | Auto_BuyerCompany | Pending     | CHI    |

  @CREATE_SAMPLE_REQUESTS_7
  Scenario: Check the Filters function
    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "All sample requests" by sidebar
    Then Admin verify pagination function
    And Admin search sample request
      | number | store               | buyer        | vendorCompany           | buyerCompany      | brand                     | fulfillment | region              | managedBy     | startDate | endDate |
      | 123    | Auto Store Chicago1 | Auto Buyer61 | Auto vendor company mov | Auto_BuyerCompany | Auto brand create product | Pending     | Chicagoland Express | thuy_admin123 | Minus1    | Plus1   |
    And Admin check no data found
    And Admin reset filter
    And Admin search with invalid field "Store"
      | value                       |
      | Auto Store Chicago1 Invalid |
    And Admin search with invalid field "Buyer"
      | value                |
      | Auto Buyer61 Invalid |
    And Admin search with invalid field "Vendor company"
      | value                       |
      | Auto vendor company Invalid |
    And Admin search with invalid field "Buyer company"
      | value                     |
      | Auto_BuyerCompany Invalid |
    And Admin search with invalid field "Brand"
      | value                             |
      | Auto brand create product invalid |
    And Admin reset filter
    And Admin search sample request
      | number  | store   | buyer   | vendorCompany | buyerCompany | brand   | fulfillment | region  | managedBy | startDate | endDate |
      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | Fulfilled   | [blank] | [blank]   | [blank]   | [blank] |
      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | Canceled    | [blank] | [blank]   | [blank]   | [blank] |
    And Admin reset filter
    And Admin search sample request
      | number  | store   | buyer   | vendorCompany | buyerCompany | brand   | fulfillment | region                   | managedBy | startDate | endDate |
      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | [blank]     | Chicagoland Express      | [blank]   | [blank]   | [blank] |
      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | [blank]     | Florida Express          | [blank]   | [blank]   | [blank] |
      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | [blank]     | Mid Atlantic Express     | [blank]   | [blank]   | [blank] |
      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | [blank]     | New York Express         | [blank]   | [blank]   | [blank] |
      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | [blank]     | North California Express | [blank]   | [blank]   | [blank] |
      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | [blank]     | South California Express | [blank]   | [blank]   | [blank] |
      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | [blank]     | Dallas Express           | [blank]   | [blank]   | [blank] |
      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | [blank]     | Pod Direct Central       | [blank]   | [blank]   | [blank] |
      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | [blank]     | Pod Direct East          | [blank]   | [blank]   | [blank] |
#      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | [blank]     | Pod Direct Southeast           | [blank]   | [blank]   | [blank] |
#      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | [blank]     | Pod Direct Southwest & Rockies | [blank]   | [blank]   | [blank] |
      | [blank] | [blank] | [blank] | [blank]       | [blank]      | [blank] | [blank]     | Pod Direct West          | [blank]   | [blank]   | [blank] |

  @SAMPLE_REQUESTS_LIST_20
  Scenario: Check exporting Sample request detail CSV file function
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto product create sample 1" by api
    And Admin search product name "auto product create sample 1" by api
    And Admin delete product name "auto product create sample 1" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state |
      | 3314      | 3314     | [blank]     | 2582     | 1847              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           |
#
    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "All sample requests" by sidebar
    And Admin search sample request
      | number  | store               | buyer        | vendorCompany | buyerCompany | brand                     | fulfillment | region  | managedBy | startDate   | endDate     |
      | [blank] | Auto Store Chicago1 | Auto Buyer59 | [blank]       | [blank]      | Auto brand create product | [blank]     | [blank] | [blank]   | currentDate | currentDate |
    And Admin check list of sample request after search
      | number  | store               | buyer        | buyerCompany      | fulfillment | region |
      | [blank] | Auto Store Chicago1 | Auto Buyer59 | Auto_BuyerCompany | Pending     | CHI    |
#
    And Admin Export Sample request "detail" CSV
    And Admin check content file Export sample request detail
      | id      | number  | createdAt   | store               | buyer        | vendorCompany       | brand                     | product                      | sku                      | unitUpc      | caseUpc      |
      | [blank] | [blank] | currentDate | Auto Store Chicago1 | Auto Buyer59 | Auto vendor company | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 123123123123 | 123123123123 |
    And Admin Export Sample request "summary" CSV
    And Admin check content file Export sample request summary
      | id      | number  | createdAt   | store               | buyer        | vendorCompany       | fulfillmentState | fulfillmentDate |
      | [blank] | [blank] | currentDate | Auto Store Chicago1 | Auto Buyer59 | Auto vendor company | Pending          | [blank]         |

  @SAMPLE_REQUEST_DETAILS_1
  Scenario: Check information displayed for a sample requests created for 1 normal buyer and 1 products
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin search product name "auto product create sample 1" by api
    And Admin delete product name "auto product create sample 1" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""

#    And Admin add SKUs sample request by API
#      | product_variant_id | variants_region_id |
#      | [blank]            | [blank]            |
    And Admin create a "active" SKU from admin with name "auto sku create sample 2" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id | skuName                  | region_id |
      | [blank]            | [blank]            | auto sku create sample 1 | 26        |
      | [blank]            | [blank]            | auto sku create sample 2 | 26        |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment      |
      | 3314      | 3314     | [blank]     | 2582     | 1847              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | currentDate      | pending           | Auto comment |

    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "All sample requests" by sidebar
    And Admin search sample request
      | number  | store               | buyer        | vendorCompany | buyerCompany | brand                     | fulfillment | region  | managedBy | startDate   | endDate     |
      | [blank] | Auto Store Chicago1 | Auto Buyer59 | [blank]       | [blank]      | Auto brand create product | [blank]     | [blank] | [blank]   | currentDate | currentDate |
    And Admin go to sample detail with number "create by api"

    And Check general information sample detail
      | created     | region              | store               | vendor_company      | buyer_company     | buyer        | email                          | address                                       | fulfillmentState | fulfillmentDate | comment      |
      | currentDate | Chicagoland Express | Auto Store Chicago1 | Auto vendor company | Auto_BuyerCompany | Auto Buyer59 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Pending          | currentDate     | Auto comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | Empty   | Empty          |
    And Check SKUs in sample detail
      | brand                     | product                      | variant                  | units        | comments | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 units/case | Empty    | 123123123123 | 123123123123 | $10.00    | $10.00    |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 2 | 1 units/case | Empty    | 123123123123 | 123123123123 | $10.00    | $10.00    |

    And Admin redirect icon of field
      | field               |
      | Auto vendor company |
    And Admin verify page title is "Vendor company 1847 — Auto vendor company"
    And Admin go back with button
    And Admin redirect icon of field
      | field             |
      | Auto_BuyerCompany |
    And Admin verify page title is "Buyer company 2216 — Auto_BuyerCompany"
    And Admin go back with button
    And Admin redirect icon of field
      | field               |
      | Auto Store Chicago1 |
    And Admin verify page title is "Store 2582 — Auto Store Chicago1"
    And Admin go back with button
    And Admin redirect icon of field
      | field        |
      | Auto Buyer59 |
    And Admin verify page title is "Buyer 3314 — Auto Buyer59"
    And Admin go back with button
#    Packing slip
    And Admin verify print Packing slip sample request
      | number        | store               | buyer        | createdAt   | address                                       | comment      |
      | create by api | Auto Store Chicago1 | Auto Buyer59 | currentDate | 455 Madison Avenue, New York, New York, 10022 | Auto comment |
    And Admin verify items of Packing slip sample request
      | brand                     | product                      | sku                      | case-units | case-upc     | upc          |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 per case | 123123123123 | 123123123123 |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 2 | 1 per case | 123123123123 | 123123123123 |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Check first Sample request in dashboard
      | requested   | number  | store               | brand                     | product                      | fulfillment |
      | currentDate | [blank] | Auto Store Chicago1 | Auto brand create product | auto product create sample 1 | Pending     |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName                 | skuName                  | status | addCart | unitUPC                      | casePrice |
      | Auto brand create product | auto sku create sample 1 | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
      | Auto brand create product | auto sku create sample 2 | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Samples" by sidebar
    And Vendor search sample request on tab "All"
      | region              | store               | requestFrom | requestTo |
      | Chicagoland Express | Auto Store Chicago1 | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number  | store               | brand                     | products                     | fulfillment |
      | currentDate | [blank] | Auto Store Chicago1 | Auto brand create product | auto product create sample 1 | Pending     |
    And Vendor go to sample detail of number: ""
    And Vendor Check info sample request detail
      | region              | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       | comment      |
      | Chicagoland Express | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Auto comment |
    And Vendor Check items in sample request detail of product "auto product create sample 1"
      | brandName                 | skuName                  | status | unitUPC                      |
      | Auto brand create product | auto sku create sample 1 | Active | Unit UPC / EAN: 123123123123 |
      | Auto brand create product | auto sku create sample 2 | Active | Unit UPC / EAN: 123123123123 |
#    And Vendor Check items in sample request detail of product "auto product create sample 1"
#      | brandName                 | skuName                  | status | unitUPC                      |
#      | Auto brand create product | auto sku create sample 2 | Active | Unit UPC / EAN: 123123123123 |

  @SAMPLE_REQUEST_DETAILS_4
  Scenario: Check email sent to buyer, vendor
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |

  @SAMPLE_REQUEST_DETAILS_7
  Scenario: Check information displayed for a sample requests created for 1 normal buyer and multiple products
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
#    And Admin search product name "auto product create sample" by api
#    And Admin delete product name "auto product create sample" by api
#    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""
#    And Admin add SKUs sample request by API
#      | product_variant_id | variants_region_id |
#      | [blank]            | [blank]            |
#    And Admin add products sample request by API
#      | product_ids |
#      | [blank]     |

    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 2 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 2000      | 2000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 2" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id | skuName                  | region_id |
      | [blank]            | [blank]            | auto sku create sample 1 | 26        |
      | [blank]            | [blank]            | auto sku create sample 2 | 26        |
    And Admin add products sample request by API
      | product_ids | product_name                 |
      | [blank]     | auto product create sample 1 |
      | [blank]     | auto product create sample 2 |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3314     |
    And Admin create sample request by with multiple products API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment      |
      | [blank]   | [blank]  | [blank]     | 2582     | 1847              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | currentDate      | pending           | Auto comment |

    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
#    And BAO_ADMIN4 navigate to "Sample Requests" to "Create new sample requests" by sidebar
    And BAO_ADMIN4 navigate to "Sample Requests" to "All sample requests" by sidebar
    And Admin search sample request
      | number  | store               | buyer        | vendorCompany | buyerCompany | brand                     | fulfillment | region  | managedBy | startDate   | endDate     |
      | [blank] | Auto Store Chicago1 | Auto Buyer59 | [blank]       | [blank]      | Auto brand create product | [blank]     | [blank] | [blank]   | currentDate | currentDate |
    And Admin go to sample detail with number "create by api"

    And Check general information sample detail
      | created     | region              | store               | vendor_company      | buyer_company     | buyer        | email                          | address                                       | fulfillmentState | fulfillmentDate | comment      |
      | currentDate | Chicagoland Express | Auto Store Chicago1 | Auto vendor company | Auto_BuyerCompany | Auto Buyer59 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Pending          | currentDate     | Auto comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | Empty   | Empty          |
    And Check SKUs in sample detail
      | brand                     | product                      | variant                  | units        | comments | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 units/case | Empty    | 123123123123 | 123123123123 | $10.00    | $10.00    |
      | Auto brand create product | auto product create sample 2 | auto sku create sample 2 | 1 units/case | Empty    | 123123123123 | 123123123123 | $20.00    | $20.00    |

    And Admin verify print Packing slip sample request
      | number        | store               | buyer        | createdAt   | address                                       | comment      |
      | create by api | Auto Store Chicago1 | Auto Buyer59 | currentDate | 455 Madison Avenue, New York, New York, 10022 | Auto comment |
    And Admin verify items of Packing slip sample request
      | brand                     | product                      | sku                      | case-units | case-upc     | upc          |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 per case | 123123123123 | 123123123123 |
      | Auto brand create product | auto product create sample 2 | auto sku create sample 2 | 1 per case | 123123123123 | 123123123123 |

  @SAMPLE_REQUEST_DETAILS_12
  Scenario: Check information displayed for a sample requests created for multiple normal buyers and 1 products
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto product create sample 1" by api
    And Admin search product name "auto product create sample 1" by api
    And Admin delete product name "auto product create sample 1" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""

    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3314     |
      | 3365     |
    And Admin create sample request by API2
      | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | [blank]     | [blank]  | 1847              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |
    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "All sample requests" by sidebar
    And Admin search sample request
      | number  | store               | buyer   | vendorCompany | buyerCompany | brand                     | fulfillment | region  | managedBy | startDate   | endDate     |
      | [blank] | Auto Store Chicago1 | [blank] | [blank]       | [blank]      | Auto brand create product | [blank]     | [blank] | [blank]   | currentDate | currentDate |
    And Admin check list of sample request after search
      | number  | store               | buyer        | buyerCompany      | fulfillment | region |
      | [blank] | Auto Store Chicago1 | Auto Buyer61 | Auto_BuyerCompany | Pending     | CHI    |
      | [blank] | Auto Store Chicago1 | Auto Buyer59 | Auto_BuyerCompany | Pending     | CHI    |

  @SAMPLE_REQUEST_DETAILS_17
  Scenario: Check information displayed for a sample requests created for multiple normal buyers and multiple products
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto product create sample 1" by api
    And Admin search product name "auto product create sample 1" by api
    And Admin delete product name "auto product create sample 1" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""
#    And Admin add SKUs sample request by API
#      | product_variant_id | variants_region_id |
#      | [blank]            | [blank]            |
    And Admin add products sample request by API
      | product_ids |
      | [blank]     |
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 2 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 2000      | 2000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 2" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id | skuName                  | region_id |
      | [blank]            | [blank]            | auto sku create sample 1 | 26        |
      | [blank]            | [blank]            | auto sku create sample 2 | 26        |
    And Admin add products sample request by API
      | product_ids |
      | [blank]     |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3314     |
      | 3365     |
    And Admin create sample request by with multiple products API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment      |
      | [blank]   | [blank]  | [blank]     | 2582     | 1847              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | currentDate      | pending           | Auto comment |
    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "All sample requests" by sidebar
    And Admin search sample request
      | number  | store               | buyer   | vendorCompany | buyerCompany | brand                     | fulfillment | region  | managedBy | startDate   | endDate     |
      | [blank] | Auto Store Chicago1 | [blank] | [blank]       | [blank]      | Auto brand create product | [blank]     | [blank] | [blank]   | currentDate | currentDate |
    And Admin check list of sample request after search
      | number  | store               | buyer        | buyerCompany      | fulfillment | region |
      | [blank] | Auto Store Chicago1 | Auto Buyer61 | Auto_BuyerCompany | Pending     | CHI    |
      | [blank] | Auto Store Chicago1 | Auto Buyer59 | Auto_BuyerCompany | Pending     | CHI    |
    And Admin go to detail of first sample request record
    And Check general information sample detail
      | created     | region              | store               | vendor_company      | buyer_company     | buyer        | email                          | address                                       | fulfillmentState | fulfillmentDate | comment      |
      | currentDate | Chicagoland Express | Auto Store Chicago1 | Auto vendor company | Auto_BuyerCompany | Auto Buyer61 | ngoctx+autobuyer61@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Pending          | [blank]         | Auto comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | Empty   | Empty          |
    And Check SKUs in sample detail
      | brand                     | product                      | variant                  | units        | comments | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 units/case | Empty    | 123123123123 | 123123123123 | $10.00    | $10.00    |
      | Auto brand create product | auto product create sample 2 | auto sku create sample 2 | 1 units/case | Empty    | 123123123123 | 123123123123 | $20.00    | $20.00    |

    And Admin go back with button
    And Admin search sample request
      | number  | store               | buyer        | vendorCompany | buyerCompany | brand                     | fulfillment | region  | managedBy | startDate   | endDate     |
      | [blank] | Auto Store Chicago1 | Auto Buyer59 | [blank]       | [blank]      | Auto brand create product | [blank]     | [blank] | [blank]   | currentDate | currentDate |
    And Admin check list of sample request after search
      | number  | store               | buyer        | buyerCompany      | fulfillment | region |
      | [blank] | Auto Store Chicago1 | Auto Buyer59 | Auto_BuyerCompany | Pending     | CHI    |
    And Admin go to detail of first sample request record

    And Check general information sample detail
      | created     | region              | store               | vendor_company      | buyer_company     | buyer        | email                          | address                                       | fulfillmentState | fulfillmentDate | comment      |
      | currentDate | Chicagoland Express | Auto Store Chicago1 | Auto vendor company | Auto_BuyerCompany | Auto Buyer59 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Pending          | [blank]         | Auto comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | Empty   | Empty          |
    And Check SKUs in sample detail
      | brand                     | product                      | variant                  | units        | comments | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 units/case | Empty    | 123123123123 | 123123123123 | $10.00    | $10.00    |
      | Auto brand create product | auto product create sample 2 | auto sku create sample 2 | 1 units/case | Empty    | 123123123123 | 123123123123 | $20.00    | $20.00    |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Samples" by sidebar
    And Check first Sample request in dashboard
      | requested   | number  | store               | brand                     | product                      | fulfillment |
      | currentDate | [blank] | Auto Store Chicago1 | Auto brand create product | auto product create sample 1 | Pending     |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer59 | Auto Store Chicago1 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName                 | skuName                  | status | addCart | unitUPC                      | casePrice |
      | Auto brand create product | auto sku create sample 1 | Active | [blank] | Unit UPC / EAN: 123123123123 | $10.00    |
      | Auto brand create product | auto sku create sample 2 | Active | [blank] | Unit UPC / EAN: 123123123123 | $20.00    |

    Given BUYER2 open web user
    When login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "buyer"
    And BUYER2 Go to Dashboard
    And BUYER2 Navigate to "Samples" by sidebar
    And Check first Sample request in dashboard
      | requested   | number  | store               | brand                     | product                      | fulfillment |
      | currentDate | [blank] | Auto Store Chicago1 | Auto brand create product | auto product create sample 1 | Pending     |
    And Go to sample request detail with number ""
    And Check info sample request detail
      | requestDate | fulfillment | buyerName    | storeName           | emailBuyer                     | address                                       |
      | currentDate | Pending     | Auto Buyer61 | Auto Store Chicago1 | ngoctx+autobuyer61@podfoods.co | 455 Madison Avenue, New York, New York, 10022 |
    And Check items in sample request detail
      | brandName                 | skuName                  | status | addCart | unitUPC                      | casePrice |
      | Auto brand create product | auto sku create sample 1 | Active | [blank] | Unit UPC / EAN: 123123123123 | —         |
      | Auto brand create product | auto sku create sample 2 | Active | [blank] | Unit UPC / EAN: 123123123123 | —         |

  @SAMPLE_REQUEST_DETAILS_20
  Scenario: Check information displayed for a sample requests created for 1 head buyer and 1 products with using default head buyer's stores address
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto product create sample" by api
    And Admin search product name "auto product create sample" by api
    And Admin delete product name "auto product create sample" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""

    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "Create new sample requests" by sidebar
    And Admin create new sample request for Head buyer
      | fulfillment | fulfillmentDate | comment      | headBuyer       | brand                     |
      | Pending     | currentDate     | Auto comment | Auto HeadBuyer1 | Auto brand create product |
    And Admin add SKUs of product "auto product create sample 1" to new sample request
      | sku                      | comment       |
      | auto sku create sample 1 | comment sku 1 |

    And Admin use default head buyer store address
      | store                      | address             |
      | Auto Store check Orrder NY | 455 Madison Avenue, |
    And Admin create sample request success

#    And Admin go to sample detail with number ""
    And Check general information sample detail
      | created     | vendor_company      | buyer_company          | buyer           | email                             | address                                       | fulfillmentState | fulfillmentDate | comment      |
      | currentDate | Auto vendor company | Auto Buyer Company Bao | Auto HeadBuyer1 | ngoctx+autoheadbuyer1@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Pending          | currentDate     | Auto comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | Empty   | Empty          |
    And Check SKUs in sample detail
      | brand                     | product                      | variant                  | units        | comments      | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 units/case | comment sku 1 | 123123123123 | 123123123123 | [blank]   | [blank]   |
    And Admin redirect icon of field
      | field               |
      | Auto vendor company |
    And Admin verify page title is "Vendor company 1847 — Auto vendor company"
    And Admin go back with button
    And Admin redirect icon of field
      | field                  |
      | Auto Buyer Company Bao |
    And Admin verify page title is "Buyer company 2360 — Auto Buyer Company Bao"
    And Admin go back with button
    And Admin redirect icon of field
      | field           |
      | Auto HeadBuyer1 |
    And Admin verify page title is "Buyer 108 — Auto HeadBuyer1"
    And Admin go back with button
#    Packing slip
    And Admin verify print Packing slip sample request
      | number          | buyerCompany           | buyer           | createdAt   | address                                       | comment      |
      | create by admin | Auto Buyer Company Bao | Auto HeadBuyer1 | currentDate | 455 Madison Avenue, New York, New York, 10022 | Auto comment |
    And Admin verify items of Packing slip sample request
      | brand                     | product                      | sku                      | case-units | case-upc     | upc          |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 per case | 123123123123 | 123123123123 |

  @SAMPLE_REQUEST_DETAILS_27
  Scenario: Check information displayed for a sample requests created for 1 head buyer and mutiple products with using default head buyer's stores address
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto product create sample" by api
    And Admin search product name "auto product create sample" by api
    And Admin delete product name "auto product create sample" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 2 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 2" of product ""

    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "Create new sample requests" by sidebar
    And Admin create new sample request for Head buyer
      | fulfillment | fulfillmentDate | comment      | headBuyer       | brand                     |
      | Pending     | currentDate     | Auto comment | Auto HeadBuyer1 | Auto brand create product |
    And Admin add SKUs of product "auto product create sample 1" to new sample request
      | sku                      | comment       |
      | auto sku create sample 1 | comment sku 1 |
    And Admin add SKUs of product "auto product create sample 2" to new sample request
      | sku                      | comment       |
      | auto sku create sample 2 | comment sku 2 |

    And Admin use default head buyer store address
      | store                      | address             |
      | Auto Store check Orrder NY | 455 Madison Avenue, |
    And Admin create sample request success

#    And Admin go to sample detail with number ""
    And Check general information sample detail
      | created     | vendor_company      | buyer_company          | buyer           | email                             | address                                       | fulfillmentState | fulfillmentDate | comment      |
      | currentDate | Auto vendor company | Auto Buyer Company Bao | Auto HeadBuyer1 | ngoctx+autoheadbuyer1@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Pending          | currentDate     | Auto comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | Empty   | Empty          |
    And Check SKUs in sample detail
      | brand                     | product                      | variant                  | units        | comments      | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 units/case | comment sku 1 | 123123123123 | 123123123123 | [blank]   | [blank]   |
      | Auto brand create product | auto product create sample 2 | auto sku create sample 2 | 1 units/case | comment sku 2 | 123123123123 | 123123123123 | [blank]   | [blank]   |

#    Packing slip
    And Admin verify print Packing slip sample request
      | number          | buyerCompany           | buyer           | createdAt   | address                                       | comment      |
      | create by admin | Auto Buyer Company Bao | Auto HeadBuyer1 | currentDate | 455 Madison Avenue, New York, New York, 10022 | Auto comment |
    And Admin verify items of Packing slip sample request
      | brand                     | product                      | sku                      | case-units | case-upc     | upc          |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 per case | 123123123123 | 123123123123 |
      | Auto brand create product | auto product create sample 2 | auto sku create sample 2 | 1 per case | 123123123123 | 123123123123 |

  @SAMPLE_REQUEST_DETAILS_28
  Scenario: Check information displayed for a sample requests created for 1 head buyer and mutiple products with using CUSTOMED stores address
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto product create sample" by api
    And Admin search product name "auto product create sample" by api
    And Admin delete product name "auto product create sample" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 2 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 2" of product ""

    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
    And BAO_ADMIN4 navigate to "Sample Requests" to "Create new sample requests" by sidebar
    And Admin create new sample request for Head buyer
      | fulfillment | fulfillmentDate | comment      | headBuyer       | brand                     |
      | Pending     | currentDate     | Auto comment | Auto HeadBuyer1 | Auto brand create product |
    And Admin add SKUs of product "auto product create sample 1" to new sample request
      | sku                      | comment       |
      | auto sku create sample 1 | comment sku 1 |
    And Admin add SKUs of product "auto product create sample 2" to new sample request
      | sku                      | comment       |
      | auto sku create sample 2 | comment sku 2 |
    And Admin add another address to sample request
      | name         | attn | street1            | street2 | city     | state    | zip   | phoneNumber |
      | Auto address | atn  | 455 Madison Avenue | [blank] | New York | New York | 10022 | 1234567890  |
    And Admin choose stores to sample request
      | store        | address             |
      | Auto address | 455 Madison Avenue, |
    And Admin create sample request success

    And Check general information sample detail
      | created     | vendor_company      | buyer_company          | buyer           | email                             | address                                       | fulfillmentState | fulfillmentDate | comment      |
      | currentDate | Auto vendor company | Auto Buyer Company Bao | Auto HeadBuyer1 | ngoctx+autoheadbuyer1@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Pending          | currentDate     | Auto comment |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | Empty   | Empty          |
    And Check SKUs in sample detail
      | brand                     | product                      | variant                  | units        | comments      | unitUPC      | caseUPC      | unitPrice | casePrice |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 units/case | comment sku 1 | 123123123123 | 123123123123 | [blank]   | [blank]   |
      | Auto brand create product | auto product create sample 2 | auto sku create sample 2 | 1 units/case | comment sku 2 | 123123123123 | 123123123123 | [blank]   | [blank]   |

#    Packing slip
    And Admin verify print Packing slip sample request
      | number          | buyerCompany           | buyer           | createdAt   | address                                       | comment      |
      | create by admin | Auto Buyer Company Bao | Auto HeadBuyer1 | currentDate | 455 Madison Avenue, New York, New York, 10022 | Auto comment |
    And Admin verify items of Packing slip sample request
      | brand                     | product                      | sku                      | case-units | case-upc     | upc          |
      | Auto brand create product | auto product create sample 1 | auto sku create sample 1 | 1 per case | 123123123123 | 123123123123 |
      | Auto brand create product | auto product create sample 2 | auto sku create sample 2 | 1 per case | 123123123123 | 123123123123 |

  @SAMPLE_REQUEST_DETAILS_32 @ADMIN_SAMPLE_REQUEST_91
  Scenario: Check when admin changes Fulfillment information (Fulffilment state and Fulffilment date field)
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    And Admin search product name "auto product create sample" by api
    And Admin delete product name "auto product create sample" by api
#    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin add products sample request by API
      | product_ids |
      | [blank]     |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 3314     |
    And Admin create sample request by with multiple products API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment      |
      | [blank]   | [blank]  | [blank]     | 2582     | 1847              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | currentDate      | pending           | Auto comment |

    Given BAO_ADMIN4 open web admin
    When BAO_ADMIN4 login to web with role Admin
#    And BAO_ADMIN4 navigate to "Sample Requests" to "Create new sample requests" by sidebar
    And BAO_ADMIN4 navigate to "Sample Requests" to "All sample requests" by sidebar
    And Admin search sample request
      | number  | store               | buyer        | vendorCompany | buyerCompany | brand                     | fulfillment | region  | managedBy | startDate   | endDate     |
      | [blank] | Auto Store Chicago1 | Auto Buyer59 | [blank]       | [blank]      | Auto brand create product | [blank]     | [blank] | [blank]   | currentDate | currentDate |
    And Admin go to sample detail with number "create by api"
    And Admin edit sample request field
      | fulfillmentDate | comment | carrier | trackingNumber |
      | currentDate     | comment | USPS    | vendorCompany  |
    And Admin edit fulfillment state sample request
      | fulfillmentState | note       | action |
      | Canceled         | admin Note | Cancel |
    And Check general information sample detail
      | created     | region              | store               | vendor_company      | buyer_company     | buyer        | email                          | address                                       | fulfillmentState | fulfillmentDate | comment | adminNote  |
      | currentDate | Chicagoland Express | Auto Store Chicago1 | Auto vendor company | Auto_BuyerCompany | Auto Buyer59 | ngoctx+autobuyer59@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Canceled         | currentDate     | comment | admin Note |
    And Admin check delivery in sample detail
      | carrier | trackingNumber |
      | USPS    | vendorCompany  |

  @ADMIN_SAMPLE_REQUEST_101
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
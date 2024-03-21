#mvn verify -Dtestsuite="AdminProductSuite" -Dcucumber.options="src/test/resources/features/admin"
@feature=AdminProductFeature
Feature: Admin product

  @Admin @TC_01_68
  Scenario: Admin create product
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]         | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto bao create product | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product" from API
    And Admin delete inventory "all" by API
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api
    And Change state of product id: "6627" to "active"

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin create new product with general info
      | brandName                 | productName               | status | isBeverage | containerType | allowRequestSamples | vendorCompany       | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand create product | auto bao create product 1 | Active | Yes        | Glass         | Yes                 | Auto vendor company | 0             | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microDescriptions | [blank]   |
    And Admin add case pack photo
      | fileName    |
      | anhJPG2.jpg |
    And Admin add master carton photo
      | fileName    |
      | anhJPG2.jpg |
    And Admin create new product with tags
      | tagName       | expiryDate  |
      | Auto Bao Tags | currentDate |
    And Admin create new product with state fees
      | stateFeeName   | stateFeeValue |
      | Auto state fee | 100           |
    And Admin confirm create new product
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  |
      | Active      | auto bao create product 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 0.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" |
    And Admin check Case pack photos
      | casePackPhoto |
      | anhJPG2.jpg   |
    And Admin check Master carton photos
      | masterPhoto |
      | anhJPG2.jpg |
    And Admin check help text tooltip1
      | field               | text                                                                                                                                                 |
      | Case Pack Photo     | Upload an image that shows your properly configured and labeled Case Pack. You will find Case Pack requirements in the Brand Guide.                  |
      | Master Carton Photo | Upload an image that shows your properly configured and labeled Master Carton (if any). You will find Master Carton requirements in the Brand Guide. |
    And Admin remove Case pack photos
      | file        |
      | anhJPG2.jpg |
    And Admin check Case pack photos
      | casePackPhoto |
      | [blank]       |
    And Admin remove Master Carton photos
      | file        |
      | anhJPG2.jpg |
    And Admin check Master carton photos
      | masterPhoto |
      | [blank]     |
    And Admin add case pack photo on product detail
      | fileName        |
      | 10MBgreater.jpg |
    And Admin verify content of alert
      | Maximum file size exceeded. |
    And Admin add master carton photo on product detail
      | fileName        |
      | 10MBgreater.jpg |
    And Admin verify content of alert
      | Maximum file size exceeded. |
#    And Admin remove Case pack photos
#      | file    |
#      | [blank] |
    And Admin add case pack photo on product detail
      | fileName          |
      | ImageInvalid1.pdf |
    And Admin verify content of alert
      | Invalid file type. |
#    And Admin remove Case pack photos
#      | file    |
#      | [blank] |
    And Admin add master carton photo on product detail
      | fileName          |
      | ImageInvalid1.pdf |
    And Admin verify content of alert
      | Invalid file type. |

  @Admin @AD_Products_6
  Scenario: Check display of the Edit visibility popup
    Given BAO_ADMIN23 login web admin by api
      | email             | password  |
      | bao23@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api
    And Change state of product id: "6627" to "active"
    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product06 | 3018     |

     # Reset search filter full textbox
    And Admin filter visibility with id "5" by api
      | q[brand_id]            |
      | q[search_term]         |
      | q[product_type_id]     |
      | q[sampleable]          |
      | q[tag_ids][]           |
      | q[state]               |
      | q[vendor_company_id]   |
      | q[product_variant_ids] |
      | q[region_id]           |
      | q[package_size_id]     |
    And Admin delete filter preset of screen id "5" by api
    Given BAO_ADMIN23 open web admin
    When BAO_ADMIN23 login to web with role Admin
    And BAO_ADMIN23 navigate to "Products" to "All products" by sidebar
    And Admin edit visibility search product
      | searchTerm | productState | brand   | vendorCompany | productType | packageSize | sampleable | available | tags    | sku     |
      | [blank]    | [blank]      | [blank] | [blank]       | [blank]     | [blank]     | [blank]    | [blank]   | [blank] | [blank] |
    Then Admin verify search product field not visible
      | searchTerm | productState | brand   | vendorCompany | productType | packageSize | sampleable | available | tags    | sku     |
      | [blank]    | [blank]      | [blank] | [blank]       | [blank]     | [blank]     | [blank]    | [blank]   | [blank] | [blank] |
    And Admin edit visibility search product
      | searchTerm | productState | brand   | vendorCompany |
      | [blank]    | [blank]      | [blank] | [blank]       |
    Then Admin verify search product field not visible
      | productType | packageSize | sampleable | available | tags    | sku     |
      | [blank]     | [blank]     | [blank]    | [blank]   | [blank] | [blank] |
    Then Admin verify search product field visible
      | searchTerm | productState | brand   | vendorCompany |
      | [blank]    | [blank]      | [blank] | [blank]       |
    And Admin edit visibility search product
      | productType | packageSize | sampleable | available | tags    | sku     |
      | [blank]     | [blank]     | [blank]    | [blank]   | [blank] | [blank] |
    And Admin search product with info
      | term                    | productState | brand                     | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    | sku     |
      | auto bao create product | Active       | Auto brand create product | Auto vendor company | Bao Bakery  | Bulk        | Sampleable | [blank]     | [blank] | [blank] |
    And Admin save filter by info
      | filterName | type               |
      | [blank]    | Save as new preset |
    And BAO_ADMIN23 check error message is showing of fields on dialog
      | field       | message                         |
      | Preset name | Please enter name filter preset |
    And Admin close dialog form
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN23 check value of field
      | field          | value                     |
      | Search term    | auto bao create product   |
      | Product state  | Active                    |
      | Brand          | Auto brand create product |
      | Vendor company | Auto vendor company       |
      | Product type   | Bao Bakery                |
      | Package size   | Bulk                      |

    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | availableIn | tags    |
      | auto bao create product06 | Active       | Auto brand create product | Auto vendor company | Bao Bakery  | [blank]     | [blank] |
    And Admin search product with info
      | term                    | productState | brand                     | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    | sku     |
      | auto bao create product | -            | Auto brand create product | Auto vendor company | -           | -           | [blank]    | [blank]     | [blank] | [blank] |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN23 check value of field
      | field          | value                     |
      | Search term    | auto bao create product   |
      | Product state  | -                         |
      | Brand          | Auto brand create product |
      | Vendor company | Auto vendor company       |
      | Product type   | -                         |
      | Package size   | -                         |
    And Admin delete filter preset is "AutoTest1"

  @Admin @TC_Admin_check_create_edit_product_and_filter_product @TC_01_68_
  Scenario: Admin create product, edit and filter
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api
    And Change state of product id: "6627" to "active"
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin create new product with general info
      | brandName                 | productName               | status | isBeverage | containerType | allowRequestSamples | vendorCompany       | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand create product | auto bao create product 1 | Active | Yes        | Glass         | Yes                 | Auto vendor company | 0             | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microDescriptions | [blank]   |
    And Admin add case pack photo
      | fileName    |
      | anhJPG2.jpg |
    And Admin add master carton photo
      | fileName    |
      | anhJPG2.jpg |
    And Admin create new product with tags
      | tagName       | expiryDate  |
      | Auto Bao Tags | currentDate |
    And Admin create new product with state fees
      | stateFeeName   | stateFeeValue |
      | Auto state fee | 100           |
    And Admin confirm create new product
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  |
      | Active      | auto bao create product 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 0.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" |
    And Admin check Case pack photos
      | casePackPhoto |
      | anhJPG2.jpg   |
    And Admin check Master carton photos
      | masterPhoto |
      | anhJPG2.jpg |
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |

    And Search the product by info then system show result
      | term    | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | [blank] | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |

    And Search the product by info then system show result
      | term    | productState | brandName                 | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | [blank] | [blank]      | Auto brand create product | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |

    And Search the product by info then system show result
      | term    | productState | brandName | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | [blank] | [blank]      | [blank]   | Auto vendor company | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |

    And Search the product by info then system show result
      | term    | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | [blank] | [blank]      | [blank]   | [blank]       | Bread       | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |
    And Search the product by info then system show result
      | term    | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | [blank] | [blank]      | [blank]   | [blank]       | [blank]     | Bulk        | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |
    And Search the product by info then system show result
      | term    | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | [blank] | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | Sampleable | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |
    And Search the product by info then system show result
      | term    | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags          |
      | [blank] | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | Auto Bao Tags |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |
    And Search the product by info then system show result
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | [blank] |

    And Admin go to detail of product "auto bao create product 1"
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | stateFee             | tags          | expiryTag   | isBeverage | containerType |
      | Active      | auto bao create product 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 0.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | Auto state fee $1.00 | Auto Bao Tags | currentDate | Yes        | Glass         |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Check product not have SKU
    And Add new SKU
      | skuName                     | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto 1 check create product | [blank] | [blank] | 12        | 123456789098      | no                    | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | [blank]          | 10              | [blank]         | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with region specific
      | regionName           | casePrice | msrpunit | availability | arriving |
      | Florida Express      | 12        | 15       | In stock     | [blank]  |
      | Mid Atlantic Express | 12        | 15       | Out of stock | [blank]  |
#      | Pod Direct Northeast | 12        | 15       | Launching soon | currentDate |
    And Click Create
    And Admin check message of sku "auto 1 check create product" is "Variant have been saved successfully !!"

    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn     | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | Florida Express | [blank] |

    #Do availableIn không theo thứ tự nhất định nên check contain từng region một
#    And Admin check list of product after searching
#      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
#      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | PDN         | Auto Bao Tags |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | MA          | Auto Bao Tags |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | FL          | Auto Bao Tags |

    And Admin go to detail of product "auto bao create product 1"

    And Admin edit info of product
      | name                      | sampleable | packageSize         | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type       | microDescription |
      | auto bao create product 2 | No         | Individual servings | 12         | 12        | 12         | 12         | 12        | 12         | 12         | 12       | lbs          | 1             | Bakery     | Bao Bakery | microDescription |
    And Admin edit pallet configuration of product
      | casePerPallet | casePerLayer | layerPerPallet |
      | 12            | 12           | 12             |
    And Admin edit master case configuration of product
      | masterCartonPallet | casePerMasterCarton | masterCaseWeight | masterLength | masterWidth | masterHeight |
      | 12                 | 12                  | 12               | 12           | 12          | 12           |
    And Admin edit state fees of product
      | oldStateFee    | newStateFee | value |
      | Auto state fee | 12abc       | 200   |
    And Admin edit tags of product
      | tag           | expireDate |
      | Auto Bao Tags | Plus1      |
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn     | tags    |
      | auto bao create product 2 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | Florida Express | [blank] |
#    And Admin check list of product after searching
#      | term                      | brandName                 | productType | availableIn | tags    |
#      | auto bao create product 2 | Auto brand create product | Bao Bakery  | PDN         | [blank] |
    And Admin check list of product after searching
      | term                      | brandName                 | productType | availableIn | tags    |
      | auto bao create product 2 | Auto brand create product | Bao Bakery  | MA          | [blank] |
    And Admin check list of product after searching
      | term                      | brandName                 | productType | availableIn | tags    |
      | auto bao create product 2 | Auto brand create product | Bao Bakery  | FL          | [blank] |
    And Admin verify list tags of product on all product page
      | tag           | expireDate |
      | Auto Bao Tags | Plus1      |
    And Admin go to detail of product "auto bao create product 2"
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize         | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | stateFee    | tags          | expiryTag |
      | Active      | auto bao create product 2 | Auto brand create product | Auto vendor company | No         | Individual servings | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 12.0 lbs | 1.00%         | Bakery   | / Bao Bakery | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | 12abc $2.00 | Auto Bao Tags | Plus1     |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |

  @Admin @TC_Admin_check_tag_product
  Scenario: Check the attached tag is removed automatically when the expiry date comes
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin create new product with general info
      | brandName                 | productName               | status | isBeverage | containerType | allowRequestSamples | vendorCompany       | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand create product | auto bao create product 1 | Active | Yes        | Glass         | Yes                 | Auto vendor company | 0             | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microDescriptions | [blank]   |
    And Admin create new product with tags
      | tagName       | expiryDate  |
      | Auto Bao Tags | currentDate |
    And Admin create new product with state fees
      | stateFeeName   | stateFeeValue |
      | Auto state fee | 100           |
    And Admin confirm create new product
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  |
      | Active      | auto bao create product 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 0.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" |

    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |

    And Search the product by info then system show result
      | term    | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | [blank] | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |

    And Search the product by info then system show result
      | term    | productState | brandName                 | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | [blank] | [blank]      | Auto brand create product | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |

    And Search the product by info then system show result
      | term    | productState | brandName | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | [blank] | [blank]      | [blank]   | Auto vendor company | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |

    And Search the product by info then system show result
      | term    | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | [blank] | [blank]      | [blank]   | [blank]       | Bread       | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |
    And Search the product by info then system show result
      | term    | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | [blank] | [blank]      | [blank]   | [blank]       | [blank]     | Bulk        | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |
    And Search the product by info then system show result
      | term    | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | [blank] | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | Sampleable | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |
    And Search the product by info then system show result
      | term    | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags          |
      | [blank] | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | Auto Bao Tags |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |
    And Search the product by info then system show result
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | [blank] |

    And Admin go to detail of product "auto bao create product 1"
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | stateFee             | tags          | expiryTag   |
      | Active      | auto bao create product 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 0.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | Auto state fee $1.00 | Auto Bao Tags | currentDate |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Check product not have SKU
    And Add new SKU
      | skuName                     | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto 1 check create product | [blank] | [blank] | 12        | 123456789098      | no                    | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | [blank]          | 10              | [blank]         | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with region specific
      | regionName           | casePrice | msrpunit | availability | arriving |
      | Florida Express      | 12        | 15       | In stock     | [blank]  |
      | Mid Atlantic Express | 12        | 15       | Out of stock | [blank]  |
#      | Pod Direct Northeast | 12        | 15       | Launching soon | currentDate |
    And Click Create
    And Admin check message of sku "auto 1 check create product" is "Variant have been saved successfully !!"

    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn     | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | Florida Express | [blank] |
#    And Admin check list of product after searching
#      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
#      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | PDN         | Auto Bao Tags |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | MA          | Auto Bao Tags |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | FL          | Auto Bao Tags |

    And Admin go to detail of product "auto bao create product 1"

    And Admin edit info of product
      | name                      | sampleable | packageSize         | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type       | microDescription |
      | auto bao create product 2 | Yes        | Individual servings | 12         | 12        | 12         | 12         | 12        | 12         | 12         | 12       | lbs          | 1             | Bakery     | Bao Bakery | microDescription |
    And Admin edit pallet configuration of product
      | casePerPallet | casePerLayer | layerPerPallet |
      | 12            | 12           | 12             |
    And Admin edit master case configuration of product
      | masterCartonPallet | casePerMasterCarton | masterCaseWeight | masterLength | masterWidth | masterHeight |
      | 12                 | 12                  | 12               | 12           | 12          | 12           |
    And Admin edit state fees of product
      | oldStateFee    | newStateFee | value |
      | Auto state fee | 12abc       | 200   |
    And Admin edit tags of product
      | tag           | expireDate |
      | Auto Bao Tags | Plus1      |
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn     | tags    |
      | auto bao create product 2 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | Florida Express | [blank] |
#    And Admin check list of product after searching
#      | term                      | brandName                 | productType | availableIn | tags    |
#      | auto bao create product 2 | Auto brand create product | Bao Bakery  | PDN         | [blank] |
    And Admin check list of product after searching
      | term                      | brandName                 | productType | availableIn | tags    |
      | auto bao create product 2 | Auto brand create product | Bao Bakery  | MA          | [blank] |
    And Admin check list of product after searching
      | term                      | brandName                 | productType | availableIn | tags    |
      | auto bao create product 2 | Auto brand create product | Bao Bakery  | FL          | [blank] |
    And Admin verify list tags of product on all product page
      | tag           | expireDate |
      | Auto Bao Tags | Plus1      |
    And Admin go to detail of product "auto bao create product 2"
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize         | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | stateFee    | tags          | expiryTag |
      | Active      | auto bao create product 2 | Auto brand create product | Auto vendor company | No         | Individual servings | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 12.0 lbs | 1.00%         | Bakery   | / Bao Bakery | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | 12abc $2.00 | Auto Bao Tags | Plus1     |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |

  @Admin @TC_Admin_check_validate_when_create_product
  Scenario: Admin check validate create product
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin go to create new product page
    And Admin confirm create new product
    And Admin check message is showing of fields when create product
      | field                       | message                                                   |
      | Brand                       | Please select a specific brand for the new product        |
      | Product name                | Please enter new product name                             |
      | category                    | Please select product category & type                     |
      | Unit L" × Unit W" × Unit H" | Please specific full unit Length" × Width" × Height".     |
      | Case L" × Case W" × Case H" | Please specific full case Length" × Width" × Height".     |
      | Case weight                 | Please enter case weight                                  |
      | Package size                | Please select a specific package size for the new product |
      | Unit Size                   | Please select a specific unit size for the new product    |
    And Admin Clear field "Cases per Pallet" when create product
    And Admin Clear field "Cases per layer" when create product
    And Admin Clear field "Layers per full pallet" when create product
    And Admin Clear field "Master Cartons per Pallet" when create product
    And Admin Clear field "Cases per Master Carton" when create product
    And Admin Clear field "Master carton L" when create product
    And Admin Clear field "Master carton Weight" when create product
    And Admin confirm create new product

    And Admin check message is showing of fields when create product
      | field                      | message                                               |
#      | Cases per Pallet          | Please enter cases per pallet                         |
      | Cases per layer            | Please enter cases per layer                          |
      | Layers per full pallet     | Please enter layer per full pallet                    |
      | Master Cartons per Pallet  | Please enter master cartons per pallet                |
      | Cases per Master Carton    | Please enter cases per master carton                  |
      | Master carton L" × W" × H" | Please specific full case Length" × Width" × Height". |
#      | Master Case Weight        | Please enter master case weight                       |
    And Admin create new product with general info
      | brandName                 | productName | status | allowRequestSamples | vendorCompany       | additionalFee | isBeverage | containerType | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand create product | [blank]     | Active | Yes                 | Auto vendor company | 0             | [blank]    | [blank]       | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microDescriptions | [blank]   |
    And Admin confirm create new product
    And Admin verify alert when create product
      | Name can't be blank |
    And Admin create new product with general info
      | brandName                 | productName             | status | allowRequestSamples | vendorCompany       | isBeverage | containerType | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand create product | auto bao create product | Active | Yes                 | Auto vendor company | [blank]    | [blank]       | 0             | Dairy    | Bread | [blank] | 0          | 0         | 0          | 0          | 0         | 0          | 0          | Bulk        | 0        | 0              | 0             | 0                   | 0                      | 0                    | 0                          | 0                         | 0                          | 0                | microDescriptions | [blank]   |
    And Admin confirm create new product
    And Admin check message is showing of fields when create product
      | field       | message                         |
      | Case weight | Please enter valid cases weight |
    And Admin create new product with general info
      | brandName                 | productName             | status | allowRequestSamples | isBeverage | containerType | vendorCompany       | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions |
      | Auto brand create product | auto bao create product | Active | Yes                 | [blank]    | [blank]       | Auto vendor company | -1            | Dairy    | Bread | [blank] | -1         | -1        | -1         | -1         | -1        | -1         | -1         | Bulk        | -1       | -1             | -1            | -1                  | -1                     | -1                   | -1                         | -1                        | -1                         | -1               | microDescriptions |
    And Admin confirm create new product
    And Admin check message is showing of fields when create product
      | field                       | message                                      |
      | Unit L" × Unit W" × Unit H" | Must be positive numbers                     |
      | Case L" × Case W" × Case H" | Must be positive numbers                     |
      | Case weight                 | Please enter valid cases weight              |
      | Cases per Pallet            | Please enter valid cases per pallet          |
      | Unit Size                   | Must be positive number                      |
      | Layers per full pallet      | Please enter valid layer per full pallet     |
      | Master Cartons per Pallet   | Please enter valid master cartons per pallet |
      | Cases per Master Carton     | Please enter valid cases per master carton   |
      | Master carton L" × W" × H"  | Must be positive numbers                     |
      | Master carton Weight        | Please enter valid master carton weight      |
    And Admin check Unit size type "g"
    And Admin check Unit size type "oz."
    And Admin check Unit size type "lbs"
    And Admin check Unit size type "kg"
    And Admin check Unit size type "fl. oz."
    And Admin check Unit size type "ml"
    And Admin check Unit size type "l"
    And Admin check Unit size type "gal"

  @Admin @TC_Admin_check_help_text_when_create_product @AD_Products_35
  Scenario: Admin check help text create product
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin go to create new product page
    And Admin check help text tooltip1
      | field                | text                                                                                                                                                     |
      | Pallet Configuration | A.K.A TI-HI. The TI is cases per layer and the HI is the number of layers to a full pallet of the product. If you do not ship via pallet, please enter 0 |
    And Admin check help text tooltip1
      | field                       | text                                                                                                                                                        |
      | Master carton configuration | This is referring to the outer shipping carton which contains your sellable retail cases of the same SKU. If not shipping in master cartons, please enter 0 |
    And Admin create new product with general info
      | brandName                 | productName               | status | isBeverage | containerType | allowRequestSamples | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand create product | auto bao create product 1 | Active | Yes        | Glass         | Yes                 | 0             | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microDescriptions | [blank]   |
    And Admin check Bottle Deposit Label
    And Admin upload Bottle Deposit Label "10MBgreater.jpg"
    And Admin verify content of alert
      | Maximum file size exceeded. |
    And Admin upload Bottle Deposit Label "test.docx"
    And Admin confirm create new product
    And Admin verify content of alert
      | Bottle deposit label image attachment content type is invalid |

  @Admin @AD_Products_54
  Scenario: Admin check help text create product
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin go to create new product page
    And Admin create new product with general info
      | brandName                 | productName               | status | isBeverage | containerType | allowRequestSamples | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand create product | auto bao create product 1 | Active | No         | [blank]       | Yes                 | 0             | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microDescriptions | [blank]   |
    And Check any button "not" showing on screen
      | Add a state fee |

  @Admin @TC_Admin_check_validate_when_create_product2
  Scenario: Check validation of Additional fee field on the General section
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin create new product with general info
      | brandName                 | productName             | status | allowRequestSamples | isBeverage | containerType | vendorCompany       | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand create product | auto bao create product | Active | Yes                 | [blank]    | [blank]       | Auto vendor company | 101           | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microDescriptions | [blank]   |
    And Admin check Unit size type "g"
    And Admin check Unit size type "oz."
    And Admin check Unit size type "lbs"
    And Admin check Unit size type "kg"
    And Admin check Unit size type "fl. oz."
    And Admin check Unit size type "ml"
    And Admin check Unit size type "l"
    And Admin check Unit size type "gal"
    And Admin confirm create new product
    And Admin check message is showing of fields when create product
      | field          | message                                        |
      | Additional fee | Additional fee must be equal or less than 100% |

  @Admin @TC_Admin_check_validate_when_create_product3 @AD_Products_60
  Scenario: Check validation of State fee field
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin create new product with general info
      | brandName                 | productName             | status | allowRequestSamples | isBeverage | containerType | vendorCompany       | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand create product | auto bao create product | Active | Yes                 | Yes        | [blank]       | Auto vendor company | 101           | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microDescriptions | [blank]   |
    And Admin create new product with state fees
      | stateFeeName   | stateFeeValue |
      | Auto state fee | 100           |
    And Admin check state fees added
      | Auto state fee |
    And Admin confirm create new product
    And Admin check alert message
      | State product fees address state must exist |
    #Đang có bug
#    And Admin check message is showing of fields when create product
#      | field          | message                                   |
#      | Additional fee | State fee must be equal or less than 100% |

  @Admin @TC_Admin_check_validate_when_create_product4
  Scenario: Check validation of Micro-description field
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin create new product with general info
      | brandName                 | productName             | status | allowRequestSamples | isBeverage | containerType | vendorCompany       | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions                                                        | stateFees |
      | Auto brand create product | auto bao create product | Active | Yes                 | [blank]    | [blank]       | Auto vendor company | 0             | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | 2. ~!@#$%$%^&*()_+2. ~!@#$%$%^&*()_+2. ~!@#$%$%^&*()_+2. ~!@#$%$%^&*()_+ | [blank]   |

    And Admin check message is showing of fields when create product
      | field              | message                                          |
      | Micro-descriptions | Micro-description should less than 70 characters |

  @Admin @TC_Admin_check_validate_when_create_product5 @AD_Products_110
  Scenario: Check validation of Region MOQ field
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin create new product with general info
      | brandName                 | productName             | status | allowRequestSamples | isBeverage | containerType | vendorCompany       | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand create product | auto bao create product | Active | Yes                 | [blank]    | [blank]       | Auto vendor company | 0             | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microdess         | [blank]   |
    And Admin create new product with Region MOQs
      | region             | value |
#      | Chicagoland Express            | 0     |
#      | New York Express               | 0     |
#      | Dallas Express                  | 0     |
#      | Florida Express                | 0     |
#      | North California Express       | 0     |
#      | Mid Atlantic Express           | 0     |
#      | South California Express       | 0     |
#      | Pod Direct Northeast           | 0     |
#      | Pod Direct West                | 0     |
      | Pod Direct Central | 0     |
      | Pod Direct East    | 0     |
      | Pod Direct West    | 0     |
    And Admin check Region MOQs error
      | region             | message                                  |
#      | Chicagoland Express            | Please enter a valid MOQ for this region |
#      | New York Express               | Please enter a valid MOQ for this region |
#      | Dallas Express                  | Please enter a valid MOQ for this region |
#      | Florida Express                | Please enter a valid MOQ for this region |
#      | North California Express       | Please enter a valid MOQ for this region |
#      | South California Express       | Please enter a valid MOQ for this region |
#      | Mid Atlantic Express           | Please enter a valid MOQ for this region |
#      | Pod Direct Northeast           | Please enter a valid MOQ for this region |
#      | Pod Direct West                | Please enter a valid MOQ for this region |
      | Pod Direct Central | Please enter a valid MOQ for this region |
      | Pod Direct East    | Please enter a valid MOQ for this region |
      | Pod Direct West    | Please enter a valid MOQ for this region |

  @Admin @TC_Admin_check_create_product_success_moq
  Scenario: Check display of new created product in the product list
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin create new product with general info
      | brandName                 | productName               | status | allowRequestSamples | isBeverage | containerType | vendorCompany       | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand create product | auto bao create product 1 | Active | Yes                 | Yes        | Glass         | Auto vendor company | 1             | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microDescriptions | [blank]   |
    And Admin create new product with tags
      | tagName       | expiryDate  |
      | Auto Bao Tags | currentDate |
    And Admin create new product with state fees
      | stateFeeName   | stateFeeValue |
      | Auto state fee | 100           |
    And Admin create new product with Region MOQs
      | region             | value |
#      | Chicagoland Express            | 2     |
#      | New York Express               | 2     |
#      | Dallas Express                  | 2     |
#      | Florida Express                | 2     |
#      | North California Express       | 2     |
#      | Mid Atlantic Express           | 2     |
#      | South California Express       | 2     |
      | Pod Direct Central | 2     |
      | Pod Direct East    | 2     |
      | Pod Direct West    | 2     |
#      | Pod Direct Northeast           | 2     |
#      | Pod Direct West                | 2     |
    And Admin confirm create new product
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  |
      | Active      | auto bao create product 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" |
    And Admin regional MOQS
      | east | central | west |
      | 2    | 2       | 2    |

    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |

  @Admin @TC_Admin_check_create_product_success_mov
  Scenario: Check display of new created product in the product list
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin create new product with general info
      | brandName      | productName               | status | allowRequestSamples | additionalFee | isBeverage | containerType | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand mov | auto bao create product 1 | Active | Yes                 | 1             | [blank]    | [blank]       | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microDescriptions | [blank]   |
    And Admin create new product with tags
      | tagName       | expiryDate  |
      | Auto Bao Tags | currentDate |
    And Admin create new product with state fees
      | stateFeeName   | stateFeeValue |
      | Auto state fee | 100           |
    And Admin check have no Region MOQs
    And Admin confirm create new product
    And Admin check product detail
      | stateStatus | productName               | brand          | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  |
      | Active      | auto bao create product 1 | Auto brand mov | Auto vender company mov | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" |

    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName      | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | Auto brand mov | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName      | vendorCompany           | productType | packageSize | sampleable | availableIn | tags          |
      | auto bao create product 1 | Active       | Auto brand mov | Auto vender company mov | Bread       | Bulk        | Sampleable | [blank]     | Auto Bao Tags |
    And Admin go to product detail from just searched
    And Admin check product detail
      | stateStatus | productName               | brand          | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  |
      | Active      | auto bao create product 1 | Auto brand mov | Auto vender company mov | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" |

  @Admin @TC_Admin_check_create_product_check_state_fee @AD_Products_86
  Scenario: Check adding, remove a state fee
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin create new product with general info
      | brandName      | productName               | status | allowRequestSamples | isBeverage | containerType | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand mov | auto bao create product 1 | Active | Yes                 | Yes        | Glass         | 1             | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microDescriptions | [blank]   |
    And Admin create new product with state fees
      | stateFeeName   | stateFeeValue |
      | Auto state fee | 100           |
      | 12abc          | 100           |
      | autoTax        | 100           |

    And Admin remove state fee when create product
      | stateFeeName   | stateFeeValue |
      | Auto state fee | 100           |
      | 12abc          | 100           |
    And Admin create new product with state fees
      | stateFeeName   | stateFeeValue |
      | Auto state fee | 100           |

    And Admin confirm create new product
    And Admin check product detail
      | stateStatus | productName               | brand          | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | stateFee      |
      | Active      | auto bao create product 1 | Auto brand mov | Auto vender company mov | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | autoTax $1.00 |
    And Admin check product detail
      | stateStatus | productName               | brand          | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | stateFee             |
      | Active      | auto bao create product 1 | Auto brand mov | Auto vender company mov | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | Auto state fee $1.00 |
    And Admin edit state fees of product
      | oldStateFee    | newStateFee | value |
      | Auto state fee | 12abc       | 200   |
    And Admin add state fees of product
      | stateFee | value |
      | Taxes 1  | 100   |
    And Admin check product detail
      | stateStatus | productName               | brand          | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | stateFee    |
      | Active      | auto bao create product 1 | Auto brand mov | Auto vender company mov | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | 12abc $2.00 |
    And Admin check product detail
      | stateStatus | productName               | brand          | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | stateFee      |
      | Active      | auto bao create product 1 | Auto brand mov | Auto vender company mov | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | autoTax $1.00 |
    And Admin check product detail
      | stateStatus | productName               | brand          | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | stateFee      |
      | Active      | auto bao create product 1 | Auto brand mov | Auto vender company mov | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | Taxes 1 $1.00 |
#    And Admin add state fees of product
#      | stateFee | value |
#      | Taxes 1  | 100   |
#    And Admin verify alert when create product
#      | State product fees state fee name duplicated state fee |
#    And Click on tooltip button "Cancel"
    And Admin add state fees of product
      | stateFee | value   |
      | [blank]  | [blank] |
    And Admin verify alert when create product
      | State product fees address state must exist |
    And Click on tooltip button "Cancel"
    And Admin check product detail
      | stateStatus | productName               | brand          | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | stateFee    |
      | Active      | auto bao create product 1 | Auto brand mov | Auto vender company mov | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | 12abc $2.00 |
    And Admin check product detail
      | stateStatus | productName               | brand          | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | stateFee      |
      | Active      | auto bao create product 1 | Auto brand mov | Auto vender company mov | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | autoTax $1.00 |
    And Admin check product detail
      | stateStatus | productName               | brand          | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | stateFee      |
      | Active      | auto bao create product 1 | Auto brand mov | Auto vender company mov | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | Taxes 1 $1.00 |

  @Admin @AD_Products_87
  Scenario: Edit state fees
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin create new product with general info
      | brandName      | productName               | status | allowRequestSamples | isBeverage | containerType | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand mov | auto bao create product 1 | Active | Yes                 | No         | [blank]       | 1             | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microDescriptions | [blank]   |

    And Admin confirm create new product
    And Admin check product detail
      | stateStatus | productName               | brand          | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | isBeverage |
      | Active      | auto bao create product 1 | Auto brand mov | Auto vender company mov | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | No         |
    And Admin edit Is beverage
      | isBeverage | containerType |
      | Yes        | [blank]       |
    And Click on tooltip button "Update"
    And Admin verify alert when create product
      | Container type can't be blank |
    And Click on tooltip button "Cancel"
    And Admin edit Is beverage
      | isBeverage | containerType |
      | Yes        | Glass         |
    And Click on tooltip button "Update"
    And Admin check product detail
      | stateStatus | productName               | brand          | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | isBeverage | containerType | stateFee |
      | Active      | auto bao create product 1 | Auto brand mov | Auto vender company mov | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | Yes        | Glass         | No fee   |
    And Admin add state fees of product
      | stateFee | value |
      | Taxes 1  | 100   |
    And Admin check product detail
      | stateStatus | productName               | brand          | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  | isBeverage | containerType | stateFee      |
      | Active      | auto bao create product 1 | Auto brand mov | Auto vender company mov | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 1.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" | Yes        | Glass         | Taxes 1 $1.00 |

  @Admin @TC_Admin_check_delete_product1
  Scenario: Check the Delete function when delete a product/SKU successfully - Product has not any SKU
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |

    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bao Bakery  | Bulk        | Sampleable | [blank]     | [blank] |
    And Admin delete product "auto bao create product 1" from list product
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check no data found

  @Admin @TC_Admin_check_delete_product2
  Scenario: Check the Delete function when delete a product/SKU successfully - Product has any inactive SKU doesn’t belong to any orders/sample request
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                    | brand_id |
      | auto bao create product | 3018     |
    And Info of Region
      | region              | id | state    | availability | casePrice | msrp |
      | Chicagoland Express | 26 | inactive | in_stock     | 1000      | 1000 |
    And Admin create SKU from admin with name "sku random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                    | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                    | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product | Active       | Auto brand create product | Auto vendor company | Bao Bakery  | Bulk        | Sampleable | [blank]     | [blank] |
    And Admin delete product "auto bao create product" from list product
    And Search the product by info then system show result
      | term                    | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check no data found

  @Admin @TC_Admin_check_delete_product @EDIT_PRODUCT_01_11
  Scenario: If the product has any SKU doesn’t belong to any orders/sample request
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU from admin with name "sku random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | Auto brand create product | Auto vendor company | Bao Bakery  | Bulk        | Sampleable | [blank]     | [blank] |
    And Admin delete product "auto bao create product 1" from list product
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
#    And Admin check no data found

  @Admin @TC_Admin_check_delete_product_2
  Scenario: Check the Delete function when delete a product/SKU successfully if product has SKU belong to deleted order
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU from admin with name "sku random" of product ""
    # Create Order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer53@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | [blank]   | [blank] | 1        |
    And Checkout cart with payment by "invoice" by API
    # Delete order
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
    # Verify
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin delete product "auto bao create product 1" from list product
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check no data found

  @Admin @TC_Admin_check_duplicate_product1
  Scenario: Check the Duplicate a product has many SKU function on product list
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Pod Direct West | 54 | active | in_stock     | 1000      | 1000 |
    And Info of Prop65
      | containChemical | firstName | lastName | email                           | skuId   | vendorCompanyId |
      | false           | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | [blank] | 1847            |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    And Info of Region
      | region                   | id | state    | availability | casePrice | msrp |
      | North California Express | 25 | inactive | in_stock     | 1000      | 1000 |
    And Info of Prop65
      | containChemical | firstName | lastName | email                           | skuId   | vendorCompanyId |
      | false           | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | [blank] | 1847            |
    And Admin create a "inactive" SKU from admin with name "sku 2 random" of product ""
    And Info of Region
      | region                   | id | state  | availability | casePrice | msrp |
      | South California Express | 51 | active | in_stock     | 1000      | 1000 |
    And Info of Prop65
      | containChemical | firstName | lastName | email                           | skuId   | vendorCompanyId |
      | false           | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | [blank] | 1847            |
    And Admin create a "draft" SKU from admin with name "sku 3 random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin click "Cancel" duplicate with images product "auto bao create product 1"
    And Search the product by info then system show result
      | term                                  | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of auto bao create product 1 (1) | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check no data found
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin click "Yes" duplicate with images product "auto bao create product 1"
    And Search the product by info then system show result
      | term                                  | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of auto bao create product 1 (1) | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                                  | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of auto bao create product 1 (1) | Active       | Auto brand create product | Auto vendor company | Bao Bakery  | Bulk        | Sampleable | [blank]     | [blank] |
    And Admin go to product detail from just searched
    And Admin check product detail
      | stateStatus | productName                           | brand                     | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | Copy of auto bao create product 1 (1) | Auto brand create product | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | [blank]    |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Check product not have SKU
    And Admin check SKU info on tab "draft"
      | skuName      | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | sku random   | 123123123123 | [blank] | Draft  | 1 per case  | not check | PDW     |
      | sku 2 random | 123123123123 | [blank] | Draft  | 1 per case  | not check | SF      |
      | sku 3 random | 123123123123 | [blank] | Draft  | 1 per case  | not check | LA      |

    And Admin go to SKU detail "sku random"
    And Admin check have no Prop65 info on general SKU
    And Admin go back with button
    And Go to draft SKU tab
    And Admin go to SKU detail "sku 2 random"
    And Admin check have no Prop65 info on general SKU
    And Admin go back with button
    And Go to draft SKU tab
    And Admin go to SKU detail "sku 3 random"
    And Admin check have no Prop65 info on general SKU
    And Admin go back with button
    And Admin go back with button
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin click "No" duplicate with images product "auto bao create product 1"
    And Search the product by info then system show result
      | term                                  | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of auto bao create product 1 (2) | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                                  | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of auto bao create product 1 (2) | Active       | Auto brand create product | Auto vendor company | Bao Bakery  | Bulk        | Sampleable | [blank]     | [blank] |
    And Admin go to detail of product "Copy of auto bao create product 1 (2)"
    And Admin check product detail
      | stateStatus | productName                           | brand                     | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | Copy of auto bao create product 1 (2) | Auto brand create product | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | [blank]    |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Check product not have SKU

    And Admin go back with button
    And Search the product by info then system show result
      | term                                  | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of auto bao create product 1 (1) | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin click "Yes" duplicate with images product "Copy of auto bao create product 1 (1)"
    And Search the product by info then system show result
      | term                                              | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of Copy of auto bao create product 1 (1) (1) | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                                              | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of Copy of auto bao create product 1 (1) (1) | Active       | Auto brand create product | Auto vendor company | Bao Bakery  | Bulk        | Sampleable | [blank]     | [blank] |
    And Admin go to detail of product "Copy of Copy of auto bao create product 1 (1) (1)"
    And Admin check product detail
      | stateStatus | productName                                       | brand                     | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | Copy of Copy of auto bao create product 1 (1) (1) | Auto brand create product | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | [blank]    |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Check product not have SKU

  @Admin @TC_Admin_check_duplicate_product2
  Scenario: Check the Duplicate a product has many SKU function on product detail
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Pod Direct West | 54 | active | in_stock     | 1000      | 1000 |
    And Info of Prop65
      | containChemical | firstName | lastName | email                           | skuId   | vendorCompanyId |
      | false           | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | [blank] | 1847            |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    And Info of Region
      | region                   | id | state    | availability | casePrice | msrp |
      | North California Express | 25 | inactive | in_stock     | 1000      | 1000 |
    And Info of Prop65
      | containChemical | firstName | lastName | email                           | skuId   | vendorCompanyId |
      | false           | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | [blank] | 1847            |
    And Admin create a "inactive" SKU from admin with name "sku 2 random" of product ""
    And Info of Region
      | region                   | id | state | availability | casePrice | msrp |
      | South California Express | 51 | draft | in_stock     | 1000      | 1000 |
    And Info of Prop65
      | containChemical | firstName | lastName | email                           | skuId   | vendorCompanyId |
      | false           | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | [blank] | 1847            |
    And Admin create a "draft" SKU from admin with name "sku 3 random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin "Cancel" duplicate product on detail

    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | auto bao create product 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | [blank]    |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Admin "Yes" duplicate product on detail
    And Admin verify content of alert
      | A duplicate is successfully created. Click |
    And Admin go back with button
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                                  | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of auto bao create product 1 (1) | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                                  | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of auto bao create product 1 (1) | Active       | Auto brand create product | Auto vendor company | Bao Bakery  | Bulk        | Sampleable | [blank]     | [blank] |
    And Admin go to detail of product "Copy of auto bao create product 1 (1)"
    And Admin check product detail
      | stateStatus | productName                           | brand                     | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | Copy of auto bao create product 1 (1) | Auto brand create product | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | [blank]    |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Check product not have SKU
    And Admin check SKU info on tab "draft"
      | skuName              | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Copy of sku random   | 123123123123 | [blank] | Draft  | 1 per case  | not check | PDW     |
      | Copy of sku 2 random | 123123123123 | [blank] | Draft  | 1 per case  | not check | SF      |
      | Copy of sku 3 random | 123123123123 | [blank] | Draft  | 1 per case  | not check | LA      |
    And Admin go back with button
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin "Yes" duplicate product on detail
    And Admin verify content of alert
      | A duplicate is successfully created. Click |
    And Admin go back with button
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                                              | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of Copy of auto bao create product 1 (1) (1) | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                                              | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of Copy of auto bao create product 1 (1) (1) | Active       | Auto brand create product | Auto vendor company | Bao Bakery  | Bulk        | Sampleable | [blank]     | [blank] |
    And Admin go to detail of product "Copy of Copy of auto bao create product 1 (1) (1)"
    And Admin check product detail
      | stateStatus | productName                                       | brand                     | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | Copy of Copy of auto bao create product 1 (1) (1) | Auto brand create product | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | [blank]    |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Check product not have SKU
    And Admin check SKU info on tab "draft"
      | skuName              | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Copy of sku random   | 123123123123 | [blank] | Draft  | 1 per case  | not check | PDW     |
      | Copy of sku 2 random | 123123123123 | [blank] | Draft  | 1 per case  | not check | SF      |
      | Copy of sku 3 random | 123123123123 | [blank] | Draft  | 1 per case  | not check | LA      |
    And Admin go to SKU detail "Copy of sku random"
    And Admin edit field general of SKU
      | field | value  |
      | State | Active |
    And Click Create
    And Admin check Prop65 popup
      | product                                           | firstName | lastName | email                           | company             | today       |
      | Copy of Copy of auto bao create product 1 (1) (1) | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | Auto vendor company | currentDate |
    And Admin choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
    And Admin submit Prop65
    And Admin accept activating SKU
    And Admin check Prop65 info on general SKU
      | type                                                                       | firstName | lastName | email                           | date        |
      | The referenced product does not contain any chemicals on the Prop. 65 List | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | currentDate |
    And Admin go back with button
    And Admin check SKU info on tab "active"
      | skuName            | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Copy of sku random | 123123123123 | [blank] | Active | 1 per case  | not check | PDW     |

  @Admin @TC_Admin_check_duplicate_product3
  Scenario: Check the Duplicate a product has many SKU function with No image
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Pod Direct West | 54 | active | in_stock     | 1000      | 1000 |
    And Info of Prop65
      | containChemical | firstName | lastName | email                           | skuId   | vendorCompanyId |
      | false           | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | [blank] | 1847            |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin "No" duplicate product on detail
    And Admin verify content of alert
      | A duplicate is successfully created. Click |

#    And Admin go back with button
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                                  | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of auto bao create product 1 (1) | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                                  | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of auto bao create product 1 (1) | Active       | Auto brand create product | Auto vendor company | Bao Bakery  | Bulk        | Sampleable | [blank]     | [blank] |
    And Admin go to detail of product "Copy of auto bao create product 1 (1)"
    And Admin check SKU info on tab "draft"
      | skuName            | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Copy of sku random | 123123123123 | [blank] | Draft  | 1 per case  | not check | PDW     |

    And Admin go to SKU detail "Copy of sku random"
    And Admin check have no images on SKU

    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |

    And Admin click "No" duplicate with images product "auto bao create product 1"

    And Admin verify content of alert
      | A duplicate is successfully created. Click |
    And Search the product by info then system show result
      | term                                  | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of auto bao create product 1 (2) | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                                  | productState | brandName                 | vendorCompany       | productType | packageSize | sampleable | availableIn | tags    |
      | Copy of auto bao create product 1 (2) | Active       | Auto brand create product | Auto vendor company | Bao Bakery  | Bulk        | Sampleable | [blank]     | [blank] |
    And Admin go to detail of product "Copy of auto bao create product 1 (2)"
    And Admin check SKU info on tab "draft"
      | skuName            | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Copy of sku random | 123123123123 | [blank] | Draft  | 1 per case  | not check | PDW     |
    And Admin go to SKU detail "Copy of sku random"
    And Admin check have no images on SKU

  @Admin @TC_Admin_check_delete_product @ALL_PRODUCTS_LIST_23
  Scenario: If the product has only active SKUs and they belong to any orders/sample request/pre-order
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random 20" of product ""
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin delete product "auto bao create product 1" from list product
    And Admin verify content of alert
      | This entity cannot be deleted since it is associated with another data (e.g. Order, Inventory, Claim, Promotion, ect) |

  @Admin @TC_Admin_check_delete_product_in_edit_fail
  Scenario: Check the Delete function when delete a product/SKU failed in edit page
#    Given BAO_ADMIN2 login web admin by api
#      | email            | password  |
#      | bao2@podfoods.co | 12345678a |
#    And Admin delete order by sku of product "auto bao create product 1" by api
#    And Admin search product name "auto bao create product" by api
#    And Admin delete product name "auto bao create product" by api
#
#    And Create product by api with file "CreateProduct.json" and info
#      | name           | brand_id |
#      | auto bao create product 1 | 3087     |
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
#    And Admin create a "active" SKU from admin with name "sku random 20" of product ""
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api26    | create by api      | 1        | false     | [blank]          |
#    Then Admin create order by API
#      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
#      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 47               | 10022 | true          | [blank]    | [blank]            | [blank]            |
#    And Admin add SKUs sample request by API
#      | product_variant_id | variants_region_id |
#      | [blank]            | [blank]            |
#    And Admin add products sample request by API
#      | product_ids |
#      | [blank]     |
#    And Admin add buyer for sample request by API
#      | buyer_id |
#      | 3314     |
#    And Admin create sample request by API2
#      | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
#      | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar

    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin delete product from product detail
    And Admin verify content of alert
      | This entity cannot be deleted since it is associated with another data (e.g. Order, Inventory, Claim, Promotion, ect) |
    And Admin go back with button
    # Product with sample request

    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin delete product from product detail
    And Admin verify content of alert
      | This entity cannot be deleted since it is associated with another data (e.g. Order, Inventory, Claim, Promotion, ect) |
    And Admin go back with button

    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin delete product from product detail
    And Admin verify content of alert
      | This entity cannot be deleted since it is associated with another data (e.g. Order, Inventory, Claim, Promotion, ect) |
    And Admin go back with button

  @Admin @TC_Admin_check_validate_edit_product
  Scenario: Admin validate edit product
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |

    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin create new product with general info
      | brandName                 | productName               | status | allowRequestSamples | isBeverage | containerType | vendorCompany       | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions | stateFees |
      | Auto brand create product | auto bao create product 1 | Active | Yes                 | Yes        | Glass         | Auto vendor company | 0             | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 12             | 12            | 12                  | 12                     | 12                   | 12                         | 12                        | 12                         | 12               | microDescriptions | [blank]   |
    And Admin create new product with tags
      | tagName       | expiryDate  |
      | Auto Bao Tags | currentDate |
    And Admin create new product with state fees
      | stateFeeName   | stateFeeValue |
      | Auto state fee | 100           |
    And Admin confirm create new product
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  |
      | Active      | auto bao create product 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 0.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" |

    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"

    And Admin edit info of product
      | name  | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type    | microDescription |
      | blank | [blank]    | [blank]     | [blank]    | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | [blank]  | [blank]      | [blank]       | [blank]    | [blank] | [blank]          |
    And Admin verify content of alert
      | Name can't be blank |
    And Admin cancel edit field
    And Admin edit info of product
      | name    | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type    | microDescription |
      | [blank] | [blank]    | [blank]     | 0          | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | [blank]  | [blank]      | [blank]       | [blank]    | [blank] | [blank]          |
    And Admin verify content of alert
      | Size l must be greater than 0 |
#    And Admin cancel edit field
#    And Admin edit info of product
#      | name | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | microDescription |
#      | [blank]  | [blank]  | [blank]  | blank      | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  |
#    And Admin verify content of alert
#      | Size l must exist |
    And Admin cancel edit field
    And Admin edit info of product
      | name    | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type    | microDescription |
      | [blank] | [blank]    | [blank]     | [blank]    | 0         | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | [blank]  | [blank]      | [blank]       | [blank]    | [blank] | [blank]          |
    And Admin verify content of alert
      | Size w must be greater than 0 |
#    And Admin cancel edit field
#    And Admin edit info of product
#      | name | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee  | categories | type | microDescription |
#      | [blank]  | [blank]  | [blank]  | [blank]  | blank     | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  |
#    And Admin verify content of alert
#      | Size w must exist |
    And Admin cancel edit field
    And Admin edit info of product
      | name    | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type    | microDescription |
      | [blank] | [blank]    | [blank]     | [blank]    | [blank]   | 0          | [blank]    | [blank]   | [blank]    | [blank]    | [blank]  | [blank]      | [blank]       | [blank]    | [blank] | [blank]          |
    And Admin verify content of alert
      | Size h must be greater than 0 |
#    And Admin cancel edit field
#    And Admin edit info of product
#      | name | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type | microDescription |
#      | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | blank      | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  |
#    And Admin verify content of alert
#      | Size h must exist |
    And Admin cancel edit field
    And Admin edit info of product
      | name    | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type    | microDescription |
      | [blank] | [blank]    | [blank]     | -1         | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | [blank]  | [blank]      | [blank]       | [blank]    | [blank] | [blank]          |
    And Admin verify content of alert
      | Size l must be greater than 0 |
    And Admin cancel edit field
    And Admin edit info of product
      | name    | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type    | microDescription |
      | [blank] | [blank]    | [blank]     | [blank]    | -1        | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | [blank]  | [blank]      | [blank]       | [blank]    | [blank] | [blank]          |
    And Admin verify content of alert
      | Size w must be greater than 0 |
    And Admin cancel edit field
    And Admin edit info of product
      | name    | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type    | microDescription |
      | [blank] | [blank]    | [blank]     | [blank]    | [blank]   | -1         | [blank]    | [blank]   | [blank]    | [blank]    | [blank]  | [blank]      | [blank]       | [blank]    | [blank] | [blank]          |
    And Admin verify content of alert
      | Size h must be greater than 0 |
    And Admin cancel edit field
    And Admin edit info of product
      | name    | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type    | microDescription |
      | [blank] | [blank]    | [blank]     | [blank]    | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | 0          | [blank]  | [blank]      | [blank]       | [blank]    | [blank] | [blank]          |
    And Admin verify content of alert
      | Case weight must be greater than 0 |
    And Admin cancel edit field
    And Admin edit info of product
      | name    | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type    | microDescription |
      | [blank] | [blank]    | [blank]     | [blank]    | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | 0        | [blank]      | [blank]       | [blank]    | [blank] | [blank]          |
    And Admin verify content of alert
      | Volume must be greater than 0 |
    And Admin cancel edit field
    And Admin edit info of product
      | name    | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type    | microDescription |
      | [blank] | [blank]    | [blank]     | [blank]    | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | -1         | [blank]  | [blank]      | [blank]       | [blank]    | [blank] | [blank]          |
    And Admin verify content of alert
      | Case weight must be greater than 0 |
    And Admin cancel edit field
    And Admin edit info of product
      | name    | sampleable | packageSize | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | unitSize | unitSizeType | additionalFee | categories | type    | microDescription |
      | [blank] | [blank]    | [blank]     | [blank]    | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | -1       | [blank]      | [blank]       | [blank]    | [blank] | [blank]          |
    And Admin verify content of alert
      | Volume must be greater than 0 |
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  |
      | Active      | auto bao create product 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 0.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" |

    And Admin edit Region MOQs
      | region          | value |
      | Pod Direct East | 0     |
    And Admin verify content of alert
      | Products region moqs moq must be greater than or equal to 1 |
    And Click on tooltip button "Cancel"
    And Admin edit Region MOQs
      | region             | value |
      | Pod Direct Central | 0     |
    And Admin verify content of alert
      | Products region moqs moq must be greater than or equal to 1 |
    And Click on tooltip button "Cancel"
    And Admin edit Region MOQs
      | region          | value |
      | Pod Direct West | 0     |
    And Admin verify content of alert
      | Products region moqs moq must be greater than or equal to 1 |
    And Click on tooltip button "Cancel"
    And Admin edit Region MOQs
      | region             | value |
      | Pod Direct Central | -1    |
    And Admin verify content of alert
      | Products region moqs moq must be greater than or equal to 1 |
    And Click on tooltip button "Cancel"
    And Admin edit Region MOQs
      | region          | value |
      | Pod Direct East | -1    |
    And Admin verify content of alert
      | Products region moqs moq must be greater than or equal to 1 |
    And Click on tooltip button "Cancel"
    And Admin edit Region MOQs
      | region          | value |
      | Pod Direct West | -1    |
    And Admin verify content of alert
      | Products region moqs moq must be greater than or equal to 1 |
    And Click on tooltip button "Cancel"
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  |
      | Active      | auto bao create product 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 0.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" |
    And Admin regional MOQS
      | central | east | west |
      | 1       | 1    | 1    |

  @Admin @TC_Admin_add_sku2 @AD_Products_261
  Scenario: Admin add new sku with all field to product successfuly
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Change state of product id: "6627" to "active"
    And Admin delete order by sku of product "auto_product23" by api
    And Admin delete all sku in product id "6627" by api
    And Admin search product name "Auto admin create product43" by api
    And Admin delete product name "Auto admin create product43" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | Auto admin create product43 | 3018     |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto admin create product43 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "Auto admin create product43"
    And Admin check product detail
      | stateStatus | productName                 | brand                     | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | Auto admin create product43 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | 1"×1"×1"   |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Check product not have SKU

    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 1 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And Master Carton UPC
      | masterCarton  | masterCartonImage |
      | master Carton | UPCImage.png      |
    And with Nutrition labels
      | nutritionLabel      | nutritionLabelDescription |
      | nutritionImage.jpg  | [blank]                   |
      | nutritionLabel2.png | nutri des                 |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
      | Holidays      | Plus1      |
    And with region specific
      | regionName           | casePrice | msrpunit | availability | arriving |
      | Florida Express      | 12        | 15       | In stock     | [blank]  |
      | Mid Atlantic Express | 12        | 15       | Out of stock | [blank]  |
#      | Pod Direct Northeast | 12        | 15       | Launching soon | currentDate |

    And Go to "Buyer company-specific" tab
    And Admin search Buyer Company specific "Auto_BuyerCompany"
    And Admin choose regions and add to Buyer Company specific
      | regions                  |
      | North California Express |
    And with Buyer Company-specific
      | buyerCompany      | region                   | msrpUnit | casePrice | availability | startDate   | endDate | inventoryArrivingAt | category |
      | Auto_BuyerCompany | North California Express | 21       | 20        | In stock     | currentDate | Plus1   | [blank]             | [blank]  |
    And Click Create
    And Admin check message of sku "auto sku 1 check create product" is "Variant have been saved successfully !!"

#    And Admin go to SKU detail "auto sku 1 check create product"
    And Go to "Region-specific" tab
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | [blank]   | [blank]  | [blank]      | [blank]  |
    And Admin check region-specific of SKU
      | regionName           | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express  | 0         | 0        | Out of stock | [blank]  | [blank]        | [blank]  |
      | Florida Express      | 12        | 15       | In stock     | [blank]  | [blank]        | [blank]  |
      | Mid Atlantic Express | 12        | 15       | Out of stock | [blank]  | [blank]        | [blank]  |
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 12        | 15       | In stock     | [blank]  |
    And Click on button "Update"
    And Admin check message of sku "random sku edit sku api" is "Variant have been saved successfully !!"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName           | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express  | 12        | 15       | In stock     | [blank]  | [blank]        | [blank]  |
      | Florida Express      | 12        | 15       | In stock     | [blank]  | [blank]        | [blank]  |
      | Mid Atlantic Express | 12        | 15       | Out of stock | [blank]  | [blank]        | [blank]  |

    And Go to "Buyer company-specific" tab
    And Admin search Buyer Company specific "Auto_BuyerCompany"
    And Admin choose regions and add to Buyer Company specific
      | regions         |
      | Florida Express |
    And Admin check buyer company-specific of SKU
      | buyerCompany      | region          | msrpUnit | casePrice | availability | startDate | endDate | inventoryArrivingAt | category |
      | Auto_BuyerCompany | Florida Express | 0        | 0         | Out of stock | [blank]   | [blank] | [blank]             | [blank]  |

    And Go to "Store-specific" tab
    And with Store-specific
      | region              | store                  | msrp    | casePrice | availability | arriving | start   | end     | category |
      | Chicagoland Express | Auto Bao Store Express | [blank] | [blank]   | [blank]      | [blank]  | [blank] | [blank] | [blank]  |

    And Admin check store-specific of SKU
      | store                   | msrp | casePrice | availability | arriving | start   | end     | category |
      | Auto Bao Store Express1 | 0    | 0         | Out of stock | [blank]  | [blank] | [blank] | [blank]  |

  @Admin @TC_Admin_add_sku @ADD_NEW_SKU_43_78  @ADD_NEW_SKU_88_98
  Scenario: Admin add new sku with all field to product successfuly
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |

    And Change state of product id: "6627" to "active"
    And Admin delete order by sku of product "auto_product23" by api
    And Admin delete all sku in product id "6627" by api
#
#    And Create product by api with file "CreateProduct.json" and info
#      | name                        | brand_id |
#      | Auto admin create product43 | 3018     |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product23 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product23"
    And Admin check product detail
      | stateStatus | productName    | brand                     | vendorCompany       | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase  |
      | Active      | auto_product23 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 g    | 0.00%         | Dairy    | / Bread | 12            | 12           | 12             | 12           | 12         | 12.00 lbs        | 12"×12"×12" |
#    And Admin regional MOQS
#      | chicago | midAtlantic | florida | newYork | northCali | southCali | texas | midwest | northeast | southeast | southeastRockies | west |
#      | 1       | 1           | 1       | 1       | 1         | 1         | 1     | 1       | 1         | 1         | 1                | 1    |
    And Check product not have SKU

    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 1 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And Master Carton UPC
      | masterCarton  | masterCartonImage |
      | master Carton | UPCImage.png      |
    And with Nutrition labels
      | nutritionLabel      | nutritionLabelDescription |
      | nutritionImage.jpg  | [blank]                   |
      | nutritionLabel2.png | nutri des                 |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
      | Holidays      | Plus1      |
    And with region specific
      | regionName           | casePrice | msrpunit | availability | arriving |
      | Florida Express      | 12        | 15       | In stock     | [blank]  |
      | Mid Atlantic Express | 12        | 15       | Out of stock | [blank]  |
#      | Pod Direct Northeast | 12        | 15       | Launching soon | currentDate |

    And Go to "Buyer company-specific" tab
    And Admin search Buyer Company specific "Auto_BuyerCompany"
    And Admin choose regions and add to Buyer Company specific
      | regions                  |
      | North California Express |
    And with Buyer Company-specific
      | buyerCompany      | region                   | msrpUnit | casePrice | availability | startDate   | endDate | inventoryArrivingAt | category |
      | Auto_BuyerCompany | North California Express | 21       | 20        | In stock     | currentDate | Plus1   | [blank]             | [blank]  |
    And Click Create
    And Admin check message of sku "auto sku 1 check create product" is "Variant have been saved successfully !!"

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "auto_product23"
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Published SKUs
      | skuName                         | caseUnit      | unitUPC       | caseUPC      |
      | auto sku 1 check create product | 12 units/case | 1234567890981 | 123456789098 |
    And Vendor go to detail of SKU "auto sku 1 check create product"
    And Vendor check SKU general detail
      | skuName                         | ingredients                            | description | leadTime | unitCase | unitUPC       | caseUPC      | country | city     | state    | storage | retail | minTemperature | maxTemperature |
      | auto sku 1 check create product | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 1234567890981 | 123456789098 | U.S     | New York | New York | 30      | 10     | 10.0           | 30.0           |
    And Vendor check Region-Specific of SKU
      | regionName           | casePrice | msrpUnit | availability | arriving |
      | Florida Express      | 12        | 15       | In Stock     | [blank]  |
      | Mid Atlantic Express | 12        | 15       | Out of Stock | [blank]  |
#      | Pod Direct Northeast | 12        | 15       | Launching Soon | currentDate |
#    And Vendor go to "Buyer-Company-Specific" tab on SKU detail
    And Vendor check Buyer-Company Specific tap
      | buyerCompany      | region | msrpUnit | casePrice | availability | startDate | endDate |
      | Auto_BuyerCompany | SF     | 21       | 20        | In Stock     | [blank]   | [blank] |

#Check on catalog
    And Vendor search product "auto sku 1 check create product" on catalog
    And Vendor Go to product detail
      | productName    | unitDimension   | caseDimension   | unitSize | casePack |
      | auto_product23 | 12" x 12" x 12" | 12" x 12" x 12" | 8.0      | 12       |
    And Vendor check regions detail
      | region               | price | casePrice | msrp   | availability | moq     |
      | Florida Express      | $1.00 | $12.00    | $15.00 | In Stock     | [blank] |
      | Mid Atlantic Express | $1.00 | $12.00    | $15.00 | Out of Stock | [blank] |
#      | Pod Direct Northeast | $1.00 | $12.00    | $15.00 | Launching Soon | 1   |

#Check on buyer catalog
##    Verify on Head buyer of North california express
##    Giá ăn theo Buyer-Company specific
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer12@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto sku 1 check create product"
    And Search item and go to detail of first result
      | item                            | productName    | productBrand              | pricePerUnit | pricePerCase | availability |
      | auto sku 1 check create product | auto_product23 | Auto brand create product | $1.67        | $20.00       | In Stock     |
    And and check details information
      | brandLocation      | storage        | retail         | ingredients                             | temperatureRequirements |
      | New York, New York | 30 days Frozen | 10 days Frozen | Sodium Laureth Sulfate, Hexylene Glycol | 10.0 F - 30.0 F         |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP search item "auto sku 1 check create product" on catalog
    And "LP" choose filter by "Order by Popularity"
    And LP go to detail of product "auto_product23"
    And  LP check detail of product
      | product        | brand                     | available                           | unitUPC       | casePack          |
      | auto_product23 | Auto brand create product | Florida ExpressMid Atlantic Express | 1234567890981 | 12 units per case |

  @Admin @TC_Admin_check_fields_number_when_create_product
  Scenario: Admin check validate fields_number create product
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API

    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Admin go to create new product page

    And Admin increase field number tooltip 2 times
      | field          | text |
      | Additional fee | 2    |
    And Admin decrease field number tooltip 2 times
      | field          | text |
      | Additional fee | 0    |
    And Admin decrease field number tooltip 1 times
      | field                      | text |
      | Unit L" × Unit W" × Unit H | 0    |
    And Admin increase field number tooltip 1 times
      | field                      | text |
      | Unit L" × Unit W" × Unit H | 0.1  |
    And Admin decrease field number tooltip 1 times
      | field                      | text |
      | Case L" × Case W" × Case H | 0    |
    And Admin increase field number tooltip 1 times
      | field                      | text |
      | Case L" × Case W" × Case H | 0.1  |
    And Admin decrease field number tooltip 1 times
      | field       | text |
      | Case weight | 0    |
    And Admin increase field number tooltip 1 times
      | field       | text |
      | Case weight | 1    |
    And Admin decrease field number tooltip 1 times
      | field     | text |
      | Unit Size | 0    |
    And Admin increase field number tooltip 1 times
      | field     | text |
      | Unit Size | 0.1  |
    And Admin decrease field number tooltip 1 times
      | field            | text |
      | Cases per Pallet | 0    |
    And Admin increase field number tooltip 1 times
      | field            | text |
      | Cases per Pallet | 1    |
    And Admin decrease field number tooltip 1 times
      | field           | text |
      | Cases per layer | 0    |
    And Admin decrease field number tooltip 1 times
      | field                  | text |
      | Layers per full pallet | 0    |
    And Admin increase field number tooltip 1 times
      | field                  | text |
      | Layers per full pallet | 1    |
    And Admin decrease field number tooltip 1 times
      | field                     | text |
      | Master Cartons per Pallet | 0    |
    And Admin increase field number tooltip 1 times
      | field                     | text |
      | Master Cartons per Pallet | 1    |
    And Admin decrease field number tooltip 1 times
      | field                   | text |
      | Cases per Master Carton | 0    |
    And Admin increase field number tooltip 1 times
      | field                   | text |
      | Cases per Master Carton | 1    |
    And Admin decrease field number tooltip 1 times
      | field                     | text |
      | Master carton L" × W" × H | 0    |
    And Admin increase field number tooltip 1 times
      | field                     | text |
      | Master carton L" × W" × H | 0.1  |
    And Admin decrease field number tooltip 1 times
      | field                | text |
      | Master carton Weight | 0    |
    And Admin increase field number tooltip 1 times
      | field                | text |
      | Master carton Weight | 1    |

  @Admin @TC_Admin_add_sku @Validate
  Scenario: Admin add new sku check validate fields, help texts on screen
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |

    And Admin delete order by sku of product "auto_product23" by api
    And Admin delete all sku in product id "6627" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product23 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product23"
    And Check product not have SKU
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Click Create
#    And Admin check message of sku "auto 1 check create product" is "Variant have been saved successfully !!"
    And Admin check message is showing of fields when create sku
      | field                      | message                                                                            |
      | SKU name                   | Please input product SKU name                                                      |
      | Master image               | Please choose a master image for new variant                                       |
      | Individual unit UPC        | Please input valid UPC 12-digit number without letters or hyphens                  |
      | Case UPC                   | Please input valid case UPC. If you don't have a case UPC, please enter a unit UPC |
      | Unit UPC image             | Please choose an unit UPC image                                                    |
      | Case UPC image             | Please choose a case UPC image                                                     |
      | City                       | Please input manufactured city                                                     |
      | State (Province/Territory) | Please input manufactured state                                                    |
      | Ingredients                | Please input ingredients info                                                      |
      | Description                | Please input description info                                                      |
      | Nutrition labels           | Please upload at least 1 nutrition label                                           |
#      | Qualities                  | Please choose at least 1 quality                                                   |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | yes                   | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Click Create
#    And Admin check message of sku "auto 1 check create product" is "Variant have been saved successfully !!"
    And Admin check message is showing of fields when create sku
      | field                      | message                                                                            |
      | SKU name                   | Please input product SKU name                                                      |
      | Master image               | Please choose a master image for new variant                                       |
      | Individual unit EAN        | Please input valid EAN 13-digit number without letters or hyphens                  |
      | Case EAN                   | Please input valid case EAN. If you don't have a case UPC, please enter a unit EAN |
      | Unit EAN image             | Please choose an unit EAN image                                                    |
      | Case EAN image             | Please choose a case EAN image                                                     |
      | City                       | Please input manufactured city                                                     |
      | State (Province/Territory) | Please input manufactured state                                                    |
      | Ingredients                | Please input ingredients info                                                      |
      | Description                | Please input description info                                                      |
      | Nutrition labels           | Please upload at least 1 nutrition label                                           |
#      | Qualities                  | Please choose at least 1 quality                                                   |

#   And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
#    And Search the product by info then system show result
#      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags |
#      | auto_product23 | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  |
#    And Admin go to detail of product "auto_product23"
#    And Check product not have SKU
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage      | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | ImageInvalid.mp4 | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field        | message                           |
      | Master image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage       | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | ImageInvalid1.pdf | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field        | message                           |
      | Master image | Unsupported format for previewing |

    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage        | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | ImageInvalid2.xlsx | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field        | message                           |
      | Master image | Unsupported format for previewing |

    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage       | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | ImageInvalid3.xls | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field        | message                           |
      | Master image | Unsupported format for previewing |

    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage       | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | ImageInvalid4.csv | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field        | message                           |
      | Master image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | 10MBgreater.jpg | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin verify content of alert
      | Maximum file size exceeded. |

    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage       | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | yes                   | ImageInvalid4.csv | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field        | message                           |
      | Master image | Unsupported format for previewing |

    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage     | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | [blank]     | [blank] | ImageInvalid.mp4 | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Unit UPC image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage      | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | [blank]     | [blank] | ImageInvalid1.pdf | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Unit UPC image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage       | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | [blank]     | [blank] | ImageInvalid2.xlsx | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Unit UPC image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage      | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | [blank]     | [blank] | ImageInvalid3.xls | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Unit UPC image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage      | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | [blank]     | [blank] | ImageInvalid4.csv | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Unit UPC image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage     | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | [blank]     | [blank] | [blank]      | ImageInvalid.mp4 | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Case UPC image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | [blank]     | [blank] | [blank]      | ImageInvalid1.pdf | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Case UPC image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage       | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | [blank]     | [blank] | [blank]      | ImageInvalid2.xlsx | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Case UPC image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | [blank]     | [blank] | [blank]      | ImageInvalid3.xls | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Case UPC image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | no                    | [blank]     | [blank] | [blank]      | ImageInvalid4.csv | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Case UPC image | Unsupported format for previewing |

    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage     | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | yes                   | [blank]     | [blank] | [blank]      | ImageInvalid.mp4 | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Case EAN image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | yes                   | [blank]     | [blank] | [blank]      | ImageInvalid1.pdf | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Case EAN image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage       | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | yes                   | [blank]     | [blank] | [blank]      | ImageInvalid2.xlsx | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Case EAN image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | yes                   | [blank]     | [blank] | [blank]      | ImageInvalid3.xls | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Case EAN image | Unsupported format for previewing |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | yes                   | [blank]     | [blank] | [blank]      | ImageInvalid4.csv | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Admin check image invalid when create sku
      | field          | message                           |
      | Case EAN image | Unsupported format for previewing |

    And with Nutrition labels
      | nutritionLabel    | nutritionLabelDescription |
      | ImageInvalid4.csv | [blank]                   |
    And Admin check image invalid when create sku
      | field            | message                           |
      | Nutrition labels | Unsupported format for previewing |

  @Admin @AD_PRODUCT_122 @AD_Products_136
  Scenario: Admin add new sku check validate fields, help texts on screen 2
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto_product23" by api
    And Admin delete all sku in product id "6627" by api
    And Change state of product id: "6627" to "active"
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product23 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product23"
    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage      | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | ImageInvalid1.pdf | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | -11                | 33                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Click Create
    And Admin check message is showing of fields when create product
      | field             | message                                             |
      | Temp. requirement | Please enter a valid range temperature requirements |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition           | retailShelfLife | retailCondition            | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | [blank]               | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | Refrigerated (33°F ~ 41°F) | [blank]         | Refrigerated (33°F ~ 41°F) | 32                 | 42                 | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Click Create
    And Admin check message is showing of fields when create product
      | field             | message                                             |
      | Temp. requirement | Please enter a valid range temperature requirements |
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | [blank]               | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | Deep Frozen (-20°F ~ -11°F) | [blank]         | Deep Frozen (-20°F ~ -11°F) | -21                | -10                | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |
    And Click Create
    And Admin check message is showing of fields when create product
      | field             | message                                             |
      | Temp. requirement | Please enter a valid range temperature requirements |

  @Admin @AD_PRODUCT_123
  Scenario: Admin add new sku check validate fields, help texts on screen 3
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto_product23" by api
    And Admin delete all sku in product id "6627" by api
    And Change state of product id: "6627" to "active"
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product23 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product23"
    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage  | caseUpcImage                    | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | CaseImage.png | CaseImage.png ImageInvalid1.pdf | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab
    And with region specific
      | regionName     | casePrice | msrpunit | availability | arriving |
      | Dallas Express | 12        | 15       | In stock     | [blank]  |
    And Click Create
#    And Admin check message of sku "auto sku 2 check create product" is "Variant have been saved successfully !!"
    And BAO_ADMIN2 check alert message
      | Barcode image attachment content type is invalid |

  @Admin @TC_Admin_check_deactive_product
  Scenario: Admin activate/deactivate product
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Change state of product id: "6813" to "active"
    And Change state of SKU id: "32027" to "active"
    And Change state of SKU id: "32026" to "active"

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product25 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product25"
    And Admin "Deactivate" this product
    And Admin check product detail
      | stateStatus | productName    | brand                | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Inactive    | auto_product25 | Auto Brand promotion | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | [blank]    |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Check product not have SKU
    And Admin check SKU info on tab "inactive"
      | skuName             | unitUpc      | caseUpc | status   | unitPerCase | codeSKU   | regions |
      | Auto sku 1 deactive | 123123123123 | [blank] | Inactive | 1 per case  | not check | [blank] |
      | Auto sku 2 deactive | 123123123123 | [blank] | Inactive | 1 per case  | not check | [blank] |
    And Admin "Activate" this product
    And Admin check product detail
      | stateStatus | productName    | brand                | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | auto_product25 | Auto Brand promotion | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | [blank]    |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Check product not have SKU
    And Admin check SKU info on tab "inactive"
      | skuName             | unitUpc      | caseUpc | status   | unitPerCase | codeSKU   | regions |
      | Auto sku 1 deactive | 123123123123 | [blank] | Inactive | 1 per case  | not check | [blank] |
      | Auto sku 2 deactive | 123123123123 | [blank] | Inactive | 1 per case  | not check | [blank] |

  @Admin @TC_Admin_check_fields_number_when_create_sku
  Scenario: Admin check validate fields number create SKU
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto_product23" by api
    And Admin delete all sku in product id "6627" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product23 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product23"
    And Check product not have SKU
    And Add new SKU
      | skuName | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
      | [blank] | [blank] | [blank] | [blank]   | [blank]           | [blank]               | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]            |

    And Admin increase field number tooltip 1 times
      | field                     | text |
      | Storage shelf life (days) | 2    |
    And Admin decrease field number tooltip 2 times
      | field                     | text |
      | Storage shelf life (days) | 0    |
    And Admin check message is showing of fields when create sku
      | field                     | message                                      |
      | Storage shelf life (days) | Please specific storage shelf life condition |
    And Admin decrease field number tooltip 1 times
      | field                     | text |
      | Storage shelf life (days) | -1   |
    And Admin check message is showing of fields when create sku
      | field                     | message                                      |
      | Storage shelf life (days) | Please specific storage shelf life condition |
    And Admin edit field general of SKU
      | field                     | value |
      | Storage shelf life (days) | -1    |
    And Admin check message is showing of fields when create sku
      | field                     | message                                      |
      | Storage shelf life (days) | Please specific storage shelf life condition |
    And Admin edit field general of SKU
      | field                     | value |
      | Storage shelf life (days) | 0     |
    And Admin check message is showing of fields when create sku
      | field                     | message                                      |
      | Storage shelf life (days) | Please specific storage shelf life condition |

    And Admin increase field number tooltip 1 times
      | field                    | text |
      | Retail shelf life (days) | 2    |
    And Admin decrease field number tooltip 2 times
      | field                    | text |
      | Retail shelf life (days) | 0    |
    And Admin check message is showing of fields when create sku
      | field                    | message                                     |
      | Retail shelf life (days) | Please specific retail shelf life condition |
    And Admin decrease field number tooltip 1 times
      | field                    | text |
      | Retail shelf life (days) | -1   |
    And Admin check message is showing of fields when create sku
      | field                    | message                                     |
      | Retail shelf life (days) | Please specific retail shelf life condition |

    And Admin edit field general of SKU
      | field                    | value |
      | Retail shelf life (days) | 0     |
    And Admin check message is showing of fields when create sku
      | field                    | message                                     |
      | Retail shelf life (days) | Please specific retail shelf life condition |
    And Admin edit field general of SKU
      | field                    | value   |
      | Retail shelf life (days) | [blank] |
    And Admin check message is showing of fields when create sku
      | field                    | message                                     |
      | Retail shelf life (days) | Please specific retail shelf life condition |

    And Admin increase field number tooltip 1 times
      | field                | text |
      | Expiry day threshold | 101  |
    And Admin decrease field number tooltip 2 times
      | field                | text |
      | Expiry day threshold | 99   |
#    And Admin check message is showing of fields when create sku
#      | field                | message |
#      | Expiry day threshold | [blank]  |
    And Admin edit field general of SKU
      | field                | value |
      | Expiry day threshold | 0     |
    And Admin check message not showing of fields when create sku
      | field                | message |
      | Expiry day threshold | [blank] |
    And Admin edit field general of SKU
      | field                | value |
      | Expiry day threshold | -1    |
    And Admin check message not showing of fields when create sku
      | field                | message |
      | Expiry day threshold | [blank] |

    And "Not Use" default pull threshold
#    And Admin decrease field number tooltip 1 times
#      | field                 | text |
#      | Pull threshold (days) | -1   |
    And Admin edit field general of SKU
      | field                 | value |
      | Pull threshold (days) | -1    |
    And Admin check message is showing of fields when create sku
      | field                 | message                             |
      | Pull threshold (days) | Please input a valid pull threshold |

  @Admin @FN_4.2_Verify_region_specific @AD_Products_148
  Scenario: Check display of all information on the Region-specific tab
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto_product24" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto_product24  | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "Auto product2 low quantity thresshold" from API
    And Admin delete inventory "all" by API
#    And Admin search product name "auto bao create product" by api
#    And Admin delete product name "auto bao create product" by api
    And Change state of product id: "6636" to "active"
#    And Admin delete order by sku of product "auto_product24" by api
    And Admin delete all sku in product id "6636" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
    And Check product not have SKU
    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab
    And Check default "region" specific tab
      | alert                                                                                                                                                                                                                       | empty                              |
      | A store-specific price is applied with priority. If no store-specific price is set, a buyer-company-specific one is applied instead. If no buyer-company-specific price is set, a region-specific price is applied at last. | You don't have any defined region. |
    And Click Create
    And Go to "Region-specific" tab
    And Check default "region" specific tab
      | alert                                                                                                                                                                                                                       | empty                              | error                                                                                                       |
      | A store-specific price is applied with priority. If no store-specific price is set, a buyer-company-specific one is applied instead. If no buyer-company-specific price is set, a region-specific price is applied at last. | You don't have any defined region. | Please upload at least 1 region config or select at least 1 store-region or select at least 1 buyer-company |
    And with region specific
      | regionName     | casePrice | msrpunit | availability | arriving |
      | Dallas Express | [blank]   | [blank]  | [blank]      | [blank]  |
    And Admin check region-specific of SKU
      | regionName     | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Dallas Express | 0         | 0        | Out of stock | [blank]  | [blank]        | [blank]  |
    And with region specific
      | regionName         | casePrice | msrpunit | availability | arriving |
      | Pod Direct Central | [blank]   | [blank]  | [blank]      | [blank]  |
    And Admin check region-specific of SKU
      | regionName         | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Pod Direct Central | 0         | 0        | [blank]      | [blank]  | [blank]        | [blank]  |
    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving                       |
      | Dallas Express           | 12        | 15       | In stock     | [blank]                        |
      | Chicagoland Express      | 12        | 15       | Out of stock | Pending Replenishment          |
      | Florida Express          | 12        | 15       | Out of stock | Vendor short-term              |
      | Mid Atlantic Express     | 12        | 15       | Out of stock | Vendor long-term               |
      | New York Express         | 12        | 15       | In stock     | [blank]                        |
#      | New York Express               | 12        | 15       | Launching soon | currentDate
      | North California Express | 12        | 15       | In stock     | [blank]                        |
      | South California Express | 12        | 15       | Out of stock | Discontinued by vendor         |
#      | Pod Direct Midwest       | 12        | 15       | Out of stock | Pending vendor response        |
#      | Pod Direct Northeast     | 12        | 15       | In stock     | [blank]                        |
#      | Pod Direct Northeast           | 12        | 15       | Launching soon | currentDate
      | Pod Direct Central       | 12        | 15       | Out of stock | [blank]                        |
      | Pod Direct East          | 12        | 15       | In stock     | Product replacement/transition |
      | Pod Direct West          | 12        | 15       | Out of stock | [blank]                        |
    And date for region specific
      | region                   | startDate   | endDate     |
      | Dallas Express           | Minus1      | currentDate |
      | Chicagoland Express      | Minus1      | Plus1       |
      | Florida Express          | Minus2      | Minus1      |
      | Mid Atlantic Express     | currentDate | Plus1       |
      | New York Express         | Plus1       | Plus2       |
      | North California Express | Minus1      | currentDate |
      | South California Express | Minus1      | Plus1       |
      | Pod Direct Central       | Minus2      | Minus1      |
      | Pod Direct East          | currentDate | Plus1       |
      | Pod Direct West          | Plus1       | Plus2       |
#      | Pod Direct Southwest & Rockies | Plus1       | Plus2       |
#      | Pod Direct West                | Minus1      | currentDate |
    And Click Create
    And Admin check message of sku "auto 2 check create product" is "Variant have been saved successfully !!"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName               | casePrice | msrpunit | availability | arriving | inventoryCount | category                       |
      | Dallas Express           | 12        | 15       | In stock     | [blank]  | [blank]        | [blank]                        |
      | Chicagoland Express      | 12        | 15       | Out of stock | [blank]  | [blank]        | Pending Replenishment          |
      | Florida Express          | 12        | 15       | Out of stock | [blank]  | [blank]        | Vendor short-term              |
      | Mid Atlantic Express     | 12        | 15       | Out of stock | [blank]  | [blank]        | Vendor long-term               |
      | New York Express         | 12        | 15       | In stock     | [blank]  | [blank]        | [blank]                        |
      | North California Express | 12        | 15       | In stock     | [blank]  | [blank]        | [blank]                        |
      | South California Express | 12        | 15       | Out of stock | [blank]  | [blank]        | Discontinued by vendor         |
      | Pod Direct Central       | 12        | 15       | Out of stock | [blank]  | [blank]        | Vendor short-term              |
      | Pod Direct East          | 12        | 15       | In stock     | [blank]  | [blank]        | Product replacement/transition |
      | Pod Direct West          | 12        | 15       | Out of stock | [blank]  | [blank]        | [blank]                        |
#      | Pod Direct Southwest & Rockies | 12        | 15       | Out of stock | [blank]  | [blank]        | Product replacement/transition |
#      | Pod Direct West                | 12        | 15       | In stock     | [blank]  | [blank]        | [blank]                        |
    And Admin check date of region-specific of SKU
      | region                   | startDate   | endDate     | state    |
      | Dallas Express           | Minus1      | currentDate | active   |
      | Chicagoland Express      | Minus1      | Plus1       | active   |
      | Florida Express          | Minus2      | Minus1      | inactive |
      | Mid Atlantic Express     | currentDate | Plus1       | active   |
      | New York Express         | Plus1       | Plus2       | inactive |
      | North California Express | Minus1      | currentDate | active   |
      | South California Express | Minus1      | Plus1       | active   |
      | Pod Direct Central       | Minus2      | Minus1      | inactive |
      | Pod Direct East          | currentDate | Plus1       | active   |
      | Pod Direct West          | Plus1       | Plus2       | inactive |
#      | Pod Direct Southwest & Rockies | Plus1       | Plus2       | inactive |
#      | Pod Direct West                | Minus1      | currentDate | active   |

  @Admin @AD_Products_162
  Scenario: Check display of Change logs modal Availability
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search product name "random product edit sku api" by api
    And Admin delete product name "random product edit sku api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | random product edit sku api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku edit sku api" of product ""
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | random product edit sku api | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "random product edit sku api"
    And Admin go to SKU detail "random sku edit sku api"
    And Go to "Region-specific" tab
    And Admin edit region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 11        | 11       | Out of stock | [blank]  |
    And date for region specific
      | region              | startDate | endDate |
      | Chicagoland Express | Minus3    | Minus2  |
    And Click on button "Update"
    And Admin check message of sku "random sku edit sku api" is "Variant have been saved successfully !!"
    And Admin check state history of region "Chicagoland Express" of SKU
      | state           | updateBy                | updateOn    |
      | Active→Inactive | Admin: bao2@podfoods.co | currentDate |
    And date for region specific
      | region              | startDate | endDate |
      | Chicagoland Express | Minus1    | Plus1   |
    And Click on button "Update"
    And Admin check message of sku "random sku edit sku api" is "Variant have been saved successfully !!"
    And Admin check state history of region "Chicagoland Express" of SKU
      | state           | updateBy                | updateOn    |
      | Inactive→Active | Admin: bao2@podfoods.co | currentDate |
      | Active→Inactive | Admin: bao2@podfoods.co | currentDate |
    And Admin check availability history of region "Chicagoland Express" of SKU
      | availability          | updateBy                | updateOn    |
      | In stock→Out of stock | Admin: bao2@podfoods.co | currentDate |
      | →In stock             | Admin: Bao              | currentDate |
    And Admin edit region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 11        | 11       | In stock     | [blank]  |
    And Click on button "Update"
    And Admin check message of sku "random sku edit sku api" is "Variant have been saved successfully !!"
    And Admin check availability history of region "Chicagoland Express" of SKU
      | availability          | updateBy                | updateOn    |
      | Out of stock→In stock | Admin: bao2@podfoods.co | currentDate |
      | In stock→Out of stock | Admin: bao2@podfoods.co | currentDate |
      | →In stock             | Admin: Bao              | currentDate |

  @Admin @AD_Products_183
  Scenario: Check display of Change logs modal Availability - Buyer company-specific tab
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search product name "random product edit sku api" by api
    And Admin delete product name "random product edit sku api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | random product edit sku api | 3018     |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
      | 2216             | Auto_BuyerCompany  | 63        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "random sku edit sku api" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | random product edit sku api | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "random product edit sku api"
    And Admin go to SKU detail "random sku edit sku api"
    And Go to "Buyer company-specific" tab
    And Admin check availability history of buyer company "Auto_BuyerCompany" and region "Chicagoland Express" of SKU
      | availability | updateBy   | updateOn    |
      | →In stock    | Admin: Bao | currentDate |
    And with Buyer Company-specific
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate | endDate | inventoryArrivingAt | category |
      | Auto_BuyerCompany | Chicagoland Express | 11       | 12        | Out of stock | Minus3    | Minus2  | [blank]             | [blank]  |
    And Click Create
    And Admin check message of sku "random sku edit sku api" is "Variant have been saved successfully !!"
    And Admin check state history of buyer company "Auto_BuyerCompany" and region "Chicagoland Express" of SKU
      | state           | updateBy                | updateOn    |
      | Active→Inactive | Admin: bao2@podfoods.co | currentDate |
    And Admin check availability history of buyer company "Auto_BuyerCompany" and region "Chicagoland Express" of SKU
      | availability          | updateBy                | updateOn    |
      | In stock→Out of stock | Admin: bao2@podfoods.co | currentDate |
      | →In stock             | Admin: Bao              | currentDate |

  @Admin @AD_Products_200
  Scenario: Check display of Change logs modal Availability - Store-specific tab
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search product name "random product edit sku api" by api
    And Admin delete product name "random product edit sku api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | random product edit sku api | 3018     |
    And Info of Store specific
      | store_id | store_name          | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
      | 1762     | Auto Store PDM      | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 1100             | 1100       | in_stock     |
    And Admin create a "active" SKU from admin with name "random sku edit sku api" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | random product edit sku api | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "random product edit sku api"
    And Admin go to SKU detail "random sku edit sku api"
    And Go to "Store-specific" tab
    And Admin check availability history of store specific "Auto Store PDM" of SKU
      | availability | updateBy   | updateOn    |
      | →In stock    | Admin: Bao | currentDate |
    And with Store-specific
      | region             | store          | msrp    | casePrice | availability | arriving | category | start  | end    |
      | Pod Direct Central | Auto Store PDM | [blank] | [blank]   | Out of stock | [blank]  | [blank]  | Minus3 | Minus1 |
    And Click on button "Update"
    And Admin check message of sku "random sku edit sku api" is "Variant have been saved successfully !!"
    And Admin check state history of store specific "Auto Store PDM" of SKU
      | state           | updateBy                | updateOn    |
      | Active→Inactive | Admin: bao2@podfoods.co | currentDate |
    And Admin check availability history of store specific "Auto Store PDM" of SKU
      | availability          | updateBy                | updateOn    |
      | In stock→Out of stock | Admin: bao2@podfoods.co | currentDate |
      | →In stock             | Admin: Bao              | currentDate |

  @Admin @Verify_region_specific2
  Scenario: Check validation of the Case price and MSRP/unit field on each create region-specific form
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
#    And Admin search product name "auto bao create product" by api
#    And Admin delete product name "auto bao create product" by api
#    And Admin search inventory by API
#      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
#      | [blank]                 | auto_product24  | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
#    And Admin get ID inventory by product "auto_product24" from API
#    And Admin delete all inventory by API
    And Change state of product id: "6636" to "active"
#    And Admin delete order by sku of product "auto_product24" by api
    And Admin delete all sku in product id "6636" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
    And Check product not have SKU
    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab
    And Check default "region" specific tab
      | alert                                                                                                                                                                                                                       | empty                              |
      | A store-specific price is applied with priority. If no store-specific price is set, a buyer-company-specific one is applied instead. If no buyer-company-specific price is set, a region-specific price is applied at last. | You don't have any defined region. |

    And with region specific
      | regionName     | casePrice | msrpunit | availability | arriving |
      | Dallas Express | [blank]   | [blank]  | [blank]      | [blank]  |
    And Click Create
#    And Go to "Region-specific" tab
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
      | MSRP/unit  | Please input a valid MSRP       |
#      | Availability | Please select availability status |

    And with region specific
      | regionName     | casePrice | msrpunit | availability | arriving |
      | Dallas Express | -1        | -1       | [blank]      | [blank]  |
    And Click Create
    And Go to "Region-specific" tab
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
      | MSRP/unit  | Please input a valid MSRP       |
#      | Availability | Please select availability status |

    And Admin increase field number tooltip 1 times
      | field      | text |
      | Case price | 0    |
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
    And Admin increase field number tooltip 1 times
      | field      | text |
      | Case price | 0.01 |
    And Admin check message not showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
    And Admin decrease field number tooltip 2 times
      | field      | text |
      | Case price | 0    |
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |

    And Admin increase field number tooltip 1 times
      | field     | text |
      | MSRP/unit | 0    |
    And Admin check message is showing of fields when create sku
      | field     | message                   |
      | MSRP/unit | Please input a valid MSRP |
    And Admin increase field number tooltip 1 times
      | field     | text |
      | MSRP/unit | 0.01 |
    And Admin check message not showing of fields when create sku
      | field     | message                   |
      | MSRP/unit | Please input a valid MSRP |
    And Admin decrease field number tooltip 2 times
      | field     | text |
      | MSRP/unit | 0    |
    And Admin check message is showing of fields when create sku
      | field     | message                   |
      | MSRP/unit | Please input a valid MSRP |

    And Remove region "Dallas Express"

    And with region specific
      | regionName      | casePrice | msrpunit | availability | arriving |
      | Pod Direct West | [blank]   | [blank]  | [blank]      | [blank]  |
    And Click Create
    And Go to "Region-specific" tab
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
      | MSRP/unit  | Please input a valid MSRP       |
#      | Availability | Please select availability status |

    And with region specific
      | regionName      | casePrice | msrpunit | availability | arriving |
      | Pod Direct West | -1        | -1       | [blank]      | [blank]  |
    And Click Create
    And Go to "Region-specific" tab
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
      | MSRP/unit  | Please input a valid MSRP       |
#      | Availability | Please select availability status |

    And Admin increase field number tooltip 1 times
      | field      | text |
      | Case price | 0    |
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
    And Admin increase field number tooltip 1 times
      | field      | text |
      | Case price | 0.01 |
    And Admin check message not showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
    And Admin decrease field number tooltip 2 times
      | field      | text |
      | Case price | 0    |
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |

    And Admin increase field number tooltip 1 times
      | field     | text |
      | MSRP/unit | 0    |
    And Admin check message is showing of fields when create sku
      | field     | message                   |
      | MSRP/unit | Please input a valid MSRP |
    And Admin increase field number tooltip 1 times
      | field     | text |
      | MSRP/unit | 0.01 |
    And Admin check message not showing of fields when create sku
      | field     | message                   |
      | MSRP/unit | Please input a valid MSRP |
    And Admin decrease field number tooltip 2 times
      | field     | text |
      | MSRP/unit | 0    |
    And Admin check message is showing of fields when create sku
      | field     | message                   |
      | MSRP/unit | Please input a valid MSRP |
    And with region specific
      | regionName      | casePrice | msrpunit | availability | arriving |
      | Pod Direct West | 123456789 | 1        | In stock     | [blank]  |
    And Click Create

    And Admin verify content of alert
      | 12345678900 is out of range for ActiveModel::Type::Integer with limit 4 bytes |
    And with region specific
      | regionName      | casePrice | msrpunit  | availability | arriving |
      | Pod Direct West | 1         | 123456789 | In stock     | [blank]  |
    And Click Create
    And Admin verify content of alert
      | 12345678900 is out of range for ActiveModel::Type::Integer with limit 4 bytes |

  @Admin @AD_Products_153
  Scenario: Check validation of the Start date - End date date picker
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
#    And Admin search product name "auto bao create product" by api
#    And Admin delete product name "auto bao create product" by api
#    And Admin search inventory by API
#      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
#      | [blank]                 | auto_product24  | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
#    And Admin get ID inventory by product "auto_product24" from API
#    And Admin delete all inventory by API
#    And Change state of product id: "6636" to "active"
#    And Admin delete order by sku of product "auto_product24" by api
#    And Admin delete all sku in product id "6636" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
    And Check product not have SKU
    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And Go to "Region-specific" tab
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Dallas Express      | 10        | 10       | In stock     | [blank]  |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  |
      | Florida Express     | 10        | 10       | In stock     | [blank]  |
      | New York Express    | 10        | 10       | In stock     | [blank]  |
    And date for region specific
      | region         | startDate | endDate  |
      | Dallas Express | 66/66/22  | 66/66/22 |
#    And Admin check date of region-specific of SKU
#      | region        | startDate | endDate |
#      | Dallas Express | [blank]   | [blank] |
    And date for region specific
      | region         | startDate | endDate  |
      | Dallas Express | 04/31/22  | 02/30/22 |
#    And Admin check date of region-specific of SKU
#      | region        | startDate | endDate |
#      | Dallas Express | [blank]   | [blank] |
    And date for region specific
      | region              | startDate   | endDate     |
      | Dallas Express      | currentDate | currentDate |
      | Chicagoland Express | Minus2      | Minus1      |
      | Florida Express     | Plus1       | Plus2       |
      | New York Express    | 02/08/23    | 02/07/23    |
    And Admin check date of region-specific of SKU
      | region              | startDate   | endDate     |
      | Dallas Express      | currentDate | currentDate |
      | Chicagoland Express | Minus2      | Minus1      |
      | Florida Express     | Plus1       | Plus2       |
      | New York Express    | 02/08/23    | 02/07/23    |
    And Click Create
    And BAO_ADMIN2 check alert message
      | Validation failed: Variants regions variants regions config start date must be before or equal to 2023-02-07 |
    And date for region specific
      | region           | startDate   | endDate     |
      | New York Express | currentDate | currentDate |
    And Click Create
    And Admin check message of sku "auto sku 2 check create product" is "Variant have been saved successfully !!"

  @Admin @Verify_region_specific_prop65 @ADD_NEW_SKU_36_39
  Scenario: Check adding new regions when select one of regions in [Pod Direct West, North California Express and South California Express]
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto_product24" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto_product24  | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto_product24" from API
    And Admin delete all inventory by API
    And Change state of product id: "6636" to "active"
    And Admin delete all sku in product id "6636" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
#    And Check product not have SKU

    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab
    And Check Prop65 is "show" when select region "Pod Direct West"
      | product        | firstName | lastName | email                           | company             | today       |
      | auto_product24 | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | Auto vendor company | currentDate |
    And Admin submit Prop65
    And Admin check region-specific of SKU
      | regionName      | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Pod Direct West | 0         | 0        | [blank]      | [blank]  | [blank]        | [blank]  |

    And Check Prop65 is "not show" when select region "South California Express"
      | product | firstName | lastName | email   | company | today   |
      | [blank] | [blank]   | [blank]  | [blank] | [blank] | [blank] |
    And Admin check region-specific of SKU
      | regionName               | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | South California Express | 0         | 0        | [blank]      | [blank]  | [blank]        | [blank]  |

    And Check Prop65 is "not show" when select region "North California Express"
      | product | firstName | lastName | email   | company | today   |
      | [blank] | [blank]   | [blank]  | [blank] | [blank] | [blank] |
    And Admin check region-specific of SKU
      | regionName               | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | North California Express | 0         | 0        | [blank]      | [blank]  | [blank]        | [blank]  |

    And Remove region "Pod Direct West"
    And Remove region "South California Express"
    And Check Prop65 is "show" when select region "South California Express"
      | product        | firstName | lastName | email                           | company             | today       |
      | auto_product24 | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | Auto vendor company | currentDate |
    And Admin submit Prop65
    And Check Prop65 is "not show" when select region "Pod Direct West"
      | product | firstName | lastName | email   | company | today   |
      | [blank] | [blank]   | [blank]  | [blank] | [blank] | [blank] |
    And Admin check region-specific of SKU
      | regionName      | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Pod Direct West | 0         | 0        | [blank]      | [blank]  | [blank]        | [blank]  |

    And Remove region "Pod Direct West"
    And Remove region "North California Express"

    And Check Prop65 is "not show" when select region "Pod Direct West"
      | product | firstName | lastName | email   | company | today   |
      | [blank] | [blank]   | [blank]  | [blank] | [blank] | [blank] |
    And Admin check region-specific of SKU
      | regionName      | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Pod Direct West | 0         | 0        | [blank]      | [blank]  | [blank]        | [blank]  |
    And Check Prop65 is "not show" when select region "North California Express"
      | product | firstName | lastName | email   | company | today   |
      | [blank] | [blank]   | [blank]  | [blank] | [blank] | [blank] |
    And Admin check region-specific of SKU
      | regionName               | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | North California Express | 0         | 0        | [blank]      | [blank]  | [blank]        | [blank]  |

    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving |
      | Pod Direct West          | 12        | 15       | In stock     | [blank]  |
      | North California Express | 12        | 15       | In stock     | [blank]  |
      | South California Express | 12        | 15       | In stock     | [blank]  |
    And Click Create
    And Admin check message of sku "auto sku 2 check create product" is "Variant have been saved successfully !!"

    And Admin go back with button
    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 3 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab

    And Check Prop65 is "show" when select region "Pod Direct West"
      | product        | firstName | lastName | email                           | company             | today       |
      | auto_product24 | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | Auto vendor company | currentDate |
    And Admin submit Prop65

    And Admin check region-specific of SKU
      | regionName      | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Pod Direct West | 0         | 0        | [blank]      | [blank]  | [blank]        | [blank]  |

    And Remove region "Pod Direct West"
    And Check Prop65 is "show" when select region "North California Express"
      | product        | firstName | lastName | email                           | company             | today       |
      | auto_product24 | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | Auto vendor company | currentDate |
    And Admin submit Prop65

    And Admin check region-specific of SKU
      | regionName               | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | North California Express | 0         | 0        | [blank]      | [blank]  | [blank]        | [blank]  |

    And Remove region "North California Express"
    And Check Prop65 is "show" when select region "South California Express"
      | product        | firstName | lastName | email                           | company             | today       |
      | auto_product24 | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | Auto vendor company | currentDate |
    And Admin submit Prop65

    And Admin check region-specific of SKU
      | regionName               | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | South California Express | 0         | 0        | [blank]      | [blank]  | [blank]        | [blank]  |

    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving |
      | South California Express | 12        | 15       | In stock     | [blank]  |
    And Click Create
    And Admin check message of sku "auto sku 3 check create product" is "Variant have been saved successfully !!"
    And Admin go back with button
    And Admin check SKU info on tab "active"
      | skuName                         | unitUpc       | caseUpc      | status | unitPerCase | codeSKU | regions |
      | auto sku 3 check create product | 1234567890981 | 123456789098 | Active | 12 per case | [blank] | LA      |
      | auto sku 2 check create product | 1234567890981 | 123456789098 | Active | 12 per case | [blank] | PDW     |
      | auto sku 2 check create product | 1234567890981 | 123456789098 | Active | 12 per case | [blank] | SF      |
      | auto sku 2 check create product | 1234567890981 | 123456789098 | Active | 12 per case | [blank] | LA      |

  @Admin @Verify_region_specific_validate_prop65
  Scenario: Verify_region_specific_validate_prop65
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto_product24" by api
    And Admin delete all sku in product id "6636" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
    And Check product not have SKU

    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab

    And Check Prop65 is "show" when select region "South California Express"
      | product        | firstName | lastName | email                           | company             | today       |
      | auto_product24 | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | Auto vendor company | currentDate |
    And Admin Clear field "First name"
    And Admin Clear field "Last name"
    And Admin Clear field "Email"
    And Admin check message is showing of fields when create product
      | field      | message                    |
      | First name | Please input a first name  |
      | Last name  | Please input a last name   |
      | Email      | Please input a valid email |
    And Admin input field values
      | field | value |
      | Email | blank |
    And Admin check message is showing of fields when create product
      | field | message                    |
      | Email | Please input a valid email |
    And Admin input field values
      | field | value |
      | Email | 1@p.c |
    And Admin check message is showing of fields when create product
      | field | message                    |
      | Email | Please input a valid email |
    And Admin input field values
      | field | value  |
      | Email | 1@p.co |
    And Admin check message not showing of fields when create product
      | field | message                    |
      | Email | Please input a valid email |
    And Admin input field values
      | field      | value |
      | First name | b     |
    And Admin check message not showing of fields when create product
      | field | message                    |
      | Email | Please input a valid email |
    And Admin input field values
      | field     | value |
      | Last name | b     |
    And Admin check message not showing of fields when create product
      | field | message                    |
      | Email | Please input a valid email |

  @Admin @Verify_region_specific_prop65 @ADD_NEW_SKU_52
  Scenario: Check the Prop.65 information is synchronized and shown on vendor site when add one of regions in [Pod Direct West, North California Express and South California Express] successfully
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Change state of product id: "6636" to "active"
    And Admin delete order by sku of product "auto_product24" by api
    And Admin delete all sku in product id "6636" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
    And Check product not have SKU

    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab
    And Check Prop65 is "show" when select region "Pod Direct West"
      | product        | firstName | lastName | email                           | company             | today       |
      | auto_product24 | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | Auto vendor company | currentDate |
    And Admin choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
    And Admin submit Prop65
    And Admin check region-specific of SKU
      | regionName      | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Pod Direct West | 0         | 0        | [blank]      | [blank]  | [blank]        | [blank]  |
    And with region specific
      | regionName      | casePrice | msrpunit | availability | arriving | inventoryCount |
      | Pod Direct West | 12        | 15       | In stock     | [blank]  | [blank]        |
    And Click Create
    And Admin check message of sku "auto sku 2 check create product" is "Variant have been saved successfully !!"

    And Go to "General" tab
    And Admin check Prop65 info on general SKU
      | type                                                                       | firstName | lastName | email                           | date        |
      | The referenced product does not contain any chemicals on the Prop. 65 List | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | currentDate |

    And Admin go back with button
    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 3 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab

    And Check Prop65 is "show" when select region "North California Express"
      | product        | firstName | lastName | email                           | company             | today       |
      | auto_product24 | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | Auto vendor company | currentDate |
    And Admin choose option "The referenced product contains one or more chemicals on the Prop. 65 List, as identified below." on Prop65
    And Admin enter info of Prop65
      | firstName | lastName | email   | listAllChemicals | item                                                                                                | warning                                                        |
      | [blank]   | [blank]  | [blank] | listAllChemicals | Our organization has determined a NSRL, and/or MADL, which will demonstrate compliance with Prop 65 | Shelf tag Prop. 65 warning label for display in retail stores. |
    And Admin submit Prop65
    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving |
      | North California Express | 12        | 15       | In stock     | [blank]  |
    And Click Create
    And Admin check message of sku "auto sku 3 check create product" is "Variant have been saved successfully !!"

    And Go to "General" tab
    And Admin check Prop65 info on general SKU
      | type                                                                                             | firstName | lastName | email                           | date        | listAllChemicals | item                                                                                                | warning                                                        |
      | The referenced product contains one or more chemicals on the Prop. 65 List, as identified below. | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | currentDate | listAllChemicals | Our organization has determined a NSRL, and/or MADL, which will demonstrate compliance with Prop 65 | Shelf tag Prop. 65 warning label for display in retail stores. |

    And Admin go back with button
    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 4 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab

    And Check Prop65 is "show" when select region "South California Express"
      | product        | firstName | lastName | email                           | company             | today       |
      | auto_product24 | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | Auto vendor company | currentDate |
    And Admin choose option "The referenced product contains one or more chemicals on the Prop. 65 List, as identified below." on Prop65
    And Admin enter info of Prop65
      | firstName | lastName | email   | listAllChemicals | item                                                                                                | warning                            |
      | [blank]   | [blank]  | [blank] | listAllChemicals | Our organization has determined a NSRL, and/or MADL, which will demonstrate compliance with Prop 65 | On product Prop. 65 warning label. |
    And Admin submit Prop65
    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving |
      | South California Express | 12        | 15       | In stock     | [blank]  |
    And Click Create
    And Admin check message of sku "auto sku 4 check create product" is "Variant have been saved successfully !!"

    And Go to "General" tab
    And Admin check Prop65 info on general SKU
      | type                                                                                             | firstName | lastName | email                           | date        | listAllChemicals | item                                                                                                | warning                            |
      | The referenced product contains one or more chemicals on the Prop. 65 List, as identified below. | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | currentDate | listAllChemicals | Our organization has determined a NSRL, and/or MADL, which will demonstrate compliance with Prop 65 | On product Prop. 65 warning label. |

    And Admin go back with button
    And Admin check SKU info on tab "active"
      | skuName                         | unitUpc       | caseUpc      | status | unitPerCase | codeSKU | regions |
      | auto sku 4 check create product | 1234567890981 | 123456789098 | Active | 12 per case | [blank] | LA      |
      | auto sku 3 check create product | 1234567890981 | 123456789098 | Active | 12 per case | [blank] | SF      |
      | auto sku 2 check create product | 1234567890981 | 123456789098 | Active | 12 per case | [blank] | PDW     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "auto_product24"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "auto sku 4 check create product"
    And Vendor check SKU general detail
      | skuName                         | ingredients                            | description | leadTime | unitCase | unitUPC       | caseUPC      | country | city     | state    | storage | retail | minTemperature | maxTemperature |
      | auto sku 4 check create product | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 1234567890981 | 123456789098 | U.S     | New York | New York | 30      | 10     | 10.0           | 30.0           |
    And Vendor check "show" prop65 of SKU
      | type                                                                                             | firstName | lastName | email                           | date        | listAllChemicals | item                                                                                                | warning                            | company             |
      | The referenced product contains one or more chemicals on the Prop. 65 List, as identified below. | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | currentDate | listAllChemicals | Our organization has determined a NSRL, and/or MADL, which will demonstrate compliance with Prop 65 | On product Prop. 65 warning label. | Auto vendor company |
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | South California Express | 12        | 15       | In Stock     |
    And Vendor go back product detail
    And Vendor go to detail of SKU "auto sku 3 check create product"
    And Vendor check SKU general detail
      | skuName                         | ingredients                            | description | leadTime | unitCase | unitUPC       | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature |
      | auto sku 3 check create product | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 1234567890981 | 123456789098 | United States | New York | New York | 30      | 10     | 10.0           | 30.0           |
    And Vendor check "show" prop65 of SKU
      | type                                                                                             | firstName | lastName | email                           | date        | listAllChemicals | item                                                                                                | warning                                                        | company             |
      | The referenced product contains one or more chemicals on the Prop. 65 List, as identified below. | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | currentDate | listAllChemicals | Our organization has determined a NSRL, and/or MADL, which will demonstrate compliance with Prop 65 | Shelf tag Prop. 65 warning label for display in retail stores. | Auto vendor company |
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | North California Express | 12        | 15       | In Stock     |
    And Vendor go back product detail
    And Vendor go to detail of SKU "auto sku 2 check create product"
    And Vendor check SKU general detail
      | skuName                         | ingredients                            | description | leadTime | unitCase | unitUPC       | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature |
      | auto sku 2 check create product | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 1234567890981 | 123456789098 | United States | New York | New York | 30      | 10     | 10.0           | 30.0           |
    And Vendor check "show" prop65 of SKU
      | type                                                                        | firstName | lastName | email                           | date        | company             |
      | The referenced product does not contain any chemicals on the Prop. 65 List. | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | currentDate | Auto vendor company |
    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 12        | 15       | In Stock     |
    And Admin check have no Prop65 info on general SKU

  @Admin @AD_Products_161 @AD_Products_261 @AD_Products_265
  Scenario: Check adding new region and that region has been added in buyer company specific or store specific
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Change state of product id: "6636" to "active"
    And Admin delete order by sku of product "auto_product24" by api
    And Admin delete all sku in product id "6636" by api
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability | out_of_stock_reason | auto_out_of_stock_reason |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | sold_out     | vendor_short_term   | pending_vendor_response  |
    And Admin create a "active" SKU from admin with name "auto sku 2 check create product" of product "6636"
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
    And Admin go to SKU detail "auto sku 2 check create product"
    And Go to "Region-specific" tab
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  |
    And Click on button "Update"
    And Admin check dialog message
      | Do you also want to change buyer-company-specific and store-specific availabilities of the region? |
    And Click on dialog button "Yes"
    And Admin check alert message
      | Variant have been saved successfully !! |
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | [blank]        | [blank]  |
    And Go to "Buyer company-specific" tab
    And Admin check buyer company-specific of SKU
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category |
      | Auto_BuyerCompany | Chicagoland Express | 10       | 10        | In stock     | currentDate | currentDate | [blank]             | [blank]  |
    And with Buyer Company-specific
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate | endDate | inventoryArrivingAt | category |
      | Auto_BuyerCompany | Chicagoland Express | [blank]  | [blank]   | Out of stock | [blank]   | [blank] | [blank]             | [blank]  |
    And Click on button "Update"
    And Admin check alert message
      | Variant have been saved successfully !! |
    And Go to "Region-specific" tab
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | [blank]   | [blank]  | Out of stock | [blank]  |
    And Click on button "Update"
    And Admin check dialog message
      | Do you also want to change buyer-company-specific and store-specific availabilities of the region? |
    And Click on dialog button "No"
    And Admin check alert message
      | Variant have been saved successfully !! |
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | [blank]   | [blank]  | In stock     | [blank]  |
    And Click on button "Update"
    And Admin check dialog message
      | Do you also want to change buyer-company-specific and store-specific availabilities of the region? |
    And Click on dialog button "No"
    And Admin check alert message
      | Variant have been saved successfully !! |
    And Go to "Buyer company-specific" tab
    And Admin check buyer company-specific of SKU
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category              |
      | Auto_BuyerCompany | Chicagoland Express | 10       | 10        | Out of stock | currentDate | currentDate | [blank]             | Pending Replenishment |

  @Admin @TC_Admin_create_sku_with_Buyer_company_specifics @FN_4.3 @AD_Products_206
  Scenario: TC_Admin_create_sku_with_Buyer_company_specifics
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Change state of product id: "6636" to "active"
    And Admin delete order by sku of product "auto_product24" by api
    And Admin delete all sku in product id "6636" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
    And Check product not have SKU
    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Buyer company-specific" tab
    And Check default "buyer" specific tab
      | alert                                                                                                                                                                                                                       | empty                                     |
      | A store-specific price is applied with priority. If no store-specific price is set, a buyer-company-specific one is applied instead. If no buyer-company-specific price is set, a region-specific price is applied at last. | You don't have any defined buyer company. |

    And Admin search Buyer Company specific "Auto_BuyerCompany"
    And Admin choose regions and add to Buyer Company specific
      | regions                  |
      | North California Express |
      | South California Express |
      | Florida Express          |
    And with Buyer Company-specific
      | buyerCompany      | region                   | msrpUnit | casePrice | availability | startDate | endDate | inventoryArrivingAt | category |
      | Auto_BuyerCompany | North California Express | [blank]  | [blank]   | [blank]      | [blank]   | [blank] | [blank]             | [blank]  |
    And Admin check buyer company-specific of SKU
      | buyerCompany      | region                   | msrpUnit | casePrice | availability | startDate | endDate | inventoryArrivingAt | category |
      | Auto_BuyerCompany | North California Express | 0        | 0         | Out of stock | [blank]   | [blank] | [blank]             | [blank]  |


    And with Buyer Company-specific
      | buyerCompany      | region                   | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category |
      | Auto_BuyerCompany | North California Express | 11       | 12        | In stock     | currentDate | currentDate | [blank]             | [blank]  |
      | Auto_BuyerCompany | South California Express | 11       | 12        | In stock     | currentDate | currentDate | [blank]             | [blank]  |
      | Auto_BuyerCompany | Florida Express          | 12       | 13        | In stock     | Plus1       | Plus2       | [blank]             | [blank]  |

    And Admin search Buyer Company specific "Auto Buyer Company Bao"
    And Admin choose regions and add to Buyer Company specific
      | regions             |
      | Chicagoland Express |
      | Florida Express     |
    And with Buyer Company-specific
      | buyerCompany           | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category         |
      | Auto Buyer Company Bao | Chicagoland Express | 12       | 13        | Out of stock | currentDate | currentDate | [blank]             | Vendor long-term |
#      | Auto Buyer Company Bao | Florida Express     | 12       | 13        | Launching soon | currentDate | currentDate | Plus1               | [blank]          |
      | Auto Buyer Company Bao | Florida Express     | 12       | 13        | In stock     | Minus2      | Minus1      | [blank]             | [blank]          |
    And Click Create
    And Admin check message of sku "auto sku 2 check create product" is "Variant have been saved successfully !!"

    And Go to "Buyer company-specific" tab
    And Admin check buyer company-specific of SKU
      | buyerCompany           | region                   | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category         | status   |
      | Auto_BuyerCompany      | North California Express | 11       | 12        | In stock     | currentDate | currentDate | [blank]             | [blank]          | Active   |
      | Auto_BuyerCompany      | South California Express | 11       | 12        | In stock     | currentDate | currentDate | [blank]             | [blank]          | Active   |
      | Auto Buyer Company Bao | Chicagoland Express      | 12       | 13        | Out of stock | currentDate | currentDate | [blank]             | Vendor long-term | Active   |
#      | Auto Buyer Company Bao | Florida Express     | 12       | 13        | Launching soon | currentDate | currentDate | Plus1               | [blank]          ||
      | Auto Buyer Company Bao | Florida Express          | 12       | 13        | In stock     | Minus2      | Minus1      | [blank]             | [blank]          | Inactive |
      | Auto_BuyerCompany      | Florida Express          | 12       | 13        | In stock     | Plus1       | Plus2       | [blank]             | [blank]          | Inactive |

  @Admin @TC_Admin_check_validate_Buyer_company_specifics
  Scenario: TC_Admin_check_validate_Buyer_company_specifics
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Change state of product id: "6636" to "active"
    And Admin delete order by sku of product "auto_product24" by api
    And Admin delete all sku in product id "6636" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
    And Check product not have SKU

    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | description               |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And Go to "Buyer company-specific" tab
    And Admin search Buyer Company specific "Bao Buyer Company"
    And Admin choose regions and add to Buyer Company specific
      | regions             |
      | Chicagoland Express |
      | Florida Express     |
    And with Buyer Company-specific
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate | endDate | inventoryArrivingAt | category |
      | Bao Buyer Company | Chicagoland Express | [blank]  | [blank]   | [blank]      | [blank]   | [blank] | [blank]             | [blank]  |
      | Bao Buyer Company | Florida Express     | [blank]  | [blank]   | [blank]      | [blank]   | [blank] | [blank]             | [blank]  |
    And Click Create
    And Admin check error on buyer company-specific of buyer: "Bao Buyer Company"
      | region              | field      | error                           |
      | Chicagoland Express | case-price | Please input a valid case price |
      | Chicagoland Express | msrp       | Please input a valid MSRP       |
#      | Chicagoland Express | availability | Please select availability status |
      | Chicagoland Express | start-date | Please input a valid start date |
      | Chicagoland Express | end-date   | Please input a valid end date   |
      | Florida Express     | case-price | Please input a valid case price |
      | Florida Express     | msrp       | Please input a valid MSRP       |
#      | Florida Express     | availability | Please select availability status |
      | Florida Express     | start-date | Please input a valid start date |
      | Florida Express     | end-date   | Please input a valid end date   |

    And with Buyer Company-specific
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate | endDate  | inventoryArrivingAt | category |
      | Bao Buyer Company | Chicagoland Express | -1       | -1        | [blank]      | 22/22/22  | 22/22/22 | [blank]             | [blank]  |
      | Bao Buyer Company | Florida Express     | -1       | -1        | [blank]      | 22/22/22  | 22/22/22 | [blank]             | [blank]  |
    And Click Create
    And Admin check error on buyer company-specific of buyer: "Bao Buyer Company"
      | region              | field      | error                           |
      | Chicagoland Express | case-price | Please input a valid case price |
      | Chicagoland Express | msrp       | Please input a valid MSRP       |
#      | Chicagoland Express | availability | Please select availability status |
#      | Chicagoland Express | start-date   | Please input a valid start date   |
#      | Chicagoland Express | end-date     | Please input a valid end date     |
      | Florida Express     | case-price | Please input a valid case price |
      | Florida Express     | msrp       | Please input a valid MSRP       |
#      | Florida Express     | availability | Please select availability status |
#      | Florida Express     | start-date   | Please input a valid start date   |
#      | Florida Express     | end-date     | Please input a valid end date     |

    And with Buyer Company-specific
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate | endDate | inventoryArrivingAt | category |
      | Bao Buyer Company | Chicagoland Express | a        | a         | [blank]      | [blank]   | [blank] | [blank]             | [blank]  |
      | Bao Buyer Company | Florida Express     | a        | a         | [blank]      | [blank]   | [blank] | [blank]             | [blank]  |
    And Click Create
    And Admin check error on buyer company-specific of buyer: "Bao Buyer Company"
      | region              | field      | error                           |
      | Chicagoland Express | case-price | Please input a valid case price |
      | Chicagoland Express | msrp       | Please input a valid MSRP       |
#      | Chicagoland Express | availability | Please select availability status |
      | Florida Express     | case-price | Please input a valid case price |
      | Florida Express     | msrp       | Please input a valid MSRP       |
#      | Florida Express     | availability | Please select availability status |
    And Remove region "Chicagoland Express" of buyer company-specific "Bao Buyer Company"

    And with Buyer Company-specific
      | buyerCompany      | region          | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category |
      | Bao Buyer Company | Florida Express | 11       | 12        | In stock     | currentDate | currentDate | [blank]             | [blank]  |
    And Click Create
    And Admin check message of sku "auto sku 2 check create product" is "Variant have been saved successfully !!"

    And Admin go back with button
    And Admin check SKU info on tab "active"
      | skuName                         | unitUpc       | caseUpc      | status | unitPerCase | codeSKU | regions |
      | auto sku 2 check create product | 1234567890981 | 123456789098 | Active | 12 per case | [blank] | FL      |
    And Admin go to SKU detail "auto sku 2 check create product"

    And Admin check general info of SKU
      | skuName                         | state  | itemCode | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | [blank]  | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10.0               | 30.0               | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And check Nutrition info of SKU
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | description               |
    And check qualities info of SKU
      | 100% Natural |
      | Gluten-Free  |
    And check Tags info of SKU
      | tagName | expiryDate |
      | [blank] | [blank]    |
    And Go to "Region-specific" tab
    And Check default "region" specific tab
      | alert                                                                                                                                                                                                                       | empty                              |
      | A store-specific price is applied with priority. If no store-specific price is set, a buyer-company-specific one is applied instead. If no buyer-company-specific price is set, a region-specific price is applied at last. | You don't have any defined region. |
    And Go to "Buyer company-specific" tab
    And Admin check buyer company-specific of SKU
      | buyerCompany      | region          | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category |
      | Bao Buyer Company | Florida Express | 11       | 12        | In stock     | currentDate | currentDate | [blank]             | [blank]  |

  @Admin @TC_Admin_edit_sku @EDIT_A_SKU_1
  Scenario: Check edit SKU information on the General tab successfully
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search product name "random product edit sku api" by api
    And Admin delete product name "random product edit sku api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | random product edit sku api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku edit sku api" of product ""
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | random product edit sku api | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "random product edit sku api"
    And Admin go to SKU detail "random sku edit sku api"
    And Admin check general info of SKU
      | skuName                 | state  | itemCode | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient  | leadTime | description | expireDayThreshold |
      | random sku edit sku api | Active | [blank]  | Yes     | 1         | 123123123123      | [blank]               | masterImage.jpg | 123123123123 | UPCImage.png | CaseImage.png | 1                | Dry              | 1               | Dry             | 1.0                | 1.0                | Chicago | Illinois         | Ingredients | [blank]  | Description | 100                |
    And check Nutrition info of SKU
      | nutritionLabel | nutritionLabelDescription |
      | anhJPG2.jpg    | [blank]                   |
    And check qualities info of SKU
      | 100% Natural |
    And Admin edit field general of SKU
      | field    | value                          |
      | SKU name | random sku edit sku api edited |
#    And Admin edit general info of SKU
#      | skuName                        | state | itemCode | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city | stateManufacture | ingredient | leadTime | description | expireDayThreshold |
#      | random sku edit sku api edited | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  |
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

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "random product edit sku api"
    And Search item and go to detail of first result
      | item                        | productName                 | productBrand              | pricePerUnit | pricePerCase | availability |
      | random product edit sku api | random product edit sku api | Auto brand create product | $11.00       | $11.00       | In Stock     |
    And Buyer choose SKU "random sku edit sku api edited" in product detail
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $11.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |

  @Admin @AD_Products_248
  Scenario: Check edit SKU information on the General tab successfully 2
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search product name "random product edit sku api" by api
    And Admin delete product name "random product edit sku api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | random product edit sku api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku edit sku api" of product ""
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | random product edit sku api | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "random product edit sku api"
    And Admin go to SKU detail "random sku edit sku api"
    And Admin check general info of SKU
      | skuName                 | state  | itemCode | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient  | leadTime | description | expireDayThreshold |
      | random sku edit sku api | Active | [blank]  | Yes     | 1         | 123123123123      | [blank]               | masterImage.jpg | 123123123123 | UPCImage.png | CaseImage.png | 1                | Dry              | 1               | Dry             | 1.0                | 1.0                | Chicago | Illinois         | Ingredients | [blank]  | Description | 100                |
    And Go to "Region-specific" tab
    And Admin edit region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 11        | 11       | In stock     | [blank]  |
    And date for region specific
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Click Create
    And Admin verify alert when create product
      | Variant have been saved successfully !! |
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category | state  |
      | Chicagoland Express | 11        | 11       | In stock     | [blank]  | [blank]        | [blank]  | active |
    And Admin check date of region-specific of SKU
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Admin edit region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 12        | 12       | In stock     | [blank]  |
    And date for region specific
      | region              | startDate | endDate  |
      | Chicagoland Express | 09/02/23  | 08/02/23 |
    And Click on button "Update"
    And BAO_ADMIN2 check alert message
      | Validation failed: Variants regions variants regions config start date must be before or equal to |
    And date for region specific
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |
    And Click Create
    And Admin verify alert when create product
      | Variant have been saved successfully !! |
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category | state    |
      | Chicagoland Express | 12        | 12       | In stock     | [blank]  | [blank]        | [blank]  | inactive |
    And Admin check date of region-specific of SKU
      | region              | startDate   | endDate     |
      | Chicagoland Express | currentDate | currentDate |

  @Admin @TC_Admin_create_sku_with_store_specifics
  Scenario: TC_Admin_create_sku_with_Store_specifics
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Change state of product id: "6636" to "active"
    And Admin delete order by sku of product "auto_product24" by api
    And Admin delete all sku in product id "6636" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
    And Check product not have SKU

    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Store-specific" tab
    And with Store-specific
      | region              | store                  | msrp    | casePrice | availability | arriving | start   | end     | category |
      | Chicagoland Express | Auto Bao Store Express | [blank] | [blank]   | [blank]      | [blank]  | [blank] | [blank] | [blank]  |

    And Admin check store-specific of SKU
      | store                   | msrp | casePrice | availability | arriving | start   | end     | category |
      | Auto Bao Store Express1 | 0    | 0         | Out of stock | [blank]  | [blank] | [blank] | [blank]  |

    And with Store-specific
      | region              | store                  | msrp | casePrice | availability | arriving | start       | end         | category |
      | Chicagoland Express | Auto Bao Store Express | 21   | 20        | In stock     | [blank]  | currentDate | currentDate | [blank]  |
    And Click Create
    And Admin check message of sku "auto 1 check create product" is "Variant have been saved successfully !!"
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                   | msrp | casePrice | availability | arriving | start       | end         | category |
      | Auto Bao Store Express1 | 21   | 20        | In stock     | [blank]  | currentDate | currentDate | [blank]  |

  @Admin @TC_Check_show_a_popup_when_click_on_the_Add_multiple_stores_of_a_buyer_company
  Scenario: TC_Check_show_a_popup_when_click_on_the_Add_multiple_stores_of_a_buyer_company
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto_product24" by api
    And Admin delete all sku in product id "6636" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
    And Check product not have SKU

    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 1 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Store-specific" tab
    And Check default "store" specific tab
      | alert                                                                                                                                                                                                                       | empty                             |
      | A store-specific price is applied with priority. If no store-specific price is set, a buyer-company-specific one is applied instead. If no buyer-company-specific price is set, a region-specific price is applied at last. | You don't have any defined store. |
    And Click on button "Add multiple stores of a buyer company"
    And Add multiple stores of Buyer company with info
      | buyer                  | msrp | casePrice | availability | arriving | start       | end         | category |
      | Auto Buyer Company Bao | 21   | 20        | In stock     | [blank]  | currentDate | currentDate | [blank]  |

    And Choose check, uncheck "a" stores of Buyer company
      | store                             |
      | Auto Store check order creditcard |
      | Auto store 2 switch mov moq       |
      | Auto store switch mov moq         |
#    And Choose "not" stores of Buyer company
#      | store                              |
#      | Auto store check Order PD Print SL |
#      | Auto Store check Orrder NY         |
#      | Auto store 2 check add to cart moq |
    And Confirm add multiple store
    And Click Create
    And Admin check message of sku "auto 1 check create product" is "Variant have been saved successfully !!"
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                              | msrp | casePrice | availability | arriving | start       | end         | category |
      | Auto store check Order PD Print SL | 21   | 20        | In stock     | [blank]  | currentDate | currentDate | [blank]  |
      | Auto Store check Orrder NY         | 21   | 20        | In stock     | [blank]  | currentDate | currentDate | [blank]  |
      | Auto store 2 check add to cart moq | 21   | 20        | In stock     | [blank]  | currentDate | currentDate | [blank]  |

  @Admin @TC_Admin_check_validate_create_sku_with_store_specifics @FN_4.4_Verify_Store_specific_tab
  Scenario: TC_Admin_check_validate_create_sku_with_Store_specifics
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Change state of product id: "6636" to "active"
    And Admin delete order by sku of product "auto_product24" by api
    And Admin delete all sku in product id "6636" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
    And Check product not have SKU

    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 1 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Store-specific" tab
    And Check default "store" specific tab
      | alert                                                                                                                                                                                                                       | empty                             |
      | A store-specific price is applied with priority. If no store-specific price is set, a buyer-company-specific one is applied instead. If no buyer-company-specific price is set, a region-specific price is applied at last. | You don't have any defined store. |

    And Search and add Store-specific
      | region              | store                   |
      | Chicagoland Express | Auto Bao Store Express1 |
    And with Store-specific
      | region              | store                   | msrp    | casePrice | availability | arriving | category | start   | end     |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | [blank]      | [blank]  | [blank]  | [blank] | [blank] |
    And Click Create

    And Admin check error on buyer company-specific of buyer: "Auto_BuyerCompany"
      | region              | field      | error                           |
      | Chicagoland Express | case-price | Please input a valid case price |
      | Chicagoland Express | msrp       | Please input a valid MSRP       |
#      | Chicagoland Express | availability | Please select availability status |
      | Chicagoland Express | start-date | Please input a valid start date |
      | Chicagoland Express | end-date   | Please input a valid end date   |
    And with Store-specific
      | region              | store                   | msrp | casePrice | availability | arriving | category | start   | end     |
      | Chicagoland Express | Auto Bao Store Express1 | -1   | -1        | [blank]      | [blank]  | [blank]  | [blank] | [blank] |
    And Click Create
    And Admin check error on buyer company-specific of buyer: "Auto_BuyerCompany"
      | region              | field      | error                           |
      | Chicagoland Express | case-price | Please input a valid case price |
      | Chicagoland Express | msrp       | Please input a valid MSRP       |
#      | Chicagoland Express | availability | Please select availability status |
      | Chicagoland Express | start-date | Please input a valid start date |
      | Chicagoland Express | end-date   | Please input a valid end date   |

    And with Store-specific
      | region              | store                   | msrp | casePrice | availability | arriving | category | start | end |
      | Chicagoland Express | Auto Bao Store Express1 | 1    | 1         | [blank]      | [blank]  | [blank]  | A     | A   |
    And Click Create
    And Admin check error on buyer company-specific of buyer: "Auto_BuyerCompany"
      | region              | field      | error                           |
#      | Chicagoland Express | availability | Please select availability status |
      | Chicagoland Express | start-date | Please input a valid start date |
      | Chicagoland Express | end-date   | Please input a valid end date   |

    And Remove region "Chicagoland Express" of buyer company-specific "Auto_BuyerCompany"

    And with Store-specific
      | region                   | store                       | msrp | casePrice | availability | arriving | category                       | start       | end         |
      | Chicagoland Express      | Auto Bao Store Express1     | 21   | 20        | In stock     | [blank]  | [blank]                        | Minus1      | currentDate |
      | Florida Express          | Auto store Florida          | 21   | 20        | Out of stock | [blank]  | Vendor short-term              | currentDate | Plus2       |
#      | Mid Atlantic Express           | Auto Mid atlantic                          | 21   | 20        | Launching soon | currentDate | [blank]                        | Minus1      | Plus1       |
      | New York Express         | Auto store NY               | 21   | 20        | In stock     | [blank]  | [blank]                        | currentDate | currentDate |
      | North California Express | Auto Store North California | 21   | 20        | Out of stock | [blank]  | Vendor long-term               | Plus1       | Plus2       |
#      | South California Express       | Auto Store South California                | 21   | 20        | Launching soon | Minus1      | [blank]                        | Minus1      | Plus1       |
      | Dallas Express           | Auto Store Taxas            | 21   | 20        | Out of stock | [blank]  | Discontinued by vendor         | Minus1      | currentDate |
      | Pod Direct Central       | Auto Store PDM              | 21   | 20        | In stock     | [blank]  | [blank]                        | currentDate | Plus1       |
      | Pod Direct East          | Auto storte PD Northeast    | 21   | 20        | Out of stock | [blank]  | Pending vendor response        | Plus1       | currentDate |
#      | Pod Direct Southeast           | Auto store pd southeast                    | 21   | 20        | Launching soon | Plus1       | [blank]                        | Plus1       | Plus2       |
#      | Pod Direct Southwest & Rockies | Auto store pod direct southeast an rockies | 21   | 20        | In stock     | [blank]  | [blank]                        | Minus1      | currentDate |
      | Pod Direct West          | Auto store pod direct west  | 21   | 20        | Out of stock | [blank]  | Product replacement/transition | Minus1      | Plus1       |
    And Click Create
    And Admin verify content of alert
      | Validation failed: Stores variants regions Time config start date must be before or equal to |

    And with Store-specific
      | region          | store                    | msrp | casePrice | availability | arriving | category                | start       | end         |
      | Pod Direct East | Auto storte PD Northeast | 21   | 20        | Out of stock | [blank]  | Pending vendor response | currentDate | currentDate |
    And Click Create

    And Admin check message of sku "auto 1 check create product" is "Variant have been saved successfully !!"
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                       | msrp | casePrice | availability | arriving | category                       | start       | end         |
      | Auto Bao Store Express1     | 21   | 20        | In stock     | [blank]  | [blank]                        | Minus1      | currentDate |
      | Auto store Florida          | 21   | 20        | Out of stock | [blank]  | Vendor short-term              | currentDate | Plus2       |
#      | Auto Mid atlantic                          | 21   | 20        | Launching soon | currentDate | [blank]                        | Minus1      | Plus1       |
      | Auto store NY               | 21   | 20        | In stock     | [blank]  | [blank]                        | currentDate | currentDate |
      | Auto Store North California | 21   | 20        | Out of stock | [blank]  | Vendor long-term               | Plus1       | Plus2       |
#      | Auto Store South California                | 21   | 20        | Launching soon | Minus1      | [blank]                        | Minus1      | Plus1       |
      | Auto Store Taxas            | 21   | 20        | Out of stock | [blank]  | Discontinued by vendor         | Minus1      | currentDate |
      | Auto Store PDM              | 21   | 20        | In stock     | [blank]  | [blank]                        | currentDate | Plus1       |
      | Auto storte PD Northeast    | 21   | 20        | Out of stock | [blank]  | Pending vendor response        | currentDate | currentDate |
#      | Auto store pd southeast                    | 21   | 20        | Launching soon | Plus1       | [blank]                        | Plus1       | Plus2       |
#      | Auto store pod direct southeast an rockies | 21   | 20        | In stock     | [blank]  | [blank]                        | Minus1      | currentDate |
      | Auto store pod direct west  | 21   | 20        | Out of stock | [blank]  | Product replacement/transition | Minus1      | Plus1       |

  @Admin @TC_Admin_check_duplicate_sku1
  Scenario: Check the Duplicate a SKU function which has Prop65 form already
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API

    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Pod Direct West | 54 | active | in_stock     | 1000      | 1000 |
    And Info of Prop65
      | containChemical | firstName | lastName | email                           | skuId   | vendorCompanyId |
      | false           | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | [blank] | 1847            |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |

    And Admin go to detail of product "auto bao create product 1"
    And Admin check SKU info on tab "active"
      | skuName    | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | sku random | 123123123123 | [blank] | Active | 1 per case  | not check | PDW     |
    And Admin "Yes" duplicate SKU "sku random" on list
    And Admin check SKU info on tab "draft"
      | skuName            | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Copy of sku random | 123123123123 | [blank] | Draft  | 1 per case  | not check | PDW     |
    And Admin go to SKU detail "Copy of sku random"
    And Admin check general info of SKU
      | skuName            | state | itemCode  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city    | stateManufacture | ingredient  | leadTime | description | expireDayThreshold |
      | Copy of sku random | Draft | not check | [blank] | 1         | 123123123123      | no                    | masterImage.jpg | 123123123123 | UPCImage.png | CaseImage.png | 1                | Dry              | 1               | Dry             | [blank]            | [blank]            | Chicago | Illinois         | Ingredients | [blank]  | Description | 100                |
    And check Nutrition info of SKU
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And check qualities info of SKU
      | 100% Natural |
    And Admin check have no Prop65 info on general SKU

  @Admin @TC_Admin_Mass_editing_SKU_Function @6.
  Scenario: Mass editing SKUs function Check adding new regions when select one of regions in [Pod Direct West, North California Express and South California Express]
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API

    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Pod Direct West | 54 | active | in_stock     | 1000      | 1000 |
    And Info of Prop65
      | containChemical | firstName | lastName | email                           | skuId   | vendorCompanyId |
      | false           | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | [blank] | 1847            |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    And Info of Region
      | region                   | id | state  | availability | casePrice | msrp |
      | North California Express | 25 | active | in_stock     | 1000      | 1000 |
    And Info of Prop65
      | containChemical | firstName | lastName | email                           | skuId   | vendorCompanyId |
      | false           | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | [blank] | 1847            |
    And Admin create a "active" SKU from admin with name "sku 2 random" of product ""
    And Info of Region
      | region                   | id | state  | availability | casePrice | msrp |
      | South California Express | 51 | active | in_stock     | 1000      | 1000 |
    And Info of Prop65
      | containChemical | firstName | lastName | email                           | skuId   | vendorCompanyId |
      | false           | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | [blank] | 1847            |
    And Admin create a "active" SKU from admin with name "sku 3 random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |

    And Admin go to detail of product "auto bao create product 1"
    And Admin click Mass editing SKU
    And Admin check SKU on Mass editing
      | sku          | image       | upc          | endQty  |
      | sku random   | anhJPG2.jpg | 123123123123 | [blank] |
      | sku 2 random | anhJPG2.jpg | 123123123123 | [blank] |
      | sku 3 random | anhJPG2.jpg | 123123123123 | [blank] |
    And Admin click update Mass editing SKU
    And Admin verify content of dialog
      | Please select a variant                              |
      | Please select a region or a buyer company or a store |
    And Admin Mass editing choose "a" SKU
      | sku          |
      | sku 2 random |
      | sku 3 random |
    And Admin click update Mass editing SKU
    And Admin verify content of dialog
      | Please select a region or a buyer company or a store |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |

    And Admin click Mass editing SKU
    And Admin Mass editing choose "a" SKU
      | sku        |
      | sku random |
#    And with Tags
#      | tagName       | expiryDate |
#      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 12        | 15       | In stock     | [blank]  |
    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |

    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | brandName                 | productType | availableIn | tags    |
      | auto bao create product 1 | Auto brand create product | Bao Bakery  | CHI         | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | auto bao create product 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | 1"×1"×1"   |
    And Admin check SKU info on tab "active"
      | skuName      | unitUpc      | caseUpc      | status | unitPerCase | codeSKU   | regions |
      | sku random   | 123123123123 | 123123123123 | Active | 1 per case  | not check | PDW     |
      | sku random   | 123123123123 | 123123123123 | Active | 1 per case  | not check | CHI     |
      | sku 2 random | 123123123123 | 123123123123 | Active | 1 per case  | not check | SF      |
      | sku 3 random | 123123123123 | 123123123123 | Active | 1 per case  | not check | LA      |
#    And Admin check tags of SKU "sku random" on list SKU
#      | tagName           | expiry  |
#      | Private SKU tag_1 | [blank] |
    And Admin check tags of SKU "sku 2 random" on list SKU
      | tagName       | expiry |
#      | Private SKU tag_1 | [blank] |
      | Auto Bao Tags | Plus1  |
    And Admin check tags of SKU "sku 3 random" on list SKU
      | tagName       | expiry |
#      | Private SKU tag_1 | [blank] |
      | Auto Bao Tags | Plus1  |

  @Admin @TC_Admin_Mass_editing_SKU_Function2
  Scenario: Mass editing SKUs function Check display condition of the total inventory end-quantity by SKU
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api

    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API
    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    And Admin create inventory api1
      | index | sku        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | sku random | random             | 10       | random   | 90           | Plus1        | [blank]     | [blank] |
    And Info of Region
      | region                   | id | state  | availability | casePrice | msrp |
      | North California Express | 25 | active | in_stock     | 1000      | 1000 |
      | South California Express | 51 | active | in_stock     | 1000      | 1000 |
    And Info of Prop65
      | containChemical | firstName | lastName | email                           | skuId   | vendorCompanyId |
      | false           | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | [blank] | 1847            |
    And Admin create a "active" SKU from admin with name "sku 2 random" of product ""

    And Admin create inventory api1
      | index | sku          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 2     | sku 2 random | random             | 10       | random   | 98           | Plus1        | [blank]     | [blank] |
    And Admin create inventory api1
      | index | sku          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 3     | sku 2 random | random             | 5        | random   | 98           | Plus1        | [blank]     | [blank] |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin click Mass editing SKU
    And Admin check SKU on Mass editing
      | sku          | image       | upc          | endQty  |
      | sku random   | anhJPG2.jpg | 123123123123 | [blank] |
      | sku 2 random | anhJPG2.jpg | 123123123123 | [blank] |
#      | sku 3 random | anhJPEG.jpg | 123123123123 | [blank]  |
    And Admin check end quantity of SKU "sku random" on Mass editing
      | region              | endQty |
      | Chicagoland Express | 10     |
    And Admin check end quantity of SKU "sku 2 random" on Mass editing
      | region                   | endQty |
      | North California Express | 15     |
#      | South California Express | 10     |
    And Admin click update Mass editing SKU
    And Admin verify content of dialog
      | Please select a variant                              |
      | Please select a region or a buyer company or a store |
    And Admin Mass editing choose "a" SKU
      | sku          |
      | sku 2 random |
#      | sku 3 random |
    And Admin click update Mass editing SKU
    And Admin verify content of dialog
      | Please select a region or a buyer company or a store |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |

    And Admin click Mass editing SKU
    And Admin Mass editing choose "a" SKU
      | sku        |
      | sku random |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 12        | 15       | In stock     | [blank]  |
    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |

    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin check list of product after searching
      | term                      | brandName                 | productType | availableIn | tags    |
      | auto bao create product 1 | Auto brand create product | Bao Bakery  | CHI         | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | auto bao create product 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | 1"×1"×1"   |
    And Admin check SKU info on tab "active"
      | skuName      | unitUpc      | caseUpc      | status | unitPerCase | codeSKU   | regions |
      | sku random   | 123123123123 | 123123123123 | Active | 1 per case  | not check | CHI     |
      | sku 2 random | 123123123123 | 123123123123 | Active | 1 per case  | not check | SF      |
      | sku 2 random | 123123123123 | 123123123123 | Active | 1 per case  | not check | LA      |
#      | sku 3 random | 123123123123 | 123123123123 | Active | 1 per case  | not check | LA      |
    And Admin check tags of SKU "sku random" on list SKU
      | tagName           | expiry  |
      | Private SKU tag_1 | [blank] |
    And Admin check tags of SKU "sku 2 random" on list SKU
      | tagName           | expiry  |
      | Private SKU tag_1 | [blank] |
      | Auto Bao Tags     | Plus1   |

  @Admin @TC_Admin_Mass_editing_SKU_Function3
  Scenario: Check adding new regions when select regions excepts Pod Direct West, North California Express and South California Express
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API

    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |

    And Admin go to detail of product "auto bao create product 1"
    And Admin click Mass editing SKU
    And Admin check SKU on Mass editing
      | sku        | image       | upc          | endQty  |
      | sku random | anhJPG2.jpg | 123123123123 | [blank] |
    And Admin Mass editing choose "a" SKU
      | sku        |
      | sku random |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |

    And Go to "Region-specific" tab
    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving |
      | Pod Direct West          | 12        | 15       | In stock     | [blank]  |
      | North California Express | 12        | 15       | In stock     | [blank]  |
      | South California Express | 12        | 15       | In stock     | [blank]  |
    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |

    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin check product detail
      | stateStatus | productName               | brand                     | vendorCompany       | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | auto bao create product 1 | Auto brand create product | Auto vendor company | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | 1"×1"×1"   |
    And Admin check SKU info on tab "active"
      | skuName    | unitUpc      | caseUpc      | status | unitPerCase | codeSKU   | regions |
      | sku random | 123123123123 | 123123123123 | Active | 1 per case  | not check | CHI     |
    And Admin check tags of SKU "sku random" on list SKU
      | tagName       | expiry |
      | Auto Bao Tags | Plus1  |

  @Admin @TC_Admin_Mass_editing_SKU_Function4
  Scenario: Admin mass editing Check validation of the fields on create region-specific form
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API
    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin click Mass editing SKU
    And Admin check SKU on Mass editing
      | sku        | image       | upc          | endQty  |
      | sku random | anhJPG2.jpg | 123123123123 | [blank] |
    And Admin Mass editing choose "a" SKU
      | sku        |
      | sku random |
    And Go to "Region-specific" tab
    And with region specific
      | regionName     | casePrice | msrpunit | availability | arriving |
      | Dallas Express | [blank]   | [blank]  | [blank]      | [blank]  |

    And Admin click update Mass editing SKU
    And Admin check message is showing of fields when create sku
      | field        | message                           |
      | Case price   | Please input a valid case price   |
      | MSRP/unit    | Please input a valid MSRP         |
      | Availability | Please select availability status |

    And Remove region "Dallas Express"
    And with region specific
      | regionName      | casePrice | msrpunit | availability | arriving |
      | Pod Direct West | [blank]   | [blank]  | [blank]      | [blank]  |
    And Admin click update Mass editing SKU
    And Admin check message is showing of fields when create sku
      | field        | message                           |
      | Case price   | Please input a valid case price   |
      | MSRP/unit    | Please input a valid MSRP         |
      | Availability | Please select availability status |

    And with region specific
      | regionName      | casePrice | msrpunit | availability | arriving |
      | Pod Direct West | [blank]   | [blank]  | In stock     | [blank]  |
    And Admin click update Mass editing SKU
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
      | MSRP/unit  | Please input a valid MSRP       |

    And with region specific
      | regionName      | casePrice | msrpunit | availability | arriving          |
      | Pod Direct West | [blank]   | [blank]  | Out of stock | Vendor short-term |
    And Admin click update Mass editing SKU
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
    And with region specific
      | regionName      | casePrice | msrpunit | availability | arriving         |
      | Pod Direct West | [blank]   | [blank]  | Out of stock | Vendor long-term |
    And Admin click update Mass editing SKU
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
      | MSRP/unit  | Please input a valid MSRP       |

    And with region specific
      | regionName      | casePrice | msrpunit | availability | arriving               |
      | Pod Direct West | [blank]   | [blank]  | Out of stock | Discontinued by vendor |
    And Admin click update Mass editing SKU
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
      | MSRP/unit  | Please input a valid MSRP       |

    And with region specific
      | regionName      | casePrice | msrpunit | availability | arriving                |
      | Pod Direct West | [blank]   | [blank]  | Out of stock | Pending vendor response |
    And Admin click update Mass editing SKU
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
      | MSRP/unit  | Please input a valid MSRP       |

    And with region specific
      | regionName      | casePrice | msrpunit | availability | arriving                       |
      | Pod Direct West | [blank]   | [blank]  | Out of stock | Product replacement/transition |
    And Admin click update Mass editing SKU
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
      | MSRP/unit  | Please input a valid MSRP       |
#    And with region specific
#      | regionName      | casePrice | msrpunit | availability   | arriving    |
#      | Pod Direct West | [blank]   | [blank]  | Launching soon | currentDate |
#    And Admin click update Mass editing SKU
#    And Admin check message is showing of fields when create sku
#      | field      | message                         |
#      | Case price | Please input a valid case price |
#      | MSRP/unit  | Please input a valid MSRP       |

    And with region specific
      | regionName      | casePrice | msrpunit | availability | arriving |
      | Pod Direct West | -1        | -1       | [blank]      | [blank]  |
    And Admin click update Mass editing SKU
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
      | MSRP/unit  | Please input a valid MSRP       |

    And Admin increase field number tooltip 1 times
      | field      | text |
      | Case price | 0    |
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
    And Admin increase field number tooltip 1 times
      | field      | text |
      | Case price | 0.01 |
    And Admin check message not showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |
    And Admin decrease field number tooltip 2 times
      | field      | text |
      | Case price | 0    |
    And Admin check message is showing of fields when create sku
      | field      | message                         |
      | Case price | Please input a valid case price |

    And Admin increase field number tooltip 1 times
      | field     | text |
      | MSRP/unit | 0    |
    And Admin check message is showing of fields when create sku
      | field     | message                   |
      | MSRP/unit | Please input a valid MSRP |
    And Admin increase field number tooltip 1 times
      | field     | text |
      | MSRP/unit | 0.01 |
    And Admin check message not showing of fields when create sku
      | field     | message                   |
      | MSRP/unit | Please input a valid MSRP |
    And Admin decrease field number tooltip 2 times
      | field     | text |
      | MSRP/unit | 0    |
    And Admin check message is showing of fields when create sku
      | field     | message                   |
      | MSRP/unit | Please input a valid MSRP |

    And with region specific
      | regionName      | casePrice | msrpunit  | availability | arriving |
      | Pod Direct West | 1         | 123456789 | In stock     | [blank]  |
    And Admin click update Mass editing SKU

    And Admin verify content of alert
      | 12345678900 is out of range for ActiveModel::Type::Integer with limit 4 bytes |

  @Admin @AD_Products_322
  Scenario: Admin mass editing Check admin edit Start date - End date datepicker
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API
    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin click Mass editing SKU
    And Admin check SKU on Mass editing
      | sku        | image       | upc          | endQty  |
      | sku random | anhJPG2.jpg | 123123123123 | [blank] |
    And Admin Mass editing choose "a" SKU
      | sku        |
      | sku random |

    And Go to "Region-specific" tab
    And Edit date for region specific mass editing
      | region              | startDate | endDate |
      | Chicagoland Express | Minus2    | Minus1  |
#    And Admin verify content of alert
#      | Variant have been saved successfully !! |
    And Add new Region specific on Mass editing
      | regionName     | casePrice | msrpunit | availability | arriving | startDate   | endDate     |
      | Dallas Express | 11        | 11       | In stock     | [blank]  | currentDate | currentDate |
    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |

    And Admin go to SKU detail "sku random"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | [blank]        | [blank]  |
      | Dallas Express      | 11        | 11       | In stock     | [blank]  | [blank]        | [blank]  |
    And Admin check date of region-specific of SKU
      | region              | startDate   | endDate     | state    |
      | Chicagoland Express | Minus2      | Minus1      | inactive |
      | Dallas Express      | currentDate | currentDate | active   |

  @Admin @EDIT_A_SKU_113
  Scenario:Admin mass editing Check display of all information on the Buyer company-specific tab
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API

    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |

    And Admin go to detail of product "auto bao create product 1"
    And Admin click Mass editing SKU
    And Admin check SKU on Mass editing
      | sku        | image       | upc          | endQty  |
      | sku random | anhJPG2.jpg | 123123123123 | [blank] |
    And Admin Mass editing choose "a" SKU
      | sku        |
      | sku random |

    And Go to "Buyer company-specific" tab
    And Admin search Buyer Company specific "Auto_BuyerCompany"
    And Admin choose regions and add to Buyer Company specific
      | regions                  |
      | North California Express |
      | South California Express |
    And with Buyer Company-specific
      | buyerCompany      | region                   | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category |
      | Auto_BuyerCompany | North California Express | 11       | 12        | In stock     | currentDate | currentDate | [blank]             | [blank]  |
      | Auto_BuyerCompany | South California Express | 11       | 12        | In stock     | currentDate | currentDate | [blank]             | [blank]  |
    And Admin search Buyer Company specific "Auto Buyer Company Bao"
    And Admin choose regions and add to Buyer Company specific
      | regions             |
      | Chicagoland Express |
      | Florida Express     |
    And with Buyer Company-specific
      | buyerCompany           | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category         |
      | Auto Buyer Company Bao | Chicagoland Express | 12       | 13        | Out of stock | currentDate | currentDate | [blank]             | Vendor long-term |
      | Auto Buyer Company Bao | Florida Express     | 12       | 13        | Out of stock | currentDate | currentDate | [blank]             | Vendor long-term |
    And Admin click update Mass editing SKU
#    And Admin check message of sku "sku random" is "Product has been mass updated successfully!"
    And Admin verify content of alert
      | Product has been mass updated successfully! |

    And Admin go to SKU detail "sku random"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | [blank]        | [blank]  |
    And Go to "Buyer company-specific" tab
    And Admin check buyer company-specific of SKU
      | buyerCompany           | region                   | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category         |
      | Auto_BuyerCompany      | North California Express | 11       | 12        | In stock     | currentDate | currentDate | [blank]             | [blank]          |
      | Auto_BuyerCompany      | South California Express | 11       | 12        | In stock     | currentDate | currentDate | [blank]             | [blank]          |
      | Auto Buyer Company Bao | Chicagoland Express      | 12       | 13        | Out of stock | currentDate | currentDate | [blank]             | Vendor long-term |
      | Auto Buyer Company Bao | Florida Express          | 12       | 13        | Out of stock | currentDate | currentDate | [blank]             | Vendor long-term |

  @Admin @TC_Admin_check_validate_Mass_Editing_Buyer_company_specifics
  Scenario:Admin mass editing Check validate on the Buyer company-specific tab
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API

    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |

    And Admin go to detail of product "auto bao create product 1"
    And Admin click Mass editing SKU
    And Admin check SKU on Mass editing
      | sku        | image       | upc          | endQty  |
      | sku random | anhJPG2.jpg | 123123123123 | [blank] |
    And Admin Mass editing choose "a" SKU
      | sku        |
      | sku random |

    And Go to "Buyer company-specific" tab
    And Admin search Buyer Company specific "Bao Buyer Company"
    And Admin choose regions and add to Buyer Company specific
      | regions             |
      | Chicagoland Express |
      | Florida Express     |
    And with Buyer Company-specific
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate | endDate | inventoryArrivingAt | category |
      | Bao Buyer Company | Chicagoland Express | [blank]  | [blank]   | [blank]      | [blank]   | [blank] | [blank]             | [blank]  |
      | Bao Buyer Company | Florida Express     | [blank]  | [blank]   | [blank]      | [blank]   | [blank] | [blank]             | [blank]  |
    And Admin click update Mass editing SKU
    And Admin check error on buyer company-specific of buyer: "Bao Buyer Company"
      | region              | field        | error                             |
      | Chicagoland Express | case-price   | Please input a valid case price   |
      | Chicagoland Express | msrp         | Please input a valid MSRP         |
      | Chicagoland Express | availability | Please select availability status |
      | Chicagoland Express | start-date   | Please input a valid start date   |
      | Chicagoland Express | end-date     | Please input a valid end date     |
      | Florida Express     | case-price   | Please input a valid case price   |
      | Florida Express     | msrp         | Please input a valid MSRP         |
      | Florida Express     | availability | Please select availability status |
      | Florida Express     | start-date   | Please input a valid start date   |
      | Florida Express     | end-date     | Please input a valid end date     |

    And with Buyer Company-specific
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate | endDate  | inventoryArrivingAt | category |
      | Bao Buyer Company | Chicagoland Express | -1       | -1        | [blank]      | 22/22/22  | 22/22/22 | [blank]             | [blank]  |
      | Bao Buyer Company | Florida Express     | -1       | -1        | [blank]      | 22/22/22  | 22/22/22 | [blank]             | [blank]  |
    And Admin click update Mass editing SKU
    And Admin check error on buyer company-specific of buyer: "Bao Buyer Company"
      | region              | field        | error                             |
      | Chicagoland Express | case-price   | Please input a valid case price   |
      | Chicagoland Express | msrp         | Please input a valid MSRP         |
      | Chicagoland Express | availability | Please select availability status |
#      | Chicagoland Express | start-date   | Please input a valid start date   |
#      | Chicagoland Express | end-date     | Please input a valid end date     |
      | Florida Express     | case-price   | Please input a valid case price   |
      | Florida Express     | msrp         | Please input a valid MSRP         |
      | Florida Express     | availability | Please select availability status |
#      | Florida Express     | start-date   | Please input a valid start date   |
#      | Florida Express     | end-date     | Please input a valid end date     |

    And with Buyer Company-specific
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate | endDate | inventoryArrivingAt | category |
      | Bao Buyer Company | Chicagoland Express | a        | a         | [blank]      | [blank]   | [blank] | [blank]             | [blank]  |
      | Bao Buyer Company | Florida Express     | a        | a         | [blank]      | [blank]   | [blank] | [blank]             | [blank]  |
    And Admin click update Mass editing SKU
    And Admin check error on buyer company-specific of buyer: "Bao Buyer Company"
      | region              | field        | error                             |
      | Chicagoland Express | case-price   | Please input a valid case price   |
      | Chicagoland Express | msrp         | Please input a valid MSRP         |
      | Chicagoland Express | availability | Please select availability status |
      | Florida Express     | case-price   | Please input a valid case price   |
      | Florida Express     | msrp         | Please input a valid MSRP         |
      | Florida Express     | availability | Please select availability status |
    And Remove region "Chicagoland Express" of buyer company-specific "Bao Buyer Company"

    And with Buyer Company-specific
      | buyerCompany      | region          | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category |
      | Bao Buyer Company | Florida Express | 11       | 12        | In stock     | currentDate | currentDate | [blank]             | [blank]  |
    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |
    And Admin go to SKU detail "sku random"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | [blank]        | [blank]  |
    And Go to "Buyer company-specific" tab
    And Admin check buyer company-specific of SKU
      | buyerCompany      | region          | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category |
      | Bao Buyer Company | Florida Express | 11       | 12        | In stock     | currentDate | currentDate | [blank]             | [blank]  |

  @Admin @EDIT_A_SKU_117
  Scenario:Admin mass editing Check display of all information on the Store-specific tab
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API

    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |

    And Admin go to detail of product "auto bao create product 1"
    And Admin click Mass editing SKU
    And Admin check SKU on Mass editing
      | sku        | image       | upc          | endQty  |
      | sku random | anhJPG2.jpg | 123123123123 | [blank] |
    And Admin Mass editing choose "a" SKU
      | sku        |
      | sku random |

    And Go to "Store-specific" tab
    And with Store-specific
      | region                   | store                       | msrp | casePrice | availability | arriving | category                       | start       | end         |
      | Chicagoland Express      | Auto Bao Store Express      | 21   | 20        | In stock     | [blank]  | [blank]                        | Minus1      | currentDate |
      | Florida Express          | Auto store Florida          | 21   | 20        | Out of stock | [blank]  | Vendor short-term              | currentDate | Plus2       |
#      | Mid Atlantic Express           | Auto Mid atlantic                          | 21   | 20        | Launching soon | currentDate | [blank]                        | Minus1      | Plus1       |
      | New York Express         | Auto store NY               | 21   | 20        | In stock     | [blank]  | [blank]                        | currentDate | currentDate |
      | North California Express | Auto Store North California | 21   | 20        | Out of stock | [blank]  | Vendor long-term               | Plus1       | Plus2       |
#      | South California Express       | Auto Store South California                | 21   | 20        | Launching soon | Minus1      | [blank]                        | Minus1      | Plus1       |
      | Dallas Express           | Auto Store Taxas            | 21   | 20        | Out of stock | [blank]  | Discontinued by vendor         | Minus1      | currentDate |
      | Pod Direct Central       | Auto Store PDM              | 21   | 20        | In stock     | [blank]  | [blank]                        | currentDate | Plus1       |
      | Pod Direct East          | Auto storte PD Northeast    | 21   | 20        | Out of stock | [blank]  | Pending vendor response        | Plus1       | currentDate |
#      | Pod Direct Southeast           | Auto store pd southeast                    | 21   | 20        | Launching soon | Plus1       | [blank]                        | Plus1       | Plus2       |
#      | Pod Direct Southwest & Rockies | Auto store pod direct southeast an rockies | 21   | 20        | In stock     | [blank]  | [blank]                        | Minus1      | currentDate |
      | Pod Direct West          | Auto store pod direct west  | 21   | 20        | Out of stock | [blank]  | Product replacement/transition | Minus1      | Plus1       |
    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Validation failed: Variants regions config start date must be before or equal to |

    And with Store-specific
      | region          | store                    | msrp | casePrice | availability | arriving | category                | start       | end         |
      | Pod Direct East | Auto storte PD Northeast | 21   | 20        | Out of stock | [blank]  | Pending vendor response | currentDate | currentDate |
    And Admin click update Mass editing SKU

    And Admin verify content of alert
      | Product has been mass updated successfully! |
    And Admin go to SKU detail "sku random"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | [blank]        | [blank]  |

    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                       | msrp | casePrice | availability | arriving | category                       | start       | end         |
      | Auto Bao Store Express1     | 21   | 20        | In stock     | [blank]  | [blank]                        | Minus1      | currentDate |
      | Auto store Florida          | 21   | 20        | Out of stock | [blank]  | Vendor short-term              | currentDate | Plus2       |
#      | Auto Mid atlantic                          | 21   | 20        | Launching soon | currentDate | [blank]                        | Minus1      | Plus1       |
      | Auto store NY               | 21   | 20        | In stock     | [blank]  | [blank]                        | currentDate | currentDate |
      | Auto Store North California | 21   | 20        | Out of stock | [blank]  | Vendor long-term               | Plus1       | Plus2       |
#      | Auto Store South California                | 21   | 20        | Launching soon | Minus1      | [blank]                        | Minus1      | Plus1       |
      | Auto Store Taxas            | 21   | 20        | Out of stock | [blank]  | Discontinued by vendor         | Minus1      | currentDate |
      | Auto Store PDM              | 21   | 20        | In stock     | [blank]  | [blank]                        | currentDate | Plus1       |
      | Auto storte PD Northeast    | 21   | 20        | Out of stock | [blank]  | Pending vendor response        | currentDate | currentDate |
#      | Auto store pd southeast                    | 21   | 20        | Launching soon | Plus1       | [blank]                        | Plus1       | Plus2       |
#      | Auto store pod direct southeast an rockies | 21   | 20        | In stock     | [blank]  | [blank]                        | Minus1      | currentDate |
      | Auto store pod direct west  | 21   | 20        | Out of stock | [blank]  | Product replacement/transition | Minus1      | Plus1       |

  @Admin @TC_EDIT_A_SKU_139
  Scenario: Admin mass editing
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |

    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API

    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Check product not have SKU
    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 1 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
#    And with Tags
#      | tagName       | expiryDate |
#      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 11        | 12       | In stock     | [blank]  |
    And Go to "Buyer company-specific" tab
    And Admin search Buyer Company specific "Auto_BuyerCompany"
    And Admin choose regions and add to Buyer Company specific
      | regions                  |
      | North California Express |
#      | South California Express |
    And with Buyer Company-specific
      | buyerCompany      | region                   | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category |
      | Auto_BuyerCompany | North California Express | 11       | 12        | Out of stock | currentDate | currentDate | [blank]             | [blank]  |
#    And Go to "Store-specific" tab
#    And with Store-specific
#      | region                   | store                      | msrp | casePrice | availability   | arriving | start       | end         | category |
#      | South California Express | Auto Store South Californi | 11   | 12        | Launching soon | [blank]  | currentDate | currentDate | [blank]  |
    And Click Create
    And Admin check message of sku "auto sku 1 check create product" is "Variant have been saved successfully !!"

    And Admin go back with button
    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab
    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving |
      | North California Express | 11        | 12       | In stock     | [blank]  |
    And Click Create
    And Admin check message of sku "auto sku 2 check create product" is "Variant have been saved successfully !!"
    And Admin go back with button
    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 3 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
#    And with Tags
#      | tagName       | expiryDate |
#      | Auto Bao Tags | Plus1      |
    And Go to "Region-specific" tab
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | 11        | 12       | In stock     | [blank]  |
    And Go to "Buyer company-specific" tab
    And Admin search Buyer Company specific "Auto_BuyerCompany"
    And Admin choose regions and add to Buyer Company specific
      | regions                  |
      | North California Express |
#      | South California Express |
    And with Buyer Company-specific
      | buyerCompany      | region                   | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category |
      | Auto_BuyerCompany | North California Express | 11       | 12        | Out of stock | currentDate | currentDate | [blank]             | [blank]  |
#    And Go to "Store-specific" tab
#    And with Store-specific
#      | region                   | store                       | msrp | casePrice | availability   | arriving | start       | end         | category |
#      | South California Express | Auto Store South California | 11   | 12        | Launching soon | [blank]  | currentDate | currentDate | [blank]  |
    And Click Create
    And Admin check message of sku "auto sku 3 check create product" is "Variant have been saved successfully !!"
    And Admin go back with button
#    Mass editing
    And Admin click Mass editing SKU
    And Admin Mass editing choose "a" SKU
      | sku                             |
      | auto sku 2 check create product |
      | auto sku 1 check create product |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |

#    And Go to "Region-specific" tab
#    And with region specific
#      | regionName               | casePrice | msrpunit | availability   | arriving    |
#      | North California Express | 12        | 15       | Launching soon | currentDate |
    And Go to "Buyer company-specific" tab
    And Admin search Buyer Company specific "Bao Buyer Company"
    And Admin choose regions and add to Buyer Company specific
      | regions              |
      | Mid Atlantic Express |
    And with Buyer Company-specific
      | buyerCompany      | region               | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category |
      | Bao Buyer Company | Mid Atlantic Express | 11       | 12        | Out of stock | currentDate | currentDate | [blank]             | [blank]  |
    And Go to "Store-specific" tab
    And with Store-specific
      | region                   | store                       | msrp | casePrice | availability | arriving | category | start       | end         |
      | South California Express | Auto Store South California | 21   | 20        | In stock     | [blank]  | [blank]  | currentDate | currentDate |
    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |

    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"

    And Admin check SKU info on tab "active"
      | skuName                         | unitUpc       | caseUpc      | status | unitPerCase | codeSKU   | regions |
      | auto sku 1 check create product | 1234567890981 | 123456789098 | Active | 12 per case | not check | CHI     |
    And Admin check SKU info on tab "active"
      | skuName                         | unitUpc       | caseUpc      | status | unitPerCase | codeSKU   | regions |
      | auto sku 1 check create product | 1234567890981 | 123456789098 | Active | 12 per case | not check | SF      |
    And Admin check SKU info on tab "active"
      | skuName                         | unitUpc       | caseUpc      | status | unitPerCase | codeSKU   | regions |
      | auto sku 1 check create product | 1234567890981 | 123456789098 | Active | 12 per case | not check | LA      |
    And Admin check SKU info on tab "active"
      | skuName                         | unitUpc       | caseUpc      | status | unitPerCase | codeSKU   | regions |
      | auto sku 1 check create product | 1234567890981 | 123456789098 | Active | 12 per case | not check | MA      |
    And Admin check tags of SKU "auto sku 1 check create product" on list SKU
      | tagName       | expiry |
      | Auto Bao Tags | Plus1  |

  @Admin @EDIT_A_SKU_121_139
  Scenario:Admin mass editing Check validate information on the Store-specific tab
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API

    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |

    And Admin go to detail of product "auto bao create product 1"
    And Admin click Mass editing SKU
    And Admin check SKU on Mass editing
      | sku        | image       | upc          | endQty  |
      | sku random | anhJPG2.jpg | 123123123123 | [blank] |
    And Admin Mass editing choose "a" SKU
      | sku        |
      | sku random |
    And Go to "Store-specific" tab

#    And Search and add Store-specific
#      | region              | store                  |
#      | Chicagoland Express | Auto Bao Store Express |
    And with Store-specific
      | region              | store                   | msrp    | casePrice | availability | arriving | category | start   | end     |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | [blank]      | [blank]  | [blank]  | [blank] | [blank] |
    And Admin click update Mass editing SKU

    And Admin check error on buyer company-specific of buyer: "Auto_BuyerCompany"
      | region              | field        | error                             |
      | Chicagoland Express | case-price   | Please input a valid case price   |
      | Chicagoland Express | msrp         | Please input a valid MSRP         |
      | Chicagoland Express | availability | Please select availability status |
      | Chicagoland Express | start-date   | Please input a valid start date   |
      | Chicagoland Express | end-date     | Please input a valid end date     |
    And with Store-specific
      | region              | store                   | msrp | casePrice | availability | arriving | category | start   | end     |
      | Chicagoland Express | Auto Bao Store Express1 | -1   | -1        | [blank]      | [blank]  | [blank]  | [blank] | [blank] |
    And Admin click update Mass editing SKU
    And Admin check error on buyer company-specific of buyer: "Auto_BuyerCompany"
      | region              | field        | error                             |
      | Chicagoland Express | case-price   | Please input a valid case price   |
      | Chicagoland Express | msrp         | Please input a valid MSRP         |
      | Chicagoland Express | availability | Please select availability status |
      | Chicagoland Express | start-date   | Please input a valid start date   |
      | Chicagoland Express | end-date     | Please input a valid end date     |

    And with Store-specific
      | region              | store                   | msrp | casePrice | availability | arriving | category | start | end |
      | Chicagoland Express | Auto Bao Store Express1 | 1    | 1         | [blank]      | [blank]  | [blank]  | A     | A   |
    And Admin click update Mass editing SKU
    And Admin check error on buyer company-specific of buyer: "Auto_BuyerCompany"
      | region              | field        | error                             |
      | Chicagoland Express | availability | Please select availability status |
      | Chicagoland Express | start-date   | Please input a valid start date   |
      | Chicagoland Express | end-date     | Please input a valid end date     |

    And Remove region "Chicagoland Express" of buyer company-specific "Auto_BuyerCompany"

    And with Store-specific
      | region                   | store                       | msrp | casePrice | availability | arriving | category         | start  | end         |
      | Chicagoland Express      | Auto Bao Store Express1     | 21   | 20        | In stock     | [blank]  | [blank]          | Minus1 | currentDate |
      | North California Express | Auto Store North California | 21   | 20        | Out of stock | [blank]  | Vendor long-term | Plus1  | Plus2       |
#      | Pod Direct Southeast     | Auto store pd southeast     | 21   | 20        | Launching soon | Plus1    | [blank]          | Plus1  | Plus2       |
    And Admin click update Mass editing SKU

  @Admin
  Scenario:Admin mass editing Check add multiple store of Buyer company on the Store-specific tab
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 2 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 2" from API
    And Admin delete all inventory by API

    And Admin search product name "auto bao create product 2" by api
    And Admin delete product name "auto bao create product 2" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 2 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 2 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |

    And Admin go to detail of product "auto bao create product 2"
    And Admin click Mass editing SKU
    And Admin check SKU on Mass editing
      | sku        | image       | upc          | endQty  |
      | sku random | anhJPG2.jpg | 123123123123 | [blank] |
    And Admin Mass editing choose "a" SKU
      | sku        |
      | sku random |
    And Go to "Store-specific" tab
    And Click on button "Add multiple stores of a buyer company"

    And Add multiple stores of Buyer company with info
      | buyer                  | msrp | casePrice | availability | arriving | start       | end         | category |
      | Auto Buyer Company Bao | 21   | 20        | In stock     | [blank]  | currentDate | currentDate | [blank]  |

    And Choose check, uncheck "a" stores of Buyer company
      | store                             |
      | Auto Store check order creditcard |
      | Auto store 2 switch mov moq       |
      | Auto store switch mov moq         |
    And Confirm add multiple store

    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                              | msrp | casePrice | availability | arriving | start       | end         | category |
      | Auto store check Order PD Print SL | 21   | 20        | In stock     | [blank]  | currentDate | currentDate | [blank]  |
      | Auto Store check Orrder NY         | 21   | 20        | In stock     | [blank]  | currentDate | currentDate | [blank]  |
      | Auto store 2 check add to cart moq | 21   | 20        | In stock     | [blank]  | currentDate | currentDate | [blank]  |
    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |
    And Admin go to SKU detail "sku random"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | [blank]        | [blank]  |

    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                              | msrp | casePrice | availability | arriving | category | start       | end         |
      | Auto store 2 check add to cart moq | 21   | 20        | In stock     | [blank]  | [blank]  | currentDate | currentDate |
      | Auto store check Order PD Print SL | 21   | 20        | In stock     | [blank]  | [blank]  | currentDate | currentDate |
      | Auto Store check Orrder NY         | 21   | 20        | In stock     | [blank]  | [blank]  | currentDate | currentDate |

  @Admin @7_Product_Recommendations
  Scenario: Admin create product recommendations
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 2" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 2 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 2" from API
    And Admin delete all inventory by API
    And Admin search product recommendation Buyer id "3186" by api
    And Admin delete product recommendation by api
    And Admin search product name "auto bao create product 2" by api
    And Admin delete product name "auto bao create product 2" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 2 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "Recommendations" by sidebar
    And Admin open create product recommendations popup
    And Admin confirm create product recommendations
    And Admin check message is showing of field "Buyer"
      | Please select a buyer to recommend. |
    And Admin check message is showing of field "Product"
      | Please select a product to recommend. |
    And Admin input invalid "Buyer" recommendation
      | field              |
      | Auto Buyer5333     |
      | Auto bao company 2 |

    And Admin input product recommendations
      | buyer        | product | comment |
      | Auto Buyer53 | [blank] | [blank] |
    And Admin confirm create product recommendations
    And Admin check message is showing of field "Product"
      | Please select a product to recommend. |
    And Admin close dialog form
    And Admin open create product recommendations popup

    And Admin input product recommendations
      | buyer        | product | comment |
      | Auto Buyer53 | [blank] | [blank] |
    And Admin input invalid "Product" recommendation
      | field                     |
      | auto bao create product 3 |
    And Admin close dialog form
    And Admin open create product recommendations popup

    And Admin input product recommendations
      | buyer        | product                   | comment |
      | Auto Buyer53 | auto bao create product 2 | comment |
    And Admin confirm create product recommendations
    And BAO_ADMIN2 navigate to "Products" to "Recommendations" by sidebar
#    And Admin verify pagination function
#    And Admin search product recommendations with buyer: "Auto Buyer5333"
#    And Admin check no data found
    And Admin search product recommendations with buyer: "Auto Buyer53"
    And Admin check product recommendations list
      | buyer        | product                   | brand                     | comment |
      | Auto Buyer53 | auto bao create product 2 | Auto brand create product | comment |
#    And Admin check message not showing of field "Buyer"
#      | Please select a buyer to recommend. |

  @Admin @7_Product_Recommendations2
  Scenario: Admin create product recommendations validate
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao 1 create product" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao 1 create product | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao 1 create product" from API
    And Admin delete all inventory by API
    And Admin delete order by sku of product "auto bao 2 create product" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao 2 create product | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao 2 create product" from API
    And Admin delete all inventory by API
    And Admin search product recommendation Buyer id "3186" by api
    And Admin delete product recommendation by api
    And Admin search product name "auto bao 1 create product" by api
    And Admin delete product name "auto bao 1 create product" by api
    And Admin search product name "auto bao 2 create product" by api
    And Admin delete product name "auto bao 2 create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao 1 create product | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao 2 create product | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku 2 random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "Recommendations" by sidebar
    And Admin open create product recommendations popup
#    And Admin input product recommendations
#      | buyer        | product                   | comment |
#      | Auto Buyer53 | auto bao 2 create product | comment |
#    And Admin confirm create product recommendations
#    And Admin verify content of alert
#      | Recommended product not active at region of buyer |
#    And Admin close dialog form
#    And Admin open create product recommendations popup
    And Admin input product recommendations
      | buyer        | product                   | comment |
      | Auto Buyer53 | auto bao 1 create product | comment |
    And Admin confirm create product recommendations

    And Admin open create product recommendations popup
    And Admin input product recommendations
      | buyer        | product                   | comment |
      | Auto Buyer53 | auto bao 1 create product | comment |
    And Admin confirm create product recommendations
    And Admin verify content of alert
      | Product has already been taken |

  @Admin @7_Product_Recommendations3
  Scenario: Admin EDIT Product Recommendations validate
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao 1 create product" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao 1 create product | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao 1 create product" from API
    And Admin delete all inventory by API

    And Admin search product recommendation Buyer id "3186" by api
    And Admin delete product recommendation by api
    And Admin search product recommendation Buyer id "3185" by api
    And Admin delete product recommendation by api
    And Admin search product name "auto bao 1 create product" by api
    And Admin delete product name "auto bao 1 create product" by api
    And Admin search product name "auto bao 2 create product" by api
    And Admin delete product name "auto bao 2 create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao 1 create product | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao 2 create product | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku 2 random" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "Recommendations" by sidebar
    And Admin open create product recommendations popup
    And Admin input product recommendations
      | buyer        | product                   | comment |
      | Auto Buyer53 | auto bao 1 create product | comment |
    And Admin confirm create product recommendations
    And BAO_ADMIN2 navigate to "Products" to "Recommendations" by sidebar

    And Admin search product recommendations with buyer: "Auto Buyer53"
    And Admin check product recommendations list
      | buyer        | product                   | brand                     | comment |
      | Auto Buyer53 | auto bao 1 create product | Auto brand create product | comment |
    And Admin open edit product recommendations "auto bao 1 create product"
    And Admin check recommendation info
      | buyer        | product                   | comment |
      | Auto Buyer53 | auto bao 1 create product | comment |
    And Admin input product recommendations
      | buyer        | product | comment |
      | Auto Buyer52 | [blank] | [blank] |
    And Admin confirm update product recommendations
    And Admin reset filter product recommendations
    And Admin search product recommendations with buyer: "Auto Buyer52"
    And Admin check product recommendations list
      | buyer        | product                   | brand                     | comment |
      | Auto Buyer52 | auto bao 1 create product | Auto brand create product | comment |
    And Admin open edit product recommendations "auto bao 1 create product"
    And Admin check recommendation info
      | buyer        | product                   | comment |
      | Auto Buyer52 | auto bao 1 create product | comment |
    And Admin input product recommendations
      | buyer   | product                   | comment |
      | [blank] | auto bao 2 create product | [blank] |
    And Admin confirm update product recommendations
    And Admin verify content of alert
      | Recommended product not active at region of buyer |

    And Admin close dialog form
    And Admin open create product recommendations popup
    And Admin input product recommendations
      | buyer        | product                   | comment |
      | Auto Buyer53 | auto bao 1 create product | comment |
    And Admin confirm create product recommendations
    And Admin search product recommendations with buyer: "Auto Buyer53"
    And Admin check product recommendations list
      | buyer        | product                   | brand                     | comment |
      | Auto Buyer53 | auto bao 1 create product | Auto brand create product | comment |
    And Admin click edit button product recommendations "auto bao 1 create product"
    And Admin check recommendation info
      | buyer        | product                   | comment |
      | Auto Buyer53 | auto bao 1 create product | comment |
    And Admin input product recommendations
      | buyer        | product                   | comment |
      | Auto Buyer52 | auto bao 1 create product | [blank] |
    And Admin confirm update product recommendations
    And Admin verify content of alert
      | Product has already been taken |
    And Admin close dialog form
    And Admin search product recommendations with buyer: "Auto Buyer53"
    And Admin "Cancel" delete product recommendations "auto bao 1 create product"
    And Admin check product recommendations list
      | buyer        | product                   | brand                     | comment |
      | Auto Buyer53 | auto bao 1 create product | Auto brand create product | comment |

    And Admin search product recommendations with buyer: "Auto Buyer53"
    And Admin "Understand & Continue" delete product recommendations "auto bao 1 create product"
    And Admin search product recommendations with buyer: "Auto Buyer53"
    And Admin check no data found

  @Admin @7_Product_Recommendations4
  Scenario: Admin export Product Recommendations validate
#    Given Admin set directory file
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
#    And Admin export file
    And BAO_ADMIN2 navigate to "Products" to "Recommendations" by sidebar
#    And Admin open create product recommendations popup
#    And Admin input product recommendations
#      | buyer        | product                   | comment |
#      | Auto Buyer53 | auto bao 1 create product | comment |
#    And Admin confirm create product recommendations
#    And BAO_ADMIN2 navigate to "Products" to "Recommendations" by sidebar

    And Admin search product recommendations with buyer: "Auto Buyer41"
    And Admin check product recommendations list
      | buyer        | product                        | brand                      | comment |
      | Auto Buyer41 | Auto product 3 add to cart mov | Auto brand add to cart mov | [blank] |
    And Admin export file

  @Admin @7_Product_Recommendations4 @AD_Products_394
  Scenario: Admin Product Recommendations Check display of the Edit visibility popup
    Given BAO_ADMIN23 login web admin by api
      | email             | password  |
      | bao23@podfoods.co | 12345678a |
     # Reset search filter full textbox
    And Admin filter visibility with id "49" by api
      | q[buyer_id] |

    And Admin delete filter preset of screen id "49" by api
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "Recommendations" by sidebar

    And Admin edit visibility search product
      | buyer   |
      | [blank] |
    Then Admin verify search product field not visible
      | buyer   |
      | [blank] |
    And Admin edit visibility search product
      | buyer   |
      | [blank] |
    Then Admin verify search product field visible
      | buyer   |
      | [blank] |

    And Admin search product recommendations with buyer: "Auto Buyer41"
    And Admin check product recommendations list
      | buyer        | product                        | brand                      | comment |
      | Auto Buyer41 | Auto product 3 add to cart mov | Auto brand add to cart mov | [blank] |
    And Admin save filter by info
      | filterName | type               |
      | [blank]    | Save as new preset |
    And BAO_ADMIN23 check error message is showing of fields on dialog
      | field       | message                         |
      | Preset name | Please enter name filter preset |
    And Admin close dialog form
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN23 check value of field
      | field | value        |
      | Buyer | Auto Buyer41 |
    And Admin check product recommendations list
      | buyer        | product                        | brand                      | comment |
      | Auto Buyer41 | Auto product 3 add to cart mov | Auto brand add to cart mov | [blank] |
    And Admin search product recommendations with buyer: "Auto Buyer53"
    And Admin check product recommendations list
      | buyer        | product                          | brand                  | comment |
      | Auto Buyer53 | random product buyer recommended | Auto Brand product moq | comment |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN23 check value of field
      | field | value        |
      | Buyer | Auto Buyer53 |
    And Admin check product recommendations list
      | buyer        | product                          | brand                  | comment |
      | Auto Buyer53 | random product buyer recommended | Auto Brand product moq | comment |
    And Admin delete filter preset is "AutoTest1"

  @Admin @TC_155
  Scenario: Check validation of the OOS Category Region-specific
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 155" by api
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]         | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto bao create product | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product" from API
    And Admin delete inventory "all" by API
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | auto bao create product 155 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku create product" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 155 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 155"
    And Admin go to SKU detail "random sku create product"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | [blank]        | [blank]  |

    And Admin edit region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | [blank]   | [blank]  | Out of stock | [blank]  |
    And Admin check dialog help text tooltip of field "OOS Category"
      | field                   | text                                                                                                          |
      | Pending Replenishment   | There isn’t any pending inbound inventory existing                                                            |
      | Vendor short-term       | Inbound inventory request exists AND its status = Approved AND (inventory request ETA minus today) <= 21 days |
      | Vendor long-term        | Inbound inventory request exists AND its status = Approved AND (inventory request ETA minus today) > 21 days  |
      | Pending vendor response | Inbound inventory request exists AND its status = Pod Planned                                                 |

#    Đang bug
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category              |
      | Chicagoland Express | 10        | 10       | Out of stock | [blank]  | [blank]        | Pending Replenishment |
      #Pending replenishment
    And with region specific
      | regionName      | casePrice | msrpunit | availability | arriving |
      | Florida Express | [blank]   | [blank]  | Out of stock | [blank]  |
    And Admin check region-specific of SKU
      | regionName      | casePrice | msrpunit | availability | arriving | inventoryCount | category          |
      | Florida Express | 0         | 0        | Out of stock | [blank]  | [blank]        | Vendor short-term |
    And with region specific
      | regionName         | casePrice | msrpunit | availability | arriving |
      | Pod Direct Central | [blank]   | [blank]  | Out of stock | [blank]  |
    And Admin check region-specific of SKU
      | regionName      | casePrice | msrpunit | availability | arriving | inventoryCount | category          |
      | Florida Express | 0         | 0        | Out of stock | [blank]  | [blank]        | Vendor short-term |
#Craete inbound
#         1.6. Inventory request exists AND status = Pod Planned for the associated Express region -> . Pending vendor response
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |

    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | [blank]        | [blank]  |
    And Admin edit region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | [blank]   | [blank]  | Out of stock | [blank]  |
#    Đang bug
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category                |
      | Chicagoland Express | 10        | 10       | Out of stock | [blank]  | [blank]        | Pending vendor response |
#    Pending vendor response
#Submit inbound
#  There is not case enough 4 condition (e.g: inventory request exists AND status = Submitted)
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                       | lot_code                  | quantity | expiry_date |
      | random sku create product | random sku create product | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | [blank]        | [blank]  |
    And Admin edit region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | [blank]   | [blank]  | Out of stock | [blank]  |
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category          |
      | Chicagoland Express | 10        | 10       | Out of stock | [blank]  | [blank]        | Vendor short-term |
      #Approve inbound
#  Inventory request exists AND status = Approved AND (inventory request ETA minus today) <= 21 days for the associated Express region
#    And Admin Approve Incoming Inventory id "api" api
    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | [blank]        | [blank]  |
    And Admin edit region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | [blank]   | [blank]  | Out of stock | [blank]  |
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category          |
      | Chicagoland Express | 10        | 10       | Out of stock | [blank]  | [blank]        | Vendor short-term |
#Delete inbound
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    #Create inbound
#    1.5. Inventory request exists AND status = Approved AND (inventory request ETA minus today) > 21 days for the associated Express region
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |
    #Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                       | lot_code                  | quantity | expiry_date |
      | random sku create product | random sku create product | 10       | Plus22      |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta    | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus22 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
 #Approve inbound
#  Inventory request exists AND status = Approved AND (inventory request ETA minus today) > 21 days for the associated Express region
#  Inventory request exists AND status = Confirmed AND (inventory request ETA minus today) > 21 days for the associated Express region
#    And Admin Approve Incoming Inventory id "api" api
    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | [blank]        | [blank]  |
    And Admin edit region specific
      | regionName          | casePrice | msrpunit | availability | arriving |
      | Chicagoland Express | [blank]   | [blank]  | Out of stock | [blank]  |
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category         |
      | Chicagoland Express | 10        | 10       | Out of stock | [blank]  | [blank]        | Vendor long-term |

  @Admin @TC_155_2
  Scenario: Check validation of the OOS Category Region-specific - automatically assign the OOS category
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]         | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto bao create product | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product" from API
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "auto bao create product 155" by api
    And Admin search product name "auto bao create product" by api
    And Admin delete product name "auto bao create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | auto bao create product 155 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Florida Express     | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku create product" of product ""

    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku create product | random             | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 2                       | 10       | Autotest |

    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku create product | random             | 10       | random   | 95           | currentDate  | [blank]     | [blank] |
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 2                       | 10       | Autotest |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 155 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 155"
    And Admin go to SKU detail "random sku create product"
    And Go to "Region-specific" tab
    #    Đang bug
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category              |
      | Chicagoland Express | 10        | 10       | Out of stock | [blank]  | 0 case         | Pending Replenishment |
      | Florida Express     | 10        | 10       | Out of stock | [blank]  | 0 case         | Pending Replenishment |
#  Pending replenishment
#  Craete inbound
#   Inventory request exists AND status = Pod Planned for the associated Express region -> . Pending vendor response
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |

    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Region-specific" tab
#Đang bug
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category                |
      | Chicagoland Express | 10        | 10       | Out of stock | [blank]  | 0 case         | Pending vendor response |
#      #Pending vendor response
#Submit inbound
#  There is not case enough 4 condition (e.g: inventory request exists AND status = Submitted)
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                       | lot_code                  | quantity | expiry_date |
      | random sku create product | random sku create product | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category          |
      | Chicagoland Express | 10        | 10       | Out of stock | [blank]  | 0 case         | Vendor short-term |
#      #Approve inbound
#  Inventory request exists AND status = Approved AND (inventory request ETA minus today) <= 21 days for the associated Express region
#    And Admin Approve Incoming Inventory id "api" api
    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category          |
      | Chicagoland Express | 10        | 10       | Out of stock | [blank]  | 0 case         | Vendor short-term |
#Cancel inbound
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    #Craete inbound
#    1.5. Inventory request exists AND status = Approved AND (inventory request ETA minus today) > 21 days for the associated Express region
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |
    #Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                       | lot_code                  | quantity | expiry_date |
      | random sku create product | random sku create product | 10       | Plus22      |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta    | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus22 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |

    #Craete inbound
#    1.5. Inventory request exists AND status = Approved AND (inventory request ETA minus today) > 21 days for the associated Express region
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 63        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 95           |
    #Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                       | lot_code                  | quantity | expiry_date |
      | random sku create product | random sku create product | 10       | Plus22      |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta    | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus22 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
#Approve inbound
#  Inventory request exists AND status = confirmed AND (inventory request ETA minus today) > 21 days for the associated Express region
#    And Admin Approve Incoming Inventory id "api" api
    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category          |
      | Chicagoland Express | 10        | 10       | Out of stock | [blank]  | 0 case         | Vendor short-term |
      | Florida Express     | 10        | 10       | Out of stock | [blank]  | 0 case         | Vendor long-term  |
      #Vendor long-term vì có 1 inbound status = cancel

  @Admin @TC_172
  Scenario: Check validation of the OOS Category Buyer company-specific
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Change state of product id: "6636" to "active"
    And Admin delete order by sku of product "auto_product24" by api
    And Admin delete all sku in product id "6636" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
    And Check product not have SKU

    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 2 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | description               |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And Go to "Buyer company-specific" tab
    And Admin search Buyer Company specific "Bao Buyer Company"
    And Admin choose regions and add to Buyer Company specific
      | regions             |
      | Chicagoland Express |
    And with Buyer Company-specific
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category                       |
      | Bao Buyer Company | Chicagoland Express | 1        | 1         | Out of stock | currentDate | currentDate | [blank]             | Pending Replenishment          |
      | Bao Buyer Company | Chicagoland Express | [blank]  | [blank]   | [blank]      | [blank]     | [blank]     | [blank]             | Vendor short-term              |
      | Bao Buyer Company | Chicagoland Express | [blank]  | [blank]   | [blank]      | [blank]     | [blank]     | [blank]             | Vendor long-term               |
      | Bao Buyer Company | Chicagoland Express | [blank]  | [blank]   | [blank]      | [blank]     | [blank]     | [blank]             | Discontinued by vendor         |
      | Bao Buyer Company | Chicagoland Express | [blank]  | [blank]   | [blank]      | [blank]     | [blank]     | [blank]             | Pending vendor response        |
      | Bao Buyer Company | Chicagoland Express | [blank]  | [blank]   | [blank]      | [blank]     | [blank]     | [blank]             | Product replacement/transition |
    And Admin check dialog help text tooltip of field "out-of-stock-reason"
      | field                   | text                                                                                                          |
      | Pending Replenishment   | There isn’t any pending inbound inventory existing                                                            |
      | Vendor short-term       | Inbound inventory request exists AND its status = Approved AND (inventory request ETA minus today) <= 21 days |
      | Vendor long-term        | Inbound inventory request exists AND its status = Approved AND (inventory request ETA minus today) > 21 days  |
      | Pending vendor response | Inbound inventory request exists AND its status = Pod Planned                                                 |

    And Click Create
    And Admin check message of sku "auto sku 2 check create product" is "Variant have been saved successfully !!"
#    And Admin go to SKU detail "auto sku 2 check create product"
    And Go to "Buyer company-specific" tab
    And with Buyer Company-specific
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category                       |
      | Bao Buyer Company | Chicagoland Express | 1        | 1         | Out of stock | currentDate | currentDate | [blank]             | Pending Replenishment          |
      | Bao Buyer Company | Chicagoland Express | [blank]  | [blank]   | [blank]      | [blank]     | [blank]     | [blank]             | Vendor short-term              |
      | Bao Buyer Company | Chicagoland Express | [blank]  | [blank]   | [blank]      | [blank]     | [blank]     | [blank]             | Product replacement/transition |
      | Bao Buyer Company | Chicagoland Express | [blank]  | [blank]   | [blank]      | [blank]     | [blank]     | [blank]             | Discontinued by vendor         |
      | Bao Buyer Company | Chicagoland Express | [blank]  | [blank]   | [blank]      | [blank]     | [blank]     | [blank]             | Pending vendor response        |
      | Bao Buyer Company | Chicagoland Express | [blank]  | [blank]   | [blank]      | [blank]     | [blank]     | [blank]             | Vendor long-term               |
    And Click on button "Update"
    And Admin check message of sku "auto sku 2 check create product" is "Variant have been saved successfully !!"

    And Go to "Buyer company-specific" tab
    And Admin check buyer company-specific of SKU
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category         | inventoryCount |
      | Bao Buyer Company | Chicagoland Express | 1        | 1         | Out of stock | currentDate | currentDate | [blank]             | Vendor long-term | [blank]        |

##    Create inventory
#    And Admin create inventory api1
#      | index | sku                             | product_variant_id | quantity | lot_code   | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | auto sku 2 check create product | auto create manual | 10       | sku random | 90           | Plus1        | [blank]     | comment |
#    And Admin go back with button
#    And Admin go to SKU detail "auto sku 2 check create product"
#    And Go to "Buyer company-specific" tab
#    And Admin check buyer company-specific of SKU
#      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category | inventoryCount | status |
#      | Bao Buyer Company | Chicagoland Express | 1        | 1         | In stock     | currentDate | currentDate | [blank]             | [blank]  | 10 cases       | Active |

  @Admin @TC_172_2
  Scenario: Check validation of the OOS Category Buyer company-specific  - automatically assign the OOS category
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto bao create product 172 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product 172" from API
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "auto bao create product 172" by api
    And Admin search product name "auto bao create product 172" by api
    And Admin delete product name "auto bao create product 172" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | auto bao create product 172 | 3018     |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
      | 2216             | Auto_BuyerCompany  | 63        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "random sku create product" of product ""
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku create product | random             | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 2                       | 10       | Autotest |

    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku create product | random             | 10       | random   | 95           | currentDate  | [blank]     | [blank] |
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 2                       | 10       | Autotest |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 172 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 172"
    And Admin go to SKU detail "random sku create product"
    And Go to "Buyer company-specific" tab
#    Đang bug
    And Admin check buyer company-specific of SKU
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category              | inventoryCount | status |
      | Auto_BuyerCompany | Chicagoland Express | 10       | 10        | Out of stock | currentDate | currentDate | [blank]             | Pending Replenishment | 0 case         | active |
      | Auto_BuyerCompany | Florida Express     | 10       | 10        | Out of stock | currentDate | currentDate | [blank]             | Pending Replenishment | 0 case         | active |
# Pending Replenishment

  #  Create inbound
#   Inventory request exists AND status = Pod Planned for the associated Express region -> . Pending vendor response
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |

    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Buyer company-specific" tab
#Đang bug
    And Admin check buyer company-specific of SKU
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category                | inventoryCount | status |
      | Auto_BuyerCompany | Chicagoland Express | 10       | 10        | Out of stock | currentDate | currentDate | [blank]             | Pending vendor response | 0 case         | active |
#  Pending vendor response
#Submit inbound
#  There is not case enough 4 condition (e.g: inventory request exists AND status = Submitted)
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                       | lot_code                  | quantity | expiry_date |
      | random sku create product | random sku create product | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Buyer company-specific" tab
    And Admin check buyer company-specific of SKU
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category          | inventoryCount | status |
      | Auto_BuyerCompany | Chicagoland Express | 10       | 10        | Out of stock | currentDate | currentDate | [blank]             | Vendor short-term | 0 case         | active |

#      #Approve inbound
#  Inventory request exists AND status = Approved AND (inventory request ETA minus today) <= 21 days for the associated Express region
#    And Admin Approve Incoming Inventory id "api" api
    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Buyer company-specific" tab
    And Admin check buyer company-specific of SKU
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category          | inventoryCount | status |
      | Auto_BuyerCompany | Chicagoland Express | 10       | 10        | Out of stock | currentDate | currentDate | [blank]             | Vendor short-term | 0 case         | active |
#Delete inbound
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
    #Craete inbound
#    1.5. Inventory request exists AND status = Approved AND (inventory request ETA minus today) > 21 days for the associated Express region
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |
    #Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                       | lot_code                  | quantity | expiry_date |
      | random sku create product | random sku create product | 10       | Plus22      |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta    | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus22 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
 #Craete inbound
#    1.5. Inventory request exists AND status = Approved AND (inventory request ETA minus today) > 21 days for the associated Express region
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 63        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 95           |
    #Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                       | lot_code                  | quantity | expiry_date |
      | random sku create product | random sku create product | 10       | Plus22      |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta    | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus22 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
 #Approve inbound
#  Inventory request exists AND status = Approved AND (inventory request ETA minus today) > 21 days for the associated Express region
#    And Admin Approve Incoming Inventory id "api" api
    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Buyer company-specific" tab
    And Admin check buyer company-specific of SKU
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category          | inventoryCount | status |
      | Auto_BuyerCompany | Chicagoland Express | 10       | 10        | Out of stock | currentDate | currentDate | [blank]             | Vendor short-term | 0 case         | active |
      | Auto_BuyerCompany | Florida Express     | 10       | 10        | Out of stock | currentDate | currentDate | [blank]             | Vendor long-term  | 0 case         | active |

  @Admin @TC_185
  Scenario: Check validation of the OOS Category Store-specific
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto bao create product 185 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product 185" from API
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "auto bao create product 185" by api
    And Admin search product name "auto bao create product 185" by api
    And Admin delete product name "auto bao create product 185" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | auto bao create product 185 | 3018     |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 185 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 185"
    And Add new SKU
      | skuName                   | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | random sku create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | description               |
    And with Qualities
      | 100% Natural |
    And Go to "Store-specific" tab
    And Check default "store" specific tab
      | alert                                                                                                                                                                                                                       | empty                             |
      | A store-specific price is applied with priority. If no store-specific price is set, a buyer-company-specific one is applied instead. If no buyer-company-specific price is set, a region-specific price is applied at last. | You don't have any defined store. |
    And with Store-specific
      | region              | store                   | msrp    | casePrice | availability | arriving | category                       | start       | end         |
      | Chicagoland Express | Auto Bao Store Express1 | 1       | 1         | Out of stock | [blank]  | Pending Replenishment          | currentDate | currentDate |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | [blank]      | [blank]  | Vendor short-term              | [blank]     | [blank]     |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | [blank]      | [blank]  | Product replacement/transition | [blank]     | [blank]     |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | [blank]      | [blank]  | Discontinued by vendor         | [blank]     | [blank]     |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | [blank]      | [blank]  | Pending vendor response        | [blank]     | [blank]     |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | [blank]      | [blank]  | Vendor long-term               | [blank]     | [blank]     |
    And Admin check dialog help text tooltip of field "out-of-stock-reason"
      | field                   | text                                                                                                          |
      | Pending Replenishment   | There isn’t any pending inbound inventory existing                                                            |
      | Vendor short-term       | Inbound inventory request exists AND its status = Approved AND (inventory request ETA minus today) <= 21 days |
      | Vendor long-term        | Inbound inventory request exists AND its status = Approved AND (inventory request ETA minus today) > 21 days  |
      | Pending vendor response | Inbound inventory request exists AND its status = Pod Planned                                                 |

    And Click Create
    And Admin check message of sku "random sku create product" is "Variant have been saved successfully !!"
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                   | msrp | casePrice | availability | arriving | start       | end         | category         |
      | Auto Bao Store Express1 | 1    | 1         | Out of stock | [blank]  | currentDate | currentDate | Vendor long-term |
    And with Store-specific
      | region              | store                   | msrp    | casePrice | availability | arriving | category                       | start       | end         |
      | Chicagoland Express | Auto Bao Store Express1 | 1       | 1         | Out of stock | [blank]  | Pending Replenishment          | currentDate | currentDate |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | [blank]      | [blank]  | Product replacement/transition | [blank]     | [blank]     |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | [blank]      | [blank]  | Discontinued by vendor         | [blank]     | [blank]     |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | [blank]      | [blank]  | Pending vendor response        | [blank]     | [blank]     |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | [blank]      | [blank]  | Vendor long-term               | [blank]     | [blank]     |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | [blank]      | [blank]  | Vendor short-term              | [blank]     | [blank]     |
    And Click on button "Update"
    And Admin check message of sku "auto sku 2 check create product" is "Variant have been saved successfully !!"
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                   | msrp | casePrice | availability | arriving | start       | end         | category          |
      | Auto Bao Store Express1 | 1    | 1         | Out of stock | [blank]  | currentDate | currentDate | Vendor short-term |
#    Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku create product | auto create manual | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                   | msrp | casePrice | availability | arriving | start       | end         | category | inventoryCount |
      | Auto Bao Store Express1 | 1    | 1         | In stock     | [blank]  | currentDate | currentDate | [blank]  | 10 cases       |
#    Create subtraction
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 2                       | 10       | Autotest |
    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                   | msrp | casePrice | availability | arriving | start       | end         | category                | inventoryCount |
      | Auto Bao Store Express1 | 1    | 1         | Out of stock | [blank]  | currentDate | currentDate | Pending vendor response | 0 case         |
#     Pending Replenishment
#    Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto bao create product 185 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product 185" from API
    And Admin delete inventory "all" by API

    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                   | msrp | casePrice | availability | arriving | start       | end         | category | inventoryCount |
      | Auto Bao Store Express1 | 1    | 1         | In stock     | [blank]  | currentDate | currentDate | [blank]  | [blank]        |
    And with Store-specific
      | region              | store                   | msrp    | casePrice | availability | arriving | category | start   | end     |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | Out of stock | [blank]  | [blank]  | [blank] | [blank] |
    And Admin check store-specific of SKU
      | store                   | msrp | casePrice | availability | arriving | start       | end         | category              | inventoryCount |
      | Auto Bao Store Express1 | 1    | 1         | Out of stock | [blank]  | currentDate | currentDate | Pending Replenishment | [blank]        |
#     Pending Replenishment

    #  Create inbound
#   Inventory request exists AND status = Pod Planned for the associated Express region -> . Pending vendor response
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |
    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Store-specific" tab
    And with Store-specific
      | region              | store                   | msrp    | casePrice | availability | arriving | category | start   | end     |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | Out of stock | [blank]  | [blank]  | [blank] | [blank] |
    And Admin check store-specific of SKU
      | store                   | msrp | casePrice | availability | arriving | start       | end         | category                | inventoryCount |
      | Auto Bao Store Express1 | 1    | 1         | Out of stock | [blank]  | currentDate | currentDate | Pending vendor response | [blank]        |
 #Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                       | lot_code                  | quantity | expiry_date |
      | random sku create product | random sku create product | 10       | Plus22      |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta    | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus22 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
 #Approve inbound
#  Inventory request exists AND status = Approved AND (inventory request ETA minus today) > 21 days for the associated Express region
#    And Admin Approve Incoming Inventory id "api" api
    And Admin go back with button
    And Admin go to SKU detail "random sku create product"
    And Go to "Store-specific" tab
    And with Store-specific
      | region              | store                   | msrp    | casePrice | availability | arriving | category | start   | end     |
      | Chicagoland Express | Auto Bao Store Express1 | [blank] | [blank]   | Out of stock | [blank]  | [blank]  | [blank] | [blank] |
    And Admin check store-specific of SKU
      | store                   | msrp | casePrice | availability | arriving | start       | end         | category         | inventoryCount |
      | Auto Bao Store Express1 | 1    | 1         | Out of stock | [blank]  | currentDate | currentDate | Vendor long-term | [blank]        |

  @Admin @TC_200
  Scenario: Check validation of the OOS Category Store-specific when add multiple stores
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto_product24  | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product 185" from API
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "auto_product24" by api
    And Admin delete all sku in product id "6636" by api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term           | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product24 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto_product24"
    And Check product not have SKU

    And Add new SKU
      | skuName                         | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto sku 1 check create product | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | 10                 | 30                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with Tags
      | tagName       | expiryDate |
      | Auto Bao Tags | Plus1      |
    And Go to "Store-specific" tab
    And Click on button "Add multiple stores of a buyer company"
    And Add multiple stores of Buyer company with info
      | buyer                  | msrp    | casePrice | availability | arriving | start       | end         | category                       |
      | Auto Buyer Company Bao | 21      | 20        | Out of stock | [blank]  | currentDate | currentDate | Pending Replenishment          |
      | [blank]                | [blank] | [blank]   | [blank]      | [blank]  | [blank]     | [blank]     | Product replacement/transition |
      | [blank]                | [blank] | [blank]   | [blank]      | [blank]  | [blank]     | [blank]     | Discontinued by vendor         |
      | [blank]                | [blank] | [blank]   | [blank]      | [blank]  | [blank]     | [blank]     | Pending vendor response        |
      | [blank]                | [blank] | [blank]   | [blank]      | [blank]  | [blank]     | [blank]     | Vendor long-term               |
      | [blank]                | [blank] | [blank]   | [blank]      | [blank]  | [blank]     | [blank]     | Vendor short-term              |
    And Admin check dialog help text tooltip of field "OOS Category"
      | field                   | text                                                                                                          |
      | Pending Replenishment   | There isn’t any pending inbound inventory existing                                                            |
      | Vendor short-term       | Inbound inventory request exists AND its status = Approved AND (inventory request ETA minus today) <= 21 days |
      | Vendor long-term        | Inbound inventory request exists AND its status = Approved AND (inventory request ETA minus today) > 21 days  |
      | Pending vendor response | Inbound inventory request exists AND its status = Pod Planned                                                 |

    And Choose check, uncheck "a" stores of Buyer company
      | store                             |
      | Auto Store check order creditcard |
      | Auto store 2 switch mov moq       |
      | Auto store switch mov moq         |
    And Confirm add multiple store
    And Click Create
    And Admin check message of sku "auto 1 check create product" is "Variant have been saved successfully !!"
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                              | msrp | casePrice | availability | arriving | start       | end         | category          |
      | Auto store check Order PD Print SL | 21   | 20        | Out of stock | [blank]  | currentDate | currentDate | Vendor short-term |
      | Auto Store check Orrder NY         | 21   | 20        | Out of stock | [blank]  | currentDate | currentDate | Vendor short-term |
      | Auto store 2 check add to cart moq | 21   | 20        | Out of stock | [blank]  | currentDate | currentDate | Vendor short-term |

  @Admin @TC_206
  Scenario: Check SKU must have at least 1 region config or at least 1 store-region or at least 1 buyer-company
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto bao create product 206 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product 206" from API
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "auto bao create product 206" by api
    And Admin search product name "auto bao create product 206" by api
    And Admin delete product name "auto bao create product 206" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | auto bao create product 206 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
#    And Info of Buyer company specific
#      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
#      | 2215             | Bao Buyer Company  | 26        | currentDate | currentDate | 1200             | 1200       | in_stock     |
#    And Info of Store specific
#      | store_id | store_name | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
#      | 2465     | Bao store  | 2215             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1400             | 1400       | in_stock     |

    And Admin create a "active" SKU from admin with name "random sku create product 206" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 206 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 206"
    And Admin check SKU info on tab "active"
      | skuName                       | unitUpc      | caseUpc      | status | unitPerCase | codeSKU   | regions |
      | random sku create product 206 | 123123123123 | 123123123123 | Active | 1 per case  | not check | CHI     |
    And Admin check upc tag of SKU
      | unitUPC      | caseUPC      |
      | 123123123123 | 123123123123 |

    Given LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And LP search item "auto bao create product 206" on catalog
    And "LP" choose filter by "Order by Popularity"
    And LP go to detail of product "auto bao create product 206"
    And LP check detail of product
      | product                     | brand                     | available           | unitUPC      | casePack        |
      | auto bao create product 206 | Auto brand create product | Chicagoland Express | 123123123123 | 1 unit per case |
    And Click on any text "123123123123"
    And Check any text "is" showing on screen
      | Barcode Image not available |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And Vendor search product "random sku create product 206" on catalog
    And Vendor Go to product detail
      | productName                 | unitDimension | caseDimension | unitSize | casePack        |
      | auto bao create product 206 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
    And Vendor check regions detail
      | region              | price  | casePrice | msrp   | availability | moq | margin |
      | Chicagoland Express | $10.00 | $10.00    | $10.00 | In Stock     | 1   | 0%     |

#    Store manager buyer
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto bao create product 206"
    And Buyer check product info on catalog
      | productName                 | brand                     | unitPrice | numberSku |
      | auto bao create product 206 | Auto brand create product | $10.00    | 1         |
    And Go to detail of product "auto bao create product 206" from catalog
    And Buyer choose SKU "random sku create product 206" in product detail
    And Check information of SKU
      | productName                 | productBrand              | pricePerUnit | pricePerCase | availability |
      | auto bao create product 206 | Auto brand create product | $10.00       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $10.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
#    Store Sub - buyer
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto bao create product 206"
    And Buyer check product info on catalog
      | productName                 | brand                     | unitPrice | numberSku |
      | auto bao create product 206 | Auto brand create product | $10.00    | 1         |
    And Go to detail of product "auto bao create product 206" from catalog
    And Buyer choose SKU "random sku create product 206" in product detail
    And Check information of SKU
      | productName                 | productBrand              | pricePerUnit | pricePerCase | availability |
      | auto bao create product 206 | Auto brand create product | $10.00       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $10.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |

  @Admin @TC_208
  Scenario: Check SKU must have at least 1 region config or at least 1 store-region or at least 1 buyer-company 3
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto bao create product 208 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product 208" from API
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "auto bao create product 208" by api
    And Admin search product name "auto bao create product 208" by api
    And Admin delete product name "auto bao create product 208" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | auto bao create product 208 | 3018     |
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
#    And Info of Buyer company specific
#      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
#      | 2215             | Bao Buyer Company  | 26        | currentDate | currentDate | 1200             | 1200       | in_stock     |
    And Info of Store specific
      | store_id | store_name          | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |

    And Admin create a "active" SKU from admin with name "random sku create product 208" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 208 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 208"
    And Admin check SKU info on tab "active"
      | skuName                       | unitUpc      | caseUpc      | status | unitPerCase | codeSKU   | regions |
      | random sku create product 208 | 123123123123 | 123123123123 | Active | 1 per case  | not check | CHI     |
    And Admin check upc tag of SKU
      | unitUPC      | caseUPC      |
      | 123123123123 | 123123123123 |

    Given LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And LP search item "auto bao create product 208" on catalog
    And "LP" choose filter by "Order by Popularity"
    And LP go to detail of product "auto bao create product 208"
    And LP check detail of product
      | product                     | brand                     | available | unitUPC      | casePack        |
      | auto bao create product 208 | Auto brand create product | [blank]   | 123123123123 | 1 unit per case |
    And Click on any text "123123123123"
    And Check any text "is" showing on screen
      | Barcode Image not available |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And Vendor search product "random sku create product 208" on catalog
    And Vendor Go to product detail
      | productName                 | unitDimension | caseDimension | unitSize | casePack        |
      | auto bao create product 208 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
#    And Vendor check regions detail
#      | region              | price  | casePrice | msrp   | availability | moq | margin |
#      | Chicagoland Express | $10.00 | $10.00    | $10.00 | In Stock     | 1   | 0%     |

#    Store manager buyer
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer52@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto bao create product 208"
    And Buyer check product info on catalog
      | productName                 | brand                     | unitPrice | numberSku |
      | auto bao create product 208 | Auto brand create product | $10.00    | 1         |
    And Go to detail of product "auto bao create product 208" from catalog
    And Buyer choose SKU "random sku create product 208" in product detail
    And Check information of SKU
      | productName                 | productBrand              | pricePerUnit | pricePerCase | availability |
      | auto bao create product 208 | Auto brand create product | $10.00       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $10.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
#    Store Sub - buyer
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto bao create product 208"
    And Buyer check product info on catalog
      | productName                 | brand                     | unitPrice | numberSku |
      | auto bao create product 208 | Auto brand create product | $10.00    | 1         |
    And Go to detail of product "auto bao create product 208" from catalog
    And Buyer choose SKU "random sku create product 208" in product detail
    And Check information of SKU
      | productName                 | productBrand              | pricePerUnit | pricePerCase | availability |
      | auto bao create product 208 | Auto brand create product | $10.00       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $10.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |

  @Admin @TC_207
  Scenario: Check SKU must have at least 1 region config or at least 1 store-region or at least 1 buyer-company 2
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto bao create product 207 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product 207" from API
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "auto bao create product 207" by api
    And Admin search product name "auto bao create product 207" by api
    And Admin delete product name "auto bao create product 207" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | auto bao create product 207 | 3018     |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "random sku create product 207" of product ""

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 207 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 207"
    And Admin check SKU info on tab "active"
      | skuName                       | unitUpc      | caseUpc      | status | unitPerCase | codeSKU   | regions |
      | random sku create product 207 | 123123123123 | 123123123123 | Active | 1 per case  | not check | CHI     |
    And Admin check upc tag of SKU
      | unitUPC      | caseUPC      |
      | 123123123123 | 123123123123 |

    Given LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And LP search item "auto bao create product 207" on catalog
    And "LP" choose filter by "Order by Popularity"
    And LP go to detail of product "auto bao create product 207"
    And LP check detail of product
      | product                     | brand                     | available | unitUPC      | casePack        |
      | auto bao create product 207 | Auto brand create product | [blank]   | 123123123123 | 1 unit per case |
    And Click on any text "123123123123"
    And Check any text "is" showing on screen
      | Barcode Image not available |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And Vendor search product "random sku create product 207" on catalog
    And Vendor Go to product detail
      | productName                 | unitDimension | caseDimension | unitSize | casePack        |
      | auto bao create product 207 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0  g   | 1 unit per case |
#    And Vendor check regions detail
#      | region              | price  | casePrice | msrp   | availability | moq | margin |
#      | Chicagoland Express | $10.00 | $10.00    | $10.00 | In Stock     | 1   | 0%     |

#    Store manager buyer
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer52@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto bao create product 207"
    And Buyer check product info on catalog
      | productName                 | brand                     | unitPrice | numberSku |
      | auto bao create product 207 | Auto brand create product | $10.00    | 1         |
    And Go to detail of product "auto bao create product 207" from catalog
    And Buyer choose SKU "random sku create product 207" in product detail
    And Check information of SKU
      | productName                 | productBrand              | pricePerUnit | pricePerCase | availability |
      | auto bao create product 207 | Auto brand create product | $10.00       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $10.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
#    Store Sub - buyer
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto bao create product 207"
    And Buyer check product info on catalog
      | productName                 | brand                     | unitPrice | numberSku |
      | auto bao create product 207 | Auto brand create product | $10.00    | 1         |
    And Go to detail of product "auto bao create product 207" from catalog
    And Buyer choose SKU "random sku create product 207" in product detail
    And Check information of SKU
      | productName                 | productBrand              | pricePerUnit | pricePerCase | availability |
      | auto bao create product 207 | Auto brand create product | $10.00       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $10.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |

  @Admin @TC_280
  Scenario: The Stock Availability Of Sku Will Be In Stock If Admin Process Inbound Story - Processed 1 Lot code
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto bao create product 280 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product 280" from API
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "auto bao create product 280" by api
    And Admin search product name "auto bao create product 280" by api
    And Admin delete product name "auto bao create product 280" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | auto bao create product 280 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | out_of_stock_reason | auto_out_of_stock_reason |
      | Chicagoland Express | 26 | active | sold_out     | 1000      | 1000 | vendor_short_term   | vendor_short_term        |
    And Admin create a "active" SKU from admin with name "random sku create product 280" of product ""

     #  Create inbound
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |
      #Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                           | lot_code                      | quantity | expiry_date |
      | random sku create product 280 | random sku create product 280 | 10       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
      #Approve inbound
#    And Admin Approve Incoming Inventory id "api" api
    #    Upload file inbound
    And Admin upload file Incoming Inventory id "api" api
      | fileBOL | filePOD |
      | BOL.pdf | POD.png |
#    Mark as received
    And Admin Mark as received Incoming Inventory id "api" api
#    Processed inbound
    And Admin Process Incoming Inventory id "api" api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 280 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 280"
    And Admin go to SKU detail "random sku create product 280"
    And Go to "Region-specific" tab
    #    Đang bug
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | 10 cases       | [blank]  |

  @Admin @TC_281
  Scenario: The Stock Availability Of Sku Will Be In Stock If Admin Process Inbound Story - Processed 2 Lot code with the same SKU
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto bao create product 281 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product 281" from API
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "auto bao create product 281" by api
    And Admin search product name "auto bao create product 281" by api
    And Admin delete product name "auto bao create product 281" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | auto bao create product 281 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | out_of_stock_reason | auto_out_of_stock_reason |
      | Chicagoland Express | 26 | active | sold_out     | 1000      | 1000 | vendor_short_term   | vendor_short_term        |
    And Admin create a "active" SKU from admin with name "random sku create product 281" of product ""

     #  Create inbound
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | random             | 1847              | 10       |
      | random             | 1847              | 20       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1847              | 10            | 10                          | 1                        | 1     | 1          | 99           |
      #Submit inbound
    And Admin set items info to submit of Incoming Inventory "api" api
      | sku                           | lot_code                        | quantity | expiry_date |
      | random sku create product 281 | random sku create product 281 1 | 10       | Plus1       |
      | random sku create product 281 | random sku create product 281 2 | 20       | Plus1       |
    And Admin submit Incoming Inventory id "api" api
      | delivery_method_id | eta   | num_of_pallet | num_of_sellable_retail_case | num_of_master_carton | num_of_retail_per_master_carton | status    | total_weight | zip_code | admin_note | warehouse_id | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | transport_coordinator_phone |
      | 1                  | Plus1 | 1             | 1                           | 1                    | 1                               | submitted | 1            | 11111    | admin_note | 99           | other_detail | freight_carrier | tracking_number | reference_number | transport_coordinator_name | 1234567890                  |
      #Approve inbound
#    And Admin Approve Incoming Inventory id "api" api
    #    Upload file inbound
    And Admin upload file Incoming Inventory id "api" api
      | fileBOL | filePOD |
      | BOL.pdf | POD.png |
#    Mark as received
    And Admin Mark as received Incoming Inventory id "api" api

#    Processed inbound
    And Admin Process Incoming Inventory id "api" api

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 281 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 281"
    And Admin go to SKU detail "random sku create product 281"
    And Go to "Region-specific" tab
    #    Đang bug
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | 30 cases       | [blank]  |

  @Admin @TC_282
  Scenario: Check Stock Availability Of SKU If Admin Mark As Approved For Withdrawal Request Story and Remove Approved withdrawal request
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3018  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto bao create product 282 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product 282" from API
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "auto bao create product 282" by api
    And Admin search product name "auto bao create product 282" by api
    And Admin delete product name "auto bao create product 282" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | auto bao create product 282 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | out_of_stock_reason | auto_out_of_stock_reason |
      | Chicagoland Express | 26 | active | sold_out     | 1000      | 1000 | vendor_short_term   | vendor_short_term        |
    And Admin create a "active" SKU from admin with name "random sku create product 282" of product ""
    And Admin create inventory api1
      | index | sku                           | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku create product 282 | random             | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
      #Create Withdrawal quantity = Pull date reached qty
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code            | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku create product 282 | 10       | 0             | 10            | currentDate           |
    And Admin create withdraw request api2
      | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 26        | 1847              | currentDate | 09:30      | 10:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |
     #approve withdrawal
    And Admin approve withdrawal request "create by api" by api
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 282 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 282"
    And Admin go to SKU detail "random sku create product 282"
    And Go to "Region-specific" tab
    #    Đang bug
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category              |
      | Chicagoland Express | 10        | 10       | Out of stock | [blank]  | 0 case         | Pending Replenishment |
  # Delete withdrawal
    And Admin search withdrawal by API
      | q[number]     | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
      | create by api | [blank]              | 3018        | 26           | [blank]   | [blank]       | [blank]     |
    And Admin delete all ID of withdrawal request of SKU "random sku create product 282" by api
    And Refesh browser
    And Go to "Region-specific" tab
    #    Đang bug
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | 10 cases       | [blank]  |

  @Admin @TC_284
  Scenario: Check Stock Availability Of SKU If Admin Mark As Approved For Withdrawal Request Story and Remove Pod consignment
#    Sau task 2636 khong xoa DC POD CONSIGMENT
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
   # Delete withdrawal
    And Admin search withdrawal by API
      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[status] | q[start_date] | q[end_date] |
      | [blank]   | [blank]              | 3018        | 26           | [blank]   | [blank]       | [blank]     |
    And Admin delete all ID of withdrawal request of SKU "random sku create product 284" by api

      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]             | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | auto bao create product 284 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "auto bao create product 284" from API
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "auto bao create product 284" by api
    And Admin search product name "auto bao create product 284" by api
    And Admin delete product name "auto bao create product 284" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | auto bao create product 284 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | out_of_stock_reason | auto_out_of_stock_reason |
      | Chicagoland Express | 26 | active | sold_out     | 1000      | 1000 | vendor_short_term   | vendor_short_term        |
    And Admin create a "active" SKU from admin with name "random sku create product 284" of product ""
    And Admin create inventory api1
      | index | sku                           | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku create product 284 | random             | 20       | random   | 90           | currentDate  | [blank]     | [blank] |
      #Create Withdrawal quantity = Pull date reached qty
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code            | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku create product 284 | 10       | 0             | 10            | currentDate           |
    And Admin create withdraw request api2
      | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 26        | 1847              | currentDate | 09:30      | 10:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |
     #approve withdrawal
    And Admin approve withdrawal request "create by api" by api
#    Create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 10       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3082     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 284 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 284"
    And Admin go to SKU detail "random sku create product 284"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category              |
      | Chicagoland Express | 10        | 10       | Out of stock | [blank]  | 0 case         | Pending Replenishment |

    And BAO_ADMIN2 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
#    And Admin remove pod consignment deliverable of sku "random sku create product 284" in line item
    And Admin delete order from order detail
      | reason  | note    | showEdit | passkey |
      | [blank] | [blank] | [blank]  | [blank] |

    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 284 | Active       | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 284"
    And Admin go to SKU detail "random sku create product 284"
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU
      | regionName          | casePrice | msrpunit | availability | arriving | inventoryCount | category |
      | Chicagoland Express | 10        | 10       | In stock     | [blank]  | 10 cases       | [blank]  |

  @Admin @TC_299
  Scenario: Mass editing SKU Check Check display of all information on the Region-specific tab - OOS Availability
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API
    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

#    And Admin create inventory api1
#      | index | sku        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | sku random | random             | 10       | random   | 90           | Plus1        | [blank]     | [blank] |
    And Info of Region
      | region                   | id | state  | availability | casePrice | msrp |
      | North California Express | 25 | active | in_stock     | 1000      | 1000 |
    And Info of Prop65
      | containChemical | firstName | lastName | email                           | skuId   | vendorCompanyId |
      | false           | Auto      | vendor29 | ngoctx+autovendor29@podfoods.co | [blank] | 1847            |
    And Admin create a "active" SKU from admin with name "sku 2 random" of product ""

#    And Admin create inventory api1
#      | index | sku          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 2     | sku 2 random | random             | 10       | random   | 98           | Plus1        | [blank]     | [blank] |
#    And Admin create inventory api1
#      | index | sku          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 3     | sku 2 random | random             | 5        | random   | 98           | Plus1        | [blank]     | [blank] |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin click Mass editing SKU
    And Admin check SKU on Mass editing
      | sku          | image       | upc          | endQty  |
      | sku random   | anhJPG2.jpg | 123123123123 | [blank] |
      | sku 2 random | anhJPG2.jpg | 123123123123 | [blank] |
#    And Admin check end quantity of SKU "sku random" on Mass editing
#      | region              | endQty |
#      | Chicagoland Express | 10     |
#    And Admin check end quantity of SKU "sku 2 random" on Mass editing
#      | region                   | endQty |
#      | North California Express | 15     |
##      | South California Express | 10     |
#    And Admin click update Mass editing SKU
#    And Admin verify content of dialog
#      | Please select a variant                              |
#      | Please select a region or a buyer company or a store |
    And Admin Mass editing choose "a" SKU
      | sku          |
      | sku random   |
      | sku 2 random |

    And Go to "Region-specific" tab
    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving                |
      | Dallas Express           | 12        | 15       | In stock     | [blank]                 |
      | Chicagoland Express      | 12        | 15       | Out of stock | Pending Replenishment   |
      | Florida Express          | 12        | 15       | Out of stock | Vendor short-term       |
      | Mid Atlantic Express     | 12        | 15       | Out of stock | Vendor long-term        |
      | New York Express         | 12        | 15       | In stock     | [blank]                 |
      | North California Express | 12        | 15       | In stock     | [blank]                 |
      | South California Express | 12        | 15       | Out of stock | Discontinued by vendor  |
      | Pod Direct Central       | 12        | 15       | Out of stock | Pending vendor response |
      | Pod Direct East          | 12        | 15       | In stock     | [blank]                 |
#      | Pod Direct Southeast           | 12        | 15       | Out of stock | [blank]                        |
#      | Pod Direct Southwest & Rockies | 12        | 15       | Out of stock | Product replacement/transition |
      | Pod Direct West          | 12        | 15       | In stock     | [blank]                 |
    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |
    And Admin click Mass editing SKU
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU "sku random" on mass editing
      | region | status     | inventoryCount | casePrice |
      | DAL    | is-checked | [blank]        | 12        |
      | CHI    | is-checked | [blank]        | 12        |
      | FL     | is-checked | [blank]        | 12        |
      | MA     | is-checked | [blank]        | 12        |
      | NY     | is-checked | [blank]        | 12        |
      | SF     | is-checked | [blank]        | 12        |
      | LA     | is-checked | [blank]        | 12        |
      | PDW    | is-checked | [blank]        | 12        |
      | PDE    | is-checked | [blank]        | 12        |
      | PDC    | is-checked | [blank]        | 12        |
#      | PDSW&R | is-checked | [blank]        | 12        |
#      | PDW    | is-checked | [blank]        | 12        |

  @Admin @TC_301
  Scenario: Mass editing SKU Region-specific tab - Check display condition of the total inventory end-quantity by SKU
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API
    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Dallas Express      | 61 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    And Admin create inventory api1
      | index | sku        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | sku random | random             | 10       | random   | 90           | Plus1        | [blank]     | [blank] |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Dallas Express      | 61 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku 2 random" of product ""
    And Admin create inventory api1
      | index | sku          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 2     | sku 2 random | random             | 10       | random   | 90           | Plus1        | [blank]     | [blank] |
    And Admin create inventory api1
      | index | sku          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 3     | sku 2 random | random             | 5        | random   | 90           | Plus1        | [blank]     | [blank] |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin click Mass editing SKU
    And Admin check end quantity of SKU "sku random" on Mass editing
      | region              | endQty |
      | Chicagoland Express | 10     |
    And Admin check end quantity of SKU "sku 2 random" on Mass editing
      | region              | endQty |
      | Chicagoland Express | 15     |
    And Admin Mass editing choose "a" SKU
      | sku          |
      | sku random   |
      | sku 2 random |
    And Go to "Region-specific" tab
    And with region specific
      | regionName          | casePrice | msrpunit | availability | arriving              |
      | Dallas Express      | 12        | 15       | In stock     | [blank]               |
      | Chicagoland Express | 12        | 15       | Out of stock | Pending Replenishment |

    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |
    And Admin click Mass editing SKU
    And Go to "Region-specific" tab
    And Admin check region-specific of SKU "sku random" on mass editing
      | region | status     | inventoryCount | casePrice |
      | DAL    | is-checked | [blank]        | 12        |
      | CHI    | is-checked | 10 cases       | 12        |
    And Admin check region-specific of SKU "sku 2 random" on mass editing
      | region | status     | inventoryCount | casePrice |
      | DAL    | is-checked | [blank]        | 12        |
      | CHI    | is-checked | 15 cases       | 12        |

  @Admin @TC_308
  Scenario: Mass editing SKU Buyer company-specific tab - Check display condition of the total inventory end-quantity by SKU
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API
    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability | out_of_stock_reason | auto_out_of_stock_reason |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | sold_out     | vendor_short_term   | pending_vendor_response  |
      | 2216             | Auto_BuyerCompany  | 63        | currentDate | currentDate | 1000             | 1000       | in_stock     | [blank]             | [blank]                  |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    And Admin create inventory api1
      | index | sku        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | sku random | random             | 10       | random   | 90           | Plus1        | [blank]     | [blank] |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2215             | Bao Buyer Company  | 26        | currentDate | currentDate | 1200             | 1200       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku 2 random" of product ""
    And Admin create inventory api1
      | index | sku          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 2     | sku 2 random | random             | 10       | random   | 90           | Plus1        | [blank]     | [blank] |
    And Admin create inventory api1
      | index | sku          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 3     | sku 2 random | random             | 5        | random   | 90           | Plus1        | [blank]     | [blank] |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin click Mass editing SKU
    And Admin check end quantity of SKU "sku random" on Mass editing
      | region              | endQty |
      | Chicagoland Express | 10     |
    And Admin check end quantity of SKU "sku 2 random" on Mass editing
      | region              | endQty |
      | Chicagoland Express | 15     |
    And Admin Mass editing choose "a" SKU
      | sku          |
      | sku random   |
      | sku 2 random |
    And Go to "Buyer company-specific" tab
    And Admin check buyer company-specific of SKU "sku random" on Mass editing
      | buyerCompany      | region | casePrice | startDate   | endDate     | inventoryCount |
      | Auto_BuyerCompany | CHI    | 10        | currentDate | currentDate | 10 cases       |
      | Auto_BuyerCompany | FL     | 10        | currentDate | currentDate | [blank]        |
    And Admin check buyer company-specific of SKU "sku 2 random" on Mass editing
      | buyerCompany      | region | casePrice | startDate   | endDate     | inventoryCount |
      | Bao Buyer Company | CHI    | 12        | currentDate | currentDate | 15 cases       |
    And Admin search Buyer Company specific "Bao Buyer Company"
    And Admin choose regions and add to Buyer Company specific
      | regions         |
      | Florida Express |
    And with Buyer Company-specific
      | buyerCompany      | region          | msrpUnit | casePrice | availability | startDate | endDate | inventoryArrivingAt | category |
      | Bao Buyer Company | Florida Express | [blank]  | [blank]   | Out of stock | [blank]   | [blank] | [blank]             | [blank]  |
    And Admin check buyer company-specific of SKU
      | buyerCompany      | region          | msrpUnit | casePrice | availability | startDate | endDate | inventoryArrivingAt | category          |
      | Bao Buyer Company | Florida Express | 0        | 0         | Out of stock | [blank]   | [blank] | [blank]             | Vendor short-term |
    And with Buyer Company-specific
      | buyerCompany      | region          | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category              |
      | Bao Buyer Company | Florida Express | 10       | 10        | Out of stock | currentDate | currentDate | [blank]             | Pending Replenishment |

    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |
    And Admin click Mass editing SKU
    And Go to "Buyer company-specific" tab
    And Admin check buyer company-specific of SKU "sku random" on Mass editing
      | buyerCompany      | region | casePrice | startDate   | endDate     | inventoryCount |
      | Auto_BuyerCompany | CHI    | 10        | currentDate | currentDate | 10 cases       |
      | Auto_BuyerCompany | FL     | 10        | currentDate | currentDate | [blank]        |
      | Bao Buyer Company | FL     | 10        | currentDate | currentDate | [blank]        |
    And Admin check buyer company-specific of SKU "sku 2 random" on Mass editing
      | buyerCompany      | region | casePrice | startDate   | endDate     | inventoryCount |
      | Bao Buyer Company | CHI    | 12        | currentDate | currentDate | 15 cases       |
      | Bao Buyer Company | FL     | 10        | currentDate | currentDate | [blank]        |

  @Admin @TC_321
  Scenario: Mass editing SKU Store-specific tab - Check display condition of the total inventory end-quantity by SKU
    Given BAO_ADMIN2 login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto bao create product 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto bao create product 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto bao create product 1" from API
    And Admin delete all inventory by API
    And Admin search product name "auto bao create product 1" by api
    And Admin delete product name "auto bao create product 1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                      | brand_id |
      | auto bao create product 1 | 3018     |
    And Info of Store specific
      | store_id | store_name          | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
      | 1762     | Auto Store PDM      | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 1100             | 1100       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    And Admin create inventory api1
      | index | sku        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | sku random | random             | 10       | random   | 90           | Plus1        | [blank]     | [blank] |
    And Info of Store specific
      | store_id | store_name          | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
      | 1762     | Auto Store PDM      | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 1100             | 1100       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku 2 random" of product ""
    And Admin create inventory api1
      | index | sku          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 2     | sku 2 random | random             | 10       | random   | 90           | Plus1        | [blank]     | [blank] |
    And Admin create inventory api1
      | index | sku          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 3     | sku 2 random | random             | 5        | random   | 90           | Plus1        | [blank]     | [blank] |

    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                      | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto bao create product 1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "auto bao create product 1"
    And Admin click Mass editing SKU
    And Admin check end quantity of SKU "sku random" on Mass editing
      | region              | endQty |
      | Chicagoland Express | 10     |
    And Admin check end quantity of SKU "sku 2 random" on Mass editing
      | region              | endQty |
      | Chicagoland Express | 15     |
    And Admin Mass editing choose "a" SKU
      | sku          |
      | sku random   |
      | sku 2 random |
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU "sku random" on Mass editing
      | store               | region | casePrice | startDate   | endDate     | inventoryCount |
      | Auto Store Chicago1 | CHI    | 10        | currentDate | currentDate | 10 cases       |
    And Admin check store-specific of SKU "sku 2 random" on Mass editing
      | store               | region | casePrice | startDate   | endDate     | inventoryCount |
      | Auto Store Chicago1 | CHI    | 10        | currentDate | currentDate | 15 cases       |
    And with Store-specific
      | region          | store                    | msrp | casePrice | availability | arriving | category                | start       | end         |
      | Pod Direct East | Auto storte PD Northeast | 12   | 12        | Out of stock | [blank]  | Pending vendor response | currentDate | currentDate |
    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |
    And Admin go to SKU detail "sku random"
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                    | msrp | casePrice | availability | arriving | category                | start       | end         |
      | Auto Store Chicago1      | 10   | 10        | In stock     | [blank]  | [blank]                 | currentDate | currentDate |
      | Auto storte PD Northeast | 12   | 12        | Out of stock | [blank]  | Pending vendor response | currentDate | currentDate |
    And Admin go back with button
    And Admin go to SKU detail "sku 2 random"
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                    | msrp | casePrice | availability | arriving | category                | start       | end         |
      | Auto Store Chicago1      | 10   | 10        | In stock     | [blank]  | [blank]                 | currentDate | currentDate |
      | Auto storte PD Northeast | 12   | 12        | Out of stock | [blank]  | Pending vendor response | currentDate | currentDate |
    And Admin go back with button
    And Admin click Mass editing SKU
    And Admin Mass editing choose "a" SKU
      | sku          |
      | sku random   |
      | sku 2 random |
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU "sku random" on Mass editing
      | store                    | region | casePrice | startDate   | endDate     | inventoryCount |
      | Auto Store Chicago1      | CHI    | 10        | currentDate | currentDate | 10 cases       |
      | Auto storte PD Northeast | PDE    | 12        | currentDate | currentDate | [blank]        |
    And Admin check store-specific of SKU "sku 2 random" on Mass editing
      | store                    | region | casePrice | startDate   | endDate     | inventoryCount |
      | Auto Store Chicago1      | CHI    | 10        | currentDate | currentDate | 15 cases       |
      | Auto storte PD Northeast | PDE    | 12        | currentDate | currentDate | [blank]        |
    And Click on button "Add multiple stores of a buyer company"
    And Add multiple stores of Buyer company with info
      | buyer                  | msrp    | casePrice | availability | arriving | start       | end         | category                       |
      | Auto Buyer Company Bao | 21      | 20        | Out of stock | [blank]  | currentDate | currentDate | Pending Replenishment          |
      | [blank]                | [blank] | [blank]   | [blank]      | [blank]  | [blank]     | [blank]     | Vendor short-term              |
      | [blank]                | [blank] | [blank]   | [blank]      | [blank]  | [blank]     | [blank]     | Product replacement/transition |
      | [blank]                | [blank] | [blank]   | [blank]      | [blank]  | [blank]     | [blank]     | Discontinued by vendor         |
      | [blank]                | [blank] | [blank]   | [blank]      | [blank]  | [blank]     | [blank]     | Pending vendor response        |
      | [blank]                | [blank] | [blank]   | [blank]      | [blank]  | [blank]     | [blank]     | Vendor long-term               |
    And Choose check, uncheck "a" stores of Buyer company
      | store                             |
      | Auto Store check order creditcard |
      | Auto store 2 switch mov moq       |
      | Auto store switch mov moq         |
    And Confirm add multiple store
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU
      | store                              | msrp | casePrice | availability | arriving | start       | end         | category         |
      | Auto store check Order PD Print SL | 21   | 20        | Out of stock | [blank]  | currentDate | currentDate | Vendor long-term |
      | Auto Store check Orrder NY         | 21   | 20        | Out of stock | [blank]  | currentDate | currentDate | Vendor long-term |
      | Auto store 2 check add to cart moq | 21   | 20        | Out of stock | [blank]  | currentDate | currentDate | Vendor long-term |
    And with Store-specific
      | region              | store                       | msrp | casePrice | availability | arriving | category                | start       | end         |
      | Chicagoland Express | Auto store 2 switch mov moq | 12   | 12        | Out of stock | [blank]  | Pending vendor response | currentDate | currentDate |
    And Admin click update Mass editing SKU
    And Admin verify content of alert
      | Product has been mass updated successfully! |
    And Admin click Mass editing SKU
    And Go to "Store-specific" tab
    And Admin check store-specific of SKU "sku random" on Mass editing
      | store                              | region | casePrice | startDate   | endDate     | inventoryCount |
      | Auto Store Chicago1                | CHI    | 10        | currentDate | currentDate | 10 cases       |
      | Auto storte PD Northeast           | PDE    | 12        | currentDate | currentDate | [blank]        |
      | Auto store 2 switch mov moq        | CHI    | 12        | currentDate | currentDate | 10 cases       |
      | Auto store check Order PD Print SL | PDC    | 20        | currentDate | currentDate | [blank]        |
      | Auto Store check Orrder NY         | NY     | 20        | currentDate | currentDate | [blank]        |
    And Admin check store-specific of SKU "sku 2 random" on Mass editing
      | store                              | region | casePrice | startDate   | endDate     | inventoryCount |
      | Auto Store Chicago1                | CHI    | 10        | currentDate | currentDate | 15 cases       |
      | Auto storte PD Northeast           | PDE    | 12        | currentDate | currentDate | [blank]        |
      | Auto store 2 switch mov moq        | CHI    | 12        | currentDate | currentDate | 15 cases       |
      | Auto store check Order PD Print SL | PDC    | 20        | currentDate | currentDate | [blank]        |
      | Auto Store check Orrder NY         | NY     | 20        | currentDate | currentDate | [blank]        |
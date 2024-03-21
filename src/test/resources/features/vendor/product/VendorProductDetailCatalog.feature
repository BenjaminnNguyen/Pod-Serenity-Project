#mvn clean verify -Dtestsuite="AddToCartTestSuite" -Dcucumber.options="src/test/resources/features/addtocart" -Denvironments=product
@feature=vendorProductDetail
Feature: Vendor Product Detail

  @V/LP_PRODUCT_DETAILS_5
  Scenario: Vendor - Verify Block 1 (Left side)
    Given BAO_ADMIN12 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor product detail" by api
    And Admin delete product name "Auto vendor product detail" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | Auto vendor product detail1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "Auto vendor product detail sku1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor search product "Auto vendor product detail1" on catalog
    And Vendor Go to product detail
      | productName                 | unitDimension | caseDimension | unitSize | casePack |
      | Auto vendor product detail1 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1        |
    And "Vendor" go to breadcrumb navigation title "Catalog"
    And Check current URL
      | title                                                                   | url                  |
      | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/products |
    And Vendor go back by browser
    And "Vendor" go to breadcrumb navigation title "Bakery"
    And Check current URL
      | title                                                                   | url                                |
      | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/products?category_id=1 |
    And Vendor go back by browser
    And "Vendor" go to breadcrumb navigation title "Bao Bakery"
    And Check current URL
      | title                                                                   | url                                                           |
      | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/products?category_id=1&q%5Bproduct_type_id%5D=115 |
    And Vendor go back by browser
    And "Vendor" go to breadcrumb navigation title "Auto vendor product detail1"
    And Check current URL
      | title                                                                                       | url                                                               |
      | Auto vendor product detail1 - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/auto-vendor-product-detail1-auto-brand-create-product |

    Given LP open web LP
    When login to beta web with email "bao@podfoods.co" pass "12345678a" role "LP"
    And LP search item "Auto vendor product detail1" on catalog
    And "LP" choose filter by "Order by Popularity"
    And LP go to detail of product "Auto vendor product detail1"
    And "Vendor" go to breadcrumb navigation title "Catalog"
    And Check current URL
      | title                                                                   | url                  |
      | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/products |
    And Vendor go back by browser
    And "LP" go to breadcrumb navigation title "Bakery"
    And Check current URL
      | title                                                                   | url                                |
      | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/products?category_id=1 |
    And Vendor go back by browser
    And "LP" go to breadcrumb navigation title "Bao Bakery"
    And Check current URL
      | title                                                                   | url                                                           |
      | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/products?category_id=1&q%5Bproduct_type_id%5D=115 |
    And Vendor go back by browser
    And "LP" go to breadcrumb navigation title "Auto vendor product detail1"
    And Check current URL
      | title                                                                                       | url                                                               |
      | Auto vendor product detail1 - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/auto-vendor-product-detail1-auto-brand-create-product |

  @V/LP_PRODUCT_DETAILS_4
  Scenario: (b1) Check display of the master image
    Given BAO_ADMIN12 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor product detail1" by api
    And Admin delete product name "Auto vendor product detail1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | Auto vendor product detail1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
#    And Add nutrition label to SKU
#      | nutritionLabelImage | nutritionDescription   |
#      | nutritionImage.jpg  | nutrition description1 |

    And Admin create SKU of product "" by api
      | name                                   | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage     | barcodeImage | caseImage   | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | random Auto vendor product detail sku1 | active | 1          | 0          | 123123123123 | 123123123123 | Barcodes::Upc | masterImage.jpg | UPCImage.png | anhJPEG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 1        | Auto ingredients 1 | Auto description 1 |

    And Admin create SKU of product "" by api
      | name                                   | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage | barcodeImage       | caseImage       | nutritionLabelImage | masterCartonImage | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | random Auto vendor product detail sku2 | active | 2          | 0          | 123123123124 | 123123123124 | Barcodes::Upc | anhJPEG.jpg | nutritionImage.jpg | masterImage.jpg | nutritionImage.jpg  | UPCImage.png      | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 2        | Auto ingredients 2 | Auto description 2 |
    And Admin add tag to SKU "create by api" by api
      | tag_id | tag_name          | expiry_date |
      | 81     | Auto Bao Tags     | Plus1       |
      | 56     | Private SKU tag_1 | Plus1       |
    Given BAO_ADMIN11 open web admin
    When BAO_ADMIN11 login to web with role Admin
    And BAO_ADMIN11 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto vendor product detail1 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "Auto vendor product detail1"
    And Admin go to SKU detail "random Auto vendor product detail sku2"
    And with Tags
      | tagName          | expiryDate |
      | Auto Bao Tags    | Plus1      |
      | Public SKU tag_1 | Plus1      |
    And Click Create
    And Admin check message of sku "random Auto vendor product detail sku2" is "Variant have been saved successfully !!"

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor search product "Auto vendor product detail1" on catalog
    And Go to detail of product "Auto vendor product detail1" from catalog
    And Vendor check product detail
      | productName                 | unitDimension | caseDimension | unitSize | casePack        | unitUPC      |
      | Auto vendor product detail1 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case | 123123123123 |
    And Vendor check regions detail
      | region              | price  | casePrice | msrp   | availability | moq | margin |
      | Chicagoland Express | $10.00 | $10.00    | $10.00 | In Stock     | 1   | 0%     |
    And and check details information
      | brandLocation  | storage   | retail    | ingredients        | temperatureRequirements |
      | Bronx, Alabama | 1 day Dry | 1 day Dry | Auto ingredients 1 | 1.0 F - 1.0 F           |
    And and check product description
      | description        |
      | Auto description 1 |
    And and product qualities
      | 100% Natural |
    And Vendor check master image info
      | masterImage     | skuName                                | numberSKU |
      | masterImage.jpg | random Auto vendor product detail sku1 | 1/2       |
    And Buyer choose SKU "random Auto vendor product detail sku2" in product detail
    And Vendor check product detail
      | productName                 | unitDimension | caseDimension | unitSize | casePack         | unitUPC      |
      | Auto vendor product detail1 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case | 123123123124 |
    And Vendor check regions detail
      | region              | price | casePrice | msrp   | availability | moq | margin |
      | Chicagoland Express | $5.00 | $10.00    | $10.00 | In Stock     | 1   | 50%    |
    And and check details information
      | brandLocation  | storage   | retail    | ingredients        | temperatureRequirements |
      | Bronx, Alabama | 1 day Dry | 1 day Dry | Auto ingredients 2 | 1.0 F - 1.0 F           |
    And and check product description
      | description        |
      | Auto description 2 |
    And and product qualities
      | 100% Natural |
    And Vendor check master image info
      | masterImage | skuName                                | numberSKU |
      | anhJPEG.jpg | random Auto vendor product detail sku2 | 2/2       |
    And Vendor check tags of sku on catalog
      | tag              |
      | Auto Bao Tags    |
      | Public SKU tag_1 |
    And Vendor click "previous" from list SKU on Product detail catalog
    And Vendor check product detail
      | productName                 | unitDimension | caseDimension | unitSize | casePack        | unitUPC      |
      | Auto vendor product detail1 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case | 123123123123 |
    And Vendor check regions detail
      | region              | price  | casePrice | msrp   | availability | moq | margin |
      | Chicagoland Express | $10.00 | $10.00    | $10.00 | In Stock     | 1   | 0%     |
    And Vendor check master image info
      | masterImage     | skuName                                | numberSKU |
      | masterImage.jpg | random Auto vendor product detail sku1 | 1/2       |
    And Vendor click "next" from list SKU on Product detail catalog
    And Vendor check product detail
      | productName                 | unitDimension | caseDimension | unitSize | casePack         | unitUPC      |
      | Auto vendor product detail1 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case | 123123123124 |
    And Vendor check regions detail
      | region              | price | casePrice | msrp   | availability | moq | margin |
      | Chicagoland Express | $5.00 | $10.00    | $10.00 | In Stock     | 1   | 50%    |
    And Vendor check master image info
      | masterImage | skuName                                | numberSKU |
      | anhJPEG.jpg | random Auto vendor product detail sku2 | 2/2       |

    Given LP open web LP
    When login to beta web with email "bao@podfoods.co" pass "12345678a" role "LP"
    And LP search item "Auto vendor product detail1" on catalog
    And "LP" choose filter by "Order by Popularity"
    And LP go to detail of product "Auto vendor product detail1"
    And LP check detail of product
      | product                     | brand                     | available           | unitUPC      | casePack        |
      | Auto vendor product detail1 | Auto brand create product | Chicagoland Express | 123123123123 | 1 unit per case |
    And Vendor check master image info
      | masterImage     | skuName                                | numberSKU |
      | masterImage.jpg | random Auto vendor product detail sku1 | 1/2       |
    And Vendor check available in of sku on catalog
      | region              |
      | Chicagoland Express |
    And Buyer choose SKU "random Auto vendor product detail sku2" in product detail
    And LP check detail of product
      | product                     | brand                     | available           | unitUPC      | casePack         |
      | Auto vendor product detail1 | Auto brand create product | Chicagoland Express | 123123123124 | 2 units per case |
    And Vendor check master image info
      | masterImage | skuName                                | numberSKU |
      | anhJPEG.jpg | random Auto vendor product detail sku2 | 2/2       |
    And Vendor check available in of sku on catalog
      | region              |
      | Chicagoland Express |
    And Vendor check tags of sku on catalog
      | tag              |
      | Auto Bao Tags    |
      | Public SKU tag_1 |
    And Vendor click "previous" from list SKU on Product detail catalog
    And LP check detail of product
      | product                     | brand                     | available           | unitUPC      | casePack        |
      | Auto vendor product detail1 | Auto brand create product | Chicagoland Express | 123123123123 | 1 unit per case |
    And Vendor check master image info
      | masterImage     | skuName                                | numberSKU |
      | masterImage.jpg | random Auto vendor product detail sku1 | 1/2       |
    And Vendor click "next" from list SKU on Product detail catalog
    And LP check detail of product
      | product                     | brand                     | available           | unitUPC      | casePack         |
      | Auto vendor product detail1 | Auto brand create product | Chicagoland Express | 123123123124 | 2 units per case |
    And Vendor check master image info
      | masterImage | skuName                                | numberSKU |
      | anhJPEG.jpg | random Auto vendor product detail sku2 | 2/2       |
    And Vendor check available in of sku on catalog
      | region              |
      | Chicagoland Express |
    And Vendor check tags of sku on catalog
      | tag              |
      | Auto Bao Tags    |
      | Public SKU tag_1 |

    And Admin change info of regions attributes of sku "random Auto vendor product detail sku1" state "draft"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | active |
    And VENDOR refresh browser
    And Vendor check product detail
      | productName                 | unitDimension | caseDimension | unitSize | casePack         | unitUPC      |
      | Auto vendor product detail1 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case | 123123123124 |
    And Vendor check regions detail
      | region              | price | casePrice | msrp   | availability | moq | margin |
      | Chicagoland Express | $5.00 | $10.00    | $10.00 | In Stock     | 1   | 50%    |
    And Vendor check master image info
      | masterImage | skuName                                | numberSKU |
      | anhJPEG.jpg | random Auto vendor product detail sku2 | 1/1       |

    And LP refresh browser
    And LP check detail of product
      | product                     | brand                     | available           | unitUPC      | casePack         |
      | Auto vendor product detail1 | Auto brand create product | Chicagoland Express | 123123123124 | 2 units per case |
    And Vendor check master image info
      | masterImage | skuName                                | numberSKU |
      | anhJPEG.jpg | random Auto vendor product detail sku2 | 1/1       |
    And Vendor check tags of sku on catalog
      | tag              |
      | Auto Bao Tags    |
      | Public SKU tag_1 |
    And Vendor check available in of sku on catalog
      | region              |
      | Chicagoland Express |

  @V/LP_PRODUCT_DETAILS_26
  Scenario: Check display conditions of Minimum Order Quantity field
    Given BAO_ADMIN12 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor product detail26" by api
    And Admin delete product name "Auto vendor product detail26" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | Auto vendor product detail26 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Pod Direct Central  | 58 | active | in_stock     | 1000      | 1000 |
#    And Add nutrition label to SKU
#      | nutritionLabelImage | nutritionDescription   |
#      | nutritionImage.jpg  | nutrition description1 |
    And Admin create SKU of product "" by api
      | name                                    | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage     | barcodeImage | caseImage   | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | random Auto vendor product detail sku26 | active | 1          | 0          | 123123123123 | 123123123123 | Barcodes::Upc | masterImage.jpg | UPCImage.png | anhJPEG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 1        | Auto ingredients 1 | Auto description 1 |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor search product "Auto vendor product detail26" on catalog
    And Go to detail of product "Auto vendor product detail26" from catalog
    And Vendor check product detail
      | productName                  | casePack        | unitUPC      |
      | Auto vendor product detail26 | 1 unit per case | 123123123123 |
    And Vendor check available in of sku on catalog
      | region              |
      | Pod Direct Central  |
      | Chicagoland Express |
    And and check details information
      | brandLocation  | storage   | retail    | ingredients        | temperatureRequirements |
      | Bronx, Alabama | 1 day Dry | 1 day Dry | Auto ingredients 1 | 1.0 F - 1.0 F           |
    And and check product description
      | description        |
      | Auto description 1 |
    And and product qualities
      | 100% Natural |
    And Vendor check master image info
      | masterImage     | skuName                                 | numberSKU |
      | masterImage.jpg | random Auto vendor product detail sku26 | 1/1       |
    And Vendor copy link share product
#    And Vendor check copy link share product
#  Headless k check dc

  @V/LP_PRODUCT_DETAILS_29
  Scenario: Check displayed information on the regions table
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info
      | name                 | vendorCompany | managedBy | state  | tags    |
      | Auto Create Brand 03 | [blank]       | [blank]   | Active | [blank] |
    And Admin remove the brand the first record
    And Admin go to create brand
    And Admin create new brand
      | name                 | description | microDescriptions | city | state   | vendorCompany           |
      | Auto Create Brand 03 | description | microDescriptions | city | Alabama | Auto_Vendor_Company_MOQ |
    And Admin create brand success
    And ADMIN navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info then system show result
      | name                 | vendorCompany | managedBy | state  | tags    |
      | Auto Create Brand 03 | [blank]       | [blank]   | Active | [blank] |
    And ADMIN navigate to "Products" to "All products" by sidebar
    And Create new Product
      | brandName            | productName   | status | allowRequestSamples | vendorCompany           | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions |
      | Auto Create Brand 03 | auto_product3 | Active | Yes                 | Auto_Vendor_Company_MOQ | 0.00%         | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 10             | 10            | 10                  | 0                      | 0                    | 0                          | 0                         | 0                          | 0                | [blank]           |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Check product not have SKU
    And Add new SKU
      | skuName               | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto_flow create sku3 | [blank] | [blank] | 12        | 123456789098      | no                    | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | [blank]          | 10              | [blank]         | 10                 | 40                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving |
      | Dallas Express           | 12        | 15       | In stock     | [blank]  |
      | Chicagoland Express      | 12        | 15       | In stock     | [blank]  |
      | Florida Express          | 12        | 15       | In stock     | [blank]  |
      | Mid Atlantic Express     | 12        | 15       | Out of stock | [blank]  |
#      | New York Express               | 12        | 15       | Launching soon | currentDate |
      | North California Express | 12        | 15       | In stock     | [blank]  |
      | South California Express | 12        | 15       | In stock     | [blank]  |
      | Pod Direct Central       | 12        | 15       | In stock     | [blank]  |
#      | Pod Direct Northeast           | 12        | 15       | Launching soon | currentDate |
      | Pod Direct East          | 12        | 15       | Out of stock | [blank]  |
#      | Pod Direct Southwest & Rockies | 12        | 15       | In stock     | [blank]  |
      | Pod Direct West          | 12        | 15       | In stock     | [blank]  |
    And Click Create
    Given VENDOR open web user
    When login to beta web with email "ngoctx+vendormoq@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Vendor Check Brand on Dashboard
      | brandName            | city | state   | country | description |
      | Auto Create Brand 03 | city | Alabama | U.S     | description |
    And Vendor check brand in detail
      | brandName            | city | state   | country | description |
      | Auto Create Brand 03 | city | Alabama | U.S     | description |
    And Vendor go to all brands page
    And Vendor search brand on catalog
      | brandName            | city | state   |
      | Auto Create Brand 03 | city | Alabama |
    And Vendor go to brand "Auto Create Brand 03" detail on catalog
    And Vendor check brand detail on catalog
      | brandName            | city | state   | description |
      | Auto Create Brand 03 | city | Alabama | description |
    And Vendor check a product on brand detail
      | auto_product3 |
    And Vendor Go to product detail
      | productName   | unitDimension   | caseDimension   | unitSize | casePack |
      | auto_product3 | 12" x 12" x 12" | 12" x 12" x 12" | 8.0      | 12       |
    And Vendor check regions detail
      | region                   | price | casePrice | msrp   | availability | moq |
      | Pod Direct West          | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
#      | Pod Direct Southwest & Rockies | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
      | Pod Direct East          | $1.00 | $12.00    | $15.00 | Out Of Stock | 1   |
#      | Pod Direct Northeast           | $1.00 | $12.00    | $15.00 | Launching Soon | 1   |
      | Pod Direct Central       | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
      | South California Express | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
      | North California Express | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
#      | New York Express               | $1.00 | $12.00    | $15.00 | Launching Soon | 1   |
      | Mid Atlantic Express     | $1.00 | $12.00    | $15.00 | Out Of Stock | 1   |
      | Florida Express          | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
      | Chicagoland Express      | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
      | Dallas Express           | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |

  @V/LP_PRODUCT_DETAILS_32
  Scenario:(l3) Check display condition of price change icon shown for each SKU
    Given BAO_ADMIN12 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor product detail" by api
    And Admin delete product name "Auto vendor product detail" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | Auto vendor product detail1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
#    And Add nutrition label to SKU
#      | nutritionLabelImage | nutritionDescription   |
#      | nutritionImage.jpg  | nutrition description1 |
#      | nutritionLabel2.png | nutrition description2 |
    And Admin create SKU of product "" by api
      | name                                   | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage     | barcodeImage | caseImage   | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | random Auto vendor product detail sku1 | active | 1          | 0          | 123123123123 | 123123123123 | Barcodes::Upc | masterImage.jpg | UPCImage.png | anhJPEG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 1        | Auto ingredients 1 | Auto description 1 |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor search product "Auto vendor product detail1" on catalog
    And Go to detail of product "Auto vendor product detail1" from catalog
    And Vendor check product detail
      | productName                 | unitDimension | caseDimension | unitSize | casePack        | unitUPC      |
      | Auto vendor product detail1 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case | 123123123123 |
    And and check details information
      | brandLocation  | storage   | retail    | ingredients        | temperatureRequirements |
      | Bronx, Alabama | 1 day Dry | 1 day Dry | Auto ingredients 1 | 1.0 F - 1.0 F           |
    And Check nutrition labels
      | image               |
#      | nutritionLabel2.png |
      | nutritionImage.jpg  |

    Given LP open web LP
    When login to beta web with email "bao@podfoods.co" pass "12345678a" role "LP"
    And LP search item "Auto vendor product detail1" on catalog
    And "LP" choose filter by "Order by Popularity"
    And LP go to detail of product "Auto vendor product detail1"
    And Check nutrition labels
      | image               |
#      | nutritionLabel2.png |
      | nutritionImage.jpg  |

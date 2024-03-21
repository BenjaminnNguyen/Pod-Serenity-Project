@feature=buyerProductDetail
Feature: Buyer Product Detail

  @B_PRODUCT_DETAILS_3 @B_PRODUCT_DETAILS
  Scenario Outline: Check displayed information on the Catalog of the bread crumb - normal buyers
    Given BAO_ADMIN login web admin by api
      | email             | password  |
      | bao32@podfoods.co | 12345678a |
    And Admin search product name "random product detail buyer 03" by api
    And Admin delete product name "random product detail buyer 03" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | random product detail buyer 03 | 2952     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU of product "" by api
      | name                                | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage     | barcodeImage | caseImage   | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | random product detail buyer 03 sku1 | active | 1          | 0          | 123123123123 | 123123123123 | Barcodes::Upc | masterImage.jpg | UPCImage.png | anhJPEG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 1        | Auto ingredients 1 | Auto description 1 |
    And Clear Info of Region api
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 2000      | 2000 |
    And Admin create SKU of product "" by api
      | name                                | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage | barcodeImage       | caseImage       | nutritionLabelImage | masterCartonImage | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | random product detail buyer 03 sku2 | active | 2          | 0          | 123123123124 | 123123123124 | Barcodes::Upc | anhJPEG.jpg | nutritionImage.jpg | masterImage.jpg | nutritionImage.jpg  | UPCImage.png      | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 2        | Auto ingredients 2 | Auto description 2 |
    And Admin add tag to SKU "create by api" by api
      | tag_id | tag_name          | expiry_date |
      | 81     | Auto Bao Tags     | Plus1       |
      | 56     | Private SKU tag_1 | Plus1       |
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product detail buyer 03"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                         | product                        | sku   | price  |
      | showing | Auto Brand check availability | random product detail buyer 03 | 2SKUs | $10.00 |
    And Go to detail of product "random product detail buyer 03" from catalog
    And Buyer choose SKU "random product detail buyer 03" in product detail
    And "Buyer" go to breadcrumb navigation title "Catalog"
    And Check current URL
      | title                                                                   | url                  |
      | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/products |
    And Buyer go back by browser
    And "Buyer" go to breadcrumb navigation title "Bakery"
    And Check current URL
      | title                                                                   | url                                |
      | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/products?category_id=1 |
    And Buyer go back by browser
    And "Buyer" go to breadcrumb navigation title "Bao Bakery"
    And Check current URL
      | title                                                                   | url                                                           |
      | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/products?category_id=1&q%5Bproduct_type_id%5D=115 |
    And Buyer go back by browser
    And Check current URL
      | title                          | url                                        |
      | random product detail buyer 03 | podfoods.co/random-product-detail-buyer-03 |
    And Buyer check detail of product
      | productName                    | productBrand                  | address | pricePerCase | availability |
      | random product detail buyer 03 | Auto Brand check availability | ,       | $10.00       | In Stock     |
    And Buyer check master image info
      | masterImage     | skuName                             | numberSKU |
      | masterImage.jpg | random product detail buyer 03 sku1 | 1/2       |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $10.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
    And and check details information
      | brandLocation  | storage   | retail    | ingredients        | temperatureRequirements |
      | Bronx, Alabama | 1 day Dry | 1 day Dry | Auto ingredients 1 | 1.0 F - 1.0 F           |
    And and product qualities
      | 100% Natural |
    And and check product description
      | description        |
      | Auto description 1 |
    And BUYER choose SKU "random product detail buyer 03 sku2" in product detail
    And Buyer check detail of product
      | productName                    | productBrand                  | address | pricePerCase | availability |
      | random product detail buyer 03 | Auto Brand check availability | ,       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack         |
      | 123123123124 | 50%         | $20.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case |
    And Buyer check master image info
      | masterImage | skuName                             | numberSKU |
      | anhJPEG.jpg | random product detail buyer 03 sku2 | 2/2       |
    And and check details information
      | brandLocation  | storage   | retail    | ingredients        | temperatureRequirements |
      | Bronx, Alabama | 1 day Dry | 1 day Dry | Auto ingredients 2 | 1.0 F - 1.0 F           |
    And and product qualities
      | 100% Natural |
    And and check product description
      | description        |
      | Auto description 2 |
    And BUYER check tags of sku on catalog
      | tag               |
      | Auto Bao Tags     |
      | Private SKU tag_1 |
    And BUYER choose SKU "random product detail buyer 03 sku1" in product detail
    And Buyer check detail of product
      | productName                    | productBrand                  | address | pricePerCase | availability |
      | random product detail buyer 03 | Auto Brand check availability | ,       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $10.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
    And and check details information
      | brandLocation  | storage   | retail    | ingredients        | temperatureRequirements |
      | Bronx, Alabama | 1 day Dry | 1 day Dry | Auto ingredients 1 | 1.0 F - 1.0 F           |
    And and product qualities
      | 100% Natural |
    And and check product description
      | description        |
      | Auto description 1 |
    And BUYER click "next" from list SKU on Product detail catalog
    And BUYER click "previous" from list SKU on Product detail catalog
#    Change state SKU
    And Admin change info of regions attributes of sku "random product detail buyer 03 sku1" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | inactive |
    And BUYER refresh browser
    And Buyer check detail of product
      | productName                    | productBrand                  | address | pricePerCase | availability |
      | random product detail buyer 03 | Auto Brand check availability | ,       | $20.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack         |
      | 123123123124 | 50%         | $20.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case |
    And Buyer check master image info
      | masterImage | skuName                             | numberSKU |
      | anhJPEG.jpg | random product detail buyer 03 sku2 | 1/1       |
    And and check details information
      | brandLocation  | storage   | retail    | ingredients        | temperatureRequirements |
      | Bronx, Alabama | 1 day Dry | 1 day Dry | Auto ingredients 2 | 1.0 F - 1.0 F           |
    And and product qualities
      | 100% Natural |
    And and check product description
      | description        |
      | Auto description 2 |
    And BUYER check tags of sku on catalog
      | tag               |
      | Auto Bao Tags     |
      | Private SKU tag_1 |
    Examples:
      | role_            | buyer                            |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co |
      | Sub buyer        | ngoctx+autobuyer32@podfoods.co   |

  @B_PRODUCT_DETAILS_4 @B_PRODUCT_DETAILS
  Scenario: Check displayed information on the Catalog of the bread crumb - Store manager PD buyers
    Given BAO_ADMIN login web admin by api
      | email             | password  |
      | bao32@podfoods.co | 12345678a |
    And Admin search product name "random product detail buyer 03" by api
    And Admin delete product name "random product detail buyer 03" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | random product detail buyer 03 | 2952     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Pod Direct Central  | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU of product "" by api
      | name                                | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage     | barcodeImage | caseImage   | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | random product detail buyer 03 sku1 | active | 1          | 0          | 123123123123 | 123123123123 | Barcodes::Upc | masterImage.jpg | UPCImage.png | anhJPEG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 1        | Auto ingredients 1 | Auto description 1 |
    And Clear Info of Region api
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 2000      | 2000 |
    And Admin create SKU of product "" by api
      | name                                | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage | barcodeImage       | caseImage       | nutritionLabelImage | masterCartonImage | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | random product detail buyer 03 sku2 | active | 2          | 0          | 123123123124 | 123123123124 | Barcodes::Upc | anhJPEG.jpg | nutritionImage.jpg | masterImage.jpg | nutritionImage.jpg  | UPCImage.png      | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 2        | Auto ingredients 2 | Auto description 2 |
    And Admin add tag to SKU "create by api" by api
      | tag_id | tag_name          | expiry_date |
      | 81     | Auto Bao Tags     | Plus1       |
      | 56     | Private SKU tag_1 | Plus1       |
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer63@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product detail buyer 03"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                         | product                        | sku   | price  |
      | showing | Auto Brand check availability | random product detail buyer 03 | 2SKUs | $10.00 |
    And Go to detail of product "random product detail buyer 03" from catalog
    And Buyer choose SKU "random product detail buyer 03" in product detail
    And "Buyer" go to breadcrumb navigation title "Catalog"
    And Check current URL
      | title                                                                   | url                  |
      | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/products |
    And Buyer go back by browser
    And "Buyer" go to breadcrumb navigation title "Bakery"
    And Check current URL
      | title                                                                   | url                                |
      | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/products?category_id=1 |
    And Buyer go back by browser
    And "Buyer" go to breadcrumb navigation title "Bao Bakery"
    And Check current URL
      | title                                                                   | url                                                           |
      | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/products?category_id=1&q%5Bproduct_type_id%5D=115 |
    And Buyer go back by browser
    And Check current URL
      | title                          | url                                        |
      | random product detail buyer 03 | podfoods.co/random-product-detail-buyer-03 |
    And Buyer check detail of product
      | productName                    | productBrand                  | address | pricePerCase | availability |
      | random product detail buyer 03 | Auto Brand check availability | ,       | $10.00       | In Stock     |
    And Buyer check master image info
      | masterImage     | skuName                             | numberSKU |
      | masterImage.jpg | random product detail buyer 03 sku1 | 1/2       |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $10.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
    And and check details information
      | brandLocation  | storage   | retail    | ingredients        | temperatureRequirements |
      | Bronx, Alabama | 1 day Dry | 1 day Dry | Auto ingredients 1 | 1.0 F - 1.0 F           |
    And and product qualities
      | 100% Natural |
    And and check product description
      | description        |
      | Auto description 1 |
    And BUYER choose SKU "random product detail buyer 03 sku2" in product detail
    And Buyer check detail of product
      | productName                    | productBrand                  | address | pricePerCase | availability |
      | random product detail buyer 03 | Auto Brand check availability | ,       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack         |
      | 123123123124 | 50%         | $20.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case |
    And Buyer check master image info
      | masterImage | skuName                             | numberSKU |
      | anhJPEG.jpg | random product detail buyer 03 sku2 | 2/2       |
    And and check details information
      | brandLocation  | storage   | retail    | ingredients        | temperatureRequirements |
      | Bronx, Alabama | 1 day Dry | 1 day Dry | Auto ingredients 2 | 1.0 F - 1.0 F           |
    And and product qualities
      | 100% Natural |
    And and check product description
      | description        |
      | Auto description 2 |
    And BUYER check tags of sku on catalog
      | tag               |
      | Auto Bao Tags     |
      | Private SKU tag_1 |
    And BUYER choose SKU "random product detail buyer 03 sku1" in product detail
    And Buyer check detail of product
      | productName                    | productBrand                  | address | pricePerCase | availability |
      | random product detail buyer 03 | Auto Brand check availability | ,       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $10.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
    And and check details information
      | brandLocation  | storage   | retail    | ingredients        | temperatureRequirements |
      | Bronx, Alabama | 1 day Dry | 1 day Dry | Auto ingredients 1 | 1.0 F - 1.0 F           |
    And and product qualities
      | 100% Natural |
    And and check product description
      | description        |
      | Auto description 1 |
    And BUYER click "next" from list SKU on Product detail catalog
    And BUYER click "previous" from list SKU on Product detail catalog
#    Change state SKU
    And Admin change info of regions attributes of sku "random product detail buyer 03 sku1" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 58        | [blank]            | 1000             | 1000       | in_stock     | inactive |
    And BUYER refresh browser
    And Buyer check detail of product
      | productName                    | productBrand                  | address | pricePerCase | availability |
      | random product detail buyer 03 | Auto Brand check availability | ,       | $20.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack         |
      | 123123123124 | 50%         | $20.00 | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case |
    And Buyer check master image info
      | masterImage | skuName                             | numberSKU |
      | anhJPEG.jpg | random product detail buyer 03 sku2 | 1/1       |
    And and check details information
      | brandLocation  | storage   | retail    | ingredients        | temperatureRequirements |
      | Bronx, Alabama | 1 day Dry | 1 day Dry | Auto ingredients 2 | 1.0 F - 1.0 F           |
    And and product qualities
      | 100% Natural |
    And and check product description
      | description        |
      | Auto description 2 |
    And BUYER check tags of sku on catalog
      | tag               |
      | Auto Bao Tags     |
      | Private SKU tag_1 |

  @B_PRODUCT_DETAILS_5 @B_PRODUCT_DETAILS
  Scenario:Check displayed information on the Catalog of the bread crumb - head buyers
    Given BAO_ADMIN login web admin by api
      | email             | password  |
      | bao33@podfoods.co | 12345678a |
    And Admin search product name "random product detail buyer 03" by api
    And Admin delete product name "random product detail buyer 03" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | random product detail buyer 03 | 2952     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |

    And Admin create a "active" SKU from admin with name "random product detail buyer 03" of product ""
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer49@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product detail buyer 03"
    And "BUYER" choose filter by "Order by Newest"

    And Go to detail of product "random product detail buyer 03" from catalog
    And Buyer choose SKU "random product detail buyer 03" in product detail
    And "Buyer" go to breadcrumb navigation title "Catalog"
    And Check current URL
      | title                                                                   | url                  |
      | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands | podfoods.co/products |
    And Buyer go back by browser
    And Check current URL
      | title                          | url                                        |
      | random product detail buyer 03 | podfoods.co/random-product-detail-buyer-03 |

  @B_PRODUCT_DETAILS_8 @B_PRODUCT_DETAILS
  Scenario: Check Total number of SKUs shown on the master image - PD buyer
##    Create SKU
#    Given BAO_ADMIN login web admin by api
#      | email             | password  |
#      | bao33@podfoods.co | 12345678a |
#    And Admin search product name "random product detail buyer 08" by api
#    And Admin delete product name "random product detail buyer 08" by api
#    And Create product by api with file "CreateProduct.json" and info
#      | name                           | brand_id |
#      | random product detail buyer 08 | 2952     |
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
##    And Admin create a "active" SKU from admin with name "random product detail buyer sku 081" of product ""
#    And Admin create SKU of product "" by api
#      | name                                | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage     | barcodeImage | caseImage   | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
#      | random product detail buyer sku 081 | active | 1          | 0          | 123123123123 | 123123123123 | Barcodes::Upc | masterImage.jpg | UPCImage.png | anhJPEG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 1        | Auto ingredients 1 | Auto description 1 |
#    And Clear Info of Region api
#    And Info of Region
#      | region             | id | state  | availability | casePrice | msrp | out_of_stock_reason   | auto_out_of_stock_reason |
#      | Pod Direct Central | 58 | active | sold_out     | 1000      | 1000 | pending_replenishment | pending_replenishment    |
##    And Admin create a "active" SKU from admin with name "random product detail buyer sku 082" of product ""
#    And Admin create SKU of product "" by api
#      | name                                | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage      | barcodeImage | caseImage  | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
#      | random product detail buyer sku 082 | active | 1          | 0          | 123123123123 | 123123123123 | Barcodes::Upc | masterImage2.jpg | UPCImage.png | anhJPG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 2        | Auto ingredients 1 | Auto description 1 |
#    And Clear Info of Region api
#    And Info of Region
#      | region           | id | state  | availability | casePrice | msrp |
#      | New York Express | 53 | active | in_stock     | 1000      | 1000 |
##    And Admin create a "active" SKU from admin with name "random product detail buyer sku 083" of product ""
#    And Admin create SKU of product "" by api
#      | name                                | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage      | barcodeImage | caseImage  | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
#      | random product detail buyer sku 083 | active | 1          | 0          | 123123123123 | 123123123123 | Barcodes::Upc | masterImage3.jpg | UPCImage.png | anhJPG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 3        | Auto ingredients 1 | Auto description 1 |
#    And Clear Info of Region api
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
##    And Admin create a "draft" SKU from admin with name "random product detail buyer sku 084" of product ""
#    And Admin create SKU of product "" by api
#      | name                                | state | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage      | barcodeImage | caseImage  | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
#      | random product detail buyer sku 084 | draft | 1          | 0          | 123123123123 | 123123123123 | Barcodes::Upc | masterImage4.jpg | UPCImage.png | anhJPG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 4        | Auto ingredients 1 | Auto description 1 |
#
#    And Clear Info of Region api
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
##    And Admin create a "inactive" SKU from admin with name "random product detail buyer sku 085" of product ""
#    And Admin create SKU of product "" by api
#      | name                                | state    | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage      | barcodeImage | caseImage  | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
#      | random product detail buyer sku 085 | inactive | 1          | 0          | 123123123123 | 123123123123 | Barcodes::Upc | masterImage5.jpg | UPCImage.png | anhJPG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 5        | Auto ingredients 1 | Auto description 1 |
#    And Clear Info of Region api
#    And Info of Store specific
#      | store_id | store_name              | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
#      | 2561     | Auto Bao Store Express1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
##    And Admin create a "active" SKU from admin with name "random product detail buyer sku 086" of product ""
#    And Admin create SKU of product "" by api
#      | name                                | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage      | barcodeImage | caseImage  | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
#      | random product detail buyer sku 086 | active | 1          | 0          | 123123123123 | 123123123123 | Barcodes::Upc | masterImage2.jpg | UPCImage.png | anhJPG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 6        | Auto ingredients 1 | Auto description 1 |
#    And Clear Info of store api
#    And Info of Buyer company specific
#      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability | out_of_stock_reason   | auto_out_of_stock_reason |
#      | 2216             | Auto_BuyerCompany  | 58        | currentDate | currentDate | 1000             | 1000       | sold_out     | pending_replenishment | pending_replenishment    |
##    And Admin create a "active" SKU from admin with name "random product detail buyer sku 087" of product ""
#    And Admin create SKU of product "" by api
#      | name                                | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage      | barcodeImage | caseImage  | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
#      | random product detail buyer sku 087 | active | 1          | 0          | 123123123123 | 123123123123 | Barcodes::Upc | masterImage3.jpg | UPCImage.png | anhJPG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 7        | Auto ingredients 1 | Auto description 1 |
#    And Clear Info of buyer company api

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyerbao6@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product detail buyer 08"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                         | product                        | sku   | price  |
      | showing | Auto Brand check availability | random product detail buyer 08 | 2SKUs | $10.00 |
    And Go to detail of product "random product detail buyer 08" from catalog
    And Buyer check list SKU on product detail catalog page
      | skuName                             | id      | price  | quantity      |
      | random product detail buyer sku 082 | [blank] | $10.00 | Not available |
      | random product detail buyer sku 087 | [blank] | $10.00 | Not available |
    And Buyer check master image info
      | masterImage      | skuName                             | numberSKU |
      | masterImage2.jpg | random product detail buyer sku 082 | 1/2       |
    And Buyer check focus SKU on product detail
      | focus  | image            |
      | active | masterImage2.jpg |
      | next   | masterImage3.jpg |
    And BUYER click "next" from list SKU on Product detail catalog
    And Buyer check master image info
      | masterImage      | skuName                             | numberSKU |
      | masterImage3.jpg | random product detail buyer sku 087 | 2/2       |

  @B_PRODUCT_DETAILS_9 @B_PRODUCT_DETAILS
  Scenario: Check Total number of SKUs shown on the master image - PE Buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyerbao5@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product detail buyer 08"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                         | product                        | sku   | price  |
      | showing | Auto Brand check availability | random product detail buyer 08 | 4SKUs | $10.00 |
    And Go to detail of product "random product detail buyer 08" from catalog
    And Check any text "is" showing on screen
      | Share this product |
    And Buyer check list SKU on product detail catalog page
      | skuName                             | id      | price  | quantity      |
      | random product detail buyer sku 081 | [blank] | $10.00 | 0             |
      | random product detail buyer sku 082 | [blank] | $10.00 | Not available |
      | random product detail buyer sku 086 | [blank] | $10.00 | 0             |
      | random product detail buyer sku 087 | [blank] | $10.00 | Not available |
    And Buyer check master image info
      | masterImage     | skuName                             | numberSKU |
      | masterImage.jpg | random product detail buyer sku 081 | 1/4       |
    And Buyer check focus SKU on product detail
      | focus  | image            |
      | active | masterImage.jpg  |
      | next   | masterImage2.jpg |
      | next   | masterImage2.jpg |
      | next   | masterImage3.jpg |
    And BUYER click "next" from list SKU on Product detail catalog
    And Buyer check master image info
      | masterImage      | skuName                             | numberSKU |
      | masterImage2.jpg | random product detail buyer sku 082 | 2/4       |
    And BUYER click "next" from list SKU on Product detail catalog
    And Buyer check master image info
      | masterImage      | skuName                             | numberSKU |
      | masterImage2.jpg | random product detail buyer sku 086 | 3/4       |
    And BUYER click "next" from list SKU on Product detail catalog
    And Buyer check master image info
      | masterImage      | skuName                             | numberSKU |
      | masterImage3.jpg | random product detail buyer sku 087 | 4/4       |

  @B_PRODUCT_DETAILS_10 @B_PRODUCT_DETAILS
  Scenario: Check Total number of SKUs shown on the master image 3 - PE sub buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer7@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product detail buyer 08"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                         | product                        | sku   | price  |
      | showing | Auto Brand check availability | random product detail buyer 08 | 4SKUs | $10.00 |
    And Go to detail of product "random product detail buyer 08" from catalog
    And Check any text "is" showing on screen
      | Share this product |
    And Buyer check list SKU on product detail catalog page
      | skuName                             | id      | price  | quantity      |
      | random product detail buyer sku 081 | [blank] | $10.00 | Not available |
      | random product detail buyer sku 082 | [blank] | $10.00 | Not available |
      | random product detail buyer sku 086 | [blank] | $10.00 | Not available |
      | random product detail buyer sku 087 | [blank] | $10.00 | Not available |

    And Buyer check master image info
      | masterImage     | skuName                             | numberSKU |
      | masterImage.jpg | random product detail buyer sku 081 | 1/4       |
    And Buyer check focus SKU on product detail
      | focus  | image            |
      | active | masterImage.jpg  |
      | next   | masterImage2.jpg |
      | next   | masterImage2.jpg |
      | next   | masterImage3.jpg |
    And BUYER click "next" from list SKU on Product detail catalog
    And Buyer check master image info
      | masterImage      | skuName                             | numberSKU |
      | masterImage2.jpg | random product detail buyer sku 082 | 2/4       |
    And BUYER click "next" from list SKU on Product detail catalog
    And Buyer check master image info
      | masterImage      | skuName                             | numberSKU |
      | masterImage2.jpg | random product detail buyer sku 086 | 3/4       |
    And BUYER click "next" from list SKU on Product detail catalog
    And Buyer check master image info
      | masterImage      | skuName                             | numberSKU |
      | masterImage3.jpg | random product detail buyer sku 087 | 4/4       |

  @B_PRODUCT_DETAILS_11 @B_PRODUCT_DETAILS
  Scenario: Check Total number of SKUs shown on the master image 4 - Head buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+autoheadbuyer69@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product detail buyer 08"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                         | product                        | sku   |
      | showing | Auto Brand check availability | random product detail buyer 08 | 5SKUs |
    And Go to detail of product "random product detail buyer 08" from catalog
    And Check any text "is" showing on screen
      | Share this product |
    And Head buyer check list SKU on product detail catalog page
      | skuName                             | id      |
      | random product detail buyer sku 081 | [blank] |
      | random product detail buyer sku 082 | [blank] |
      | random product detail buyer sku 083 | [blank] |
      | random product detail buyer sku 086 | [blank] |
      | random product detail buyer sku 087 | [blank] |
    And Buyer check master image info
      | masterImage     | skuName                             | numberSKU |
      | masterImage.jpg | random product detail buyer sku 081 | 1/5       |
    And Buyer check focus SKU on product detail
      | focus  | image            |
      | active | masterImage.jpg  |
      | next   | masterImage2.jpg |
      | next   | masterImage3.jpg |
      | next   | masterImage2.jpg |
      | next   | masterImage3.jpg |
    And BUYER click "next" from list SKU on Product detail catalog
    And Buyer check master image info
      | masterImage      | skuName                             | numberSKU |
      | masterImage2.jpg | random product detail buyer sku 082 | 2/5       |
    And BUYER click "next" from list SKU on Product detail catalog
    And Buyer check master image info
      | masterImage      | skuName                             | numberSKU |
      | masterImage3.jpg | random product detail buyer sku 083 | 3/5       |
    And BUYER click "next" from list SKU on Product detail catalog
    And Buyer check master image info
      | masterImage      | skuName                             | numberSKU |
      | masterImage2.jpg | random product detail buyer sku 086 | 4/5       |
    And BUYER click "next" from list SKU on Product detail catalog
    And Buyer check master image info
      | masterImage      | skuName                             | numberSKU |
      | masterImage3.jpg | random product detail buyer sku 087 | 5/5       |

  @B_PRODUCT_DETAILS_15 @B_PRODUCT_DETAILS
  Scenario: Check display of Disclaimer warning
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer27@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product detail buyer 08"
    And "BUYER" choose filter by "Order by Newest"
    And Go to detail of product "random product detail buyer 08" from catalog
    And Check any text "is" showing on screen
      | Buyer acknowledges that the retail sale of Cannabidiol (CBD) in food and beverage products to the public for general consumption may not be legal in some jurisdictions.                                  |
      | Buyer assumes all responsibility to any third parties it chooses to sell CBD products to, and holds Pod Foods Co and its employees harmless against any legal actions that arise as a result of the sale. |

#    #    Setup data
#  @B_PRODUCT_DETAILS_24
#  Scenario: Check the display condition of Express tag and Truck icon of a SKU (Store manager+Store sub-buyer)
#    Given BAO_ADMIN login web admin by api
#      | email             | password  |
#      | bao34@podfoods.co | 12345678a |
#    And Admin search brand name "Auto random brand buyer product detail" by api
#    And Admin delete brand by API
#    And Admin create brand by API
#      | name                                   | description        | micro_description | city    | address_state_id | vendor_company_id |
#      | Auto random brand buyer product detail | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
#    And Create product by api with file "CreateProduct.json" and info
#      | name                                      | brand_id      |
#      | random product buyer product detail api24 | create by api |
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
#      | Pod Direct Central  | 58 | active | in_stock     | 1000      | 1000 |
#    And Admin create SKU from admin with name "random sku buyer product detail api241" of product ""
#    And Clear Info of Region api
#    And Info of Region
#      | region             | id | state  | availability | casePrice | msrp |
#      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
#    And Admin create SKU from admin with name "random sku buyer product detail api242" of product ""

  @B_PRODUCT_DETAILS_24 @B_PRODUCT_DETAILS_29
  Scenario Outline: Check the display condition of Express tag and Truck icon of a SKU (Store manager+Store sub-buyer) + Check display of Product tags and SKU tags shown for each SKU
#    Truck icon just show on Express buyer with direct item
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "Auto product buyer product detail api24"
    And "BUYER" choose filter by "Order by Newest"
    And Go to detail of product "Auto product buyer product detail api24" from catalog
    And Buyer choose SKU "Auto sku buyer product detail api241" in product detail
    And Buyer check tag "Express" of sku "Auto sku buyer product detail api241" is "<expressTag>"
    And Check tags of product on detail
      | tag              | status |
      | Public SKU tag_1 | show   |
      | Auto Bao Tags    | show   |
    And Buyer choose SKU "Auto sku buyer product detail api242" in product detail
    And Buyer check tag "Direct" of sku "Auto sku buyer product detail api242" is "<truckIcon>"
    And Check tags of product on detail
      | tag              | status   |
      | Public SKU tag_1 | not show |
      | Auto Bao Tags    | show     |
    And Buyer choose SKU "Auto sku buyer product detail api243" in product detail
    And Buyer check tag "Direct" of sku "Auto sku buyer product detail api243" is "<truckIcon2>"
    And Buyer check tag "Express" of sku "Auto sku buyer product detail api243" is "<expressTag2>"
    And Buyer choose SKU "Auto sku buyer product detail api244" in product detail
    And Buyer check tag "Express" of sku "Auto sku buyer product detail api244" is "<expressTag2>"
    And Buyer check tag "Direct" of sku "Auto sku buyer product detail api244" is "<truckIcon2>"
    And Buyer choose SKU "Auto sku buyer product detail api245" in product detail
    And Buyer check tag "Express" of sku "Auto sku buyer product detail api245" is "<expressTag3>"
    And Buyer check tag "Direct" of sku "Auto sku buyer product detail api245" is "<truckIcon3>"

    Examples:
      | role_              | buyer                          | pass      | role       | expressTag | truckIcon | expressTag2 | truckIcon2 | expressTag3 | truckIcon3 |
      | Store manager PE   | ngoctx+autobuyer70@podfoods.co | 12345678a | buyer      | show       | show      | not show    | not show   | not show    | show       |
      | Store sub buyer PE | ngoctx+autobuyer61@podfoods.co | 12345678a | buyer      | show       | show      | not show    | not show   | not show    | show       |
      | Store manager PD   | ngoctx+autobuyer63@podfoods.co | 12345678a | buyer      | not show   | not show  | not show    | not show   | not show    | not show   |
      | Store sub buyer PD | ngoctx+autobuyer64@podfoods.co | 12345678a | buyer      | not show   | not show  | not show    | not show   | not show    | not show   |
      | Head buyer         | ngoctx+autobuyer71@podfoods.co | 12345678a | head buyer | show       | not show  | not show    | not show   | not show    | not show   |

  @B_PRODUCT_DETAILS_33
  Scenario Outline: Check showing the Promotion bagde for applied SKU(s) - With No stack deal
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "Auto product buyer product detail api33"
    And "BUYER" choose filter by "Order by Newest"
    And Go to detail of product "Auto product buyer product detail api33" from catalog
    And Buyer verify Promotional Discount of sku "Auto sku buyer product detail api331" in product detail
      | unitPrice | currentPrice | oldPrice | tag    | typePromo        | discount    | newPrice         | caseMinimum                                  | caseLimit                                   | discountThumbnails |
      | $48.00    | $48.00       | $50.00   | Buy in | Buy-in Promotion | -$2.00/case | Only $48.00/case | Applicable with a minimum purchase of 5 case | Limited to first 3 cases of the first order | -$2                |
    And Buyer verify Promotional Discount of sku "Auto sku buyer product detail api332" in product detail
      | unitPrice | currentPrice | oldPrice | tag | typePromo     | discount    | newPrice         | caseMinimum                                  | caseLimit                     | discountThumbnails |
      | $47.00    | $47.00       | $50.00   | TPR | TPR Promotion | -$3.00/case | Only $47.00/case | Applicable with a minimum purchase of 5 case | Limited to first 3 cases only | -$3                |
    And Buyer verify Promotional Discount of sku "Auto sku buyer product detail api333" in product detail
      | unitPrice | currentPrice | oldPrice | tag         | typePromo             | discount    | newPrice         | expireDate | caseMinimum                                  | caseLimit                     | discountThumbnails |
      | $46.00    | $46.00       | $50.00   | Short dated | Short-dated Promotion | -$4.00/case | Only $46.00/case | -          | Applicable with a minimum purchase of 3 case | Limited to first 5 cases only | -$4                |
#    sku apply nhiều promotion thì hien thị promo mới nhất
    And Buyer verify Promotional Discount of sku "Auto sku buyer product detail api334" in product detail
      | unitPrice | currentPrice | oldPrice | tag         | typePromo             | discount    | newPrice         | expireDate | caseMinimum                                  | caseLimit                     | discountThumbnails |
      | $46.00    | $46.00       | $50.00   | Short dated | Short-dated Promotion | -$4.00/case | Only $46.00/case | -          | Applicable with a minimum purchase of 3 case | Limited to first 5 cases only | -$4                |

    Examples:
      | role_              | buyer                          |
      | Store manager PE   | ngoctx+autobuyer70@podfoods.co |
      | Store sub buyer PE | ngoctx+autobuyer61@podfoods.co |
      | Store manager PD   | ngoctx+autobuyer63@podfoods.co |
      | Store sub buyer PD | ngoctx+autobuyer64@podfoods.co |

  @B_PRODUCT_DETAILS_34
  Scenario Outline: Check showing the Promotion bagde for applied SKU(s) - With stack deal
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "Auto product buyer product detail api34"
    And "BUYER" choose filter by "Order by Newest"
    And Go to detail of product "Auto product buyer product detail api34" from catalog
    And Buyer verify Promotional Discount of sku "Auto sku buyer product detail api341" in product detail
      | unitPrice       | currentPrice    | oldPrice | tag    | typePromo        | caseMinimum                                   | caseLimit                                   | discountThumbnails |
      | $48.00 ~ $49.00 | $48.00 ~ $49.00 | $50.00   | Buy in | Buy-in Promotion | Applicable with a minimum purchase of 2 cases | Limited to first 2 cases of the first order | -$1 ~ -$2          |
    And Verify Stack case promotion on product detail
      | stackCase             |
      | 2 - 4 cases: $1.00 OI |
      | 5+ cases: $2.00 OI    |
    And Buyer verify Promotional Discount of sku "Auto sku buyer product detail api342" in product detail
      | unitPrice       | currentPrice    | oldPrice | tag | typePromo     | caseMinimum                                   | caseLimit                     | discountThumbnails |
      | $47.00 ~ $48.00 | $47.00 ~ $48.00 | $50.00   | TPR | TPR Promotion | Applicable with a minimum purchase of 3 cases | Limited to first 2 cases only | -$2 ~ -$3          |
    And Verify Stack case promotion on product detail
      | stackCase             |
      | 3 - 4 cases: $2.00 OI |
      | 5+ cases: $3.00 OI    |
    And Buyer verify Promotional Discount of sku "Auto sku buyer product detail api343" in product detail
      | unitPrice       | currentPrice    | oldPrice | tag         | typePromo             | expireDate | caseMinimum                                   | caseLimit                     | discountThumbnails |
      | $46.00 ~ $47.00 | $46.00 ~ $47.00 | $50.00   | Short dated | Short-dated Promotion | -          | Applicable with a minimum purchase of 4 cases | Limited to first 2 cases only | -$3 ~ -$4          |
    And Verify Stack case promotion on product detail
      | stackCase             |
      | 4 - 4 cases: $3.00 OI |
      | 5+ cases: $4.00 OI    |
  #    sku apply nhiều promotion thì hien thị promo mới nhất
    And Buyer verify Promotional Discount of sku "Auto sku buyer product detail api344" in product detail
      | unitPrice       | currentPrice    | oldPrice | tag         | typePromo             | expireDate | caseMinimum                                   | caseLimit                     | discountThumbnails |
      | $46.00 ~ $47.00 | $46.00 ~ $47.00 | $50.00   | Short dated | Short-dated Promotion | -          | Applicable with a minimum purchase of 4 cases | Limited to first 2 cases only | -$3 ~ -$4          |
    And Verify Stack case promotion on product detail
      | stackCase             |
      | 4 - 4 cases: $3.00 OI |
      | 5+ cases: $4.00 OI    |

    Examples:
      | role_              | buyer                          |
      | Store manager PE   | ngoctx+autobuyer70@podfoods.co |
      | Store sub buyer PE | ngoctx+autobuyer61@podfoods.co |
      | Store manager PD   | ngoctx+autobuyer63@podfoods.co |
      | Store sub buyer PD | ngoctx+autobuyer64@podfoods.co |

  @B_PRODUCT_DETAILS_42
  Scenario Outline: Check display of Price info (price/unit and price/case) shown for each SKU without applying promotion - PE
    Given BAO_ADMIN login web admin by api
      | email   | password  |
      | <admin> | 12345678a |
    And Admin change info of store specific of sku "76584"
      | id     | region_id | store_id | store_name          | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date   |
      | 150115 | 26        | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 76584              | 2000             | 2000       | in_stock     | active | Minus1     | 2026-02-28 |
    And Admin change info of buyer company specific of sku "76584"
      | id     | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date   |
      | 150116 | 26        | active              | 2216             | Auto_BuyerCompany  | 76584              | 1200             | 1200       | in_stock     | active | Minus1     | 2026-02-28 |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "Auto product buyer product detail api42"
    And "BUYER" choose filter by "Order by Newest"
    And Go to detail of product "Auto product buyer product detail api42" from catalog
    And Buyer choose SKU "Auto sku buyer product detail api421" in product detail
    And Buyer check detail of product
      | productName                             | productBrand                  | address | pricePerCase    | availability |
      | Auto product buyer product detail api42 | Auto Brand check availability | ,       | <company_price> | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp            | minimumOrder | unitDimension | caseDimension | unitSize | casePack         |
      | 123123123123 | 50%         | <company_price> | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case |
    #    Update store specific to inactive
    And Admin change info of store specific of sku "76584"
      | id     | region_id | store_id | store_name          | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | 150115 | 26        | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 76584              | 2000             | 2000       | in_stock     | active | Minus2     | Minus1   |

    And BUYER refresh browser
    And Buyer check detail of product
      | productName                             | productBrand                  | address | pricePerCase  | availability |
      | Auto product buyer product detail api42 | Auto Brand check availability | ,       | <store_price> | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp          | minimumOrder | unitDimension | caseDimension | unitSize | casePack         |
      | 123123123123 | 50%         | <store_price> | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case |
     #    Update buyer company  to inactive
    And Admin change info of buyer company specific of sku "76584"
      | id     | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | 150116 | 26        | active              | 2216             | Auto_BuyerCompany  | 76584              | 1200             | 1200       | in_stock     | active | Minus2     | Minus1   |
    And BUYER refresh browser
    And Buyer check detail of product
      | productName                             | productBrand                  | address | pricePerCase   | availability |
      | Auto product buyer product detail api42 | Auto Brand check availability | ,       | <region_price> | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp           | minimumOrder | unitDimension | caseDimension | unitSize | casePack         |
      | 123123123123 | 50%         | <region_price> | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case |
    And Check nutrition labels
      | image               |
      | nutritionLabel2.png |
      | anhJPEG.jpg         |
    And Admin change info of store specific of sku "76584"
      | id     | region_id | store_id | store_name          | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date   |
      | 150115 | 26        | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 76584              | 2000             | 2000       | in_stock     | active | Minus1     | 2026-02-28 |
    And Admin change info of buyer company specific of sku "76584"
      | id     | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date   |
      | 150116 | 26        | active              | 2216             | Auto_BuyerCompany  | 76584              | 1200             | 1200       | in_stock     | active | Minus1     | 2026-02-28 |

    Examples:
      | role_              | admin             | buyer                          | pass      | role  | region_price | store_price | company_price |
      | Store manager PE   | bao34@podfoods.co | ngoctx+autobuyer70@podfoods.co | 12345678a | buyer | $15.00       | $12.00      | $20.00        |
      | Store sub buyer PE | bao35@podfoods.co | ngoctx+autobuyer61@podfoods.co | 12345678a | buyer | $15.00       | $12.00      | $20.00        |
#      | Store manager PE NY | ngoctx+autobuyerbaony5@podfoods.co | 12345678a | buyer | $100.00      | $100.00     | $100.00       |

  @B_PRODUCT_DETAILS_422
  Scenario Outline: Check display of Price info (price/unit and price/case) shown for each SKU without applying promotion - PD
    Given BAO_ADMIN login web admin by api
      | email   | password  |
      | <admin> | 12345678a |
    And Admin change info of store specific of sku "76584"
      | id     | region_id | store_id | store_name     | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date   |
      | 150117 | 58        | 1762     | Auto Store PDM | 1664             | Tra Midwest 05     | 76584              | 2000             | 2000       | in_stock     | active | Minus1     | 2026-02-28 |
    And Admin change info of buyer company specific of sku "76584"
      | id     | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date   |
      | 150118 | 58        | active              | 1664             | Tra Midwest 05     | 76584              | 1200             | 1200       | in_stock     | active | Minus1     | 2026-02-28 |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "Auto product buyer product detail api42"
    And "BUYER" choose filter by "Order by Newest"
    And Go to detail of product "Auto product buyer product detail api42" from catalog
    And Buyer choose SKU "Auto sku buyer product detail api421" in product detail
    And Buyer check detail of product
      | productName                             | productBrand                  | address | pricePerCase    | availability |
      | Auto product buyer product detail api42 | Auto Brand check availability | ,       | <company_price> | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp            | minimumOrder | unitDimension | caseDimension | unitSize | casePack         |
      | 123123123123 | 50%         | <company_price> | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case |
    #    Update store specific to inactive
    And Admin change info of store specific of sku "76584"
      | id     | region_id | store_id | store_name     | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | 150117 | 58        | 1762     | Auto Store PDM | 1664             | Tra Midwest 05     | 76584              | 2000             | 2000       | in_stock     | active | Minus2     | Minus1   |

    And BUYER refresh browser
    And Buyer check detail of product
      | productName                             | productBrand                  | address | pricePerCase  | availability |
      | Auto product buyer product detail api42 | Auto Brand check availability | ,       | <store_price> | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp          | minimumOrder | unitDimension | caseDimension | unitSize | casePack         |
      | 123123123123 | 50%         | <store_price> | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case |
     #    Update buyer company  to inactive
    And Admin change info of buyer company specific of sku "76584"
      | id     | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | 150118 | 58        | active              | 1664             | Tra Midwest 05     | 76584              | 1200             | 1200       | in_stock     | active | Minus2     | Minus1   |
    And BUYER refresh browser
    And Buyer check detail of product
      | productName                             | productBrand                  | address | pricePerCase   | availability |
      | Auto product buyer product detail api42 | Auto Brand check availability | ,       | <region_price> | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp           | minimumOrder | unitDimension | caseDimension | unitSize | casePack         |
      | 123123123123 | 50%         | <region_price> | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case |
    And Check nutrition labels
      | image               |
      | nutritionLabel2.png |
      | anhJPEG.jpg         |
    And Admin change info of store specific of sku "76584"
      | id     | region_id | store_id | store_name     | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date   |
      | 150117 | 58        | 1762     | Auto Store PDM | 1664             | Tra Midwest 05     | 76584              | 2000             | 2000       | in_stock     | active | Minus1     | 2026-02-28 |
    And Admin change info of buyer company specific of sku "76584"
      | id     | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date   |
      | 150118 | 58        | active              | 1664             | Tra Midwest 05     | 76584              | 1200             | 1200       | in_stock     | active | Minus1     | 2026-02-28 |

    Examples:
      | role_              | admin             | buyer                          | pass      | role  | region_price | store_price | company_price |
      | Store manager PD   | bao34@podfoods.co | ngoctx+autobuyer63@podfoods.co | 12345678a | buyer | $5.00        | $12.00      | $20.00        |
      | Store sub buyer PD | bao35@podfoods.co | ngoctx+autobuyer64@podfoods.co | 12345678a | buyer | $5.00        | $12.00      | $20.00        |

  @B_PRODUCT_DETAILS_423
  Scenario Outline: Check display of Price info (price/unit and price/case, availability) shown for each SKU without applying promotion - Head Buyer
    Given BAO_ADMIN login web admin by api
      | email   | password  |
      | <admin> | 12345678a |
    And Admin change info of store specific of sku "76584"
      | id     | region_id | store_id | store_name          | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date   |
      | 150115 | 26        | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 76584              | 2000             | 2000       | in_stock     | active | Minus1     | 2026-02-28 |
      | 150117 | 58        | 1762     | Auto Store PDM      | 1664             | Tra Midwest 05     | 76584              | 2000             | 2000       | in_stock     | active | Minus1     | 2026-02-28 |
    And Admin change info of buyer company specific of sku "76584"
      | id     | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date   |
      | 150116 | 26        | active              | 2216             | Auto_BuyerCompany  | 76584              | 1200             | 1200       | in_stock     | active | Minus1     | 2026-02-28 |
      | 150118 | 58        | active              | 1664             | Tra Midwest 05     | 76584              | 1200             | 1200       | in_stock     | active | Minus1     | 2026-02-28 |
      | 150120 | 55        | active              | 2216             | Auto_BuyerCompany  | 76584              | 10000             | 10000       | in_stock     | active | Minus1     | 2026-02-28 |
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "Auto product buyer product detail api42"
    And "BUYER" choose filter by "Order by Newest"
    And Go to detail of product "Auto product buyer product detail api42" from catalog
    And Buyer choose SKU "Auto sku buyer product detail api421" in product detail
    And Head buyer check price of sku on product detail
      | productName                             | productBrand                  | address | pricePerCase    | pricePerUnit   | availability                                                  |
      | Auto product buyer product detail api42 | Auto Brand check availability | ,       | $5.00 ~ $100.00 | $2.50 ~ $50.00 | PDC - In Stock, CHI - In Stock, NY - In Stock, PDE - In Stock |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp    | unitDimension | caseDimension | unitSize | casePack         |
      | 123123123123 | 50%         | $100.00 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case |
    And Check nutrition labels
      | image               |
      | nutritionLabel2.png |
      | anhJPEG.jpg         |

    And Admin change info of buyer company specific of sku "76584"
      | id     | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date   | out_of_stock_reason | auto_out_of_stock_reason |
      | 150120 | 55        | active              | 2216             | Auto_BuyerCompany  | 76584              | 10000             | 10000       | sold_out     | active | Minus1     | 2026-02-28 |vendor_short_term   | pending_vendor_response  |
    And BUYER refresh browser
    And Head buyer check price of sku on product detail
      | productName                             | productBrand                  | address | pricePerCase    | pricePerUnit   | availability                                                  |
      | Auto product buyer product detail api42 | Auto Brand check availability | ,       | $5.00 ~ $100.00 | $2.50 ~ $50.00 | PDC - In Stock, CHI - In Stock, NY - In Stock, PDE - Out of stock |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp    | unitDimension | caseDimension | unitSize | casePack         |
      | 123123123123 | 50%         | $100.00 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case |
    And Admin change info of store specific of sku "76584"
      | id     | region_id | store_id | store_name          | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date   |
      | 150115 | 26        | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 76584              | 2000             | 2000       | in_stock     | active | Minus1     | 2026-02-28 |
      | 150117 | 58        | 1762     | Auto Store PDM      | 1664             | Tra Midwest 05     | 76584              | 2000             | 2000       | in_stock     | active | Minus1     | 2026-02-28 |
    And Admin change info of buyer company specific of sku "76584"
      | id     | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date   |
      | 150116 | 26        | active              | 2216             | Auto_BuyerCompany  | 76584              | 1200             | 1200       | in_stock     | active | Minus1     | 2026-02-28 |
      | 150118 | 58        | active              | 1664             | Tra Midwest 05     | 76584              | 1200             | 1200       | in_stock     | active | Minus1     | 2026-02-28 |
      | 150120 | 55        | active              | 2216             | Auto_BuyerCompany  | 76584              | 10000             | 10000       | in_stock     | active | Minus1     | 2026-02-28 |

    Examples:
      | role_      | admin             | buyer                          | pass      | role       |
      | Head buyer | bao35@podfoods.co | ngoctx+autobuyer71@podfoods.co | 12345678a | head buyer |

  @B_PRODUCT_DETAILS_47
  Scenario Outline: Check display of the Quantity (cases) field, Add to cart button
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "Auto product buyer product detail api47"
    And "BUYER" choose filter by "Order by Newest"
    And Go to detail of product "Auto product buyer product detail api47" from catalog
    And Buyer choose SKU "Auto sku buyer product detail api471" in product detail
    And Buyer check quantity of sku on product detail
      | sku                                  | quantity |
      | Auto sku buyer product detail api471 | 1        |
    And Buyer change the quantity with button
      | sku                                  | action   | value |
      | Auto sku buyer product detail api471 | increase | 2     |
      | Auto sku buyer product detail api471 | increase | 3     |
      | Auto sku buyer product detail api471 | decrease | 2     |
      | Auto sku buyer product detail api471 | decrease | 1     |
#    And Buyer check detail of product
#      | productName                             | productBrand                  | address | pricePerCase    | availability |
#      | Auto product buyer product detail api42 | Auto Brand check availability | ,       | <company_price> | In Stock     |
#    And Check more information of SKU
#      | unitUpcEan   | grossMargin | msrp            | minimumOrder | unitDimension | caseDimension | unitSize | casePack         |
#      | 123123123123 | 50%         | <company_price> | 1            | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 2 units per case |

    Examples:
      | role_              | buyer                          | pass      | role  |
      | Store manager PE   | ngoctx+autobuyer70@podfoods.co | 12345678a | buyer |
      | Store sub buyer PE | ngoctx+autobuyer61@podfoods.co | 12345678a | buyer |
      | Store manager PD   | ngoctx+autobuyer63@podfoods.co | 12345678a | buyer |
      | Store sub buyer PD | ngoctx+autobuyer64@podfoods.co | 12345678a | buyer |


  @B_PRODUCT_DETAILS_114
  Scenario Outline: Verify the Request Sample function of normal buyers
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "Auto product buyer product detail api49"
    And "BUYER" choose filter by "Order by Newest"
    And Go to detail of product "Auto product buyer product detail api49" from catalog
    And Buyer open submit sample request
    And Buyer check form submit sample request
      | product                                 | comment | defaultShippingAddress | store               | address                                  | phone |
      | Auto product buyer product detail api49 | [blank] | yes                    | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | 1234567890 |
#    And Buyer create sample request with info
#      | comment |
#      | comment |
#    And Select Skus to sample
#      | sku                               |
#      | sku random buyer sku sample 7 api |
#    And Buyer "use" Use default name and store address
#      | store               | addressStamp                                  | storePhone |
#      | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | 1234567890 |
#    And Buyer submit sample request

    Examples:
      | role_            | admin             | buyer                          | pass      | role  | region_price | store_price | company_price |
      | Store manager PE | bao34@podfoods.co | ngoctx+autobuyer70@podfoods.co | 12345678a | buyer | $15.00       | $12.00      | $20.00        |
#      | Store sub buyer PE | bao35@podfoods.co | ngoctx+autobuyer61@podfoods.co | 12345678a | buyer | $15.00       | $12.00      | $20.00        |
#      | Store manager PD   | bao34@podfoods.co | ngoctx+autobuyer63@podfoods.co | 12345678a | buyer | $5.00        | $12.00      | $20.00        |
#      | Store sub buyer PD | bao35@podfoods.co | ngoctx+autobuyer64@podfoods.co | 12345678a | buyer | $5.00        | $12.00      | $20.00        |

#mvn verify -Dtestsuite="VendorProductTestSuite" -Dcucumber.options="src/test/resources/features/vendor"  -Dfailsafe.rerunFaillingTestsCount=1
@feature=VendorProduct
Feature: Vendor Product

  @VENDOR_PRODUCTS_11_Create_new_Product
  Scenario: Vendor company set MOV
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]            | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | Auto vendor create product | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "Auto vendor create product" from API
    And Admin delete all inventory by API
    And Admin search product name "Auto vendor create product moq" by api
    And Admin delete product name "Auto vendor create product moq" by api

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor check message on Dashboard product
    And Vendor go to Create new Product
    And VENDOR Create an new Product Success
      | productName                    | brandName              | productType | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | Auto vendor create product moq | Auto Brand product moq | Bread       | yes         | Dairy    | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  | 10             | 10            | 10                  | 1                      | 1                    | 1                          | 1                         | 1                          | 1                |
    And Vendor upload Master case photo
      | casePack    | masterCarton |
      | anhJPEG.jpg | anhJPG2.jpg  |
    And Vendor confirm Next new Product
    And Vendor verify tab "create your first sku" is active
    And Check any text "is" showing on screen
      | Square-shape (800px × 800px recommended) |
      | Minimum 520px in width                   |
    And Vendor input info new SKU
      | skuName                 | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku1 | 12        | 123123123123      | masterImage.jpg | 123123123123 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor upload "UPC" image for new SKU
      | image           | masterCarton |
      | masterImage.jpg | 123          |
    And Vendor choose qualities of SKU
      | Dairy-Free |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |

    And Vendor confirm Next new Product
#    #    And Vendor go to "Region-Specific" tab on SKU detail

    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And VENDOR check dialog message
      | Are you sure all the information is accurate? Once confirmed, your product will be live and your key product information including price, UPC / EAN, case pack, and size will be locked in so that stores can benefit from consistent information. You can still request changes. Changes may take up to 90 days to process. |
    And Vendor Continue confirm publish SKU
#    And Wait for create product successfully
    And Vendor check SKU general detail
      | skuName                 | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature |
      | Auto vendor create sku1 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123123123123 | 123123123123 | United States | New York | New York | 30      | 10     | -20            | -12            |
    And Vendor check specific price of SKU
      | regionName          | casePrice | availability |
      | Chicagoland Express | $12.00    | In Stock     |
#
    And VENDOR Navigate to "Products" by sidebar
    And Vendor check product "Show" on list
      | product                        | brand                  | department |
      | Auto vendor create product moq | Auto Brand product moq | Dairy      |
#    And Vendor export summary product
#    And Check file CSV exported "download"
#      | Brand name             | Product name                   | Product type | Product categories | Product package size | Product unit size | Individual unit dimensions | Case dimensions | Product MOQ | SKU name                | Unit UPC/EAN | Case UPC/EAN | North California Express case price | North California Express unit price | North California Express margin | North California Express MSRP | Chicagoland Express case price | Chicagoland Express unit price | Chicagoland Express margin | Chicagoland Express MSRP | South California Express case price | South California Express unit price | South California Express margin | South California Express MSRP | New York Express case price | New York Express unit price | New York Express margin | New York Express MSRP | Pod Direct West case price | Pod Direct West unit price | Pod Direct West margin | Pod Direct West MSRP | Pod Direct Northeast case price | Pod Direct Northeast unit price | Pod Direct Northeast margin | Pod Direct Northeast MSRP | Pod Direct Midwest case price | Pod Direct Midwest unit price | Pod Direct Midwest margin | Pod Direct Midwest MSRP | Pod Direct Southeast case price | Pod Direct Southeast unit price | Pod Direct Southeast margin | Pod Direct Southeast MSRP | Pod Direct Southwest & Rockies case price | Pod Direct Southwest & Rockies unit price | Pod Direct Southwest & Rockies margin | Pod Direct Southwest & Rockies MSRP | Texas Express case price | Texas Express unit price | Texas Express margin | Texas Express MSRP | Mid Atlantic Express case price | Mid Atlantic Express unit price | Mid Atlantic Express margin | Mid Atlantic Express MSRP | Florida Express case price | Florida Express unit price | Florida Express margin | Florida Express MSRP | Units/case | Lead time | Location           | Storage shelf life    | Retail shelf life     | Temperature requirement | Qualities  |
#      | Auto Brand product moq | Auto vendor create product moq | Bread        | Dairy              | Bulk                 | 8.0 oz.           | 12" x 12" x 12"            | 12" x 12" x 12" | 1           | Auto vendor create sku1 | [blank]      | [blank]      | [blank]                             | [blank]                             | [blank]                         | [blank]                       | $12.00                         | $1.00                          | 93%                        | $15.00                   | [blank]                             | [blank]                             | [blank]                         | [blank]                       | [blank]                     | [blank]                     | [blank]                 | [blank]               | [blank]                    | [blank]                    | [blank]                | [blank]              | [blank]                         | [blank]                         | [blank]                     | [blank]                   | [blank]                       | [blank]                       | [blank]                   | [blank]                 | [blank]                         | [blank]                         | [blank]                     | [blank]                   | [blank]                                   | [blank]                                   | [blank]                               | [blank]                             | [blank]                  | [blank]                  | [blank]              | [blank]            | [blank]                         | [blank]                         | [blank]                     | [blank]                   | [blank]                    | [blank]                    | [blank]                | [blank]              | 12         | 5         | New York, New York | 30 days (Deep Frozen) | 10 days (Deep Frozen) | 10.0F - 40.0F           | Dairy-Free |
#
#    And Vendor check file export summary product
#      | Brand name             | Product name                               | Product type | Product categories | Product package size | Product unit size | Individual           | unit dimensions      | Case dimensions | Product MOQ                     | SKU name | Unit UPC/EAN | Case UPC/EAN | North California Express case price | North California Express unit price | North California Express margin | North California Express MSRP | Chicagoland Express case price | Chicagoland Express unit price | Chicagoland Express margin | Chicagoland Express MSRP | South California Express case price | South California Express unit price | South California Express margin | South California Express MSRP | New York Express case price | New York Express unit price | New York Express margin | New York Express MSRP | Pod Direct West case price | Pod Direct West unit price | Pod Direct West margin | Pod Direct West MSRP | Pod Direct Northeast case price | Pod Direct Northeast unit price | Pod Direct Northeast margin | Pod Direct Northeast MSRP | Pod Direct Midwest case price | Pod Direct Midwest unit price | Pod Direct Midwest margin | Pod Direct Midwest MSRP | Pod Direct Southeast case price | Pod Direct Southeast unit price | Pod Direct Southeast margin | Pod Direct Southeast MSRP | Pod Direct Southwest & Rockies case price | Pod Direct Southwest & Rockies unit price | Pod Direct Southwest & Rockies margin | Pod Direct Southwest & Rockies MSRP | Texas Express case price | Texas Express unit price | Texas Express margin | Texas Express MSRP | Mid Atlantic Express case price | Mid Atlantic Express unit price | Mid Atlantic Express margin | Mid Atlantic Express MSRP | Florida Express case price | Florida Express unit price | Florida Express margin | Florida Express MSRP | Units/case | Lead time | Location  | Storage shelf life    | Retail shelf life     | Temperature requirement | Qualities  |
#      | Auto Brand product moq | Copy of Auto vendor create product moq (1) | Bread        | Dairy              | Bulk                 | 8.0 oz.           | "12"" x 12"" x 12""" | "12"" x 12"" x 12""" | 1               | Copy of Auto vendor create sku1 | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | $12.00                        | $1.00                          | 93%                            | $15.00                     | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | 12                   | 5          | "New York | New York" | 30 days (Deep Frozen) | 10 days (Deep Frozen) | 10.0F - 40.0F           | Dairy-Free |
##      | Auto Brand product moq | Auto vendor create product moq             | Bread        | Dairy              | Bulk                 | 8.0 oz.           | "12"" x 12"" x 12""" | "12"" x 12"" x 12""" | 1               | Auto vendor create sku1         | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | $12.00                        | $1.00                          | 93%                            | $15.00                     | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | 12                   | 5          | "New York | New York" | 30 days (Deep Frozen) | 10 days (Deep Frozen) | 10.0F - 40.0F           | Dairy-Free |
#    And Vendor delete file export summary product
    And Vendor go to product detail by name "Auto vendor create product moq"
    And Vendor check product Organization detail on dashboard
      | brand                  | category | type  | allowSampleRequest |
      | Auto Brand product moq | Dairy    | Bread | checked            |
    And Vendor check product Packaging detail on dashboard
      | product                        | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Auto vendor create product moq | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8.0      | oz.  |
    And Vendor check Packaging and size disabled
    And Vendor check Case pack photo
      | photo       |
      | anhJPEG.jpg |
    And Vendor check Master carton photo
      | photo       |
      | anhJPG2.jpg |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 10            | 10           | 10              |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 1                      | 1                    | 1                  | 1                 | 1                  | 1                  |
    And Vendor check product MOQs detail on dashboard
      | region             | value |
      | Pod Direct West    | 1     |
#      | Pod Direct Central | 1     |
      | Pod Direct East    | 1     |
#      | Pod Direct Northeast           | 1     |
      | Pod Direct Central | 1     |
    And Vendor check SKUs on product detail with "1" active and "0" draft
      | image           |
      | masterImage.jpg |
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Published SKUs
      | skuName                 | caseUnit      | unitUPC      | caseUPC      |
      | Auto vendor create sku1 | 12 units/case | 123123123123 | 123123123123 |
    And Vendor go to detail of SKU "Auto vendor create sku1"
    And Vendor check SKU general detail
      | skuName                 | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature |
      | Auto vendor create sku1 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123123123123 | 123123123123 | United States | New York | New York | 30      | 10     | -20            | -12            |
    And Vendor check specific price of SKU
      | regionName          | casePrice | availability |
      | Chicagoland Express | $12.00    | In Stock     |

  @VENDOR_PRODUCTS_11_Create_new_Product_validate
  Scenario: Create_new_Product_validate
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product 2 moq" by api
    And Admin delete product name "Auto vendor create product 2 moq" by api

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to Create new Product
    And VENDOR Create an new Product Success
      | productName | brandName | productType | allowSample | isBeverage | containerType | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit    | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | [blank]     | [blank]   | [blank]     | [blank]     | Yes        | [blank]       | [blank]  | [blank]    | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | [blank]     | [blank]  | [blank] | [blank]        | [blank]       | [blank]             | [blank]                | [blank]              | [blank]                    | [blank]                   | [blank]                    | [blank]          |

    And Vendor confirm Next new Product
    And Vendor check alert message
      | Please correct the errors on this form before continuing. |
#      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field          | message                    |
      | Title          | This field cannot be blank |
      | Brand          | This field cannot be blank |
      | Category       | This field cannot be blank |
#      | Product type   | This field cannot be blank |
      | Container Type | This field cannot be blank |
      | Unit length    | This field cannot be blank |
      | Unit width     | This field cannot be blank |
      | Unit height    | This field cannot be blank |
      | Case width     | This field cannot be blank |
      | Case height    | This field cannot be blank |
      | Case Weight    | This field cannot be blank |
      | Package size   | This field cannot be blank |
      | Unit Size      | This field cannot be blank |
      | Unit           | This field cannot be blank |

    And Vendor input invalid "Brand"
      | value                          |
      | Auto Brand product moq invalid |
    And Vendor input invalid "Category"
      | value                          |
      | Auto Brand product moq invalid |
#    And Vendor input invalid "Product type"
#      | value                          |
#      | Auto Brand product moq invalid |

    And Vendor Clear field "Cases per pallet" when create product
    And Vendor Clear field "Cases per layer" when create product
    And Vendor Clear field "Layers per full pallet" when create product
    And Vendor Clear field "Master Cartons per Pallet" when create product
    And Vendor Clear field "Cases per Master Carton" when create product
    And Vendor Clear field "Master carton length" when create product
    And Vendor Clear field "Master carton width" when create product
    And Vendor Clear field "Master carton height" when create product
    And Vendor Clear field "Master carton Weight" when create product

    And Vendor check message is showing of fields when create product
      | field                     | message                    |
      | Cases per pallet          | This field cannot be blank |
      | Cases per layer           | This field cannot be blank |
      | Layers per full pallet    | This field cannot be blank |
      | Master Cartons per Pallet | This field cannot be blank |
      | Cases per Master Carton   | This field cannot be blank |
      | Master carton length      | This field cannot be blank |
      | Master carton width       | This field cannot be blank |
      | Master carton height      | This field cannot be blank |
      | Master carton Weight      | This field cannot be blank |
    And Vendor edit MOQs
      | region             | value   |
      | Pod Direct West    | [blank] |
#      | Pod Direct Southwest & Rockies | [blank] |
#      | Pod Direct Southeast           | [blank] |
      | Pod Direct East    | [blank] |
      | Pod Direct Central | [blank] |
    And Vendor confirm Next new Product
    And Vendor check message is showing of fields MOQs
      | field              | message                    |
      | Pod Direct West    | This field cannot be blank |
#      | Pod Direct Southwest & Rockies | This field cannot be blank |
#      | Pod Direct Southeast           | This field cannot be blank |
      | Pod Direct East    | This field cannot be blank |
      | Pod Direct Central | This field cannot be blank |

  @VENDOR_PRODUCTS_11_Create_new_Product_validate2
  Scenario: Create_new_Product_validate2
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to Create new Product

    And Vendor decrease field number tooltip 1 times
      | field       | text |
      | Unit length | 0    |
    And Vendor increase field number tooltip 2 times
      | field       | text |
      | Unit length | 0.2  |
    And Vendor decrease field number tooltip 2 times
      | field       | text |
      | Unit length | 0    |
    And Vendor decrease field number tooltip 1 times
      | field      | text |
      | Unit width | 0    |
    And Vendor increase field number tooltip 2 times
      | field      | text |
      | Unit width | 0.2  |
    And Vendor decrease field number tooltip 2 times
      | field      | text |
      | Unit width | 0    |
    And Vendor decrease field number tooltip 1 times
      | field       | text |
      | Unit height | 0    |
    And Vendor increase field number tooltip 2 times
      | field       | text |
      | Unit height | 0.2  |
    And Vendor decrease field number tooltip 2 times
      | field       | text |
      | Unit height | 0    |
    And Vendor decrease field number tooltip 1 times
      | field       | text |
      | Case length | 0    |
    And Vendor increase field number tooltip 2 times
      | field       | text |
      | Case length | 0.2  |
    And Vendor decrease field number tooltip 2 times
      | field       | text |
      | Case length | 0    |
    And Vendor decrease field number tooltip 1 times
      | field       | text |
      | Case Weight | 0    |
    And Vendor increase field number tooltip 2 times
      | field       | text |
      | Case Weight | 0.2  |
    And Vendor decrease field number tooltip 2 times
      | field       | text |
      | Case Weight | 0    |
    And Vendor decrease field number tooltip 1 times
      | field     | text |
      | Unit Size | 0    |
    And Vendor increase field number tooltip 2 times
      | field     | text |
      | Unit Size | 0.2  |
    And Vendor decrease field number tooltip 2 times
      | field     | text |
      | Unit Size | 0    |
    And Vendor decrease field number tooltip 1 times
      | field            | text |
      | Cases per pallet | 0    |
    And Vendor increase field number tooltip 2 times
      | field            | text |
      | Cases per pallet | 2    |
    And Vendor decrease field number tooltip 2 times
      | field            | text |
      | Cases per pallet | 0    |
    And Vendor decrease field number tooltip 1 times
      | field           | text |
      | Cases per layer | 0    |
    And Vendor increase field number tooltip 2 times
      | field           | text |
      | Cases per layer | 2    |
    And Vendor decrease field number tooltip 2 times
      | field           | text |
      | Cases per layer | 0    |
    And Vendor decrease field number tooltip 1 times
      | field                  | text |
      | Layers per full pallet | 0    |
    And Vendor increase field number tooltip 2 times
      | field                  | text |
      | Layers per full pallet | 2    |
    And Vendor decrease field number tooltip 2 times
      | field                  | text |
      | Layers per full pallet | 0    |
    And Vendor decrease field number tooltip 1 times
      | field                     | text |
      | Master Cartons per Pallet | 0    |
    And Vendor increase field number tooltip 2 times
      | field                     | text |
      | Master Cartons per Pallet | 2    |
    And Vendor decrease field number tooltip 2 times
      | field                     | text |
      | Master Cartons per Pallet | 0    |
    And Vendor decrease field number tooltip 1 times
      | field                   | text |
      | Cases per Master Carton | 0    |
    And Vendor increase field number tooltip 2 times
      | field                   | text |
      | Cases per Master Carton | 2    |
    And Vendor decrease field number tooltip 2 times
      | field                   | text |
      | Cases per Master Carton | 0    |
    And Vendor decrease field number tooltip 1 times
      | field                | text |
      | Master carton length | 0    |
    And Vendor increase field number tooltip 2 times
      | field                | text |
      | Master carton length | 0.2  |
    And Vendor decrease field number tooltip 2 times
      | field                | text |
      | Master carton length | 0    |
    And Vendor decrease field number tooltip 1 times
      | field               | text |
      | Master carton width | 0    |
    And Vendor increase field number tooltip 2 times
      | field               | text |
      | Master carton width | 0.2  |
    And Vendor decrease field number tooltip 2 times
      | field               | text |
      | Master carton width | 0    |
    And Vendor decrease field number tooltip 1 times
      | field                | text |
      | Master carton height | 0    |
    And Vendor increase field number tooltip 2 times
      | field                | text |
      | Master carton height | 0.2  |
    And Vendor decrease field number tooltip 2 times
      | field                | text |
      | Master carton height | 0    |
    And Vendor decrease field number tooltip 1 times
      | field                | text |
      | Master carton Weight | 0    |
    And Vendor increase field number tooltip 2 times
      | field                | text |
      | Master carton Weight | 0.2  |
    And Vendor decrease field number tooltip 2 times
      | field                | text |
      | Master carton Weight | 0    |

    And Vendor decrease field number tooltip 1 times
      | field              | text |
      | Pod Direct Central | 0    |
    And Vendor increase field number tooltip 2 times
      | field              | text |
      | Pod Direct Central | 2    |
    And Vendor decrease field number tooltip 2 times
      | field              | text |
      | Pod Direct Central | 0    |
    And Vendor decrease field number tooltip 1 times
      | field           | text |
      | Pod Direct East | 0    |
    And Vendor increase field number tooltip 2 times
      | field           | text |
      | Pod Direct East | 2    |
    And Vendor decrease field number tooltip 2 times
      | field           | text |
      | Pod Direct East | 0    |
#    And Vendor decrease field number tooltip 1 times
#      | field                | text |
#      | Pod Direct Southeast | 0    |
#    And Vendor increase field number tooltip 2 times
#      | field                | text |
#      | Pod Direct Southeast | 2    |
#    And Vendor decrease field number tooltip 2 times
#      | field                | text |
#      | Pod Direct Southeast | 0    |
#    And Vendor decrease field number tooltip 1 times
#      | field                          | text |
#      | Pod Direct Southwest & Rockies | 0    |
#    And Vendor increase field number tooltip 2 times
#      | field                          | text |
#      | Pod Direct Southwest & Rockies | 2    |
#    And Vendor decrease field number tooltip 2 times
#      | field                          | text |
#      | Pod Direct Southwest & Rockies | 0    |
    And Vendor decrease field number tooltip 1 times
      | field           | text |
      | Pod Direct West | 0    |
    And Vendor increase field number tooltip 2 times
      | field           | text |
      | Pod Direct West | 2    |
    And Vendor decrease field number tooltip 2 times
      | field           | text |
      | Pod Direct West | 0    |

  @VENDOR_PRODUCTS_11_Create_new_Product_validate3
  Scenario: Create_new_Product_validate3
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to Create new Product
    And VENDOR Create an new Product Success
      | productName                    | brandName              | productType | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | Auto vendor create product moq | Auto Brand product moq | Bread       | yes         | Dairy    | -1         | -1        | -1         | -1         | -1        | -1         | -1         | Bulk        | -1       | oz.  | -1             | -1            | -1                  | -1                     | -1                   | -1                         | -1                        | -1                         | -1               |
    And Vendor confirm Next new Product
    And Vendor check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check message is showing of fields when create product
      | field                     | message                                  |
      | Unit length               | Value must be greater than 0             |
      | Unit width                | Value must be greater than 0             |
      | Unit height               | Value must be greater than 0             |
      | Case width                | Value must be greater than 0             |
      | Case height               | Value must be greater than 0             |
      | Case Weight               | Value must be greater than 0             |
      | Unit Size                 | Value must be greater than 0             |
      | Cases per pallet          | Value must be greater than or equal to 0 |
      | Cases per layer           | Value must be greater than or equal to 0 |
      | Layers per full pallet    | Value must be greater than or equal to 0 |
      | Master Cartons per Pallet | Value must be greater than or equal to 0 |
      | Cases per Master Carton   | Value must be greater than or equal to 0 |
      | Master carton length      | Value must be greater than or equal to 0 |
      | Master carton width       | Value must be greater than or equal to 0 |
      | Master carton height      | Value must be greater than or equal to 0 |
      | Master carton Weight      | Value must be greater than or equal to 0 |

    And Vendor edit MOQs
      | region             | value |
      | Pod Direct West    | -1    |
#      | Pod Direct Southwest & Rockies | -1    |
      | Pod Direct East    | -1    |
#      | Pod Direct Northeast           | -1    |
      | Pod Direct Central | -1    |
    And Vendor check message is showing of fields MOQs
      | field              | message                                  |
      | Pod Direct West    | Value must be greater than or equal to 1 |
#      | Pod Direct Southwest & Rockies | Value must be greater than or equal to 1 |
      | Pod Direct East    | Value must be greater than or equal to 1 |
#      | Pod Direct Northeast           | Value must be greater than or equal to 1 |
      | Pod Direct Central | Value must be greater than or equal to 1 |
#    And Vendor check message is showing of fields when create product
#      | field | message |

    And Vendor confirm Next new Product
    And Vendor check message is showing of fields MOQs
      | field              | message                                  |
      | Pod Direct West    | Value must be greater than or equal to 1 |
#      | Pod Direct Southwest & Rockies | Value must be greater than or equal to 1 |
      | Pod Direct East    | Value must be greater than or equal to 1 |
#      | Pod Direct Northeast           | Value must be greater than or equal to 1 |
      | Pod Direct Central | Value must be greater than or equal to 1 |

  @VENDOR_PRODUCTS_27
  Scenario: Check when choosing Is this a beverage & Container type on Organization section
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor57@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to Create new Product
    And VENDOR Create an new Product Success
      | productName                 | brandName              | productType | allowSample | isBeverage | containerType | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | Auto vendor create product8 | Auto Brand product moq | Nut Butter  | yes         | Yes        | Glass         | CBD      | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  | 10             | 10            | 10                  | 1                      | 1                    | 1                          | 1                         | 1                          | 1                |
    And Vendor check help text tooltip
      | field          | text                                             |
      | Container Type | Select the material used to package the product. |
    And Vendor add Bottle Deposits Label
      | file            |
      | 10MBgreater.jpg |
    And VENDOR check alert message
      | Maximum file size exceeded. |
    And Vendor add Bottle Deposits Label
      | file      |
      | test.docx |
    And VENDOR check alert message
      | Invalid file type |
    And Vendor add Bottle Deposits Label
      | file        |
      | anhJPG2.jpg |
    And Vendor add Bottle Deposits
      | bottle          | perUnit |
      | auto1Checkout20 | 1       |
      | auto1checkout21 | 2       |

    And Vendor confirm Next new Product
    And Vendor input info new SKU
      | skuName                 | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku1 | 12        | 123123123123      | masterImage.jpg | 123123123123 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor upload "UPC" image for new SKU
      | image           | masterCarton |
      | masterImage.jpg | 123          |
    And Vendor choose qualities of SKU
      | Dairy-Free |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |
    And Vendor confirm Next new Product
    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"

    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for create product successfully

  @VENDOR_PRODUCTS_3_Preview_Product
  Scenario: Check Vendor click Preview product have/without active SKUs
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product3" by api
    And Admin delete product name "Auto vendor create product3" by api

    And Admin create product by api with info
      | fileName           | product                     | brandID |
      | CreateProduct.json | Auto vendor create product3 | 3086    |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor57@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
#    28/02/2023 update: Vendor create product + sku in the same time
#    And Vendor go to Create new Product
#    And VENDOR Create an new Product Success
#      | productName                 | brandName              | productType | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
#      | Auto vendor create product3 | Auto Brand product moq | Bread       | yes         | Dairy    | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  | 10             | 10            | 10                  | 1                      | 1                    | 1                          | 1                         | 1                          | 1                |
#    And Vendor confirm Create new Product
#    And VENDOR Navigate to "Products" by sidebar
    And Vendor preview Product "Auto vendor create product3"
    And Vendor check page missing

    And VENDOR Navigate to Dashboard
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product3"
    And Vendor check SKUs on product detail with "0" active and "0" draft
      | image   |
      | [blank] |
    And Vendor go to SKUs tap
    And Vendor check SKU "not show" on Draft SKUs
      | skuName    | caseUnit | unitUPC | caseUPC |
      | sku random | [blank]  | [blank] | [blank] |
    And Vendor check SKU "not show" on Published SKUs
      | skuName    | caseUnit | unitUPC | caseUPC |
      | sku random | [blank]  | [blank] | [blank] |
#    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                 | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku1 | 12        | 123123123123      | masterImage.jpg | 123123123123 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |
    And Vendor choose qualities of SKU
      | Dairy-Free |
    And Click on button "Next"
    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And VENDOR check dialog message
      | Are you sure all the information is accurate? Once confirmed, your product will be live and your key product information including price, UPC / EAN, case pack, and size will be locked in so that stores can benefit from consistent information. You can still request changes. Changes may take up to 90 days to process. |
    And Vendor Continue confirm publish SKU
    And Wait for create SKU successfully

    And Vendor check SKU general detail
      | skuName                 | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | storageCondition            | retailCondition             | minTemperature | maxTemperature |
      | Auto vendor create sku1 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123123123123 | 123123123123 | United States | New York | New York | 30      | 10     | Deep Frozen (-20°F ~ -11°F) | Deep Frozen (-20°F ~ -11°F) | -20            | -12            |
    And Vendor check specific price of SKU
      | regionName          | casePrice | availability |
      | Chicagoland Express | $12.00    | In Stock     |

    And VENDOR Navigate to "Products" by sidebar
    And Vendor preview Product "Auto vendor create product3"
    And Vendor check product detail
      | productName                 | unitDimension | caseDimension | unitSize | casePack          |
      | Auto vendor create product3 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 kg   | 12 units per case |
    And Vendor check regions detail
      | region              | price | casePrice | msrp   | availability | moq |
      | Chicagoland Express | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
    And and check details information
      | brandLocation      | storage             | retail              | ingredients                             | temperatureRequirements |
      | New York, New York | 30 days Deep Frozen | 10 days Deep Frozen | Sodium Laureth Sulfate, Hexylene Glycol | -20.0 F - -12.0 F       |
    And and product qualities
      | Dairy-Free |

  @VENDOR_PRODUCTS_5_Duplicate_Product
  Scenario: Check Vendor duplicate product have/without active SKUs
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | Auto vendor create product3 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor "Cancel" duplicate with images of Product "Auto vendor create product3"
    And Vendor check product "not Show" on list
      | product                                 | brand                  | department |
      | Copy of Auto vendor create product3 (1) | Auto Brand product moq | Bakery     |

    And Vendor "Yes" duplicate with images of Product "Auto vendor create product3"
    And Vendor check product "Show" on list
      | product                                 | brand                  | department | image       |
      | Auto vendor create product3             | Auto Brand product moq | Bakery     | anhJPG2.jpg |
      | Copy of Auto vendor create product3 (1) | Auto Brand product moq | Bakery     | anhJPG2.jpg |
    And Vendor go to product detail by name "Copy of Auto vendor create product3 (1)"
    And Vendor check product Packaging detail on dashboard
      | product                                 | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Copy of Auto vendor create product3 (1) | 1          | 1         | 1          | 1          | 1         | 1          | 1          | Bulk        | 1.0      | g    |
    And Vendor check Packaging and size enable
    And Vendor check product Organization detail on dashboard
      | brand                  | category | type       | allowSampleRequest |
      | Auto Brand product moq | Bakery   | Bao Bakery | checked            |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 1             | 1            | 1               |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 1                      | 1                    | 1                  | 1                 | 1                  | 1                  |
    And Vendor check product MOQs detail on dashboard
      | region             | value |
      | Pod Direct West    | 1     |
#      | Pod Direct Southwest & Rockies | 1     |
      | Pod Direct East    | 1     |
#      | Pod Direct Northeast           | 1     |
      | Pod Direct Central | 1     |
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Draft SKUs
      | skuName            | caseUnit | unitUPC | caseUPC |
      | Copy of sku random | [blank]  | [blank] | [blank] |

    And Vendor go to detail of SKU "Copy of sku random"
    And Vendor check SKU general detail
      | skuName            | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature |
      | Copy of sku random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | [blank]        | [blank]        |
#    And Vendor check Region-Specific of SKU
#      | regionName          | casePrice | msrpUnit | availability | arriving |
#      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |
    And Vendor check specific price of SKU
      | regionName          | casePrice | availability |
      | Chicagoland Express | $10.00    | In Stock     |

    And VENDOR Navigate to "Products" by sidebar
    And Vendor "Yes" duplicate with images of Product "Copy of Auto vendor create product3 (1)"
    And Vendor check product "Show" on list
      | product                                             | brand                  | department | image       |
      | Auto vendor create product3                         | Auto Brand product moq | Bakery     | anhJPG2.jpg |
      | Copy of Auto vendor create product3 (1)             | Auto Brand product moq | Bakery     | anhJPG2.jpg |
      | Copy of Copy of Auto vendor create product3 (1) (1) | Auto Brand product moq | Bakery     | anhJPG2.jpg |
    And Vendor go to product detail by name "Copy of Copy of Auto vendor create product3 (1) (1)"
    And Vendor check product Packaging detail on dashboard
      | product                                             | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Copy of Copy of Auto vendor create product3 (1) (1) | 1          | 1         | 1          | 1          | 1         | 1          | 1          | Bulk        | 1.0      | g    |
    And Vendor check Packaging and size enable
    And Vendor check product Organization detail on dashboard
      | brand                  | category | type       | allowSampleRequest |
      | Auto Brand product moq | Bakery   | Bao Bakery | checked            |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 1             | 1            | 1               |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 1                      | 1                    | 1                  | 1                 | 1                  | 1                  |
    And Vendor check product MOQs detail on dashboard
      | region             | value |
      | Pod Direct West    | 1     |
#      | Pod Direct Southwest & Rockies | 1     |
#      | Pod Direct Southeast           | 1     |
      | Pod Direct East    | 1     |
      | Pod Direct Central | 1     |
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Draft SKUs
      | skuName            | caseUnit | unitUPC | caseUPC |
      | Copy of sku random | [blank]  | [blank] | [blank] |
    And VENDOR Navigate to "Products" by sidebar
    And Vendor "Yes" duplicate with images of Product "Auto vendor create product3"
    And Vendor check product "Show" on list
      | product                                             | brand                  | department | image       |
      | Auto vendor create product3                         | Auto Brand product moq | Bakery     | anhJPG2.jpg |
      | Copy of Auto vendor create product3 (1)             | Auto Brand product moq | Bakery     | anhJPG2.jpg |
      | Copy of Auto vendor create product3 (2)             | Auto Brand product moq | Bakery     | anhJPG2.jpg |
      | Copy of Copy of Auto vendor create product3 (1) (1) | Auto Brand product moq | Bakery     | anhJPG2.jpg |
    And Vendor go to product detail by name "Copy of Auto vendor create product3 (2)"
    And Vendor check product Packaging detail on dashboard
      | product                                 | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Copy of Auto vendor create product3 (2) | 1          | 1         | 1          | 1          | 1         | 1          | 1          | Bulk        | 1.0      | g    |
    And Vendor check Packaging and size enable
    And Vendor check product Organization detail on dashboard
      | brand                  | category | type       | allowSampleRequest |
      | Auto Brand product moq | Bakery   | Bao Bakery | checked            |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 1             | 1            | 1               |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 1                      | 1                    | 1                  | 1                 | 1                  | 1                  |
    And Vendor check product MOQs detail on dashboard
      | region             | value |
      | Pod Direct West    | 1     |
#      | Pod Direct Southwest & Rockies | 1     |
#      | Pod Direct Southeast           | 1     |
      | Pod Direct East    | 1     |
      | Pod Direct Central | 1     |
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Draft SKUs
      | skuName            | caseUnit | unitUPC | caseUPC |
      | Copy of sku random | [blank]  | [blank] | [blank] |
    And Vendor go to detail of SKU "Copy of sku random"
    And Vendor check SKU general detail
      | skuName            | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature |
      | Copy of sku random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | [blank]        | [blank]        |
#    And Vendor check Region-Specific of SKU
#      | regionName          | casePrice | msrpUnit | availability | arriving |
#      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |
    And Vendor check specific price of SKU
      | regionName          | casePrice | availability |
      | Chicagoland Express | $10.00    | In Stock     |

  @VENDOR_PRODUCTS_5_Duplicate_Product2
  Scenario: Check Vendor duplicate product have/without active SKUs
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | Auto vendor create product3 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor "Cancel" duplicate with images of Product "Auto vendor create product3"
    And Vendor check product "not Show" on list
      | product                                 | brand                  | department |
      | Copy of Auto vendor create product3 (1) | Auto Brand product moq | Bakery     |

    And Vendor "No" duplicate with images of Product "Auto vendor create product3"
    And Vendor check product "Show" on list
      | product                                 | brand                  | department | image            |
      | Auto vendor create product3             | Auto Brand product moq | Bakery     | anhJPG2.jpg      |
      | Copy of Auto vendor create product3 (1) | Auto Brand product moq | Bakery     | no_img_small.png |
    And Vendor go to product detail by name "Copy of Auto vendor create product3 (1)"
    And Vendor check product Packaging detail on dashboard
      | product                                 | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Copy of Auto vendor create product3 (1) | 1          | 1         | 1          | 1          | 1         | 1          | 1          | Bulk        | 1.0      | g    |
    And Vendor check Packaging and size enable
    And Vendor check product Organization detail on dashboard
      | brand                  | category | type       | allowSampleRequest |
      | Auto Brand product moq | Bakery   | Bao Bakery | checked            |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 1             | 1            | 1               |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 1                      | 1                    | 1                  | 1                 | 1                  | 1                  |
    And Vendor check product MOQs detail on dashboard
      | region             | value |
      | Pod Direct West    | 1     |
#      | Pod Direct Southwest & Rockies | 1     |
#      | Pod Direct Southeast           | 1     |
      | Pod Direct East    | 1     |
      | Pod Direct Central | 1     |
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Draft SKUs
      | skuName            | caseUnit | unitUPC | caseUPC | image            |
      | Copy of sku random | [blank]  | [blank] | [blank] | no_img_small.png |
    And Vendor go to detail of SKU "Copy of sku random"
    And Vendor check SKU general detail
      | skuName            | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature |
      | Copy of sku random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | [blank]        | [blank]        |
    And Vendor check SKU have no images
    And Vendor check specific price of SKU
      | regionName          | casePrice | availability |
      | Chicagoland Express | $10.00    | In Stock     |
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |
#

  @VENDOR_PRODUCTS_5_Delete_Product
  Scenario: Check Vendor delete product
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Admin search product name "Auto vendor create product4" by api
    And Admin delete product name "Auto vendor create product4" by api
    And Admin search product name "Auto vendor create product5" by api
    And Admin delete product name "Auto vendor create product5" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | Auto vendor create product4 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | Auto vendor create product5 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor click "Cancel" delete Product "Auto vendor create product4" on "list"
    And Vendor check product "Show" on list
      | product                     | brand                  | department |
      | Auto vendor create product4 | Auto Brand product moq | Bakery     |
    And Vendor click "Remove it" delete Product "Auto vendor create product4" on "list"
    And Vendor check alert message
      | Product deleted successfully. |
    And Vendor check product "not Show" on list
      | product                     | brand                  | department |
      | Auto vendor create product4 | Auto Brand product moq | Bakery     |

    And Vendor click "Cancel" delete Product "Auto vendor create product5" on "list"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor check product "Show" on list
      | product                     | brand                  | department |
      | Auto vendor create product5 | Auto Brand product moq | Bakery     |

    And Vendor click "Remove it" delete Product "Auto vendor create product5" on "detail"
    And Vendor check alert message
      | Product deleted successfully. |
    And Vendor check product "not Show" on list
      | product                     | brand                  | department |
      | Auto vendor create product5 | Auto Brand product moq | Bakery     |

    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto vendor create product4 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "Auto vendor create product4"
    And Admin check product detail
      | stateStatus | productName                 | brand                  | vendorCompany           | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Inactive    | Auto vendor create product4 | Auto Brand product moq | Auto vendor company moq | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | 1"×1"×1"   |
    And Admin check SKU info on tab "inactive"
      | skuName    | unitUpc      | caseUpc | status   | unitPerCase | codeSKU   | regions |
      | sku random | 123123123123 | [blank] | Inactive | 1 per case  | not check | [blank] |
    And BAO_ADMIN3 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                        | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto vendor create product5 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "Auto vendor create product5"
    And Admin check product detail
      | stateStatus | productName                 | brand                  | vendorCompany           | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Inactive    | Auto vendor create product5 | Auto Brand product moq | Auto vendor company moq | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | 1"×1"×1"   |
    And Admin check SKU info on tab "inactive"
      | skuName    | unitUpc      | caseUpc | status   | unitPerCase | codeSKU   | regions |
      | sku random | 123123123123 | [blank] | Inactive | 1 per case  | not check | [blank] |

#  @VENDOR_PRODUCTS_Check_pagination
#  Scenario: Check the pagination
#    Given VENDOR open web user
#    When login to beta web with email "thuy+pet@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Products" by sidebar
#    And Vendor check 12 number record on pagination
#    And Vendor click "2" on pagination
#    And Vendor check 12 number record on pagination
#    And Vendor click "back" on pagination
#    And Vendor check 12 number record on pagination
#    And Vendor click "next" on pagination
#    And Vendor check 12 number record on pagination

  @VENDOR_Product_Disclaimer
  Scenario: Check Product Disclaimer
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor57@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to Create new Product
    And VENDOR Create an new Product Success
      | productName                 | brandName              | productType | allowSample | isBeverage | containerType | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | Auto vendor create product8 | Auto Brand product moq | Nut Butter  | yes         | Yes        | Glass         | CBD      | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  | 10             | 10            | 10                  | 1                      | 1                    | 1                          | 1                         | 1                          | 1                |
    And Vendor add Bottle Deposits
      | bottle          | perUnit |
      | auto1Checkout20 | 1       |
      | auto1checkout21 | 2       |
      | auto2Checkout20 | 3       |
    And Vendor delete Bottle Deposits 2
    And Vendor confirm Next new Product
    And Vendor input info new SKU
      | skuName                 | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku1 | 12        | 123123123123      | masterImage.jpg | 123123123123 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor upload "UPC" image for new SKU
      | image           | masterCarton |
      | masterImage.jpg | 123          |
    And Vendor choose qualities of SKU
      | Dairy-Free |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |
    And Vendor confirm Next new Product
    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"

    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for create product successfully
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product8"
    And Vendor check product Packaging detail on dashboard
      | product                     | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Auto vendor create product8 | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8.0      | oz.  |
    And Vendor check product Organization detail on dashboard
      | brand                  | category | type       | allowSampleRequest |
      | Auto Brand product moq | CBD      | Nut Butter | checked            |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 10            | 10           | 10              |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 1                      | 1                    | 1                  | 1                 | 1                  | 1                  |
    And Vendor check product MOQs detail on dashboard
      | region             | value |
      | Pod Direct West    | 1     |
#      | Pod Direct Southwest & Rockies | 1     |
#      | Pod Direct Southeast           | 1     |
      | Pod Direct East    | 1     |
      | Pod Direct Central | 1     |
    And Vendor check Bottle Deposit product detail on dashboard
      | bottle          | perUnit |
      | auto2Checkout20 | 3       |
      | auto1Checkout20 | 1       |
    And Vendor check Disclaimer "show" on product detail

  @VENDOR_PRODUCTS_11_Create_new_Product2
  Scenario: Vendor company set MOQ
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |

    And Admin search product name "Auto vendor create product mov" by api
    And Admin delete product name "Auto vendor create product mov" by api

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor56@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor check message on Dashboard product
    And Vendor go to Create new Product
    And VENDOR Create an new Product Success
      | productName                    | brandName              | productType | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | Auto vendor create product mov | Auto Brand product mov | Bread       | yes         | Dairy    | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  | 10             | 10            | 10                  | 1                      | 1                    | 1                          | 1                         | 1                          | 1                |
    And Vendor confirm Next new Product
    And Vendor input info new SKU
      | skuName                 | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku1 | 12        | 123123123123      | masterImage.jpg | 123123123123 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor upload "UPC" image for new SKU
      | image           | masterCarton |
      | masterImage.jpg | 123          |
    And Vendor choose qualities of SKU
      | Dairy-Free |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |
    And Vendor confirm Next new Product
    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for create product successfully
    And VENDOR Navigate to "Products" by sidebar
    And Vendor check product "Show" on list
      | product                        | brand                  | department |
      | Auto vendor create product mov | Auto Brand product mov | Dairy      |

  @VENDOR_PRODUCTS_54
  Scenario: Check display of Product detail page: Vendor company set MOV, There isn't any SKU published for a product
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | Auto vendor create product54 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor56@podfoods.co" pass "12345678a" role "vendor"

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product54"
    And Vendor check product Packaging detail on dashboard
      | product                      | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Auto vendor create product54 | 1          | 1         | 1          | 1          | 1         | 1          | 1          | Bulk        | 1.0      | g    |
    And Vendor check Packaging and size enable
    And Vendor check product Organization detail on dashboard
      | brand                  | category | type       | allowSampleRequest |
      | Auto Brand product mov | Bakery   | Bao Bakery | checked            |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 1             | 1            | 1               |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 1                      | 1                    | 1                  | 1                 | 1                  | 1                  |

  @VENDOR_PRODUCTS_55
  Scenario: Check display of Product detail page: Vendor company set MOV, There is at least 1 published SKU
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | Auto vendor create product55 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor56@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product55"
    And Vendor check product Packaging detail on dashboard
      | product                      | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Auto vendor create product55 | 1          | 1         | 1          | 1          | 1         | 1          | 1          | Bulk        | 1.0      | g    |
    And Vendor check Packaging and size disabled
    And Vendor check product Organization detail on dashboard
      | brand                  | category | type       | allowSampleRequest |
      | Auto Brand product mov | Bakery   | Bao Bakery | checked            |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 1             | 1            | 1               |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 1                      | 1                    | 1                  | 1                 | 1                  | 1                  |
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Published SKUs
      | skuName    | caseUnit    | unitUPC      | caseUPC      |
      | sku random | 1 unit/case | 123123123123 | 123123123123 |

    And Vendor go to detail of SKU "sku random"
    And Vendor check SKU general detail
      | skuName    | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature |
      | sku random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | [blank]        | [blank]        |
    And Vendor check specific price of SKU
      | regionName          | casePrice | availability |
      | Chicagoland Express | $10.00    | In Stock     |
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |

  @VENDOR_PRODUCTS_56
  Scenario: Check display of Product detail page: Vendor company set MOQ, There isn't any SKU published for a product
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | Auto vendor create product56 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product56"
    And Vendor check product Packaging detail on dashboard
      | product                      | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Auto vendor create product56 | 1          | 1         | 1          | 1          | 1         | 1          | 1          | Bulk        | 1.0      | g    |
    And Vendor check Packaging and size disabled
    And Vendor check product Organization detail on dashboard
      | brand                  | category | type       | allowSampleRequest |
      | Auto Brand product moq | Bakery   | Bao Bakery | checked            |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 1             | 1            | 1               |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 1                      | 1                    | 1                  | 1                 | 1                  | 1                  |

  @VENDOR_PRODUCTS_57
  Scenario: Check display of Product detail page: Vendor company set MOQ, There is at least 1 published SKU
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | Auto vendor create product57 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product57"
    And Vendor check product Packaging detail on dashboard
      | product                      | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Auto vendor create product57 | 1          | 1         | 1          | 1          | 1         | 1          | 1          | Bulk        | 1.0      | g    |
    And Vendor check Packaging and size disabled
    And Vendor check product Organization detail on dashboard
      | brand                  | category | type       | allowSampleRequest |
      | Auto Brand product moq | Bakery   | Bao Bakery | checked            |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 1             | 1            | 1               |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 1                      | 1                    | 1                  | 1                 | 1                  | 1                  |
    And Vendor check product MOQs detail on dashboard
      | region             | value |
      | Pod Direct West    | 1     |
#      | Pod Direct Southwest & Rockies | 1     |
#      | Pod Direct Southeast           | 1     |
      | Pod Direct East    | 1     |
      | Pod Direct Central | 1     |
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Published SKUs
      | skuName    | caseUnit    | unitUPC      | caseUPC      |
      | sku random | 1 unit/case | 123123123123 | 123123123123 |
    And Vendor go to detail of SKU "sku random"
    And Vendor check SKU general detail
      | skuName    | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature |
      | sku random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | [blank]        | [blank]        |
    And Vendor check specific price of SKU
      | regionName          | casePrice | availability |
      | Chicagoland Express | $10.00    | In Stock     |
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |

  @VENDOR_PRODUCTS_58
  Scenario: Edit a product - General tab
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | Auto vendor create product57 | 3086     |
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | Auto vendor create product57 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product57"
    And Vendor edit field on Product detail
      | field | value   |
      | Title | [blank] |
    And Vendor confirm Save new Product
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field | message                    |
      | Title | This field cannot be blank |
    And Vendor edit field on Product detail
      | field | value                                |
      | Title | Auto vendor create product57 @edited |
    And Vendor confirm Save new Product
    And Vendor check alert message
      | Product updated successfully! Please add SKUs to this product. |

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product57"
    And Vendor edit field on Product detail
      | field | value                        |
      | Title | Auto vendor create product57 |
    And Vendor confirm Save new Product
    And Vendor check alert message
      | Product updated successfully! Please add SKUs to this product. |

    And VENDOR Create an new Product Success
      | productName | brandName | productType | allowSample | isBeverage | containerType | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit    | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | [blank]     | [blank]   | [blank]     | [blank]     | Yes        | [blank]       | [blank]  | [blank]    | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | [blank]     | [blank]  | [blank] | [blank]        | [blank]       | [blank]             | [blank]                | [blank]              | [blank]                    | [blank]                   | [blank]                    | [blank]          |
    And Vendor check help text tooltip
      | field          | text                                             |
      | Container Type | Select the material used to package the product. |
    And Vendor add Bottle Deposits Label
      | file            |
      | 10MBgreater.jpg |
    And VENDOR check alert message
      | Maximum file size exceeded. |
    And Vendor add Bottle Deposits Label
      | file      |
      | test.docx |
    And VENDOR check alert message
      | Invalid file type |
    And Vendor add Bottle Deposits Label
      | file        |
      | anhJPG2.jpg |
    And Vendor add Bottle Deposits
      | bottle          | perUnit |
      | auto1Checkout20 | 1       |
      | auto1checkout21 | 2       |
    And Vendor confirm Save new Product
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field          | message                    |
      | Container Type | This field cannot be blank |
    And VENDOR Create an new Product Success
      | productName | brandName | productType | allowSample | isBeverage | containerType | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit    | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | [blank]     | [blank]   | [blank]     | [blank]     | Yes        | Glass         | [blank]  | [blank]    | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | [blank]     | [blank]  | [blank] | [blank]        | [blank]       | [blank]             | [blank]                | [blank]              | [blank]                    | [blank]                   | [blank]                    | [blank]          |
    And Vendor confirm Save new Product
    And Vendor check alert message
      | Product updated successfully! Please add SKUs to this product. |

  @VENDOR_PRODUCTS_74
  Scenario: Edit a product - General tab 2
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | Auto vendor create product58 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product58"

    #    And Vendor go to Create new Product
    And VENDOR Create an new Product Success
      | productName | brandName | productType | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | [blank]     | [blank]   | [blank]     | [blank]     | [blank]  | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  | 10             | 10            | 10                  | 10                     | 10                   | 10                         | 10                        | 10                         | 10               |
    And Vendor edit MOQs
      | region             | value |
      | Pod Direct West    | 2     |
#      | Pod Direct Southwest & Rockies | 2     |
#      | Pod Direct Southeast           | 2     |
      | Pod Direct East    | 2     |
      | Pod Direct Central | 2     |
    And Vendor confirm Save new Product
    And Vendor check alert message
      | Product updated successfully! Please add SKUs to this product. |

    And Vendor check product Packaging detail on dashboard
      | product                      | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Auto vendor create product58 | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  |
    And Vendor check Packaging and size enable
    And Vendor check product Organization detail on dashboard
      | brand                  | category | type       | allowSampleRequest |
      | Auto Brand product moq | Bakery   | Bao Bakery | checked            |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 10            | 10           | 10              |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 10                     | 10                   | 10                 | 10                | 10                 | 10                 |
    And Vendor check product MOQs detail on dashboard
      | region             | value |
      | Pod Direct West    | 2     |
#      | Pod Direct Southwest & Rockies | 2     |
#      | Pod Direct Southeast           | 2     |
      | Pod Direct East    | 2     |
      | Pod Direct Central | 2     |

    And VENDOR Create an new Product Success
      | productName | brandName | productType | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | [blank]     | [blank]   | [blank]     | [blank]     | [blank]  | -1         | -1        | -1         | -1         | -1        | -1         | -1         | Bulk        | -1       | oz.  | -1             | -1            | -1                  | -1                     | -1                   | -1                         | -1                        | -1                         | -1               |
    And Vendor confirm Save new Product
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field                     | message                                  |
      | Unit length               | Value must be greater than 0             |
      | Unit width                | Value must be greater than 0             |
      | Unit height               | Value must be greater than 0             |
      | Case width                | Value must be greater than 0             |
      | Case height               | Value must be greater than 0             |
      | Case Weight               | Value must be greater than 0             |
      | Unit Size                 | Value must be greater than 0             |
      | Cases per pallet          | Value must be greater than or equal to 0 |
      | Cases per layer           | Value must be greater than or equal to 0 |
      | Layers per full pallet    | Value must be greater than or equal to 0 |
      | Master Cartons per Pallet | Value must be greater than or equal to 0 |
      | Cases per Master Carton   | Value must be greater than or equal to 0 |
      | Master carton length      | Value must be greater than or equal to 0 |
      | Master carton width       | Value must be greater than or equal to 0 |
      | Master carton height      | Value must be greater than or equal to 0 |
      | Master carton Weight      | Value must be greater than or equal to 0 |

    And Vendor edit MOQs
      | region             | value |
      | Pod Direct West    | -1    |
#      | Pod Direct Southwest & Rockies | -1    |
#      | Pod Direct Southeast           | -1    |
      | Pod Direct East    | -1    |
      | Pod Direct Central | -1    |
    And Vendor check message is showing of fields MOQs
      | field              | message                                  |
      | Pod Direct West    | Value must be greater than or equal to 1 |
#      | Pod Direct Southwest & Rockies | Value must be greater than or equal to 1 |
#      | Pod Direct Southeast           | Value must be greater than or equal to 1 |
      | Pod Direct East    | Value must be greater than or equal to 1 |
      | Pod Direct Central | Value must be greater than or equal to 1 |

  @VENDOR_PRODUCTS_68_69
  Scenario: Edit a product - Change from Category is not Beverage to Category is Beverage
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | Auto vendor create product61 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product61"
    And VENDOR Create an new Product Success
      | productName | brandName                | productType | isBeverage | containerType   | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | [blank]     | Auto Brand 2 product moq | Milk        | Yes        | Plastic PETE #1 | [blank]     | Beverage | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  | 10             | 10            | 10                  | 10                     | 10                   | 10                         | 10                        | 10                         | 10               |

    And Vendor add Bottle Deposits
      | bottle          | perUnit |
      | auto1Checkout20 | 1       |
    And Vendor confirm Save new Product
    And Vendor check alert message
      | Product updated successfully! Please add SKUs to this product. |
    And Vendor check Bottle Deposit product detail on dashboard
      | bottle          | perUnit |
      | auto1Checkout20 | 1       |
    And Vendor check product Packaging detail on dashboard
      | product                      | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Auto vendor create product61 | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  |
    And Vendor check product Organization detail on dashboard
      | brand                    | category | type | allowSampleRequest | container       | isBeverage |
      | Auto Brand 2 product moq | Beverage | Milk | checked            | Plastic PETE #1 | Yes        |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 10            | 10           | 10              |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 10                     | 10                   | 10                 | 10                | 10                 | 10                 |

#    - Change from Category is Beverage to Category is not Beverage
    And VENDOR Create an new Product Success
      | productName | brandName | productType | isBeverage | containerType | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit    | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | [blank]     | [blank]   | Bao Bakery  | No         | [blank]       | [blank]     | Bakery   | [blank]    | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | [blank]     | [blank]  | [blank] | [blank]        | [blank]       | [blank]             | [blank]                | [blank]              | [blank]                    | [blank]                   | [blank]                    | [blank]          |
    And Vendor confirm Save new Product
    And Vendor check alert message
      | Product updated successfully! Please add SKUs to this product. |
    And Vendor check product Packaging detail on dashboard
      | product                      | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Auto vendor create product61 | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  |
    And Vendor check product Organization detail on dashboard
      | brand                    | category | type       | allowSampleRequest |
      | Auto Brand 2 product moq | Bakery   | Bao Bakery | checked            |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 10            | 10           | 10              |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 10                     | 10                   | 10                 | 10                | 10                 | 10                 |
#  Change from any Category to Category is CBD
    And VENDOR Create an new Product Success
      | productName | brandName | productType | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit    | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | [blank]     | [blank]   | Nut Butter  | [blank]     | CBD      | [blank]    | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | [blank]     | [blank]  | [blank] | [blank]        | [blank]       | [blank]             | [blank]                | [blank]              | [blank]                    | [blank]                   | [blank]                    | [blank]          |
    And Vendor confirm Save new Product
    And Vendor check alert message
      | Product updated successfully! Please add SKUs to this product. |
    And Vendor check product Packaging detail on dashboard
      | product                      | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Auto vendor create product61 | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  |
    And Vendor check product Organization detail on dashboard
      | brand                    | category | type       | allowSampleRequest |
      | Auto Brand 2 product moq | CBD      | Nut Butter | checked            |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 10            | 10           | 10              |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 10                     | 10                   | 10                 | 10                | 10                 | 10                 |
    And Vendor check Disclaimer "show" on product detail

    #  - Change from Category is CBD to Category is not CBD
    And VENDOR Create an new Product Success
      | productName | brandName | productType | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit    | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | [blank]     | [blank]   | Bao Bakery  | [blank]     | Bakery   | [blank]    | [blank]   | [blank]    | [blank]    | [blank]   | [blank]    | [blank]    | [blank]     | [blank]  | [blank] | [blank]        | [blank]       | [blank]             | [blank]                | [blank]              | [blank]                    | [blank]                   | [blank]                    | [blank]          |
    And Vendor confirm Save new Product
    And Vendor check alert message
      | Product updated successfully! Please add SKUs to this product. |
    And Vendor check product Packaging detail on dashboard
      | product                      | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit |
      | Auto vendor create product61 | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  |
    And Vendor check product Organization detail on dashboard
      | brand                    | category | type       | allowSampleRequest |
      | Auto Brand 2 product moq | Bakery   | Bao Bakery | checked            |
    And Vendor check product Pallet Configuration detail on dashboard
      | casePerPallet | casePerLayer | layerFullPallet |
      | 10            | 10           | 10              |
    And Vendor check product Master Case Configuration detail on dashboard
      | masterCartonsPerPallet | casesPerMasterCarton | masterCartonLength | masterCartonWidth | masterCartonHeight | masterCartonWeight |
      | 10                     | 10                   | 10                 | 10                | 10                 | 10                 |
    And Vendor check Disclaimer "not show" on product detail
    And Vendor confirm Save new Product
    And Vendor check alert message
      | Product updated successfully! Please add SKUs to this product. |

  @VENDOR_PRODUCTS_109
  Scenario: 4. Product detail page > SKUs tab (SKU list)
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product109 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor58@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product109"
    And Vendor go to SKUs tap
    And Vendor check default SKUs tap with "no published and no draft"
#    And Vendor check product Organization detail on dashboard
#      | brand                  | category | type       | allowSampleRequest |
#      | Auto Brand product moq | Bakery   | Bao Bakery | checked            |

  @VENDOR_PRODUCTS_113
  Scenario: 4. Product detail page > SKUs tab (SKU list)2
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]               | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | Auto vendor create product113 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "Auto vendor create product113" from API
    And Admin delete all inventory by API

    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]            | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | Auto vendor create product | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "Auto vendor create product" from API
    And Admin delete all inventory by API

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product113 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
#    And Info of Region
#      | region          | id | state  | availability | casePrice | msrp |
#      | Florida Express | 26 | active | in_stock     | 1000      | 1000 |
#    And Admin create a "draft" SKU from admin with name "sku 2 random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor58@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product113"
    And Vendor go to SKUs tap
    And Vendor check default SKUs tap with "no draft"
    And Click on any text "< Back to Product"
    And Vendor check product Organization detail on dashboard
      | brand                  | category | type       | allowSampleRequest |
      | Auto Brand product moq | Bakery   | Bao Bakery | checked            |

    And Admin delete sku "" in product "" by api
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "draft" SKU from admin with name "sku 2 random" of product ""
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product113"
    And Vendor go to SKUs tap
    And Vendor check default SKUs tap with "no published"

    And Info of Region
      | region                   | id | state  | availability | casePrice | msrp |
      | Chicagoland Express      | 26 | active | in_stock     | 1000      | 1000 |
      | New York Express         | 53 | active | sold_out     | 2000      | 2000 |
#      | Pod Direct Southeast           | 59 | active | coming_soon  | 3000      | 3000 |
      | Pod Direct Central       | 58 | active | in_stock     | 1000      | 1000 |
      | Pod Direct East          | 55 | active | sold_out     | 2000      | 2000 |
#      | Mid Atlantic Express           | 62 | active | coming_soon  | 3000      | 3000 |
      | Florida Express          | 63 | active | in_stock     | 1000      | 1000 |
#      | Pod Direct Southwest & Rockies | 60 | active | sold_out     | 2000      | 2000 |
#      | Texas Express                  | 61 | active | coming_soon  | 3000      | 3000 |
      | Pod Direct West          | 54 | active | in_stock     | 1000      | 1000 |
      | North California Express | 25 | active | sold_out     | 2000      | 2000 |
      | Sacramento Express       | 67 | active | in_stock     | 2000      | 2000 |
      | Denver Express           | 66 | active | in_stock     | 2000      | 2000 |
      | Phoenix Express          | 65 | active | in_stock     | 2000      | 2000 |
      | Atlanta Express          | 64 | active | in_stock     | 2000      | 2000 |
#      | South California Express       | 51 | active | coming_soon  | 3000      | 3000 |


    And Admin create a "active" SKU from admin with name "sku random" of product ""

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product113"
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Published SKUs
      | skuName    | caseUnit    | unitUPC      | caseUPC      |
      | sku random | 1 unit/case | 123123123123 | 123123123123 |
    And Vendor check SKU "show" on Draft SKUs
      | skuName      | caseUnit | unitUPC | caseUPC |
      | sku 2 random | [blank]  | [blank] | [blank] |

    And Vendor check price Stock Availability of SKU "sku random"
      | region                         | availability | wholesale | unit   |
      | Chicagoland Express            | In stock     | $10.00    | $10.00 |
      | New York Express               | Sold out     | $20.00    | $20.00 |
#      | Pod Direct Southeast           | Launching Soon | $30.00    | $30.00 |
      | Pod Direct Central             | In stock     | $10.00    | $10.00 |
      | Pod Direct East                | Sold out     | $20.00    | $20.00 |
#      | Mid Atlantic Express           | Launching Soon | $30.00    | $30.00 |
      | Florida Express                | In stock     | $10.00    | $10.00 |
#      | Pod Direct Southwest & Rockies | Sold out     | $20.00    | $20.00 |
#      | Texas Express                  | Launching Soon | $30.00    | $30.00 |
      | Pod Direct West                | In stock     | $10.00    | $10.00 |
      | North California Express       | Sold out     | $20.00    | $20.00 |
      | Sacramento Express             | In stock     | $20.00    | $20.00 |
      | Denver Express                 | In stock     | $20.00    | $20.00 |
      | Phoenix Express                | In stock     | $20.00    | $20.00 |
      | Atlanta Express                | In stock     | $20.00    | $20.00 |
#      | South California Express       | Launching Soon | $30.00    | $30.00 |

    And Vendor close popup
    And Vendor go to Inventory of SKU "sku random"
    And Vendor check Inventory of SKU
      | lotCode | comment | quantity |
      | [blank] | [blank] | [blank]  |
    And Vendor close popup

    And Admin create inventory api1
      | index | sku        | product_variant_id | quantity | lot_code     | warehouse_id | receive_date | expiry_date | comment |
      | 1     | sku random | random             | 10       | sku random   | 90           | Plus1        | [blank]     | comment |
      | 1     | sku random | random             | 11       | sku random1  | 90           | currentDate  | [blank]     | comment |
      | 1     | sku random | random             | 12       | sku random2  | 90           | Minus1       | [blank]     | comment |
      | 1     | sku random | random             | 13       | sku random3  | 90           | Minus2       | Minus1      | comment |
      | 1     | sku random | random             | 14       | sku random4  | 90           | Plus1        | Plus2       | comment |
      | 1     | sku random | random             | 15       | sku random5  | 90           | currentDate  | currentDate | comment |
      | 1     | sku random | random             | 16       | sku random6  | 90           | currentDate  | [blank]     | comment |
      | 1     | sku random | random             | 17       | sku random7  | 90           | currentDate  | [blank]     | comment |
      | 1     | sku random | random             | 18       | sku random8  | 90           | currentDate  | [blank]     | comment |
      | 1     | sku random | random             | 19       | sku random9  | 90           | currentDate  | [blank]     | comment |
      | 1     | sku random | random             | 20       | sku random10 | 90           | currentDate  | [blank]     | comment |
      | 1     | sku random | random             | 21       | sku random11 | 90           | currentDate  | [blank]     | comment |
      | 1     | sku random | random             | 22       | sku random12 | 90           | currentDate  | [blank]     | comment |
    And Vendor go to Inventory of SKU "sku random"
    And Vendor check Inventory of SKU
      | lotCode      | comment | quantity |
      | sku random   | comment | 10       |
      | sku random1  | comment | 11       |
      | sku random2  | comment | 12       |
      | sku random3  | comment | 13       |
      | sku random4  | comment | 14       |
      | sku random5  | comment | 15       |
      | sku random6  | comment | 16       |
      | sku random7  | comment | 17       |
      | sku random8  | comment | 18       |
      | sku random9  | comment | 19       |
      | sku random10 | comment | 20       |
      | sku random11 | comment | 21       |

    And Vendor click "2" on pagination
    And Vendor check Inventory of SKU
      | lotCode      | comment | quantity |
      | sku random12 | comment | 22       |

    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]            | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | Auto vendor create product | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "Auto vendor create product" from API
    And Admin delete all inventory by API

  @VENDOR_PRODUCTS_116
  Scenario: Check vendor duplicate a SKU (published/draft)
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]            | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | Auto vendor create product | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "Auto vendor create product" from API
    And Admin delete all inventory by API

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product116 | 3086     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product116"
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Published SKUs
      | skuName    | caseUnit    | unitUPC      | caseUPC      |
      | sku random | 1 unit/case | 123123123123 | 123123123123 |
    And Vendor "Cancel" duplicate with images of SKU "sku random"
    And Vendor check SKU "show" on Published SKUs
      | skuName    | caseUnit    | unitUPC      | caseUPC      |
      | sku random | 1 unit/case | 123123123123 | 123123123123 |
    And Vendor check SKU "not show" on Draft SKUs
      | skuName    | caseUnit | unitUPC | caseUPC |
      | sku random | [blank]  | [blank] | [blank] |

    And Vendor "Yes" duplicate with images of SKU "sku random"
    And Vendor check SKU "show" on Published SKUs
      | skuName    | caseUnit    | unitUPC      | caseUPC      |
      | sku random | 1 unit/case | 123123123123 | 123123123123 |
    And Vendor check SKU "show" on Draft SKUs
      | skuName            | caseUnit | unitUPC | caseUPC |
      | Copy of sku random | [blank]  | [blank] | [blank] |
    And Vendor "Cancel" delete SKU "Copy of sku random"
    And Vendor check SKU "show" on Draft SKUs
      | skuName            | caseUnit | unitUPC | caseUPC |
      | Copy of sku random | [blank]  | [blank] | [blank] |
    And Vendor "OK" delete SKU "Copy of sku random"
    And Vendor check SKU "not show" on Draft SKUs
      | skuName            | caseUnit | unitUPC | caseUPC |
      | Copy of sku random | [blank]  | [blank] | [blank] |

    And Vendor "No" duplicate with images of SKU "sku random"
    And Vendor check SKU "show" on Published SKUs
      | skuName    | caseUnit    | unitUPC      | caseUPC      |
      | sku random | 1 unit/case | 123123123123 | 123123123123 |
    And Vendor check SKU "show" on Draft SKUs
      | skuName            | caseUnit | unitUPC | caseUPC | image            |
      | Copy of sku random | [blank]  | [blank] | [blank] | no_img_small.png |
    And Vendor go to detail of SKU "Copy of sku random"
    And Vendor check SKU general detail
      | skuName            | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature |
      | Copy of sku random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | [blank]        | [blank]        |
    And Vendor check SKU have no images
    And Vendor go back product detail

    And Vendor "Yes" duplicate with images of SKU "Copy of sku random"
    And Vendor check SKU "show" on Draft SKUs
      | skuName                    | caseUnit | unitUPC | caseUPC | image            |
      | Copy of Copy of sku random | [blank]  | [blank] | [blank] | no_img_small.png |

    And Vendor go to detail of SKU "Copy of Copy of sku random"
    And Vendor check SKU general detail
      | skuName                    | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature |
      | Copy of Copy of sku random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | [blank]        | [blank]        |
    And Vendor check SKU have no images

  @VENDOR_PRODUCTS_120
  Scenario: Check vendor remove a SKU (published/draft)
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product120 | 3086     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "draft" SKU from admin with name "sku 2 random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor55@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product120"
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Published SKUs
      | skuName    | caseUnit    | unitUPC      | caseUPC      |
      | sku random | 1 unit/case | 123123123123 | 123123123123 |

    And Vendor check SKU "show" on Draft SKUs
      | skuName      | caseUnit    | unitUPC      | caseUPC      |
      | sku 2 random | 1 unit/case | 123123123123 | 123123123123 |
    And Vendor "Cancel" delete SKU "sku 2 random"
    And Vendor check SKU "show" on Draft SKUs
      | skuName      | caseUnit    | unitUPC      | caseUPC      |
      | sku 2 random | 1 unit/case | 123123123123 | 123123123123 |
    And Vendor "OK" delete SKU "sku 2 random"
    And Vendor check SKU "not show" on Draft SKUs
      | skuName      | caseUnit    | unitUPC      | caseUPC      |
      | sku 2 random | 1 unit/case | 123123123123 | 123123123123 |

    And Vendor "OK" delete SKU "sku random"
    And Vendor check alert message
      | You must create a new main variant before |

    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                          | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto vendor create product120 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "Auto vendor create product120"
    And Admin check product detail
      | stateStatus | productName                   | brand                  | vendorCompany           | sampleable | packageSize | unitLWH  | caseLWH  | caseWight | unitSize | additionalFee | category | type         | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | Auto vendor create product120 | Auto Brand product moq | Auto vendor company moq | Yes        | Bulk        | 1"×1"×1" | 1"×1"×1" | 1.00 lbs  | 1.0 g    | 0.00%         | Bakery   | / Bao Bakery | 1             | 1            | 1              | 1            | 1          | 1.00 lbs         | 1"×1"×1"   |
    And Admin check SKU info on tab "active"
      | skuName    | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | sku random | 123123123123 | [blank] | Active | 1 per case  | not check | [blank] |
    And Admin check SKU info on tab "inactive"
      | skuName      | unitUpc      | caseUpc | status   | unitPerCase | codeSKU   | regions |
      | sku 2 random | 123123123123 | [blank] | Inactive | 1 per case  | not check | [blank] |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_124
  Scenario: Create new SKU General tab
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Admin search product name "Auto vendor create product moq sku124" by api
    And Admin delete product name "Auto vendor create product moq sku124" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product124 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product124"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
#      | Auto vendor create sku124 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                 | United States     | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor click "Save as a draft" new SKU
    And Vendor check alert message
      | Validation failed: Name can't be blank |

    And Vendor Clear field "Name" when create product
    And Vendor click "Save as a draft" new SKU
    And Vendor check alert message
      | Validation failed: Name can't be blank |

    And Vendor check message is showing of fields when create product
      | field | message                    |
      | Name  | This field cannot be blank |
#    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku124 | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
#      | Auto vendor create sku124 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                 | United States     | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product124"
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Draft SKUs
      | skuName                   | caseUnit | unitUPC | caseUPC |
      | Auto vendor create sku124 | [blank]  | [blank] | [blank] |
    And Vendor go to detail of SKU "Auto vendor create sku124"
    And Vendor check SKU general detail
      | skuName                   | ingredients | description | leadTime | unitCase | unitUPC | caseUPC | country       | city    | state   | storage | retail  | minTemperature | maxTemperature |
      | Auto vendor create sku124 | [blank]     | [blank]     | 1        | 1        | [blank] | [blank] | United States | [blank] | [blank] | [blank] | [blank] | [blank]        | [blank]        |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Vendor go to Manage SKU price tab
    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku124"
    And Check have no product showing

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product124"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor click "Next" new SKU
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field                      | message                    |
      | Name                       | This field cannot be blank |
      | SKU Image                  | Please upload an image     |
      | Ingredients                | This field cannot be blank |
      | Description                | This field cannot be blank |
      | Units/case                 | This field cannot be blank |
      | Unit UPC Image             | Please upload an image     |
      | Case UPC Image             | Please upload an image     |
      | Unit UPC                   | This field cannot be blank |
      | Case UPC                   | This field cannot be blank |
      | City                       | This field cannot be blank |
      | State (Province/Territory) | This field cannot be blank |
      | Storage shelf life (days)  | This field cannot be blank |
      | Retail shelf life (days)   | This field cannot be blank |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_126
  Scenario: Create new SKU General tab 2
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product126 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product126"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor set is main SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku126 | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
#      | Auto vendor create sku124 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                 | United States     | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product126"
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Draft SKUs
      | skuName                   | caseUnit | unitUPC | caseUPC |
      | Auto vendor create sku126 | [blank]  | [blank] | [blank] |

    And Vendor go to detail of SKU "Auto vendor create sku126"
    And Vendor check SKU general detail
      | skuName                   | ingredients | description | leadTime | unitCase | unitUPC | caseUPC | country | city    | state   | storage | retail  | minTemperature | maxTemperature | isMain |
      | Auto vendor create sku126 | [blank]     | [blank]     | [blank]  | [blank]  | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]        | [blank]        | isMain |

    And Admin get ID SKU by name "Auto vendor create sku126" from product id "" by API
    And Admin delete sku "" in product "" by api

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product126"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor set not main SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku126 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |
    And Vendor choose qualities of SKU
      | Dairy-Free |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"
    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product126"
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Published SKUs
      | skuName                   | caseUnit      | unitUPC      | caseUPC      |
      | Auto vendor create sku126 | 12 units/case | 123456789098 | 123456789098 |

    And Vendor go to detail of SKU "Auto vendor create sku126"
    And Vendor check SKU general detail
      | skuName                   | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature | isMain |
      | Auto vendor create sku126 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20            | -12            | isMain |
    And Vendor check value of field on SKU detail
      | field                     | value                       |
      | Storage shelf life (days) | 30                          |
      | Storage condition         | Deep Frozen (-20°F ~ -11°F) |
      | Retail shelf life (days)  | 10                          |
      | Retail condition          | Deep Frozen (-20°F ~ -11°F) |
    And Vendor check Qualities of SKU
      | Dairy-Free |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_130
  Scenario: Create new SKU General tab 3
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product130 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product130"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor set is main SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku130 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |
    And Vendor choose qualities of SKU
      | Dairy-Free |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"

    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product130"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor set is main SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku130 | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
#      | Auto vendor create sku124 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                 | United States     | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor click "Save as a draft" new SKU
    And Vendor check alert message
      | Validation failed: You can't save a draft as main variant |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_131
  Scenario: Create new SKU General tab 4
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product131 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product131"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor set is main SKU
    And Vendor input info new SKU
      | skuName                            | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku131 not main | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |
    And Vendor choose qualities of SKU
      | Dairy-Free |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"

    And Vendor add regions for SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor go back product detail
    And Vendor go to create a new SKU
    And Vendor set not main SKU
    And Vendor input info new SKU
      | skuName                        | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku131 main | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |
    And Vendor choose qualities of SKU
      | Dairy-Free |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"

    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor go back product detail
    And Vendor check SKU "show" on Published SKUs
      | skuName                        | caseUnit      | unitUPC      | caseUPC      |
      | Auto vendor create sku131 main | 12 units/case | 123456789098 | 123456789098 |

    And Vendor go to detail of SKU "Auto vendor create sku131 not main"
    And Vendor check SKU general detail
      | skuName                            | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature | isMain |
      | Auto vendor create sku131 not main | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20            | -12            | isMain |
    And Vendor go back product detail
    And Vendor go to detail of SKU "Auto vendor create sku131 main"
    And Vendor check SKU general detail
      | skuName                        | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature | isMain  |
      | Auto vendor create sku131 main | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20            | -12            | [blank] |
    And Vendor go back product detail
    And Vendor "OK" delete SKU "Auto vendor create sku131 main"

    And Vendor go to create a new SKU
    And Vendor set is main SKU
    And Vendor input info new SKU
      | skuName                        | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku131 main | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |
    And Vendor choose qualities of SKU
      | Dairy-Free |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"

    And Vendor add regions for SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor go back product detail
    And Vendor go to detail of SKU "Auto vendor create sku131 main"
    And Vendor check SKU general detail
      | skuName                        | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature | isMain |
      | Auto vendor create sku131 main | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20            | -12            | isMain |

    And Vendor go back product detail
    And Vendor go to detail of SKU "Auto vendor create sku131 not main"
    And Vendor check SKU general detail
      | skuName                            | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature | isMain  |
      | Auto vendor create sku131 not main | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20            | -12            | [blank] |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_132
  Scenario: Create new SKU General tab validate images field
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product132 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product132"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor set is main SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku132 | [blank]   | [blank]           | 10MBgreater.jpg | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage      | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid.mp4 | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage      | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid.mp4 | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage       | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid1.pdf | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage        | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid2.xlsx | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage       | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid3.xls | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage       | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid4.csv | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |

    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage    | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku132 | [blank]   | [blank]           | [blank]     | [blank] | 10MBgreater.jpg | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage     | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid.mp4 | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage     | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid.mp4 | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage      | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid1.pdf | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage       | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid2.xlsx | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage      | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid3.xls | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage      | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid4.csv | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |

    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage    | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku132 | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | 10MBgreater.jpg | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage     | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid.mp4 | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage     | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid.mp4 | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid1.pdf | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage       | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid2.xlsx | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid3.xls | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid4.csv | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |

    And Vendor upload "UPC" image for new SKU
      | image           | masterCarton |
      | 10MBgreater.jpg | 123          |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor upload "UPC" image for new SKU
      | image             | masterCarton      |
      | ImageInvalid4.csv | Invalid file type |
    And Vendor change Barcodes type of SKU to EAN
    And Vendor upload "EAN" image for new SKU
      | image           | masterCarton |
      | 10MBgreater.jpg | 123          |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor upload "EAN" image for new SKU
      | image             | masterCarton      |
      | ImageInvalid4.csv | Invalid file type |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_134
  Scenario: Vendor save draft SKU
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product134 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product134"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor click "Next" new SKU
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku134 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor upload "UPC" image for new SKU
      | image       | masterCarton      |
      | anhJPEG.jpg | Invalid file type |

    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor go back product detail
    And Vendor check SKU "show" on Draft SKUs
      | skuName                   | caseUnit      | unitUPC      | caseUPC      |
      | Auto vendor create sku134 | 12 units/case | 123456789098 | 123456789098 |

    And Vendor go to detail of SKU "Auto vendor create sku134"
    And Vendor check SKU general detail
      | skuName                   | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature | isMain |
      | Auto vendor create sku134 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20            | -12            | isMain |
    And Vendor check value of field on SKU detail
      | field                     | value                       |
      | Storage shelf life (days) | 30                          |
      | Storage condition         | Deep Frozen (-20°F ~ -11°F) |
      | Retail shelf life (days)  | 10                          |
      | Retail condition          | Deep Frozen (-20°F ~ -11°F) |

    And Vendor click "Publish" new SKU
#    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |
    And Vendor upload "UPC" image for new SKU
      | image       | masterCarton |
      | anhJPEG.jpg | 123          |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Validation failed: Region specific or store specific or buyer company specific must be present |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_122
  Scenario: Create new SKU General tab check help text
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product122 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product122"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor check help text tooltip
      | field       | text                                                                                                    |
      | Name        | Exact name of your SKU as you want it to appear to buyers                                               |
#      | SKU Image   | You must include pictures of your product in their final packaging, so buyers know what to expect.      |
#      | SKU Image   | We will remove listings that do not include photos of the final packaging from our live catalog                                                                                     |
#      | SKU Image   | they will be moved to Draft stage                                                                                                                                                   |
#      | SKU Image   | The maximum file size is 10MB.                                                                                                                                                      |
      | Description | Use this box to describe the use case for your product and any other attributes you’d like to highlight |
#      | Description | Keep SEO in mind and try to include words you think buyers may search for |
#      | Description | This is an opportunity to sell your product when buyers browse the Pod Food catalog                                                                                                 |
      | Lead time   | How long it takes to get your product into our distribution centers                                     |
      | Units/case  | How many individual units per case                                                                      |

    And Vendor check value of field on SKU detail
      | field         | value |
      | Barcodes Type | UPC   |
    And Vendor check help text tooltip
      | field                   | text                                                                                              |
      | Unit UPC                | UPC of an individual unit (without hyphens)                                                       |
      | Unit UPC Image          | Please upload a picture of the actual product with the unit UPC clearly displayed.                |
      | Case UPC Image          | Please upload a picture of the actual case pack with the case pack UPC clearly displayed.         |
      | Case UPC                | If you do not have a case UPC, please enter a unit UPC                                            |
      | Master Carton UPC Image | Please upload a picture of the actual master carton with the master carton UPC clearly displayed. |
    And Vendor change Barcodes type of SKU to EAN
    And Vendor check value of field on SKU detail
      | field         | value |
      | Barcodes Type | EAN   |
    And Vendor check help text tooltip
      | field          | text                                                                     |
      | Unit EAN       | EAN of an individual unit (without hyphens)                              |
      | Unit EAN Image | Please upload a picture of the SKU with unit EAN clearly displayed.      |
      | Case EAN Image | Please upload a picture of the case box with case EAN clearly displayed. |
      | Case EAN       | If you do not have a case EAN, please enter a unit EAN                   |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_140
  Scenario: Create new SKU General tab check Unit/case
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product140 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product140"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku140 | abc       | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |

    And Vendor check value of field on SKU detail
      | field      | value   |
      | Units/case | [blank] |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | 0         | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |

#    Đang có bug nên comment đoạn này

#    And Vendor check message is showing of fields when create product
#      | field      | message                                  |
#      | Units/case | Value must be greater than or equal to 1 |
#    And Vendor input info new SKU
#      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city | stateManufacture | ingredient | leadTime | description | nutritionLabel |
#      | [blank]  | -1        | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  |
#
#    And Vendor check message is showing of fields when create product
#      | field      | message                                  |
#      | Units/case | Value must be greater than or equal to 1 |
#    And Vendor input info new SKU
#      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city | stateManufacture | ingredient | leadTime | description | nutritionLabel |
#      | [blank]  | 1.1       | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  |
#
#    And Vendor check message is showing of fields when create product
#      | field      | message                  |
#      | Units/case | Value must be an integer |
#    And Vendor input info new SKU
#      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city | stateManufacture | ingredient | leadTime | description | nutritionLabel |
#      | [blank]  | 0         | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  |

    And Vendor decrease field number tooltip 1 times
      | field      | text |
      | Units/case | -1   |
    And Vendor increase field number tooltip 2 times
      | field      | text |
      | Units/case | 1    |

#      And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      | Please fix the highlighted error(s) to continue. |
    And Vendor click "Next" new SKU
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_146
  Scenario: Create new SKU General tab check Unit UPC
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product146 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product146"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku146 | [blank]   | abc               | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |

    And Vendor check value of field on SKU detail
      | field    | value   |
      | Unit UPC | [blank] |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | 1                 | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check message is showing of fields when create product
      | field    | message                     |
      | Unit UPC | UPC must be 12-digit number |

    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | 1234567890123     | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check message is showing of fields when create product
      | field    | message                     |
      | Unit UPC | UPC must be 12-digit number |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | 123456789012      | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check message not showing of fields when create product
      | field    | message                     |
      | Unit UPC | UPC must be 12-digit number |

#    And Vendor Clear field "Unit UPC" when create product
#
#    And Vendor input info new SKU
#      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city | stateManufacture | ingredient | leadTime | description | nutritionLabel |
#      | [blank]  | [blank]  | [blank]  | [blank]  | 12       | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  |
#
#    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |

    And Vendor change Barcodes type of SKU to EAN
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | 1                 | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check message is showing of fields when create product
      | field    | message                     |
      | Unit EAN | EAN must be 13-digit number |

    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | 12345678901232    | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check message is showing of fields when create product
      | field    | message                     |
      | Unit EAN | EAN must be 13-digit number |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | 123456789012      | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check message is showing of fields when create product
      | field    | message                     |
      | Unit EAN | EAN must be 13-digit number |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | 1234567890123     | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check message not showing of fields when create product
      | field    | message                     |
      | Unit EAN | EAN must be 13-digit number |

    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor go back product detail
    And Vendor go to detail of SKU "Auto vendor create sku146"
    And Vendor check SKU general detail
      | skuName                   | ingredients | description | leadTime | unitCase | unitUPC | caseUPC | country       | city    | state   | storage | retail  | minTemperature | maxTemperature |
      | Auto vendor create sku146 | [blank]     | [blank]     | 1        | 1        | [blank] | [blank] | United States | [blank] | [blank] | [blank] | [blank] | [blank]        | [blank]        |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_166
  Scenario: Create new SKU General tab check Storage shelf life
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product166 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product166"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku166 | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | 0                | [blank]          | 0               | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |

    And Vendor check message is showing of fields when create product
      | field                     | message                                  |
      | Storage shelf life (days) | Value must be greater than or equal to 1 |
      | Retail shelf life (days)  | Value must be greater than or equal to 1 |
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku166 | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | -1               | [blank]          | -1              | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |

    And Vendor check message is showing of fields when create product
      | field                     | message                                  |
      | Storage shelf life (days) | Value must be greater than or equal to 1 |
      | Retail shelf life (days)  | Value must be greater than or equal to 1 |

    And Vendor increase field number tooltip 1 times
      | field                     | text |
      | Storage shelf life (days) | 0    |
    And Vendor increase field number tooltip 1 times
      | field                    | text |
      | Retail shelf life (days) | 0    |
    And Vendor check message is showing of fields when create product
      | field                     | message                                  |
      | Storage shelf life (days) | Value must be greater than or equal to 1 |
      | Retail shelf life (days)  | Value must be greater than or equal to 1 |

    And Vendor decrease field number tooltip 1 times
      | field                     | text |
      | Storage shelf life (days) | -1   |
    And Vendor decrease field number tooltip 1 times
      | field                    | text |
      | Retail shelf life (days) | -1   |
    And Vendor check message is showing of fields when create product
      | field                     | message                                  |
      | Storage shelf life (days) | Value must be greater than or equal to 1 |
      | Retail shelf life (days)  | Value must be greater than or equal to 1 |
    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku166"
    And Check have no product showing

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_178
  Scenario: Create new SKU General tab validate Check when adding Nutrition Labels
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product178 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product178"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU

    And Vendor add nutrition labels of SKU
      | image           | description |
      | 10MBgreater.jpg | [blank]     |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor delete nutrition labels number 1
    And Vendor add nutrition labels of SKU
      | image            | description |
      | ImageInvalid.mp4 | [blank]     |
    And Vendor check alert message
      | Invalid file type |
    And Vendor delete nutrition labels number 1
    And Vendor add nutrition labels of SKU
      | image             | description |
      | ImageInvalid1.pdf | [blank]     |
    And Vendor check alert message
      | Invalid file type |
    And Vendor delete nutrition labels number 1

    And Vendor add nutrition labels of SKU
      | image              | description |
      | ImageInvalid2.xlsx | [blank]     |
    And Vendor check alert message
      | Invalid file type |
    And Vendor delete nutrition labels number 1
    And Vendor add nutrition labels of SKU
      | image             | description |
      | ImageInvalid3.xls | [blank]     |
    And Vendor check alert message
      | Invalid file type |
    And Vendor delete nutrition labels number 1
    And Vendor add nutrition labels of SKU
      | image             | description |
      | ImageInvalid4.csv | [blank]     |
    And Vendor check alert message
      | Invalid file type |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | abc         |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    And Check button "Add new" is disabled
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku178 | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |

    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor go back product detail

    And Vendor check SKU "show" on Draft SKUs
      | skuName                   | caseUnit | unitUPC | caseUPC |
      | Auto vendor create sku178 | [blank]  | [blank] | [blank] |
    And Vendor go to detail of SKU "Auto vendor create sku178"
    And Vendor check SKU general detail
      | skuName                   | ingredients | description | leadTime | unitCase | unitUPC | caseUPC | country       | city    | state   | storage | retail  | minTemperature | maxTemperature |
      | Auto vendor create sku178 | [blank]     | [blank]     | [blank]  | [blank]  | [blank] | [blank] | United States | [blank] | [blank] | [blank] | [blank] | [blank]        | [blank]        |

    And Vendor check Nutrition info of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
      | nutritionImage.jpg | abc         |
#    And Check any text is showing on screen
#      | Nutrition labels must have at least one image and not more than three. |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_180
  Scenario: Check when do not add any Region
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product180 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product180"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU

    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku180 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |

    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor go back product detail
    And Vendor check SKU "show" on Draft SKUs
      | skuName                   | caseUnit      | unitUPC      | caseUPC      |
      | Auto vendor create sku180 | 12 units/case | 123456789098 | 123456789098 |
    And Vendor go to detail of SKU "Auto vendor create sku180"
    And Vendor check SKU general detail
      | skuName                   | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature | isMain |
      | Auto vendor create sku180 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20            | -12            | isMain |
    And Vendor check value of field on SKU detail
      | field                     | value                       |
      | Storage shelf life (days) | 30                          |
      | Storage condition         | Deep Frozen (-20°F ~ -11°F) |
      | Retail shelf life (days)  | 10                          |
      | Retail condition          | Deep Frozen (-20°F ~ -11°F) |
#
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku180"
    And Check have no product showing

    And Switch to actor VENDOR
    And Vendor click "Publish" new SKU
    And Check any text "is" showing on screen
      | Nutrition labels must have at least one image and not more than three |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |

    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Validation failed: Region specific or store specific or buyer company specific must be present |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_181
  Scenario: Check when adding region then remove all region added
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product181 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product181"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku181 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |

    And Click on button "Next"
#    #    And Vendor go to "Region-Specific" tab on SKU detail

    And Vendor choose region "Mid Atlantic Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor choose region "Pod Direct West" for SKU
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Vendor choose option "The referenced product contains one or more chemicals on the Prop. 65 List, as identified below." on Prop65
    And Vendor enter info of Prop65
      | firstName | lastName | email                           | companyName             | listAllChemicals | item                                                                                                | warning                                                        |
      | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | Auto vendor company moq | listAllChemicals | Our organization has determined a NSRL, and/or MADL, which will demonstrate compliance with Prop 65 | Shelf tag Prop. 65 warning label for display in retail stores. |
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName           | casePrice | msrpUnit | availability | arriving |
      | Mid Atlantic Express | 0         | 0        | Out of Stock | [blank]  |
      | Pod Direct West      | 0         | 0        | In Stock     | [blank]  |
    And Vendor choose region "Mid Atlantic Express" for SKU
    And Vendor choose region "Pod Direct West" for SKU
#    And Vendor remove region of SKU
#      | Mid Atlantic Express |
#      | Pod Direct West      |
    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Validation failed: Region specific or store specific or buyer company specific must be present |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_182
  Scenario: Check when adding region then remove some region added
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product182 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product182"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku182 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    And Click on button "Next"
#    #    And Vendor go to "Region-Specific" tab on SKU detail

    And Vendor choose region "Chicagoland Express" for SKU

    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor choose region "Pod Direct West" for SKU
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Vendor choose option "The referenced product contains one or more chemicals on the Prop. 65 List, as identified below." on Prop65
    And Vendor enter info of Prop65
      | firstName | lastName | email                           | companyName             | listAllChemicals | item                                                                                                | warning                                                        |
      | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | Auto vendor company moq | listAllChemicals | Our organization has determined a NSRL, and/or MADL, which will demonstrate compliance with Prop 65 | Shelf tag Prop. 65 warning label for display in retail stores. |
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 0         | 0        | Out of Stock | [blank]  |
      | Pod Direct West     | 0         | 0        | In Stock     | [blank]  |
    And Vendor choose region "Pod Direct West" for SKU
#    And Vendor remove region of SKU
#      | Pod Direct West |
    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor go back product detail
    And Vendor check SKU "show" on Draft SKUs
      | skuName                   | caseUnit      | unitUPC      | caseUPC      |
      | Auto vendor create sku182 | 12 units/case | 123456789098 | 123456789098 |
    And Vendor go to detail of SKU "Auto vendor create sku182"
    And Vendor check SKU general detail
      | skuName                   | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature | isMain |
      | Auto vendor create sku182 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20            | -12            | isMain |
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability |
      | Chicagoland Express | 0         | 0        | Out of Stock |

    And Vendor click "Publish" new SKU
#    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field     | message                      |
      | MSRP/unit | Value must be greater than 0 |
    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 1         | 1        | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku182"
    And Search item and go to detail of first result
      | item                      | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create sku182 | Auto vendor create product182 | Auto Brand product moq | $0.08        | $1.00        | In Stock     |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_183
  Scenario: Check when adding the region IS NOT one of three regions covering California  (Pod Direct West, North California Express and South California Express)
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product183 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product183"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku183 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    And Click on button "Next"
#    #    And Vendor go to "Region-Specific" tab on SKU detail

    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor choose region "Dallas Express" for SKU
    And Vendor choose region "Pod Direct Central" for SKU
    And Vendor check content of confirm when add region "Pod Direct"
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Click on dialog button "Add"

    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 0         | 0        | Out of Stock | [blank]  |
      | Dallas Express      | 0         | 0        | Out of Stock | [blank]  |
      | Pod Direct Central  | 0         | 0        | In Stock     | [blank]  |

    And Vendor choose region "Florida Express" for SKU
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Florida Express     | 0         | 0        | Out of Stock | [blank]  |
      | Chicagoland Express | 0         | 0        | Out of Stock | [blank]  |
      | Dallas Express      | 0         | 0        | Out of Stock | [blank]  |
      | Pod Direct Central  | 0         | 0        | In Stock     | [blank]  |
    And Vendor choose region "Pod Direct East" for SKU
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Florida Express     | 0         | 0        | Out of Stock | [blank]  |
      | Chicagoland Express | 0         | 0        | Out of Stock | [blank]  |
      | Dallas Express      | 0         | 0        | Out of Stock | [blank]  |
      | Pod Direct Central  | 0         | 0        | In Stock     | [blank]  |
      | Pod Direct East     | 0         | 0        | In Stock     | [blank]  |

    And Vendor click "Save as a draft" new SKU
    And Wait for create SKU successfully
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Vendor go back product detail
    And Vendor check SKU "show" on Draft SKUs
      | skuName                   | caseUnit      | unitUPC      | caseUPC      |
      | Auto vendor create sku183 | 12 units/case | 123456789098 | 123456789098 |
    And Vendor go to detail of SKU "Auto vendor create sku183"
    And Vendor check SKU general detail
      | skuName                   | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature | isMain |
      | Auto vendor create sku183 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20            | -12            | isMain |
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability |
      | Chicagoland Express | 0         | 0        | Out of Stock |
      | Florida Express     | 0         | 0        | Out of Stock |
      | Dallas Express      | 0         | 0        | Out of Stock |
      | Pod Direct Central  | 0         | 0        | In Stock     |
      | Pod Direct East     | 0         | 0        | In Stock     |

    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 1         | 1        | In Stock     | [blank]      |
      | Dallas Express      | 1         | 1        | In Stock     | [blank]      |
      | Pod Direct Central  | 1         | 1        | In Stock     | [blank]      |
      | Florida Express     | 1         | 1        | In Stock     | [blank]      |
      | Pod Direct East     | 1         | 1        | In Stock     | [blank]      |

    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku182"
    And Search item and go to detail of first result
      | item                      | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create sku183 | Auto vendor create product183 | Auto Brand product moq | $0.08        | $1.00        | In Stock     |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_184
  Scenario: Check when adding the region IS one of three regions covering California (Pod Direct West, North California Express and South California Express)
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product184 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product184"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku184 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |

    And Click on button "Next"
    And Vendor choose region "Pod Direct West" for SKU
    And Vendor check "show" content of Prop65
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
#    And Vendor choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
    And Vendor choose option "The referenced product contains one or more chemicals on the Prop. 65 List, as identified below." on Prop65

    And Vendor enter info of Prop65
      | firstName | lastName | email                           | companyName             | listAllChemicals | item                                                                                                | warning                                                        |
      | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | Auto vendor company moq | listAllChemicals | Our organization has determined a NSRL, and/or MADL, which will demonstrate compliance with Prop 65 | Shelf tag Prop. 65 warning label for display in retail stores. |

    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 0         | 0        | In Stock     |

    And Vendor choose region "North California Express" for SKU
    And Vendor check "not show" content of Prop65
    And Vendor check content of confirm when add region "Express"

    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | Pod Direct West          | 0         | 0        | In Stock     |
      | North California Express | 0         | 0        | Out of Stock |

    And Vendor choose region "South California Express" for SKU
    And Vendor check "not show" content of Prop65

    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | Pod Direct West          | 0         | 0        | In Stock     |
      | North California Express | 0         | 0        | Out of Stock |
      | South California Express | 0         | 0        | Out of Stock |

    And Vendor click "Save as a draft" new SKU
    And Wait for create SKU successfully

#    And Click on button "Next"
    And Vendor go to Manage SKU price tab
    And Vendor input Region-Specific info of SKU
      | regionName               | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West          | 1         | 1        | In Stock     | [blank]      |
      | North California Express | 1         | 1        | In Stock     | [blank]      |
      | South California Express | 1         | 1        | In Stock     | [blank]      |

    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

    And Vendor search product "Auto vendor create product184" on catalog
    And Vendor Go to product detail
      | productName                   | unitDimension | caseDimension | unitSize | casePack          |
      | Auto vendor create product184 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 12 units per case |
    And Vendor check regions detail
      | region                   | price | casePrice | msrp  | availability | moq |
      | Pod Direct West          | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | North California Express | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | South California Express | $0.08 | $1.00     | $1.00 | In Stock     | 1   |

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer60@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku184"
    And Search item and go to detail of first result
      | item                      | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create sku184 | Auto vendor create product184 | Auto Brand product moq | $0.08        | $1.00        | In Stock     |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_185
  Scenario: Check when adding the first region IS one of three regions covering California and add the next region IS NOT one on three regions covering California (Pod Direct West, North California Express and South California Express)
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product185 | 3086     |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product185"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku185 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    And Click on button "Next"
    And Vendor choose region "Florida Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Florida Express | 0         | 0        | Out of Stock |
    And Vendor choose region "Pod Direct Central" for SKU
    And Vendor check content of confirm when add region "Pod Direct"
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName         | casePrice | msrpUnit | availability |
      | Florida Express    | 0         | 0        | Out of Stock |
      | Pod Direct Central | 0         | 0        | In Stock     |

    And Vendor choose region "North California Express" for SKU
    And Vendor check "show" content of Prop65
#    And Vendor check content of confirm when add region "Express"
    And Vendor choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
#    And Vendor choose option on confirm add region
#      | You have product in the corresponding regional DC or on the way to it.           |
#      | You're focusing your sales efforts on activating new accounts in this region.    |
#      | You've sent us a list of direct accounts you’d like us to manage in this region. |
#      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | Florida Express          | 0         | 0        | Out of Stock |
      | Pod Direct Central       | 0         | 0        | In Stock     |
      | North California Express | 0         | 0        | Out of Stock |
    And Vendor choose region "Pod Direct West" for SKU
    And Vendor check "not show" content of Prop65
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | Florida Express          | 0         | 0        | Out of Stock |
      | Pod Direct Central       | 0         | 0        | In Stock     |
      | North California Express | 0         | 0        | Out of Stock |
      | Pod Direct West          | 0         | 0        | In Stock     |
    And Vendor click "Save as a draft" new SKU
    And Wait for create SKU successfully
    And Vendor go to Manage SKU price tab
    And Vendor input Region-Specific info of SKU
      | regionName               | casePrice | msrpunit | availability | expectedDate |
      | Florida Express          | 1         | 1        | In Stock     | [blank]      |
      | Pod Direct Central       | 1         | 1        | In Stock     | [blank]      |
      | North California Express | 1         | 1        | In Stock     | [blank]      |
      | Pod Direct West          | 1         | 1        | In Stock     | [blank]      |

    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

    And Vendor search product "Auto vendor create product185" on catalog
    And Vendor Go to product detail
      | productName                   | unitDimension | caseDimension | unitSize | casePack          |
      | Auto vendor create product185 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 12 units per case |
    And Vendor check regions detail
      | region                   | price | casePrice | msrp  | availability | moq |
      | Pod Direct West          | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Florida Express          | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Pod Direct Central       | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | North California Express | $0.08 | $1.00     | $1.00 | In Stock     | 1   |

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer60@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku185"
    And Search item and go to detail of first result
      | item                      | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create sku186 | Auto vendor create product185 | Auto Brand product moq | $0.08        | $1.00        | In Stock     |

    Given BUYER2 open web user
    And login to beta web with email "ngoctx+autobuyer45@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku185"
    And Search item and go to detail of first result
      | item                      | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create sku185 | Auto vendor create product185 | Auto Brand product moq | $0.08        | $1.00        | In Stock     |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_186
  Scenario: Check when adding the first region IS one of three regions covering California and add the next region IS NOT one on three regions covering California (Pod Direct West, North California Express and South California Express)
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product186 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product186"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku186 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
#    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"

    And Vendor choose region "North California Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Vendor check content of confirm when add region "Express"
    And Vendor check "show" content of Prop65
    And Vendor choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | North California Express | 0         | 0        | Out of Stock |

    And Vendor choose region "Pod Direct West" for SKU
    And Vendor check content of confirm when add region "Pod Direct"
#    And Vendor check "show" content of Prop65
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |

      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Click on dialog button "Add"

    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | Pod Direct West          | 0         | 0        | In Stock     |
      | North California Express | 0         | 0        | Out of Stock |

    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
#    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | Chicagoland Express      | 0         | 0        | Out of Stock |
      | Pod Direct West          | 0         | 0        | In Stock     |
      | North California Express | 0         | 0        | Out of Stock |

    And Vendor choose region "Florida Express" for SKU
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | Florida Express          | 0         | 0        | Out of Stock |
      | Chicagoland Express      | 0         | 0        | Out of Stock |
      | North California Express | 0         | 0        | Out of Stock |
      | Pod Direct West          | 0         | 0        | In Stock     |

    And Vendor click "Save as a draft" new SKU
    And Wait for create SKU successfully
    And Vendor go to Manage SKU price tab
    And Vendor input Region-Specific info of SKU
      | regionName               | casePrice | msrpunit | availability | expectedDate |
      | Florida Express          | 1         | 1        | In Stock     | [blank]      |
      | Chicagoland Express      | 1         | 1        | In Stock     | [blank]      |
      | North California Express | 1         | 1        | In Stock     | [blank]      |
      | Pod Direct West          | 1         | 1        | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

    And Vendor search product "Auto vendor create product186" on catalog
    And Vendor Go to product detail
      | productName                   | unitDimension | caseDimension | unitSize | casePack          |
      | Auto vendor create product186 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 12 units per case |
    And Vendor check regions detail
      | region                   | price | casePrice | msrp  | availability | moq |
      | Florida Express          | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Chicagoland Express      | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | North California Express | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Pod Direct West          | $0.08 | $1.00     | $1.00 | In Stock     | 1   |

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer60@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku186"
    And Search item and go to detail of first result
      | item                      | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create sku186 | Auto vendor create product186 | Auto Brand product moq | $0.08        | $1.00        | In Stock     |

    Given BUYER2 open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku186"
    And Search item and go to detail of first result
      | item                      | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create sku186 | Auto vendor create product186 | Auto Brand product moq | $0.08        | $1.00        | In Stock     |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_123
  Scenario: Vendor create SKU with all region
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product186 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product186"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku186 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
#    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"
    And Vendor choose region "North California Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
#    And Vendor check content of confirm when add region "Express"
#    And Vendor check "show" content of Prop65
    And Vendor choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
    And Click on dialog button "Add"
#    And Vendor check Region-Specific of SKU
#      | regionName               | casePrice | msrpUnit | availability |
#      | North California Express | 0         | 0        | Out of Stock |

    And Vendor choose region "Pod Direct West" for SKU
#    And Vendor check content of confirm when add region "Pod Direct"
#    And Vendor check "show" content of Prop65
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Click on dialog button "Add"

    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | Pod Direct West          | 0         | 0        | In Stock     |
      | North California Express | 0         | 0        | Out of Stock |

    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
#    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | Chicagoland Express      | 0         | 0        | Out of Stock |
      | Pod Direct West          | 0         | 0        | In Stock     |
      | North California Express | 0         | 0        | Out of Stock |

    And Vendor choose region "Florida Express" for SKU
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | Florida Express          | 0         | 0        | Out of Stock |
      | Chicagoland Express      | 0         | 0        | Out of Stock |
      | North California Express | 0         | 0        | Out of Stock |
      | Pod Direct West          | 0         | 0        | In Stock     |
    And Vendor choose region "Dallas Express" for SKU
    And Vendor choose region "Denver Express" for SKU
    And Vendor choose region "Atlanta Express" for SKU
    And Vendor choose region "Mid Atlantic Express" for SKU
    And Vendor choose region "Phoenix Express" for SKU
    And Vendor choose region "Sacramento Express" for SKU
    And Vendor choose region "South California Express" for SKU
    And Vendor choose region "Pod Direct Central" for SKU
    And Vendor choose region "Pod Direct East" for SKU
#    And Vendor choose region "Pod Direct Southeast" for SKU
#    And Vendor choose region "Pod Direct Southwest & Rockies" for SKU
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | Florida Express          | 0         | 0        | Out of Stock |
      | Chicagoland Express      | 0         | 0        | Out of Stock |
      | North California Express | 0         | 0        | Out of Stock |
      | Dallas Express           | 0         | 0        | Out of Stock |
      | Denver Express           | 0         | 0        | Out of Stock |
      | Atlanta Express          | 0         | 0        | Out of Stock |
      | Mid Atlantic Express     | 0         | 0        | Out of Stock |
      | Phoenix Express          | 0         | 0        | Out of Stock |
      | Sacramento Express       | 0         | 0        | Out of Stock |
      | South California Express | 0         | 0        | Out of Stock |
      | Pod Direct West          | 0         | 0        | In Stock     |
      | Pod Direct Central       | 0         | 0        | In Stock     |
      | Pod Direct East          | 0         | 0        | In Stock     |
#      | Pod Direct Southeast           | 0         | 0        | In Stock     |
#      | Pod Direct Southwest & Rockies | 0         | 0        | In Stock     |

    And Vendor click "Save as a draft" new SKU
    And Wait for create SKU successfully
    And Vendor go to Manage SKU price tab
    And Vendor input Region-Specific info of SKU
      | regionName               | casePrice | msrpunit | availability | expectedDate |
      | Florida Express          | 1         | 1        | In Stock     | [blank]      |
      | Chicagoland Express      | 1         | 1        | In Stock     | [blank]      |
      | North California Express | 1         | 1        | In Stock     | [blank]      |
      | Dallas Express           | 1         | 1        | In Stock     | [blank]      |
      | Denver Express           | 1         | 1        | In Stock     | [blank]      |
      | Atlanta Express          | 1         | 1        | In Stock     | [blank]      |
      | Mid Atlantic Express     | 1         | 1        | In Stock     | [blank]      |
      | Phoenix Express          | 1         | 1        | In Stock     | [blank]      |
      | Sacramento Express       | 1         | 1        | In Stock     | [blank]      |
      | South California Express | 1         | 1        | In Stock     | [blank]      |
      | Pod Direct West          | 1         | 1        | In Stock     | [blank]      |
      | Pod Direct Central       | 1         | 1        | In Stock     | [blank]      |
      | Pod Direct East          | 1         | 1        | In Stock     | [blank]      |
#      | Pod Direct Southeast           | 1         | 1        | In Stock     | [blank]      |
#      | Pod Direct Southwest & Rockies | 1         | 1        | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

    And Vendor search product "Auto vendor create product186" on catalog
    And Vendor Go to product detail
      | productName                   | unitDimension | caseDimension | unitSize | casePack          |
      | Auto vendor create product186 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 12 units per case |
    And Vendor check regions detail
      | region                   | price | casePrice | msrp  | availability | moq |
      | Florida Express          | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Chicagoland Express      | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | North California Express | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Dallas Express           | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Denver Express           | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Atlanta Express          | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Mid Atlantic Express     | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Phoenix Express          | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Sacramento Express       | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | South California Express | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Pod Direct West          | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Pod Direct Central       | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
      | Pod Direct East          | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
#      | Pod Direct Southeast           | $0.08 | $1.00     | $1.00 | In Stock     | 1   |
#      | Pod Direct Southwest & Rockies | $0.08 | $1.00     | $1.00 | In Stock     | 1   |

  @VENDOR_PRODUCTS_133
  Scenario: Check when create up to 20 SKUs
    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by "6059"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor check alert message
      | You can create only up to 20 SKUs for each product. |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_187
  Scenario: Check when Active/Inactive state of region
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product187 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product187"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku187 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
#    #    And Vendor go to "Region-Specific" tab on SKU detail

    And Click on button "Next"
    And Vendor choose region "Pod Direct West" for SKU
    And Vendor check "show" content of Prop65
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Vendor choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 0         | 0        | In Stock     |
    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor check content of confirm when add region "Express"
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability |
      | Chicagoland Express | 0         | 0        | Out of Stock |
      | Pod Direct West     | 0         | 0        | In Stock     |

    And Vendor inactive region "Chicagoland Express" of SKU
    And Vendor click "Save as a draft" new SKU
    And Wait for create SKU successfully
#    And Vendor check alert message
#      | Product SKU created successfully. |

    And Vendor go to Manage SKU price tab
    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
#      | Chicagoland Express | 1         | 1        | In Stock     | [blank]      |
      | Pod Direct West | 1         | 1        | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

    And Vendor search product "Auto vendor create product187" on catalog
    And Vendor Go to product detail
      | productName                   | unitDimension | caseDimension | unitSize | casePack          |
      | Auto vendor create product187 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 12 units per case |
    And Vendor check regions detail
      | region          | price | casePrice | msrp  | availability | moq |
      | Pod Direct West | $0.08 | $1.00     | $1.00 | In Stock     | 1   |

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer60@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku187"
    And Search item and go to detail of first result
      | item                      | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create sku187 | Auto vendor create product187 | Auto Brand product moq | $0.08        | $1.00        | In Stock     |

    Given BUYER2 open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku187"
    And Check have no product showing

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_188
  Scenario: Check when entering Wholesale price/CASE, MSRP/unit
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product188 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product188"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku188 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    #    And Vendor go to "Region-Specific" tab on SKU detail

    And Click on button "Next"

    And Vendor choose region "Pod Direct West" for SKU
    And Vendor check "show" content of Prop65
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Vendor choose option "The referenced product contains one or more chemicals on the Prop. 65 List, as identified below." on Prop65
    And Vendor enter info of Prop65
      | firstName | lastName | email                           | companyName             | listAllChemicals | item                                                                                                | warning                                                        |
      | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | Auto vendor company moq | listAllChemicals | Our organization has determined a NSRL, and/or MADL, which will demonstrate compliance with Prop 65 | Shelf tag Prop. 65 warning label for display in retail stores. |

    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 0         | 0        | In Stock     |

    And Vendor Clear field "Wholesale price/CASE" when create product
    And Vendor check message is showing of fields when create product
      | field                | message                    |
      | Wholesale price/CASE | This field cannot be blank |

    And Vendor Clear field "MSRP/unit" when create product
    And Vendor check message is showing of fields when create product
      | field     | message                    |
      | MSRP/unit | This field cannot be blank |

    And Vendor click "Save as a draft" new SKU
    And Wait for create SKU successfully
    And Vendor go to Manage SKU price tab

    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 0         | 0        | In Stock     |
    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West | -1        | -1       | In Stock     | [blank]      |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    #    And Vendor go to "Region-Specific" tab on SKU detail

    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | -1        | -1       | In Stock     |

    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West | 0         | 0        | In Stock     | [blank]      |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 0         | 0        | In Stock     |

    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West | e         | e        | In Stock     | [blank]      |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 0         | 0        | In Stock     |

    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West | 123456789 | 1        | In Stock     | [blank]      |
    And Vendor click "Save as a draft" new SKU
    And Vendor check alert message
      | 12345678900 is out of range for ActiveModel::Type::Integer with limit 4 bytes |
    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit  | availability | expectedDate |
      | Pod Direct West | 1         | 123456789 | In Stock     | [blank]      |
    And Vendor click "Save as a draft" new SKU
    And Vendor check alert message
      | 12345678900 is out of range for ActiveModel::Type::Integer with limit 4 bytes |

    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West | 1         | 1        | In Stock     | [blank]      |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    #    And Vendor go to "Region-Specific" tab on SKU detail

    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 1         | 1        | In Stock     |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_189
  Scenario: Check publish when entering Wholesale price/CASE, MSRP/unit
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product189 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product189"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku189 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"

    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability |
      | Chicagoland Express | 0         | 0        | Out of Stock |

    And Vendor Clear field "Wholesale price/CASE" when create product
    And Vendor check message is showing of fields when create product
      | field                | message                    |
      | Wholesale price/CASE | This field cannot be blank |

    And Vendor Clear field "MSRP/unit" when create product
    And Vendor check message is showing of fields when create product
      | field     | message                    |
      | MSRP/unit | This field cannot be blank |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | -1        | -1       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |

    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 0         | 0        | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |

    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | -1        | 1        | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |

    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 1         | -1       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |

    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 1         | 1        | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor search product "Auto vendor create product189" on catalog
    And Vendor Go to product detail
      | productName                   | unitDimension | caseDimension | unitSize | casePack          |
      | Auto vendor create product189 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 12 units per case |
    And Vendor check regions detail
      | region              | price | casePrice | msrp  | availability | moq |
      | Chicagoland Express | $0.08 | $1.00     | $1.00 | In Stock     | 1   |

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku189"
    And Search item and go to detail of first result
      | item                      | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create sku189 | Auto vendor create product189 | Auto Brand product moq | $0.08        | $1.00        | In Stock     |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_190
  Scenario: Check publish when entering Wholesale price/CASE, MSRP/unit 2
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product190 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product190"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku190 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"

    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability |
      | Chicagoland Express | 0         | 0        | Out of Stock |

    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 12        | 15       | In Stock     | [blank]      |

#    And Vendor check Region-Specific of SKU
#      | regionName          | casePrice | msrpUnit | availability   | arriving |
#      | Chicagoland Express | 12        | 15       | Launching Soon | tomorrow |
#
#    And Vendor input Region-Specific info of SKU
#      | regionName          | casePrice | msrpunit | availability   | expectedDate |
#      | Chicagoland Express | 12        | 15       | Launching Soon | 04/31/2022   |
#
#    And Vendor check Region-Specific of SKU
#      | regionName          | casePrice | msrpUnit | availability   | arriving |
#      | Chicagoland Express | 12        | 15       | Launching Soon | [blank]  |
#
#    And Vendor input Region-Specific info of SKU
#      | regionName          | casePrice | msrpunit | availability   | expectedDate |
#      | Chicagoland Express | 12        | 15       | Launching Soon | a            |
#
#    And Vendor check Region-Specific of SKU
#      | regionName          | casePrice | msrpUnit | availability   | arriving |
#      | Chicagoland Express | 12        | 15       | Launching Soon | [blank]  |
#
#    And Vendor input Region-Specific info of SKU
#      | regionName          | casePrice | msrpunit | availability   | expectedDate |
#      | Chicagoland Express | 12        | 15       | Launching Soon | Plus30       |
#
#    And Vendor check Region-Specific of SKU
#      | regionName          | casePrice | msrpUnit | availability   | arriving |
#      | Chicagoland Express | 12        | 15       | Launching Soon | Plus30   |

    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor search product "Auto vendor create product190" on catalog
    And Vendor Go to product detail
      | productName                   | unitDimension | caseDimension | unitSize | casePack          |
      | Auto vendor create product190 | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 12 units per case |
#    And Vendor check regions detail
#      | region              | price | casePrice | msrp   | availability   | moq | margin |
#      | Chicagoland Express | $1.00 | $12.00    | $15.00 | Launching Soon | 1   | 93%    |

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku190"
    And Search item and go to detail of first result
      | item                      | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create sku190 | Auto vendor create product190 | Auto Brand product moq | $1.00        | $12.00       | In Stock     |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_199
  Scenario: Other cases with Prop 65
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product199 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product199"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku199 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"

    And Vendor choose region "Pod Direct West" for SKU
    And Vendor check "show" content of Prop65
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Vendor choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 0         | 0        | In Stock     |
    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West | 1         | 1        | In Stock     | [blank]      |
    And Vendor click "Save as a draft" new SKU
    And Wait for create SKU successfully
#    And Vendor go back to Manage SKU info tab
    And Vendor check "show" prop65 of SKU
      | type                                                                        | firstName | lastName | email                           | date        | company                 |
      | The referenced product does not contain any chemicals on the Prop. 65 List. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | Auto vendor company moq |

    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                          | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto vendor create product199 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "Auto vendor create product199"
    And Admin check SKU info on tab "draft"
      | skuName                   | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Auto vendor create sku199 | 123456789098 | [blank] | Draft  | 12 per case | not check | PDW     |
    And Admin go to SKU detail "Auto vendor create sku199"
    And Go to "General" tab
    And Admin check Prop65 info on general SKU
      | type                                                                       | firstName | lastName | email                           | date        |
      | The referenced product does not contain any chemicals on the Prop. 65 List | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate |

    And Switch to actor VENDOR
    And Vendor go to Manage SKU price tab
    And Vendor inactive region "Pod Direct West" of SKU
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    #And Vendor go to "General" tab on SKU detail
    And Vendor go back to Manage SKU info tab
    And Vendor check "show" prop65 of SKU
      | type                                                                        | firstName | lastName | email                           | date        | company                 |
      | The referenced product does not contain any chemicals on the Prop. 65 List. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | Auto vendor company moq |

    And Switch to actor BAO_ADMIN3
    And Admin go back with button
    And Admin check SKU info on tab "draft"
      | skuName                   | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Auto vendor create sku199 | 123456789098 | [blank] | Draft  | 12 per case | not check | [blank] |
    And Admin go to SKU detail "Auto vendor create sku199"
    And Go to "General" tab
#    And Admin check have no Prop65 info on general SKU
    And Admin check Prop65 info on general SKU
      | type                                                                       | firstName | lastName | email                           | date        |
      | The referenced product does not contain any chemicals on the Prop. 65 List | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate |

    And Switch to actor VENDOR
    And Vendor go back product detail
    And Vendor check SKU "show" on Draft SKUs
      | skuName                   | caseUnit      | unitUPC      | caseUPC      |
      | Auto vendor create sku199 | 12 units/case | 123456789098 | 123456789098 |
    And Vendor go to detail of SKU "Auto vendor create sku199"
    And Vendor check SKU general detail
      | skuName                   | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature | isMain |
      | Auto vendor create sku199 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20            | -12            | isMain |

    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Vendor go to Manage SKU price tab
#    And Vendor active region "Pod Direct West" of SKU
    And Vendor choose region "Pod Direct West" for SKU
#    And Vendor choose option "The referenced product contains one or more chemicals on the Prop. 65 List, as identified below." on Prop65
#    And Vendor enter info of Prop65
#      | firstName | lastName | email                           | companyName             | listAllChemicals | item                                                                                                                                                                                                                                                                                                                                                           | warning                                                        |
#      | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | Auto vendor company moq | listAllChemicals | This product does not expose the user to chemical levels that exceed the No Significant Risk Level (NSRL) and/or Maximum Allowable Dose Level (MADL) established under Prop 65, or an alternative level established by California Courts (if established by California Courts, please email a copy of the applicable Consent Judgment to success@podfoods.co). | Shelf tag Prop. 65 warning label for display in retail stores. |
#    And Click on dialog button "Add"
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    #And Vendor go to "General" tab on SKU detail
    And Vendor go back to Manage SKU info tab
    And Vendor check "show" prop65 of SKU
      | type                                                                        | firstName | lastName | email                           | date        | company                 |
      | The referenced product does not contain any chemicals on the Prop. 65 List. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | Auto vendor company moq |

    And Vendor go to Manage SKU price tab
    And Vendor choose region "North California Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName               | casePrice | msrpunit | availability | expectedDate |
      | North California Express | 1         | 1        | In Stock     | [blank]      |
    And Vendor choose region "South California Express" for SKU
    And Vendor input Region-Specific info of SKU
      | regionName               | casePrice | msrpunit | availability | expectedDate |
      | South California Express | 1         | 1        | In Stock     | [blank]      |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    #And Vendor go to "General" tab on SKU detail
    And Vendor go back to Manage SKU info tab
    And Vendor check "show" prop65 of SKU
      | type                                                                        | firstName | lastName | email                           | date        | company                 |
      | The referenced product does not contain any chemicals on the Prop. 65 List. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | Auto vendor company moq |
 #    And Vendor go to "Region-Specific" tab on SKU detail
    And Vendor go to Manage SKU price tab
    And Vendor inactive region "North California Express" of SKU
    And Vendor inactive region "South California Express" of SKU
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    #And Vendor go to "General" tab on SKU detail
    And Vendor go back to Manage SKU info tab
    And Vendor check "show" prop65 of SKU
      | type                                                                        | firstName | lastName | email                           | date        | company                 |
      | The referenced product does not contain any chemicals on the Prop. 65 List. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | Auto vendor company moq |

    And Switch to actor BAO_ADMIN3
    And Admin go back with button
    And Admin check SKU info on tab "draft"
      | skuName                   | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Auto vendor create sku199 | 123456789098 | [blank] | Draft  | 12 per case | not check | [blank] |
    And Admin go to SKU detail "Auto vendor create sku199"
    And Go to "General" tab
    And Admin check Prop65 info on general SKU
      | type                                                                       | firstName | lastName | email                           | date        |
      | The referenced product does not contain any chemicals on the Prop. 65 List | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate |

    And Switch to actor VENDOR
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Vendor go to Manage SKU price tab
    And Vendor inactive region "Pod Direct West" of SKU
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    #And Vendor go to "General" tab on SKU detail
    And Vendor go back to Manage SKU info tab
    And Vendor check "show" prop65 of SKU
      | type                                                                        | firstName | lastName | email                           | date        | company                 |
      | The referenced product does not contain any chemicals on the Prop. 65 List. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | Auto vendor company moq |

    And Switch to actor BAO_ADMIN3
    And Admin go back with button
    And Admin check SKU info on tab "draft"
      | skuName                   | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Auto vendor create sku199 | 123456789098 | [blank] | Draft  | 12 per case | not check | [blank] |
    And Admin go to SKU detail "Auto vendor create sku199"
    And Go to "General" tab
    And Admin check Prop65 info on general SKU
      | type                                                                       | firstName | lastName | email                           | date        |
      | The referenced product does not contain any chemicals on the Prop. 65 List | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate |
#    And Admin check have no Prop65 info on general SKU

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_202
  Scenario: Other cases with Prop 65 2
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product202 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product202"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku202 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"
    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability |
      | Chicagoland Express | 0         | 0        | Out of Stock |
#
#    And Vendor input Region-Specific info of SKU
#      | regionName          | casePrice | msrpunit | availability   | expectedDate |
#      | Chicagoland Express | 1         | 1        | Launching Soon | tomorrow     |

    And Vendor choose region "Pod Direct West" for SKU
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Vendor choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
    And Click on dialog button "Add"

    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West | 1         | 1        | In Stock     | [blank]      |
    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 1         | 1        | In Stock     |
    #And Vendor go to "General" tab on SKU detail
    And Vendor go back to Manage SKU info tab
    And Vendor check "show" prop65 of SKU
      | type                                                                        | firstName | lastName | email                           | date        | company                 |
      | The referenced product does not contain any chemicals on the Prop. 65 List. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | Auto vendor company moq |

    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                          | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto vendor create product202 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "Auto vendor create product202"
    And Admin check SKU info on tab "draft"
      | skuName                   | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Auto vendor create sku202 | 123456789098 | [blank] | Draft  | 12 per case | not check | PDW     |
    And Admin check SKU info on tab "draft"
      | skuName                   | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Auto vendor create sku202 | 123456789098 | [blank] | Draft  | 12 per case | not check | CHI     |
    And Admin go to SKU detail "Auto vendor create sku202"
    And Go to "General" tab
    And Admin check Prop65 info on general SKU
      | type                                                                       | firstName | lastName | email                           | date        |
      | The referenced product does not contain any chemicals on the Prop. 65 List | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate |

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_203
  Scenario: Other cases with Prop 65 3
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product203 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product203"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku203 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"

    And Vendor choose region "Pod Direct West" for SKU
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Vendor choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
    And Click on dialog button "Add"

    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West | 1         | 1        | In Stock     | [blank]      |

    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"

    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 1         | 1        | In Stock     | [blank]      |

#    And Vendor remove region of SKU
#      | Pod Direct West |
    And Vendor choose region "Pod Direct West" for SKU
    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability |
      | Chicagoland Express | 1         | 1        | In Stock     |
    #And Vendor go to "General" tab on SKU detail
    And Vendor go back to Manage SKU info tab
    And Vendor check "not show" prop65 of SKU
      | type                                                                        | firstName | lastName | email                           | date        | company                 |
      | The referenced product does not contain any chemicals on the Prop. 65 List. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | Auto vendor company moq |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_205
  Scenario: Other cases with Prop 65 4
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product205 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product205"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku205 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"

    And Vendor choose region "Pod Direct West" for SKU
    And Vendor check "show" content of Prop65
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Vendor choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 0         | 0        | In Stock     |
    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West | 1         | 1        | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor go back product detail
    And Vendor "Yes" duplicate with images of SKU "Auto vendor create sku205"
    And Vendor check SKU "show" on Draft SKUs
      | skuName                           | caseUnit | unitUPC | caseUPC |
      | Copy of Auto vendor create sku205 | [blank]  | [blank] | [blank] |
    And Vendor go to detail of SKU "Copy of Auto vendor create sku205"
    And Vendor check SKU general detail
      | skuName                           | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature |
      | Copy of Auto vendor create sku205 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20.0          | -12.0          |

    And Vendor check "not show" prop65 of SKU
      | type                                                                        | firstName | lastName | email                           | date        | company                 |
      | The referenced product does not contain any chemicals on the Prop. 65 List. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | Auto vendor company moq |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_206
  Scenario: Other cases with Prop 65 5
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product206 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product206"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku206 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"

    And Vendor choose region "Pod Direct West" for SKU
    And Vendor check "show" content of Prop65
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Vendor choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 0         | 0        | In Stock     |
    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West | 1         | 1        | In Stock     | [blank]      |
    And Vendor click "Save as a draft" new SKU
#    And Vendor Continue confirm publish SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor go back product detail
    And Vendor "Yes" duplicate with images of SKU "Auto vendor create sku206"
    And Vendor check SKU "show" on Draft SKUs
      | skuName                           | caseUnit | unitUPC | caseUPC |
      | Copy of Auto vendor create sku206 | [blank]  | [blank] | [blank] |
    And Vendor go to detail of SKU "Copy of Auto vendor create sku206"
    And Vendor check SKU general detail
      | skuName                           | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature |
      | Copy of Auto vendor create sku206 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20.0          | -12.0          |

    And Vendor check "not show" prop65 of SKU
      | type                                                                        | firstName | lastName | email                           | date        | company                 |
      | The referenced product does not contain any chemicals on the Prop. 65 List. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | Auto vendor company moq |

    And Vendor click "Publish" new SKU
    And Vendor check "show" content of Prop65

    And Vendor choose option "The referenced product contains one or more chemicals on the Prop. 65 List, as identified below." on Prop65
    And Vendor enter info of Prop65
      | firstName | lastName | email                           | companyName             | listAllChemicals | item                                                                                                                                                                                                                                                                                                                                                           | warning                                                        |
      | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | Auto vendor company moq | listAllChemicals | This product does not expose the user to chemical levels that exceed the No Significant Risk Level (NSRL) and/or Maximum Allowable Dose Level (MADL) established under Prop 65, or an alternative level established by California Courts (if established by California Courts, please email a copy of the applicable Consent Judgment to success@podfoods.co). | Shelf tag Prop. 65 warning label for display in retail stores. |
    And Click on dialog button "Add"
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully
    #And Vendor go to "General" tab on SKU detail
    And Vendor check "show" prop65 of SKU
      | type                                                                                             | firstName | lastName | email                           | date        | listAllChemicals | item                                                                                                                                                                                                                                                                                                                                                           | warning                                                        | company                 |
      | The referenced product contains one or more chemicals on the Prop. 65 List, as identified below. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | listAllChemicals | This product does not expose the user to chemical levels that exceed the No Significant Risk Level (NSRL) and/or Maximum Allowable Dose Level (MADL) established under Prop 65, or an alternative level established by California Courts (if established by California Courts, please email a copy of the applicable Consent Judgment to success@podfoods.co). | Shelf tag Prop. 65 warning label for display in retail stores. | Auto vendor company moq |

    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                          | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto vendor create product206 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "Auto vendor create product206"
    And Admin check SKU info on tab "active"
      | skuName                   | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Auto vendor create sku206 | 123456789098 | [blank] | Active | 12 per case | not check | PDW     |
    And Admin go to SKU detail "Auto vendor create sku206"
    And Go to "General" tab
    And Admin check Prop65 info on general SKU
      | type                                                                                             | firstName | lastName | email                           | date        | listAllChemicals | item                                                                                                                                                                                                                                                                                                                                                           | warning                                                        | company                 |
      | The referenced product contains one or more chemicals on the Prop. 65 List, as identified below. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | listAllChemicals | This product does not expose the user to chemical levels that exceed the No Significant Risk Level (NSRL) and/or Maximum Allowable Dose Level (MADL) established under Prop 65, or an alternative level established by California Courts (if established by California Courts, please email a copy of the applicable Consent Judgment to success@podfoods.co). | Shelf tag Prop. 65 warning label for display in retail stores. | Auto vendor company moq |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_207
  Scenario: Other cases with Prop 65 6
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product207 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product207"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku207 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"

    And Vendor choose region "Pod Direct West" for SKU
    And Vendor check "show" content of Prop65
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Vendor choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 0         | 0        | In Stock     |
    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West | 1         | 1        | In Stock     | [blank]      |

    And Vendor inactive region "Pod Direct West" of SKU
    And Vendor click "Save as a draft" new SKU
    And Wait for create SKU successfully

    And Vendor go back product detail
    And Vendor "Yes" duplicate with images of SKU "Auto vendor create sku207"
    And Vendor check SKU "show" on Draft SKUs
      | skuName                           | caseUnit | unitUPC | caseUPC |
      | Copy of Auto vendor create sku207 | [blank]  | [blank] | [blank] |
    And Vendor go to detail of SKU "Copy of Auto vendor create sku207"
    And Vendor check SKU general detail
      | skuName                           | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature |
      | Copy of Auto vendor create sku207 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20.0          | -12.0          |

    And Vendor check "not show" prop65 of SKU
      | type                                                                        | firstName | lastName | email                           | date        | company                 |
      | The referenced product does not contain any chemicals on the Prop. 65 List. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | Auto vendor company moq |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Vendor go to Manage SKU price tab
    And Vendor active region "Pod Direct West" of SKU
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Vendor choose option "The referenced product contains one or more chemicals on the Prop. 65 List, as identified below." on Prop65
    And Vendor enter info of Prop65
      | firstName | lastName | email                           | companyName             | listAllChemicals | item                                                                                                                                                                                                                                                                                                                                                           | warning                                                        |
      | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | Auto vendor company moq | listAllChemicals | This product does not expose the user to chemical levels that exceed the No Significant Risk Level (NSRL) and/or Maximum Allowable Dose Level (MADL) established under Prop 65, or an alternative level established by California Courts (if established by California Courts, please email a copy of the applicable Consent Judgment to success@podfoods.co). | Shelf tag Prop. 65 warning label for display in retail stores. |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West | 1         | 1        | In Stock     | [blank]      |

    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully
    And Vendor check "show" prop65 of SKU
      | type                                                                                             | firstName | lastName | email                           | date        | listAllChemicals | item                                                                                                                                                                                                                                                                                                                                                           | warning                                                        | company                 |
      | The referenced product contains one or more chemicals on the Prop. 65 List, as identified below. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | listAllChemicals | This product does not expose the user to chemical levels that exceed the No Significant Risk Level (NSRL) and/or Maximum Allowable Dose Level (MADL) established under Prop 65, or an alternative level established by California Courts (if established by California Courts, please email a copy of the applicable Consent Judgment to success@podfoods.co). | Shelf tag Prop. 65 warning label for display in retail stores. | Auto vendor company moq |

    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                          | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto vendor create product207 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "Auto vendor create product207"
    And Admin check SKU info on tab "active"
      | skuName                           | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Copy of Auto vendor create sku207 | 123456789098 | [blank] | Active | 12 per case | not check | PDW     |
    And Admin go to SKU detail "Copy of Auto vendor create sku207"
    And Go to "General" tab
    And Admin check Prop65 info on general SKU
      | type                                                                                             | firstName | lastName | email                           | date        | listAllChemicals | item                                                                                                                                                                                                                                                                                                                                                           | warning                                                        | company                 |
      | The referenced product contains one or more chemicals on the Prop. 65 List, as identified below. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | listAllChemicals | This product does not expose the user to chemical levels that exceed the No Significant Risk Level (NSRL) and/or Maximum Allowable Dose Level (MADL) established under Prop 65, or an alternative level established by California Courts (if established by California Courts, please email a copy of the applicable Consent Judgment to success@podfoods.co). | Shelf tag Prop. 65 warning label for display in retail stores. | Auto vendor company moq |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_Create_new_SKU @VENDOR_PRODUCTS_208
  Scenario: Other cases with Prop 65 7
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product208 | 3086     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product208"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku208 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"

    And Vendor choose region "Pod Direct West" for SKU
    And Vendor check "show" content of Prop65
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Vendor choose option "The referenced product does not contain any chemicals on the Prop. 65 List" on Prop65
    And Click on dialog button "Add"
    And Vendor check Region-Specific of SKU
      | regionName      | casePrice | msrpUnit | availability |
      | Pod Direct West | 0         | 0        | In Stock     |
    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct West | 1         | 1        | In Stock     | [blank]      |

    And Vendor inactive region "Pod Direct West" of SKU
    And Vendor click "Save as a draft" new SKU
    And Wait for create SKU successfully

    And Vendor go back product detail
    And Vendor "Yes" duplicate with images of SKU "Auto vendor create sku208"
    And Vendor check SKU "show" on Draft SKUs
      | skuName                           | caseUnit | unitUPC | caseUPC |
      | Copy of Auto vendor create sku208 | [blank]  | [blank] | [blank] |
    And Vendor go to detail of SKU "Copy of Auto vendor create sku208"
    And Vendor check SKU general detail
      | skuName                           | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature |
      | Copy of Auto vendor create sku208 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20.0          | -12.0          |

    And Vendor check "not show" prop65 of SKU
      | type                                                                        | firstName | lastName | email                           | date        | company                 |
      | The referenced product does not contain any chemicals on the Prop. 65 List. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | Auto vendor company moq |
    And Vendor go to Manage SKU price tab
    And Vendor choose region "North California Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |

    And Vendor choose option "The referenced product contains one or more chemicals on the Prop. 65 List, as identified below." on Prop65
    And Vendor enter info of Prop65
      | firstName | lastName | email                           | companyName             | listAllChemicals | item                                                                                                                                                                                                                                                                                                                                                           | warning                                                        |
      | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | Auto vendor company moq | listAllChemicals | This product does not expose the user to chemical levels that exceed the No Significant Risk Level (NSRL) and/or Maximum Allowable Dose Level (MADL) established under Prop 65, or an alternative level established by California Courts (if established by California Courts, please email a copy of the applicable Consent Judgment to success@podfoods.co). | Shelf tag Prop. 65 warning label for display in retail stores. |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName               | casePrice | msrpunit | availability | expectedDate |
      | North California Express | 1         | 1        | In Stock     | [blank]      |

    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
#
    And Wait for update SKU successfully
    #And Vendor go to "General" tab on SKU detail
    And Vendor check "show" prop65 of SKU
      | type                                                                                             | firstName | lastName | email                           | date        | listAllChemicals | item                                                                                                                                                                                                                                                                                                                                                           | warning                                                        | company                 |
      | The referenced product contains one or more chemicals on the Prop. 65 List, as identified below. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | listAllChemicals | This product does not expose the user to chemical levels that exceed the No Significant Risk Level (NSRL) and/or Maximum Allowable Dose Level (MADL) established under Prop 65, or an alternative level established by California Courts (if established by California Courts, please email a copy of the applicable Consent Judgment to success@podfoods.co). | Shelf tag Prop. 65 warning label for display in retail stores. | Auto vendor company moq |

    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                          | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto vendor create product208 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "Auto vendor create product208"
    And Admin check SKU info on tab "active"
      | skuName                           | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Copy of Auto vendor create sku208 | 123456789098 | [blank] | Active | 12 per case | not check | SF      |
    And Admin go to SKU detail "Copy of Auto vendor create sku208"
    And Go to "General" tab
    And Admin check Prop65 info on general SKU
      | type                                                                                             | firstName | lastName | email                           | date        | listAllChemicals | item                                                                                                                                                                                                                                                                                                                                                           | warning                                                        | company                 |
      | The referenced product contains one or more chemicals on the Prop. 65 List, as identified below. | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | currentDate | listAllChemicals | This product does not expose the user to chemical levels that exceed the No Significant Risk Level (NSRL) and/or Maximum Allowable Dose Level (MADL) established under Prop 65, or an alternative level established by California Courts (if established by California Courts, please email a copy of the applicable Consent Judgment to success@podfoods.co). | Shelf tag Prop. 65 warning label for display in retail stores. | Auto vendor company moq |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_211
  Scenario: Check display of Published SKU detail
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product211 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor56@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product211"

    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    And Vendor check SKU general detail
      | skuName    | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature |
      | sku random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | [blank]        | [blank]        |
    And Vendor check value of field on SKU detail
      | field                     | value                 |
      | Storage shelf life (days) | 1                     |
      | Storage condition         | Dry (No temp control) |
      | Retail shelf life (days)  | 1                     |
      | Retail condition          | Dry (No temp control) |
    And Vendor check Qualities of SKU
      | 100% Natural |
    And Vendor check status of field
      | field         | status   |
      | Units/case    | disabled |
      | Barcodes Type | disabled |
      | Unit UPC      | disabled |
      | Case UPC      | disabled |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability |
      | Chicagoland Express | 10        | 10       | In Stock     |

  @VENDOR_PRODUCTS_212
  Scenario: Check display of Draft SKU detail
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product212 | 3087     |
    And Info of Region
      | region                   | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express      | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
      | New York Express         | 53 | active | sold_out     | 2000      | 2000 | [blank]      |
#      | Pod Direct Southeast           | 59 | active | coming_soon  | 3000      | 3000 | Plus1        |
      | Pod Direct Central       | 58 | active | in_stock     | 1000      | 1000 | [blank]      |
      | Pod Direct East          | 55 | active | sold_out     | 2000      | 2000 | [blank]      |
#      | Mid Atlantic Express           | 62 | active | coming_soon  | 3000      | 3000 | Plus1        |
      | Florida Express          | 63 | active | in_stock     | 1000      | 1000 | [blank]      |
#      | Pod Direct Southwest & Rockies | 60 | active | sold_out     | 2000      | 2000 | [blank]      |
#      | Dallas Express                  | 61 | active | coming_soon  | 3000      | 3000 | Plus1        |
      | Pod Direct West          | 54 | active | in_stock     | 1000      | 1000 | [blank]      |
      | North California Express | 25 | active | sold_out     | 2000      | 2000 | [blank]      |
#      | South California Express       | 51 | active | coming_soon  | 3000      | 3000 | Plus1        |
    And Admin create a "draft" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor56@podfoods.co" pass "12345678a" role "vendor"

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product212"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    And Vendor check SKU general detail
      | skuName    | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature |
      | sku random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | 1.0            | 1.0            |
    And Vendor check value of field on SKU detail
      | field                     | value                 |
      | Storage shelf life (days) | 1                     |
      | Storage condition         | Dry (No temp control) |
      | Retail shelf life (days)  | 1                     |
      | Retail condition          | Dry (No temp control) |
    And Vendor check Qualities of SKU
      | 100% Natural |
    And Vendor check status of field
      | field         | status |
      | Units/case    | enable |
      | Barcodes Type | enable |
      | Unit UPC      | enable |
      | Case UPC      | enable |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express      | 10        | 10       | In Stock     | [blank]  |
      | New York Express         | 20        | 20       | Out of Stock | [blank]  |
#      | Pod Direct Southeast           | 30        | 30       | Launching Soon | Plus1    |
      | Pod Direct Central       | 10        | 10       | In Stock     | [blank]  |
      | Pod Direct East          | 20        | 20       | Out of Stock | [blank]  |
#      | Mid Atlantic Express           | 30        | 30       | Launching Soon | Plus1    |
      | Florida Express          | 10        | 10       | In Stock     | [blank]  |
#      | Pod Direct Southwest & Rockies | 20        | 20       | Out of Stock | [blank]  |
#      | Dallas Express                  | 30        | 30       | Launching Soon | Plus1    |
      | Pod Direct West          | 10        | 10       | In Stock     | [blank]  |
      | North California Express | 20        | 20       | Out of Stock | [blank]  |
#      | South California Express       | 30        | 30       | Launching Soon | Plus1    |

  @VENDOR_PRODUCTS_186
  Scenario: Check when selecting Storage condition
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product215 | 3087     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor56@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product215"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku215 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -21                | -10                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor check message is showing of fields when create product
      | field               | message                                                      |
      | Min temperature (F) | Please enter a valid range to a storage shelf life condition |
      | Max temperature (F) | Please enter a valid range to a storage shelf life condition |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition           | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | Refrigerated (33°F ~ 41°F) | [blank]         | [blank]         | 32                 | 42                 | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor click "Next" new SKU
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field               | message                                                      |
      | Min temperature (F) | Please enter a valid range to a storage shelf life condition |
      | Max temperature (F) | Please enter a valid range to a storage shelf life condition |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition      | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | Frozen (-10°F ~ 32°F) | [blank]         | [blank]         | -11                | 33                 | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor click "Next" new SKU
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU

    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field               | message                                                      |
      | Min temperature (F) | Please enter a valid range to a storage shelf life condition |
      | Max temperature (F) | Please enter a valid range to a storage shelf life condition |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition      | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | Dry (No temp control) | [blank]         | [blank]         | -21                | -12                | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    And Vendor click "Next" new SKU
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Validation failed: Region specific or store specific or buyer company specific must be present |

  @VENDOR_PRODUCTS_215
  Scenario: Edit Published SKU - General tab
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product215 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
      | New York Express    | 53 | active | sold_out     | 2000      | 2000 | [blank]      |
#      | Pod Direct Southeast | 59 | active | coming_soon  | 3000      | 3000 | Plus1        |
    And Admin create a "draft" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor56@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product215"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku215 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully
    And Vendor go back product detail
    And Vendor go to detail of SKU "Auto vendor create sku215"
    And Vendor check SKU general detail
      | skuName                   | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature |
      | Auto vendor create sku215 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20.0          | -12.0          |
#    Check field "Name"
    And Vendor Clear field "Name" when create product
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field | message                    |
      | Name  | This field cannot be blank |
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku215 | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
#    Check field "Ingredients"
    And Vendor Clear field "Ingredients" when create product
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field       | message                    |
      | Ingredients | This field cannot be blank |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient                             | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | Sodium Laureth Sulfate,Hexylene Glycol | [blank]  | [blank]     | [blank]        |
#    Check field "Description"
    And Vendor Clear field "Description" when create product
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field       | message                    |
      | Description | This field cannot be blank |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | abc         | [blank]        |
#    Check field "Lead time"
    And Vendor Clear field "Lead time" when create product
    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully
    And Vendor check SKU general detail
      | skuName                   | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature |
      | Auto vendor create sku215 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | [blank]  | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20.0          | -12.0          |
    #    Check field "City"
    And Vendor Clear field "City" when create product
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field | message                    |
      | City  | This field cannot be blank |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | Canada  | a    | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
  #    Check field "State (Province/Territory)"
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field                      | message                    |
      | State (Province/Territory) | This field cannot be blank |
    And Vendor input invalid "State (Province/Territory)"
      | value |
      | abc   |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field                      | message                    |
      | State (Province/Territory) | This field cannot be blank |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country       | city | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | United States | a    | New York         | [blank]    | [blank]  | [blank]     | [blank]        |
  #    Check field Storage
    And Vendor edit field on SKU detail
      | field                     | value |
      | Storage shelf life (days) | 0     |
    And Vendor check message is showing of fields when create product
      | field                     | message                                  |
      | Storage shelf life (days) | Value must be greater than or equal to 1 |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor edit field on SKU detail
      | field                     | value |
      | Storage shelf life (days) | -1    |
    And Vendor check message is showing of fields when create product
      | field                     | message                                  |
      | Storage shelf life (days) | Value must be greater than or equal to 1 |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor edit field on SKU detail
      | field                     | value |
      | Storage shelf life (days) | e     |
    And Vendor check message is showing of fields when create product
      | field                     | message                    |
      | Storage shelf life (days) | This field cannot be blank |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor edit field on SKU detail
      | field                     | value |
      | Storage shelf life (days) | 30    |
    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully
 #    Check field Storage Retail
    And Vendor edit field on SKU detail
      | field                    | value |
      | Retail shelf life (days) | 0     |
    And Vendor check message is showing of fields when create product
      | field                    | message                                  |
      | Retail shelf life (days) | Value must be greater than or equal to 1 |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor edit field on SKU detail
      | field                    | value |
      | Retail shelf life (days) | -1    |
    And Vendor check message is showing of fields when create product
      | field                    | message                                  |
      | Retail shelf life (days) | Value must be greater than or equal to 1 |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor edit field on SKU detail
      | field                    | value |
      | Retail shelf life (days) | e     |
    And Vendor check message is showing of fields when create product
      | field                    | message                    |
      | Retail shelf life (days) | This field cannot be blank |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor edit field on SKU detail
      | field                    | value |
      | Retail shelf life (days) | 10    |
    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully
    And Vendor increase field number tooltip 1 times
      | field                    | text |
      | Retail shelf life (days) | 11   |
    And Vendor decrease field number tooltip 1 times
      | field                    | text |
      | Retail shelf life (days) | 10   |
    And Vendor increase field number tooltip 1 times
      | field                     | text |
      | Storage shelf life (days) | 31   |
    And Vendor decrease field number tooltip 1 times
      | field                     | text |
      | Storage shelf life (days) | 30   |
    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | country | city     | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | Frozen (-10°F ~ 32°F) | [blank]            | [blank]            | Canada  | New York | Manitoba         | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition           | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | Refrigerated (33°F ~ 41°F) | [blank]         | [blank]         | 33                 | 41                 | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully
    And Vendor edit field on SKU detail
      | field               | value |
      | Min temperature (F) | 0     |
    And Vendor edit field on SKU detail
      | field               | value |
      | Max temperature (F) | 0     |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Validation failed: The temperature must between 33 and 41 |

    And Vendor check value of field on SKU detail
      | field               | value   |
      | Max temperature (F) | [blank] |
    And Vendor increase field number tooltip 1 times
      | field               | text |
      | Max temperature (F) | 0.1  |
    And Vendor decrease field number tooltip 1 times
      | field               | text |
      | Max temperature (F) | 0    |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Validation failed: The temperature must between 33 and 41 |
    And Vendor increase field number tooltip 1 times
      | field               | text |
      | Max temperature (F) | 0.1  |
    And Vendor increase field number tooltip 1 times
      | field               | text |
      | Min temperature (F) | 0.1  |
    And Vendor check message is showing of fields when create product
      | field               | message                                                      |
      | Min temperature (F) | Please enter a valid range to a storage shelf life condition |
      | Max temperature (F) | Please enter a valid range to a storage shelf life condition |
    And Vendor edit field on SKU detail
      | field               | value |
      | Min temperature (F) | 33    |
    And Vendor edit field on SKU detail
      | field               | value |
      | Max temperature (F) | 41    |
    And Vendor check value of field on SKU detail
      | field               | value |
      | Min temperature (F) | 33    |
    And Vendor edit field on SKU detail
      | field               | value |
      | Max temperature (F) | 41    |
    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully

    And Vendor check SKU general detail
      | skuName                   | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country | city     | state    | storage | retail | minTemperature | maxTemperature |
      | Auto vendor create sku215 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | [blank]  | 12       | 123456789098 | 123456789098 | Canada  | New York | Manitoba | 30      | 10     | 33.0           | 41.0           |
    And Vendor check value of field on SKU detail
      | field                     | value                      |
      | Storage shelf life (days) | 30                         |
      | Storage condition         | Refrigerated (33°F ~ 41°F) |
      | Retail shelf life (days)  | 10                         |
      | Retail condition          | Frozen (-10°F ~ 32°F)      |

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product215"
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Published SKUs
      | skuName                   | caseUnit | unitUPC      | caseUPC      |
      | Auto vendor create sku215 | 12       | 123456789098 | 123456789098 |
    And Vendor go to detail of SKU "Auto vendor create sku215"
    And Vendor check SKU general detail
      | skuName                   | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country | city     | state    | storage | retail | minTemperature | maxTemperature |
      | Auto vendor create sku215 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | [blank]  | 12       | 123456789098 | 123456789098 | Canada  | New York | Manitoba | 30      | 10     | 33.0           | 41.0           |
#Check on Admin
    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                          | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto vendor create product215 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "Auto vendor create product215"
    And Admin check SKU info on tab "active"
      | skuName                   | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Auto vendor create sku215 | 123456789098 | [blank] | Active | 12 per case | not check | CHI     |
    And Admin go to SKU detail "Auto vendor create sku215"

    And Admin check general info of SKU
      | skuName                   | state  | itemCode  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | Auto vendor create sku215 | Active | not check | Yes     | 12        | 123456789098      | no                    | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Refrigerated     | 10              | Frozen          | 33.0               | 41.0               | New York | Manitoba         | Sodium Laureth Sulfate, Hexylene Glycol | [blank]  | abc         | 100                |
    And check Nutrition info of SKU
      | nutritionLabel | nutritionLabelDescription |
      | anhJPEG        | [blank]                   |
    And check qualities info of SKU
      | 100% Natural |
#Check on Buyer
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku215"
    And Search item and go to detail of first result
      | item                      | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create sku215 | Auto vendor create product215 | Auto Brand product mov | $0.83        | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack          |
      | 123456789098 | 92%         | $10.00 | [blank]      | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage              | retail         | ingredients                             |
      | New York, Manitoba | 30 days Refrigerated | 10 days Frozen | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | 100% Natural |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_216
  Scenario: Edit published SKU General tab validate images field
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product216 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product216"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
#    And Vendor go to create a new SKU
#    And Vendor set is main SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku216 | [blank]   | [blank]           | 10MBgreater.jpg | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage      | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid.mp4 | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage      | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid.mp4 | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage       | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid1.pdf | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage        | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid2.xlsx | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage       | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid3.xls | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage       | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid4.csv | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage     | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | masterImage.jpg | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |

    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage    | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku132 | [blank]   | [blank]           | [blank]     | [blank] | 10MBgreater.jpg | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage     | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid.mp4 | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage     | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid.mp4 | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage      | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid1.pdf | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage       | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid2.xlsx | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage      | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid3.xls | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage      | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid4.csv | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | UPCImage.png | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |

    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage    | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku132 | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | 10MBgreater.jpg | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage     | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid.mp4 | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage     | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid.mp4 | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid1.pdf | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage       | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid2.xlsx | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid3.xls | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid4.csv | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | CaseImage.png | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor upload "UPC" image for new SKU
      | image           | masterCarton |
      | 10MBgreater.jpg | 123          |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor upload "UPC" image for new SKU
      | image             | masterCarton      |
      | ImageInvalid4.csv | Invalid file type |
    And Vendor click "Publish" new SKU
#    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_236
  Scenario: Edit published SKU General tab Nutrition Labels
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product236 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product236"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
      | Nut-Free     |
    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully

    And and product qualities
      | Gluten-Free |
      | Nut-Free    |
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku random"
    And with Qualities
      | Gluten-Free |
      | Nut-Free    |
    And Vendor delete nutrition labels number 1
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Validation failed: Nutrition labels must have at least one image and not more than three |
    And Vendor add nutrition labels of SKU
      | image   | description |
      | [blank] | [blank]     |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Validation failed: Nutrition labels attachment can't be blank |
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku random"
#    And Vendor check Nutrition info of SKU
#      | nutritionLabel | description |
#      | anhJPG2.jpg    | [blank]     |
    And Vendor delete nutrition labels number 1
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    And Vendor click "Publish" new SKU
#    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully
    And Vendor check Nutrition info of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku random"
    And Vendor check Nutrition info of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    And Vendor add nutrition labels of SKU
      | image       | description |
      | anhJPEG.jpg | abc         |
      | anhJPEG.jpg | [blank]     |
#    And Check button "Add new" is disable
    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully
    And Vendor check Nutrition info of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
      | anhJPEG.jpg        | abc         |
      | anhJPEG.jpg        | [blank]     |
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku random"
    And Vendor check Nutrition info of SKU
      | image              | description |
      | anhJPEG.jpg        | [blank]     |
      | anhJPEG.jpg        | abc         |
      | nutritionImage.jpg | bcd         |

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_237
  Scenario: Edit published SKU Region tab
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product237 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product237"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |
    And Check field "Wholesale price/CASE" is disabled
    And Vendor edit field on SKU detail
      | field     | value   |
      | MSRP/unit | [blank] |
    And Vendor check message is showing of fields when create product
      | field     | message                    |
      | MSRP/unit | This field cannot be blank |
    And Vendor edit field on SKU detail
      | field     | value |
      | MSRP/unit | -1    |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor edit field on SKU detail
      | field     | value |
      | MSRP/unit | e     |
    And Vendor check message is showing of fields when create product
      | field     | message                    |
      | MSRP/unit | This field cannot be blank |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor decrease field number tooltip 1 times
      | field     | text  |
      | MSRP/unit | -0.01 |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor increase field number tooltip 1 times
      | field     | text |
      | MSRP/unit | 0    |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor edit field on SKU detail
      | field     | value     |
      | MSRP/unit | 123456789 |
    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | 12345678900 is out of range for ActiveModel::Type::Integer with limit 4 bytes |
#    And Vendor go back product detail
#    And Vendor go to detail of SKU "sku random"
#    #    And Vendor go to "Region-Specific" tab on SKU detail
#    And Vendor go to Manage SKU price tab
#    And Vendor check Region-Specific of SKU
#      | regionName          | casePrice | msrpUnit | availability | arriving |
#      | Chicagoland Express | 10        | 10        | In Stock     | [blank]  |
    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | [blank]   | 1        | Out of Stock | [blank]      |
    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully
#    And Vendor input Region-Specific info of SKU
#      | regionName          | casePrice | msrpunit | availability   | expectedDate |
#      | Chicagoland Express | [blank]   | [blank]  | Launching Soon | [blank]      |
#    And Vendor check alert message after 60 seconds
#      And Wait for update SKU successfully
#    And Vendor input Region-Specific info of SKU
#      | regionName          | casePrice | msrpunit | availability   | expectedDate |
#      | Chicagoland Express | [blank]   | [blank]  | Launching Soon | Plus1        |
#    And Vendor click "Publish" new SKU
#    And Vendor check alert message after 60 seconds
#      And Wait for update SKU successfully
    And Vendor go back to Manage SKU info tab
#    And Vendor go to detail of SKU "sku random"
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability |
      | Chicagoland Express | 10        | 1        | Out of Stock |

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_242
  Scenario: Edit published SKU Region tab prop65
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product242 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product242"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |

    And Vendor choose region "Florida Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Florida Express | 10        | 10       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |
      | Florida Express     | 10        | 10       | In Stock     | [blank]  |
    And Vendor choose region "Pod Direct Central" for SKU
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName         | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct Central | 10        | 10       | In Stock     | [blank]      |
    And Vendor choose region "North California Express" for SKU
    And Vendor choose option "The referenced product contains one or more chemicals on the Prop. 65 List, as identified below." on Prop65
    And Vendor enter info of Prop65
      | firstName | lastName | email                           | companyName             | listAllChemicals | item                                                                                                                                                                                                                                                                                                                                                           | warning                                                        |
      | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | Auto vendor company moq | listAllChemicals | This product does not expose the user to chemical levels that exceed the No Significant Risk Level (NSRL) and/or Maximum Allowable Dose Level (MADL) established under Prop 65, or an alternative level established by California Courts (if established by California Courts, please email a copy of the applicable Consent Judgment to success@podfoods.co). | Shelf tag Prop. 65 warning label for display in retail stores. |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName               | casePrice | msrpunit | availability | expectedDate |
      | North California Express | 10        | 10       | In Stock     | [blank]      |

    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express      | 10        | 10       | In Stock     | [blank]  |
      | Florida Express          | 10        | 10       | In Stock     | [blank]  |
      | Pod Direct Central       | 10        | 10       | In Stock     | [blank]  |
      | North California Express | 10        | 10       | In Stock     | [blank]  |

  @VENDOR_PRODUCTS_244
  Scenario: Edit Draft SKU - General tab
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product244 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
      | New York Express    | 53 | active | sold_out     | 2000      | 2000 | [blank]      |
      | Pod Direct East     | 55 | active | coming_soon  | 3000      | 3000 | Plus1        |
    And Admin create a "draft" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor56@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product244"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku244 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor go back product detail
    And Vendor go to detail of SKU "Auto vendor create sku244"
    And Vendor check SKU general detail
      | skuName                   | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature |
      | Auto vendor create sku244 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20.0          | -12.0          |
    And Vendor Clear field "Name" when create product
    And Vendor click "Save as a draft" new SKU
    And Vendor check message is showing of fields when create product
      | field | message                    |
      | Name  | This field cannot be blank |
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku244 | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor Clear field "Ingredients" when create product
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor Clear field "Description" when create product
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor Clear field "Lead time" when create product
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

#    Đang bug
#    And Vendor Clear field "Units/case" when create product
#    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      And Wait for update SKU successfully

    And Vendor Clear field "City" when create product
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    And Vendor input invalid "State (Province/Territory)"
      | value |
      | abc   |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    And Vendor edit field on SKU detail
      | field                     | value |
      | Storage shelf life (days) | 0     |
    And Vendor check message is showing of fields when create product
      | field                     | message                                  |
      | Storage shelf life (days) | Value must be greater than or equal to 1 |
    And Vendor edit field on SKU detail
      | field                     | value |
      | Storage shelf life (days) | -1    |
    And Vendor check message is showing of fields when create product
      | field                     | message                                  |
      | Storage shelf life (days) | Value must be greater than or equal to 1 |
    And Vendor edit field on SKU detail
      | field                     | value |
      | Storage shelf life (days) | a     |
    And Vendor check message is showing of fields when create product
      | field                     | message                    |
      | Storage shelf life (days) | This field cannot be blank |
    And Vendor edit field on SKU detail
      | field                     | value |
      | Storage shelf life (days) | 30    |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    And Vendor edit field on SKU detail
      | field                    | value |
      | Retail shelf life (days) | 0     |
    And Vendor check message is showing of fields when create product
      | field                    | message                                  |
      | Retail shelf life (days) | Value must be greater than or equal to 1 |
    And Vendor edit field on SKU detail
      | field                    | value |
      | Retail shelf life (days) | -1    |
    And Vendor check message is showing of fields when create product
      | field                    | message                                  |
      | Retail shelf life (days) | Value must be greater than or equal to 1 |
    And Vendor edit field on SKU detail
      | field                    | value |
      | Retail shelf life (days) | e     |
    And Vendor check message is showing of fields when create product
      | field                    | message                    |
      | Retail shelf life (days) | This field cannot be blank |
    And Vendor edit field on SKU detail
      | field                    | value |
      | Retail shelf life (days) | 10    |

    And Vendor increase field number tooltip 1 times
      | field                    | text |
      | Retail shelf life (days) | 11   |
    And Vendor decrease field number tooltip 1 times
      | field                    | text |
      | Retail shelf life (days) | 10   |
    And Vendor increase field number tooltip 1 times
      | field                     | text |
      | Storage shelf life (days) | 31   |
    And Vendor decrease field number tooltip 1 times
      | field                     | text |
      | Storage shelf life (days) | 30   |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | Frozen (-10°F ~ 32°F) | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition           | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | Refrigerated (33°F ~ 41°F) | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor edit field on SKU detail
      | field               | value |
      | Min temperature (F) | -1    |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor edit field on SKU detail
      | field               | value |
      | Min temperature (F) | a     |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor check value of field on SKU detail
      | field               | value   |
      | Min temperature (F) | [blank] |
    And Vendor increase field number tooltip 1 times
      | field               | text |
      | Min temperature (F) | 0.1  |
    And Vendor decrease field number tooltip 1 times
      | field               | text |
      | Min temperature (F) | 0    |

    And Vendor check value of field on SKU detail
      | field               | value |
      | Min temperature (F) | 0     |
    And Vendor edit field on SKU detail
      | field               | value |
      | Min temperature (F) | 34    |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor edit field on SKU detail
      | field               | value |
      | Max temperature (F) | -1    |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor edit field on SKU detail
      | field               | value |
      | Max temperature (F) | a     |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor check value of field on SKU detail
      | field               | value   |
      | Max temperature (F) | [blank] |
    And Vendor increase field number tooltip 1 times
      | field               | text |
      | Max temperature (F) | 0.1  |
    And Vendor decrease field number tooltip 1 times
      | field               | text |
      | Max temperature (F) | 0    |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor check value of field on SKU detail
      | field               | value |
      | Max temperature (F) | 0     |
    And Vendor edit field on SKU detail
      | field               | value |
      | Max temperature (F) | 40    |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor click "Publish" new SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field       | message                    |
      | Ingredients | This field cannot be blank |
      | Description | This field cannot be blank |
      | City        | This field cannot be blank |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city | stateManufacture | ingredient                             | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | a    | [blank]          | Sodium Laureth Sulfate,Hexylene Glycol | [blank]  | abc         | [blank]        |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

    And Vendor check SKU general detail
      | skuName                   | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city | state    | storage | retail | minTemperature | maxTemperature |
      | Auto vendor create sku244 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | [blank]  | 12       | 123456789098 | 123456789098 | United States | a    | New York | 30      | 10     | 34.0           | 40.0           |
    And Vendor check value of field on SKU detail
      | field                     | value                      |
      | Storage shelf life (days) | 30                         |
      | Storage condition         | Refrigerated (33°F ~ 41°F) |
      | Retail shelf life (days)  | 10                         |
      | Retail condition          | Frozen (-10°F ~ 32°F)      |

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product244"
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Published SKUs
      | skuName                   | caseUnit | unitUPC      | caseUPC      |
      | Auto vendor create sku244 | 12       | 123456789098 | 123456789098 |
    And Vendor go to detail of SKU "Auto vendor create sku244"
    And Vendor check SKU general detail
      | skuName                   | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city | state    | storage | retail | minTemperature | maxTemperature |
      | Auto vendor create sku244 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | [blank]  | 12       | 123456789098 | 123456789098 | United States | a    | New York | 30      | 10     | 34.0           | 40.0           |
#Check on Admin
    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                          | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto vendor create product244 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "Auto vendor create product244"
    And Admin check SKU info on tab "active"
      | skuName                   | unitUpc      | caseUpc | status | unitPerCase | codeSKU   | regions |
      | Auto vendor create sku244 | 123456789098 | [blank] | Active | 12 per case | not check | CHI     |
    And Admin go to SKU detail "Auto vendor create sku244"

    And Admin check general info of SKU
      | skuName                   | state  | itemCode  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | Auto vendor create sku244 | Active | not check | Yes     | 12        | 123456789098      | no                    | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Refrigerated     | 10              | Frozen          | 34.0               | 40.0               | a    | New York         | Sodium Laureth Sulfate, Hexylene Glycol | [blank]  | abc         | 100                |
    And check Nutrition info of SKU
      | nutritionLabel | nutritionLabelDescription |
      | anhJPEG        | [blank]                   |
    And check qualities info of SKU
      | 100% Natural |
#Check on Buyer
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create sku244"
    And Search item and go to detail of first result
      | item                      | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create sku244 | Auto vendor create product244 | Auto Brand product mov | $0.83        | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack          |
      | 123456789098 | 92%         | $10.00 | [blank]      | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 12 units per case |
    And and check details information
      | brandLocation | storage              | retail         | ingredients                             |
      | a, New York   | 30 days Refrigerated | 10 days Frozen | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | 100% Natural |

    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_246
  Scenario: Edit draft SKU General tab validate images field
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product246 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "draft" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product246"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
#    And Vendor go to create a new SKU
#    And Vendor set is main SKU
    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage     | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku246 | [blank]   | [blank]           | 10MBgreater.jpg | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage      | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid.mp4 | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage      | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid.mp4 | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage       | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid1.pdf | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage        | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid2.xlsx | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage       | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid3.xls | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage       | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | ImageInvalid4.csv | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage     | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | masterImage.jpg | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |

    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage    | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku132 | [blank]   | [blank]           | [blank]     | [blank] | 10MBgreater.jpg | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage     | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid.mp4 | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage     | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid.mp4 | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage      | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid1.pdf | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage       | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid2.xlsx | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage      | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid3.xls | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage      | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | ImageInvalid4.csv | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | UPCImage.png | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |

    And Vendor input info new SKU
      | skuName                   | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage    | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku246 | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | 10MBgreater.jpg | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage     | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid.mp4 | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage     | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid.mp4 | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid1.pdf | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage       | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid2.xlsx | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid3.xls | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage      | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | ImageInvalid4.csv | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor check alert message
      | Invalid file type |
    And Vendor input info new SKU
      | skuName | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | [blank] | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | CaseImage.png | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |

    And Vendor upload "UPC" image for new SKU
      | image           | masterCarton |
      | 10MBgreater.jpg | 123          |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor upload "UPC" image for new SKU
      | image             | masterCarton      |
      | ImageInvalid4.csv | Invalid file type |
    And Vendor change Barcodes type of SKU to EAN
    And Vendor upload "EAN" image for new SKU
      | image           | masterCarton |
      | 10MBgreater.jpg | 123          |
    And Vendor check alert message
      | Maximum file size exceeded |
    And Vendor upload "EAN" image for new SKU
      | image             | masterCarton      |
      | ImageInvalid4.csv | Invalid file type |

    And Vendor click "Save as a draft" new SKU

#    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_288
  Scenario: Edit draft SKU General tab Nutrition Labels
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product288 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "draft" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product288"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
      | Nut-Free     |
    And Vendor click "Save as a draft" new SKU
#    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully
    And and product qualities
      | Gluten-Free |
      | Nut-Free    |
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku random"
    And with Qualities
      | Gluten-Free |
      | Nut-Free    |
    And Vendor delete nutrition labels number 1
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor add nutrition labels of SKU
      | image   | description |
      | [blank] | [blank]     |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku random"
    And Vendor check Nutrition info of SKU
      | image            | description |
      | no_img_large.png | [blank]     |
    And Vendor delete nutrition labels number 1
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor check Nutrition info of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku random"
    And Vendor check Nutrition info of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    And Vendor add nutrition labels of SKU
      | image       | description |
      | anhJPEG.jpg | abc         |
      | anhJPEG.jpg | [blank]     |
#    And Check button "Add new" is disable
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    And Vendor check Nutrition info of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
      | anhJPEG.jpg        | abc         |
      | anhJPEG.jpg        | [blank]     |
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku random"
    And Vendor check Nutrition info of SKU
      | image              | description |
      | anhJPEG.jpg        | [blank]     |
      | anhJPEG.jpg        | abc         |
      | nutritionImage.jpg | bcd         |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_290
  Scenario: Edit draft SKU Region tab
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product290 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "draft" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product290"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    #    And Vendor go to "Region-Specific" tab on SKU detail

    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |
    And Vendor inactive region "Chicagoland Express" of SKU
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create product290"
    And Check have no product showing

    And Switch to actor VENDOR
    And Vendor active region "Chicagoland Express" of SKU
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Switch to actor BUYER
    And Search item "Auto vendor create product290"
    And Check have no product showing

    And Switch to actor VENDOR
    And Vendor inactive region "Chicagoland Express" of SKU
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

    And Switch to actor BUYER
    And Search item "Auto vendor create product290"
    And Check have no product showing

    And Switch to actor VENDOR
    And Vendor active region "Chicagoland Express" of SKU
    And Vendor click "Publish" new SKU
    And Wait for update SKU successfully

    And Switch to actor BUYER
    And Buyer go to "Orders" from dashboard
    And Search item "Auto vendor create product290"
    And Search item and go to detail of first result
      | item                          | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create product290 | Auto vendor create product290 | Auto Brand product moq | $10.00       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $10.00 | [blank]      | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
    And and check details information
      | brandLocation     | storage   | retail    | ingredients |
      | Chicago, Illinois | 1 day Dry | 1 day Dry | Ingredients |
    And and product qualities
      | 100% Natural |

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_294
  Scenario: Edit draft SKU Region tab 2
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product294 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "draft" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product294"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    #    And Vendor go to "Region-Specific" tab on SKU detail

    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |

    And Check field "Wholesale price/CASE" is enable
    And Vendor edit field on SKU detail
      | field     | value   |
      | MSRP/unit | [blank] |
    And Vendor check message is showing of fields when create product
      | field     | message                    |
      | MSRP/unit | This field cannot be blank |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |
    And Vendor edit field on SKU detail
      | field     | value |
      | MSRP/unit | -1    |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | -1       | In Stock     | [blank]  |
    And Vendor edit field on SKU detail
      | field     | value |
      | MSRP/unit | a     |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | -1       | In Stock     | [blank]  |
    And Vendor decrease field number tooltip 1 times
      | field     | text  |
      | MSRP/unit | -1.01 |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | -1.01    | In Stock     | [blank]  |
    And Vendor increase field number tooltip 1 times
      | field     | text |
      | MSRP/unit | -1   |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | -1       | In Stock     | [blank]  |
    And Vendor click "Publish" new SKU
#    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor edit field on SKU detail
      | field     | value     |
      | MSRP/unit | 123456789 |
    And Vendor click "Save as a draft" new SKU
    And Vendor check alert message
      | 12345678900 is out of range for ActiveModel::Type::Integer with limit 4 bytes |

    And Vendor edit field on SKU detail
      | field     | value |
      | MSRP/unit | 0     |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
##Đang bug
#    And Vendor click "Publish" new SKU
#    And Vendor Continue confirm publish SKU
#    And Vendor check alert message
#      | Validation failed: Variants regions msrp must be greater than or equal to 0 |
    And Vendor edit field on SKU detail
      | field     | value |
      | MSRP/unit | 1     |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully
#
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create product294"
    And Search item and go to detail of first result
      | item                          | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create product294 | Auto vendor create product294 | Auto Brand product moq | $10.00       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp  | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | -900%       | $1.00 | [blank]      | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
    And and check details information
      | brandLocation     | storage   | retail    | ingredients |
      | Chicago, Illinois | 1 day Dry | 1 day Dry | Ingredients |
    And and product qualities
      | 100% Natural |

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_292
  Scenario: Edit draft SKU Region tab 3
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product292 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "draft" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product292"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    #    And Vendor go to "Region-Specific" tab on SKU detail

    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |
    And Check field "Wholesale price/CASE" is enable
    And Vendor edit field on SKU detail
      | field                | value   |
      | Wholesale price/CASE | [blank] |
    And Vendor check message is showing of fields when create product
      | field                | message                    |
      | Wholesale price/CASE | This field cannot be blank |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |
    And Vendor edit field on SKU detail
      | field                | value |
      | Wholesale price/CASE | -1    |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | -1        | 10       | In Stock     | [blank]  |
    And Vendor edit field on SKU detail
      | field                | value |
      | Wholesale price/CASE | a     |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | -1        | 10       | In Stock     | [blank]  |
    And Vendor decrease field number tooltip 1 times
      | field                | text  |
      | Wholesale price/CASE | -1.01 |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | -1.01     | 10       | In Stock     | [blank]  |
    And Vendor increase field number tooltip 1 times
      | field                | text |
      | Wholesale price/CASE | -1   |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | -1        | 10       | In Stock     | [blank]  |
    And Vendor click "Publish" new SKU
#    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor edit field on SKU detail
      | field                | value     |
      | Wholesale price/CASE | 123456789 |
    And Vendor click "Save as a draft" new SKU
    And Vendor check alert message
      | 12345678900 is out of range for ActiveModel::Type::Integer with limit 4 bytes |

    And Vendor edit field on SKU detail
      | field                | value |
      | Wholesale price/CASE | 0     |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully

    And Vendor click "Publish" new SKU
#    And Vendor Continue confirm publish SKU
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor edit field on SKU detail
      | field                | value |
      | Wholesale price/CASE | 1     |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully
#
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create product292"
    And Search item and go to detail of first result
      | item                          | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create product292 | Auto vendor create product292 | Auto Brand product moq | $1.00        | $1.00        | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 90%         | $10.00 | [blank]      | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
    And and check details information
      | brandLocation     | storage   | retail    | ingredients |
      | Chicago, Illinois | 1 day Dry | 1 day Dry | Ingredients |
    And and product qualities
      | 100% Natural |

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_296
  Scenario: Edit draft SKU Region tab 4
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product296 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "draft" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product296"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
#    #    And Vendor go to "Region-Specific" tab on SKU detail

    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |

    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | [blank]   | [blank]  | Out of Stock | [blank]      |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    And Vendor input Region-Specific info of SKU
#      | regionName          | casePrice | msrpunit | availability   | expectedDate |
#      | Chicagoland Express | [blank]   | [blank]  | Launching Soon | [blank]      |
#    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      And Wait for update SKU successfully
#    And Vendor input Region-Specific info of SKU
#      | regionName          | casePrice | msrpunit | availability   | expectedDate |
#      | Chicagoland Express | [blank]   | [blank]  | Launching Soon | Plus1        |
#    And Vendor click "Save as a draft" new SKU
#    And Vendor check alert message
#      And Wait for update SKU successfully
#    And Vendor go back product detail
#    And Vendor go to detail of SKU "sku random"
##    #    And Vendor go to "Region-Specific" tab on SKU detail
#
##    And Vendor check Region-Specific of SKU
##      | regionName          | casePrice | msrpUnit | availability   | arriving |
##      | Chicagoland Express | 10        | 10       | Launching Soon | Plus1    |
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability |
      | Chicagoland Express | 10        | 10       | Out of Stock |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully
#
#    Given BUYER open web user
#    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
#    And Search item "Auto vendor create product296"
#    And Search item and go to detail of first result
#      | item                          | productName                   | productBrand           | pricePerUnit | pricePerCase | availability   |
#      | Auto vendor create product296 | Auto vendor create product296 | Auto Brand product moq | $10.00       | $10.00       | Launching Soon |
#    And Check more information of SKU
#      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
#      | 123123123123 | 0%          | $10.00 | [blank]      | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
#    And and check details information
#      | brandLocation     | storage   | retail    | ingredients |
#      | Chicago, Illinois | 1 day Dry | 1 day Dry | Ingredients |
#    And and product qualities
#      | 100% Natural |

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_299
  Scenario: Edit draft SKU Region tab prop65
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product299 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "draft" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product299"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
#    #    And Vendor go to "Region-Specific" tab on SKU detail

    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |
    And Vendor choose region "Florida Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName      | casePrice | msrpunit | availability | expectedDate |
      | Florida Express | 10        | 10       | In Stock     | [blank]      |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express | 10        | 10       | In Stock     | [blank]  |
      | Florida Express     | 10        | 10       | In Stock     | [blank]  |
    And Vendor choose region "Pod Direct Central" for SKU
    And Vendor choose option on confirm add region
      | You will drop ship every Pod Direct order directly to the store and pay all shipping costs. |
      | You will confirm and provide order tracking details within 48 hours of order placement.     |
#      | Orders must arrive at the store within 5 days of the order date.                            |
      | Orders must be fulfilled within 5 days of the order date.                                   |
      | Inventory stored in our regional DCs cannot be used to fulfill orders for Pod Direct.       |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName         | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct Central | 10        | 10       | In Stock     | [blank]      |
    And Vendor choose region "North California Express" for SKU
    And Vendor choose option "The referenced product contains one or more chemicals on the Prop. 65 List, as identified below." on Prop65
    And Vendor enter info of Prop65
      | firstName | lastName | email                           | companyName             | listAllChemicals | item                                                                                                                                                                                                                                                                                                                                                           | warning                                                        |
      | Auto      | Vendor59 | ngoctx+autovendor59@podfoods.co | Auto vendor company moq | listAllChemicals | This product does not expose the user to chemical levels that exceed the No Significant Risk Level (NSRL) and/or Maximum Allowable Dose Level (MADL) established under Prop 65, or an alternative level established by California Courts (if established by California Courts, please email a copy of the applicable Consent Judgment to success@podfoods.co). | Shelf tag Prop. 65 warning label for display in retail stores. |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName               | casePrice | msrpunit | availability | expectedDate |
      | North California Express | 10        | 10       | In Stock     | [blank]      |
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
#    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability | arriving |
      | Chicagoland Express      | 10        | 10       | In Stock     | [blank]  |
      | Florida Express          | 10        | 10       | In Stock     | [blank]  |
      | Pod Direct Central       | 10        | 10       | In Stock     | [blank]  |
      | North California Express | 10        | 10       | In Stock     | [blank]  |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create product299"
    And Search item and go to detail of first result
      | item                          | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create product299 | Auto vendor create product299 | Auto Brand product moq | $10.00       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $10.00 | [blank]      | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
    And and check details information
      | brandLocation     | storage   | retail    | ingredients |
      | Chicago, Illinois | 1 day Dry | 1 day Dry | Ingredients |
    And and product qualities
      | 100% Natural |

#    buyer thuộc PDM
    Given BUYER2 open web user
    And login to beta web with email "ngoctx+autobuyer54@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create product299"
    And Search item and go to detail of first result
      | item                          | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create product299 | Auto vendor create product299 | Auto Brand product moq | $10.00       | $10.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension | caseDimension | unitSize | casePack        |
      | 123123123123 | 0%          | $10.00 | [blank]      | 1" x 1" x 1"  | 1" x 1" x 1"  | 1.0 g    | 1 unit per case |
    And and check details information
      | brandLocation     | storage   | retail    | ingredients |
      | Chicago, Illinois | 1 day Dry | 1 day Dry | Ingredients |
    And and product qualities
      | 100% Natural |

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_303
  Scenario: Vendor editing a SKU is main
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product303 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product303"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor set is main SKU
    And Vendor input info new SKU
      | skuName                    | unitsCase | individualUnitUPC | masterImage | caseUPC | unitUpcImage | caseUpcImage | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | country | city    | stateManufacture | ingredient | leadTime | description | nutritionLabel |
      | Auto vendor create sku3032 | [blank]   | [blank]           | [blank]     | [blank] | [blank]      | [blank]      | [blank]          | [blank]          | [blank]         | [blank]         | [blank]            | [blank]            | [blank] | [blank] | [blank]          | [blank]    | [blank]  | [blank]     | [blank]        |
    And Vendor click "Save as a draft" new SKU
    And Vendor check alert message
      | Validation failed: You can't save a draft as main variant |

    And Vendor input info new SKU
      | skuName                    | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku3033 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"
    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 1         | 1        | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor go back product detail
    And Vendor check SKU "show" on Published SKUs
      | skuName                    | caseUnit | unitUPC      | caseUPC      |
      | Auto vendor create sku3033 | 12       | 123456789098 | 123456789098 |
      | sku random                 | 1        | 123123123123 | 123123123123 |
    And Vendor go to detail of SKU "Auto vendor create sku3033"
    And Vendor check SKU general detail
      | skuName                    | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature | isMain |
      | Auto vendor create sku3033 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | [blank]  | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20.0          | -12.0          | yes    |
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku random"
    And Vendor check SKU general detail
      | skuName    | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature | isMain  |
      | sku random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | 1.0            | 1.0            | [blank] |
    And Vendor set is main SKU
    And Vendor click "Publish" new SKU
#    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully
    And Vendor go back product detail
    And Vendor go to detail of SKU "Auto vendor create sku3033"
    And Vendor check SKU general detail
      | skuName                    | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature | isMain  |
      | Auto vendor create sku3033 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | [blank]  | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20.0          | -12.0          | [blank] |
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku random"
    And Vendor check SKU general detail
      | skuName    | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature | isMain |
      | sku random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | 1.0            | 1.0            | yes    |

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_306
  Scenario:  Buyer-company-Specific Price tab
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product306 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "draft" SKU from admin with name "sku random" of product ""
    And Admin create a "draft" SKU from admin with name "sku 2 random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product306"
    And Vendor go to SKUs tap
    And Vendor check SKU "show" on Draft SKUs
      | skuName      | caseUnit | unitUPC      | caseUPC      |
      | sku random   | 1        | 123123123123 | 123123123123 |
      | sku 2 random | 1        | 123123123123 | 123123123123 |
    And Vendor go to detail of SKU "sku random"
    And Vendor check SKU general detail
      | skuName    | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature | isMain |
      | sku random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | 1.0            | 1.0            | yes    |
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku 2 random"
    And Vendor check SKU general detail
      | skuName      | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature | isMain  |
      | sku 2 random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | 1.0            | 1.0            | [blank] |
    And Vendor set is main SKU
    And Vendor click "Save as a draft" new SKU
    And Wait for update SKU successfully
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku random"
    And Vendor check SKU general detail
      | skuName    | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature | isMain  |
      | sku random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | 1.0            | 1.0            | [blank] |
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku 2 random"
    And Vendor check SKU general detail
      | skuName      | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature | isMain |
      | sku 2 random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | 1.0            | 1.0            | yes    |

  #    Create a sku active -
#    And Admin create a "active" SKU from admin with name "sku 3 random" of product ""

    And VENDOR Navigate to "Orders" by sidebar
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product306"
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor set is main SKU
    And Vendor input info new SKU
      | skuName                    | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create sku3034 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | bcd         |
    #    And Vendor go to "Region-Specific" tab on SKU detail
    And Click on button "Next"
    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 1         | 1        | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
#    And Vendor check alert message
#      | Product SKU created successfully. |
    And Wait for create SKU successfully

    And Vendor go back product detail
    And Vendor go to detail of SKU "Auto vendor create sku3034"
    And Vendor check SKU general detail
      | skuName                    | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city     | state    | storage | retail | minTemperature | maxTemperature | isMain |
      | Auto vendor create sku3034 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | United States | New York | New York | 30      | 10     | -20.0          | -12.0          | yes    |
    And Vendor go back product detail
    And Vendor go to detail of SKU "sku 2 random"
    And Vendor check SKU general detail
      | skuName      | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city    | state    | storage | retail | minTemperature | maxTemperature | isMain  |
      | sku 2 random | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States | Chicago | Illinois | 1       | 1      | 1.0            | 1.0            | [blank] |

  @VENDOR_PRODUCTS_308
  Scenario: Buyer-company-Specific Price tab
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product308 | 3086     |

    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                          | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto vendor create product308 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "Auto vendor create product308"
    And Check product not have SKU
    And Add new SKU
      | skuName                   | state  | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition      | retailShelfLife | retailCondition       | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | Auto vendor create SKU308 | Active | Yes     | 12        | 1234567890981     | yes                   | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Frozen (-10°F ~ 32°F) | 10              | Frozen (-10°F ~ 32°F) | -10                | 20                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
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
    And Admin search Buyer Company specific "Auto_BuyerCompany"
    And Admin choose regions and add to Buyer Company specific
      | regions             |
      | Chicagoland Express |
      | Florida Express     |
    And with Buyer Company-specific
      | buyerCompany      | region              | msrpUnit | casePrice | availability | startDate   | endDate     | inventoryArrivingAt | category |
      | Auto_BuyerCompany | Chicagoland Express | 11       | 12        | In stock     | currentDate | currentDate | [blank]             | [blank]  |
      | Auto_BuyerCompany | Florida Express     | 11       | 12        | In stock     | Plus1       | Plus1       | [blank]             | [blank]  |

    And Admin search Buyer Company specific "Auto Buyer Company Bao"
    And Admin choose regions and add to Buyer Company specific
      | regions                  |
      | South California Express |
      | Pod Direct Central       |
    And with Buyer Company-specific
      | buyerCompany           | region                   | msrpUnit | casePrice | availability | startDate   | endDate | inventoryArrivingAt | category         |
      | Auto Buyer Company Bao | South California Express | 11       | 12        | Out of stock | currentDate | Plus1   | [blank]             | Vendor long-term |
      | Auto Buyer Company Bao | Pod Direct Central       | 11       | 12        | Out of stock | Minus1      | Plus1   | [blank]             | [blank]          |
    And Click Create
    And Admin check message of sku "Auto vendor create SKU308" is "Variant have been saved successfully !!"

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product308"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "Auto vendor create SKU308"
#    And Vendor check SKU general detail
#      | skuName    | ingredients | description | leadTime | unitCase | unitUPC      | caseUPC      | country | city    | state    | storage | retail | minTemperature | maxTemperature | isMain |
#      | Auto vendor create SKU308 | Ingredients | Description | [blank]  | 1        | 123123123123 | 123123123123 | United States     | Chicago | Illinois | 1       | 1      | 1.0            | 1.0            | yes    |
    And Vendor go to Manage SKU price tab
#    And Vendor go to "Buyer-Company-Specific Price" tab on SKU detail
    And Vendor check Buyer-Company Specific tap
      | buyerCompany      | region | msrpUnit | casePrice | availability | startDate   | endDate     |
      | Auto_BuyerCompany | CHI    | 11       | 12        | In Stock     | currentDate | currentDate |

    And Vendor check Buyer-Company Specific tap
      | buyerCompany           | region | msrpUnit | casePrice | availability | startDate   | endDate | inventoryArrivingAt |
      | Auto Buyer Company Bao | LA     | 11       | 12        | Out of Stock | currentDate | Plus1   | [blank]             |
#      | Auto Buyer Company Bao | PDM    | 11       | 12        | Launching Soon | Minus1      | Plus1   | currentDate         |

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_310
  Scenario:  Buyer-company-Specific Price tab 2
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product310 | 3086     |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "draft" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product310"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    And Vendor go to Manage SKU price tab
#    And Vendor go to "Buyer-Company-Specific Price" tab on SKU detail
    And Vendor check Buyer-Company Specific tap
      | buyerCompany      | region | msrpUnit | casePrice | availability | startDate   | endDate     |
      | Auto_BuyerCompany | CHI    | 10       | 10        | In Stock     | currentDate | currentDate |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create product299"
    And Search item and go to detail of first result
      | item                          | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create product310 | Auto vendor create product310 | Auto Brand product moq | $10.00       | $10.00       | In Stock     |

  @VENDOR_PRODUCTS_5_EDIT_SKU @VENDOR_PRODUCTS_312
  Scenario: Store Specific Price tab
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product312 | 3086     |
    And Info of Store specific
      | store_id | store_name                  | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2582     | Auto Store Chicago1         | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
      | 2859     | Auto store Florida          | 2215             | Bao Buyer Company  | 63        | currentDate | currentDate | 1000             | 1000       | in_stock     |
      | 2576     | Auto Store North California | 2216             | Auto_BuyerCompany  | 25        | currentDate | currentDate | 1000             | 1000       | in_stock     |
#      | 1762     | Auto Store PDM              | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "draft" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor59@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product312"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    And Vendor go to Manage SKU price tab
#    And Vendor go to "Store-Specific Price" tab on SKU detail
    And Vendor check Store Specific tap
      | store                       | region                   | price | startDate   | endDate     |
      | Auto Store Chicago1         | Chicagoland Express      | 10    | currentDate | currentDate |
      | Auto store Florida          | Florida Express          | 10    | currentDate | currentDate |
      | Auto Store North California | North California Express | 10    | currentDate | currentDate |
#    And Vendor check Store Specific of SKU
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
    And Wait for update SKU successfully

    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto vendor create product312"
    And Search item and go to detail of first result
      | item                          | productName                   | productBrand           | pricePerUnit | pricePerCase | availability |
      | Auto vendor create product312 | Auto vendor create product312 | Auto Brand product moq | $10.00       | $10.00       | In Stock     |

  @VENDOR_PRODUCTS_337 @VENDOR_PRODUCTS_314
  Scenario: Change request product 2
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | Auto vendor create product3371 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor56@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product3371"
    And Vendor edit field on Product detail
      | field | value                          |
      | Title | Auto vendor create product3372 |
#    And Vendor "Cancel" go to change request of field "Unit length"
    And Vendor "Save and Redirect" go to change request of field "Unit length"
    And Vendor check current Request information change of product
      | field                | value |
      | Unit length (inches) | 1     |
      | Unit width (inches)  | 1     |
      | Unit height (inches) | 1     |
    And Vendor check request change product page

  @VENDOR_PRODUCTS_314 @VENDOR_PRODUCTS_79
  Scenario: Change request product
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product314 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor56@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product314"
    And Vendor "Cancel" go to change request of field "Unit length"
    And Vendor "Redirect" go to change request of field "Unit length"
    And Vendor check current Request information change of product
      | field                | value |
      | Unit length (inches) | 1     |
      | Unit width (inches)  | 1     |
      | Unit height (inches) | 1     |
    And Vendor check request change product page

    And Vendor Request information change of product
      | unitLength | unitWidth | unitHeight | note    |
      | 1          | 1         | 1          | [blank] |
    And Vendor check message is showing of fields when create product
      | field                | message                                              |
      | Unit length (inches) | The current value and new value cannot be identical. |
      | Unit width (inches)  | The current value and new value cannot be identical. |
      | Unit height (inches) | The current value and new value cannot be identical. |
    And Vendor submit Request information change
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field | message                    |
      | Note  | This field cannot be blank |
    And Vendor Clear field "Unit length (inches)" when create product
    And Vendor Clear field "Unit width (inches)" when create product
    And Vendor Clear field "Unit height (inches)" when create product
    And Vendor Request information change of product
      | unitLength | unitWidth | unitHeight | note |
      | [blank]    | [blank]   | [blank]    | auto |
    And Vendor submit Request information change
    And Vendor check alert message
      | Request has no data change |
    And Vendor Request information change of product
      | unitLength | unitWidth | unitHeight | note |
      | [blank]    | 2         | 2          | auto |
    And Vendor submit Request information change
    And Vendor check alert message
      | Unit length must exist |
    And Vendor Request information change of product
      | unitLength | unitWidth | unitHeight | note |
      | [blank]    | 2         | 2          | auto |
    And Vendor submit Request information change
    And Vendor check alert message
      | Error 422 |
    And Vendor Request information change of product
      | unitLength | unitWidth | unitHeight | note |
      | 2          | 2         | 2          | auto |
    And Vendor submit Request information change
    And Vendor check alert message after 60 seconds
      | Product change requested successfully. |
    And Vendor check after Request information change of product
      | field                | value | effective |
      | Unit length (inches) | 1 → 2 | Plus90    |
      | Unit width (inches)  | 1 → 2 | Plus90    |
      | Unit height (inches) | 1 → 2 | Plus90    |
    And Click on any text "< Auto vendor create product314"
    And Vendor check after Request information change of product
      | field       | value | effective |
      | Unit length | 1 → 2 | Plus90    |
      | Unit width  | 1 → 2 | Plus90    |
      | Unit height | 1 → 2 | Plus90    |
    And Vendor "Yes" go to change request of field ""

    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Change requests" to "All requests" by sidebar
    And Admin search change request by info
      | field        | value                         | type  |
      | Product name | Auto vendor create product314 | input |
    And Admin check list change request
      | requestedDate | effectiveDate | vendor        | brand                  | product                       | changesProduct                           | note |
      | currentDate   | Plus90        | Auto Vendor56 | Auto Brand product mov | Auto vendor create product314 | Size (L × W × H)1" x 1" x 1"2" x 2" x 2" | auto |

    And Switch to actor VENDOR
    And Vendor Request information change of product
      | unitLength | unitWidth | unitHeight | note  |
      | 3          | 3         | 3          | auto2 |
    And Click on button "Edit Request"
    And Vendor check alert message after 60 seconds
      | Product change request edited successfully. |
    And Click on any text "< Auto vendor create product314"
    And Vendor check after Request information change of product
      | field       | value | effective |
      | Unit length | 1 → 3 | Plus90    |
      | Unit width  | 1 → 3 | Plus90    |
      | Unit height | 1 → 3 | Plus90    |
    And Vendor "Yes" go to change request of field ""

    And Switch to actor BAO_ADMIN3
    And Admin search change request by info
      | field        | value                         | type  |
      | Product name | Auto vendor create product314 | input |
    And Admin check list change request
      | requestedDate | effectiveDate | vendor        | brand                  | product                       | changesProduct                           | note  |
      | currentDate   | Plus90        | Auto Vendor56 | Auto Brand product mov | Auto vendor create product314 | Size (L × W × H)1" x 1" x 1"3" x 3" x 3" | auto2 |

    And Switch to actor VENDOR
    And Click on button "Cancel Request"

    And Switch to actor BAO_ADMIN3
    And Admin search change request by info
      | field        | value                         | type  |
      | Product name | Auto vendor create product314 | input |
    And Admin check no data found

  @VENDOR_PRODUCTS_321
  Scenario: Change request SKU
    Given BAO_ADMIN3 login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create product" by api
    And Admin delete product name "Auto vendor create product" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                          | brand_id |
      | Auto vendor create product321 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | arrivingDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | [blank]      |
    And Admin create a "active" SKU from admin with name "sku random" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor56@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto vendor create product321"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"

    And Vendor "Cancel" go to change request of field "Barcodes Type"
    And Vendor "Redirect" go to change request of field "Barcodes Type"
    And Vendor check request change sku page

    And Vendor check current Request information change of product
      | field         | value        |
      | Barcodes Type | UPC          |
      | Units/case    | 1            |
      | Unit UPC      | 123123123123 |
      | Case UPC      | 123123123123 |
    And Vendor check current Request information change region of SKU
      | region              | price |
      | Chicagoland Express | 10.00 |
    And Vendor submit Request information change
    And Vendor check alert message
      | Please fix the highlighted error(s) to continue. |
    And Vendor check message is showing of fields when create product
      | field | message                    |
      | Note  | This field cannot be blank |
    And Vendor Request information change general info of SKU "sku random"
      | barcodes | unitCase | unit    | case    | note |
      | [blank]  | [blank]  | [blank] | [blank] | auto |
    And Vendor submit Request information change
    And Vendor check alert message
      | Request has no data change |
#      | Please fix the highlighted error(s) to continue. |
    And Vendor Request information change general info of SKU "sku random"
      | barcodes | unitCase | unit    | case    | note |
      | [blank]  | 2        | [blank] | [blank] | auto |
    And Vendor submit Request information change
    And Vendor check alert message after 60 seconds
      | Product change requested successfully. |
    And Vendor check after Request information change of product
      | field      | value | effective |
      | Units/case | 1 → 2 | Plus90    |

    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Change requests" to "All requests" by sidebar
    And Admin search change request by info
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
      | Product change request canceled successfully. |
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
    And Admin search change request by info
      | field        | value                         | type  |
      | Product name | Auto vendor create product321 | input |
    And Admin check list change request
      | requestedDate | effectiveDate | vendor        | brand                  | product                       | changesSKU | note |
      | currentDate   | Plus90        | Auto Vendor56 | Auto Brand product mov | Auto vendor create product321 | sku random | auto |
    And Admin check list change request
      | requestedDate | effectiveDate | vendor  | brand   | product | changesSKU                                                                                                                                 | note    |
      | [blank]       | [blank]       | [blank] | [blank] | [blank] | Unit UPC / EAN1231231231231212121212121Case UPC / EAN1231231231231212121212121UPC / EAN typeUpcEanCase units12Case price (CHI)$10.00$20.00 | [blank] |

    And Switch to actor VENDOR
    And Click on any text "< Auto vendor create product321"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    And Vendor "Redirect" go to change request of field "Unit UPC"
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
    And Click on any text "< Auto vendor create product321"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "sku random"
    And Vendor "Redirect" go to change request of field "Units/case"
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
    And Admin search change request by info
      | field        | value                         | type  |
      | Product name | Auto vendor create product321 | input |
    And Admin check no data found
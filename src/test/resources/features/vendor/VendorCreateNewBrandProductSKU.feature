#mvn clean verify -Dtestsuite="AddToCartTestSuite" -Dcucumber.options="src/test/resources/features/addtocart" -Denvironments=product
@feature=VendorCreateBrandProductSKU
Feature: Vendor Create Brand Product SKU

  @Vendor @TC_Vendor_setting_MOQ
  Scenario: Vendor Create Brand Product SKU MOQ
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info
      | name                 | vendorCompany | managedBy | state   | tags    |
      | Auto Create Brand 01 | [blank]       | [blank]   | [blank] | [blank] |
    And Admin remove the brand the first record

    Given VENDOR open web user
    When login to beta web with email "thuy+vegetable@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Create an new Brand
      | name                 | description       | city     | stage    | country |
      | Auto Create Brand 01 | this is new brand | New York | New York | U.S     |
    And Vendor upload logo image, Cover image, Photos2
      | logo     | cover     | photos          |
      | logo.jpg | cover.jpg | masterImage.jpg |
#
    And Vendor go to all brands page
    And Vendor search products with brand just created
    And Vendor verify not any product was showing
#The New Product will not show cuz it hasn't got any Active SKU

    Given USER_EMAIL open login gmail with email "bao@podfoods.co" pass "Baovip99"
    And USER_EMAIL search email with sender "Pod Foods Co"
    And QA go to first email with title "New brand created"
    And verify email
      | name         | vendorCompany                                                   | brandName            | productName |
      | Hi Pod Foods | A new brand has been added from trang+vegetablecom@podfoods.co: | Auto Create Brand 01 | [blank]     |
#
    Given ADMIN go to admin beta
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info then system show result
      | name                 | vendorCompany | managedBy | state  | tags    |
      | Auto Create Brand 01 | [blank]       | [blank]   | Active | [blank] |

    Given VENDOR open web user
    When login to beta web with email "thuy+vegetable@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to Dashboard
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to Create new Product
    And VENDOR Create an new Product Success
      | productName   | brandName            | productType | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | auto_product1 | Auto Create Brand 01 | Bread       | yes         | Dairy    | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  | 10             | 10            | 10                  | 1                      | 1                    | 1                          | 1                         | 1                          | 1                |

    And Vendor go to product detail just created
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName               | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | auto_flow create sku1 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -10°F) | 10              | Deep Frozen (-20°F ~ -10°F) | 10                 | 40                 | U.S     | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |
    And Vendor choose qualities of SKU
      | Dairy-Free |

    And Vendor go to "Region-Specific" tab on SKU detail
#
#    And Vendor choose region "Chicagoland Express" for SKU
#    And Vendor choose region "Florida Express" for SKU
#    And Vendor choose region "Mid Atlantic Express" for SKU
#    And Vendor choose region "New York Express" for SKU
#    And Vendor choose region "North California Express" for SKU
#    And Vendor choose region "South California Express" for SKU
#    And Vendor choose region "Texas Express" for SKU
#    And Vendor choose region "Pod Direct Midwest" for SKU
#    And Vendor choose region "Pod Direct Northeast" for SKU
#    And Vendor choose region "Pod Direct Southeast" for SKU
#    And Vendor choose region "Pod Direct Southwest & Rockies" for SKU
#    And Vendor choose region "Pod Direct West" for SKU
#    And Vendor input Region-Specific info of SKU
    And Vendor add regions for SKU
      | regionName               | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express      | 12        | 15       | In Stock     | [blank]      |
      | Florida Express          | 12        | 15       | In Stock     | [blank]      |
      | Mid Atlantic Express     | 12        | 15       | Out of Stock | [blank]      |
#      | New York Express               | 12        | 15       | Launching Soon | tomorrow     |
      | North California Express | 12        | 15       | In Stock     | [blank]      |
      | South California Express | 12        | 15       | In Stock     | [blank]      |
      | Dallas Express           | 12        | 15       | In Stock     | [blank]      |
      | Pod Direct Central       | 12        | 15       | In Stock     | [blank]      |
      | Pod Direct East          | 12        | 15       | Out of Stock | [blank]      |
#      | Pod Direct Southeast           | 12        | 15       | Launching Soon | tomorrow     |
#      | Pod Direct Southwest & Rockies | 12        | 15       | In Stock       | [blank]      |
      | Pod Direct West          | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
#    Given USER_EMAIL2 open login gmail with email "bao@podfoods.co" pass "Baovip99"
    And USER_EMAIL search email with sender "Pod Foods Co New product created"
    And QA go to first email with title "New product created"
    And verify email
      | name         | vendorCompany                                                     | brandName            | productName   |
      | Hi Pod Foods | A new product has been added from trang+vegetablecom@podfoods.co: | Auto Create Brand 01 | auto_product1 |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term          | productState | brandName            | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product1 | [blank]      | Auto Create Brand 01 | [blank]       | Bread       | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to product detail from just searched
    And Admin check product detail
      | stateStatus | productName   | brand                | vendorCompany          | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | auto_product1 | Auto Create Brand 01 | vegetable company 1609 | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 oz.  | 0.00%         | Dairy    | / Bread | 10            | 10           | 10             | 1            | 1          | 1.00 lbs         | [blank]    |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Admin check SKU info
      | skuName               | unitUpc      | caseUpc      | status |
      | auto_flow create sku1 | 123456789098 | 123456789098 | Active |

#    Verify on Head buyer
    Given BUYER open web user
    And login to beta web with email "auto+buyerbao1@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku1"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku1 | auto_product1 | Auto Create Brand 01 | $1.00        | $12.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 oz.  | 12 units per case |
    And and check details information
      | brandLocation      | storage             | retail              | ingredients                             |
      | New York, New York | 30 days Deep Frozen | 10 days Deep Frozen | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Dairy-Free |

#    Verify on Head buyer Launching soon
    Given BUYER open web user
    And login to beta web with email "auto+buyerbao1ny@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku1"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability   | arrivingDate |
      | auto_flow create sku1 | auto_product1 | Auto Create Brand 01 | $1.00        | $12.00       | Launching Soon | tomorrow     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 oz.  | 12 units per case |
    And and check details information
      | brandLocation      | storage             | retail              | ingredients                             |
      | New York, New York | 30 days Deep Frozen | 10 days Deep Frozen | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Dairy-Free |

#    Verify on Sub buyer
    Given BUYER2 open web user
    And login to beta web with email "auto+buyerbao2@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku1"
    And Check button add to cart is disable
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku1 | auto_product1 | Auto Create Brand 01 | $1.00        | $12.00       | In Stock     |
    And Check button add to cart on product detail is disable

    #    Verify on Direct buyer
    Given BUYER3 open web user
    And login to beta web with email "auto+buyerbao3@podfoods.co" pass "12345678a" role "Buyer"
    And Search Brand and go to detail
      | brand                | productName   | unitPrice | numberSku |
      | Auto Create Brand 01 | auto_product1 | $1.00     | 1         |


###### Vendor company setting Minimum Order Value (MOV)
  @Vendor @TC_Vendor_setting_MOV
  Scenario: Vendor Create Brand Product SKU MOV
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Brands" to "All brands" by sidebar
#    And Admin search the brand by info then system show result
#      | name                 | vendorCompany | managedBy | state  | tags |
#      | Auto Create Brand 02 | [blank]  | [blank]  | Active | [blank]  |
#    And Admin remove the brand the first record

    Given VENDOR open web user
    When login to beta web with email "auto+vendormov@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Create an new Brand
      | name                 | description       | city     | stage    | country |
      | Auto Create Brand 02 | this is new brand | New York | New York | U.S     |

    And Vendor upload logo image, Cover image, Photos2
      | logo     | cover     | photos          |
      | logo.jpg | cover.jpg | masterImage.jpg |

    And Vendor go to all brands page
    And Vendor search products with brand just created
    And Vendor verify not any product was showing
#The New Product will not show cuz it hasn't got any Active SKU
#
    Given USER_EMAIL open login gmail with email "bao@podfoods.co" pass "Baovip99"
    And USER_EMAIL search email with sender "Pod Foods Co"
    And QA go to first email with title "New brand created"
    And verify email
      | name         | vendorCompany                                            | brandName            | productName |
      | Hi Pod Foods | A new brand has been added from auto_vendor@podfoods.co: | Auto Create Brand 02 | [blank]     |

    Given ADMIN go to admin beta
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info then system show result
      | name                 | vendorCompany | managedBy | state  | tags    |
      | Auto Create Brand 02 | [blank]       | [blank]   | Active | [blank] |

    And VENDOR Navigate to Dashboard
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to Create new Product
    And VENDOR Create an new Product Success
      | productName   | brandName            | productType | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | auto_product2 | Auto Create Brand 02 | Bread       | yes         | Dairy    | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  | 10             | 10            | 10                  | 1                      | 1                    | 1                          | 1                         | 1                          | 1                |

    And Vendor go to product detail just created
    And Vendor go to SKUs tap
    And Vendor go to create a new SKU
    And Vendor input info new SKU
      | skuName               | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | auto_flow create sku2 | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -10°F) | 10              | Deep Frozen (-20°F ~ -10°F) | 10                 | 40                 | U.S     | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |
    And Vendor choose qualities of SKU
      | Dairy-Free |
    And Vendor go to "Region-Specific" tab on SKU detail
    And Vendor add regions for SKU
      | regionName                     | casePrice | msrpunit | availability | expectedDate |
      | Pod Direct Central | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And Vendor Continue confirm publish SKU
#    Given USER_EMAIL2 open login gmail with email "bao@podfoods.co" pass "Baovip99"
    And USER_EMAIL search email with sender "Pod Foods Co New product created"
    And QA go to first email with title "New product created"
    And verify email
      | name         | vendorCompany                                              | brandName            | productName   |
      | Hi Pod Foods | A new product has been added from auto_vendor@podfoods.co: | Auto Create Brand 02 | auto_product2 |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term          | productState | brandName            | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product2 | [blank]      | Auto Create Brand 02 | [blank]       | Bread       | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to product detail from just searched
    And Admin check product detail
      | stateStatus | productName   | brand                | vendorCompany           | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | auto_product2 | Auto Create Brand 02 | Auto_Vendor_company_MOV | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 12.00 lbs | 8.0 oz.  | 0.00%         | Dairy    | / Bread | 10            | 10           | 10             | 1            | 1          | 1.00 lbs         | [blank]    |

    And Admin check SKU info
      | skuName               | unitUpc      | caseUpc      | status |
      | auto_flow create sku2 | 123456789098 | 123456789098 | Active |

#    Verify on Head buyer express
    Given BUYER open web user
    And login to beta web with email "auto+buyerbao5@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku2"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku2 | auto_product2 | Auto Create Brand 02 | $1.00        | $12.00       | In Stock     |
    And Check badge Direct is "true"

#    Verify on Sub buyer express
    Given BUYER2 open web user
    And login to beta web with email "auto+buyerbao6@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku2"
    And Check button add to cart is disable
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku2 | auto_product2 | Auto Create Brand 02 | $1.00        | $12.00       | In Stock     |
    And Check button add to cart on product detail is disable

    #    Verify on Direct Head buyer
    Given BUYER3 open web user
    And login to beta web with email "auto+buyerbao7@podfoods.co" pass "12345678a" role "Buyer"
    And Search Brand and go to detail
      | brand                | productName   | unitPrice | numberSku |
      | Auto Create Brand 02 | auto_product2 | $1.00     | 1         |



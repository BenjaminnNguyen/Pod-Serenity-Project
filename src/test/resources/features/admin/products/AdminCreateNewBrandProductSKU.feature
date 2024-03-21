#mvn clean verify -Dtestsuite="AddToCartTestSuite" -Dcucumber.options="src/test/resources/features/addtocart" -Denvironments=product
@feature=AdminNewCreateBrandProductSKU
Feature: Admin create brand product sku

  @Admin @TC_Admin_create_Brand_Product_Sku_with_MOQs
  Scenario: Admin_create_Brand_Product_Sku_with_MOQs
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

#    Verify on Head buyer
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyerbao5@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |

#    Verify on Head buyer with sku Launching soon
    Given BUYER2 open web user
    And login to beta web with email "ngoctx+autobuyerbaony5@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability   | arrivingDate |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | Launching Soon | currentDate  |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
#    Verify on Head buyer with sku Out of stock
    Given BUYER3 open web user
    And login to beta web with email "ngoctx+autobuyerbaomidalantic5@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | Out of Stock |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |

#  Verify on Direct buyer
    Given BUYER4 open web user
    And login to beta web with email "ngoctx+autobuyerbao6@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check tag Express is "false"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
#    And Check badge Direct is "true"
    And Search Brand and go to detail
      | brand                | productName   | unitPrice | numberSku |
      | Auto Create Brand 03 | auto_product3 | $1.00     | 1         |


#  Verify on Direct buyer with sku Launching soon
    Given BUYER5 open web user
    And login to beta web with email "ngoctx+autobuyerbaopdnt6@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check tag Express is "false"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability   | arrivingDate |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | Launching Soon | currentDate  |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
#    And Check badge Direct is "true"
    And Search Brand and go to detail
      | brand                | productName   | unitPrice | numberSku |
      | Auto Create Brand 03 | auto_product3 | $1.00     | 1         |


#  Verify on Direct buyer with sku Out of stock
    Given BUYER6 open web user
    And login to beta web with email "ngoctx+autobuyerbaopdst6@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check tag Express is "false"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | Out of Stock |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
#    And Check badge Direct is "true"
    And Search Brand and go to detail
      | brand                | productName   | unitPrice | numberSku |
      | Auto Create Brand 03 | auto_product3 | $1.00     | 1         |

#    Verify on Sub buyer with sku instock
    Given BUYER7 open web user
    And login to beta web with email "ngoctx+autobuyerbao7@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check button add to cart is disable
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | In Stock     |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
    And Check button add to cart on product detail is disable
#    Verify on Sub buyer with sku Launching soon
    Given BUYER8 open web user
    And login to beta web with email "ngoctx+autobuyerbaony7@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check button add to cart is disable
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability   | arrivingDate |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | Launching Soon | currentDate  |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |

          #    Verify on Sub buyer with sku Out of stock
    Given BUYER9 open web user
    And login to beta web with email "ngoctx+autobuyerbaopdst7@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check button add to cart is disable
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | Out of Stock |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
    And Check button add to cart on product detail is disable

  @Admin @TC_Admin_create_Brand_Product_Sku_with_MOV
  Scenario: Admin_create_Brand_Product_Sku_with_MOV
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info then system show result
      | name                 | vendorCompany | managedBy | state  | tags    |
      | Auto Create Brand 04 | [blank]       | [blank]   | Active | [blank] |
    And Admin remove the brand the first record
    And Admin go to create brand
    And Admin create new brand
      | name                 | description | microDescriptions | city | state   | vendorCompany        |
      | Auto Create Brand 04 | description | microDescriptions | city | Alabama | AutoVendorCompanyMOV |
    And Admin create brand success
    And ADMIN navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info then system show result
      | name                 | vendorCompany | managedBy | state  | tags    |
      | Auto Create Brand 04 | [blank]       | [blank]   | Active | [blank] |
    And ADMIN navigate to "Products" to "All products" by sidebar
    And Create new Product
      | brandName            | productName   | status | allowRequestSamples | vendorCompany        | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions |
      | Auto Create Brand 04 | auto_product4 | Active | Yes                 | AutoVendorCompanyMOV | 0.00%         | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 10             | 10            | 10                  | 0                      | 0                    | 0                          | 0                         | 0                          | 0                | [blank]           |
    And Check product not have SKU
    And Add new SKU
      | skuName               | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto_flow create sku4 | [blank] | [blank] | 12        | 123456789098      | no                    | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | [blank]          | 10              | [blank]         | 10                 | 40                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving |
      | North California Express | 12        | 15       | In stock     | [blank]  |
    And Click Create

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendormov@poodfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Vendor Check Brand on Dashboard
      | brandName            | city | state   | country | description |
      | Auto Create Brand 04 | city | Alabama | U.S     | description |
    And Vendor check brand in detail
      | brandName            | city | state   | country | description |
      | Auto Create Brand 03 | city | Alabama | U.S     | description |
    And Vendor go to all brands page
    And Vendor search brand on catalog
      | brandName            | city | state   |
      | Auto Create Brand 04 | city | Alabama |
    And Vendor go to brand "Auto Create Brand 04" detail on catalog
    And Vendor check brand detail on catalog
      | brandName            | city | state   | description |
      | Auto Create Brand 04 | city | Alabama | description |
    And Vendor check a product on brand detail
      | auto_product4 |
    And Vendor Go to product detail
      | productName   | unitDimension   | caseDimension   | unitSize | casePack |
      | auto_product4 | 12" x 12" x 12" | 12" x 12" x 12" | 8.0      | 12       |
    And Vendor check regions detail
      | region                   | price | casePrice | msrp   | availability | moq     |
      | North California Express | $1.00 | $12.00    | $15.00 | In Stock     | [blank] |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
#    Verify on Head buyer
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyerbao8@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku4"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku4 | auto_product4 | Auto Create Brand 04 | $1.00        | $12.00       | In Stock     |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
      #    Verify on Direct buyer
    Given BUYER2 open web user
    And login to beta web with email "ngoctx+autobuyerbao9@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku4"
    And Check have no product showing
# Không hiển thị SKU trên Catalog của Direct buyer

#    Verify on Sub buyer
    Given BUYER3 open web user
    And login to beta web with email "ngoctx+autobuyerbao10@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku4"
    And Check tag Express is "true"
    And Check button add to cart is disable
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku4 | auto_product4 | Auto Create Brand 04 | $1.00        | $12.00       | In Stock     |
    And Check button add to cart on product detail is disable

  @Admin @TC_Admin_create_sku_with_price_show_on_Region_specifics_Tab_and_Buyer_company_specifics_tab
  Scenario: Admin_create_sku_with_price_show_on_Region_specifics_Tab_and_Buyer_company_specifics_tab
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer12@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer13@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term          | productState | brandName      | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product5 | [blank]      | Auto Brand Bao | [blank]       | Bread       | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin remove the product on first record
    And Create new Product
      | brandName      | productName   | status | allowRequestSamples | vendorCompany      | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions |
      | Auto Brand Bao | auto_product5 | Active | Yes                 | Auto_VendorCompany | 0.00%         | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 10             | 10            | 10                  | 0                      | 0                    | 0                          | 0                         | 0                          | 0                | [blank]           |
    And Check product not have SKU
    And Add new SKU
      | skuName               | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                             | leadTime | description | expireDayThreshold |
      | auto_flow create sku5 | [blank] | [blank] | 12        | 123456789098      | no                    | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | [blank]          | 10              | [blank]         | 10                 | 40                 | New York | New York         | Sodium Laureth Sulfate,Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving |
      | North California Express | 12        | 15       | In stock     | [blank]  |
      | Dallas Express           | 10        | 15       | In stock     | [blank]  |
    And Go to "Buyer company-specific" tab
    And Admin search Buyer Company specific "Auto_BuyerCompany"
    And Admin choose regions and add to Buyer Company specific
      | regions                  |
      | North California Express |
    And with Buyer Company-specific
      | buyerCompany      | region                   | msrpUnit | casePrice | availability | startDate   | endDate | inventoryArrivingAt | category |
      | Auto_BuyerCompany | North California Express | 21       | 20        | In stock     | currentDate | Plus1   | [blank]             | [blank]  |
    And Click Create

#    Check on Dashboard
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor12@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail just created
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "auto_flow create sku5"
    And Vendor check SKU general detail
      | skuName               | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country | city     | state    | storage | retail | minTemperature | maxTemperature |
      | auto_flow create sku5 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | U.S     | New York | New York | 30      | 10     | 10.0           | 40.0           |
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | Dallas Express           | 10        | 15       | In Stock     |
      | North California Express | 12        | 15       | In Stock     |
    And Vendor go to "Buyer-Company-Specific Price" tab on SKU detail
    And Vendor check Buyer-Company Specific tap
      | buyerCompany      | region | msrpUnit | casePrice | availability | startDate | endDate |
      | Auto_BuyerCompany | SF     | 21       | 20        | In stock     | [blank]   | [blank] |

#Check on catalog
    And Vendor search product "auto_flow create sku5" on catalog
    And Vendor Go to product detail
      | productName   | unitDimension   | caseDimension   | unitSize | casePack |
      | auto_product5 | 12" x 12" x 12" | 12" x 12" x 12" | 8.0      | 12       |
    And Vendor check regions detail
      | region                   | price | casePrice | msrp   | availability | moq |
      | Dallas Express           | $0.83 | $10.00    | $15.00 | In Stock     | 1   |
      | North California Express | $1.00 | $12.00    | $15.00 | In Stock     | 1   |

#Check on buyer catalog
##    Verify on Head buyer of North california express
#    Giá ăn theo Buyer-Company specific
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer12@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku5"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand   | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku5 | auto_product5 | Auto Brand Bao | $1.67        | $20.00       | In Stock     |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
    And Clear cart to empty in cart before
    And Add to cart the sku "auto_flow create sku5" with quantity = "1"
    And Verify item on cart tab on right side
      | brand          | product       | sku                   | price  | quantity |
      | Auto Brand Bao | auto_product5 | auto_flow create sku5 | $20.00 | 1        |
    And and verify price on cart tab on right side
      | logisticsSurcharge | smallOrderSurcharge |
      | $20.00             | $30.00              |
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand          | product       | sku                   | price  | quantity | total  |
      | Auto Brand Bao | auto_product5 | auto_flow create sku5 | $20.00 | 1        | $20.00 |
    And and check price on cart detail
      | logisticsSurcharge | smallOrderSurcharge |
      | $20.00             | $30.00              |
#    And Clear cart to empty in cart before

#    Check trên Buyer thuộc Taxas Express,
#    Giá ăn theo Region specific
    Given BUYER2 open web user
    And login to beta web with email "ngoctx+autobuyer13@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku5"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand   | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku5 | auto_product5 | Auto Brand Bao | $0.83        | $10.00       | In Stock     |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
    And Clear cart to empty in cart before
    And Add to cart the sku "auto_flow create sku5" with quantity = "1"
    And Verify item on cart tab on right side
      | brand          | product       | sku                   | price  | quantity |
      | Auto Brand Bao | auto_product5 | auto_flow create sku5 | $10.00 | 1        |
    And and verify price on cart tab on right side
      | logisticsSurcharge | smallOrderSurcharge |
      | $20.00             | $30.00              |
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand          | product       | sku                   | price  | quantity | total  |
      | Auto Brand Bao | auto_product5 | auto_flow create sku5 | $10.00 | 1        | $10.00 |
    And and check price on cart detail
      | logisticsSurcharge | smallOrderSurcharge |
      | $20.00             | $30.00              |
#    And Clear cart to empty in cart before

  @Admin @TC_Admin_deactivate_brand_check_all_screen
  Scenario: Admin_deactivate_brand_check_all_screen
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Change state of Brand id: "2820" to "active"
#    State (active, inactive)
    And Change state of product id: "6055" to "active"
#    State (active, inactive, draft)
    And Update all SKU of product "6055" to "active"

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info then system show result
      | name                 | vendorCompany | managedBy | state  | tags    |
      | Auto Create Brand 06 | [blank]       | [blank]   | Active | [blank] |
    And Go to brand detail
#    And Admin verify general information in brand detail
#      | name                 | description | microDescriptions | city    | state  | vendorCompany      | tags    |
#      | Auto Create Brand 06 | [blank]     | [blank]           | [blank] | Active | Auto_VendorCompany | [blank] |
#    Deactive brand
    And Deactivate this brand
#    And Admin verify general information in brand detail
#      | name                 | description | microDescriptions | city    | state    | vendorCompany      | tags    |
#      | Auto Create Brand 06 | [blank]     | [blank]           | [blank] | Inactive | Auto_VendorCompany | [blank] |
#    Check Product is inactive
    And ADMIN navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term          | productState | brandName            | vendorCompany      | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product6 | Inactive     | Auto Create Brand 06 | Auto_VendorCompany | Bread       | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to product detail from just searched
    And Check product not have SKU
    And Go to inactive SKU tab
    And Admin check SKU Inactive info
      | skuName               | unitUpc      | caseUpc      | status   |
      | auto_flow create sku6 | 123456789098 | 123456789098 | Inactive |
      | auto_flow create sku7 | 123456789098 | 123456789098 | Inactive |

#        Check on Vendor Dashboard
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor12@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Vendor check Brand "Auto Create Brand 06" is "not showing" on dashboard
    And Search "Products" in dashboard by name "auto_product6"
    And Check no result found

 #    Check on Head Buyer catalog
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer12@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_product6"
    And Check have no product showing
    And Search Brand item "Auto Create Brand 06"
    And Check have no brands showing
    And Go to Recommended products
    And Check have no product showing
    And Go to Promotions
    And Show detail of all promotions
    And Check SKU "auto_flow create sku6" not in of all promotions
    And Check SKU "auto_flow create sku7" not in of all promotions
    And Go to Order guide
    And Check orders in order guild
      | brandName            | productName   | skuName               | unitPerCase | orderDate | quantity | addCart  |
      | Auto Create Brand 06 | auto_product6 | auto_flow create sku7 | [blank]     | 05/09/22  | 1        | disabled |
      | Auto Create Brand 06 | auto_product6 | auto_flow create sku6 | [blank]     | 05/09/22  | 1        | disabled |
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Buyer verify order in result
      | ordered  | number     | store                       | creator         | payment | fulfillment | total  |
      | 05/09/22 | #220509886 | Auto Store North California | Bao AutoBuyer12 | Pending | Pending     | $52.00 |
    And Go to order detail with order number "220509886"
    And Check items in order detail
      | brandName            | productName   | skuName               | casePrice | quantity | total | addCart  |
      | Auto Create Brand 06 | auto_product6 | auto_flow create sku6 | $1.00     | 1        | $1.00 | disabled |
      | Auto Create Brand 06 | auto_product6 | auto_flow create sku7 | $1.00     | 1        | $1.00 | disabled |

    And BUYER Navigate to "Samples" by sidebar
    And Check first Sample request in dashboard
      | requested | number     | store                       | brand                | product       | fulfillment |
      | 05/09/22  | #220509306 | Auto Store North California | Auto Create Brand 06 | auto_product6 | Pending     |
    And Go to sample request detail with number "220509306"
    And Check items in sample request detail
      | brandName            | skuName               | status        | addCart  |
      | Auto Create Brand 06 | auto_flow create sku7 | Not Available | disabled |
      | Auto Create Brand 06 | auto_flow create sku6 | Not Available | disabled |

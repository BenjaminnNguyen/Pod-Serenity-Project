#mvn verify -Dtestsuite="VendorBrandTestSuite" -Dcucumber.options="src/test/resources/features/vendor"  -Dfailsafe.rerunFaillingTestsCount=1
@feature=VendorBrand
Feature: Vendor Brand

  @V_BRANDS_1
  Scenario: Create a brand
    Given BAO_ADMIN11 login web admin by api
      | email             | password  |
      | bao11@podfoods.co | 12345678a |
     # Delete brand
    And Admin search brand name "AAuto Vendor Create Brand" by api
    And Admin delete brand by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Click on button "New Brand"
    And Vendor create brand with info
      | brandName | description | country | state   | city    |
      | [blank]   | [blank]     | [blank] | [blank] | [blank] |
    And Check any text "is" showing on screen
      | Use this Description field to convey how you are different, including your brand positioning, mission, etc. |
      | Please input your brand name                                                                                |
      | Please select your brand located state                                                                      |
#    And Vendor close popup
#    And Click on button "New Brand"
    And Vendor create brand with info
      | brandName                   | description                            | country       | state  | city  |
      | AAuto Vendor Create Brand 1 | Auto Vendor Create Brand 1 Description | United States | Alaska | Hanoi |
    And Click on any text "Back to Brands"
    And Click on button "New Brand"
    And Vendor create brand with info
      | brandName                   | description                            | country       | state  | city  |
      | AAuto Vendor Create Brand 1 | Auto Vendor Create Brand 1 Description | United States | Alaska | Hanoi |
    And Vendor check alert message
      | Name has already been taken |
#    And Vendor close popup
#    And Click on button "New Brand"
    And Vendor create brand with info
      | brandName                   | description                            | country | state    | city |
      | AAuto Vendor Create Brand 2 | Auto Vendor Create Brand 2 Description | Canada  | Manitoba | HCM  |
    And Click on any text "Back to Brands"
    And Vendor check list brand on dashboard
      | brandName                   | description                            | address       | image              |
      | AAuto Vendor Create Brand 1 | Auto Vendor Create Brand 1 Description | Hanoi, Alaska | no_img_product.png |
      | AAuto Vendor Create Brand 2 | Auto Vendor Create Brand 2 Description | HCM, Manitoba | no_img_product.png |
    And Vendor click "Cancel" delete brand "AAuto Vendor Create Brand 2"
    And Vendor check list brand on dashboard
      | brandName                   | description                            | address       | image              |
      | AAuto Vendor Create Brand 1 | Auto Vendor Create Brand 1 Description | Hanoi, Alaska | no_img_product.png |
      | AAuto Vendor Create Brand 2 | Auto Vendor Create Brand 2 Description | HCM, Manitoba | no_img_product.png |
    And Vendor click "Remove it" delete brand "AAuto Vendor Create Brand 1"
    And Vendor check alert message
      | Deleted successfully. |
    And Check any text "not" showing on screen
      | AAuto Vendor Create Brand 1 |
    And Vendor check list brand on dashboard
      | brandName                   | description                            | address       | image              |
      | AAuto Vendor Create Brand 2 | Auto Vendor Create Brand 2 Description | HCM, Manitoba | no_img_product.png |
     # Delete brand
    And Admin search brand name "AAuto Vendor Create Brand" by api
    And Admin delete brand by API

  @V_BRANDS_2
  Scenario: Create a brand - validate
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Click on button "New Brand"
    And Vendor create brand with info
      | brandName | description | country | state   | city    |
      | [blank]   | [blank]     | [blank] | [blank] | [blank] |
    And Check any text "is" showing on screen
      | Use this Description field to convey how you are different, including your brand positioning, mission, etc. |
      | Please input your brand name                                                                                |
      | Please select your brand located state                                                                      |
    And Vendor create brand with info
      | brandName                  | description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | country       | state   | city    |
      | Auto Vendor Create Brand 1 | Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N1 | United States | Alabama | [blank] |
    And Vendor check alert message
      | Description is too long (maximum is 1000 characters) |

  @V_BRANDS_17
  Scenario: Check vendor can edit the General Information of a brand successfully
    Given BAO_ADMIN11 login web admin by api
      | email             | password  |
      | bao11@podfoods.co | 12345678a |
     # Delete brand
    And Admin search brand name "Auto Vendor Create Brand" by api
    And Admin delete brand by API
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Click on button "New Brand"
    And Vendor create brand with info
      | brandName                   | description                             | country       | state  | city  |
      | Auto Vendor Create Brand 17 | Auto Vendor Create Brand 17 Description | United States | Alaska | Hanoi |
    And Vendor check brand detail on dashboard
      | brandName                   | description                             | country | state  | city  | pricing                  |
      | Auto Vendor Create Brand 17 | Auto Vendor Create Brand 17 Description | U.S     | Alaska | Hanoi | Emerge (25% service fee) |
    And Click on button "Edit"
    And Vendor check info edit brand
      | brandName                   | description                             | country       | state  | city  |
      | Auto Vendor Create Brand 17 | Auto Vendor Create Brand 17 Description | United States | Alaska | Hanoi |
    And Vendor edit brand with info
      | brandName                        | description                                  | country | state    | city |
      | Edit Auto Vendor Create Brand 17 | Edit Auto Vendor Create Brand 17 Description | Canada  | Manitoba | HCM  |
    And Vendor check alert message
      | Updated successfully. |
    And Vendor check brand detail on dashboard
      | brandName                        | description                                  | country | state    | city | pricing                  |
      | Edit Auto Vendor Create Brand 17 | Edit Auto Vendor Create Brand 17 Description | Canada  | Manitoba | HCM  | Emerge (25% service fee) |
    And Click on button "Edit"
    And Vendor clear field "Brand name"
    And Vendor edit brand with info
      | brandName | description | country | state   | city    |
      | [blank]   | [blank]     | [blank] | [blank] | [blank] |
    And Check any text "is" showing on screen
      | Please input your brand name |
    And Vendor close popup
    And Click on button "Edit"
    And Vendor edit brand with info
      | brandName | description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | country | state   | city    |
      | [blank]   | Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. N1 | [blank] | [blank] | [blank] |
    And Vendor check alert message
      | Description is too long (maximum is 1000 characters) |
    And Vendor close popup
    And Click on button "Remove"
    And Click on dialog button "Remove it"
    And Vendor check alert message
      | Deleted successfully. |
    And Check any text "not" showing on screen
      | Auto Vendor Create Brand 17 |

  @V_BRANDS_23
  Scenario: Check redirection when click the Preview on catalog button
    Given BAO_ADMIN11 login web admin by api
      | email             | password  |
      | bao11@podfoods.co | 12345678a |
     # Delete brand
    And Admin search brand name "Auto Vendor Create Brand 23" by api
    And Admin delete brand by API
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Click on button "New Brand"
    And Vendor create brand with info
      | brandName                   | description                             | country       | state  | city  |
      | Auto Vendor Create Brand 23 | Auto Vendor Create Brand 23 Description | United States | Alaska | Hanoi |
    And Vendor check brand detail on dashboard
      | brandName                   | description                             | country | state  | city  | pricing                  |
      | Auto Vendor Create Brand 23 | Auto Vendor Create Brand 23 Description | U.S     | Alaska | Hanoi | Emerge (25% service fee) |
    And Click on any text "Preview on catalog"
    And Switch to tab by title "Auto Vendor Create Brand 23 - Pod Foods | Online Distribution Platform for Emerging Brands"
#    And Check any text "is" showing on screen
#      | No data available...          |
#      | We couldn't find any matches. |
#    And Vendor check brand detail on catalog
#      | brandName                   | city  | state  | description                             |
#      | Auto Vendor Create Brand 23 | Hanoi | Alaska | Auto Vendor Create Brand 23 Description |

  @V_BRANDS_29
  Scenario: Check uploading Logo for a brand successfully
    Given BAO_ADMIN11 login web admin by api
      | email             | password  |
      | bao11@podfoods.co | 12345678a |
     # Delete brand
    And Admin search brand name "Auto Vendor Create Brand 29" by api
    And Admin delete brand by API
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Click on button "New Brand"
    And Vendor create brand with info
      | brandName                   | description                             | country       | state  | city  |
      | Auto Vendor Create Brand 29 | Auto Vendor Create Brand 29 Description | United States | Alaska | Hanoi |
    And Vendor check brand detail on dashboard
      | brandName                   | description                             | country | state  | city  | pricing                  |
      | Auto Vendor Create Brand 29 | Auto Vendor Create Brand 29 Description | U.S     | Alaska | Hanoi | Emerge (25% service fee) |
    And Vendor upload logo image, Cover image, Photos2
      | logo     | cover     | photos           |
      | logo.jpg | cover.jpg | masterImage.jpg  |
      | [blank]  | [blank]   | featureImage.jpg |
    And Vendor check brand detail on dashboard
      | brandName                   | description                             | country       | state  | city  | pricing                  |
      | Auto Vendor Create Brand 29 | Auto Vendor Create Brand 29 Description | U.S | Alaska | Hanoi | Emerge (25% service fee) |
    And Vendor check image of brand detail on dashboard
      | logo     | coverImage | photo            |
      | logo.jpg | cover.jpg  | featureImage.jpg |
      | [blank]  | [blank]    | masterImage.jpg  |

    And Vendor upload logo image, Cover image, Photos2
      | logo            | cover   | photos  |
      | 10MBgreater.jpg | [blank] | [blank] |
    And Vendor check alert message
      | Logo attachment File size should be less than 10 MB |
    And Vendor upload logo image, Cover image, Photos2
      | logo    | cover   | photos  |
      | BOL.pdf | [blank] | [blank] |
    And Vendor check alert message
      | Logo attachment content type is invalid |
    And Vendor upload logo image, Cover image, Photos2
      | logo    | cover           | photos  |
      | [blank] | 10MBgreater.jpg | [blank] |
    And Vendor check alert message
      | Main image attachment File size should be less than 10 MB |
    And Vendor upload logo image, Cover image, Photos2
      | logo    | cover   | photos  |
      | [blank] | BOL.pdf | [blank] |
    And Vendor check alert message
      | Main image attachment content type is invalid |
    And Vendor upload logo image, Cover image, Photos2
      | logo    | cover   | photos          |
      | [blank] | [blank] | 10MBgreater.jpg |
    And Vendor check alert message
      | Sub images attachment File size should be less than 10 MB |
    And Vendor upload logo image, Cover image, Photos2
      | logo    | cover   | photos  |
      | [blank] | [blank] | BOL.pdf |
    And Vendor check alert message
      | Sub images attachment content type is invalid |
    And Vendor upload logo image, Cover image, Photos2
      | logo    | cover   | photos      |
      | [blank] | [blank] | anhJPEG.jpg |
      | [blank] | [blank] | anhJPG2.jpg |
      | [blank] | [blank] | anhPNG.png  |
    And Vendor check image of brand detail on dashboard
      | logo     | coverImage | photo            |
      | [blank]  | [blank]    | anhPNG.png       |
      | [blank]  | [blank]    | anhJPG2.jpg      |
      | [blank]  | [blank]    | anhJPEG.jpg      |
      | logo.jpg | cover.jpg  | featureImage.jpg |
      | [blank]  | [blank]    | masterImage.jpg  |
    And Vendor check disable upload photos brand
    And Vendor delete image of brand
      | photo      |
      | anhPNG.png |
    And Vendor check image of brand detail on dashboard
      | logo     | coverImage | photo            |
      | [blank]  | [blank]    | anhJPG2.jpg      |
      | [blank]  | [blank]    | anhJPEG.jpg      |
      | logo.jpg | cover.jpg  | featureImage.jpg |
      | [blank]  | [blank]    | masterImage.jpg  |

  @V_BRANDS_26
  Scenario: Verify delete a brand that has at least one product/SKU assigned to any orders
    Given BAO_ADMIN11 login web admin by api
      | email             | password  |
      | bao11@podfoods.co | 12345678a |
    And Admin search product name "Auto vendor create brand product 26" by api
    And Admin delete product name "Auto vendor create brand product 26" by api
     # Delete brand
    And Admin search brand name "Auto Vendor Create Brand 26" by api
    And Admin delete brand by API
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor66@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Click on button "New Brand"
    And Vendor create brand with info
      | brandName                   | description                             | country       | state  | city  |
      | Auto Vendor Create Brand 26 | Auto Vendor Create Brand 26 Description | United States | Alaska | Hanoi |
    And Vendor check brand detail on dashboard
      | brandName                   | description                             | country | state  | city  | pricing                  |
      | Auto Vendor Create Brand 26 | Auto Vendor Create Brand 26 Description | U.S     | Alaska | Hanoi | Emerge (25% service fee) |
    And Click on any text "New Product"
    And VENDOR Create an new Product Success
      | productName                         | brandName                   | productType | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | Auto vendor create brand product 26 | Auto Vendor Create Brand 26 | Bread       | yes         | Dairy    | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  | 10             | 10            | 10                  | 1                      | 1                    | 1                          | 1                         | 1                          | 1                |
    And Vendor upload Master case photo
      | casePack    | masterCarton |
      | anhJPEG.jpg | anhJPG2.jpg  |
    And Vendor confirm Next new Product
    And Vendor input info new SKU
      | skuName                         | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto vendor create brand sku 26 | 12        | 123123123123      | masterImage.jpg | 123123123123 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
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
    And VENDOR check dialog message
      | Are you sure all the information is accurate? Once confirmed, your product will be live and your key product information including price, UPC / EAN, case pack, and size will be locked in so that stores can benefit from consistent information. You can still request changes. Changes may take up to 90 days to process. |
    And Vendor Continue confirm publish SKU
    And Wait for create product successfully

    And VENDOR Navigate to "Brands" by sidebar
    And Vendor go to detail of brand "Auto Vendor Create Brand 26" on dashboard
    And Click on button "Remove"
    And Click on dialog button "Remove it"
    And VENDOR check alert message
      | Deleted successfully |

    Given BAO_ADMIN11 open web admin
    When BAO_ADMIN11 login to web with role Admin
    And BAO_ADMIN11 navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info
      | name                        | vendorCompany | state   | managedBy | tags    |
      | Auto Vendor Create Brand 26 | [blank]       | [blank] | [blank]   | [blank] |
    And Admin verify brand in result search
      | state    | brandName                   | pricing | address       | managedBy | launchedBy |
      | Inactive | Auto Vendor Create Brand 26 | 25.00%  | Hanoi, Alaska | [blank]   | [blank]    |
    And Go to brand detail
    And Admin verify general information in brand detail
      | name                        | description                             | microDescriptions | city  | state  | vendorCompany       | tags    | status   | inboundInventoryMOQ |
      | Auto Vendor Create Brand 26 | Auto Vendor Create Brand 26 Description | Empty             | Hanoi | Alaska | Auto vendor company | [blank] | Inactive | Empty               |
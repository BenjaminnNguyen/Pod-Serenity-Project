#mvn verify -Dtestsuite="AddToCartTestSuite" -Dcucumber.options="src/test/resources/features/addtocart"  -Dfailsafe.rerunFaillingTestsCount=1
@feature=vendorSKUDetail3
Feature: Vendor SKU Detail

  @TC_01
  Scenario: Test
#    Given VENDOR open web user
#    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Products" by sidebar
#    And Vendor go to product detail by "5933"
#    And Go to request information change
#    And Change info of SKU "Autotest SKU Ngoc01"
#      | priceNY | priceChicago | requestNote               |
#      | 201     | 101          | Auto change request price |
#    Given NGOC_ADMIN go to admin beta
#    When NGOC_ADMIN login to web with role Admin
#    And Navigate to "Change requests" to "All requests" by sidebar
#    And Search the request by info then system show result
#      | productName             | skuName             |
#      | Autotest product ngoc01 | Autotest SKU Ngoc01 |

#    Given NGOC_BUYER_NY1 open web user
#    When NGOC_BUYER_NY1 login to web with role Buyer
#    And Search Products in dashboard by name "Autotest product ngoc01"
#    And Buyer go to Product details "Autotest product ngoc01"
#   And Check icon arrow increase in "Product details"
#    And Buyer search in "Your order guide" by name "Autotest Brand Ngoc01"
#    And Check icon arrow increase in "Order Guide"
#    And Buyer go to Favorites "Autotest product ngoc01"
#    And Check icon arrow increase in "Favorites"
#
#    Given NGOC_BUYER_CHICAGO1 open web user
#    When NGOC_BUYER_CHICAGO1 login to web with role Buyer
#    And Search Products in dashboard by name "Autotest product ngoc01"
#    And Buyer go to Product details "Autotest product ngoc01"
#    And Check icon arrow increase in "Product details"
#    And Buyer search in "Your order guide" by name "Autotest Brand Ngoc01"
#    And Check icon arrow increase in "Order Guide"
#    And Buyer go to Favorites "Autotest product ngoc01"
#    And Check icon arrow increase in "Favorites"
#
#    Given NGOC_VENDOR1 open web user
#    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
#    And NGOC_VENDOR1 Navigate to "Products" by sidebar
#    And Vendor see product detail name "Autotest product ngoc01"
#    And Check icon arrow increase in "Product Details Vendor"
#    And Check icon arrow increase in "Product Details Vendor"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Products" to "All products" by sidebar
    And Search product by info then system show result
      | searchTerm              | brand                 |
      | Autotest product ngoc01 | Autotest Brand Ngoc01 |


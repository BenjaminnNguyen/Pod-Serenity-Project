#mvn verify -Dtestsuite="PromotionTestSuite2" -Dcucumber.options="src/test/resources/features/promotion"

@feature=Promotion2
Feature: Promotion2

  @Promotion @PROMOTION_78
  Scenario:Verify that admin edits information of a normal promotion successfully: Edit Name
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion Edited"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate | toDate      | showVendor | specSKU                 | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | Minus2   | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Percentage | 20     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | Minus2  | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate      | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Minus2   | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |
    And Admin edit info of promo
      | field | value       |
      | From  | currentDate |

    And Admin click Update
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |
    And Admin Close the Create promotion form
    And NGOC_ADMIN navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion Edited"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_79
  Scenario: Verify that admin edits information of a normal promotion successfully: Edit Usage limit, Case limit, Case minimum
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion Edited"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | specSKU                 | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | Minus2   | Plus2  | Yes        | Auto_Check 4 Promotions | [blank] | Percentage | 20     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | Plus2    | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | Minus2  | Plus2    | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Minus2   | Plus2  | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    And Admin edit info of promo
      | field | value |
      | From  | Plus1 |

    And Admin click Update
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Plus1   | Plus2    | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | Plus1   | Plus2    | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Plus1    | Plus2  | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |
    And Admin Close the Create promotion form
    And NGOC_ADMIN navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | currentDate | [blank]     |
    And Admin verify no data in result after search promotion

    And NGOC_ADMIN navigate to "Promotions" to "Upcoming" by sidebar
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Plus1   | Plus2    | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | Plus1   | Plus2    | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Plus1    | Plus2  | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion Edited"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_80
  Scenario: Verify that admin edits information of a normal promotion successfully: Edit promotion Type
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion Edited"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | specSKU                 | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | Minus2   | Plus2  | Yes        | Auto_Check 4 Promotions | [blank] | Percentage | 20     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | Plus2    | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | Minus2  | Plus2    | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Minus2   | Plus2  | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |
    And Admin edit info of promo
      | field | value  |
      | To    | Minus1 |

    And Admin click Update
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | Minus1   | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | Minus2  | Minus1   | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Minus2   | Minus1 | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |
    And Admin Close the Create promotion form
    And NGOC_ADMIN navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | Plus2    | [blank]     |
    And Admin verify no data in result after search promotion

    And NGOC_ADMIN navigate to "Promotions" to "Upcoming" by sidebar
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | Plus2    | [blank]     |
    And Admin verify no data in result after search promotion

    And NGOC_ADMIN navigate to "Promotions" to "Expired" by sidebar
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | Minus1   | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | Minus2  | Minus1   | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Minus2   | Minus1 | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion Edited"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_81
  Scenario: Verify that admin edits information of a normal promotion successfully, Changes region and Applied SKU is available on that new region
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer37@podfoods.co | 12345678a |
#    And Buyer set favorite product 29645 by API
#    And Buyer set favorite product 31098 by API
#    And Buyer set favorite product 31110 by API
    And Buyer set favorite product "35091" by API
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion Edited"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Percentage | 20     | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer37@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |

    Then Buyer verify no promotion requests found
    And Switch to actor NGOC_ADMIN
    And Choose regions to promo
      | region        |
      | Dallas Express |
#      | Texas Express |

    And Admin click Update
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region        | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Dallas Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
      | Auto TPR 78 Promotion | TPR  | DAL     | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |
    And Admin Close the Create promotion form

    And Switch to actor HEAD_BUYER_PE
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
      | TPR  | $8.00         | 1 Case          | [blank]   | currentDate | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Product page"
      | name                    | type | price | caseLimit |
      | Auto_Check 4 Promotions | TPR  | $8.00 | [blank]   |

    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Catalog page"
      | name                    | type | price | caseLimit |
      | Auto_Check 4 Promotions | TPR  | $8.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $8.00    | -$2.00   | $8.00    |

    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $8.00     | $8.00        | $10.00   | TPR Promotion | 20% off  | $8.00    | [blank]   | 20%                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Favorite page"
      | name                    | type | price | caseLimit |
      | Auto_Check 4 Promotions | TPR  | $8.00 | [blank]   |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion Edited"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_82
  Scenario: Verify that admin edits information of a normal promotion successfully: changes Region but Applied SKU is not available on that new region
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion Edited"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Percentage | 20     | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
      | TPR  | $8.00         | 1 Case          | [blank]   | currentDate | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Product page"
      | name                    | type | price | caseLimit |
      | Auto_Check 4 Promotions | TPR  | $8.00 | [blank]   |

    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Catalog page"
      | name                    | type | price | caseLimit |
      | Auto_Check 4 Promotions | TPR  | $8.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $8.00    | -$2.00   | $8.00    |

    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $8.00     | $8.00        | $10.00   | TPR Promotion | 20% off  | $8.00    | [blank]   | 20%                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Favorite page"
      | name                    | type | price | caseLimit |
      | Auto_Check 4 Promotions | TPR  | $8.00 | [blank]   |

    And Switch to actor NGOC_ADMIN
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
      | New York Express    |
    And Admin click Update

    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region        | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Dallas Express | currentDate | currentDate | [blank]     |
    And Admin verify no data in result after search promotion
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region           | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | New York Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | NY     | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |
    And Admin Close the Create promotion form

    And Switch to actor HEAD_BUYER_PE
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    Then Buyer verify no promotion requests found

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion Edited"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_83
  Scenario: Verify that admin edits information of a normal promotion successfully: Change the state of the "Specific SKU" so that the SKU is not active "Regions"
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |

    And Change state of SKU id: "31110" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83199 | 26        | 31110              | 1000             | 1000       | in_stock     | active |
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by skuName "Auto_Check 3 Promotions"
    And Admin delete promotion by skuName "Auto_Check 3 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion Edited"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 3 Promotions | [blank] | Percentage | 20     | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 3 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 3 Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
      | TPR  | $8.00         | 1 Case          | [blank]   | currentDate | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Product page"
      | name                    | type | price | caseLimit |
      | Auto_Check 3 Promotions | TPR  | $8.00 | [blank]   |

    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 3 Promotions" and add to cart with amount = "1"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Catalog page"
      | name                    | type | price | caseLimit |
      | Auto_Check 3 Promotions | TPR  | $8.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $8.00    | -$2.00   | $8.00    |

    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 3 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $8.00     | $8.00        | $10.00   | TPR Promotion | 20% off  | $8.00    | [blank]   | 20%                |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Change state of SKU id: "31110" to "inactive"

    And Switch to actor HEAD_BUYER_PE
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | [blank]    | [blank] |
    Then Buyer verify no promotion requests found

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check 3 Promotions"
    And Admin delete promotion by skuName "Auto_Check 3 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion Edited"
    And Admin delete promotion by skuName ""
    And Change state of SKU id: "31110" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83199 | 26        | 31110              | 1000             | 1000       | in_stock     | active |

  @Promotion @PROMOTION_84
  Scenario: Verify that admin edits information of a normal promotion successfully: Changes "Included Stores" of a promotion and Applied SKU is available on that store's region
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | Bao store | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    And Choose regions to promo
      | region              |
      | Chicagoland Express |
      | Dallas Express       |
    And Admin delete store "Bao store" in create promotion form
    And Admin edit info of promo
      | field           | value                        |
      | Included stores | Auto Store check order texas |
    And Admin click Update
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region        | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Dallas Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | DAL     | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store                        |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Auto Store check order texas |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer37@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
      | TPR  | $5.00         | 1 Case          | [blank]   | currentDate | currentDate |

    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Product page"
      | name                    | type | price | caseLimit |
      | Auto_Check 4 Promotions | TPR  | $5.00 | [blank]   |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Catalog page"
      | name                    | type | price | caseLimit |
      | Auto_Check 4 Promotions | TPR  | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | TPR Promotion | 50% off  | $5.00    | [blank]   | 50%                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Favorite page"
      | name                    | type | price | caseLimit |
      | Auto_Check 4 Promotions | TPR  | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_85
  Scenario: Verify that admin edits information of a normal promotion successfully: Changes "Included Stores" of a promotion and Applied SKU is NOT available on that store's region
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | Bao store | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    And Choose regions to promo
      | region              |
      | Chicagoland Express |
      | New York Express    |
    And Admin delete store "Bao store" in create promotion form
    And Admin edit info of promo
      | field           | value                            |
      | Included stores | Auto store3 check sample request |
    And Admin click Update
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region           | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | New York Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | NY     | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store                            |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Auto store3 check sample request |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer27@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
#    Chỉ search ra những brand có sku active trên region của buyer
    And Buyer input invalid "Brand"
      | value                |
      | Auto_Brand_Inventory |
#    Không tìm thấy brand
#    And Search promotions by info
#      | brandName            | orderBrand | time |
#      | Auto_Brand_Inventory | [blank]  | [blank]  |
#    Then Buyer verify no promotion requests found

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_86
  Scenario: Verify that admin edits information of a normal promotion successfully: Changes "Excluded Store" of a promotion
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer48@podfoods.co | 12345678a |
#    And Buyer set favorite product 29645 by API
#    And Buyer set favorite product 31098 by API
#    And Buyer set favorite product 31110 by API
    And Buyer set favorite product "35091" by API
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Percentage | 50     | Bao store    | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    And Admin delete store "Bao store" in create promotion form
    And Admin edit info of promo
      | field           | value                   |
      | Excluded stores | Auto Bao Store Express1 |
    And Admin click Update
    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo | start   | expired     |
      | Short dated | $5.00         | 1 Case          | [blank]   | [blank] | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Product page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Catalog page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | Short-dated Promotion | 50% off  | $5.00    | [blank]   | 50%                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Favorite page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_87
  Scenario: Verify that admin edits information of a normal promotion successfully: Changes "Included buyer companies" of a promotion and Applied SKU is available on that stores's region of buyer company
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Percentage | 50     | [blank]      | Auto_BuyerCompany    | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    And Admin delete store "Auto_BuyerCompany" in create promotion form
    And Admin edit info of promo
      | field                    | value             |
      | Included buyer companies | Bao Buyer Company |
    And Admin click Update
    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo | start   | expired     |
      | Short dated | $5.00         | 1 Case          | [blank]   | [blank] | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Product page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Catalog page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | Short-dated Promotion | 50% off  | $5.00    | [blank]   | 50%                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Favorite page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_88
  Scenario: Verify that admin edits information of a normal promotion successfully: Changes "Included buyer companies" of a promotion and Applied SKU is NOT available on that stores's region of buyer company
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Percentage | 50     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    And Admin delete store "Bao Buyer Company" in create promotion form
    And Admin edit info of promo
      | field                    | value             |
      | Included buyer companies | Auto_BuyerCompany |
    And Admin click Update
    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    And Buyer verify no promotion requests found
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_89
  Scenario: Verify that admin edits information of a normal promotion successfully: Changes "Excluded buyer companies" of a promotion
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Percentage | 50     | [blank]      | [blank]              | Bao Buyer Company    |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    And Admin delete store "Bao Buyer Company" in create promotion form
    And Admin edit info of promo
      | field                    | value             |
      | Excluded buyer companies | Auto_BuyerCompany |
    And Admin click Update
    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo | start   | expired     |
      | Short dated | $5.00         | 1 Case          | [blank]   | [blank] | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Product page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |

    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Catalog page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | Short-dated Promotion | 50% off  | $5.00    | [blank]   | 50%                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Favorite page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_90
  Scenario: Verify that admin edits information of a normal promotion successfully: Edit Percentage amount
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR "
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Percentage | 20     | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    And Admin edit info of promo
      | field  | value |
      | Amount | 50    |
    And Admin click Update
    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo | start   | expired     |
      | Short dated | $5.00         | 1 Case          | [blank]   | [blank] | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Product page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |

    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Catalog page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | Short-dated Promotion | 50% off  | $5.00    | [blank]   | 50%                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Favorite page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_91
  Scenario: Verify that admin edits information of a normal promotion successfully: Edit Fix rate amount
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Fix rate  | 2      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | USD  | 2      |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    And Admin edit info of promo
      | field  | value |
      | Amount | 5     |
    And Admin click Update
    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo | start   | expired     |
      | Short dated | $5.00         | 1 Case          | [blank]   | [blank] | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Product page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |

    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Catalog page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount    | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | Short-dated Promotion | -$5.00/case | $5.00    | [blank]   | -$5                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Favorite page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_92
  Scenario: Verify that admin duplicate a Buy-in promotion and not edit information
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type   | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 84 Promotion | Auto Description | Buy-in | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Fix rate  | 2      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                          | type   | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Buy-in | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type   | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Buy-in | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Admin click duplicate promotion "Auto Short-dated 84 Promotion"
    And Admin confirm duplicate promotion
    And Admin process overlap promotion
    And Search promotion by info
      | name                          | type   | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Buy-in | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type   | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Buy-in | CHI    | currentDate | currentDate | [blank]    | [blank]   |
      | Auto Short-dated 84 Promotion | Buy-in | CHI    | currentDate | currentDate | [blank]    | [blank]   |

  @Promotion @PROMOTION_93
  Scenario: Verify that admin duplicate a Short-dated promotion and edit with value information
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Buy In"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Fix rate  | 5      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Admin click duplicate promotion "Auto Short-dated 84 Promotion"
    And Admin edit info of promo
      | field | value                                |
      | Name  | Auto Short-dated 84 Promotion edited |
    And Admin edit info of promo
      | field  | value |
      | Amount | 5     |
    And Duplicate promo success
#    And Process promo success
#    And Admin confirm duplicate promotion
    And Admin process overlap promotion
    And Search promotion by info
      | name                                 | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion edited | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                                 | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion edited | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                                 | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto Short-dated 84 Promotion edited | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | USD  | 5      |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo | start   | expired     |
      | Short dated | $5.00         | 1 Case          | [blank]   | [blank] | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Product page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |

    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Catalog page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount    | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | Short-dated Promotion | -$5.00/case | $5.00    | [blank]   | -$5                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Favorite page"
      | name                    | type        | price | caseLimit |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_94
  Scenario: Verify that admin duplicate a TPR promotion and not edit information
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by product Name "Auto Check promotions"
    And Admin delete promotion by skuName "Auto Check promotions"
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Fix rate  | 5      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Admin click duplicate promotion "Auto TPR 78 Promotion"
#    And Admin edit info of promo
#      | field | value                             |
#      | Name  | Auto TPR 78 Promotion edited |
#    And Admin edit info of promo
#      | field  | value |
#      | Amount | 5     |
    And Admin confirm duplicate promotion
    And Admin process overlap promotion
    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
      | Auto TPR 78 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | USD  | 5      |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo | start   | expired     |
      | TPR  | $5.00         | 1 Case          | [blank]   | [blank] | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Product page"
      | name                    | type | price | caseLimit |
      | Auto_Check 4 Promotions | TPR  | $5.00 | [blank]   |

    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Catalog page"
      | name                    | type | price | caseLimit |
      | Auto_Check 4 Promotions | TPR  | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount    | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | TPR Promotion | -$5.00/case | $5.00    | [blank]   | -$5                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Favorite page"
      | name                    | type | price | caseLimit |
      | Auto_Check 4 Promotions | TPR  | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_95
  Scenario: Verify that admin duplicate a TPR promotion and edit with value information
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Fix rate  | 2      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Admin click duplicate promotion "Auto TPR 78 Promotion"
    And Admin edit info of promo
      | field        | value                        |
      | Name         | Auto TPR 78 Promotion edited |
      | Usage limit  | 1                            |
      | Case limit   | 1                            |
      | Case minimum | 2                            |
      | From         | Minus1                       |
      | To           | Plus1                        |
      | Amount       | 5                            |
    And Admin confirm duplicate promotion
    And Admin process overlap promotion
    And Search promotion by info
      | name                         | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR 78 Promotion edited | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus1  | Plus1    | [blank]     |
    Then Verify promotion show in All promotion page
      | name                         | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion edited | TPR  | CHI    | Minus1  | Plus1    | 1          | 1         |
    And Verify promotion info in Promotion detail
      | name                         | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR 78 Promotion edited | Auto Description | TPR  | 1          | 1         | 2           | Minus1   | Plus1  | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | USD  | 5      |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | [blank]    | [blank] |
#    And Show details of promotion then verify info
#      | type | pricePromoted | minimumPurchase | limitedTo | start  | expired |
#      | TPR  | $5.00         | 2 Case          | [blank]  | Minus1 | Plus1   |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Product page"
      | name                    | type | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | TPR  | $5.00 | 1         | 2           |

    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Catalog page"
      | name                    | type | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | TPR  | $5.00 | 1         | 2           |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $8.00    | -$2.00   | $8.00    |
#    because add cart 1 case so was be apply the fisrt promo
#But show on product detail is second promo
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount    | newPrice | caseLimit | discountThumbnails | caseMinimum |
      | $5.00     | $5.00        | $10.00   | TPR Promotion | -$5.00/case | $5.00    | 1         | -$5                | 2           |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Favorite page"
      | name                    | type | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | TPR  | $5.00 | [blank]   | 2           |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $8.00    | -$2.00   | $8.00    |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_96
  Scenario: Verify that admin duplicate a Short-dated promotion and not edit information
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by product Name "Auto Check promotions"
    And Admin delete promotion by skuName "Auto Check promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | currentDate | 2          | 2         | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Fix rate  | 2      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Admin click duplicate promotion "Auto Short-dated 84 Promotion"
    And Admin confirm duplicate promotion
    And Admin process overlap promotion
    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |

  @Promotion @PROMOTION_112_Added_12/07/22
  Scenario: Verify that admin duplicate a Short-dated promotion with case stack deal and not edit information
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by product Name "Auto Check promotions"
    And Admin delete promotion by skuName "Auto Check promotions"
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | currentDate | 2          | 2         | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Fix rate  | 2      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Admin add case stack deal to promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Create promo success

    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Admin click duplicate promotion "Auto Short-dated 84 Promotion"
    And Admin confirm duplicate promotion
    And Admin process overlap promotion
    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | 2          | 2         |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | 2          | 2         |
    And Verify promotion info in Promotion detail
      | name                          | description | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto Short-dated 84 Promotion | Test        | Short-dated | 2          | 2         | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Verify amount stack deal description
      | description                   |
      | Quantity 1 ~ 4:$10.00 USD off |
      | Quantity 5 ~ :$15.00 USD off  |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_97
  Scenario: Verify that admin duplicate a Short-dated promotion and edit with value information
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type        | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | Short-dated | Plus1     | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Fix rate  | 2      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Admin click duplicate promotion "Auto TPR 78 Promotion"
    And Admin edit info of promo
      | field        | value                        |
      | Name         | Auto TPR 78 Promotion edited |
      | Usage limit  | 1                            |
      | Case limit   | 1                            |
      | Case minimum | 2                            |
      | From         | Minus1                       |
      | To           | Plus1                        |
      | Amount       | 5                            |
    And Admin confirm duplicate promotion
    And Admin process overlap promotion
    And Search promotion by info
      | name                         | type        | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR 78 Promotion edited | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus1  | Plus1    | [blank]     |
    Then Verify promotion show in All promotion page
      | name                         | type        | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion edited | Short-dated | CHI    | Minus1  | Plus1    | 1          | 1         |
    And Verify promotion info in Promotion detail
      | name                         | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR 78 Promotion edited | Auto Description | Short-dated | 1          | 1         | 2           | Minus1   | Plus1  | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | USD  | 5      |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | [blank]    | [blank] |
#    And Show details of promotion then verify info
#      | type        | pricePromoted | minimumPurchase | limitedTo | start  | expired |
#      | Short dated | $8.00         | 2 Case          | [blank]  | Minus1 | Plus1   |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Product page"
      | name                    | type        | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | 1         | 2           |

    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Catalog page"
      | name                    | type        | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | 1         | 2           |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $8.00    | -$2.00   | $8.00    |
#    because add cart 1 case so was be apply the fisrt promo

    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount    | newPrice | caseLimit | discountThumbnails | caseMinimum |
      | $5.00     | $5.00        | $10.00   | Short-dated Promotion | -$5.00/case | $5.00    | 1         | -$5                | 2           |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Favorite page"
      | name                    | type        | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | [blank]   | 2           |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $8.00    | -$2.00   | $8.00    |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_113_Added_12/07/22
  Scenario: Verify that admin duplicate a Short-dated promotion with stack deal and edit with value information
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type        | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | Short-dated | Plus1     | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Fix rate  | 2      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Admin add case stack deal to promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 10          | 15     |
    And Create promo success

    And Search promotion by info
      | name                  | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Admin click duplicate promotion "Auto TPR 78 Promotion"
    And Admin edit info of promo
      | field        | value                        |
      | Name         | Auto TPR 78 Promotion edited |
      | Usage limit  | 1                            |
      | Case limit   | 1                            |
      | Case minimum | 2                            |
      | From         | Minus1                       |
      | To           | Plus1                        |
      | Amount       | 5                            |

    And Admin confirm duplicate promotion
    And Admin process overlap promotion
    And Search promotion by info
      | name                         | type        | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR 78 Promotion edited | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus1  | Plus1    | [blank]     |
    Then Verify promotion show in All promotion page
      | name                         | type        | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion edited | Short-dated | CHI    | Minus1  | Plus1    | 1          | 1         |
    And Verify promotion info in Promotion detail
      | name                         | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR 78 Promotion edited | Auto Description | Short-dated | 1          | 1         | 2           | Minus1   | Plus1  | is-checked | [blank] |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 2           | 5      |
      | 10          | 15     |
    And Verify amount stack deal description
      | description                   |
      | Quantity 2 ~ 9:$5.00 USD off  |
      | Quantity 10 ~ :$15.00 USD off |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 4 Promotions |

  @Promotion @PROMOTION_98
  Scenario: Verify that admin deletes a promotion successfully
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type        | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | Short-dated | Plus1     | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Fix rate  | 2      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    And Admin delete promotion name "Auto TPR 78 Promotion"

    And Search promotion by info
      | name                  | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    And Admin verify no data in result after search promotion
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_99
  Scenario: Verify displayed information of a buy-in promotion on Product details when admin set fully information for Case limit > 1, Case minimum > 1
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Buy-in 99 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR "
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Short-dated "
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                     | description      | type   | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Buy-in 99 Promotion | Auto Description | Buy-in | [blank]   | [blank]    | 2         | 2           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Fix rate  | 5      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                     | type   | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Buy-in 99 Promotion | Buy-in | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                     | type   | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Buy-in 99 Promotion | Buy-in | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type   | pricePromoted | minimumPurchase | limitedTo | start       | expired |
      | Buy in | $5.00         | 2 Case          | 2 cases   | currentDate | [blank] |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Buy in" of product "Auto Check promotions" in "Product page"
      | name                    | type   | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | BUY-IN | $5.00 | 2         | 2           |

    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 1        |
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"

    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$10.00  | $10.00   |
    Then Verify promo preview "Buy in" of product "Auto Check promotions" in "Catalog page"
      | name                    | type   | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | BUY-IN | $5.00 | 2         | 2           |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo        | discount    | newPrice | caseLimit | discountThumbnails | caseMinimum |
      | $5.00     | $5.00        | $10.00   | Buy-in Promotion | -$5.00/case | $5.00    | 2         | -$5                | 2           |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "Buy in" of product "Auto Check promotions" in "Favorite page"
      | name                    | type   | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | BUY-IN | $5.00 | 2         | 2           |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$10.00  | $10.00   |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Buy-in 99 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_102
  Scenario: Verify displayed information of a TPR promotion on Product details with information for Case limit
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 78 Promotion | Auto Description | TPR  | [blank]   | [blank]    | 2         | 2           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Fix rate  | 5      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 78 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 78 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo | start       | expired |
      | TPR  | $5.00         | 2 Case          | 2 cases   | currentDate | [blank] |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Product page"
      | name                    | type | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | TPR  | $5.00 | 2         | 2           |

    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 1        |
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"

    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$10.00  | $10.00   |
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Catalog page"
      | name                    | type | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | TPR  | $5.00 | 2         | 2           |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount    | newPrice | caseLimit | discountThumbnails | caseMinimum |
      | $5.00     | $5.00        | $10.00   | TPR Promotion | -$5.00/case | $5.00    | 2         | -$5                | 2           |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Favorite page"
      | name                    | type | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | TPR  | $5.00 | 2         | 2           |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$10.00  | $10.00   |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 78 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_105
  Scenario: Verify displayed information of a short-dated promotion on Product details when admin set information for Case limit > 1, Case minimum > 1
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 84 Promotion | Auto Description | Short-dated | currentDate | [blank]    | 2         | 2           | currentDate | currentDate | Yes        | Auto_Check 4 Promotions | [blank] | Fix rate  | 5      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 4 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 84 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 84 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo | start       | expired |
      | Short dated | $5.00         | 2 Case          | 2 cases   | currentDate | [blank] |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Product page"
      | name                    | type        | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | 2         | 2           |

    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "1"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 1        |
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price | quantity |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $5.00 | 2        |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$10.00  | $10.00   |
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Catalog page"
      | name                    | type        | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | 2         | 2           |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check 4 Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount    | newPrice | caseLimit | discountThumbnails | caseMinimum |
      | $5.00     | $5.00        | $10.00   | Short-dated Promotion | -$5.00/case | $5.00    | 2         | -$5                | 2           |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Favorite page"
      | name                    | type        | price | caseLimit | caseMinimum |
      | Auto_Check 4 Promotions | SHORT-DATED | $5.00 | 2         | 2           |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$10.00  | $10.00   |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 84 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_108
  Scenario: Admin create/edit a Pod sponsored promotion successfully: Usage limit > 1
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | 2          | [blank]   | [blank]     | Minus1   | Plus1  | [blank]    | [blank] | Bao store | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus1  | Plus1    | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | Minus1  | Plus1    | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity | specialDiscount |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        | -$10.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $20.00   | -$10.00         |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_109
  Scenario: Admin create/edit a Pod sponsored promotion successfully: Usage limit = empty
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | Bao store | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity | specialDiscount |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        | -$10.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $20.00   | -$10.00         |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_112
  Scenario: Admin create/edit a Pod sponsored promotion successfully: From < To < Current date
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | Minus2   | Minus1 | [blank]    | [blank] | Bao store | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | Minus1   | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | Minus2  | Minus1   | [blank]    | [blank]   |

    And NGOC_ADMIN navigate to "Promotions" to "Expired" by sidebar
    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | Minus1   | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | Minus2  | Minus1   | [blank]    | [blank]   |
    And NGOC_ADMIN navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | [blank]  | [blank]     |
    And Admin verify no data in result after search promotion

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $10.00   | [blank]  | $20.00   |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_113
  Scenario: Admin create/edit a Pod sponsored promotion successfully: Current date < From < To
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | Plus1    | Plus2  | [blank]    | [blank] | Bao store | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Plus1   | Plus2    | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | Plus1   | Plus2    | [blank]    | [blank]   |

    And NGOC_ADMIN navigate to "Promotions" to "Upcoming" by sidebar
    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Plus1   | Plus2    | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | Plus1   | Plus2    | [blank]    | [blank]   |
    And NGOC_ADMIN navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | [blank]  | [blank]     |
    And Admin verify no data in result after search promotion

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $10.00   | [blank]  | $20.00   |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_114
  Scenario: Admin create/edit a Pod sponsored promotion successfully: Do not select regions
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | [blank] | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                             | description      | type          | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store   | typePromo  | amount |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | [blank] | Percentage | 50     |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Admin click Update
    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region  | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | [blank] | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region      | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | All regions | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity | specialDiscount |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        | -$10.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $20.00   | -$10.00         |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_116
  Scenario: Admin create/edit a Pod sponsored promotion successfully: Select all regions
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | [blank] | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                             | description      | type          | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Choose regions to promo
      | region                         |
      | Atlanta Express                |
      | Florida Express                |
      | Denver Express                 |
      | Mid Atlantic Express           |
      | New York Express               |
      | North California Express       |
      | Phoenix Express                |
      | Sacramento Express             |
      | South California Express       |
      | Dallas Express                  |
      | Pod Direct Central             |
      | Pod Direct East           |
#      | Pod Direct Southeast           |
#      | Pod Direct Southwest & Rockies |
      | Pod Direct West                |
    And Admin click Update
    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region  | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | [blank] | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region      | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | All regions | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity | specialDiscount |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        | -$10.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $20.00   | -$10.00         |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_118
  Scenario: Admin create/edit a Pod sponsored promotion successfully: Select Included stores
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | Bao store | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region  | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | [blank] | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity | specialDiscount |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        | -$10.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $20.00   | -$10.00         |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_120
  Scenario: Admin create/edit a Pod sponsored promotion successfully: Select Excluded stores
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | [blank] | Percentage | 50     | Bao store    | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                             | type          | store     | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | Bao store | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region  | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | [blank] | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $10.00   | [blank]  | $20.00   |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_121
  Scenario: Admin create/edit a Pod sponsored promotion successfully: Select Excluded stores and included stores in the same store
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | Bao store | Percentage | 50     | Bao store    | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
    And Admin verify content of alert
      | You input conflicted promotion values. Please check the included stores (or buyer companies) and excluded stores (or buyer companies). |
    And Admin Close the Create promotion form

    And Search promotion by info
      | name                             | type          | store     | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | Bao store | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    And Admin verify no data in result after search promotion

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_123
  Scenario: Admin create/edit a Pod sponsored promotion successfully: Do not select Excluded stores
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | [blank] | Percentage | 50     | [blank]      | Bao Buyer Company    | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region  | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | [blank] | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity | specialDiscount |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        | -$10.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $20.00   | -$10.00         |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_126
  Scenario: Admin create/edit a Pod sponsored promotion successfully: Select Excluded buyer companies and Included buyer companies is the same buyer company
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | [blank] | Percentage | 50     | [blank]      | Bao Buyer Company    | Bao Buyer Company    |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
    And Admin verify content of alert
      | You input conflicted promotion values. Please check the included stores (or buyer companies) and excluded stores (or buyer companies). |
    And Admin Close the Create promotion form

    And Search promotion by info
      | name                             | type          | store     | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | Bao store | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    And Admin verify no data in result after search promotion

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_127
  Scenario:Admin create/edit a Pod sponsored promotion successfully: Amount = 100%
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given BAO_ADMIN open web admin
    When BAO_ADMIN login to web with role Admin
    And BAO_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | Bao store | Percentage | 100    | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region  | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | [blank] | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity | specialDiscount |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        | -$20.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $20.00   | -$20.00         |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_129
  Scenario: Admin edit a Pod-sponsored promotion successfully: Change Regions but Included stores/Included buyer companies NOT belong to this region
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 145 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"
    And Admin search promotion by store "2465"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | Bao store | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                             | description      | type          | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store     |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | Bao store |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Choose regions to promo
      | region               |
      | Chicagoland Express  |
      | Mid Atlantic Express |
    And Admin click Update
    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region  | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | [blank] | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | MA     | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        |
    And and verify price on cart tab on right side
      | logisticsSurcharge | smallOrderSurcharge |
      | [blank]            | $30.00              |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $10.00   | [blank]  | $20.00   |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_130
  Scenario: Admin created multiple Pod-sponsored promotion for the same Store/Buyer company
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | Bao store | Percentage | 20     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                             | description      | type          | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store     |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | Bao store |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |

    And Admin Close the Create promotion form
    And Create promotion
      | name                               | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion 2 | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | Bao store | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                               | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion   | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |
      | Auto Pod-sponsored 108 Promotion 2 | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                               | description      | type          | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store     |
      | Auto Pod-sponsored 108 Promotion 2 | Auto Description | Pod-sponsored | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | Bao store |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity | specialDiscount |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        | -$10.00         |
    And and verify price on cart tab on right side
      | logisticsSurcharge | smallOrderSurcharge | specialDiscount |
      | [blank]            | $30.00              | -$10.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $20.00   | -$10.00         |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_131
  Scenario: Admin duplicate a Pod-sponsored promotion and not edit information
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | Bao store | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                             | description      | type          | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store     |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | Bao store |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Admin Close the Create promotion form
    And Admin click duplicate promotion "Auto Pod-sponsored 108 Promotion"
    And Admin confirm duplicate promotion

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity | specialDiscount |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        | -$10.00         |
    And and verify price on cart tab on right side
      | logisticsSurcharge | smallOrderSurcharge | specialDiscount |
      | [blank]            | $30.00              | -$10.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $20.00   | -$10.00         |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_132
  Scenario: Admin duplicate a Pod-sponsored promotion and edit information with valid value
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | Bao store | Percentage | 20     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                             | description      | type          | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store     |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | Bao store |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Admin Close the Create promotion form
    And Admin click duplicate promotion "Auto Pod-sponsored 108 Promotion"
    And Admin edit info of promo
      | field  | value |
      | Amount | 50    |
    And Admin confirm duplicate promotion

    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity | specialDiscount |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        | -$10.00         |
    And and verify price on cart tab on right side
      | logisticsSurcharge | smallOrderSurcharge | specialDiscount |
      | [blank]            | $30.00              | -$10.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $20.00   | -$10.00         |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

  @Promotion @PROMOTION_133
  Scenario: Admin delete a Pod-sponsored promotion
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 108 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | Bao store | Percentage | 20     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    And Admin delete promotion name "Auto Pod-sponsored 108 Promotion"
    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 108 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    And Admin verify no data in result after search promotion

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Check promotions", sku "Auto_Check 4 Promotions" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product               | sku                     | price  | quantity |
      | Auto_Brand_Inventory | Auto Check promotions | Auto_Check 4 Promotions | $10.00 | 2        |
    And and verify price on cart tab on right side
      | logisticsSurcharge | smallOrderSurcharge |
      | [blank]            | $30.00              |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $10.00   | [blank]  | $20.00   |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 108 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 4 Promotions"
    And Admin delete promotion by skuName "Auto_Check 4 Promotions"

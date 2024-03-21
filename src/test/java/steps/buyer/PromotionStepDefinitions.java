package steps.buyer;

import cucumber.tasks.buyer.CheckoutCart;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.buyer.HandlePromotion;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.Buyer.promotion.PromotionsPage;
import cucumber.user_interface.beta.Buyer.cart.CartPage;
import cucumber.user_interface.beta.Buyer.products.BuyerProductDetailPage;
import cucumber.user_interface.beta.Buyer.cart.CheckoutPage;
import cucumber.user_interface.beta.Buyer.sampleRequest.BuyerSampleRequestDetailPage;
import cucumber.user_interface.beta.CatalogForm;
import cucumber.user_interface.beta.HomePageForm;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.hamcrest.Matchers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static cucumber.tasks.buyer.addtocart.AddToCart.chooseSKUFromProductDetail;
import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.Matchers.*;
import static org.hamcrest.Matchers.equalToIgnoringWhiteSpace;

public class PromotionStepDefinitions {

    @And("Verify promo preview {string} of product {string} in {string}")
    public void verify_promo_preview(String typePromo, String product, String page, DataTable infos) {
        List<Map<String, String>> expected = infos.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(product)),
                Scroll.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(product)),
                MoveMouse.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(product)),
                MoveMouse.to(CatalogForm.PROMO_TAG1(typePromo, product)),
                CommonWaitUntil.isVisible(CatalogForm.TAG_IN_PREVIEW)
        );
        for (int i = 0; i < expected.size(); i++) {
            HashMap<String, String> info = CommonTask.setValueRandom(expected.get(i), "name", Serenity.sessionVariableCalled("SKU inventory"));
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CatalogForm.PROMO_IN_TAG_PREVIEW(info.get("name"), "sku")).text().containsIgnoringCase(info.get("name")),
                    Ensure.that(CatalogForm.PROMO_IN_TAG_PREVIEW(info.get("name"), "promotion-type")).text().containsIgnoringCase(expected.get(i).get("type")),
                    Ensure.that(CatalogForm.PROMO_IN_TAG_PREVIEW(info.get("name"), "price")).text().contains(expected.get(i).get("price")),
                    Check.whether(expected.get(i).get("caseLimit").equals(""))
                            .otherwise(
                                    Ensure.that(CatalogForm.PROMO_IN_TAG_PREVIEW(info.get("name"), "case-limit")).text().contains(expected.get(i).get("caseLimit"))
                            )
            );
            if (expected.get(i).containsKey("caseMinimum") && !expected.get(i).get("caseMinimum").equals("")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(CatalogForm.PROMO_IN_TAG_PREVIEW(info.get("name"), "case-minimum")).text().contains(expected.get(i).get("caseMinimum"))
                );
            }
            if (expected.get(i).containsKey("oldPrice") && !expected.get(i).get("oldPrice").equals("")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(CatalogForm.PROMO_IN_TAG_PREVIEW(info.get("name"), "old")).text().contains(expected.get(i).get("oldPrice"))
                );
            }
            if (expected.get(i).containsKey("expiryDate") && !expected.get(i).get("expiryDate").equals("")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(CatalogForm.PROMO_IN_TAG_PREVIEW(info.get("name"), "expiry-date")).text().contains(CommonHandle.setDate2(expected.get(i).get("expiryDate"), "MM/dd/yy"))
                );
            }
        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(HomePageForm.ALERT),
                CommonWaitUntil.isVisible(HomePageForm.INFO_PRODUCT_IN_HEADER("Cart", "pf-ellipsis")),
                Click.on(HomePageForm.INFO_PRODUCT_IN_HEADER("Cart", "pf-ellipsis"))
        );
    }

    @And("Verify promo preview {string} of sku {string} is {string} in sample request page")
    public void verify_promo_preview2(String typePromo, String sku, String show, DataTable info) {
        List<Map<String, String>> expected = info.asMaps(String.class, String.class);
        if (show.equals("show")) {
            for (int i = 0; i < expected.size(); i++) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isNotVisible(HomePageForm.ALERT),
                        CommonWaitUntil.isVisible(BuyerSampleRequestDetailPage.SKU_NAME(sku)),
                        Scroll.to(BuyerSampleRequestDetailPage.SKU_NAME(sku)),
                        MoveMouse.to(BuyerSampleRequestDetailPage.TAG_PROMO_SKU(sku, typePromo)),
                        CommonWaitUntil.isVisible(CatalogForm.TAG_IN_PREVIEW),

//                        Ensure.that(BuyerSampleRequestDetailPage.TAG_PROMO_SKU(sku)).text().containsIgnoringCase(typePromo),
                        Ensure.that(CatalogForm.SKU_NAME_IN_PREVIEW(i + 1)).text().containsIgnoringCase(sku),
                        Ensure.that(CatalogForm.TAG_IN_PREVIEW(i + 1)).text().containsIgnoringCase(expected.get(i).get("type")),
                        Ensure.that(CatalogForm.PRICE_PROMO_IN_PREVIEW(i + 1)).text().contains(expected.get(i).get("price")),
                        Check.whether(expected.get(i).get("caseLimit").equals(""))
                                .otherwise(
                                        Ensure.that(CatalogForm.CASE_LIMIT_IN_PREVIEW(i + 1)).text().contains(expected.get(i).get("caseLimit"))
                                )
                );
                if (expected.get(i).containsKey("caseMinimum") && !expected.get(i).get("caseMinimum").equals("")) {
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(CatalogForm.CASE_MINIMUM_IN_PREVIEW(i + 1)).text().contains(expected.get(i).get("caseMinimum"))
                    );
                }
                if (expected.get(i).containsKey("expiryDate")) {
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(CatalogForm.EXPIRY_IN_PREVIEW(i + 1)).text().contains(CommonHandle.setDate2(expected.get(i).get("expiryDate"), "MM/dd/yy"))
                    );
                }
            }
        } else {
            for (int i = 0; i < expected.size(); i++) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isNotVisible(HomePageForm.ALERT),
                        CommonWaitUntil.isVisible(BuyerSampleRequestDetailPage.SKU_NAME(sku)),
                        Scroll.to(BuyerSampleRequestDetailPage.SKU_NAME(sku)),
                        Ensure.that(BuyerSampleRequestDetailPage.TAG_PROMO_SKU(sku, typePromo)).isNotDisplayed()
                );
            }
        }
    }

    @And("Verify promo preview {string} of sku {string} is {string} on add cart popup")
    public void verify_promo_preview3(String typePromo, String sku, String show, DataTable info) {
        List<Map<String, String>> expected = info.asMaps(String.class, String.class);
        if (show.equals("show")) {
            for (int i = 0; i < expected.size(); i++) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(CatalogForm.SKU_NAME_IN_PREVIEW_POPUP(sku)),
                        Scroll.to(CatalogForm.SKU_NAME_IN_PREVIEW_POPUP(sku)),
                        MoveMouse.to(CatalogForm.TAG_IN_PREVIEW_POPUP(sku, typePromo)),
                        CommonWaitUntil.isVisible(CatalogForm.TAG_IN_PREVIEW),

//                        Ensure.that(BuyerSampleRequestDetailPage.TAG_PROMO_SKU(sku)).text().containsIgnoringCase(typePromo),
                        Ensure.that(CatalogForm.SKU_NAME_IN_PREVIEW).text().containsIgnoringCase(sku),
                        Ensure.that(CatalogForm.TAG_IN_PREVIEW(i + 1)).text().containsIgnoringCase(expected.get(i).get("type")),
                        Ensure.that(CatalogForm.PRICE_PROMO_IN_PREVIEW(i + 1)).text().contains(expected.get(i).get("price")),
                        Check.whether(expected.get(i).get("caseLimit").equals(""))
                                .otherwise(
                                        Ensure.that(CatalogForm.CASE_LIMIT_IN_PREVIEW(i + 1)).text().contains(expected.get(i).get("caseLimit"))
                                ).andIfSo(
                                        Ensure.that(CatalogForm.CASE_LIMIT_IN_PREVIEW(i + 1)).isNotDisplayed())
                );
            }
        } else {
            for (int i = 0; i < expected.size(); i++) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(CatalogForm.SKU_NAME_IN_PREVIEW_POPUP(sku)),
                        Scroll.to(CatalogForm.SKU_NAME_IN_PREVIEW_POPUP(sku)),
                        Ensure.that(CatalogForm.TAG_IN_PREVIEW_POPUP(sku, typePromo)).isNotDisplayed()
                );
            }
        }
    }

    @And("Verify promo preview {string} of sku {string} is {string} on add cart popup have met MOV")
    public void verify_promo_preview4(String typePromo, String sku, String show, DataTable info) {
        List<Map<String, String>> expected = info.asMaps(String.class, String.class);
        if (show.equals("show")) {
            for (int i = 0; i < expected.size(); i++) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isVisible(CatalogForm.SKU_NAME_IN_PREVIEW_POPUP_MOV(sku)),
                        Scroll.to(CatalogForm.SKU_NAME_IN_PREVIEW_POPUP_MOV(sku)),
                        MoveMouse.to(CatalogForm.TAG_IN_PREVIEW_POPUP_MOV(sku, typePromo)),
                        CommonWaitUntil.isVisible(CatalogForm.TAG_IN_PREVIEW),

//                        Ensure.that(BuyerSampleRequestDetailPage.TAG_PROMO_SKU(sku)).text().containsIgnoringCase(typePromo),
                        Ensure.that(CatalogForm.SKU_NAME_IN_PREVIEW).text().containsIgnoringCase(sku),
                        Ensure.that(CatalogForm.TAG_IN_PREVIEW(i + 1)).text().containsIgnoringCase(expected.get(i).get("type")),
                        Ensure.that(CatalogForm.PRICE_PROMO_IN_PREVIEW(i + 1)).text().contains(expected.get(i).get("price")),
                        Check.whether(expected.get(i).get("caseLimit").equals(""))
                                .otherwise(
                                        Ensure.that(CatalogForm.CASE_LIMIT_IN_PREVIEW(i + 1)).text().contains(expected.get(i).get("caseLimit"))
                                )
                );
            }
        } else {
            for (int i = 0; i < expected.size(); i++) {
                theActorInTheSpotlight().attemptsTo(
                        CommonWaitUntil.isNotVisible(HomePageForm.ALERT),
                        CommonWaitUntil.isVisible(CatalogForm.SKU_NAME_IN_PREVIEW_POPUP_MOV(sku)),
                        Scroll.to(CatalogForm.SKU_NAME_IN_PREVIEW_POPUP_MOV(sku)),
                        Ensure.that(CatalogForm.TAG_IN_PREVIEW_POPUP_MOV(sku, typePromo)).isNotDisplayed()
                );
            }
        }
    }

    @And("Verify Express badge in promotion tab of sku {string}")
    public void verify_express_badge_in_promotion_tab(String skuName) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CatalogForm.D_EXPRESS_BADGE(skuName)),
                MoveMouse.to(CatalogForm.D_EXPRESS_BADGE(skuName)),
                Ensure.that(CatalogForm.TOOL_TIP_BADGE).isDisplayed()
        );
    }

    @And("Verify tag {string} promotion is {string} on product {string}")
    public void verifyTagPromo(String product, String tag, String status) {
        if (status.toLowerCase().equals("show"))
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isNotVisible(HomePageForm.ALERT),
                    Ensure.that(CatalogForm.PROMO_TAG(tag, product)).isDisplayed()
            );
        else theActorInTheSpotlight().attemptsTo(
                Ensure.that(CatalogForm.PROMO_TAG(tag, product)).isNotDisplayed()
        );
    }

    @And("Verify Promotional Discount in {string}")
    public void verify_promo_discount(String type, DataTable infos) {
        List<Map<String, String>> expected = infos.asMaps(String.class, String.class);
        if (type.equals("details")) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(CommonQuestions.isControlDisplay(HomePageForm.VIEW_CART_BUTTON)).andIfSo(
                            Click.on(HomePageForm.VIEW_CART_BUTTON),
                            CommonWaitUntil.isVisible(CartPage.CHECKOUT_BUTTON),
                            CheckoutCart.closePopup()
                    ),
                    Ensure.that(CartPage.PRICE_DISCOUNT_IN_SKU).text().contains(expected.get(0).get("priceSKU")),
                    Ensure.that(CartPage.PRICE_DISCOUNT_TOTAL_IN_SKU).text().contains(expected.get(0).get("totalSKU"))
            );

            if (expected.get(0).containsKey("oldPrice")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(CartPage.PRICE_BEFORE_DISCOUNT_SKU), equalToIgnoringCase(expected.get(0).get("oldPrice")))
                );
            }

            if (expected.get(0).containsKey("oldTotalPrice")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(CartPage.ORIGINAL_PRICE_DISCOUNT_TOTAL), equalToIgnoringCase(expected.get(0).get("oldTotalPrice")))
                );
            }
        }
        if (type.equals("before cart")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(HomePageForm.PRICE_DISCOUNT_IN_SKU).text().contains(expected.get(0).get("priceSKU")),
                    Ensure.that(HomePageForm.PRICE_DISCOUNT_TOTAL_IN_SKU).text().contains(expected.get(0).get("totalSKU"))
            );
            if (expected.get(0).containsKey("oldPrice")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(HomePageForm.PRICE_BEFORE_DISCOUNT_SKU), equalToIgnoringCase(expected.get(0).get("oldPrice")))
                );
            }
            if (expected.get(0).containsKey("oldTotalPrice")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(HomePageForm.ORIGINAL_PRICE_DISCOUNT_TOTAL), equalToIgnoringCase(expected.get(0).get("oldTotalPrice")))
                );
            }
        }
        if (!expected.get(0).get("discount").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(HomePageForm.CART_DISCOUNT_BEFORE), equalToIgnoringCase(expected.get(0).get("discount")))
            );
        }
        if (expected.get(0).containsKey("specialDiscount")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(HomePageForm.CART_SPECIAL_DISCOUNT_BEFORE), equalToIgnoringCase(expected.get(0).get("specialDiscount")))
            );
        }
        if (expected.get(0).containsKey("orderValue")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(HomePageForm.ORDER_VALUE), equalToIgnoringCase(expected.get(0).get("orderValue")))
            );
        }
        if (expected.get(0).containsKey("cartTotal")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(HomePageForm.CART_TOTAL), equalToIgnoringCase(expected.get(0).get("cartTotal")))
            );
        }
    }


    @And("Verify Promotional Discount of {string} and sku {string} in product detail")
    public void verify_promo_discount_in_sku_detail(String productName, String skuName, DataTable infos) {
        List<Map<String, String>> expected = infos.asMaps(String.class, String.class);
        String idSKU = Serenity.sessionVariableCalled("ID SKU Admin");
        if (skuName.equals("random")) {
            skuName = Serenity.sessionVariableCalled("SKU inventory");
        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(HomePageForm.ALERT),
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                Click.on(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                Check.whether(skuName.isEmpty())
                        .andIfSo(
                                chooseSKUFromProductDetail(idSKU)
                        )
                        .otherwise(
                                chooseSKUFromProductDetail(skuName)
                        )
        );
        theActorInTheSpotlight().should(
//                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.UNIT_PRICE_PROMOTED), equalToIgnoringCase(expected.get(0).get("unitPrice"))),
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.CASE_PRICE_PROMOTED(skuName)), equalToIgnoringCase(expected.get(0).get("currentPrice"))),
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.TYPE_PROMOTION(skuName)), equalToIgnoringCase(expected.get(0).get("typePromo"))),
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.DISCOUNT_THUMBNAIL), equalToIgnoringCase(expected.get(0).get("discountThumbnails")))
        );
        if (expected.get(0).containsKey("discount") && !expected.get(0).get("discount").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.DISCOUNT_PROMOTION(skuName)), equalToIgnoringCase(expected.get(0).get("discount")))
            );
        }
        if (expected.get(0).containsKey("newPrice") && !expected.get(0).get("newPrice").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.NEW_PRICE_PROMOTION(skuName)), containsString(expected.get(0).get("newPrice")))
            );
        }
        if (expected.get(0).containsKey("oldPrice") && !expected.get(0).get("oldPrice").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.OLD_PRICE_PROMOTION(skuName)), equalToIgnoringCase(expected.get(0).get("oldPrice")))
            );
        }
        if (expected.get(0).containsKey("caseLimit") && !expected.get(0).get("caseLimit").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.CASE_LIMIT_PROMOTION(skuName)), containsString(expected.get(0).get("caseLimit")))
            );
        }
        if (expected.get(0).containsKey("caseMinimum") && !expected.get(0).get("caseMinimum").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.CASE_MINIMUM_PROMOTION(skuName)), containsString(expected.get(0).get("caseMinimum")))
            );
        }
        if (expected.get(0).containsKey("expireDate") && !expected.get(0).get("expireDate").isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerProductDetailPage.EXPIRE_DATE(skuName)).text().contains(CommonHandle.setDate2(expected.get(0).get("expireDate"), "MM/dd/yy"))
            );
        }
    }

    @And("Verify Stack case promotion on product detail")
    public void verify_price_promo_product_detail(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.STACK_DEAL(i + 1)), containsString(infos.get(i).get("stackCase")))
            );
    }

    @And("Verify price promo in order buyer is {string}")
    public void verify_price_promo_in_order_buyer(String pricePromo) {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(CheckoutPage.PROMOTION_ORDER), containsString(pricePromo))
        );
    }

    @And("Verify price promo in Invoice is {string}")
    public void verify_price_promo_in_cart_invoice(String pricePromo) {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(CheckoutPage.PROMOTION_INVOICE), containsString(pricePromo))
        );
    }

    @And("Search promotions by info")
    public void search_promotion_by_brand(DataTable data) {
        List<Map<String, String>> infos = data.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandlePromotion.search(infos.get(0))
        );
    }

    @And("Show details of promotion then verify info")
    public void show_detail_of_promotion(DataTable data) {
        List<Map<String, String>> expected = data.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            String startDate = CommonHandle.setDate2(expected.get(i).get("start"), "MM/dd/yy");
            String endDate = CommonHandle.setDate2(expected.get(i).get("expired"), "MM/dd/yy");
            theActorInTheSpotlight().attemptsTo(
                    HandlePromotion.showDetail(i + 1)
            );
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(PromotionsPage.TYPE_PROMO(i + 1)).text().contains(expected.get(i).get("type")),
                    Ensure.that(PromotionsPage.PRICE_PROMOTED).text().contains(expected.get(i).get("pricePromoted")),
                    Ensure.that(PromotionsPage.MININUM_PURCHASE).text().contains(expected.get(i).get("minimumPurchase")),
                    Check.whether(expected.get(i).get("limitedTo").equals(""))
                            .otherwise(Ensure.that(PromotionsPage.LIMITED_TO).text().contains(expected.get(i).get("limitedTo"))),
                    Ensure.that(PromotionsPage.EFFECTIVE_DATE).text().contains(startDate),
                    Check.whether(endDate.equals(""))
                            .otherwise(Ensure.that(PromotionsPage.EFFECTIVE_DATE).text().contains(endDate))

            );
            if (expected.get(0).containsKey("skuExpiryDate")) {
                if (!expected.get(0).get("skuExpiryDate").isEmpty())
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.targetText(PromotionsPage.SKU_EXPIRY_DATE), equalToIgnoringCase(CommonHandle.setDate2(expected.get(i).get("skuExpiryDate"), "MM/dd/yy")))
                    );
            }
        }
    }

    @And("Verify stack case detail on Promotion tab")
    public void detail_of_promotion(DataTable data) {
        List<Map<String, String>> expected = data.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(PromotionsPage.STACK_CASE_DETAIL(i + 1)), Matchers.containsString(expected.get(i).get("stackCase")))
            );
        }
    }

    @And("Verify Case Stack Deals on cart detail tab")
    public void caseStackDealCartDetail(DataTable data) {
        List<Map<String, String>> expected = data.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(PromotionsPage.STACK_CASE_DETAIL_CART_DETAIL()), containsString(expected.get(i).get("stackCase"))),
                    seeThat(CommonQuestions.targetText(PromotionsPage.STACK_CASE_DETAIL_CART_DETAIL()), containsString(expected.get(i).get("discount")))
            );
        }
    }

    @And("Buyer onboard verify tab promotion not show")
    public void buyer_onboard_verify_tab_promotion_not_show() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(PromotionsPage.PROMOTIONS("promotions")).isNotDisplayed()
        );
    }

    @And("Buyer verify no promotion requests found")
    public void verify_no_promotion_request_found() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(PromotionsPage.NO_PROMOTION_FOUND),
                Ensure.that(PromotionsPage.NO_PROMOTION_FOUND).isDisplayed()
        );
    }

    @And("Buyer verify brand {string} not display in promotion tab")
    public void verify_brand_not_display_in_promotion_tab(String brand) {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(PromotionsPage.BRAND_IN_PROMO_TAB(brand)).isNotDisplayed()
        );
    }

    @And("Buyer verify default value and placeholder of the search box")
    public void verify_default_value_and_placeholder_of_the_search_box() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(PromotionsPage.BRAND_TEXTBOX).attribute("placeholder").contains("Type to select")
        );
    }

    @And("Buyer verify total of promotion in promotion tab is {string}")
    public void verify_total_of_promotion_in_promotion_tab(String total) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(PromotionsPage.TOTAL_PROMOTION_TEXT),
                Ensure.that(PromotionsPage.TOTAL_PROMOTION_TEXT).text().contains(total)
        );
    }

    @And("Buyer verify text {string} in tab promotion")
    public void verify_text_order_before_in_tab_promotion(String message) {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(PromotionsPage.TEXT_ORDER_BEFORE).isDisplayed()
        );
    }

    @And("Buyer click {word} name and verify info")
    public void click_name_and_verify_info(String type, DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(type.equals("SKU"))
                        .andIfSo(
                                Click.on(PromotionsPage.SKU_IN_DETAIL))
                        .otherwise(
                                Click.on(PromotionsPage.PRODUCT_IN_DETAIL)),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.LOADING_PRODUCT)
        );
        theActorInTheSpotlight().attemptsTo(
//                Ensure.that(BuyerProductDetailPage.UNIT_PRICE_PROMOTED).text().contains(expected.get(0).get("unitPrice")),
                Ensure.that(BuyerProductDetailPage.CASE_PRICE_PROMOTED).text().contains(expected.get(0).get("casePrice")),
                Ensure.that(BuyerProductDetailPage.TYPE_PROMOTION).text().contains(expected.get(0).get("typePromo")),
                Ensure.that(BuyerProductDetailPage.DISCOUNT_PROMOTION).text().contains(expected.get(0).get("discount")),
                Ensure.that(BuyerProductDetailPage.NEW_PRICE_PROMOTION).text().contains(expected.get(0).get("newPrice")),
                Ensure.that(BuyerProductDetailPage.CASE_LIMIT_PROMOTION).text().contains(expected.get(0).get("caseLimit")),
                Ensure.that(BuyerProductDetailPage.DISCOUNT_THUMBNAIL).text().contains(expected.get(0).get("discountThumbnails"))
        );
        if (expected.get(0).containsKey("expireDate")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerProductDetailPage.EXPIRE_DATE).text().contains(CommonHandle.setDate2(expected.get(0).get("expireDate"), "MM/dd/yy"))
            );
        }
    }

    @And("Buyer add to card sku {string} from promo detail")
    public void buyer_add_to_card_sku_from_promo_detail(String sku) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(PromotionsPage.SHOW_DETAILS(1))).andIfSo(
                        HandlePromotion.showDetail(1)
                ),
                CommonWaitUntil.isVisible(PromotionsPage.D_ADD_TO_CART(sku)),
                Click.on(PromotionsPage.D_ADD_TO_CART(sku)),
                WindowTask.threadSleep(1000),
                // check popup confirm nếu SKU hết hạn
                Check.whether(CommonQuestions.isControlDisplay(PromotionsPage.POPUP_CONFIRM))
                        .andIfSo(
                                Click.on(PromotionsPage.POPUP_CONFIRM),
                                CommonWaitUntil.isNotVisible(PromotionsPage.MESSAGE_ADD_TO_CART)
                        )
        );
    }

    @And("Buyer verify add to card button of sku {string} from promo detail is {string} display")
    public void buyer_verify_add_to_card_sku_from_promo_detail_is_display(String sku, String isDisplay) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(isDisplay.equals(""))
                        .andIfSo(Ensure.that(PromotionsPage.D_ADD_TO_CART(sku)).isDisplayed())
                        .otherwise(Ensure.that(PromotionsPage.D_ADD_TO_CART(sku)).isNotDisplayed())
        );
    }

    @And("{word} show details of promotion with no applied product found")
    public void show_detail_of_promotion_with_no_applied_product_found(String actor) {
        theActorCalled(actor).attemptsTo(
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(PromotionsPage.SHOW_DETAILS(1)),
                Click.on(PromotionsPage.SHOW_DETAILS(1)),
                CommonWaitUntil.isVisible(PromotionsPage.NO_APPLIED_PRODUCT_FOUND),
                Ensure.that(PromotionsPage.NO_APPLIED_PRODUCT_FOUND).isDisplayed()
        );

    }

    @And("Buyer verify Promotional Discount of sku {string} in product detail")
    public void buyer_verify_promo_discount_in_product_detail(String skuName, DataTable infos) {
        List<Map<String, String>> expected = infos.asMaps(String.class, String.class);
        if (skuName.equals("random")) {
            skuName = Serenity.sessionVariableCalled("SKU inventory");
        }
        if (skuName.isEmpty())
            skuName = Serenity.sessionVariableCalled("ID SKU Admin");
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(HomePageForm.ALERT),
                chooseSKUFromProductDetail(skuName)
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.CASE_PRICE_PROMOTED(skuName)), equalToIgnoringCase(expected.get(0).get("currentPrice"))),
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.TYPE_PROMOTION(skuName)), equalToIgnoringCase(expected.get(0).get("typePromo"))),
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.DISCOUNT_THUMBNAIL), equalToIgnoringCase(expected.get(0).get("discountThumbnails")))
        );
        if (expected.get(0).containsKey("tag") && !expected.get(0).get("tag").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.TYPE_PROMOTION_TAG(skuName)), equalToIgnoringCase(expected.get(0).get("tag")))
            );
        }
        if (expected.get(0).containsKey("discount") && !expected.get(0).get("discount").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.DISCOUNT_PROMOTION(skuName)), equalToIgnoringCase(expected.get(0).get("discount")))
            );
        }
        if (expected.get(0).containsKey("newPrice") && !expected.get(0).get("newPrice").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.NEW_PRICE_PROMOTION(skuName)), containsString(expected.get(0).get("newPrice")))
            );
        }
        if (expected.get(0).containsKey("oldPrice") && !expected.get(0).get("oldPrice").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.OLD_PRICE_PROMOTION(skuName)), equalToIgnoringCase(expected.get(0).get("oldPrice")))
            );
        }
        if (expected.get(0).containsKey("caseLimit") && !expected.get(0).get("caseLimit").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.CASE_LIMIT_PROMOTION(skuName)), containsString(expected.get(0).get("caseLimit")))
            );
        }
        if (expected.get(0).containsKey("caseMinimum") && !expected.get(0).get("caseMinimum").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(BuyerProductDetailPage.CASE_MINIMUM_PROMOTION(skuName)), containsString(expected.get(0).get("caseMinimum")))
            );
        }
        if (expected.get(0).containsKey("expireDate") && !expected.get(0).get("expireDate").isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerProductDetailPage.EXPIRE_DATE(skuName)).text().contains(CommonHandle.setDate2(expected.get(0).get("expireDate"), "MM/dd/yy"))
            );
        }
    }

}

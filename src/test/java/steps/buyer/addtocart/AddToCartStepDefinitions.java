package steps.buyer.addtocart;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.buyer.addtocart.AddToCart;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.buyer.BuyerCatalogTask;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.Utility;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.Buyer.products.BuyerProductDetailPage;
import cucumber.user_interface.beta.Buyer.cart.CartPage;
import cucumber.user_interface.beta.Buyer.cart.CheckoutPage;
import cucumber.user_interface.beta.CatalogForm;
import cucumber.user_interface.beta.DashBoardForm;
import cucumber.user_interface.beta.HomePageForm;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.hamcrest.Matchers;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActor;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.Matchers.equalToIgnoringCase;

public class AddToCartStepDefinitions {
    @And("Search {word} by name {string}, sku {string} and add to cart with amount = {string}")
    public void search_by_name(String typeSearch, String valueSearch, String name, String amount) {
        if (name.equals("random")) {
            name = Serenity.sessionVariableCalled("SKU inventory");
        }
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue(typeSearch, valueSearch)
        );
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(2000),
                AddToCart.chooseProductToAdd(valueSearch, name)
        );
        theActorInTheSpotlight().attemptsTo(
                AddToCart.addFromPopupCart(name, amount)
        );
        theActorInTheSpotlight().attemptsTo(
                AddToCart.checkAddToCartSuccess(name)
        );
    }

    @And("Buyer search and add to cart")
    public void buyer_search_and_add_to_cart(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            String name = info.get("name");
            if (name.equals("random")) {
                name = Serenity.sessionVariableCalled("SKU inventory");
            }
            theActorInTheSpotlight().attemptsTo(
                    AddToCart.searchByValue1(info.get("typeSearch"), info.get("typeSort"), info.get("valueSearch"))
            );
            theActorInTheSpotlight().attemptsTo(
                    WindowTask.threadSleep(2000),
                    AddToCart.chooseProductToAdd(info.get("valueSearch"), info.get("brand"), name)
            );
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(info.get("typeSearchSKU").equals("relative"))
                            .andIfSo(AddToCart.addFromPopupCart(name, info.get("amount")))
                            .otherwise(AddToCart.addFromPopupCart1(name, info.get("amount")))
            );
            theActorInTheSpotlight().attemptsTo(
                    AddToCart.checkAddToCartSuccess(name)
            );
        }

    }

    @And("Verify info product in popup cart")
    public void verify_info_in_popup_cart(String product, DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(HomePageForm.CART_COUNTER_IN_HEADER), containsString(expected.get(0).get("quantity"))),
                seeThat(CommonQuestions.isControlDisplay(HomePageForm.INFO_PRODUCT_IN_HEADER(expected.get(0).get("brand"), "brand"))),
                seeThat(CommonQuestions.isControlDisplay(HomePageForm.INFO_PRODUCT_IN_HEADER(expected.get(0).get("name"), "name"))),
                seeThat(CommonQuestions.isControlDisplay(HomePageForm.INFO_PRODUCT_IN_HEADER(expected.get(0).get("variant"), "variant"))),
                seeThat(CommonQuestions.targetText(HomePageForm.DESCRIPTION_PRODUCT_IN_HEADER(product, "case-price")), containsString(expected.get(0).get("casePrice"))),
                seeThat(CommonQuestions.targetText(HomePageForm.DESCRIPTION_PRODUCT_IN_HEADER(product, "quantity")), containsString(expected.get(0).get("quantity"))),
                seeThat(CommonQuestions.targetText(HomePageForm.TOTAL_PRODUCT_IN_HEADER(product, "total")), containsString(expected.get(0).get("total")))
        );
    }

    @And("Verify report price in popup cart")
    public void verify_report_price_in_popup_cart(String product, DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        // verify Total
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(HomePageForm.TOTAL_IN_HEADER), containsString(expected.get(0).get("total")))
        );

        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(HomePageForm.REPORT_IN_HEADER("Order Value")), containsString(expected.get(0).get("orderValue"))),
                seeThat(CommonQuestions.targetText(HomePageForm.REPORT_IN_HEADER("Items Subtotal")), containsString(expected.get(0).get("subTotal"))),
                seeThat(CommonQuestions.targetText(HomePageForm.REPORT_IN_HEADER("Small Order Surcharge")), containsString(expected.get(0).get("smallOrderSurcharge"))),
                seeThat(CommonQuestions.targetText(HomePageForm.REPORT_IN_HEADER("Logistics Surcharge")), containsString(expected.get(0).get("logisticsSurcharge")))
        );
    }

    @And("Verify price in cart {string}")
    public void verify_price_in_cart_before(String type, DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(list.get(0).get("smallOrderSurchage").isEmpty())
                        .andIfSo(Ensure.that(HomePageForm.CART_SOS_BEFORE).isNotDisplayed())
                        .otherwise(Ensure.that(HomePageForm.CART_SOS_BEFORE).text().contains(list.get(0).get("smallOrderSurchage"))),
                Check.whether(list.get(0).get("logisticsSurchage").isEmpty())
                        .otherwise(Ensure.that(HomePageForm.CART_LS_BEFORE).text().contains(list.get(0).get("logisticsSurchage"))),
                Check.whether(list.get(0).get("tax").isEmpty())
                        .otherwise(Ensure.that(HomePageForm.CART_TAX_BEFORE).text().contains(list.get(0).get("tax"))),
                Check.whether(list.get(0).get("total").isEmpty())
                        .andIfSo(Ensure.that(HomePageForm.CART_TOTAL_BEFORE).isNotDisplayed())
                        .otherwise(Ensure.that(HomePageForm.CART_TOTAL_BEFORE).text().contains(list.get(0).get("total")))
        );
        if (list.get(0).containsKey("specialDiscount")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(HomePageForm.CART_SPECIAL_DISCOUNT_BEFORE).text().contains(list.get(0).get("specialDiscount"))
            );
        }
        if (list.get(0).containsKey("discount")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(HomePageForm.CART_DISCOUNT_BEFORE).text().contains(list.get(0).get("discount"))
            );
        }
        if (list.get(0).containsKey("orderValue")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(HomePageForm.CART_ORDER_BEFORE).text().contains(list.get(0).get("orderValue"))
            );
        }
    }

    @And("Verify price in cart {string} not display and total = {string}")
    public void verify_price_in_cart_before(String type, String priceTotal) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(type.equals("details"))
                        .andIfSo(
                                Click.on(HomePageForm.VIEW_CART_BUTTON),
                                CommonWaitUntil.isVisible(CartPage.CHECKOUT_BUTTON))
        );
        List<WebElementFacade> lsCartBefore = HomePageForm.CART_LS_BEFORE.resolveAllFor(theActorInTheSpotlight());
        theActorInTheSpotlight().attemptsTo(
                Check.whether(lsCartBefore.size() != 0)
                        .andIfSo(Ensure.that(HomePageForm.CART_LS_BEFORE).isNotDisplayed())
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(HomePageForm.CART_TOTAL_BEFORE), containsString(priceTotal))
        );
    }

    @And("Clear cart to empty in cart before")
    public void clear_cart_to_empty_in_cart_before() {
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(3000),
                AddToCart.removeItemInCartBefore()
        );
    }

    @And("Verify price in sub-invoice not display and total = {string}")
    public void verify_price_in_sub_invoice(String priceTotal) {
        List<WebElementFacade> lsCartBefore = CheckoutPage.CART_SOS_INVOICE.resolveAllFor(theActorInTheSpotlight());
        theActorInTheSpotlight().attemptsTo(
                Check.whether(lsCartBefore.size() != 0)
                        .andIfSo(Ensure.that(CheckoutPage.CART_SOS_INVOICE).isNotDisplayed())
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(CheckoutPage.TOTAL_INVOICE), containsString(priceTotal))
        );
    }

    @And("Add to cart the sku {string} with quantity = {string}")
    public void addToCartFromDetail(String skuName, String amount) {
        theActorInTheSpotlight().attemptsTo(
//                AddToCart.removeItemInCartBefore(),
                AddToCart.addFromProductDetail(skuName, amount)
        );
    }

    @And("Buyer update cart of MOV alert with info")
    public void buyer_update_cart_of_MOV_alert_with_info(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    AddToCart.changeQuanityOfSkuInMovAlert(item)
            );
        }
    }

    @And("Buyer add sku to cart in popup cart")
    public void buyer_add_sku_to_cart_in_popup_cart(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    AddToCart.changeQuanityOfSkuInPopupCart(item)
            );
        }
    }

    @And("Buyer update cart of MOV alert success")
    public void buyer_update_cart_of_MOV_alert_success() {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.updateCartFromPopupMovAlertSuccess()
        );
    }

    @And("Buyer add to cart in popup cart")
    public void buyer_add_to_cart_in_popup_cart() {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.updateCartFromPopupPopupCartSuccess()
        );
    }

    @And("Verify item on cart tab on right side")
    public void verify_cart_right_side(DataTable items) {
        List<Map<String, String>> list = items.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    WindowTask.threadSleep(1000),
                    CommonWaitUntil.isVisible(HomePageForm.VIEW_CART_BUTTON)
            );
//            if (!HomePageForm.ITEM_CART_QUANTITY(i).resolveFor(theActorInTheSpotlight()).isClickable()) {
//                theActorInTheSpotlight().attemptsTo(
//                        Scroll.to(HomePageForm.ITEM_CART_QUANTITY(i))
//                );
//            }
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(HomePageForm.ITEM_CART_QUANTITY(i)),
                    Ensure.that(HomePageForm.ITEM_CART_BRAND_NAME2(i)).text().contains(list.get(i).get("brand")),
                    Ensure.that(HomePageForm.ITEM_CART_PRODUCT_NAME(i, list.get(i).get("product"))).text().contains(list.get(i).get("product")),
                    Ensure.that(HomePageForm.ITEM_CART_SKU_NAME(i, list.get(i).get("sku"))).text().contains(list.get(i).get("sku")),
                    Ensure.that(HomePageForm.ITEM_CART_QUANTITY(i)).attribute("value").contains(list.get(i).get("quantity"))
            );

            if (list.get(i).containsKey("price")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(HomePageForm.ITEM_CART_PRICE(i)).text().contains(list.get(i).get("price"))
                );
            }
            if (list.get(i).containsKey("oldPrice")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(HomePageForm.ITEM_CART_OLD_PRICE(i)).text().contains(list.get(i).get("oldPrice"))
                );
            }
            if (list.get(i).containsKey("newPrice")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(HomePageForm.ITEM_CART_NEW_PRICE(i)).text().contains(list.get(i).get("newPrice"))
                );
            }
            if (list.get(i).containsKey("total")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(HomePageForm.ITEM_CART_ITEM_TOTAL(i)).text().contains(list.get(i).get("total"))
                );
            }
            if (list.get(i).containsKey("moq")) {
                theActorInTheSpotlight().attemptsTo(
                        Check.whether(list.get(i).get("moq").isEmpty())
                                .otherwise(Ensure.that(HomePageForm.ITEM_CART_MOQ(i)).text().contains(list.get(i).get("moq")))
                );
            }
            if (list.get(i).containsKey("skuID")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(HomePageForm.ITEM_CART_SKU_ID(i)).text().contains(list.get(i).get("skuID"))
                );
            }
        }
    }

    /*
     * Check cả total , order values...
     * chỉ truyền smallOrderSurcharge, logisticsSurcharge
     * */
    @And("and verify price on cart tab on right side")
    public void verify_price_cart_right_side(DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);
        List<WebElementFacade> total = HomePageForm.LIST_TOTAL_PRICE_OF_ITEM.resolveAllFor(theActorInTheSpotlight());
        double a = 0;
        for (WebElementFacade e : total) {
            a = a + Utility.convertPriceToDouble(e.getText());
        }
        double cartTotal = a + Utility.convertPriceToDouble(list.get(0).get("smallOrderSurcharge")) + Utility.convertPriceToDouble(list.get(0).get("logisticsSurcharge"));

        if (list.get(0).containsKey("specialDiscount")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(HomePageForm.CART_SPECIAL_DISCOUNT_BEFORE), equalToIgnoringCase(list.get(0).get("specialDiscount")))
            );
            cartTotal = cartTotal - Utility.convertPriceToDouble(list.get(0).get("specialDiscount"));
        }
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(HomePageForm.ORDER_VALUE), equalTo(Utility.convertDoubleToPrice(a))),
                seeThat(CommonQuestions.targetText(HomePageForm.ITEMS_SUBTOTAL), equalTo(Utility.convertDoubleToPrice(a))),
                seeThat(CommonQuestions.targetText(HomePageForm.SMALL_ORDER_SURCHARGE), containsString(list.get(0).get("smallOrderSurcharge"))),
//                seeThat(CommonQuestions.targetText(HomePageForm.LOGISTICS_SURCHARGE), containsString(list.get(0).get("logisticsSurcharge"))),
                seeThat(CommonQuestions.targetText(HomePageForm.CART_TOTAL), equalTo(Utility.convertDoubleToPrice(cartTotal)))
        );
    }

    @And("{word} go to catalog {string}")
    public void go_to_catalog_all(String actor, String category) {
        theActor(actor).attemptsTo(
                Click.on(CatalogForm.CATALOG_MENU),
                CommonWaitUntil.isVisible(CatalogForm.CATALOG_MENU_ITEM(category)),
                Click.on(CatalogForm.CATALOG_MENU_ITEM(category)),
                WindowTask.threadSleep(2000)
        );
    }

    @And("Add product {string} to favorite")
    public void add_product_to_favorite(String productName) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(BuyerProductDetailPage.ICON_HEART)).andIfSo(
                        Click.on(BuyerProductDetailPage.ICON_ADD_TO_FAVORITES)
                ),
                Click.on(DashBoardForm.FAVORITE_BUTTON),
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName))
        );
    }

    @And("Go to favorite page of {string}")
    public void go_to_favorite_page(String productName) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(DashBoardForm.FAVORITE_BUTTON),
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName))
        );
    }

    @And("Remove product {string} from favorite")
    public void remove_product_to_favorite(String productName) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(DashBoardForm.FAVORITE_BUTTON),
                Scroll.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                MoveMouse.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                MoveMouse.to(HomePageForm.HEART_ANIMATED(productName)),
                Click.on(HomePageForm.HEART_ANIMATED(productName)),
                Click.on(HomePageForm.CONFIRM_REMOVE)

        );
    }

    @And("Go to Cart detail")
    public void goToCartDetail() {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.goToCartDetailPage()
        );
    }

    @And("Buyer close recommended items modal")
    public void close_recommended_item_modal() {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.closeRecommendedItemsModal()
        );
    }

    @And("Buyer close SOS popup")
    public void closeSOSpopup() {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.closeSOS()
        );
    }

    @And("Check item in Cart detail")
    public void checkItemInCartDetail(DataTable items) {
        List<Map<String, String>> list = items.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).get("product").isEmpty()) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.isControlUnDisplay(CartPage.ITEM_CART_PRODUCT_NAME(i)))
                );
            } else
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(CartPage.ITEM_CART_BRAND_NAME(i)), containsString(list.get(i).get("brand"))),
                        seeThat(CommonQuestions.targetText(CartPage.ITEM_CART_PRODUCT_NAME(i)), containsString(list.get(i).get("product"))),
                        seeThat(CommonQuestions.targetText(CartPage.ITEM_CART_SKU_NAME(i)), containsString(list.get(i).get("sku"))),
                        seeThat(CommonQuestions.targetText(CartPage.ITEM_CART_PRICE(i)), containsString(list.get(i).get("price"))),
                        seeThat(CommonQuestions.targetText(CartPage.ITEM_CART_ITEM_TOTAL(i)), containsString(list.get(i).get("total"))),
                        seeThat(CommonQuestions.attributeText(CartPage.ITEM_CART_QUANTITY(i), "value"), containsString(list.get(i).get("quantity")))
//                    seeThat(CommonQuestions.targetText(CartPage.ITEM_CART_ITEM_TOTAL(i)), containsString(Utility.convertDoubleToPrice(Double.parseDouble(list.get(i).get("quantity")) * Utility.convertPriceToDouble(list.get(i).get("price")))))
                );
        }
    }

    @And("Update quantity item {string} to {string} in Cart detail")
    public void updateQuantityOfItemInCartDetail(String sku, String qty) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isEnabled(CartPage.ITEM_CART_QUANTITY(sku)),
                WindowTask.threadSleep(1000),
                Clear.field(CartPage.ITEM_CART_QUANTITY(sku)),
                Enter.theValue(qty).into(CartPage.ITEM_CART_QUANTITY(sku)).thenHit(Keys.TAB),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.LOADING_BAR),
                WindowTask.threadSleep(2000),
                CommonWaitUntil.isClickable(CartPage.CHECKOUT_BUTTON)
        );
    }

    @And("and check price on cart detail")
    public void verify_price_cart_detail(DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);
        List<WebElementFacade> total = CartPage.TOTAL_PRICE_OF_ITEM.resolveAllFor(theActorInTheSpotlight());
        double a = 0;
        for (WebElementFacade e : total) {
            a = a + Utility.convertPriceToDouble(e.getText());
        }
        if (!list.get(0).get("smallOrderSurcharge").isEmpty() && !list.get(0).get("logisticsSurcharge").isEmpty()) {
            double cartTotal = a + Utility.convertPriceToDouble(list.get(0).get("smallOrderSurcharge")) + Utility.convertPriceToDouble(list.get(0).get("logisticsSurcharge"));
//            theActorInTheSpotlight().should(
//                    seeThat(CommonQuestions.targetText(CartPage.ORDER_VALUE), equalTo(Utility.convertDoubleToPrice(a))),
//                    seeThat(CommonQuestions.targetText(CartPage.ITEMS_SUBTOTAL), equalTo(Utility.convertDoubleToPrice(a))),
//                    seeThat(CommonQuestions.targetText(CartPage.SMALL_ORDER_SURCHARGE), containsString(list.get(0).get("smallOrderSurcharge"))),
////                    seeThat(CommonQuestions.targetText(CartPage.LOGISTICS_SURCHARGE), containsString(list.get(0).get("logisticsSurcharge"))),
//                    seeThat(CommonQuestions.targetText(CartPage.CART_TOTAL), equalTo(Utility.convertDoubleToPrice(cartTotal)))
//            );
        }
    }

    @And("Buyer search {word} by name {string} and pre order with info")
    public void pre_order_from_catalog(String typeSearch, String valueSearch, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps();
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue(typeSearch, valueSearch),
                AddToCart.chooseProductToPreOrder(valueSearch, list.get(0).get("sku"))
        );
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    AddToCart.enterAmountOfSku(item.get("sku"), item.get("amount"))
            );
        }
        theActorInTheSpotlight().attemptsTo(
                AddToCart.createPreOrderSuccess()
        );
    }

    @And("Check MOQ alert")
    public void check_moq_alert(DataTable table) {
        List<Map<String, String>> list = table.asMaps();
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(CartPage.MOQ_ALERT), equalTo("MOQ Alert")),
                seeThat(CommonQuestions.targetText(CartPage.MOQ_ALERT_QUANTITY), equalTo(list.get(0).get("quantity"))),
                seeThat(CommonQuestions.targetText(CartPage.MOQ_ALERT_NOTICE), equalTo(list.get(0).get("notice"))),
                seeThat(CommonQuestions.targetText(CartPage.MOQ_ALERT_CASE_MORE), equalTo(list.get(0).get("caseMore")))
        );
    }

    @And("Buyer verify MOV alert in popup cart")
    public void buyer_verify_moq_alert_in_popup_cart(DataTable table) {
        List<Map<String, String>> list = table.asMaps();
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(CartPage.MOV_ALERT), equalTo(list.get(0).get("title"))),
                seeThat(CommonQuestions.targetText(CartPage.MOV_ALERT_CASE_MORE_POPUP_CART), equalTo(list.get(0).get("more")))
        );
    }

    @And("Check Items in MOQ alert")
    public void check_items_moq_alert(DataTable table) {
        List<Map<String, String>> list = table.asMaps();
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(CartPage.MOQ_ALERT_PRODUCT_NAME(i + 1)), equalToIgnoringCase(list.get(i).get("productName"))),
                    seeThat(CommonQuestions.targetText(CartPage.MOQ_ALERT_SKU_NAME(i + 1)), equalToIgnoringCase(list.get(i).get("skuName"))),
                    seeThat(CommonQuestions.targetText(CartPage.MOQ_ALERT_UNIT_PER_CASE(i + 1)), equalToIgnoringCase(list.get(i).get("unitCase"))),
                    seeThat(CommonQuestions.targetText(CartPage.MOQ_ALERT_PRICE(i + 1)), equalToIgnoringCase(list.get(i).get("price"))),
                    seeThat(CommonQuestions.targetValue(CartPage.MOQ_ALERT_QUANTITY_FIELD(i + 1)), equalToIgnoringCase(list.get(i).get("quantity")))
            );
        }
    }

    @And("Check Items in MOQ alert have promo")
    public void check_items_moq_alert_have_promo(DataTable table) {
        List<Map<String, String>> list = table.asMaps();
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(CartPage.MOQ_ALERT_PRODUCT_NAME(i + 1)), equalToIgnoringCase(list.get(i).get("productName"))),
                    seeThat(CommonQuestions.targetText(CartPage.MOQ_ALERT_SKU_NAME(i + 1)), equalToIgnoringCase(list.get(i).get("skuName"))),
                    seeThat(CommonQuestions.targetText(CartPage.MOQ_ALERT_UNIT_PER_CASE(i + 1)), equalToIgnoringCase(list.get(i).get("unitCase"))),
                    seeThat(CommonQuestions.targetText(CartPage.MOQ_ALERT_PRICE_OLD(i + 1)), equalToIgnoringCase(list.get(i).get("oldPrice"))),
                    seeThat(CommonQuestions.targetText(CartPage.MOQ_ALERT_PRICE_NEW(i + 1)), equalToIgnoringCase(list.get(i).get("newPrice"))),
                    seeThat(CommonQuestions.targetValue(CartPage.MOQ_ALERT_QUANTITY_FIELD(i + 1)), equalToIgnoringCase(list.get(i).get("quantity")))
            );
        }
    }

    @And("Check button update cart is {string} in {word} alert")
    public void check_button_update_moq_alert(String status, String type) {
        if (status.equalsIgnoreCase("disabled")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(CartPage.MOQ_ALERT_UPDATE_CART, "class"), containsString(status))
            );
        }
    }

    @And("Change quantity of skus in {word} alert")
    public void change_quantity_moq_alert(String type, DataTable table) {
        List<Map<String, String>> list = table.asMaps();
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    Enter.theValue(item.get("quantity")).into(CartPage.MOQ_ALERT_QUANTITY_FIELD(item.get("skuName"))).thenHit(Keys.TAB)
            );
        }
    }

    @And("Check notice disappear in {word} alert")
    public void change_quantity_moq_alert(String moq) {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(CartPage.MOQ_ALERT_NOTICE), equalTo(false))
        );
    }

    @And("Close MOQ alert")
    public void close_moq_alert() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(CartPage.MOQ_ALERT_CLOSE),
                CommonWaitUntil.isNotVisible(CartPage.MOQ_ALERT)
        );
    }

    @And("Check MOQ alert on cart page")
    public void check_moq_alert_cart_page(DataTable table) {
        List<Map<String, String>> moq = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(CartPage.MOQ_ALERT_CART_DETAIL), equalTo(Boolean.parseBoolean(moq.get(0).get("alert")))),
                seeThat(CommonQuestions.isControlDisplay(CartPage.MOQ_ALERT_NOTCE_CART_DETAIL), equalTo(Boolean.parseBoolean(moq.get(0).get("notice")))),
                seeThat(CommonQuestions.targetText(CartPage.MOQ_CART_DETAIL), equalToIgnoringCase(moq.get(0).get("moq")))
        );
    }

    @And("Update cart MOQ Alert")
    public void update_cart_moq_alert() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CartPage.MOQ_ALERT_UPDATE_CART),
                Click.on(CartPage.MOQ_ALERT_UPDATE_CART)
//                CommonWaitUntil.isNotVisible(CartPage.MOQ_ALERT)
        );
    }

    @And("Check out this order")
    public void check_out_order() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CartPage.CHECKOUT_BUTTON),
                Click.on(CartPage.CHECKOUT_BUTTON),
                CommonWaitUntil.isNotVisible(CheckoutPage.PAYMENT_METHOD_DROPDOWN)
        );
    }

    @And("Verify in pre-order detail of SKU {string} of product {string}")
    public void verify_pre_order_in_cart_detail(String skuName, String product, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
//                AddToCart.searchByValue("Products", product),
                BuyerCatalogTask.go_to_product(product),
                //choose a flavor
                CommonWaitUntil.isVisible(BuyerProductDetailPage.SKU_IN_DETAIL(skuName)),
                Scroll.to(BuyerProductDetailPage.SKU_IN_DETAIL(skuName)),
                Click.on(BuyerProductDetailPage.SKU_IN_DETAIL(skuName))
//                CommonTask.chooseItemInDropdown(BuyerProductDetailPage.CHOOSE_A_FLAVOR, BuyerProductDetailPage.SKU_NAME(skuName))
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(BuyerProductDetailPage.AVAILABILITY), equalToIgnoringCase(infos.get(0).get("availability"))),
                seeThat(CommonQuestions.isControlDisplay(BuyerProductDetailPage.DYNAMIC_BUTTON(infos.get(0).get("button"))))
        );
    }

    @And("Search and check mov when add cart product from popup")
    public void add_cart_check_mov(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue("Products", infos.get(0).get("sku")),
                WindowTask.threadSleep(2000),
                AddToCart.chooseProductToAdd(infos.get(0).get("product"), infos.get(0).get("sku")),
                AddToCart.addFromPopupCart(infos.get(0).get("sku"), infos.get(0).get("amount"))
        );
    }

    @And("Buyer choose items an add cart product from popup")
    public void choose_item_add_cart(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        for (Map<String, String> map : infos)
            theActorInTheSpotlight().attemptsTo(
                    AddToCart.chooseItemAddCartPopup(map.get("sku"), map.get("amount"))
            );
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isDisabled(HomePageForm.ADD_TO_CART_BUTTON_IN_POPUP)).otherwise(
                        Click.on(HomePageForm.ADD_TO_CART_BUTTON_IN_POPUP)
                )
        );
    }

    @And("Search and check moq when add cart product from popup")
    public void add_cart_check_moq(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue("Products", infos.get(0).get("sku")),
                WindowTask.threadSleep(2000),
                AddToCart.justUpdateQuantityFromPopupCart(infos.get(0).get("product"), infos.get(0).get("sku"), infos.get(0).get("amount"))
        );
    }

    @And("Add cart from product detail")
    public void go_to_detail_and_add_cart(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                BuyerCatalogTask.go_to_product(infos.get(0).get("product"))
        );
        for (Map<String, String> map : infos) {
            theActorInTheSpotlight().attemptsTo(
                    AddToCart.addFromProductDetail(map.get("sku"), map.get("amount"))
            );
        }
    }

    @And("Check MOV not met")
    public void check_mov(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        if (!infos.get(0).get("message").isEmpty() && !infos.get(0).get("counter").isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CartPage.MOV_ALERT_ADD_CART),
                    Ensure.that(CartPage.MOV_ALERT_ADD_CART).text().containsIgnoringCase(infos.get(0).get("message")),
                    Ensure.that(CartPage.MOV_ALERT_COUNTER_ADD_CART).text().containsIgnoringCase(infos.get(0).get("counter")),
                    Ensure.that(CartPage.UPDATE_ALERT_ADD_CART).isDisabled()
            );
        } else {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlUnDisplay(CartPage.PD_MOV_ALERT_CART_DETAIL))
//                    seeThat(CommonQuestions.isControlUnDisplay(CartPage.MOV_ALERT_COUNTER_ADD_CART))
            );
        }
    }
//    @And("Check MOV alert on header catalog")
//    public void check_mov_header(DataTable table) {
//        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
//        if (!infos.get(0).get("message").isEmpty() && !infos.get(0).get("counter").isEmpty()) {
//            theActorInTheSpotlight().attemptsTo(
//                    CommonWaitUntil.isVisible(CartPage.MOV_ALERT_ADD_CART),
//                    Ensure.that(CartPage.MOV_ALERT_ADD_CART).text().containsIgnoringCase(infos.get(0).get("message")),
//                    Ensure.that(CartPage.MOV_ALERT_COUNTER_ADD_CART).text().containsIgnoringCase(infos.get(0).get("counter")),
//                    Ensure.that(CartPage.UPDATE_ALERT_ADD_CART).isDisabled()
//            );
//        } else {
//            theActorInTheSpotlight().should(
//                    seeThat(CommonQuestions.isControlUnDisplay(CartPage.MOV_ALERT_ADD_CART)),
//                    seeThat(CommonQuestions.isControlUnDisplay(CartPage.MOV_ALERT_COUNTER_ADD_CART))
//            );
//        }
//    }

    @And("Check MOQ not met")
    public void check_moq(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        if (!infos.get(0).get("message").isEmpty() && !infos.get(0).get("counter").isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CartPage.MOV_ALERT_ADD_CART).text().contains(infos.get(0).get("message")),
                    Ensure.that(CartPage.MOV_ALERT_COUNTER_ADD_CART).text().contains(infos.get(0).get("counter"))
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CartPage.MOV_ALERT_ADD_CART).isNotDisplayed(),
                    Ensure.that(CartPage.MOV_ALERT_COUNTER_ADD_CART).isNotDisplayed()
            );
        }
    }

    @And("Check MOQ not met of {string}")
    public void check_moq(String item, DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        if (!infos.get(0).get("message").isEmpty() && !infos.get(0).get("counter").isEmpty()) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CartPage.MOV_ALERT_ADD_CART_DIRECT(item)).text().contains(infos.get(0).get("message")),
                    Ensure.that(CartPage.MOV_ALERT_COUNTER_ADD_CART_DIRECT(item)).text().contains(infos.get(0).get("counter"))
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CartPage.MOV_ALERT_ADD_CART_DIRECT(item)).isNotDisplayed(),
                    Ensure.that(CartPage.MOV_ALERT_COUNTER_ADD_CART_DIRECT(item)).isNotDisplayed()
            );
        }
    }

    @And("Close popup add cart")
    public void closeAddCart() {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.closeAddCart()
        );
    }

    @And("Check MOV not met in cart detail")
    public void check_mov_cart_detail(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        if (!infos.get(0).get("message").isEmpty() && !infos.get(0).get("counter").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(CartPage.MOV_MOQ_ALERT_CART_DETAIL), Matchers.containsString(infos.get(0).get("message"))),
                    seeThat(CommonQuestions.targetText(CartPage.MOV_ALERT_CART_DETAIL_COUNTER), Matchers.containsString(infos.get(0).get("counter")))
            );
        } else {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlUnDisplay(CartPage.PD_MOV_ALERT_CART_DETAIL))
//                    seeThat(CommonQuestions.isControlUnDisplay(CartPage.MOV_ALERT_CART_DETAIL_COUNTER))
            );
        }
    }

    @And("Check MOQ not met in cart detail")
    public void check_moq_cart_detail(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++) {
            if (!infos.get(i).get("message").isEmpty() && !infos.get(i).get("counter").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(CartPage.MOV_MOQ_ALERT_CART_DETAIL(infos.get(i).get("sku"))).text().contains(infos.get(i).get("message")),
                        Ensure.that(CartPage.MOQ_ALERT_CART_DETAIL_COUNTER(infos.get(i).get("sku"))).text().contains(infos.get(i).get("counter"))
                );
            } else {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(CartPage.MOV_MOQ_ALERT_CART_DETAIL(infos.get(i).get("sku"))).isNotDisplayed()
                );
            }
        }
    }

    @And("Verify alert validation field")
    public void verifyAlertValidation(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonBuyerPage.ALERT),
                Ensure.that(CommonQuestions.targetText(CommonBuyerPage.ALERT).answeredBy(theActorInTheSpotlight())).contains(message)
        );
    }

    @And("Buyer verify popup add to cart pre order of product {string} with sku {string}")
    public void buyer_verify_popup_pre_order(String product, String skuName) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue("Products", product),
                AddToCart.openPopupAddToCart(product)
        );

    }

    @And("Buyer add cart product {string} from popup")
    public void buyer_open_popup_add_cart(String product) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.openPopupAddToCart(product)
        );
    }

    @And("Search product by name {string}, sku {string} and verify message {string}")
    public void buyerr_search_sku_and_verify(String product, String sku, String message) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue("product", product),
                WindowTask.threadSleep(2000),
                AddToCart.chooseProductToAdd(product, sku),
                // Verify
                Ensure.that(HomePageForm.MESSAGE_OUT_STOCK_OF_SKU(sku)).text().contains(message),
                Ensure.that(HomePageForm.ADD_TO_CART_DISABLE).isDisplayed()
        );
    }

    @And("Head buyer verify cart button is not display")
    public void head_buyer_verify_cart_button_is_not_display() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(BuyerProductDetailPage.ADD_TO_CART_BUTTON).isNotDisplayed()
        );
    }

    @And("Buyer change quantity of sku with info")
    public void buyer_change_quantity_of_sku_with_info(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                AddToCart.changeQuantityInBeforeCheckout(infos.get(0))
        );
    }

    @And("Buyer change quantity of sku by button in before cart")
    public void buyer_change_quantity_of_sku_by_button_in_before_cart(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                AddToCart.changeQuantityInBeforeCheckoutByButton(infos.get(0))
        );
    }

    @And("Buyer verify message after change quantity in before cart is {string}")
    public void buyer_verify_message_after_change_quantiry_in_before_cart(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonBuyerPage.D_MESSAGE_POPUP(message)),
                Ensure.that(CommonBuyerPage.D_MESSAGE_POPUP(message)).isDisplayed(),
                CommonWaitUntil.isNotVisible(CommonBuyerPage.D_MESSAGE_POPUP(message))
        );
    }

    @And("Buyer verify mov alert in catalog")
    public void buyer_verify_mov_alert_in_catalog(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(HomePageForm.TITLE_MOV_ALERT_CATALOG),
                Ensure.that(HomePageForm.TITLE_MOV_ALERT_CATALOG).text().contains(infos.get(0).get("title")),
                Ensure.that(HomePageForm.DESCRIPTION_MOV_ALERT_CATALOG).text().contains(infos.get(0).get("description")),
                Ensure.that(HomePageForm.BRAND_MOV_ALERT_CATALOG).text().contains(infos.get(0).get("brand")),
                Ensure.that(HomePageForm.CURRENT_MOV_ALERT_CATALOG).text().contains(infos.get(0).get("current")),
                Ensure.that(HomePageForm.TARGET_MOV_ALERT_CATALOG).text().contains(infos.get(0).get("target"))
        );
    }

    @And("Buyer verify not meet mov alert in catalog")
    public void buyer_verify_not_meet_mov_alert_in_catalog() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(HomePageForm.TITLE_MOV_ALERT_CATALOG).isNotDisplayed()
        );
    }

    @And("Buyer verify button Explore SKUs from this brand of product {string}")
    public void buyer_verify_button_explore_sku_from_this_brand(String productName) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(HomePageForm.EXPLORE_BUTTON_MOV_ALERT_CATALOG),
                Click.on(HomePageForm.EXPLORE_BUTTON_MOV_ALERT_CATALOG),
                CommonWaitUntil.isNotVisible(HomePageForm.EXPLORE_BUTTON_MOV_ALERT_CATALOG),
                CommonWaitUntil.isVisible(HomePageForm.VENDOR_COMPANY_HEADER),
                Ensure.that(HomePageForm.VENDOR_COMPANY_HEADER).text().contains(productName)
        );
    }

    @And("Buyer click on remove button of sku {string}")
    public void buyer_click_on_remove(String skuID) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.removeItemSpecThenCancelInCartBefore(skuID)
        );
    }

    @And("Buyer remove sku {string} in before cart")
    public void buyer_remove_sku_in_before_cart(String skuID) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.removeItemSpecInCartBefore(skuID)
        );
    }

    @And("Buyer remove sku {string} in cart detail")
    public void buyer_remove_sku_in_cart_detail(String skuName) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.removeItemSpecInCartDetail(skuName)
        );
    }

    @And("Buyer verify your cart is empty page")
    public void buyer_verify_your_cart_is_empty_page() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CartPage.CART_EMPTY_TITLE),
                Ensure.that(CartPage.CART_EMPTY_TITLE).isDisplayed(),
                Ensure.that(CartPage.CART_EMPTY_DESCRIPTION).isDisplayed(),
                Ensure.that(CartPage.CART_EMPTY_START_SHOPPING_BUTTON).isDisplayed()
        );
    }

    @And("Buyer verify message remove SOS {string}")
    public void buyer_verify_message_remove_sos(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CartPage.MESSAGE_REMOVE_SOS),
                Ensure.that(CartPage.MESSAGE_REMOVE_SOS).text().contains(message)
        );
    }

    @And("Buyer verify message remove SOS is not display")
    public void buyer_verify_message_remove_sos_is_not_display() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(CartPage.MESSAGE_REMOVE_SOS).isNotDisplayed()
        );
    }

    /**
     * Recomment item modal
     */

    @And("Buyer verify recommended item modal is not display")
    public void buyer_verify_recommended_item_modal_is_not_display() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CartPage.CHECKOUT_BUTTON),
                Ensure.that(CartPage.RECOMMEND_ITEM_POPUP).isNotDisplayed()
        );
    }

    @And("Buyer verify recommended item modal")
    public void buyer_verify_recommended_item_modal(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CartPage.RECOMMEND_ITEM_POPUP),
                Ensure.that(CartPage.RECOMMEND_ITEM_POPUP_TITLE).text().contains(infos.get(0).get("title")),
                Ensure.that(CartPage.RECOMMEND_ITEM_POPUP_REMAIN_MONEY).text().contains(infos.get(0).get("remainMoney")),
                Check.whether(infos.get(0).get("minimumOrderValue").isEmpty())
                        .andIfSo(Ensure.that(CartPage.RECOMMEND_ITEM_POPUP_MINIMUM_ORDER_VALUE).isNotDisplayed())
                        .otherwise(Ensure.that(CartPage.RECOMMEND_ITEM_POPUP_MINIMUM_ORDER_VALUE).text().contains(infos.get(0).get("minimumOrderValue")))
        );
    }

    @And("Buyer verify sku in recommended item modal")
    public void buyer_verify_sku_in_recommended_item_modal(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CartPage.RECOMMEND_ITEM_POPUP),
                    Ensure.that(CartPage.RECOMMEND_ITEM_POPUP_ITEM_SKU(info.get("sku"))).text().contains(info.get("sku")),
                    Ensure.that(CartPage.RECOMMEND_ITEM_POPUP_ITEM_PRODUCT(info.get("sku"))).text().contains(info.get("product")),
                    Ensure.that(CartPage.RECOMMEND_ITEM_POPUP_ITEM_QUANTITY(info.get("sku"))).attribute("value").contains(info.get("quantity"))
            );
            if (info.containsKey("newPrice")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(CartPage.RECOMMEND_ITEM_POPUP_ITEM_NEW_PRICE(info.get("sku"))).text().contains(info.get("newPrice")),
                        Ensure.that(CartPage.RECOMMEND_ITEM_POPUP_ITEM_OLD_PRICE(info.get("sku"))).text().contains(info.get("price"))
                );
            } else {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(CartPage.RECOMMEND_ITEM_POPUP_ITEM_PRICE(info.get("sku"))).text().contains(info.get("price"))
                );
            }
        }
    }

    @And("Buyer close popup recommended item modal")
    public void buyer_close_popup_recommended_item_modal() {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.closeRecommendedItemsModal()
        );
    }

    @And("Buyer verify sku in recommended items slider")
    public void buyer_verify_sku_in_recommended_item_slider(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CartPage.RECOMMEND_ITEM_SLIDE_ITEM_SKU(info.get("sku"))).text().contains(info.get("sku")),
                    Ensure.that(CartPage.RECOMMEND_ITEM_SLIDE_ITEM_PRODUCT(info.get("sku"))).text().contains(info.get("product")),
                    Ensure.that(CartPage.RECOMMEND_ITEM_SLIDE_ITEM_CASE(info.get("sku"))).text().contains(info.get("case"))
            );
            if (info.containsKey("newPrice")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(CartPage.RECOMMEND_ITEM_SLIDE_ITEM_NEW_PRICE(info.get("sku"))).text().contains(info.get("newPrice")),
                        Ensure.that(CartPage.RECOMMEND_ITEM_SLIDE_ITEM_OLD_PRICE(info.get("sku"))).text().contains(info.get("price"))
                );
            } else {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(CartPage.RECOMMEND_ITEM_SLIDE_ITEM_PRICE(info.get("sku"))).text().contains(info.get("price"))
                );
            }

            if (info.containsKey("promo")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(CartPage.RECOMMEND_ITEM_SLIDE_PROMO(info.get("sku"), info.get("promo"))).text().contains(info.get("promo"))
                );
            }
        }

    }

    @And("Buyer slide to first sku in recommended items slider")
    public void buyer_slide_to_first_of_sku_in_recommended_item_slider() {
        theActorInTheSpotlight().attemptsTo(
                // Slide to first element in slider
                Drag.from(CartPage.SLIDE_ACTIVE).to(CartPage.SLIDE_NEXT),
                WindowTask.threadSleep(1000),
                Drag.from(CartPage.SLIDE_ACTIVE).to(CartPage.SLIDE_NEXT),
                WindowTask.threadSleep(1000)
        );
    }

    @And("Buyer verify promotion of sku in recommended items slider")
    public void buyer_verify_promotion_of_sku_in_recommended_item_slider(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                MoveMouse.to(CartPage.RECOMMEND_ITEM_SLIDE_PROMO1(infos.get(0).get("sku"))),
                CommonWaitUntil.isVisible(CartPage.SLIDE_PROMO_TOOLTIP_SKU(infos.get(0).get("sku"))),
                Ensure.that(CartPage.SLIDE_PROMO_TOOLTIP_SKU(infos.get(0).get("sku"))).text().contains(infos.get(0).get("sku")),
                Ensure.that(CartPage.SLIDE_PROMO_TOOLTIP_PROMOTION_TYPE(infos.get(0).get("sku"))).text().contains(infos.get(0).get("promoType")),
                Ensure.that(CartPage.SLIDE_PROMO_TOOLTIP_CURRENT_PRICE(infos.get(0).get("sku"))).text().contains(infos.get(0).get("newPrice")),
                Ensure.that(CartPage.SLIDE_PROMO_TOOLTIP_OLD_PRICE(infos.get(0).get("sku"))).text().contains(infos.get(0).get("oldPrice")),
                Check.whether(infos.get(0).get("expiryDate").isEmpty())
                        .otherwise(Ensure.that(CartPage.SLIDE_PROMO_TOOLTIP_EXPIRY_DATE(infos.get(0).get("sku"))).text().contains(CommonHandle.setDate2(infos.get(0).get("expiryDate"), "MM/dd/yy")))
        );
    }

    @And("Buyer verify recommended item slide is not display")
    public void buyer_verify_recommended_item_slide_is_not_display() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(CartPage.RECOMMEND_ITEM_SLIDE),
                Ensure.that(CartPage.RECOMMEND_ITEM_SLIDE).isNotDisplayed()
        );
    }

    @And("Buyer choose sku in recommended item modal in Cart detail")
    public void buyer_choose_sku_in_recommended_item_modal(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                AddToCart.AddSkuInRecommendedItemModal(infos)
        );
    }

    @And("Buyer verify save for later item in Cart detail")
    public void verify_save_for_later_item(DataTable items) {
        List<Map<String, String>> infos = items.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CartPage.SAVE_FOR_LATER_SKU(info.get("sku"))),
                    Ensure.that(CartPage.SAVE_FOR_LATER_SKU(info.get("sku"))).text().contains(info.get("sku")),
                    Ensure.that(CartPage.SAVE_FOR_LATER_PRODUCT(info.get("sku"))).text().contains(info.get("product")),
                    Ensure.that(CartPage.SAVE_FOR_LATER_BRAND(info.get("sku"))).text().contains(info.get("brand")),
                    Ensure.that(CartPage.SAVE_FOR_LATER_SKU_ID(info.get("sku"))).text().contains(info.get("skuID")),
                    Ensure.that(CartPage.SAVE_FOR_LATER_DELETE_BUTTON(info.get("sku"))).isDisplayed(),
                    Ensure.that(CartPage.SAVE_FOR_LATER_DELETE_FIND(info.get("sku"))).isDisplayed()
            );
            if (info.containsKey("available")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(CartPage.SAVE_FOR_LATER_PRICING(info.get("sku"))).isDisplayed(),
                        Ensure.that(CartPage.SAVE_FOR_LATER_MOVE_DISABLE(info.get("sku"))).isDisplayed()
                );
            }
        }
    }

    @And("Buyer verify save for later item not available")
    public void verify_save_for_later_item_not_available(DataTable items) {
        List<Map<String, String>> infos = items.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CartPage.SAVE_FOR_LATER_NOT_AVAILABLE(info.get("sku"))),
                    Ensure.that(CartPage.SAVE_FOR_LATER_MOVE_DISABLE(info.get("sku"))).isDisplayed()
            );
        }
    }

    @And("Buyer save for later sku {string} in cart detail")
    public void save_for_later_item(String sku) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.saveForLater(sku)
        );
    }

    @And("Buyer move to cart sku {string} in saved for later")
    public void move_cart_save_for_later_item(String sku) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.moveCartSaveForLater(sku)
        );
    }

    @And("Guest search product in catalog")
    public void guest_search_product_in_catalog(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue1(infos.get(0).get("typeSearch"), infos.get(0).get("typeSort"), infos.get(0).get("valueSearch"))
        );
    }


}

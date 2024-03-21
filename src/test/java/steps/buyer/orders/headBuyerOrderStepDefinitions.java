package steps.buyer.orders;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.tasks.vendor.orders.HandleHBuyerCreateOrder;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.orders.VendorCreateOrderPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class headBuyerOrderStepDefinitions {

    @And("Head buyer go to create multi order")
    public void head_buyer_go_to_create_order() {
        theActorInTheSpotlight().attemptsTo(
                HandleHBuyerCreateOrder.goToCreate()
        );
    }

    @And("Head buyer add store to create multi order")
    public void head_buyer_add_store_to_create_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleHBuyerCreateOrder.addStore(infos)
        );
    }

    @And("Head buyer remove added store create multi order")
    public void head_buyer_remove_add_store_to_create_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleHBuyerCreateOrder.removeStore(infos)
        );
    }

    @And("Head buyer go to add sku to create multi order")
    public void head_buyer_go_to_add_sku() {
        theActorInTheSpotlight().attemptsTo(
                HandleHBuyerCreateOrder.goToAddSku()
        );
    }

    @And("Head buyer add sku to create multi order")
    public void head_buyer_add_sku_to_create_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleHBuyerCreateOrder.addSKU(infos)
        );
    }

    @And("Head buyer verify info sku in add sku popup of create multi order")
    public void head_buyer_verify_sku_to_create_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++) {
            if (infos.get(i).get("sku").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateOrderPage.SKU_IN_SELECT_SKU_POPUP(infos.get(i).get("sku"))).isNotDisplayed(),
                        Ensure.that(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("Select a SKU first")).isDisplayed()
                );
            } else
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateOrderPage.SKU_IN_SELECT_SKU_POPUP(infos.get(i).get("sku"))).text().contains(infos.get(i).get("sku")),
                        Ensure.that(VendorCreateOrderPage.BRAND_IN_SELECT_SKU_POPUP(infos.get(i).get("sku"))).text().contains(infos.get(i).get("brand")),
                        Ensure.that(VendorCreateOrderPage.PRODUCT_IN_SELECT_SKU_POPUP(infos.get(i).get("sku"))).text().contains(infos.get(i).get("product")),
                        Ensure.that(VendorCreateOrderPage.UPC_IN_SELECT_SKU_POPUP(infos.get(i).get("sku"))).text().contains(infos.get(i).get("upc")),
                        Ensure.that(VendorCreateOrderPage.SKU_ID_IN_SELECT_SKU_POPUP(infos.get(i).get("sku"))).text().contains(infos.get(i).get("skuID"))
                );
        }
    }

    @And("Head buyer search sku in add sku popup of create multi order")
    public void head_buyer_search_sku_to_create_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Enter.theValue(infos.get(0).get("sku")).into(VendorCreateOrderPage.TEXTBOX_IN_SELECT_SKU_POPUP).thenHit(Keys.TAB),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING)
        );
    }

    @And("Head buyer verify sku added to create multi order")
    public void head_buyer_verify_sku_added_to_create_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++)
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCreateOrderPage.SKU_ADDED_INFO("brand", i + 1)).text().contains(infos.get(i).get("brand")),
                    Ensure.that(VendorCreateOrderPage.SKU_ADDED_INFO("product", i + 1)).text().contains(infos.get(i).get("product")),
                    Ensure.that(VendorCreateOrderPage.SKU_ADDED_INFO("sku", i + 1)).text().contains(infos.get(i).get("sku")),
                    Ensure.that(VendorCreateOrderPage.SKU_ADDED_INFO("product-variant-stamp", i + 1)).text().contains(infos.get(i).get("id").contains("api") ? Serenity.sessionVariableCalled("itemCode" + infos.get(i).get("sku")) : infos.get(i).get("id")),
                    Ensure.that(VendorCreateOrderPage.SKU_ADDED_IMAGE(i + 1)).attribute("style").contains(infos.get(i).get("image"))
            );
    }

    @And("Head buyer verify sku added in popup create multi order")
    public void head_buyer_verify_sku_added_popup_to_create_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++)
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCreateOrderPage.SKU_POPUP_ADDED(infos.get(i).get("sku"))).isDisplayed()
            );
    }

    @And("Head buyer add sku success to create multi order")
    public void head_buyer_add_sku_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleHBuyerCreateOrder.addSKUsSuccess()
        );
    }

    @And("Head buyer next to create multi order")
    public void head_buyer_next_to_create() {
        theActorInTheSpotlight().attemptsTo(
                HandleHBuyerCreateOrder.next()
        );
    }

    @And("Head buyer verify item in order of store {string}")
    public void head_buyer_verify_sku_to_create_order(String buyer, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorCreateOrderPage.SKU_IN_MULTI_ORDER(buyer, info.get("sku"))),
                    // Verify
                    Ensure.that(VendorCreateOrderPage.SKU_IN_MULTI_ORDER(buyer, info.get("sku"))).text().contains(info.get("sku")),
                    Ensure.that(VendorCreateOrderPage.BRAND_IN_MULTI_ORDER(buyer, info.get("sku"))).text().contains(info.get("brand")),
                    Ensure.that(VendorCreateOrderPage.PRODUCT_IN_MULTI_ORDER(buyer, info.get("sku"))).text().contains(info.get("product")),
                    Ensure.that(VendorCreateOrderPage.UPC_IN_MULTI_ORDER(buyer, info.get("sku"))).text().contains(info.get("upc")),
                    Ensure.that(VendorCreateOrderPage.SKU_ID_IN_MULTI_ORDER(buyer, info.get("sku"))).text().contains(info.get("skuID").contains("api") ? Serenity.sessionVariableCalled("itemCode" + info.get("sku")) : info.get("skuID"))
            );
            if (!info.get("amount").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateOrderPage.AMOUNT_IN_MULTI_ORDER(buyer, info.get("sku"))).attribute("value").contains(info.get("amount"))
                );
            }
            if (!info.get("unit").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateOrderPage.UNIT_IN_MULTI_ORDER(buyer, info.get("sku"))).text().contains(info.get("unit"))
                );
            }
            if (!info.get("price").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateOrderPage.PRICE_IN_MULTI_ORDER(buyer, info.get("sku"))).text().contains(info.get("price"))
                );
            }
            if (!info.get("oldPrice").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateOrderPage.OLD_PRICE_IN_MULTI_ORDER(buyer, info.get("sku"))).text().contains(info.get("oldPrice"))
                );
            }
            if (!info.get("error").isEmpty()) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateOrderPage.ERROR_IN_MULTI_ORDER(buyer, info.get("sku"))).text().contains(info.get("error"))
                );
            }
        }

    }

    @And("Head buyer edit amount of item create multiple order")
    public void head_buyer_edit_amount(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    Enter.theValue(info.get("amount")).into(VendorCreateOrderPage.AMOUNT_IN_MULTI_ORDER(info.get("store"), info.get("sku"))).thenHit(Keys.TAB),
                    WindowTask.threadSleep(2000)
            );
        }
    }

    @And("Head buyer verify cart summary of buyer {string} in create multi order")
    public void head_buyer_verify_cart_summary(String buyer, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorCreateOrderPage.VALUE_CART_SUMMARY(buyer)),
                    // Verify
                    Ensure.that(VendorCreateOrderPage.VALUE_CART_SUMMARY(buyer)).text().contains(info.get("orderValue")),
                    Ensure.that(VendorCreateOrderPage.ITEM_SUBTOTAL_CART_SUMMARY(buyer)).text().contains(info.get("subTotal")),
                    Ensure.that(VendorCreateOrderPage.TOTAL_CART_SUMMARY(buyer)).text().contains(info.get("total"))
            );
            if (!info.get("sos").equals("")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateOrderPage.SOS_CART_SUMMARY(buyer)).text().contains(info.get("sos"))
                );
            }
            if (!info.get("promotion").equals("")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateOrderPage.PROMOTION_CART_SUMMARY(buyer)).text().contains(info.get("promotion"))
                );
            }
            if (!info.get("specialDiscount").equals("")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateOrderPage.SPECIAL_DISCOUNT_CART_SUMMARY(buyer)).text().contains(info.get("specialDiscount"))
                );
            }
            if (!info.get("taxes").equals("")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorCreateOrderPage.TAX_CART_SUMMARY(buyer)).text().contains(info.get("taxes"))
                );
            }
        }

    }

    @And("Head buyer change buyer of store {string} to buyer {string} order of create multi order")
    public void head_buyer_change_buyer_to_order(String store, String newBuyer) {
        theActorInTheSpotlight().attemptsTo(
                HandleHBuyerCreateOrder.changeBuyer(store, newBuyer)
        );
    }

    @And("Head buyer create order with info")
    public void head_buyer_create_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleHBuyerCreateOrder.createOrder(infos)
        );
    }

    @And("Head buyer create all orders")
    public void head_buyer_create_all_orders() {
        theActorInTheSpotlight().attemptsTo(
                HandleHBuyerCreateOrder.createAllOrder()
        );
    }

    @And("Head buyer add favorite on create multiple orders page")
    public void head_buyer_add_favorite_create_all_orders(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleHBuyerCreateOrder.addFavorite(infos)
        );
    }

    @And("Head buyer check favorite sku info on create multiple orders page")
    public void head_buyer_check_favorite_create_all_orders(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorCreateOrderPage.SKU_FAVORITE_INFO("sku", i + 1)),
                    Ensure.that(VendorCreateOrderPage.SKU_FAVORITE_INFO("brand", i + 1)).text().contains(infos.get(i).get("brand")),
                    Ensure.that(VendorCreateOrderPage.SKU_FAVORITE_INFO("product", i + 1)).text().contains(infos.get(i).get("product")),
                    Ensure.that(VendorCreateOrderPage.SKU_FAVORITE_INFO("sku", i + 1)).text().contains(infos.get(i).get("sku")),
                    Ensure.that(VendorCreateOrderPage.SKU_FAVORITE_INFO("product-variant-stamp", i + 1)).text().contains(infos.get(i).get("id").contains("api") ? Serenity.sessionVariableCalled("itemCode" + infos.get(i).get("sku")) : infos.get(i).get("id")),
                    Ensure.that(VendorCreateOrderPage.SKU_FAVORITE_IMAGE(i + 1)).attribute("style").contains(infos.get(i).get("image"))
            );
    }

    @And("Head buyer check default favorite sku on create multiple orders page")
    public void head_buyer_check_default_favorite_create_all_orders(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorCreateOrderPage.SKU_FAVORITE_ADD_BTN(infos.get(i).get("sku"))),
                    MoveMouse.to(VendorCreateOrderPage.SKU_FAVORITE_ADD_BTN(infos.get(i).get("sku"))),
                    WindowTask.threadSleep(500),
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ANY_TEXT("Select store(s) first"))
            );
    }

    @And("Head buyer add from favorite sku on create multiple orders page")
    public void head_buyer_add_from_favorite_create_all_orders(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorCreateOrderPage.SKU_FAVORITE_ADD_BTN(infos.get(i).get("sku"))),
                    Click.on(VendorCreateOrderPage.SKU_FAVORITE_ADD_BTN(infos.get(i).get("sku"))),
                    WindowTask.threadSleep(500)
            );
    }
}

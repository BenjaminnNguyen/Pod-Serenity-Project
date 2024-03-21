package cucumber.tasks.vendor.orders;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.claims.VendorClaimsPage;
import cucumber.user_interface.beta.Vendor.orders.VendorCreateOrderPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ui.Button;
import net.serenitybdd.screenplay.ui.PageElement;
import org.openqa.selenium.By;
import org.openqa.selenium.support.locators.RelativeLocator;

import java.util.List;
import java.util.Map;

public class HandleHBuyerCreateOrder {

    public static Task goToCreate() {
        return Task.where("Go to create order",
                CommonWaitUntil.isVisible(VendorCreateOrderPage.CREATE_ORDER_BUTTON),
                Click.on(VendorCreateOrderPage.CREATE_ORDER_BUTTON)
        );
    }

    public static Task addStore(List<Map<String, String>> infos) {
        return Task.where("Add store to create",
                CommonTask.chooseMultiItemInDropdown1(VendorCreateOrderPage.ADD_STORE_TEXTBOX, infos)
        );
    }

    public static Performable removeStore(List<Map<String, String>> infos) {
        return Task.where("Add store to create",
                actor -> {
                    for (Map<String, String> map : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(VendorCreateOrderPage.STORE_ADDED_INFO(map.get("store"))),
                                Click.on(VendorCreateOrderPage.STORE_ADDED_INFO(map.get("store")))
                        );
                    }
                }
        );
    }

    public static Task goToAddSku() {
        return Task.where("Go to popup add skus",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Add SKUs")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Add SKUs")),
                CommonWaitUntil.isVisible(VendorClaimsPage.SELECT_LINE_ITEM_POPUP)
        );
    }

    public static Performable addSKU(List<Map<String, String>> infos) {
        return Task.where("add skus",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(VendorCreateOrderPage.SKU_IN_SELECT_SKU_POPUP(info.get("sku"))),
                                // choose sku
                                Click.on(VendorCreateOrderPage.SKU_IN_SELECT_SKU_POPUP(info.get("sku"))),
                                WindowTask.threadSleep(500)
                        );
                    }
                }
        );
    }

    public static Task addSKUsSuccess() {
        return Task.where("Add skus success",
                CommonWaitUntil.isVisible(VendorCreateOrderPage.SELECTED_SKU_BUTTON),
                Click.on(VendorCreateOrderPage.SELECTED_SKU_BUTTON),
                CommonWaitUntil.isNotVisible(VendorClaimsPage.SELECT_LINE_ITEM_POPUP)
        );
    }

    public static Task next() {
        return Task.where("Next",
                CommonWaitUntil.isVisible(Button.withText("Next")),
                Click.on(Button.withText("Next"))
        );
    }

    public static Task changeBuyer(String oldBuyer, String newBuyer) {
        return Task.where("Change from buyer " + oldBuyer + " to buyer " + newBuyer,
                CommonTask.chooseItemInDropdown(VendorCreateOrderPage.CHANGE_BUYER_TEXTBOX(oldBuyer), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN1(newBuyer)),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING),
                WindowTask.threadSleep(1000)
        );
    }
    public static Task createOrder(List<Map<String, String>> map) {
        return Task.where("Head buyer create order",
                CommonTask.chooseItemInDropdown(VendorCreateOrderPage.CHANGE_BUYER_TEXTBOX(map.get(0).get("store")), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN1(map.get(0).get("buyer"))),
                WindowTask.threadSleep(1000),
                Check.whether(map.get(0).get("customerPO").isEmpty()).otherwise(
                        Enter.theValue(map.get(0).get("customerPO")).into(VendorCreateOrderPage.CUSTOMER_PO_TEXTBOX(map.get(0).get("store")))
                ),
                Click.on(VendorCreateOrderPage.CREATE_ORDER_BTN(map.get(0).get("store"))).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT("Order created successfully"))
        );
    }

    public static Task createAllOrder() {
        return Task.where("Create all order",
                CommonWaitUntil.isVisible(Button.withText("Create All Orders")),
                Click.on(Button.withText("Create All Orders")).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(VendorCreateOrderPage.ORDER_SUCCESS_POPUP_TITLE)
        );
    }

    public static Performable addFavorite(List<Map<String, String>> infos) {
        return Task.where("Add favorite sku",
                actor -> {
                    for (Map<String, String> map : infos)
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(VendorCreateOrderPage.SKU_FAVORITE(map.get("store"), map.get("sku"))),
                                Click.on(VendorCreateOrderPage.SKU_FAVORITE(map.get("store"), map.get("sku"))).afterWaitingUntilEnabled(),
                                WindowTask.threadSleep(1000)
                        );
                }
        );
    }
}

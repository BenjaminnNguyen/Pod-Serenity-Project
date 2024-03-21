package cucumber.tasks.vendor.claims;

import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.claims.VendorClaimsPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Clear;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HandleVendorClaim {

    public static Task goToCreateClaims() {
        return Task.where("Go to create vendor claims",
                CommonWaitUntil.isVisible(VendorClaimsPage.NEW_CLAIM_BUTTON),
                Click.on(VendorClaimsPage.NEW_CLAIM_BUTTON).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(VendorClaimsPage.CREATE_CLAIM_PAGE_TITLE)
        );
    }

    public static Task fillInfoToCreate(Map<String, String> info) {
        return Task.where("Fill info to create",
                Click.on(VendorClaimsPage.ISSUE_TYPE_IN_CREATE(info.get("issue"))),
                Check.whether(info.get("region").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput1(VendorClaimsPage.D_TEXTBOX_CREATE("Select Express Region"), info.get("region"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("region")))),
                Check.whether(info.get("uploadFile").equals(""))
                        .otherwise(
                                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Add a file")),
                                CommonWaitUntil.isVisible(VendorClaimsPage.REMOVE_BUTTON_UPLOAD_IN_CREATE),
                                CommonFile.upload2(info.get("uploadFile"), VendorClaimsPage.UPLOAD_IN_CREATE)),
                Check.whether(info.get("adminNote").equals(""))
                        .otherwise(Enter.theValue(info.get("adminNote")).into(VendorClaimsPage.D_TEXTAREA_CREATE("Additional Notes")))
        );
    }

    public static Performable addSKUToCreate(List<Map<String, String>> infos) {
        return Task.where("Add SKU to create",
                actor -> {
                    actor.attemptsTo(
                            Click.on(VendorClaimsPage.TYPE_VALUE_IN_CREATE("SKU")),
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add new SKUs"))
                    );
                    for (Map<String, String> info : infos) {
                        // add sku
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add new SKUs")),
                                CommonWaitUntil.isVisible(VendorClaimsPage.SELECT_LINE_ITEM_POPUP),
                                Enter.theValue(info.get("sku")).into(VendorClaimsPage.TEXTBOX_IN_SELECT_LINE_ITEM_POPUP),
                                CommonWaitUntil.isVisible(VendorClaimsPage.ITEM_IN_SELECT_LINE_ITEM_POPUP(info.get("sku"))),
                                Click.on(VendorClaimsPage.ITEM_IN_SELECT_LINE_ITEM_POPUP(info.get("sku"))),
                                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("selected SKU")),
                                CommonWaitUntil.isNotVisible(VendorClaimsPage.SELECT_LINE_ITEM_POPUP),
                                // edit quantity
                                Check.whether(info.get("quantity").equals(""))
                                        .otherwise(
                                                CommonWaitUntil.isVisible(VendorClaimsPage.SKU_ITEM_IN_CREATE(info.get("sku"))),
                                                Clear.field(VendorClaimsPage.SKU_QUANTITY_TEXTBOX_IN_CREATE(info.get("sku"))),
                                                Enter.theValue(info.get("quantity")).into(VendorClaimsPage.SKU_QUANTITY_TEXTBOX_IN_CREATE(info.get("sku"))).thenHit(Keys.ENTER)
                                        ),
                                WindowTask.threadSleep(1000)
                        );
                    }
                }
        );
    }

    public static Task addSKUNotAdded(Map<String, String> info) {
        return Task.where("Add SKU not added",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add new SKUs")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add new SKUs")),
                CommonWaitUntil.isVisible(VendorClaimsPage.SELECT_LINE_ITEM_POPUP),
                Enter.theValue(info.get("sku")).into(VendorClaimsPage.TEXTBOX_IN_SELECT_LINE_ITEM_POPUP),
                CommonWaitUntil.isVisible(VendorClaimsPage.ITEM_IN_SELECT_NOT_ADDED(info.get("sku"))),
                Click.on(CommonVendorPage.D_DIALOG_CLOSE_BUTTON),
                CommonWaitUntil.isNotVisible(VendorClaimsPage.SELECT_LINE_ITEM_POPUP)
        );
    }

    public static Performable removeSKUToCreate(List<Map<String, String>> infos) {
        return Task.where("Remove SKU to create",
                actor -> {
                    for (Map<String, String> info : infos) {
                        // add sku
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(VendorClaimsPage.DELETE_SKU_IN_CREATE(info.get("sku"))),
                                Click.on(VendorClaimsPage.DELETE_SKU_IN_CREATE(info.get("sku"))),
                                CommonWaitUntil.isNotVisible(VendorClaimsPage.DELETE_SKU_IN_CREATE(info.get("sku")))
                        );
                    }
                }
        );
    }

    public static Task createClaimSuccess(String message) {
        return Task.where("Create vendor claim success",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Create")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isVisible(VendorClaimsPage.MESSAGE_CREATE_SUCCESS(message))
        );
    }

    public static Task updateClaimSuccess(String message) {
        return Task.where("Update vendor claim success",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Update")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(VendorClaimsPage.MESSAGE_CREATE_SUCCESS(message))
        );
    }
    public static Task clickHere() {
        return Task.where("Click link here after create",
                CommonWaitUntil.isVisible(VendorClaimsPage.HERE_LINK),
                Click.on(VendorClaimsPage.HERE_LINK),
                CommonWaitUntil.isVisible(VendorClaimsPage.NEW_CLAIM_BUTTON)
        );
    }


    public static Task goToDetail(String number) {
        return Task.where("Go to detail",
                CommonWaitUntil.isVisible(VendorClaimsPage.NUMBER_CLAIM_RESULT(number)),
                Click.on(VendorClaimsPage.NUMBER_CLAIM_RESULT(number)),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Update"))
        );
    }

    public static Task selectOrderToAdd(Map<String, String> info) {
        return Task.where("Select order to add",
                CommonWaitUntil.isVisible(VendorClaimsPage.TYPE_VALUE_IN_CREATE("Order")),
                Click.on(VendorClaimsPage.TYPE_VALUE_IN_CREATE("Order")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add new orders")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add new orders")),
                CommonWaitUntil.isVisible(VendorClaimsPage.ADD_NEW_ORDERS),
                Enter.theValue(info.get("order")).into(VendorClaimsPage.TEXTBOX_IN_SELECT_LINE_ITEM_POPUP),
                CommonWaitUntil.isVisible(VendorClaimsPage.ORDER_IN_ADD_NEW_ORDERS_POPUP(info.get("order"))),
                Click.on(VendorClaimsPage.ORDER_IN_ADD_NEW_ORDERS_POPUP(info.get("order")))
        );
    }

    public static Performable selectLineItem(List<Map<String, String>> infos) {
        return Task.where("Select line item in order to add",
                actor -> {
                    for (Map<String, String> info : infos) {
                        // add sku
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(VendorClaimsPage.LINE_ITEM_SKU_IN_ADD_NEW_ORDERS_POPUP(info.get("sku"))),
                                Click.on(VendorClaimsPage.LINE_ITEM_SKU_IN_ADD_NEW_ORDERS_POPUP(info.get("sku")))
                        );
                    }
                }
        );
    }

    public static Task addItemInPopup(String value) {
        return Task.where("Add item in popup",
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("selected " + value)),
                CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("selected " + value))
        );
    }

    public static Task addOrderNotAdded(String order) {
        return Task.where("Add Order not added",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add new orders")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add new orders")),
                CommonWaitUntil.isVisible(VendorClaimsPage.ADD_NEW_ORDERS),
                Enter.theValue(order).into(VendorClaimsPage.TEXTBOX_IN_SELECT_LINE_ITEM_POPUP),
                CommonWaitUntil.isVisible(VendorClaimsPage.ITEM_IN_ADD_ORDER_POPUP_NOT_ADDED(order)),
                Click.on(CommonVendorPage.D_DIALOG_CLOSE_BUTTON),
                CommonWaitUntil.isNotVisible(VendorClaimsPage.ADD_NEW_ORDERS)
        );
    }

    public static Performable editOrder(List<Map<String, String>> infos) {
        return Task.where("Edit '# of cases' of order",
                actor -> {
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> item = CommonTask.setValue2(info, "order", info.get("order"), Serenity.sessionVariableCalled("Number Order API" + info.get("index")).toString(), "create by api");
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(VendorClaimsPage.QUANTITY_IN_ORDER_IN_DETAIL(item.get("order"), info.get("sku"))),
                                Clear.field(VendorClaimsPage.QUANTITY_IN_ORDER_IN_DETAIL(item.get("order"), info.get("sku"))),
                                Enter.theValue(item.get("quantity")).into(VendorClaimsPage.QUANTITY_IN_ORDER_IN_DETAIL(item.get("order"), info.get("sku"))).thenHit(Keys.TAB)
                        );
                    }
                }
        );
    }

    public static Performable removeOrderToCreate(List<Map<String, String>> infos) {
        return Task.where("Remove Order to create",
                actor -> {
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> item = CommonTask.setValue2(info, "order", info.get("order"), Serenity.sessionVariableCalled("Number Order API" + info.get("index")).toString(), "create by api");

                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(VendorClaimsPage.DELETE_ORDER_IN_CREATE(item.get("order"))),
                                Click.on(VendorClaimsPage.DELETE_ORDER_IN_CREATE(item.get("order"))),
                                CommonWaitUntil.isNotVisible(VendorClaimsPage.DELETE_ORDER_IN_CREATE(item.get("order")))
                        );
                    }
                }
        );
    }

    public static Task selectInboundToAdd(Map<String, String> info) {
        return Task.where("Select inbound to add",
                Click.on(VendorClaimsPage.TYPE_VALUE_IN_CREATE("Inbound")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add new inbound inventory")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add new inbound inventory")),
                CommonWaitUntil.isVisible(VendorClaimsPage.ADD_NEW_INBOUND_INVENTORIES),
                Enter.theValue(info.get("inbound")).into(VendorClaimsPage.TEXTBOX_IN_SELECT_LINE_ITEM_POPUP),
                CommonWaitUntil.isVisible(VendorClaimsPage.ORDER_IN_ADD_NEW_ORDERS_POPUP(info.get("inbound"))),
                Click.on(VendorClaimsPage.ORDER_IN_ADD_NEW_ORDERS_POPUP(info.get("inbound")))
        );
    }

    public static Task addInboundNotAdded(String order) {
        return Task.where("Add Inbound not added",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add new inbound inventory")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add new inbound inventory")),
                CommonWaitUntil.isVisible(VendorClaimsPage.ADD_NEW_INBOUND_INVENTORIES),
                Enter.theValue(order).into(VendorClaimsPage.TEXTBOX_IN_SELECT_LINE_ITEM_POPUP),
                CommonWaitUntil.isVisible(VendorClaimsPage.ITEM_IN_ADD_ORDER_POPUP_NOT_ADDED(order)),
                Click.on(CommonVendorPage.D_DIALOG_CLOSE_BUTTON),
                CommonWaitUntil.isNotVisible(VendorClaimsPage.ADD_NEW_INBOUND_INVENTORIES)
        );
    }

    public static Performable removeInboundToCreate(List<Map<String, String>> infos) {
        return Task.where("Remove Inbound to create",
                actor -> {
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> item = CommonTask.setValue2(info, "inbound", info.get("inbound"), Serenity.sessionVariableCalled("Number Inbound Inventory api" + info.get("index")).toString(), "create by api");

                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(VendorClaimsPage.DELETE_ORDER_IN_CREATE(item.get("inbound"))),
                                Click.on(VendorClaimsPage.DELETE_ORDER_IN_CREATE(item.get("inbound"))),
                                CommonWaitUntil.isNotVisible(VendorClaimsPage.DELETE_ORDER_IN_CREATE(item.get("inbound")))
                        );
                    }
                }
        );
    }

    public static Performable editInbound(List<Map<String, String>> infos) {
        return Task.where("Edit '# of cases' of inbound",
                actor -> {
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> item = CommonTask.setValue2(info, "inbound", info.get("inbound"), Serenity.sessionVariableCalled("Number Inbound Inventory api" + info.get("index")).toString(), "create by api");
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(VendorClaimsPage.QUANTITY_IN_ORDER_IN_DETAIL(item.get("inbound"), info.get("sku"))),
                                Clear.field(VendorClaimsPage.QUANTITY_IN_ORDER_IN_DETAIL(item.get("inbound"), info.get("sku"))),
                                Enter.theValue(item.get("quantity")).into(VendorClaimsPage.QUANTITY_IN_ORDER_IN_DETAIL(item.get("inbound"), info.get("sku"))).thenHit(Keys.TAB)
                        );
                    }
                }
        );
    }
}

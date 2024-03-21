package cucumber.tasks.admin.orders;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.CreateNewOrderPage;
import cucumber.user_interface.admin.orders.GhostOrderPage;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleGhostOrders {

    public static Task goToCreate() {
        return Task.where("Go to create ghost order",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isVisible(CreateNewOrderPage.DYNAMIC_TEXTBOX("Buyer"))
        );
    }

    public static Task convertOrder() {
        return Task.where("Convert ghost order to real order",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Convert Order")),
                Scroll.to(CommonAdminForm.DYNAMIC_BUTTON("Convert Order")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Convert Order")),
                // Popup confirm
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("If you convert this ghost order into a regular order, ops team will fulfill the order. Are you sure?")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("OK")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task confirmConvertOrder() {
        return Task.where("Confirm convert ghost order to real order",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Convert Order")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Convert Order")),
                // confirm nếu có popup MOQ alert
                Check.whether(valueOf(GhostOrderPage.MOQ_ALERT_POPUP_CONVERT), isCurrentlyVisible())
                        .andIfSo(Click.on(CommonAdminForm.DYNAMIC_BUTTON("Process"))),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(OrderDetailPage.GENERAL_INFORMATION)
        );
    }

    public static Task confirmConvertOrderWithPO(String order) {
        return Task.where("Confirm convert ghost order to real order with PO",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Convert Order")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Convert Order")),
                // Check popup customer PO
                CommonWaitUntil.isVisible(OrderDetailPage.WARNING_PO_USED_POPUP),
                CommonWaitUntil.isVisible(OrderDetailPage.WARNING_PO_USED_MESSAGE),
                // Verify link to order
                Click.on(OrderDetailPage.ORDER_LINK_PO_USED_POPUP(order)),
                WindowTask.threadSleep(5000),
                WindowTask.switchToChildWindowsByTitle(order),
                CommonWaitUntil.isVisible(OrderDetailPage.ORDER_ID_HEADER(order)),
                WindowTask.threadSleep(5000),
                // switch to create new order
                WindowTask.switchToChildWindowsByTitle("Create new order"),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(OrderDetailPage.GENERAL_INFORMATION)
        );
    }

    public static Task searchGhostOrder(Map<String, String> info) {
        return Task.where("Search ghost order by info",
                Check.whether(info.get("ghostOrderNumber").isEmpty())
                        .otherwise(Enter.theValue(info.get("ghostOrderNumber")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number"))),
                Check.whether(info.get("store").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("store")))),
                Check.whether(info.get("buyer").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id"), info.get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyer")))),
                Check.whether(info.get("buyerCompany").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id"), info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerCompany")))),
                Check.whether(info.get("vendorCompany").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany")))),
                Check.whether(info.get("brand").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id"), info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("brand")))),
                Check.whether(info.get("sku").isEmpty())
                        .otherwise(CommonTask.chooseMultiWithOneItemInDropdown(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_variant_ids"), info.get("sku"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("sku")))),
                Check.whether(info.get("region").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))),
                Check.whether(info.get("managed").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_manager_id"), info.get("managed"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("managed")))),
                Check.whether(info.get("startDate").isEmpty())
                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("startDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("start_date"))),
                Check.whether(info.get("endDate").isEmpty())
                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("endDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("end_date"))),

                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task addLineItem(Map<String, String> info) {
        return Task.where("Add line item",
                // Go to add item popup
                CommonWaitUntil.isClickable(CreateNewOrderPage.ADD_LINE_BUTTON),
                Click.on(CreateNewOrderPage.ADD_LINE_BUTTON),
                CommonWaitUntil.isVisible(CreateNewOrderPage.SEARCH_ITEM),
                // Search and choose SKU
                Enter.theValue(info.get("sku")).into(CreateNewOrderPage.SEARCH_ITEM),
                CommonWaitUntil.isVisible(CreateNewOrderPage.ITEM_RESULT),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                Click.on(CreateNewOrderPage.ITEM_RESULT),
                Check.whether(valueOf(CommonAdminForm.DYNAMIC_DIALOG("This SKU is launching soon. Do you want to continue?")), isVisible())
                        .andIfSo(Click.on(CommonAdminForm.DYNAMIC_BUTTON("OK"))),
                Check.whether(valueOf(CommonAdminForm.DYNAMIC_DIALOG("This SKU is out of stock. Do you want to continue?")), isVisible())
                        .andIfSo(Click.on(CommonAdminForm.DYNAMIC_BUTTON("OK"))),
                CommonWaitUntil.isVisible(GhostOrderPage.QUANTITY_OF_ITEM_TEXTBOX(info.get("sku"))),
                // add additional info
                Enter.theValue(info.get("quantity")).into(GhostOrderPage.QUANTITY_OF_ITEM_TEXTBOX(info.get("sku"))),
                Check.whether(info.get("reason").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(GhostOrderPage.REASON_ADD_TEXTBOX(info.get("sku")), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("reason")))),
                Check.whether(info.get("note").equals(""))
                        .otherwise(Enter.theValue(info.get("note")).into(GhostOrderPage.NOTE_ADD_TEXTBOX(info.get("sku"))))
        );
    }

    public static Task seeHistoryAddItem(String sku) {
        return Task.where("See history add item",
                Scroll.to(OrderDetailPage.ADD_LINE_ITEM_BUTTON),
                Click.on(GhostOrderPage.HISTORY_ADD_TEXTBOX(sku))
        );
    }

    public static Task deleteLineItem(Map<String, String> info) {
        return Task.where("Delete line item",
                CommonWaitUntil.isVisible(GhostOrderPage.DELETE_LINE_ITEM_BUTTON(info.get("sku"))),
                Click.on(GhostOrderPage.DELETE_LINE_ITEM_BUTTON(info.get("sku"))),
                WindowTask.threadSleep(1000),
                //Check reason popup
                CommonWaitUntil.isVisible(OrderDetailPage.POPUP_REASON),
                Check.whether(info.get("reason").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(OrderDetailPage.REASON_TEXTBOX_IN_POPUP_DELETE, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("reason")))),
                Check.whether(info.get("note").equals(""))
                        .otherwise(Enter.theValue(info.get("note")).into(OrderDetailPage.NOTE_TEXTAREA_IN_POPUP_DELETE)),
                Check.whether(info.get("deduction").equals("Yes"))
                        .andIfSo(Click.on(OrderDetailPage.DEDUCTION_CHECKBOX)),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Choose reason"))
        );
    }

    public static Task deleteGhostOrder() {
        return Task.where("Delete ghost order",
                Click.on(GhostOrderPage.DELETE_GHOST_ORDER).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(CommonAdminForm.SHOW_FILTER),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task selectAll() {
        return Task.where("Select all ghost order",
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(GhostOrderPage.SELECT_ALL_ORDER),
                Click.on(GhostOrderPage.SELECT_ALL_ORDER),
                CommonWaitUntil.isVisible(GhostOrderPage.CONVERT_BULK_BUTTON)
        );
    }

    public static Task unSelectAll() {
        return Task.where("Un select all ghost order",
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(GhostOrderPage.SELECT_ALL_ORDER),
                Click.on(GhostOrderPage.SELECT_ALL_ORDER),
                CommonWaitUntil.isNotVisible(GhostOrderPage.CONVERT_BULK_BUTTON)
        );
    }

    public static Performable selectGhostOrder(List<Map<String, String>> infos) {
        return Task.where("Delete ghost order",
                actor -> {
                    for (Map<String, String> info : infos) {
                        String ghostOrderNumber = Serenity.sessionVariableCalled("Ghost Order Number API" + info.get("index"));
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(GhostOrderPage.ORDER_RESULT(ghostOrderNumber)),
                                Click.on(GhostOrderPage.SELECT_ORDER_RESULT(ghostOrderNumber))
                        );
                    }
                }
        );
    }

    public static Task convertBulk() {
        return Task.where("Convert bulk ghost order",
                CommonWaitUntil.isVisible(GhostOrderPage.CONVERT_BULK_BUTTON),
                Click.on(GhostOrderPage.CONVERT_BULK_BUTTON).afterWaitingUntilEnabled(),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Performable expandBulk(String ghostOrderNumber) {
        return Task.where("Expand bulk ghost order",
                CommonWaitUntil.isVisible(GhostOrderPage.CONVERT_BULK_BUTTON(ghostOrderNumber)),
                Click.on(GhostOrderPage.CONVERT_BULK_BUTTON(ghostOrderNumber)).afterWaitingUntilEnabled()
        );
    }

    public static Performable deleteLineItemBulk(List<Map<String, String>> infos) {
        return Task.where("Delete line item in order of bulk",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(GhostOrderPage.DELETE_LINE_ITEM_BULK(info.get("sku"))),
                                Click.on(GhostOrderPage.DELETE_LINE_ITEM_BULK(info.get("sku"))),
                                CommonWaitUntil.isNotVisible(GhostOrderPage.DELETE_LINE_ITEM_BULK(info.get("sku")))
                        );
                    }
                }
        );
    }

    public static Performable changeQuantityBulk(List<Map<String, String>> infos) {
        return Task.where("Change quantity of line item in bulk",
                actor -> {
                    for (Map<String, String> info : infos) {
                        String quantity = GhostOrderPage.QUANTITY_OF_ITEM_TEXTBOX(info.get("sku")).resolveFor(theActorInTheSpotlight()).getAttribute("value");
                        while (Integer.parseInt(quantity) < Integer.parseInt(info.get("quantity"))) {
                            actor.attemptsTo(
                                    // add additional info
                                    CommonWaitUntil.isVisible(GhostOrderPage.QUANTITY_OF_ITEM_TEXTBOX(info.get("sku"))),
                                    Click.on(GhostOrderPage.INCREASE_QUANTITY_OF_ITEM_TEXTBOX(info.get("sku"))),
                                    WindowTask.threadSleep(500)
                            );
                            quantity = GhostOrderPage.QUANTITY_OF_ITEM_TEXTBOX(info.get("sku")).resolveFor(theActorInTheSpotlight()).getAttribute("value");
                        }

                    }
                }
        );
    }
}

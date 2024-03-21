package cucumber.tasks.admin.orders;

import cucumber.singleton.GVs;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.IncomingInventoryDetailPage;
import cucumber.user_interface.admin.orders.AllOrdersForm;
import cucumber.user_interface.admin.orders.DropSummaryPage;
import cucumber.user_interface.admin.orders.SummaryOrderPage;
import cucumber.user_interface.beta.Buyer.orders.BuyerClaimPage;
import cucumber.user_interface.beta.HomePageForm;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.matchers.WebElementStateMatchers;
import net.serenitybdd.screenplay.waits.Wait;
import net.serenitybdd.screenplay.waits.WaitUntil;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;
import static org.hamcrest.CoreMatchers.not;

public class HandleDropSummary {

    public static Performable search(Map<String, String> info) {
        return Task.where("Search order drop summary by info",
                actor -> {
                    if (info.containsKey("orderNumber")) {
                        actor.attemptsTo(
                                Check.whether(info.get("orderNumber").isEmpty())
                                        .otherwise(Enter.theValue(info.get("orderNumber")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number")))
                        );
                    }
                    if (info.containsKey("store")) {
                        actor.attemptsTo(
                                Check.whether(info.get("store").isEmpty())
                                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("store"))))
                        );
                    }
                    if (info.containsKey("buyer")) {
                        actor.attemptsTo(
                                Check.whether(info.get("buyer").isEmpty())
                                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id"), info.get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyer"))))
                        );
                    }
                    if (info.containsKey("buyerCompany")) {
                        actor.attemptsTo(
                                Check.whether(info.get("buyerCompany").isEmpty())
                                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id"), info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerCompany"))))
                        );
                    }
                    if (info.containsKey("vendorCompany")) {
                        actor.attemptsTo(
                                Check.whether(info.get("vendorCompany").isEmpty())
                                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany"))))
                        );
                    }
                    if (info.containsKey("brand")) {
                        actor.attemptsTo(
                                Check.whether(info.get("brand").isEmpty())
                                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id"), info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("brand"))))
                        );
                    }
                    if (info.containsKey("fulfillment")) {
                        actor.attemptsTo(
                                Check.whether(info.get("fulfillment").isEmpty())
                                        .otherwise(CommonTask.chooseItemInDropdown1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("fulfillment_states"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("fulfillment"))))
                        );
                    }
                    if (info.containsKey("region")) {
                        actor.attemptsTo(
                                Check.whether(info.get("region").isEmpty())
                                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region"))))
                        );
                    }
                    if (info.containsKey("route")) {
                        actor.attemptsTo(
                                Check.whether(info.get("route").isEmpty())
                                        .otherwise(CommonTask.chooseMultiWithOneItemInDropdown(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("route_id"), info.get("route"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("route"))))
                        );
                    }
                    if (info.containsKey("startDate")) {
                        actor.attemptsTo(
                                Check.whether(info.get("startDate").isEmpty())
                                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("startDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("start_date")))
                        );
                    }
                    if (info.containsKey("endDate")) {
                        actor.attemptsTo(
                                Check.whether(info.get("endDate").isEmpty())
                                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("endDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("end_date")))
                        );
                    }
                    if (info.containsKey("temp")) {
                        actor.attemptsTo(
                                Check.whether(info.get("temp").isEmpty())
                                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("temperature_name"), info.get("temp"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("temp"))))
                        );
                    }
                    if (info.containsKey("oos")) {
                        actor.attemptsTo(
                                Check.whether(info.get("oos").isEmpty())
                                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("has_out_of_stock_items"), info.get("oos"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("oos"))))
                        );
                    }
                    if (info.containsKey("oos")) {
                        actor.attemptsTo(
                                Check.whether(info.get("exProcess").isEmpty())
                                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("express_progress"), info.get("exProcess"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("exProcess"))))
                        );
                    }
                    actor.attemptsTo(
                            Click.on(CommonAdminForm.SEARCH_BUTTON),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
                    );
                }

        );
    }

    public static Task selectSubInvoice(String subInvoice) {
        return Task.where("Select sub invoice",
                CommonWaitUntil.isVisible(DropSummaryPage.SUB_INVOICE_RESULT_SUB(subInvoice)),
                Click.on(DropSummaryPage.CHECK_RESULT_SUB(subInvoice)),
                WindowTask.threadSleep(500)
        );
    }

    public static Task clearSelected() {
        return Task.where("Clear selected in create drop popup",
                Click.on(DropSummaryPage.CLEAR_ACTION_IN_ACTION_BAR),
                CommonWaitUntil.isNotVisible(DropSummaryPage.CLEAR_ACTION_IN_ACTION_BAR)
        );
    }

    public static Task createDrop() {
        return Task.where("create drop",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create drops")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create drops")),
                CommonWaitUntil.isVisible(DropSummaryPage.CREATE_DROP_POPUP)
        );
    }

    public static Task applySOS(String store) {
        return Task.where("Apply sos suggestion",
                CommonWaitUntil.isVisible(DropSummaryPage.APPLY_BUTTON_SOS_SUGGESTION(store)),
                Click.on(DropSummaryPage.APPLY_BUTTON_SOS_SUGGESTION(store))
        );
    }

    public static Task rejectSOS(String store) {
        return Task.where("Reject sos suggestion",
                CommonWaitUntil.isVisible(DropSummaryPage.REJECT_BUTTON_SOS_SUGGESTION(store)),
                Click.on(DropSummaryPage.REJECT_BUTTON_SOS_SUGGESTION(store)),
                CommonWaitUntil.isNotVisible(DropSummaryPage.REJECT_BUTTON_SOS_SUGGESTION(store))
        );
    }

    public static Task editSOS(String subInvoice, String value) {
        return Task.where("Edit sos",
                CommonWaitUntil.isVisible(DropSummaryPage.SOS_IN_CREATE_DROP_POPUP(subInvoice)),
                Click.on(DropSummaryPage.SOS_IN_CREATE_DROP_POPUP(subInvoice)),
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX),
                WindowTask.threadSleep(1000),
                Hit.the(Keys.BACK_SPACE).into(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX),
                Enter.theValue(value).into(CommonAdminForm.TOOLTIP_TEXTBOX),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP)
        );
    }

    public static Task editReason(String reason, String additionNote) {
        return Task.where("Edit sos",
                // Edit reason
                CommonWaitUntil.isVisible(DropSummaryPage.REASON_POPUP),
                CommonTask.chooseItemInDropdownWithValueInput1(DropSummaryPage.REASON_TEXTBOX, reason, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(reason)),
                Check.whether(additionNote.equals(""))
                        .otherwise(Enter.theValue(additionNote).into(DropSummaryPage.ADDITIONAL_NOTE_TEXTAREA)),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Submit"))
        );
    }

    public static Performable addPurchaseOrder(List<Map<String, String>> infos) {
        return Task.where("Add purchase order",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                // turn on create PO
                                CommonWaitUntil.isVisible(DropSummaryPage.CREATE_PO(info.get("store"))),
                                Click.on(DropSummaryPage.CREATE_PO(info.get("store"))),
                                WindowTask.threadSleep(1000),
                                // fill info
                                CommonTask.chooseItemInDropdownWithValueInput(DropSummaryPage.D_TEXTBOX_CREATE_PO(info.get("store"), "Driver"), info.get("driver"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("driver"))),
                                CommonWaitUntil.isVisible(DropSummaryPage.D_TEXTBOX_CREATE_PO(info.get("store"), "Fulfillment date")),
                                Check.whether(info.get("fulfillmentState").isEmpty())
                                        .otherwise(
                                                CommonTask.chooseItemInDropdown(DropSummaryPage.D_TEXTBOX_CREATE_PO(info.get("store"), "Fulfillment state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("fulfillmentState")))),
                                Check.whether(info.get("fulfillmentDate").isEmpty())
                                        .otherwise(
                                                Check.whether(info.get("fulfillmentDate").isEmpty())
                                                        .otherwise(
                                                                Enter.theValue(CommonHandle.setDate2(info.get("fulfillmentDate"), "MM/dd/yy")).into(DropSummaryPage.D_TEXTBOX_CREATE_PO(info.get("store"), "Fulfillment date")).thenHit(Keys.ENTER))),
                                Check.whether(info.get("pod").isEmpty())
                                        .otherwise(
                                                Click.on(DropSummaryPage.D_POD_BUTTON_CREATE_PO(info.get("store"))),
                                                CommonFile.upload1(info.get("pod"), DropSummaryPage.D_POD_UPLOAD_CREATE_PO(info.get("store")))),
                                Check.whether(info.get("adminNote").isEmpty())
                                        .otherwise(
                                                Enter.theValue(info.get("adminNote")).into(DropSummaryPage.D_TEXTBOX_CREATE_PO(info.get("store"), "Admin note"))),
                                Check.whether(info.get("lpNote").isEmpty())
                                        .otherwise(
                                                Enter.theValue(info.get("lpNote")).into(DropSummaryPage.D_TEXTBOX_CREATE_PO(info.get("store"), "LP note")))
                        );
                    }
                }
        );
    }

    public static Task copyPO(String store) {
        return Task.where("Use this info for all drops",
                CommonWaitUntil.isVisible(DropSummaryPage.D_COPY_PO_BUTTON(store)),
                Click.on(DropSummaryPage.D_COPY_PO_BUTTON(store)),
                WindowTask.threadSleep(2000)
        );
    }

    public static Task createDropInPopup() {
        return Task.where("Create drop in popup",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                WaitUntil.the(CommonAdminForm.ALERT_MESSAGE("Drops have been created successfully!"), not(WebElementStateMatchers.isNotVisible())).forNoMoreThan(90).seconds(),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task createDropHadPOInPopup() {
        return Task.where("Create drop with have po in popup",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("A PO was created for the sub-invoice(s) listed below. We will update the existing PO information based on new drop information")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK"))

        );
    }

    public static Task searchToAddDrop(Map<String, String> info) {
        return Task.where("Search order to add to drop",
                Check.whether(info.get("orderNumber").isEmpty())
                        .otherwise(Enter.theValue(info.get("orderNumber")).into(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("number"))),
                Check.whether(info.get("store").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("store_ids"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("store")))),
                Check.whether(info.get("buyer").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("buyer_id"), info.get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyer")))),
                Check.whether(info.get("buyerCompany").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("buyer_company_id"), info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerCompany")))),
                Check.whether(info.get("vendorCompany").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("vendor_company_id"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany")))),
                Check.whether(info.get("brand").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("brand_id"), info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("brand")))),
                Check.whether(info.get("fulfillment").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdown1(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("fulfillment_states"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("fulfillment")))),
                Check.whether(info.get("region").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("region_id"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))),
                Check.whether(info.get("route").isEmpty())
                        .otherwise(
                                CommonTask.clearTextboxMultiDropdown(DropSummaryPage.ICON_CLEAR_IN_MULTI_DROPDOWN("Route")),
                                CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("route_id"), info.get("route"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("route")))),
                Check.whether(info.get("startDate").isEmpty())
                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("startDate"), "MM/dd/yy")).into(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("start_date")).thenHit(Keys.ENTER)),
                Check.whether(info.get("endDate").isEmpty())
                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("endDate"), "MM/dd/yy")).into(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("end_date")).thenHit(Keys.ENTER)),
                Check.whether(info.get("temp").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("temperature_name"), info.get("temp"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("temp")))),
                Check.whether(info.get("oos").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("has_out_of_stock_items"), info.get("oos"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("oos")))),
                Check.whether(info.get("exProcess").isEmpty())
                        .otherwise(
                                CommonTask.clearTextboxMultiDropdown(DropSummaryPage.ICON_CLEAR_IN_MULTI_DROPDOWN("Express progress")),
                                CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("express_progress"), info.get("exProcess"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("exProcess"))),
                                Hit.the(Keys.ESCAPE).into(CommonAdminForm.D_SEARCH_TEXTBOX_IN_POPUP("express_progress"))),

                Click.on(CommonAdminForm.SEARCH_BUTTON_IN_POPUP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToAddSubInvoice(String drop, String purchase) {
        return Task.where("Go to add sub invoice",
                Check.whether(purchase.equals("No"))
                        .andIfSo(
                                CommonWaitUntil.isVisible(DropSummaryPage.ADD_SUB_IN_DROP_NO_PURCHASE_RESULT(drop)),
                                Click.on(DropSummaryPage.ADD_SUB_IN_DROP_NO_PURCHASE_RESULT(drop)),
                                CommonWaitUntil.isVisible(DropSummaryPage.ADD_TO_DROP_POPUP)
                        )
                        .otherwise(
                                CommonWaitUntil.isVisible(DropSummaryPage.ADD_SUB_IN_DROP_PURCHASE_RESULT(drop)),
                                Click.on(DropSummaryPage.ADD_SUB_IN_DROP_PURCHASE_RESULT(drop)),
                                CommonWaitUntil.isVisible(DropSummaryPage.ADD_TO_DROP_POPUP)
                        )

        );
    }

    public static Task chooseOrderToAdd(String subInvoice) {
        return Task.where("Choose order to add to drop",
                CommonWaitUntil.isVisible(DropSummaryPage.CHECKBOX_IN_DROP_POPUP(subInvoice)),
                Click.on(DropSummaryPage.CHECKBOX_IN_DROP_POPUP(subInvoice)),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task addToDropSuccess() {
        return Task.where("Add to drop success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Add to drop")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Add to drop")),
                CommonWaitUntil.isNotVisible(DropSummaryPage.ADD_TO_DROP_POPUP)
        );
    }

    public static Performable deleteDrop(List<Map<String, String>> infos) {
        return Task.where("Delete drop with ID ",
                actor -> {
                    for (Map<String, String> info : infos) {
                        String dropNumer = Serenity.sessionVariableCalled("Drop Number" + info.get("store"));
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(DropSummaryPage.DELETE_IN_DROP_RESULT(dropNumer)),
                                Click.on(DropSummaryPage.DELETE_IN_DROP_RESULT(dropNumer)),
                                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("This will permanently delete this record. Continue?")),
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Understand & Continue")),
                                WindowTask.threadSleep(1000),
                                CommonWaitUntil.isNotVisible(DropSummaryPage.DELETE_IN_DROP_RESULT(dropNumer))
                        );
                    }
                }

        );
    }

    public static Task chooseDrop(String dropID) {
        return Task.where("Choose drop " + dropID,
                CommonWaitUntil.isVisible(DropSummaryPage.CHECKBOX_DROP_IN_RESULT(dropID)),
                Click.on(DropSummaryPage.CHECKBOX_DROP_IN_RESULT(dropID)),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create purchase order"))
        );
    }

    public static Task goToCreatePoPopup() {
        return Task.where("Go to create purchase order popup",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create purchase order")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create purchase order")),
                CommonWaitUntil.isVisible(DropSummaryPage.CREATE_PO_POPUP)
        );
    }

    public static Task deleteSubInDrop(String subInvoice) {
        return Task.where("Delete subinvoice " + subInvoice + " in drop",
                CommonWaitUntil.isVisible(DropSummaryPage.DELETE_SUB_IN_DROP_RESULT(subInvoice)),
                Click.on(DropSummaryPage.DELETE_SUB_IN_DROP_RESULT(subInvoice)),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Do you want to remove sub-invoice from this drop?")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("OK")),
                WindowTask.threadSleep(500),
                CommonWaitUntil.isNotVisible(DropSummaryPage.DELETE_IN_DROP_RESULT(subInvoice))
        );
    }

    public static Performable expandDrop(List<Map<String, String>> infos) {
        return Task.where("Expand drop to see detail",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(DropSummaryPage.DROP_ID_INDEX(info.get("index"))),
                                Click.on(DropSummaryPage.DROP_ID_INDEX(info.get("index"))).afterWaitingUntilEnabled(),
                                WindowTask.threadSleep(2000)
                        );
                    }
                }
        );
    }
}

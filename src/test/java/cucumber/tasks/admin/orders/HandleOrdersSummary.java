package cucumber.tasks.admin.orders;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.AllOrdersForm;
import cucumber.user_interface.admin.orders.DropSummaryPage;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import cucumber.user_interface.admin.orders.SummaryOrderPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.Map;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleOrdersSummary {

    public static Task checkByInfo(Map<String, String> info) {
        return Task.where("Search order summary by info",
                Check.whether(info.get("orderNumber").isEmpty())
                        .otherwise(Enter.theValue(info.get("orderNumber")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number"))),
                Check.whether(info.get("orderSpecific").isEmpty())
                        .otherwise(Enter.theValue(info.get("orderSpecific")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("custom_store_name"))),
                Check.whether(info.get("store").isEmpty())
                        .otherwise(CommonTask.chooseMultiWithOneItemInDropdown(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_ids"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("store")))),
                Check.whether(info.get("buyer").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id"), info.get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyer")))),
                Check.whether(info.get("vendorCompany").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany")))),
                Check.whether(info.get("brand").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id"), info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("brand")))),
                Check.whether(info.get("sku").isEmpty())
                        .otherwise(CommonTask.chooseMultiWithOneItemInDropdown(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_variant_ids"), info.get("sku"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("sku")))),
                Check.whether(info.get("upc").isEmpty())
                        .otherwise(Enter.theValue(info.get("upc")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("upc"))),
                Check.whether(info.get("buyerCompany").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id"), info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerCompany")))),
                Check.whether(info.get("fulfillment").isEmpty())
                        .otherwise(
                                Check.whether(info.get("fulfillment").equals("remove"))
                                        .andIfSo(
                                                CommonTask.clearTextboxMultiDropdown(CommonAdminForm.D_SEARCH_ICON_CLOSE_IN_TEXTBOX("Fulfillment")))
                                        .otherwise(
                                                CommonTask.clearTextboxMultiDropdown(CommonAdminForm.D_SEARCH_ICON_CLOSE_IN_TEXTBOX("Fulfillment")),
                                                CommonTask.chooseMultiWithOneItemInDropdown(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("fulfillment_states"), info.get("fulfillment"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("fulfillment"))))
                                ),
                Check.whether(info.get("buyerPayment").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_payment_state"), info.get("buyerPayment"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerPayment")))),
                Check.whether(info.get("region").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))),
                Check.whether(info.get("route").isEmpty())
                        .otherwise(CommonTask.chooseMultiWithOneItemInDropdown(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("route_id"), info.get("route"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("route")))),
                Check.whether(info.get("managed").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_manager_id"), info.get("managed"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("managed")))),
                Check.whether(info.get("pod").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("lack_pod"), info.get("pod"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("pod")))),
                Check.whether(info.get("tracking").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("lack_tracking"), info.get("tracking"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("tracking")))),
                Check.whether(info.get("startDate").isEmpty())
                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("startDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("start_date"))),
                Check.whether(info.get("endDate").isEmpty())
                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("endDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("end_date"))),
                Check.whether(info.get("temp").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("temperature_name"), info.get("temp"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("temp")))),
                Check.whether(info.get("oos").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("has_out_of_stock_items"), info.get("oos"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("oos")))),
                Check.whether(info.get("orderType").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("type"), info.get("orderType"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("orderType")))),
                Check.whether(info.get("exProcess").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("express_progress"), info.get("exProcess"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("exProcess")))),
                Check.whether(info.get("edi").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("only_spring_po"), info.get("edi"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("edi")))),
                Check.whether(info.get("perPage").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("per_page"), info.get("perPage"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("perPage")))),

                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task deleteDeliverable(String type) {
        return Task.where("Delete deliverable",
                CommonWaitUntil.isVisible(SummaryOrderPage.DELIVERABLE_DELETE_BUTTON),
                Click.on(SummaryOrderPage.DELIVERABLE_DELETE_BUTTON),
                Check.whether(type.equals("Self deliver to store"))
                        .andIfSo(CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Shipments are created when selecting and confirming multiple line-items at once. This means if you remove this item, it cannot be added back to its original shipment. Are you sure you want to continue?")))
                        .otherwise(CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("This will permanently delete this delivery record. Continue?"))),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("OK"))
        );
    }

    public static Task expandOrderSummary() {
        return Task.where("Expand Order Summary",
                Check.whether(valueOf(SummaryOrderPage.EXPAND_ORDER), isCurrentlyVisible())
                        .andIfSo(CommonWaitUntil.isVisible(SummaryOrderPage.EXPAND_ORDER),
                                Click.on(SummaryOrderPage.EXPAND_ORDER))
        );
    }

    public static Task goToPopupCreatePurchaseOrder(String subInvoice) {
        return Task.where("Go to popup create purchase order",
                CommonWaitUntil.isVisible(SummaryOrderPage.CREATE_PO_BUTTON(subInvoice)),
                Click.on(SummaryOrderPage.CREATE_PO_BUTTON(subInvoice)),
                CommonWaitUntil.isVisible(AllOrdersForm.DRIVER_TEXTBOX)
        );
    }

    public static Task createPurchaseOrder(String type) {
        return Task.where(type + " purchase order",
                Click.on(AllOrdersForm.CREATE_PO_BUTTON(type)),
                CommonWaitUntil.isNotVisible(AllOrdersForm.CREATE_PO_BUTTON(type))
        );
    }

    public static Task goToPopupEditPurchaseOrder(String subInvoice) {
        return Task.where("Go to popup edit purchase order",
                CommonWaitUntil.isVisible(SummaryOrderPage.EDIT_PO_BUTTON(subInvoice)),
                Click.on(SummaryOrderPage.EDIT_PO_BUTTON(subInvoice)),
                CommonWaitUntil.isVisible(SummaryOrderPage.EDIT_PO_POPUP)
        );
    }

    public static Task removeFulfilled(String sub, String sku) {
        return Task.where("Remove fulfilled of line item",
                Click.on(SummaryOrderPage.INVOICE_FULFILLED_CHECKBOX(sub, sku)),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task fulfilledLineItem(String sub, String sku) {
        return Task.where("Fulfilled of line item",
                Click.on(SummaryOrderPage.INVOICE_FULFILLED_CHECKBOX(sub, sku)),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task fulfilledAllLineItem() {
        return Task.where("Fulfilled all line item",
                CommonWaitUntil.isVisible(SummaryOrderPage.FULFILL_ALL_ITEM),
                WindowTask.threadSleep(2000),
                JavaScriptClick.on(SummaryOrderPage.FULFILL_ALL_ITEM),
                WindowTask.threadSleep(3000)
        );
    }

    public static Task goToEditLineItem() {
        return Task.where("Go to edit line item",
                CommonWaitUntil.isVisible(SummaryOrderPage.BUTTON_EDIT_LINEITEM),
                Click.on(SummaryOrderPage.BUTTON_EDIT_LINEITEM),
                CommonWaitUntil.isVisible(SummaryOrderPage.BUTTON_CANCEL_EDIT_LINEITEM)
        );
    }

    public static Task editLineItemInOrderDetail(Map<String, String> info) {
        return Task.where("Edit quantity of line item in order detail",
                // Open popup quantity
                CommonWaitUntil.isVisible(SummaryOrderPage.LINE_ITEM_QUANTITY(info.get("sku"))),
                Click.on(SummaryOrderPage.LINE_ITEM_QUANTITY(info.get("sku"))),
                CommonWaitUntil.isVisible(OrderDetailPage.ITEM_QUANTITY_POPUP),
                // Edit quantity
                Clear.field(OrderDetailPage.ITEM_QUANTITY_POPUP_QUANTITY_TEXTBOX),
                Enter.theValue(info.get("quantity")).into(OrderDetailPage.ITEM_QUANTITY_POPUP_QUANTITY_TEXTBOX),
                Check.whether(info.get("reason").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(OrderDetailPage.ITEM_QUANTITY_POPUP_REASON_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("reason")))),
                Check.whether(info.get("note").equals(""))
                        .otherwise(Enter.theValue(info.get("note")).into(OrderDetailPage.ITEM_QUANTITY_POPUP_NOTE_TEXTBOX)),
                Check.whether(info.get("deduction").equals("Yes"))
                        .andIfSo(
                                CommonWaitUntil.isVisible(OrderDetailPage.DEDUCTION_CHECKBOX_POPUP_NOTE),
                                Click.on(OrderDetailPage.DEDUCTION_CHECKBOX_POPUP_NOTE)),
                Check.whether(info.get("showEdit").equals("Yes"))
                        .otherwise(Click.on(OrderDetailPage.SHOW_EDIT_CHECKBOX))
        );
    }

    public static Task updateQuantityInOrderDetail(String type) {
        return Task.where("Update quantity of line item in order detail",
                // Open popup quantity
                Check.whether(type.equals("Change"))
                        .andIfSo(Click.on(SummaryOrderPage.CHANGE_QUANTITY__BUTTON_IN_POPUP))
                        .otherwise(Click.on(SummaryOrderPage.CANCEL_QUANTITY__BUTTON_IN_POPUP))
        );
    }

    public static Task fulfillByMarkAsFulfilled() {
        return Task.where("Expand Order Summary",
                CommonWaitUntil.isVisible(SummaryOrderPage.MARK_FULFILL_BUTTON(1)),
                Click.on(SummaryOrderPage.MARK_FULFILL_BUTTON(1)),
                CommonWaitUntil.isNotVisible(SummaryOrderPage.MARK_FULFILL_BUTTON(1)),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task createSubInvoice(String type, String suffix) {
        return Task.where("Create Sub-Invoice",
                CommonWaitUntil.isVisible(AllOrdersForm.SET_INVOICE),
                Click.on(AllOrdersForm.SET_INVOICE),
                Check.whether(type.equals("add to"))
                        .andIfSo(
                                CommonTask.chooseItemInDropdown(AllOrdersForm.SELECTED_TO_SUB_INVOICE, AllOrdersForm.ITEM_SELETED_TO_SUB_INVOICE("Add to", suffix))
                        ).otherwise(
                                CommonTask.chooseItemInDropdown(AllOrdersForm.SELECTED_TO_SUB_INVOICE, AllOrdersForm.ITEM_SELETED_TO_SUB_INVOICE("Create new sub-invoice", "1")),
                                Check.whether(suffix.equals(""))
                                        .otherwise(Enter.theValue(suffix).into(AllOrdersForm.SUFFIX_TEXTBOX))

                        ),
                WindowTask.threadSleep(5000),
                Click.on(AllOrdersForm.UPDATE_SELETED_TO_SUB_INVOICE),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task removeLineItemInOrderDetail(Map<String, String> info) {
        return Task.where("Remove quantity of line item in order detail",
                // Open popup remove
                CommonWaitUntil.isVisible(SummaryOrderPage.REMOVE_LINE_ITEM_BUTTON(info.get("sku"))),
                Click.on(SummaryOrderPage.REMOVE_LINE_ITEM_BUTTON(info.get("sku"))),
                CommonWaitUntil.isVisible(OrderDetailPage.POPUP_REASON),
                //Check reason popup
                CommonWaitUntil.isVisible(OrderDetailPage.POPUP_REASON),
                Check.whether(info.get("reason").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(OrderDetailPage.REASON_TEXTBOX_IN_POPUP_DELETE, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("reason")))),
                Check.whether(info.get("note").equals(""))
                        .otherwise(Enter.theValue(info.get("note")).into(OrderDetailPage.NOTE_TEXTAREA_IN_POPUP_DELETE)),
                Check.whether(info.get("deduction").equals("Yes"))
                        .andIfSo(Click.on(OrderDetailPage.DEDUCTION_CHECKBOX)),
                Check.whether(info.get("showEdit").equals("Yes"))
                        .andIfSo(Click.on(OrderDetailPage.SHOW_EDIT_DELETE_CHECKBOX)),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Choose reason"))
        );
    }

    public static Task exportOrderSummaryCSV(String fileName) {
        return Task.where("Export order summary CSV",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("CSV")),
                WindowTask.threadSleep(2000),
                CommonWaitUntil.waitToDownloadSuccessfully(fileName)
        );
    }
}

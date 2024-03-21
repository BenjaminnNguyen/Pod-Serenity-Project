package cucumber.tasks.admin.orders;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.AllOrdersForm;
import cucumber.user_interface.admin.orders.CreateNewOrderPage;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleOrders {

    public static Task check(String idInvoice) {
        return Task.where("Search order by idInvoice",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Enter.theValue(idInvoice).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number")),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task checkByInfo(Map<String, String> info) {
        return Task.where("Search order by info",
                Check.whether(info.get("orderNumber").isEmpty())
                        .otherwise(Enter.theValue(info.get("orderNumber")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number"))),
                Check.whether(info.get("orderSpecific").isEmpty())
                        .otherwise(Enter.theValue(info.get("orderSpecific")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("custom_store_name"))),
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
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_variant_ids"), info.get("sku"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("sku")))),
                Check.whether(info.get("upc").isEmpty())
                        .otherwise(Enter.theValue(info.get("upc")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("upc"))),
                Check.whether(info.get("fulfillment").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("fulfillment_state"), info.get("fulfillment"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("fulfillment")))),
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
                Check.whether(info.get("pendingFinancial").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("finance_state"), info.get("pendingFinancial"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("pendingFinancial")))),

                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task seeDetail(String idInvoice) {
        return Task.where("See detail order",
                CommonWaitUntil.isVisible(AllOrdersForm.ORDER_DETAIL_BY_ID(idInvoice)),
                Click.on(AllOrdersForm.ORDER_DETAIL_BY_ID(idInvoice)).afterWaitingUntilEnabled(),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task seeDetailFirstResult() {
        return Task.where("See detail order of first result",
                Click.on(AllOrdersForm.ORDER_DETAIL_FIRST_RESULT),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task chooseNoninvoice() {
        return Task.where("Create Sub-Invoice",
                Check.whether(CommonQuestions.isControlDisplay(AllOrdersForm.NON_INVOICE_EXPAND))
                        .andIfSo(
                                Click.on(AllOrdersForm.NON_INVOICE)
                        )
        );
    }

    public static Task chooseSkuToCreateSubInvoice(String skuName) {
        return Task.where("choose SKU to create sub invoice",
                CommonWaitUntil.isVisible(AllOrdersForm.CHECKBOX_SELECT_BY_SKU(skuName)),
                Scroll.to(AllOrdersForm.CHECKBOX_SELECT_BY_SKU(skuName)),
                Click.on(AllOrdersForm.CHECKBOX_SELECT_BY_SKU(skuName)),
                CommonWaitUntil.isVisible(AllOrdersForm.SET_INVOICE)
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
                                Check.whether(suffix.isEmpty())
                                        .otherwise(Enter.theValue(suffix).into(AllOrdersForm.SUFFIX_TEXTBOX))

                        ),
                Click.on(AllOrdersForm.UPDATE_SELETED_TO_SUB_INVOICE),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AllOrdersForm.ID_SUB_INVOICE)
        );
    }

    public static Task goToPopupCreatePurchaseOrder() {
        return Task.where("Go to popup create purchase order",
                CommonWaitUntil.isVisible(AllOrdersForm.PO_BUTTON),
                Click.on(AllOrdersForm.PO_BUTTON),
                CommonWaitUntil.isVisible(AllOrdersForm.DRIVER_TEXTBOX)
        );
    }

    public static Task goToPopupEditPurchaseOrder(String subInvoice) {
        return Task.where("Go to popup edit purchase order",
                Click.on(AllOrdersForm.EDIT_PO_BUTTON(subInvoice)),
                CommonWaitUntil.isVisible(AllOrdersForm.DRIVER_TEXTBOX),
                WindowTask.threadSleep(2000)
        );
    }

    public static Task addPurchaseOrder(Map<String, String> info) {
        return Task.where("Add purchase order",
                CommonTask.chooseItemInDropdownWithValueInput(AllOrdersForm.DRIVER_TEXTBOX, info.get("driver"), AllOrdersForm.DYNAMIC_ITEM(info.get("driver"))),
                CommonWaitUntil.isVisible(AllOrdersForm.D_TEXTBOX("Fulfillment date")),
                Check.whether(info.get("fulfillmentState").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown(AllOrdersForm.D_TEXTBOX("Fulfillment state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("fulfillmentState")))),
                Check.whether(info.get("fulfillmentDate").equals(""))
                        .otherwise(
                                Check.whether(info.get("fulfillmentDate").equals("clear"))
                                        .andIfSo(MoveMouse.to(AllOrdersForm.D_TEXTBOX("Fulfillment date")),
                                                CommonWaitUntil.isVisible(AllOrdersForm.ICON_CLOSE_DATE),
                                                Click.on(AllOrdersForm.ICON_CLOSE_DATE))
                                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("fulfillmentDate"), "MM/dd/yy")).into(AllOrdersForm.D_TEXTBOX("Fulfillment date")).thenHit(Keys.ENTER))),
                Check.whether(info.get("proof").equals(""))
                        .otherwise(
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a POD")),
                                WindowTask.threadSleep(500),
                                CommonFile.upload2(info.get("proof"), CommonAdminForm.ATTACHMENT_BUTTON)),
                Check.whether(info.get("adminNote").equals(""))
                        .otherwise(
                                CommonWaitUntil.isVisible(AllOrdersForm.D_TEXTBOX1("admin_note")),
                                Enter.theValue(info.get("adminNote")).into(AllOrdersForm.D_TEXTBOX1("admin_note"))),
                Check.whether(info.get("lpNote").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("lpNote")).into(AllOrdersForm.D_TEXTBOX("LP note")))
        );
    }

    public static Task removePurchaseOrder(String subInvoice) {
        return Task.where("Remove purchase order",
                CommonWaitUntil.isVisible(OrderDetailPage.PO_DELETE_BUTTON(subInvoice)),
                Click.on(OrderDetailPage.PO_DELETE_BUTTON(subInvoice)),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("This will permanently delete this purchase order. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK")),
                CommonWaitUntil.isVisible(OrderDetailPage.PO_DELETE_BUTTON(subInvoice))
        );
    }

    public static Task createPurchaseOrder(String type) {
        return Task.where(type + " purchase order",
                Click.on(AllOrdersForm.CREATE_PO_BUTTON(type)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AllOrdersForm.PO_LABEB_IN_SUBINVOICE)
        );
    }

    public static Task setReceiving(String receiving) {
        return Task.where("Set receiving",
                Click.on(OrderDetailPage.SET_RECEIVING_WEEKDAYS),
                CommonWaitUntil.isVisible(OrderDetailPage.SET_RECEIVING_WEEKDAYS_FIELD),
                CommonTask.chooseItemInDropdownWithValueInput(OrderDetailPage.SET_RECEIVING_WEEKDAYS_FIELD, receiving, AllOrdersForm.DYNAMIC_ITEM(receiving)),
                Hit.the(Keys.TAB).into(OrderDetailPage.SET_RECEIVING_WEEKDAYS_FIELD),
//                Enter.keyValues("").into(OrderDetailPage.SET_RECEIVING_WEEKDAYS_FIELD).thenHit(Keys.TAB),
                Click.on(OrderDetailPage.SET_RECEIVING_WEEKDAYS_UPDATE)
//                CommonWaitUntil.isVisible(OrderDetailPage.LOADING_ICON)
        );
    }

    public static Task fulfillOrder(Map<String, String> info) {
        return Task.where("Fulfill Order",
                Check.whether(CommonQuestions.isControlDisplay(OrderDetailPage.EXPAND_ODER)).andIfSo(
                        Click.on(OrderDetailPage.EXPAND_ODER),
                        CommonWaitUntil.isNotVisible(OrderDetailPage.LOADING_HEADER)),
                Scroll.to(OrderDetailPage.FULFILL_BUTTON(info.get("skuName"), info.get("index"))),
                CommonWaitUntil.isVisible(OrderDetailPage.FULFILL_BUTTON(info.get("skuName"), info.get("index"))),
                CommonWaitUntil.isEnabled(OrderDetailPage.FULFILL_DATE_TEXTBOX(info.get("skuName"), info.get("index"))),
                Enter.theValue(CommonHandle.setDate2(info.get("fulfillDate"), "MM/dd/yy")).into(OrderDetailPage.FULFILL_DATE_TEXTBOX(info.get("skuName"), info.get("index"))).thenHit(Keys.ENTER),
                WindowTask.threadSleep(2000),
                Click.on(OrderDetailPage.FULFILL_BUTTON(info.get("skuName"), info.get("index"))),
                WindowTask.threadSleep(2000)
        );
    }

    public static Task unfulfillOrder(Map<String, String> info) {
        return Task.where("Unfulfill Order",
                Check.whether(CommonQuestions.isControlDisplay(OrderDetailPage.EXPAND_ODER)).andIfSo(
                        Click.on(OrderDetailPage.EXPAND_ODER),
                        CommonWaitUntil.isNotVisible(OrderDetailPage.LOADING_HEADER)),
                Scroll.to(OrderDetailPage.FULFILL_BUTTON(info.get("skuName"), info.get("index"))),
                CommonWaitUntil.isVisible(OrderDetailPage.FULFILL_BUTTON(info.get("skuName"), info.get("index"))),
                CommonWaitUntil.isEnabled(OrderDetailPage.FULFILL_DATE_TEXTBOX(info.get("skuName"), info.get("index"))),
                WindowTask.threadSleep(2000),
                Click.on(OrderDetailPage.FULFILL_BUTTON(info.get("skuName"), info.get("index"))),
                WindowTask.threadSleep(2000)
        );
    }

    public static Task fillInfoToCreateOrder(Map<String, String> info) {
        return Task.where("Fill info to create order",
                CommonWaitUntil.isVisible(CreateNewOrderPage.DYNAMIC_TEXTBOX("Buyer")),
                CommonTask.chooseItemInDropdownWithValueInput(
                        CreateNewOrderPage.DYNAMIC_TEXTBOX("Buyer"), info.get("buyer"), CreateNewOrderPage.DYNAMIC_ITEM_DROPDOWN(info.get("buyer"))),
                Enter.keyValues(info.get("street")).into(CreateNewOrderPage.STREET1_TEXTBOX),
                CommonTask.chooseItemInDropdownWithValueInput(
                        CreateNewOrderPage.DYNAMIC_TEXTBOX("Payment type"), info.get("paymentType"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("paymentType"))),
                Enter.keyValues(info.get("city")).into(CreateNewOrderPage.DYNAMIC_TEXTBOX("City")),
                CommonTask.chooseItemInDropdownWithValueInput(
                        CreateNewOrderPage.DYNAMIC_TEXTBOX("State (Province/Territory)"), info.get("state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("state"))),
                Enter.keyValues(info.get("zip")).into(CreateNewOrderPage.DYNAMIC_TEXTBOX("Zip"))
        );
    }

    public static Task fillInfoOptionalToCreateOrder(Map<String, String> info) {
        return Task.where("Fill info optional to create order",
                Check.whether(info.get("customerPO").equals(""))
                        .otherwise(Enter.keyValues(info.get("customerPO")).into(CreateNewOrderPage.DYNAMIC_TEXTBOX("Customer PO"))),
                Check.whether(info.get("attn").equals(""))
                        .otherwise(Enter.keyValues(info.get("attn")).into(CreateNewOrderPage.DYNAMIC_TEXTBOX("ATTN"))),
                Check.whether(info.get("department").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown(
                                CreateNewOrderPage.DYNAMIC_TEXTBOX("Department"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("department")))),
                Check.whether(info.get("noteAdmin").equals(""))
                        .otherwise(Enter.keyValues(info.get("noteAdmin")).into(CreateNewOrderPage.DYNAMIC_TEXTAREA("Note for admin")))
        );
    }

    public static Task uploadFileOrder(String fileName) {
        return Task.where("Upload file order",
                CommonFile.upload1(fileName, CreateNewOrderPage.UPLOAD_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task addLineItem(String skuName) {
        return Task.where("Add line item",
                CommonWaitUntil.isClickable(CreateNewOrderPage.ADD_LINE_BUTTON),
                Scroll.to(CreateNewOrderPage.ADD_LINE_BUTTON),
                Click.on(CreateNewOrderPage.ADD_LINE_BUTTON),
                CommonWaitUntil.isVisible(CreateNewOrderPage.SEARCH_ITEM),
                WindowTask.threadSleep(1000),
                Enter.theValue(skuName).into(CreateNewOrderPage.SEARCH_ITEM),
                CommonWaitUntil.isVisible(CreateNewOrderPage.ITEM_RESULT),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                Click.on(CreateNewOrderPage.ITEM_RESULT),
                Check.whether(valueOf(CommonAdminForm.DYNAMIC_DIALOG("This SKU is launching soon. Do you want to continue?")), isVisible())
                        .andIfSo(Click.on(CommonAdminForm.DYNAMIC_BUTTON("OK"))),
                Check.whether(valueOf(CommonAdminForm.DYNAMIC_DIALOG("This SKU is out of stock. Do you want to continue?")), isVisible())
                        .andIfSo(Click.on(CommonAdminForm.DYNAMIC_BUTTON("OK"))),
                CommonWaitUntil.isNotVisible(CreateNewOrderPage.POPUP_SELECT_ITEM)
        );
    }

    public static Task addLineItemNoFound(String skuName) {
        return Task.where("Add line item",
                CommonWaitUntil.isClickable(CreateNewOrderPage.ADD_LINE_BUTTON),
                JavaScriptClick.on(CreateNewOrderPage.ADD_LINE_BUTTON),
                CommonWaitUntil.isVisible(CreateNewOrderPage.SEARCH_ITEM),
                Enter.theValue(skuName).into(CreateNewOrderPage.SEARCH_ITEM),
                CommonWaitUntil.isNotVisible(CreateNewOrderPage.ITEM_RESULT),
                Click.on(CreateNewOrderPage.CLOSE_POPUP_ADD_ITEM)
        );
    }

    public static Task addLineItemQty(String skuName, String num) {
        return Task.where("Add line item with quantity ",
                addLineItem(skuName),
                CommonWaitUntil.isVisible(CreateNewOrderPage.QUANTITY_OF_ITEM(skuName)),
//                Clear.field(CreateNewOrder.QUANTITY_OF_ITEM(skuName)),
                Hit.the(Keys.BACK_SPACE).into(CreateNewOrderPage.QUANTITY_OF_ITEM(skuName)),
                Enter.keyValues(num).into(CreateNewOrderPage.QUANTITY_OF_ITEM(skuName)).thenHit(Keys.TAB),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task uploadFileSucess() {
        return Task.where("Upload file success",
                Click.on(CreateNewOrderPage.ADD_LINE_ITEM_BUTTON)
        );
    }

    public static Task createOrderSuccess() {
        return Task.where("Create order success",
                CommonWaitUntil.isVisible(CreateNewOrderPage.CREATE_ORDER_BUTTON),
                Click.on(CreateNewOrderPage.CREATE_ORDER_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(OrderDetailPage.REGION_NAME)
        );
    }

    public static Performable createOrderSuccessPo(String order) {
        return Task.where("Create order success with customer po already used",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(CreateNewOrderPage.CREATE_ORDER_BUTTON),
                            Click.on(CreateNewOrderPage.CREATE_ORDER_BUTTON),
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
                            CommonWaitUntil.isVisible(OrderDetailPage.REGION_NAME)
                    );
                }
        );
    }

    public static Task openExpandOrder() {
        return Task.where("Open expand order",
                Check.whether(CommonQuestions.isControlDisplay(OrderDetailPage.EXPAND_ODER))
                        .andIfSo(
                                Click.on(OrderDetailPage.EXPAND_ODER),
                                CommonWaitUntil.isNotVisible(OrderDetailPage.LOADING_HEADER),
                                WindowTask.threadSleep(1000)
                        )
        );
    }

    public static Task updateQuantity(String sku, String quantity) {
        return Task.where("Update quantity",
                CommonWaitUntil.isVisible(OrderDetailPage.LINE_ITEM_QUANTITY(sku)),
                Click.on(OrderDetailPage.LINE_ITEM_QUANTITY(sku)),
                CommonWaitUntil.isVisible(OrderDetailPage.UPDATE_LINE_ITEM_FIELD),
                Enter.theValue(quantity).into(OrderDetailPage.UPDATE_LINE_ITEM_FIELD),
                Click.on(OrderDetailPage.UPDATE_LINE_ITEM_CHANGE),
                CommonWaitUntil.isVisible(OrderDetailPage.SAVE_ACTION),
                Click.on(OrderDetailPage.SAVE_ACTION),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(OrderDetailPage.LOADING_ICON)
        );
    }

    public static Task openVendorPayment() {
        return Task.where("Open vendor payment",
                Check.whether(CommonQuestions.isControlDisplay(OrderDetailPage.EXPAND_VENDOR_PAYMENT)).andIfSo(
                        Click.on(OrderDetailPage.EXPAND_VENDOR_PAYMENT),
                        CommonWaitUntil.isNotVisible(OrderDetailPage.LOADING_HEADER)
                )
        );
    }

    public static Task approveToFulfillThisOrder() {
        return Task.where("Approve to fulfill",
                CommonWaitUntil.isVisible(AllOrdersForm.APPROVE_TO_FULFILL),
                Click.on(AllOrdersForm.APPROVE_TO_FULFILL),
                CommonWaitUntil.isVisible(AllOrdersForm.WARNING_POPUP),
                Click.on(AllOrdersForm.APPROVE_THIS_ORDER_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AllOrdersForm.PO_BUTTON)

        );
    }

    public static Task approveToFulfillAllOrder() {
        return Task.where("Approve to fulfill all orders",
                CommonWaitUntil.isVisible(AllOrdersForm.APPROVE_TO_FULFILL),
                Click.on(AllOrdersForm.APPROVE_TO_FULFILL),
                CommonWaitUntil.isVisible(AllOrdersForm.WARNING_POPUP),
                Click.on(AllOrdersForm.APPROVE_ALL_ORDERS_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AllOrdersForm.PO_BUTTON)

        );
    }

    public static Task deleteLineItem(Map<String, String> info) {
        return Task.where("Delete line item",
                CommonWaitUntil.isVisible(OrderDetailPage.FULFILL_BUTTON(info.get("skuName"), info.get("index"))),
                Click.on(OrderDetailPage.DELETE_LINE_ITEM_BY_SKU(info.get("skuName"))),
                //Check reason popup
                CommonWaitUntil.isVisible(OrderDetailPage.POPUP_REASON),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Choose reason"))
        );
    }

    public static Task deleteLineItem(String group, Map<String, String> info) {
        return Task.where("Delete line item in non invoice",
                CommonWaitUntil.isVisible(OrderDetailPage.FULFILL_BUTTON(info.get("skuName"), info.get("index"))),
                Click.on(OrderDetailPage.DELETE_LINE_ITEM_BY_SKU(group, info.get("skuName"), info.get("index"))),
                //Check reason popup
                CommonWaitUntil.isVisible(OrderDetailPage.POPUP_REASON),
                Check.whether(info.get("reason").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(OrderDetailPage.REASON_TEXTBOX_IN_POPUP_DELETE, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("reason")))),
                Check.whether(info.get("note").equals(""))
                        .otherwise(Enter.theValue(info.get("note")).into(OrderDetailPage.NOTE_TEXTAREA_IN_POPUP_DELETE)),
                Check.whether(info.get("deduction").equals("Yes"))
                        .andIfSo(
                                Click.on(OrderDetailPage.DEDUCTION_CHECKBOX))
                        .otherwise(
                                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Choose reason")),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Choose reason"))
                        )
        );
    }

    public static Task deleteLineItemSuccess() {
        return Task.where("Delete line success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Choose reason")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Choose reason")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Choose reason"))
        );
    }

    public static Task saveAction() {
        return Task.where("Save action",
                //Save action
                CommonWaitUntil.isVisible(OrderDetailPage.SAVE_ACTION_BUTTON),
                Click.on(OrderDetailPage.SAVE_ACTION_BUTTON),
                //Wait loading
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task revertAction() {
        return Task.where("Revert action",
                //Save action
                CommonWaitUntil.isVisible(OrderDetailPage.REVERT_ACTION_BUTTON),
                Click.on(OrderDetailPage.REVERT_ACTION_BUTTON)
        );
    }

    public static Task editNewLineItem(Map<String, String> info) {
        return Task.where("Edit new line item",
                CommonWaitUntil.isVisible(OrderDetailPage.NEW_QUANTITY_TEXTBOX),
                Enter.theValue(info.get("quantity")).into(OrderDetailPage.NEW_QUANTITY_TEXTBOX),
                Check.whether(info.get("note").equals(""))
                        .otherwise(Enter.theValue(info.get("note")).into(OrderDetailPage.NEW_NOTE_TEXTAREA)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task removeSubInvoice(String subInvoice) {
        return Task.where("Remove sub invoice",
                Click.on(OrderDetailPage.REMOVE_SUBINVOICE_BY_ID(subInvoice)),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("This will permanently delete this sub invoice. Continue?")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task deleteOrder(Map<String, String> info) {
        return Task.where("Delete the order",
                CommonWaitUntil.isVisible(AllOrdersForm.ORDER_DETAIL_BY_ID(info.get("orderNumber"))),
                Scroll.to(AllOrdersForm.DELETE_ORDER(info.get("orderNumber"))),
                Click.on(AllOrdersForm.DELETE_ORDER(info.get("orderNumber"))),
                CommonWaitUntil.isVisible(AllOrdersForm.DELETE_ORDER_NOTE),
                CommonTask.chooseItemInDropdown(AllOrdersForm.DELETE_ORDER_REASON, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("reason"))),
                Check.whether(info.get("note").isEmpty())
                        .otherwise(Enter.theValue(info.get("note")).into(AllOrdersForm.DELETE_ORDER_NOTE)),
                // enter passkey
                Check.whether(info.get("passkey").isEmpty())
                        .otherwise(Enter.theValue(info.get("passkey")).into(AllOrdersForm.DELETE_ORDER_PASSKEY)),
                // delete
                Click.on(AllOrdersForm.DELETE_ORDER_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task deleteOrderDetail(Map<String, String> info) {
        return Task.where("Delete the order",
                // open popup delete order
                CommonWaitUntil.isVisible(AllOrdersForm.DELETE_ORDER_DETAIL),
                Click.on(AllOrdersForm.DELETE_ORDER_DETAIL),
                CommonWaitUntil.isVisible(AllOrdersForm.DELETE_ORDER_BUTTON),
                // fill info
                Check.whether(info.get("reason").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(AllOrdersForm.DELETE_ORDER_REASON, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("reason")))
                ),
                Check.whether(info.get("note").isEmpty())
                        .otherwise(Enter.theValue(info.get("note")).into(AllOrdersForm.DELETE_ORDER_NOTE)),
                // enter passkey
                Check.whether(info.get("passkey").isEmpty())
                        .otherwise(Enter.theValue(info.get("passkey")).into(AllOrdersForm.DELETE_ORDER_PASSKEY)),
                Check.whether(info.get("showEdit").equals("No"))
                        .andIfSo(Click.on(OrderDetailPage.ORDER_DETAIL_SHOW_EDIT_CHECKBOX)),
                Click.on(AllOrdersForm.DELETE_ORDER_BUTTON),
                CommonWaitUntil.isNotVisible(AllOrdersForm.DELETE_ORDER_BUTTON)
        );
    }

    public static Task removePodConsignment(String sku) {
        return Task.where("Remove pod consignment of line item",
                CommonWaitUntil.isVisible(OrderDetailPage.POP_CONSIGNMENT_SETTED(sku)),
                Click.on(OrderDetailPage.POP_CONSIGNMENT_SETTED(sku)),
                CommonWaitUntil.isVisible(OrderDetailPage.POP_CONSIGNMENT_REMOVE_BUTTON),
                Click.on(OrderDetailPage.POP_CONSIGNMENT_REMOVE_BUTTON),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("This will permanently delete this delivery record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK"))
//                CommonWaitUntil.isVisible(OrderDetailPage.DELIVERABLE_NOT_SET)
        );
    }

    public static Task editPodConsignment(Map<String, String> info) {
        return Task.where("Edit pod consignment of line item",
                CommonWaitUntil.isVisible(OrderDetailPage.POP_CONSIGNMENT_SETTED(info.get("sku"))),
                Click.on(OrderDetailPage.POP_CONSIGNMENT_SETTED(info.get("sku"))),
                CommonWaitUntil.isVisible(OrderDetailPage.POP_CONSIGNMENT_REMOVE_BUTTON),
                // edit comment
                Enter.theValue(info.get("comment")).into(OrderDetailPage.POP_CONSIGNMENT_COMMENT_TEXTAREA),

                Click.on(CommonAdminForm.DYNAMIC_GLOBAL_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_GLOBAL_DIALOG_BUTTON("Update"))
        );
    }

    public static Task editGeneralInformation(Map<String, String> info) {
        return Task.where("Edit general information",
                Check.whether(info.get("customerPO").isEmpty())
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(OrderDetailPage.CUSTOM_PO_FIELD, info.get("customerPO"))),
                Check.whether(info.get("customStoreName").isEmpty())
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(OrderDetailPage.CUSTOM_STORE_NAME_EDIT, info.get("customStoreName"))),
                Check.whether(info.get("adminNote").isEmpty())
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(OrderDetailPage.ADMIN_NOTE_FIELD_EDIT, info.get("adminNote")))
        );
    }

    public static Task goToEditAddress() {
        return Task.where("Go to edit address",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Edit")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Edit"))
        );
    }

    public static Task updateEditAddressSuccess() {
        return Task.where("Update edit address",
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update"))
        );
    }

    public static Task editAddress(Map<String, String> info) {
        return Task.where("Edit address",
                Check.whether(info.get("attn").isEmpty())
                        .otherwise(Enter.theValue(info.get("attn")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Attn"))),
                Check.whether(info.get("street1").isEmpty())
                        .otherwise(Enter.theValue(info.get("street1")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Street"))),
                Check.whether(info.get("street2").isEmpty())
                        .otherwise(Enter.theValue(info.get("street2")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT2("Street", 2))),
                Check.whether(info.get("city").isEmpty())
                        .otherwise(Enter.theValue(info.get("city")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("City"))),
                Check.whether(info.get("state").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_DIALOG_INPUT("State (Province/Territory)"), info.get("state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("state")))),
                Check.whether(info.get("zip").isEmpty())
                        .otherwise(Enter.theValue(info.get("zip")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Zip")))
        );
    }

    public static Task collapseOrder() {
        return Task.where("Collapse Order",
                Check.whether(CommonQuestions.isControlDisplay(OrderDetailPage.COLLAPSE_ODER)).andIfSo(
                        Click.on(OrderDetailPage.COLLAPSE_ODER),
                        WindowTask.threadSleep(1000)
                )
        );
    }

    public static Task editETA(String subInvoice, String eta) {
        return Task.where("Edit ETA textbox",
                CommonWaitUntil.isVisible(OrderDetailPage.ETA_TEXTBOX(subInvoice)),
                Enter.theValue(CommonHandle.setDate2(eta, "MM/dd/yy")).into(OrderDetailPage.ETA_TEXTBOX(subInvoice)).thenHit(Keys.ENTER)
        );
    }

    public static Task setDeliveable(String subInvoice, Map<String, String> info) {
        return Task.where("Set pod consignment of line item",
                CommonWaitUntil.isVisible(OrderDetailPage.DELIVERABLE_NOT_SET_BUTTON(subInvoice)),
                Scroll.to(OrderDetailPage.DELIVERABLE_NOT_SET_BUTTON(subInvoice)),
                Click.on(OrderDetailPage.DELIVERABLE_NOT_SET_BUTTON(subInvoice)),
                CommonWaitUntil.isVisible(OrderDetailPage.CREATE_DELIVERABLE_POPUP),
                CommonTask.chooseItemInDropdown1(OrderDetailPage.DELIVERY_METHOD_DROPDOWN, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("deliveryMethod"))),
                Check.whether(info.get("comment").isEmpty())
                        .otherwise(Enter.theValue(info.get("comment")).into(OrderDetailPage.DELIVERY_METHOD_COMMENT)),
                // nhập thông tin nếu delivery method là "Ship direct to stores"
                Check.whether(info.get("deliveryDate").isEmpty())
                        .otherwise(
                                CommonWaitUntil.isVisible(OrderDetailPage.DELIVERY_DATE_TEXTBOX),
                                Enter.theValue(CommonHandle.setDate2(info.get("deliveryDate"), "MM/dd/yy")).into(OrderDetailPage.DELIVERY_DATE_TEXTBOX).thenHit(Keys.ENTER)),
                Check.whether(info.get("carrier").isEmpty())
                        .otherwise(
                                CommonWaitUntil.isVisible(OrderDetailPage.CARRIER_DROPDOWN),
                                CommonTask.chooseItemInDropdown1(OrderDetailPage.CARRIER_DROPDOWN, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("carrier")))),
                Check.whether(info.get("trackingNumber").isEmpty())
                        .otherwise(
                                CommonWaitUntil.isVisible(OrderDetailPage.TRACKING_NUMBER_DROPDOWN),
                                Enter.theValue(info.get("trackingNumber")).into(OrderDetailPage.TRACKING_NUMBER_DROPDOWN)),
                // nhập thông tin nếu delivery method là "Self deliver to stores"
                Check.whether(info.get("deliveryStarTime").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdown1(OrderDetailPage.DELIVERY_FROM_TIME_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("deliveryStarTime"))),
                                WindowTask.threadSleep(1000),
                                CommonTask.chooseItemInDropdown1(OrderDetailPage.DELIVERY_TO_TIME_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("deliveryToTime")))
                        ),
                Check.whether(info.get("proof").isEmpty())
                        .otherwise(CommonFile.upload2(info.get("proof"), OrderDetailPage.DELIVERY_TO_PROOF)),
                Click.on(OrderDetailPage.DELIVERY_METHOD_UPDATE_POPUP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task editLineItemOfCreate(Map<String, String> info) {
        return Task.where("Edit line item of create new order page",
                CommonWaitUntil.isVisible(CreateNewOrderPage.QUANTITY_TEXTBOX_IN_LINE_ITEM(info.get("skuID"))),
                Clear.field(CreateNewOrderPage.QUANTITY_TEXTBOX_IN_LINE_ITEM(info.get("skuID"))),
                Enter.theValue(info.get("quantity")).into(CreateNewOrderPage.QUANTITY_TEXTBOX_IN_LINE_ITEM(info.get("skuID")))
        );
    }

    public static Task turnOffDisplaySurcharge() {
        return Task.where("Turn off display surcharge",
                Check.whether(valueOf(OrderDetailPage.DISPLAY_SURCHARGE_BUTTON_CHECKED), isCurrentlyVisible())
                        .andIfSo(Click.on(OrderDetailPage.DISPLAY_SURCHARGE_BUTTON_CHECKED),
                                CommonWaitUntil.isVisible(OrderDetailPage.DISPLAY_SURCHARGE_BUTTON_UNCHECKED))
        );
    }


    public static Task changeWarehouseOfLineitem(String sku, String warehouse) {
        return Task.where("Change warehouse of line item",
                CommonTask.chooseItemInDropdownWithValueInput1(OrderDetailPage.DISTRIBUTE_CENTER, warehouse, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(warehouse)),

                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("This warehouse does not have sufficient inventory level to confirm this line-item. If you proceed, the delivery method for this line-item will be cleared. Proceed?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Process")),
                CommonWaitUntil.isVisible(OrderDetailPage.DELIVERABLE_NOT_SET)
        );
    }

    public static Task editLineItemInOrderDetail(Map<String, String> info) {
        return Task.where("Edit quantity of line item in order detail",
                // Open popup quantity
                Scroll.to(OrderDetailPage.QUANTITY_OF_LINEITEM(info.get("order") + info.get("sub"), info.get("subID"))),
                Click.on(OrderDetailPage.QUANTITY_OF_LINEITEM(info.get("order") + info.get("sub"), info.get("subID"))),
                CommonWaitUntil.isVisible(OrderDetailPage.ITEM_QUANTITY_POPUP),
                // Edit quantity
                Clear.field(OrderDetailPage.ITEM_QUANTITY_POPUP_QUANTITY_TEXTBOX),
                Enter.theValue(info.get("quantity")).into(OrderDetailPage.ITEM_QUANTITY_POPUP_QUANTITY_TEXTBOX),
                Check.whether(info.get("reason").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdown1(OrderDetailPage.ITEM_QUANTITY_POPUP_REASON_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("reason")))),
                Check.whether(info.get("note").isEmpty())
                        .otherwise(Enter.theValue(info.get("note")).into(OrderDetailPage.ITEM_QUANTITY_POPUP_NOTE_TEXTBOX)),
                Check.whether(info.get("deduction").equals("Yes"))
                        .andIfSo(Click.on(OrderDetailPage.DEDUCTION_CHECKBOX_POPUP_NOTE)),
                Check.whether(info.get("showEdit").equals("Yes"))
                        .otherwise(Click.on(OrderDetailPage.SHOW_EDIT_CHECKBOX))
        );
    }

    public static Performable editDeductionQuantity(Map<String, String> info) {
        return Task.where("Edit deduction quantity",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(OrderDetailPage.DEDUCTION_QUANTITY),
                            CommonTask.chooseItemInDropdownWithValueInput(OrderDetailPage.DEDUCTION_CATEGORY, info.get("category"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("category")))
                    );
                    if (info.containsKey("subCategory")) {
                        actor.attemptsTo(
                                Check.whether(info.get("subCategory").isEmpty())
                                        .otherwise(
                                                CommonTask.chooseItemInDropdownWithValueInput(OrderDetailPage.DEDUCTION_SUB_CATEGORY, info.get("subCategory"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("subCategory"))))
                        );
                    }
                    actor.attemptsTo(
                            Check.whether(info.get("comment").isEmpty())
                                    .otherwise(
                                            Enter.theValue(info.get("comment")).into(OrderDetailPage.DEDUCTION_COMMENT))
                    );
                }
        );
    }

    public static Task updateQuantityInOrderDetail(String type) {
        return Task.where("Update quantity of line item in order detail",
                // Open popup quantity
                Check.whether(type.equals("Change"))
                        .andIfSo(Click.on(OrderDetailPage.CHANGE_QUANTITY__BUTTON_IN_POPUP))
                        .otherwise(Click.on(OrderDetailPage.CANCEL_QUANTITY__BUTTON_IN_POPUP))
        );
    }

    public static Task openDeliveryDetail(String subInvoice) {
        return Task.where("open Delivery Detail",
                CommonWaitUntil.isVisible(OrderDetailPage.DELIVERY_DETAIL(subInvoice)),
                Click.on(OrderDetailPage.DELIVERY_DETAIL(subInvoice))
        );
    }

    public static Task refreshPageByButton() {
        return Task.where("refresh page by button",
                CommonWaitUntil.isVisible(OrderDetailPage.REFRESH_BUTTON),
                Click.on(OrderDetailPage.REFRESH_BUTTON),
                CommonWaitUntil.isNotVisible(OrderDetailPage.LOADING_ICON),
                CommonWaitUntil.isClickable(OrderDetailPage.REFRESH_BUTTON),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task deleteLineItemCreate(String skuID) {
        return Task.where("Delete line item in create form",
                CommonWaitUntil.isVisible(OrderDetailPage.DELETE_LINE_ITEM_BY_SKU_BEFORE_CREATE(skuID)),
                JavaScriptClick.on(OrderDetailPage.DELETE_LINE_ITEM_BY_SKU_BEFORE_CREATE(skuID)),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task subscribe() {
        return Task.where("Subscribe order",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Subscribe")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Subscribe")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("A Slack message will be sent when this Express order is dispatched or marked as fulfilled")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Unsubscribe"))
        );
    }

    public static Task unsubscribe() {
        return Task.where("Unsubscribe order",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Unsubscribe")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Unsubscribe")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Subscribe"))
        );
    }

    public static Task fulfillByMarkAsFulfilled(Map<String, String> info) {
        return Task.where("fulfill by mark as fulfilled",
                CommonWaitUntil.isVisible(OrderDetailPage.MARK_FULFILL_BUTTON(info.get("sub"), 2)),
                Click.on(OrderDetailPage.MARK_FULFILL_BUTTON(info.get("sub"), 2)),
                CommonWaitUntil.isVisible(OrderDetailPage.SUB_INVOICE_FULFILLMENT_STATUS(info.get("sub"), "Fulfilled"))
        );
    }

    public static Task exportOrderDetail(String fileName) {
        return Task.where("Export order detail",
                CommonTask.chooseItemInDropdown2(OrderDetailPage.EXPORT_BUTTON, AllOrdersForm.ORDER_DETAIL_CSV),
                WindowTask.threadSleep(2000),
                CommonWaitUntil.waitToDownloadSuccessfully(fileName)
        );
    }

    public static Task exportOrderList(String fileName) {
        return Task.where("Export order list",
                CommonTask.chooseItemInDropdown2(AllOrdersForm.EXPORT_BUTTON, AllOrdersForm.ORDER_DETAIL_CSV),
                CommonWaitUntil.isVisible(AllOrdersForm.DANGER_EXPORT_TEXTBOX),
                Enter.theValue("I UNDERSTAND").into(AllOrdersForm.DANGER_EXPORT_TEXTBOX),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Process")),
                CommonWaitUntil.isNotVisible(AllOrdersForm.DANGER_EXPORT_TEXTBOX),
                WindowTask.threadSleep(2000),
                CommonWaitUntil.waitToDownloadSuccessfully(fileName)
        );
    }

    public static Task sendEtaEmail() {
        return Task.where("Send ETA email",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Send ETA email")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Send ETA email")).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(OrderDetailPage.ETA_SENT)
        );
    }

}

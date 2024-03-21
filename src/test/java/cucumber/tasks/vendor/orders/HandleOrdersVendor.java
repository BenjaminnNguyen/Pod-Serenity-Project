package cucumber.tasks.vendor.orders;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.orders.VendorOrderListPage;
import cucumber.user_interface.beta.Vendor.orders.VendorOrderDetailPage;
import cucumber.user_interface.lp.CommonLPPage;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.actions.Upload;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class HandleOrdersVendor {

    public static Performable search(Map<String, String> info) {
        return Task.where(actor -> {
                    if (!info.get("region").isEmpty())
                        actor.attemptsTo(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH("Region"), info.get("region"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("region")))
                        );
                    if (!info.get("store").isEmpty())
                        actor.attemptsTo(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH("Store"), info.get("store"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("store")))
                        );
                    if (!info.get("paymentStatus").isEmpty())
                        actor.attemptsTo(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH("Payment status"), info.get("paymentStatus"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("paymentStatus")))
                        );
                    if (!info.get("orderType").isEmpty())
                        actor.attemptsTo(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH("Order type"), info.get("orderType"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("orderType")))
                        );
                    if (!info.get("checkoutDate").isEmpty())
                        actor.attemptsTo(
                                Enter.theValue(CommonHandle.setDate2(info.get("checkoutDate"), "MM/dd/yy")).into(VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH("Checkout date (from)")).thenHit(Keys.ENTER)

                        );
                    if (info.containsKey("checkoutDateTo"))
                        if (!info.get("checkoutDateTo").isEmpty())
                            actor.attemptsTo(
                                    Enter.theValue(CommonHandle.setDate2(info.get("checkoutDateTo"), "MM/dd/yy")).into(VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH("Checkout date (to)")).thenHit(Keys.ENTER)

                            );
                    if (info.containsKey("fulfillmentState"))
                        if (!info.get("fulfillmentState").isEmpty())
                            actor.attemptsTo(
                                    CommonTask.chooseItemInDropdown(VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH("Fulfillment state"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("fulfillmentState")))
                            );
                    if (info.containsKey("fulfillmentFrom"))
                        if (!info.get("fulfillmentFrom").isEmpty())
                            actor.attemptsTo(
                                    Enter.theValue(CommonHandle.setDate2(info.get("fulfillmentFrom"), "MM/dd/yy")).into(VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH("Fulfillment date (from)")).thenHit(Keys.ENTER)

                            );
                    if (info.containsKey("fulfillmentTo"))
                        if (!info.get("fulfillmentTo").isEmpty())
                            actor.attemptsTo(
                                    Enter.theValue(CommonHandle.setDate2(info.get("fulfillmentTo"), "MM/dd/yy")).into(VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH("Fulfillment date (to)")).thenHit(Keys.ENTER)

                            );
                    actor.attemptsTo(
                            CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your orders..."))
                    );
                }
        );
    }

    public static Task inputSearchAll(Map<String, String> info) {
        return Task.where("search order",
                Check.whether(!Objects.equals(info.get("region"), ""))
                        .andIfSo(
                                CommonWaitUntil.isVisible(VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH_ALL("Region")),
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH_ALL("Region"), info.get("region"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("region"))),
                                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Fetching your orders..."))
                        ),
                Check.whether(!Objects.equals(info.get("store"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH_ALL("Store"), info.get("store"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("store"))),
                                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Fetching your orders..."))

                        ),
                Check.whether(!Objects.equals(info.get("paymentStatus"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH_ALL("Payment status"), info.get("paymentStatus"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("paymentStatus"))),
                                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Fetching your orders..."))
                        ),
                Check.whether(!Objects.equals(info.get("orderType"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH_ALL("Order type"), info.get("orderType"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("orderType"))),
                                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Fetching your orders..."))

                        ),
                Check.whether(info.get("checkoutDateFrom").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("checkoutDateFrom"), "MM/dd/yy")).into(VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH_ALL("Checkout date (from)")).thenHit(Keys.ENTER),
                        CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Fetching your orders..."))
                ),
                Check.whether(info.get("checkoutDateTo").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("checkoutDateTo"), "MM/dd/yy")).into(VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH_ALL("Checkout date (to)")).thenHit(Keys.ENTER),
                        CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Fetching your orders..."))
                )
        );
    }

    public static Task chooseTypeOrder(String type) {
        return Task.where("Choose type order",
                Click.on(VendorOrderListPage.TYPE_ORDER(type)),
                CommonWaitUntil.isNotVisible(VendorOrderListPage.LOADING_SPINNER)
        );
    }


    public static Task closeSearchAll() {
        return Task.where("close search order",
                CommonWaitUntil.isVisible(VendorOrderListPage.CLOSE_SEARCH_ALL),
                Click.on(VendorOrderListPage.CLOSE_SEARCH_ALL),
                CommonWaitUntil.isNotVisible(VendorOrderListPage.CLOSE_SEARCH_ALL)
        );
    }

    public static Task collapse(String collapse) {
        return Task.where("collapse search order",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON(collapse)),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON(collapse)),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task clearSearchAll() {
        return Task.where("close search order",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Clear all filters")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Clear all filters")),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING)
        );
    }

    public static Task searchAll() {
        return Task.where("Open search all order",
                CommonWaitUntil.isVisible(VendorOrderListPage.SEARCH_ALL),
                Click.on(VendorOrderListPage.SEARCH_ALL),
                CommonWaitUntil.isVisible(VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH_ALL("Region"))
        );
    }

    public static Task switchPages(String num) {
        List<WebElementFacade> page = VendorOrderListPage.NUMBER_PAGE.resolveAllFor(theActorInTheSpotlight());
        if (page.size() > 1) {
            return Task.where("go to page " + num,
                    Click.on(page.get(Integer.parseInt(num) - 1))
            );
        } else
            return Task.where("Only 1 page showing");
    }

    public static Task switchPages(WebElementFacade num) {
        return Task.where("go to page " + num,
                Click.on(num),
                CommonWaitUntil.isNotVisible(VendorOrderListPage.LOADING_SPINNER)
        );
    }

    public static Task selectConfirmItems(Map<String, String> map) {
        return Task.where("Select item to confirm " + map.get("sku"),
                Check.whether(map.get("date").isEmpty()).otherwise(
                        CommonWaitUntil.isVisible(VendorOrderDetailPage.EXPIRY_DATE_TEXTBOX(map.get("sku"))),
                        Enter.theValue(CommonHandle.setDate2(map.get("date"), "MM/dd/yy")).into(VendorOrderDetailPage.EXPIRY_DATE_TEXTBOX(map.get("sku"))).thenHit(Keys.ENTER)),
                Check.whether(map.get("sku").isEmpty()).otherwise(
                        Click.on(VendorOrderDetailPage.CHECK_CONFIRM_ITEM(map.get("sku"))))
//                CommonWaitUntil.isVisible(VendorOrderDetailPage.CONFIRM_BTN)
        );
    }

    public static Task confirmItems(Map<String, String> map) {
        return Task.where("confirm " + map.get("delivery"),
                Click.on(VendorOrderDetailPage.CONFIRM_BTN),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.CHOOSE_DELIVERY_CONFIRM),
                Click.on(VendorOrderDetailPage.CHOOSE_DELIVERY_CONFIRM),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.DYNAMIC_TEXT_SPAN(map.get("delivery"))),
                Click.on(VendorOrderDetailPage.DYNAMIC_TEXT_SPAN(map.get("delivery"))),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM)
        );
    }

    public static Task chooseDeliveryMethod(String deliveryMethod) {
        return Task.where("chooseDeliveryMethod " + deliveryMethod,
//                Click.on(VendorOrderDetailPage.CONFIRM_BTN),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.CHOOSE_DELIVERY_CONFIRM),
                Click.on(VendorOrderDetailPage.CHOOSE_DELIVERY_CONFIRM),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.DYNAMIC_TEXT_SPAN(deliveryMethod)),
                Click.on(VendorOrderDetailPage.DYNAMIC_TEXT_SPAN(deliveryMethod))
//                CommonWaitUntil.isVisible(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM)
        );
    }

    public static Task shippingInfo(Map<String, String> map) {
        if (map.get("shippingMethod").contains("Use my own shipping label")) {
            return Task.where("Fill info with use my orn shipping label",
                    CommonWaitUntil.isVisible(VendorOrderDetailPage.DYNAMIC_TEXT_SPAN(map.get("shippingMethod"))),
                    Click.on(VendorOrderDetailPage.DYNAMIC_TEXT_SPAN(map.get("shippingMethod"))),
                    CommonWaitUntil.isVisible(VendorOrderDetailPage.DELIVERY_DATE),
                    Check.whether(map.get("deliveryDate").isEmpty())
                            .otherwise(
                                    Enter.theValue(CommonHandle.setDate(map.get("deliveryDate"), "MM/dd/yy")).into(VendorOrderDetailPage.DELIVERY_DATE).thenHit(Keys.ENTER)),
                    Check.whether(map.get("carrier").isEmpty())
                            .otherwise(
                                    CommonTask.chooseItemInDropdown1(VendorOrderDetailPage.PARCEL_INFORMATION("Carrier"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN1(map.get("carrier")))),
                    Check.whether(map.get("trackingNumber").isEmpty())
                            .otherwise(
                                    Enter.theValue(map.get("trackingNumber")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Tracking number"))),
                    Check.whether(map.get("comment").isEmpty())
                            .otherwise(
                                    Enter.theValue(map.get("comment")).into(VendorOrderDetailPage.DELIVERY_COMMENTS)),

                    Click.on(VendorOrderDetailPage.DELIVERY_CONFIRM_BTN)
//                    CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_P_ALERT("Delivery information updated successfully! Please print invoice & packing slip!"))
            );
        } else
            return Task.where("Fill info with use my orn shipping label ",
                    CommonWaitUntil.isVisible(VendorOrderDetailPage.DYNAMIC_TEXT_SPAN(map.get("shippingMethod"))),
                    WindowTask.threadSleep(2000),
                    Click.on(VendorOrderDetailPage.DYNAMIC_TEXT_SPAN(map.get("shippingMethod"))).afterWaitingUntilEnabled(),
                    CommonWaitUntil.isVisible(VendorOrderDetailPage.PARCEL_INFORMATION("Width")),
                    Check.whether(map.get("width").isEmpty()).otherwise(
                            Enter.theValue(map.get("width")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Width"))
                    ),
                    Check.whether(map.get("height").isEmpty()).otherwise(
                            Enter.theValue(map.get("height")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Height"))
                    ),
                    Check.whether(map.get("length").isEmpty()).otherwise(
                            Enter.theValue(map.get("length")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Length"))
                    ),
                    Check.whether(map.get("weight").isEmpty()).otherwise(
                            Enter.theValue(map.get("weight")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Weight"))
                    ),
                    Check.whether(map.get("distance").isEmpty()).otherwise(
                            Click.on(VendorOrderDetailPage.PARCEL_INFORMATION("Distance Unit")),
                            CommonTask.ChooseValueFromSuggestions(map.get("distance"))
                    ),
                    Check.whether(map.get("mass").isEmpty()).otherwise(
                            Click.on(VendorOrderDetailPage.PARCEL_INFORMATION("Mass Unit")),
                            CommonTask.ChooseValueFromSuggestions(map.get("mass"))
                    ),
                    Check.whether(map.get("name").isEmpty()).otherwise(
                            Enter.theValue(map.get("name")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Name"))
                    ),
                    Check.whether(map.get("company").isEmpty()).otherwise(
                            Enter.theValue(map.get("company")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Company"))
                    ),
                    Check.whether(map.get("address1").isEmpty()).otherwise(
                            Enter.theValue(map.get("address1")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Address street 1"))
                    ),
                    Check.whether(map.get("city").isEmpty()).otherwise(
                            Enter.theValue(map.get("city")).into(VendorOrderDetailPage.PARCEL_INFORMATION("City"))
                    ),
                    Check.whether(map.get("zipcode").isEmpty()).otherwise(
                            Enter.theValue(map.get("zipcode")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Zipcode"))
                    ),
                    Check.whether(map.get("state").isEmpty()).otherwise(
                            CommonTask.chooseItemInDropdownWithValueInput1(VendorOrderDetailPage.PARCEL_INFORMATION("State"), map.get("state"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(map.get("state")))
                    ),
                    Check.whether(map.get("country").isEmpty()).otherwise(
                            Click.on(VendorOrderDetailPage.PARCEL_INFORMATION("Country")),
                            CommonTask.ChooseValueFromSuggestions(map.get("country"))
                    ),
                    Check.whether(map.get("email").isEmpty()).otherwise(
                            Enter.theValue(map.get("email")).into(VendorOrderDetailPage.PARCEL_INFORMATION("Email"))
                    ),
                    Scroll.to(VendorOrderDetailPage.GET_RATE),
                    Click.on(VendorOrderDetailPage.GET_RATE),
//                    WindowTask.threadSleep(500),
                    CommonWaitUntil.isNotVisible(VendorOrderDetailPage.GET_RATE_LOADING)
            );
    }

    public static Task selectRate() {
        return Task.where("select shippo ",
                CommonWaitUntil.isVisible(VendorOrderDetailPage.CHECK_SHIPPO),
                Scroll.to(VendorOrderDetailPage.CHECK_SHIPPO),
                Click.on(VendorOrderDetailPage.CHECK_SHIPPO)
//                CommonWaitUntil.isEnabled(VendorOrderDetailPage.BUY),
//                Click.on(VendorOrderDetailPage.BUY),
//                CommonWaitUntil.isNotVisible(VendorOrderDetailPage.BUY)

        );
    }

    public static Task viewDelivery(String type) {
        return Task.where("View Delivery detail",
                CommonWaitUntil.isVisible(VendorOrderDetailPage.PRINT_BTN),
                Click.on(VendorOrderDetailPage.PRINT_BTN),
                WindowTask.switchToChildWindowsByTitle("Order #"),
                Check.whether(type.equals("Self-deliver to Store"))
                        .andIfSo(
                                CommonWaitUntil.isPresent(VendorOrderDetailPage.UPLOAD_BUTTON),
                                CommonFile.upload1("ProofOfDelivery.pdf", VendorOrderDetailPage.UPLOAD_BUTTON),
                                CommonWaitUntil.isVisible(VendorOrderDetailPage.UPLOAD_PROOF("ProofOfDelivery.pdf"))
                        ),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.DYNAMIC_TEXT_SPAN("View delivery details")),
                Click.on(VendorOrderDetailPage.DYNAMIC_TEXT_SPAN("View delivery details")),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM)

        );
    }

    public static Task print() {
        return Task.where("Print invoice",
                CommonWaitUntil.isVisible(VendorOrderDetailPage.PRINT_BTN),
                Click.on(VendorOrderDetailPage.PRINT_BTN)
        );
    }

    public static Task viewDeliveryDetail(String subInvoice) {
        return Task.where("View Delivery detail",
                CommonWaitUntil.isVisible(VendorOrderDetailPage.DELIVERY_DETAIL(subInvoice)),
                Click.on(VendorOrderDetailPage.DELIVERY_DETAIL(subInvoice)),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM)
        );
    }

    public static Task uploadProofOfDelivery(String type) {
        return Task.where("View Delivery detail",
                CommonWaitUntil.isPresent(VendorOrderDetailPage.UPLOAD_BUTTON),
                CommonFile.upload1("ProofOfDelivery.pdf", VendorOrderDetailPage.UPLOAD_BUTTON),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.UPLOAD_PROOF("ProofOfDelivery.pdf"))

        );
    }

    public static Task fillInfoSelfDelivery(Map<String, String> map) {
        return Task.where("Fill info self delivery",
                Check.whether(map.get("deliveryDate").equals(""))
                        .otherwise(
                                CommonWaitUntil.isVisible(VendorOrderDetailPage.DELIVERY_DATE),
                                Enter.theValue(CommonHandle.setDate2(map.get("deliveryDate"), "MM/dd/yy")).into(VendorOrderDetailPage.DELIVERY_DATE).thenHit(Keys.ENTER)),
                Check.whether(map.get("from").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(VendorOrderDetailPage.FROM_TEXTBOX, map.get("from"), VendorOrderDetailPage.DYNAMIC_ITEM_DROPDOWN(map.get("from")))),
                Check.whether(map.get("to").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(VendorOrderDetailPage.TO_TEXTBOX, map.get("to"), VendorOrderDetailPage.DYNAMIC_ITEM_DROPDOWN(map.get("to")))),
                Check.whether(map.get("comment").equals(""))
                        .otherwise(
                                Enter.theValue(map.get("comment")).into(VendorOrderDetailPage.COMMENT_TEXTAREA)),
                Click.on(VendorOrderDetailPage.CONFIRM_BUTTON),
                CommonWaitUntil.isNotVisible(VendorOrderDetailPage.POPUP_MESSAGE_DELIVERY)
        );
    }

    public static Task goToPrintInvoicePackingSlip(String idOrder) {
        return Task.where("Go to Print Invoice/Packing slip",
                Click.on(VendorOrderDetailPage.SHOW_MORE_ACTION),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.D_MENU_SHOW_MORE("Print invoice/Packing slip")),
                Click.on(VendorOrderDetailPage.D_MENU_SHOW_MORE("Print invoice/Packing slip")),
                WindowTask.threadSleep(5000),
                CommonTask.pressESC(),
                WindowTask.switchToChildWindowsByTitle1(idOrder + " - Pod Foods | Online Distribution Platform for Emerging Brands"),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.D_INFO_SUB_INVOICE("Order Date"))
        );
    }

    public static Task removeSubInvoice(String subInvoice, String sku, String index, String allDelete) {
        return Task.where("Remove sub invoice",
                Click.on(VendorOrderDetailPage.DELETE_SUB_INVOICE(subInvoice, sku, index)),
                Check.whether(allDelete.equals("all"))
                        .andIfSo(
                                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT("Deleting a shipment will clear all delivery details of its line items. Continue?")),
                                Click.on(CommonVendorPage.DYNAMIC_BUTTON("OK"))
                        ),
                CommonWaitUntil.isNotVisible(CommonVendorPage.DYNAMIC_P_ALERT("Shipment deleted successfully!")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Confirm"))
        );
    }

    public static Task goToEditSubInvoice() {
        return Task.where("Go to edit sub invoice",
                CommonWaitUntil.isVisible(VendorOrderDetailPage.SHOW_MORE_ACTION),
                Click.on(VendorOrderDetailPage.SHOW_MORE_ACTION),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.D_MENU_SHOW_MORE("Print invoice/Packing slip")),
                Click.on(VendorOrderDetailPage.D_MENU_SHOW_MORE("View/Edit sub-invoice")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Confirm"))
        );
    }

    public static Task moreAction(String action, String subInvoice) {
        return Task.where("Go to " + action,
                CommonWaitUntil.isVisible(VendorOrderDetailPage.SHOW_MORE_ACTION(subInvoice)),
                Click.on(VendorOrderDetailPage.SHOW_MORE_ACTION(subInvoice)),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.D_MENU_SHOW_MORE(action)),
                Check.whether(action.contains("Upload Proof of Delivery")).otherwise(
                        Click.on(VendorOrderDetailPage.D_MENU_SHOW_MORE(action))
                )
        );
    }

    public static Task deleteShipment() {
        return Task.where("Delete shipment",
                Click.on(VendorOrderDetailPage.SHOW_MORE_ACTION),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.D_MENU_SHOW_MORE("Print invoice/Packing slip")),
                Click.on(VendorOrderDetailPage.D_MENU_SHOW_MORE("Delete this shipment")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT("Deleting a shipment will clear all delivery details of its line items. Continue?")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("OK"))
        );
    }
}

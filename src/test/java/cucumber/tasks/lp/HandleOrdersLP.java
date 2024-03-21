package cucumber.tasks.lp;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.orders.VendorOrderListPage;
import cucumber.user_interface.lp.CommonLPPage;
import cucumber.user_interface.lp.LPOrdersDetailPage;
import cucumber.user_interface.lp.OrdersLPPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class HandleOrdersLP {

    public static Task filter(Map<String, String> info) {
        Task task = Task.where("Filter order by info",
                CommonWaitUntil.isVisible(OrdersLPPage.DYNAMIC_FILTER("Fulfillment state")),
                Check.whether(info.get("orderBy").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(OrdersLPPage.DYNAMIC_FILTER("Order by"), info.get("orderBy"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_1(info.get("orderBy")))
                ),
                Check.whether(info.get("fulFillState").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(OrdersLPPage.DYNAMIC_FILTER("Fulfillment state"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_1(info.get("fulFillState")))
                ),
                Check.whether(info.get("store").isEmpty()).otherwise(
                        Enter.theValue(info.get("store")).into(OrdersLPPage.DYNAMIC_FILTER("Store")).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("fulFilledDate").isEmpty())
                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("fulFilledDate"), "MM/dd/yy")).into(OrdersLPPage.DYNAMIC_FILTER("Fulfilled date")).thenHit(Keys.ENTER)),
                Check.whether(info.get("order").isEmpty()).otherwise(
                        Enter.theValue(info.get("order")).into(OrdersLPPage.DYNAMIC_FILTER("Order # / PO #")).thenHit(Keys.ENTER)
                )
//                Check.whether(info.get("po").isEmpty()).otherwise(
//                        Enter.theValue(info.get("po")).into(OrdersLPPage.DYNAMIC_FILTER("PO #")).thenHit(Keys.ENTER)
//                ),
        );
        if (info.containsKey("route")) {
            task.then(
                    Check.whether(info.get("route").isEmpty()).otherwise(
                            CommonTask.chooseItemInDropdownWithValueInput1(OrdersLPPage.DYNAMIC_FILTER_ALL("Route"), info.get("route"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(info.get("route")))
                    )
            );
        }
        if (info.containsKey("uploadInvoice")) {
            task.then(
                    Check.whether(info.get("uploadInvoice").isEmpty()).otherwise(
                            CommonTask.chooseItemInDropdown(OrdersLPPage.DYNAMIC_FILTER_ALL("Invoice uploaded?"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(info.get("uploadInvoice")))
                    )
            );
        }
        return Task.where("Filter order by info", task, WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your orders..."))
        );
    }

    public static Task filterOrderJustCreated() {
        return Task.where("Filter order by info",
                Enter.theValue(Serenity.sessionVariableCalled("ID Invoice").toString().substring(7)).into(OrdersLPPage.DYNAMIC_FILTER("Order # / PO #")).thenHit(Keys.ENTER),
                CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your orders..."))
        );
    }

    public static Task searchAll() {
        return Task.where("Open search all order",
                CommonWaitUntil.isVisible(VendorOrderListPage.SEARCH_ALL),
                Click.on(VendorOrderListPage.SEARCH_ALL),
                CommonWaitUntil.isVisible(VendorOrderListPage.DYNAMIC_TEXTBOX_SEARCH_ALL("Fulfillment state"))
        );
    }

    public static Task inputSearchAll(Map<String, String> info) {
        return Task.where("search all order",
                Check.whether(info.get("fulFillState").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(OrdersLPPage.DYNAMIC_FILTER_ALL("Fulfillment state"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(info.get("fulFillState")))
                ),
                Check.whether(info.get("store").isEmpty()).otherwise(
                        Enter.theValue(info.get("store")).into(OrdersLPPage.DYNAMIC_FILTER_ALL("Store")).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("fulFilledDate").isEmpty())
                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("fulFilledDate"), "MM/dd/yy")).into(OrdersLPPage.DYNAMIC_FILTER_ALL("Fulfilled date")).thenHit(Keys.ENTER)),
                Check.whether(info.get("order").isEmpty()).otherwise(
                        Enter.theValue(info.get("order")).into(OrdersLPPage.DYNAMIC_FILTER_ALL("Order #")).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("po").isEmpty()).otherwise(
                        Enter.theValue(info.get("po")).into(OrdersLPPage.DYNAMIC_FILTER_ALL("PO #")).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("route").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput1(OrdersLPPage.DYNAMIC_FILTER_ALL("Route"), info.get("route"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(info.get("route")))
                ),
                Check.whether(info.get("uploadInvoice").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(OrdersLPPage.DYNAMIC_FILTER_ALL("Invoice uploaded?"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(info.get("uploadInvoice")))
                ),
                CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your orders..."))
        );
    }

    public static Task closeSearchAll() {
        return Task.where("close search order",
                CommonWaitUntil.isVisible(OrdersLPPage.CLOSE_SEARCH_ALL),
                Click.on(OrdersLPPage.CLOSE_SEARCH_ALL),
                CommonWaitUntil.isNotVisible(OrdersLPPage.CLOSE_SEARCH_ALL)
        );
    }

    public static Task collapse(String collapse) {
        return Task.where("collapse search order",
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON(collapse)),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON(collapse)),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task seeDetail(String idSubinvoice) {
        return Task.where("See detail order LP",
                CommonWaitUntil.isVisible(OrdersLPPage.DYNAMIC_ORDER_BY_ID(idSubinvoice)),
                Click.on(OrdersLPPage.DYNAMIC_ORDER_BY_ID(idSubinvoice)),
                CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Loading order details..."))
        );
    }

    public static Task seeInvoice(String idInvoiceLP) {
        return Task.where("See Invoice",
                CommonWaitUntil.isVisible(OrdersLPPage.INVOICE_BUTTON),
                Scroll.to(OrdersLPPage.INVOICE_BUTTON),
                Click.on(OrdersLPPage.INVOICE_BUTTON),
                WindowTask.threadSleep(5000),
                WindowTask.switchToChildWindowsByTitle1("PO_" + idInvoiceLP + " - Pod Foods | Online Distribution Platform for Emerging Brands"),
                CommonWaitUntil.isVisible(OrdersLPPage.TOTAL_INVOICE)
        );
    }

    public static void setFulfillment(String date) {
        date = CommonHandle.setDate2(date, "MMMM d, yyyy");
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPOrdersDetailPage.FULFILLMENT_DATE),
                Scroll.to(LPOrdersDetailPage.FULFILLMENT_DATE),
                Click.on(LPOrdersDetailPage.FULFILLMENT_DATE(date)),
                Click.on(LPOrdersDetailPage.SET_FULFILLMENT_DATE_BUTTON).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(LPOrdersDetailPage.MESSAGE_SUCCESS)
        );
    }

    public static Task confirmOderUnconfirmed() {
        return Task.where("Confirm Order Unconfirmed",
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON("Confirm")),
                Click.on(CommonLPPage.DYNAMIC_BUTTON("Confirm")
                ));
    }

    public static Task setFulfillment1(String date) {
        return Task.where("Set fulfillment order by date",
                Scroll.to(LPOrdersDetailPage.FULFILLMENT_DATE1),
                Check.whether(date.isEmpty())
                        .andIfSo(
                                Ensure.that(CommonLPPage.DYNAMIC_BUTTON("Pick a fulfillment date first")).isDisplayed()
                        )
                        .otherwise(
                                handleDateTime(date),
                                CommonWaitUntil.isVisible(LPOrdersDetailPage.SET_FULFILLMENT_DATE1),
                                Click.on(LPOrdersDetailPage.SET_FULFILLMENT_DATE1),
                                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_ALERT("Fulfillment details updated successfully.")),
                                CommonWaitUntil.isNotVisible(CommonLPPage.DYNAMIC_ALERT("Fulfillment details updated successfully.")))

        );
    }

    public static Task handleDateTime(String date) {
        String dateFull = CommonHandle.setDateFull(date);
        return Task.where("Choose date",
                Check.whether(CommonQuestions.AskForAttributeContainText(LPOrdersDetailPage.FULFILLMENT_DATE_IN_MONTH(dateFull), "class", "in-next-month"))
                        .andIfSo(
                                Click.on(LPOrdersDetailPage.RIGHT_ARROW_DATE),
                                CommonWaitUntil.isVisible(LPOrdersDetailPage.FULFILLMENT_DATE(dateFull)),
                                Click.on(LPOrdersDetailPage.FULFILLMENT_DATE(dateFull))
                        ).otherwise(
                                Check.whether(CommonQuestions.AskForAttributeContainText(LPOrdersDetailPage.FULFILLMENT_DATE_IN_MONTH(dateFull), "class", "in-prev-month"))
                                        .andIfSo(
                                                Click.on(LPOrdersDetailPage.LEFT_ARROW_DATE),
                                                CommonWaitUntil.isVisible(LPOrdersDetailPage.FULFILLMENT_DATE(dateFull)),
                                                Click.on(LPOrdersDetailPage.FULFILLMENT_DATE(dateFull))),
                                Check.whether(CommonQuestions.AskForAttributeContainText(LPOrdersDetailPage.FULFILLMENT_DATE_IN_MONTH(dateFull), "class", "in-month"))
                                        .andIfSo(
                                                CommonWaitUntil.isVisible(LPOrdersDetailPage.FULFILLMENT_DATE(dateFull)),
                                                Click.on(LPOrdersDetailPage.FULFILLMENT_DATE(dateFull)))

                        ));
    }

    public static Task seePackingSlip(String idInvoiceLP) {
        return Task.where("See packing slip",
                CommonWaitUntil.isVisible(OrdersLPPage.PACKING_SLIP_BUTTON),
                Scroll.to(OrdersLPPage.PACKING_SLIP_BUTTON),
                Click.on(OrdersLPPage.PACKING_SLIP_BUTTON),
                WindowTask.threadSleep(5000),
                WindowTask.switchToChildWindowsByTitle1("PO_" + idInvoiceLP + " - Pod Foods | Online Distribution Platform for Emerging Brands"),
                CommonWaitUntil.isVisible(OrdersLPPage.D_FIELD_PACKING_SLIP("Store"))
        );
    }
}

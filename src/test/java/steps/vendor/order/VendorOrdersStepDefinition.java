package steps.vendor.order;

import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.*;
import cucumber.tasks.vendor.orders.HandleOrdersVendor;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.orders.VendorOrderListPage;
import cucumber.user_interface.beta.Vendor.orders.VendorOrderDetailPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.et.Ja;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;
import org.hamcrest.Matchers;

import java.util.*;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.Matchers.*;

public class VendorOrdersStepDefinition {
    @And("See detail order by idInvoice")
    public void see_detail_order() {
        String idInvoice = Serenity.sessionVariableCalled("ID Invoice");
        idInvoice = idInvoice.substring(6);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorOrderListPage.ORDER_BY_ID(idInvoice)),
                Click.on(VendorOrderListPage.ORDER_BY_ID(idInvoice)),
                CommonWaitUntil.isNotVisible(VendorOrderListPage.LOADING_SPINNER)
        );
    }

    @And("Verify promotion in order of vendor")
    public void verify_promotion_in_order_of_vendor(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorOrderListPage.SHOW_INFO_ORDER)
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(VendorOrderListPage.PROMOTION_DICOUNT), containsString(expected.get(0).get("promotion"))),
                seeThat(CommonQuestions.targetText(VendorOrderListPage.CURRENT_PRICE_PROMO), containsString(expected.get(0).get("currentPrice")))
        );
    }

    @And("Vendor Check items in order detail")
    public void vendor_check_item_in_order_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> info = CommonTask.setValueRandom(list.get(i), "skuName", Serenity.sessionVariableCalled("SKU inventory"));
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.BRAND_NAME(i + 1)), equalToIgnoringCase(list.get(i).get("brandName"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.PRODUCT_NAME(i + 1)), containsString(list.get(i).get("productName"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.SKU_NAME(i + 1)), containsString(info.get("skuName"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.CASE_PRICE(i + 1)), containsString(list.get(i).get("casePrice"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.QUANTITY(i + 1)), containsString(list.get(i).get("quantity"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.TOTAL_IN_DETAIL(i + 1)), equalToIgnoringCase(list.get(i).get("total")))
            );
            if (list.get(i).containsKey("podConsignment"))
                theActorInTheSpotlight().attemptsTo(
                        Check.whether(list.get(i).get("podConsignment").contains("Pod Consignment"))
                                .andIfSo(
                                        Ensure.that(VendorOrderDetailPage.POD_CONSIGNMENT(i + 1)).text().containsIgnoringCase(list.get(i).get("podConsignment"))
                                ),
                        Check.whether(list.get(i).get("podConsignment").equals("not set"))
                                .andIfSo(
                                        Ensure.that(VendorOrderDetailPage.POD_CONSIGNMENT_NOT_SET).isDisplayed()
                                )
                );
        }
    }

    @And("Vendor verify change quantity history in order detail")
    public void vendor_verify_change_quantiry_history_in_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        int size = infos.size();
        theActorInTheSpotlight().attemptsTo(
                MoveMouse.to(VendorOrderDetailPage.HISTORY_ICON),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.HISTORY_QUANTITY(1))
        );
        for (int i = 0; i < size; i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorOrderDetailPage.HISTORY_QUANTITY(i + 1)).text().contains(infos.get(i).get("quantity")),
                    Ensure.that(VendorOrderDetailPage.HISTORY_REASON(i + 1)).text().contains(infos.get(i).get("reason")),
                    Ensure.that(VendorOrderDetailPage.HISTORY_EDIT_DATE(i + 1)).text().contains(CommonHandle.setDate2(infos.get(i).get("editDate"), "MM/dd/yy"))
            );
        }
    }

    @And("Vendor Check items in sub invoice {string} number {string} with status is {string}")
    public void check_item_sub_invoice_in_order_detail(String subInvoice, String number, String status, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        if (subInvoice.contains("create by api")) {
            subInvoice = Serenity.sessionVariableCalled("ID Invoice").toString();
        }
        if (subInvoice.contains("create by buyer")) {
            subInvoice = Serenity.sessionVariableCalled("ID Invoice").toString().split("#")[1].replaceAll("#", "");
        }
        for (int i = 0; i < list.size(); i++) {
//            HashMap<String, String> info = CommonTask.setValueRandom(list.get(i), "skuName", Serenity.sessionVariableCalled("itemCode" + list.get(i).get("skuName")));
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.STATUS(subInvoice + number, 1)), containsString(status)),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.BRAND_NAME(subInvoice + number, i + 1)), equalToIgnoringCase(list.get(i).get("brandName"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.PRODUCT_NAME(subInvoice + number, i + 1)), containsString(list.get(i).get("productName"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.SKU_NAME(subInvoice + number, i + 1)), containsString(list.get(i).get("skuName"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.CASE_PRICE(subInvoice + number, i + 1)), containsString(list.get(i).get("casePrice"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.QUANTITY(subInvoice + number, i + 1)), containsString(list.get(i).get("quantity"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.TOTAL_IN_DETAIL(subInvoice + number, i + 1)), equalToIgnoringCase(list.get(i).get("total"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.UNIT_UPC(subInvoice + number, i + 1)), equalToIgnoringCase(list.get(i).get("unitUPC")))
            );
            if (list.get(i).containsKey("podConsignment"))
                theActorInTheSpotlight().attemptsTo(
                        Check.whether(list.get(i).get("podConsignment").equals("Pod Consignment auto-confirmation"))
                                .andIfSo(
                                        Ensure.that(VendorOrderDetailPage.POD_CONSIGNMENT(subInvoice + number, i + 1)).text().contains(list.get(i).get("podConsignment"))
                                ),
                        Check.whether(list.get(i).get("podConsignment").equals("not set"))
                                .andIfSo(
                                        Ensure.that(VendorOrderDetailPage.POD_CONSIGNMENT_NOT_SET(subInvoice + number, i + 1)).isDisplayed()
                                )
                );
            if (list.get(i).containsKey("fee"))
                theActorInTheSpotlight().attemptsTo(
                        Check.whether(list.get(i).get("fee").isEmpty())
                                .otherwise(
                                        Ensure.that(VendorOrderDetailPage.FEE(subInvoice + number, i + 1)).text().contains(list.get(i).get("fee"))
                                )
                );
        }
    }

    @And("Vendor Check {string} items in Unconfirmed Pod Direct Items")
    public void check_item_pod_direct_in_order_detail(String numberUnConfirm, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(VendorOrderDetailPage.NUMBER_UNCONFIRM), containsString(numberUnConfirm))
        );
        for (int i = 0; i < list.size(); i++) {
//            HashMap<String, String> info = CommonTask.setValueRandom(list.get(i), "skuName", Serenity.sessionVariableCalled("itemCode" + list.get(i).get("skuName")));
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.BRAND_NAME("Unconfirmed item", i + 1)), equalToIgnoringCase(list.get(i).get("brandName"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.PRODUCT_NAME("Unconfirmed item", i + 1)), containsString(list.get(i).get("productName"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.SKU_NAME("Unconfirmed item", i + 1)), containsString(list.get(i).get("skuName"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.CASE_PRICE("Unconfirmed item", i + 1)), containsString(list.get(i).get("casePrice"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.QUANTITY("Unconfirmed item", i + 1)), containsString(list.get(i).get("quantity"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.TOTAL_IN_DETAIL("Unconfirmed item", i + 1)), equalToIgnoringCase(list.get(i).get("total"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.UNIT_UPC("Unconfirmed item", i + 1)), equalToIgnoringCase(list.get(i).get("unitUPC")))
            );
//            if (list.get(i).containsKey("podConsignment"))
//                theActorInTheSpotlight().attemptsTo(
//                        Check.whether(list.get(i).get("podConsignment").equals("Pod Consignment auto-confirmation"))
//                                .andIfSo(
//                                        Ensure.that(VendorOrderDetailPage.POD_CONSIGNMENT("Unconfirmed item", i + 1)).text().contains(list.get(i).get("podConsignment"))
//                                ),
//                        Check.whether(list.get(i).get("podConsignment").equals("not set"))
//                                .andIfSo(
//                                        Ensure.that(VendorOrderDetailPage.POD_CONSIGNMENT_NOT_SET("Unconfirmed item", i + 1)).isDisplayed()
//                                )
//                );
            if (list.get(i).containsKey("fee"))
                theActorInTheSpotlight().attemptsTo(
                        Check.whether(list.get(i).get("fee").isEmpty())
                                .otherwise(
                                        Ensure.that(VendorOrderDetailPage.FEE("Unconfirmed item", i + 1)).text().contains(list.get(i).get("fee"))
                                )
                );
        }
    }

    @And("Vendor check history of quantity items in Unconfirmed Pod Direct Items")
    public void checkHistoryChangeQuantity(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(list.get(0), "skuName", Serenity.sessionVariableCalled("itemCode" + list.get(0).get("skuName")));
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorOrderDetailPage.QUANTITY_ICON("Unconfirmed item", 1)),
                MoveMouse.to(VendorOrderDetailPage.QUANTITY_ICON("Unconfirmed item", 1))
        );
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorOrderDetailPage.HISTORY_QUANTITY(i + 1)).text().contains(list.get(i).get("quantity")),
                    Ensure.that(VendorOrderDetailPage.HISTORY_REASON(i + 1)).text().contains(list.get(i).get("reason")),
                    Ensure.that(VendorOrderDetailPage.HISTORY_EDIT_DATE(i + 1)).text().contains(CommonHandle.setDate2(list.get(i).get("editDate"), "MM/dd/yy"))
            );
        }
    }

    @And("Vendor check order detail info")
    public void check_order_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(VendorOrderDetailPage.REGION), equalToIgnoringCase(list.get(0).get("region"))),
                seeThat(CommonQuestions.targetText(VendorOrderDetailPage.ORDER_DATE), equalToIgnoringCase(CommonHandle.setDate(list.get(0).get("orderDate"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(VendorOrderDetailPage.FULFILLMENT_STATUS), equalToIgnoringCase(list.get(0).get("fulfillmentStatus")))
        );
        if (list.get(0).get("fulfillmentStatus").contains("Fulfilled")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.FULFILLMENT_DATE), containsString(CommonHandle.setDate(list.get(0).get("fulfillmentDate"), "MM/dd/yy")))
            );
        }
    }

    @And("Vendor check general info")
    public void check_general(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(VendorOrderDetailPage.SHOW_GENERAL_INFORMATION)).andIfSo(
                        Click.on(VendorOrderDetailPage.SHOW_GENERAL_INFORMATION),
                        CommonWaitUntil.isNotVisible(VendorOrderDetailPage.SHOW_GENERAL_INFORMATION)
                )
        );
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorOrderDetailPage.ORDER_BUYER_NAME).text().contains(list.get(0).get("buyer")),
                Ensure.that(VendorOrderDetailPage.ORDER_STORE_NAME).text().contains(list.get(0).get("store")),
                Ensure.that(VendorOrderDetailPage.ORDER_BUYER_EMAIL).text().contains(list.get(0).get("email")),
                Ensure.that(VendorOrderDetailPage.ORDER_BUYER_NAME).text().contains(list.get(0).get("buyer")),
                Ensure.that(VendorOrderDetailPage.ORDER_VALUE).text().contains(list.get(0).get("orderValue")),
                Ensure.that(VendorOrderDetailPage.ORDER_TOTAL).text().contains(list.get(0).get("orderTotal")),
                Ensure.that(VendorOrderDetailPage.ORDER_PAYMENT_STATUS).text().contains(list.get(0).get("payment"))
        );
        if (list.get(0).containsKey("weekday")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorOrderDetailPage.WEEKDAY).text().contains(list.get(0).get("weekday"))
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorOrderDetailPage.WEEKDAY).isNotDisplayed()
            );
        }
        if (list.get(0).containsKey("serviceFee")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorOrderDetailPage.SERVICE_FEE).text().contains(list.get(0).get("serviceFee"))
            );
        }
        if (list.get(0).containsKey("promotion")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorOrderDetailPage.PROMOTION).text().contains(list.get(0).get("promotion"))
            );
        }
    }

    @And("Vendor Check orders in dashboard order")
    public void check_order_in_dashboard_order(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String id = list.get(i).get("number").toString();
            if (list.get(i).get("number").isEmpty()) {
                id = Serenity.sessionVariableCalled("ID Invoice").toString().split("#")[1];
            } else if (list.get(i).get("number").contains("create by api")) {
                id = Serenity.sessionVariableCalled("ID Invoice").toString();
            }
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DETAIL_ORDER_RECORD2(id, "ordered")), equalToIgnoringCase(CommonHandle.setDate2(list.get(i).get("ordered"), "MM/dd/yy"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.NUMBER(id.replaceAll("#", ""))), containsString(id)),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DETAIL_ORDER_RECORD(id, "store")), containsString(list.get(i).get("store"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.PAYMENT(id, "payment")), equalToIgnoringCase(list.get(i).get("payment"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.FULFILLMENT(id)), equalToIgnoringCase(list.get(i).get("fullfillment"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DETAIL_ORDER_RECORD(id, "total")), equalToIgnoringCase(list.get(i).get("total")))
            );
            if (list.get(i).containsKey("fulfilled")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.FULFILLED(id, "fulfilled")), equalToIgnoringCase(CommonHandle.setDate(list.get(i).get("fulfilled"), "MM/dd/yy")))
                );
            }
            if (list.get(i).containsKey("orderType")) {
                if (list.get(i).get("orderType").equals("Direct")) {
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.attributeText(VendorOrderDetailPage.ORDER_TYPE(id), "src"), containsString("img/direct.svg"))
                    );
                }
                if (list.get(i).get("orderType").equals("Express")) {
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.attributeText(VendorOrderDetailPage.ORDER_TYPE(id), "src"), containsString("img/express.svg"))
                    );
                }
                if (list.get(i).get("orderType").equals("Direct/Express")) {
                    theActorInTheSpotlight().should(
                            seeThat(CommonQuestions.attributeText(VendorOrderDetailPage.ORDER_TYPE(id), "src"), containsString("img/both-direct-express.svg"))
                    );
                }
            }
            if (list.get(i).containsKey("deliveryDate")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DETAIL_ORDER_RECORD(id, "delivery-date")), containsString(CommonHandle.setDate2(list.get(i).get("deliveryDate"), "MM/dd/yy")))
                );
            }
        }
    }

    @And("Vendor Go to order detail with order number {string}")
    public void goToOrderNumber(String number) {
        String order = Serenity.hasASessionVariableCalled("ID Invoice") ? Serenity.sessionVariableCalled("ID Invoice").toString() : number;
        if (number.contains("create by api")) {
            number = Serenity.sessionVariableCalled("ID Invoice").toString();
            order = number;
        } else if (number.isEmpty()) {
            if (order.contains("Order")) {
                order = order.split("#")[1].replaceAll("#", "");
            }
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorOrderDetailPage.NUMBER(order)),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.BACK_TO_ORDER)
        );
    }

    @And("Vendor search order {string}")
    public void search_order(String type, DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        // Choose type orders
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.chooseTypeOrder(type)
        );
        for (Map<String, String> map : infos)
            theActorInTheSpotlight().attemptsTo(
                    HandleOrdersVendor.search(map)
            );
    }

    @And("Vendor search order with all filter {string}")
    public void search_order_all_filter(String type, DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorOrderListPage.TYPE_ORDER(type)),
                CommonWaitUntil.isNotVisible(VendorOrderListPage.LOADING_SPINNER),
                HandleOrdersVendor.searchAll()
        );
        for (Map<String, String> map : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrdersVendor.inputSearchAll(map)
            );
        }
    }

    @And("Vendor close search all filters")
    public void close_search_order_all_filter() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.closeSearchAll()
        );
    }

    @And("Vendor {string} search order")
    public void collapse_search_order(String collapse) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.collapse(collapse)
        );
    }

    @And("Vendor check counter order tab {string} is equal {string}")
    public void checkCounter(String tab, String count) {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(VendorOrderListPage.COUNTER(tab)), containsString(count))

        );
    }

    @And("Vendor clear search all filters")
    public void clear_search_order_all_filter() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.clearSearchAll()
        );
    }

    @And("Vendor check step confirm")
    public void check_step_confirm(DataTable table) {
        List<Map<String, String>> step = table.asMaps(String.class, String.class);
        if (!step.get(0).get("step1").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.STEP_INFO("Step 1")), equalToIgnoringCase(step.get(0).get("step1")))
            );
        }
        if (!step.get(0).get("step2").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.STEP_INFO("Step 2")), equalToIgnoringCase(step.get(0).get("step2")))
            );
        }
        if (!step.get(0).get("step3").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.STEP_INFO("Step 3")), equalToIgnoringCase(step.get(0).get("step3")))
            );
        }
        if (!step.get(0).get("step4").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.STEP_INFO("Step 4")), equalToIgnoringCase(step.get(0).get("step4")))
            );
        }
        if (!step.get(0).get("step5").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.STEP_INFO("Step 5")), equalToIgnoringCase(step.get(0).get("step5")))
            );
        }
    }

    @And("Vendor select items to confirm in order")
    public void selectItem(DataTable table) {
        List<Map<String, String>> item = table.asMaps(String.class, String.class);
        for (Map<String, String> map : item) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrdersVendor.selectConfirmItems(map)
            );
        }
    }

    @And("Vendor confirm with delivery method with info")
    public void confirmItem(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.confirmItems(infos.get(0))
        );
        //Check INSTRUCTIONS
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Store Name:  " + infos.get(0).get("store") + " % Pod Foods"),
                Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains(infos.get(0).get("address")),
                Check.whether(infos.get(0).get("delivery").equals("Self-deliver to Store"))
                        .andIfSo(
                                Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Deliver all items on this invoice directly to store within five (5) days of order date:"),
                                Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Step 5/5: Upload signed packing slip as proof of delivery. Orders without proof of delivery will not be paid.")
                        ).otherwise(
                                Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Ship this order directly to the store within five (5) days of order date."),
                                Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Step 4/5: Print and include Pod Foods Invoice + Packing Slip  in parcel."),
                                Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Step 5/5: Enter tracking information by clicking “View Delivery Details”"),
//                                Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("if you didn't add at the start. Orders without tracking information will not be paid.")
                                Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Questions?"),
                                Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Find complete fulfillment details on Pod Direct section of the"),
//                                Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Preparing Shipments"),
//                                Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Shipping - Pallets + Parcels"),
                                Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("orders@podfoods.co")
                        )
        );
    }

    @And("Vendor choose shipping method")
    public void chooseShipping(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.shippingInfo(info.get(0))
        );
    }

    @And("Vendor choose delivery method {string}")
    public void chooseDelivery(String delivery) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.chooseDeliveryMethod(delivery)
        );
    }

    @And("Vendor edit shipping method")
    public void vendor_edit_delivery_method(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.goToEditSubInvoice(),
                HandleOrdersVendor.shippingInfo(info.get(0))
        );
    }

    @And("Vendor Show more action of sub invoice {string} suffix {string} and then {string}")
    public void moreAction(String subInvoice, String suffix, String action) {
        if (subInvoice.contains("create by api"))
            subInvoice = Serenity.sessionVariableCalled("ID Invoice").toString();
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.moreAction(action, subInvoice + suffix)
        );
    }

    @And("Vendor delete shipping method")
    public void vendor_delete_delivery_method() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.deleteShipment()
        );
    }

    @And("Vendor select shippo and then confirm")
    public void selectShippo() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.selectRate()
        );
    }

    @And("Vendor check information after confirm")
    public void checkAfterConfirm(DataTable table) {
        List<Map<String, String>> item = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorOrderDetailPage.DYNAMIC_TEXT_DIV("provider")),
//                Ensure.that(VendorOrderDetailPage.SUB_INVOICE).isDisplayed(),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_TEXT_DIV("provider")).text().containsIgnoringCase(item.get(0).get("provider")),
                Check.whether(item.get(0).get("tracking").equals(""))
                        .otherwise(Ensure.that(VendorOrderDetailPage.DYNAMIC_TEXT_DIV("tracking-number")).text().contains(item.get(0).get("tracking"))),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_TEXT_DIV("shipment-eta")).text().containsIgnoringCase(item.get(0).get("eta")),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_TEXT_DIV("tracking-status")).text().containsIgnoringCase(item.get(0).get("status")),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_TEXT_DIV("size")).text().containsIgnoringCase(item.get(0).get("size")),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_TEXT_DIV("weight")).text().containsIgnoringCase(item.get(0).get("weight")),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_TEXT_DIV("line-per-case")).text().containsIgnoringCase(item.get(0).get("line")),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_TEXT_DIV("price")).text().containsIgnoringCase(item.get(0).get("price"))
        );
    }

    @And("Vendor check shipping label on delivery detail")
    public void checkShippingLabel(DataTable table) {
        List<Map<String, String>> item = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorOrderDetailPage.DYNAMIC_DIALOG_TEXT_DIV("provider")),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_DIALOG_TEXT_DIV("provider")).text().containsIgnoringCase(item.get(0).get("provider")),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_DIALOG_SPAN("Shipping Rate")).text().containsIgnoringCase(item.get(0).get("price")),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_DIALOG_SPAN("Tracking Number")).text().containsIgnoringCase(item.get(0).get("tracking")),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_DIALOG_SPAN("Delivery Date")).text().containsIgnoringCase(item.get(0).get("eta")),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_DIALOG_SPAN("Tracking Status")).text().containsIgnoringCase(item.get(0).get("status")),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_DIALOG_SPAN("Parcel Information")).text().containsIgnoringCase(item.get(0).get("size")),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_DIALOG_SPAN("Address From")).text().containsIgnoringCase(item.get(0).get("from")),
                Ensure.that(VendorOrderDetailPage.DYNAMIC_DIALOG_SPAN("Address To")).text().containsIgnoringCase(item.get(0).get("to"))
        );
    }

    @And("Vendor print Invoice & Packing Slip")
    public void printInvoicePackingSlip() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.print()
        );
    }

    @And("Vendor view delivery detail of sub invoice {string} suffix {string}")
    public void viewDeliveryDetail(String subinvoice, String suffix) {
        if (subinvoice.contains("create by api"))
            subinvoice = Serenity.sessionVariableCalled("ID Invoice").toString();
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.viewDeliveryDetail(subinvoice + suffix)
        );
    }

    @And("Vendor check items on Confirm Delivery method")
    public void checkItemDeliveryDetail(DataTable table) {
        List<Map<String, String>> item = table.asMaps(String.class, String.class);
        for (Map<String, String> map : item)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlDisplay(VendorOrderDetailPage.DELIVERY_ITEM_QUANTITY(map.get("item"), map.get("quantity"))))
            );
    }

    @And("Vendor check instructions of delivery method {string} on Confirm Delivery method")
    public void checkInstructions(String type, DataTable table) {
        List<Map<String, String>> item = table.asMaps(String.class, String.class);
        if (type.equals("Ship Direct to Store")) {
            //Check INSTRUCTIONS
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorOrderDetailPage.DELIVERY_METHOD).attribute("value").contains(item.get(0).get("deliveryMethod")),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains(item.get(0).get("store") + " % Pod Foods"),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains(item.get(0).get("address")),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Ship this order directly to the store within five (5) days of order date."),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Step 4/5: Print and include Pod Foods Invoice + Packing Slip"),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Step 5/5: Enter tracking information by clicking “View Delivery Details”"),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("if you didn't add at the start. Orders without tracking information will not be paid."),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Find complete fulfillment details on Pod Direct section of the")
            );
            if (item.get(0).containsKey("carrier")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.attributeText(VendorOrderDetailPage.DELIVERY_DATE, "value"), equalToIgnoringCase(CommonHandle.setDate2(item.get(0).get("deliveryDate"), "MM/dd/yy"))),
                        seeThat(CommonQuestions.attributeText(VendorOrderDetailPage.PARCEL_INFORMATION("Carrier"), "value"), equalToIgnoringCase(item.get(0).get("carrier"))),
                        seeThat(CommonQuestions.attributeText(VendorOrderDetailPage.PARCEL_INFORMATION("Tracking number"), "value"), equalToIgnoringCase(item.get(0).get("trackingNumber"))),
                        seeThat(CommonQuestions.attributeText(VendorOrderDetailPage.DELIVERY_COMMENTS, "value"), equalToIgnoringCase(item.get(0).get("comment")))
                );

            } else
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DYNAMIC_TEXT_DELIVERY("Delivery Date")), equalToIgnoringCase(item.get(0).get("deliveryDate"))),
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DYNAMIC_TEXT_DELIVERY("Tracking Status")), equalToIgnoringCase(item.get(0).get("trackingStatus"))),
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DYNAMIC_TEXT_DELIVERY("Address From")), containsString(item.get(0).get("from"))),
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DYNAMIC_TEXT_DELIVERY("Address To")), containsString(item.get(0).get("to"))),
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DYNAMIC_TEXT_DELIVERY("Tracking Number")), containsString(item.get(0).get("trackingNumber"))),
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DYNAMIC_TEXT_DELIVERY("Parcel Information")), containsString(item.get(0).get("parcelInfo")))
                );
        } else if (type.isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetValue(VendorOrderDetailPage.DELIVERY_METHOD), equalToIgnoringCase(""))
            );
        } else {
            //Check INSTRUCTIONS
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorOrderDetailPage.DELIVERY_METHOD).attribute("value").contains(item.get(0).get("deliveryMethod")),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Store Name:  " + item.get(0).get("store") + " % Pod Foods"),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains(item.get(0).get("address")),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Deliver all items on this invoice directly to store within five (5) days of order date:"),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Step 4/5: Print and include Pod Foods Invoice + Packing Slip"),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Step 5/5: Upload signed packing slip as proof of delivery. Orders without proof of delivery will not be paid."),
                    Ensure.that(VendorOrderDetailPage.DELIVERY_DATE).attribute("value").contains(CommonHandle.setDate2(item.get(0).get("deliveryDate"), "MM/dd/yy")),
                    Ensure.that(VendorOrderDetailPage.FROM_TEXTBOX).attribute("value").contains(item.get(0).get("from")),
                    Ensure.that(VendorOrderDetailPage.TO_TEXTBOX).attribute("value").contains(item.get(0).get("to")),
                    Ensure.that(VendorOrderDetailPage.COMMENT_TEXTAREA).attribute("value").contains(item.get(0).get("comment"))
            );
        }
    }

    @And("Vendor check instructions with contents")
    public void checkInstructionsContent(DataTable table) {
        List<Map<String, String>> item = table.asMaps(String.class, String.class);
        if (item.get(0).get("type").equals("Ship Direct to Store")) {
            //Check INSTRUCTIONS
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.textContains(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM, "Store Name:  " + item.get(0).get("store") + " % Pod Foods")),
                    seeThat(CommonQuestions.textContains(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM, item.get(0).get("address"))),
                    seeThat(CommonQuestions.textContains(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM, "Ship this order directly to the store within five (5) days of order date.")),
                    seeThat(CommonQuestions.textContains(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM, "Step 4/5: Print and include Pod Foods Invoice + Packing Slip")),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM), containsString("Step 5/5: Enter tracking information by clicking “View Delivery Details”")),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM), containsString("if you didn't add at the start. Orders without tracking information will not be paid.")),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM), containsString("Find complete fulfillment details on Pod Direct section of the"))
            );
        } else if (item.get(0).get("type").isEmpty()) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM), equalToIgnoringCase(""))
            );
        } else {
            //Check INSTRUCTIONS
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Store Name:  " + item.get(0).get("store") + " % Pod Foods"),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains(item.get(0).get("address")),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Deliver all items on this invoice directly to store within five (5) days of order date:"),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Step 4/5: Print and include Pod Foods Invoice + Packing Slip"),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Step 5/5: Upload signed packing slip as proof of delivery. Orders without proof of delivery will not be paid.")
            );
        }
    }

    @And("Vendor view delivery detail of {string}")
    public void viewDeliveryDetail(String type, DataTable table) {
        List<Map<String, String>> item = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorOrderDetailPage.SUB_INVOICE)
        );
        Serenity.setSessionVariable("ID Sub invoice").to(VendorOrderDetailPage.SUB_INVOICE.resolveFor(theActorInTheSpotlight()).getText().substring(12));
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.viewDelivery(type)
        );
        if (type.equals("Ship Direct to Store")) {
            //Check INSTRUCTIONS
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorOrderDetailPage.DELIVERY_ITEM_IMAGE).isDisplayed(),
                    Ensure.that(VendorOrderDetailPage.DELIVERY_ITEM_NAME).text().contains(item.get(0).get("item")),
                    Ensure.that(VendorOrderDetailPage.DELIVERY_ITEM_NAME).text().contains(" × " + item.get(0).get("quantity")),
                    Ensure.that(VendorOrderDetailPage.DELIVERY_METHOD).attribute("value").contains(item.get(0).get("deliveryMethod")),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Store Name:  " + item.get(0).get("store") + " % Pod Foods"),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains(item.get(0).get("address")),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Ship this order directly to the store within five (5) days of order date."),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Step 4/5: Print and include Pod Foods Invoice + Packing Slip  in parcel."),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Step 5/5: Enter tracking information by clicking “View Delivery Details”"),
//                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("if you didn’t add at the start. Orders without tracking information will not be paid.")),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Find complete fulfillment details on Pod Direct section of the")
            );
            if (item.get(0).containsKey("carrier")) {
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.attributeText(VendorOrderDetailPage.DELIVERY_DATE, "value"), equalToIgnoringCase(CommonHandle.setDate2(item.get(0).get("deliveryDate"), "MM/dd/yy"))),
                        seeThat(CommonQuestions.attributeText(VendorOrderDetailPage.PARCEL_INFORMATION("Carrier"), "value"), equalToIgnoringCase(item.get(0).get("carrier"))),
                        seeThat(CommonQuestions.attributeText(VendorOrderDetailPage.PARCEL_INFORMATION("Tracking number"), "value"), equalToIgnoringCase(item.get(0).get("trackingNumber"))),
                        seeThat(CommonQuestions.attributeText(VendorOrderDetailPage.DELIVERY_COMMENTS, "value"), equalToIgnoringCase(item.get(0).get("comment")))
                );

            } else
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DYNAMIC_TEXT_DELIVERY("Delivery Date")), Matchers.containsString(item.get(0).get("deliveryDate"))),
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DYNAMIC_TEXT_DELIVERY("Tracking Status")), Matchers.containsString(item.get(0).get("trackingStatus"))),
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DYNAMIC_TEXT_DELIVERY("Address From")), Matchers.containsString(item.get(0).get("from"))),
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DYNAMIC_TEXT_DELIVERY("Address To")), Matchers.containsString(item.get(0).get("to"))),
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DYNAMIC_TEXT_DELIVERY("Tracking Number")), Matchers.containsString(item.get(0).get("trackingNumber"))),
                        seeThat(CommonQuestions.targetText(VendorOrderDetailPage.DYNAMIC_TEXT_DELIVERY("Parcel Information")), Matchers.containsString(item.get(0).get("parcelInfo")))
                );
        } else {
            //Check INSTRUCTIONS
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorOrderDetailPage.DELIVERY_ITEM_IMAGE).isDisplayed(),
                    Ensure.that(VendorOrderDetailPage.DELIVERY_ITEM_NAME).text().contains(item.get(0).get("item")),
                    Ensure.that(VendorOrderDetailPage.DELIVERY_ITEM_NAME).text().contains(" × " + item.get(0).get("quantity")),
                    Ensure.that(VendorOrderDetailPage.DELIVERY_METHOD).attribute("value").contains(item.get(0).get("deliveryMethod")),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Store Name:  " + item.get(0).get("store") + " % Pod Foods"),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains(item.get(0).get("address")),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Deliver all items on this invoice directly to store within five (5) days of order date:"),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Step 4/5: Print and include Pod Foods Invoice + Packing Slip  in parcel."),
                    Ensure.that(VendorOrderDetailPage.INSTRUCTIONS_CONFIRM).text().contains("Step 5/5: Upload signed packing slip as proof of delivery. Orders without proof of delivery will not be paid."),
                    Ensure.that(VendorOrderDetailPage.DELIVERY_DATE).attribute("value").contains(CommonHandle.setDate2(item.get(0).get("deliveryDate"), "MM/dd/yy")),
                    Ensure.that(VendorOrderDetailPage.FROM_TEXTBOX).attribute("value").contains(item.get(0).get("from")),
                    Ensure.that(VendorOrderDetailPage.TO_TEXTBOX).attribute("value").contains(item.get(0).get("to")),
                    Ensure.that(VendorOrderDetailPage.COMMENT_TEXTAREA).attribute("value").contains(item.get(0).get("comment"))
            );
        }
    }

    @And("Vendor check no order found")
    public void check_no_order() {
        String num = (Serenity.sessionVariableCalled("ID Invoice").toString().substring(7));
        List<WebElementFacade> page = VendorOrderListPage.NUMBER_PAGE.resolveAllFor(theActorInTheSpotlight());
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(VendorOrderListPage.NO_ORDER_FOUND)).andIfSo(
                        Ensure.that(CommonQuestions.isControlDisplay(VendorOrderListPage.NO_ORDER_FOUND)).isTrue()
                ).otherwise(
                        Ensure.that(CommonQuestions.isControlUnDisplay(VendorOrderDetailPage.NUMBER(num))).isTrue()
                )
        );
        if (page.size() > 1) {
            for (int i = 0; i < page.size(); i++) {
                HandleOrdersVendor.switchPages(page.get(i));
                if (CommonQuestions.isControlDisplay(VendorOrderDetailPage.NUMBER(num)).answeredBy(theActorInTheSpotlight())) {
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(CommonQuestions.isControlUnDisplay(VendorOrderDetailPage.NUMBER(num))).isTrue()
                    );
                    break;
                }
            }
        }
    }

    @And("Vendor check order number {string} is {string}")
    public void check_no_order(String number, String show) {
        String num = number;
        if (show.equals("not show")) {
            if (number.contains("api")) {
                num = Serenity.sessionVariableCalled("Number Order API").toString();
            }
            if (number.isEmpty()) {
                num = (Serenity.sessionVariableCalled("ID Invoice").toString().substring(7));
            }
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(CommonQuestions.isControlDisplay(VendorOrderListPage.NO_ORDER_FOUND)).andIfSo(
                            Ensure.that(CommonQuestions.isControlDisplay(VendorOrderListPage.NO_ORDER_FOUND)).isTrue()
                    ).otherwise(
                            Ensure.that(CommonQuestions.isControlUnDisplay(VendorOrderDetailPage.NUMBER(num))).isTrue()
                    )
            );
        }
        List<WebElementFacade> page = VendorOrderListPage.NUMBER_PAGE.resolveAllFor(theActorInTheSpotlight());
        if (page.size() > 1) {
            for (int i = 0; i < page.size(); i++) {
                HandleOrdersVendor.switchPages(page.get(i));
                if (CommonQuestions.isControlDisplay(VendorOrderDetailPage.NUMBER(num)).answeredBy(theActorInTheSpotlight())) {
                    theActorInTheSpotlight().attemptsTo(
                            Ensure.that(CommonQuestions.isControlUnDisplay(VendorOrderDetailPage.NUMBER(num))).isTrue()
                    );
                    break;
                }
            }
        }
    }

    @And("Vendor fill info to self-deliver to Store")
    public void fill_info_to_self_deliver_to_store(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.fillInfoSelfDelivery(info.get(0))
        );
    }

    @And("Vendor check estimated arrival time to is {word} from {string}")
    public void estimated_arrival_time(String status, String from, DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTask.chooseItemInDropdownWithValueInput(VendorOrderDetailPage.FROM_TEXTBOX, from, VendorOrderDetailPage.DYNAMIC_ITEM_DROPDOWN(from)),
                Click.on(VendorOrderDetailPage.TO_TEXTBOX));
        for (Map<String, String> map : info) {
            if (status.equalsIgnoreCase("disable"))
                theActorInTheSpotlight().attemptsTo(
                        Scroll.to(VendorOrderDetailPage.DYNAMIC_ITEM_DROPDOWN(map.get("to"))),
                        Ensure.that(VendorOrderDetailPage.DYNAMIC_ITEM_DROPDOWN(map.get("to"))).attribute("class").containsIgnoringCase("disabled")
                );
            else
                theActorInTheSpotlight().attemptsTo(
                        Scroll.to(VendorOrderDetailPage.DYNAMIC_ITEM_DROPDOWN(map.get("to"))),
                        Ensure.that(VendorOrderDetailPage.DYNAMIC_ITEM_DROPDOWN(map.get("to"))).attribute("class").doesNotContain("disabled")
                );
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonVendorPage.DYNAMIC_ANY_TEXT("Estimated arrival time"))
        );
    }

    @And("Vendor edit info to self-deliver to Store")
    public void edit_info_to_self_deliver_to_store(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.goToEditSubInvoice(),
                HandleOrdersVendor.fillInfoSelfDelivery(info.get(0))
        );
    }

    @And("Vendor print order")
    public void vendor_print_order() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorOrderDetailPage.PRINT_BTN),
                CommonWaitUntil.isPresent(VendorOrderDetailPage.UPLOAD_BUTTON)
        );
    }

    @And("Vendor upload proof of delivery with file {string}")
    public void vendor_upload_proof_of_delivery(String file) {
        theActorInTheSpotlight().attemptsTo(
                CommonFile.upload1(file, VendorOrderDetailPage.UPLOAD_BUTTON)
//                WindowTask.threadSleep(300)
//                CommonWaitUntil.isVisible(VendorOrderDetailPage.UPLOAD_PROOF(file))
        );
    }

    @And("Vendor Show more action of sub invoice {string} suffix {string} and upload proof of delivery with file {string}")
    public void vendor_upload_proof_of_delivery2(String subInvoice, String suffix, String file) {
        if (subInvoice.contains("create by api"))
            subInvoice = Serenity.sessionVariableCalled("ID Invoice").toString();
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorOrderDetailPage.SHOW_MORE_ACTION(subInvoice + suffix)),
                Click.on(VendorOrderDetailPage.SHOW_MORE_ACTION(subInvoice + suffix)),
                CommonWaitUntil.isVisible(VendorOrderDetailPage.D_MENU_SHOW_MORE("Upload Proof of Delivery")),
                CommonFile.upload1(file, VendorOrderDetailPage.UPLOAD_PROOF)
        );
    }

    @And("Vendor check proof of delivery")
    public void vendor_check_proof_of_delivery(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        for (Map<String, String> map : info)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorOrderDetailPage.UPLOAD_PROOF(map.get("proof_of_delivery")))
            );
    }

    @And("Vendor delete proof of delivery file {string}")
    public void vendor_delete_proof_of_delivery(String file) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorOrderDetailPage.DELETE_PROOF(file)),
                Click.on(VendorOrderDetailPage.DELETE_PROOF(file))
        );
    }

    @And("Vendor print invoice packing slip {string}")
    public void vendor_print_invoice_packing_slip(String number) {
        String idOrder = Serenity.sessionVariableCalled("ID Invoice");
        if (number.contains("create by api")) {
            idOrder = Serenity.sessionVariableCalled("ID Invoice").toString();
        } else
            idOrder = idOrder.length() >= 9 ? idOrder.substring(idOrder.lastIndexOf("#") + 1).trim() : idOrder;
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.goToPrintInvoicePackingSlip(idOrder)
        );
    }

    @And("Vendor verify info in Invoice")
    public void vendor_verify_info_in_invoice(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        String invoiceNumber = expected.get(0).get("invoiceNumber");
        if (expected.get(0).get("invoiceNumber").contains("create by vendor")) {
            invoiceNumber = Serenity.sessionVariableCalled("Sub-invoice ID after confirm by vendor").toString();
        }
        if (expected.get(0).get("invoiceNumber").contains("create by admin")) {
            invoiceNumber = Serenity.sessionVariableCalled("Sub-invoice ID create by admin").toString();
        }
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorOrderDetailPage.D_INFO_SUB_INVOICE("Order Date")).text().contains(CommonHandle.setDate2(expected.get(0).get("orderDate"), "MM/dd/yy")),
                Ensure.that(VendorOrderDetailPage.D_INFO_SUB_INVOICE("Invoice Number")).text().contains(invoiceNumber),
//                Ensure.that(VendorOrderDetailPage.D_INFO_SUB_INVOICE("Invoice Number")).text().contains(Serenity.sessionVariableCalled("Sub-invoice ID create by admin").toString()),
                Check.whether(expected.get(0).get("customerPO").isEmpty())
                        .otherwise(Ensure.that(VendorOrderDetailPage.D_INFO_SUB_INVOICE("Customer PO")).text().contains(expected.get(0).get("customerPO"))),
                Check.whether(expected.get(0).get("deliveryDate").isEmpty())
                        .otherwise(Ensure.that(VendorOrderDetailPage.D_INFO_SUB_INVOICE("Delivery Date")).text().contains(expected.get(0).get("deliveryDate"))),
                Check.whether(expected.get(0).get("department").isEmpty())
                        .otherwise(Ensure.that(VendorOrderDetailPage.D_INFO_SUB_INVOICE("Department")).text().contains(expected.get(0).get("department"))),
                Check.whether(expected.get(0).get("deliverTo").isEmpty())
                        .otherwise(Ensure.that(VendorOrderDetailPage.D_INFO_SUB_INVOICE("Deliver to")).text().contains(expected.get(0).get("deliverTo"))),
                Check.whether(expected.get(0).get("paymentMethod").isEmpty())
                        .otherwise(Ensure.that(VendorOrderDetailPage.D_INFO_SUB_INVOICE("Payment Method")).text().contains(expected.get(0).get("paymentMethod")))
        );
    }

    @And("Vendor verify items info in Invoice")
    public void vendor_verify_items_info_in_invoice(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.STORAGE_ITEM_SUB_INVOICE(expected.get(i).get("storage"))), equalToIgnoringCase(expected.get(i).get("storage"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_SUB_INVOICE("tr upc-ean", i + 1)), equalToIgnoringCase(expected.get(i).get("unitUPC"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_SUB_INVOICE("tc pack", i + 1)), equalToIgnoringCase(expected.get(i).get("pack"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_SUB_INVOICE("tr size", i + 1)), equalToIgnoringCase(expected.get(i).get("unitSize"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_SUB_INVOICE("tc desc", i + 1)), containsString(expected.get(i).get("description"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_SUB_INVOICE("tc temp", i + 1)), equalToIgnoringCase(expected.get(i).get("temp"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_SUB_INVOICE("tc qty", i + 1)), equalToIgnoringCase(expected.get(i).get("caseQty"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_SUB_INVOICE("tr price", i + 1)), equalToIgnoringCase(expected.get(i).get("casePrice"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_SUB_INVOICE("tr discount", i + 1)), equalToIgnoringCase(expected.get(i).get("discount"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_SUB_INVOICE("tr tax", i + 1)), equalToIgnoringCase(expected.get(i).get("bottleDeposit"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_SUB_INVOICE("tr total", i + 1)), equalToIgnoringCase(expected.get(i).get("total")))
            );
        }
    }

    @And("Vendor verify summary items info in Invoice")
    public void vendor_verify_summary_items_info_in_invoice(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(VendorOrderDetailPage.TOTAL_SUMMARY_ITEM_SUB_INVOICE("tc qty")), equalToIgnoringCase(expected.get(0).get("totalQuantity"))),
                seeThat(CommonQuestions.targetText(VendorOrderDetailPage.TOTAL_SUMMARY_ITEM_SUB_INVOICE("tr discount")), equalToIgnoringCase(expected.get(0).get("discount"))),
                seeThat(CommonQuestions.targetText(VendorOrderDetailPage.TOTAL_SUMMARY_ITEM_SUB_INVOICE("tr tax")), equalToIgnoringCase(expected.get(0).get("tax"))),
                seeThat(CommonQuestions.targetText(VendorOrderDetailPage.TOTAL_SUMMARY_ITEM_SUB_INVOICE("tr total")), equalToIgnoringCase(expected.get(0).get("totalPrice"))),
                seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_SUB_INVOICE2("Subtotal")), equalToIgnoringCase(expected.get(0).get("subTotal"))),
                seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_SUB_INVOICE2("Bottle Deposit")), equalToIgnoringCase(expected.get(0).get("bottleDeposit"))),
                seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_SUB_INVOICE2("Promotional Discount")), equalToIgnoringCase(expected.get(0).get("promotionDiscount"))),
                seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_SUB_INVOICE2("Invoice Total")), equalToIgnoringCase(expected.get(0).get("invoiceTotal")))
        );
    }

    @And("Vendor verify packing slip")
    public void vendor_verify_packing_slip(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : expected) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorOrderDetailPage.D_INFO_PACKING_SLIP(item.get("index"), "Store")).text().contains(item.get("store")),
                    Ensure.that(VendorOrderDetailPage.D_INFO_PACKING_SLIP(item.get("index"), "Buyer")).text().contains(item.get("buyer")),
                    Ensure.that(VendorOrderDetailPage.D_INFO_PACKING_SLIP(item.get("index"), "Order Date")).text().contains(CommonHandle.setDate2(item.get("orderDate"), "MM/dd/yy")),
                    Check.whether(expected.get(0).get("customerPO").equals(""))
                            .otherwise(Ensure.that(VendorOrderDetailPage.D_INFO_PACKING_SLIP(item.get("index"), "Store PO no.")).text().contains(item.get("customerPO")))
            );
        }
    }

    @And("Vendor verify items on packing slip")
    public void vendor_verify_items_packing_slip(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("brand", 1, i + 1)), containsString(expected.get(i).get("brand"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("product", 1, i + 1)), containsString(expected.get(i).get("product"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("variant", 1, i + 1)), containsString(expected.get(i).get("variant"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("upc-ean", 1, i + 1)), containsString(expected.get(i).get("unitUPC"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("case-upc-ean", 1, i + 1)), containsString(expected.get(i).get("caseUPC"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("case-unit", 1, i + 1)), equalToIgnoringCase(expected.get(i).get("caseUnit"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("temperature", 1, i + 1)), equalToIgnoringCase(expected.get(i).get("temperature"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("storage", 1, i + 1)), equalToIgnoringCase(expected.get(i).get("storage"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("quantity tr", 1, i + 1)), equalToIgnoringCase(expected.get(i).get("quantity"))),
//                    Packing slip 2
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("brand", 2, i + 1)), containsString(expected.get(i).get("brand"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("product", 2, i + 1)), containsString(expected.get(i).get("product"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("variant", 2, i + 1)), containsString(expected.get(i).get("variant"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("upc-ean", 2, i + 1)), containsString(expected.get(i).get("unitUPC"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("case-upc-ean", 2, i + 1)), containsString(expected.get(i).get("caseUPC"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("case-unit", 2, i + 1)), equalToIgnoringCase(expected.get(i).get("caseUnit"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("temperature", 2, i + 1)), equalToIgnoringCase(expected.get(i).get("temperature"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("storage", 2, i + 1)), equalToIgnoringCase(expected.get(i).get("storage"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.D_INFO_ITEM_PACKING_SLIP("quantity tr", 2, i + 1)), equalToIgnoringCase(expected.get(i).get("quantity")))
            );
        }
    }

    @And("Vendor verify sub-invoice created after confirm")
    public void vendor_verify_sub_invoice_created_after_confirm(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorOrderDetailPage.SUB_INVOICE(expected.get(0).get("sku"), expected.get(0).get("index"))).text().endsWith(expected.get(0).get("index"))
        );
    }

    @And("Vendor get ID sub invoice")
    public void vendor_get_id_sub_invoice(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            String subInvoice = Text.of(VendorOrderDetailPage.SUB_INVOICE(list.get(0).get("sku"), list.get(0).get("index"))).answeredBy(theActorInTheSpotlight());
            subInvoice = subInvoice.split("#")[1];
            System.out.println("Sub invoice ID = " + subInvoice);
            Serenity.setSessionVariable("Sub-invoice ID create by admin" + item.get("sku")).to(subInvoice);
            Serenity.setSessionVariable("Sub-invoice ID create by admin" + item.get("sku") + item.get("index")).to(subInvoice);
            Serenity.setSessionVariable("Sub-invoice ID after confirm by vendor").to(subInvoice);
//            Serenity.recordReportData().withTitle("Sub-invoice ID " + item.get("sku")).andContents(subInvoice);
        }
    }

    @And("Vendor remove sub invoice {string}")
    public void vendor_remove_sub_invoice(String allDelete, DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        String subInvoice = Serenity.sessionVariableCalled("Sub-invoice ID create by admin" + list.get(0).get("sku") + list.get(0).get("index"));
        System.out.println("Sub invoice = " + subInvoice);
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.removeSubInvoice(subInvoice, list.get(0).get("itemRemove"), list.get(0).get("index"), allDelete)
        );
    }

    @And("Vendor verify unconfirmed item")
    public void vendor_verify_unconfirmed_item() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorOrderDetailPage.UNCONFIRMED_ITEM).isDisplayed()
        );
    }

    @And("Vendor Check items in order detail by subInvoice")
    public void check_item_in_order_detail1(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String subInvoice = Serenity.sessionVariableCalled("Sub-invoice ID create by admin" + list.get(i).get("skuName") + list.get(i).get("index"));
            System.out.println("Sub invoice = " + subInvoice);
            HashMap<String, String> info = CommonTask.setValueRandom(list.get(i), "skuName", Serenity.sessionVariableCalled("SKU inventory"));
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.BRAND_NAME(subInvoice, i + 1)), equalToIgnoringCase(list.get(i).get("brandName"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.PRODUCT_NAME(subInvoice, i + 1)), equalToIgnoringCase(list.get(i).get("productName"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.SKU_NAME(subInvoice, i + 1)), equalToIgnoringCase(info.get("skuName"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.CASE_PRICE(subInvoice, i + 1)), containsString(list.get(i).get("casePrice"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.QUANTITY(subInvoice, i + 1)), containsString(list.get(i).get("quantity"))),
                    seeThat(CommonQuestions.targetText(VendorOrderDetailPage.TOTAL_IN_DETAIL(subInvoice, i + 1)), equalToIgnoringCase(list.get(i).get("total")))
            );
//            if (list.get(i).containsKey("podConsignment"))
//                theActorInTheSpotlight().attemptsTo(
//                        Check.whether(list.get(i).get("podConsignment").equals("Pod Consignment auto-confirmation"))
//                                .andIfSo(
//                                        Ensure.that(VendorOrderDetailPage.POD_CONSIGNMENT(subInvoice, i + 1)).text().contains(list.get(i).get("podConsignment"))
//                                ),
//                        Check.whether(list.get(i).get("podConsignment").equals("not set"))
//                                .andIfSo(
//                                        Ensure.that(VendorOrderDetailPage.POD_CONSIGNMENT_NOT_SET(subInvoice, i + 1)).isDisplayed()
//                                )
//                );
        }
    }

    @And("Vendor verify shippo is not display")
    public void vendor_verify_shippo_is_not_display() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorOrderDetailPage.CONFIRM_BTN).isNotDisplayed()
        );
    }

    @And("Vendor remove item and verify message error")
    public void vendor_remove_item_and_verify_message_error(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        String subInvoice = Serenity.sessionVariableCalled("Sub-invoice ID create by admin");
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorOrderDetailPage.DELETE_SUB_INVOICE(subInvoice, list.get(0).get("sku"), list.get(0).get("index"))),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_P_ALERT(list.get(0).get("message")))
        );
    }

    @And("Vendor export order {string}")
    public void exportSummary(String type) {
        String file;
        if (type.contains("detail")) {
            file = "Pod_Foods_order-details_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".xlsx";
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Export")),
                    Click.on(CommonVendorPage.DYNAMIC_BUTTON("Export")),
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ITEM_DROPDOWN2("Order details")),
                    JavaScriptClick.on(CommonVendorPage.DYNAMIC_ITEM_DROPDOWN2("Order details")),
                    WindowTask.threadSleep(1000)
            );
        } else {
            file = "Pod_Foods_orders_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".csv";
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Export")),
                    Click.on(CommonVendorPage.DYNAMIC_BUTTON("Export")),
                    CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ITEM_DROPDOWN2("Order summary")),
                    JavaScriptClick.on(CommonVendorPage.DYNAMIC_ITEM_DROPDOWN2("Order summary")),
                    WindowTask.threadSleep(1000)
            );
        }
//        theActorInTheSpotlight().attemptsTo(
//                Ensure.that(CommonVendorPage.DYNAMIC_DIALOG_TEXT("It will take a few minutes to process your request. An email will be sent to the address on your profile when the CSV is ready to download. Continue?")).isDisplayed()
////                CommonWaitUntil.waitToDownloadSuccessfully(file)
//        );
    }

    @And("Vendor check file {string} exits on {string}")
    public void checkFile(String file, String path) {
        path = System.getProperty("user.dir");
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.checkFileExist(file, path))
        );
    }

    @And("{word} check export order {string} success")
    public void checkExportFile(String actor, String type) {
        String file;
        if (type.contains("detail")) {
            file = "Pod_Foods_order-details_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".xlsx";
        } else file = "Pod_Foods_orders_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".csv";
        String path = System.getProperty("user.dir") + "/target/";
//        theActorInTheSpotlight().should(
//                seeThat(CommonQuestions.checkFileExist(file, path))
//        );
    }

    @And("Vendor delete file export order {string}")
    public void deleteExportSummary(String type) {
        String file;
        if (type.equals("details")) file = "Pod_Foods_order-details_" + Utility.getTimeNow("MMddyyyy") + ".xlsx";
        else file = "Pod_Foods_orders_" + Utility.getTimeNow("MMddyyyy") + ".xlsx";
        theActorInTheSpotlight().attemptsTo(
                CommonFile.deleteFileToDownload(file)
        );
    }

    @And("Vendor check content file export order {string}")
    public void checkExportSummary(String type, DataTable table) {
        List<List<String>> list = table.asLists(String.class);
        List<String[]> list2 = new ArrayList<>();
        for (List<String> e : list) {
            String[] targetArray = e.toArray(new String[0]);
            list2.add(targetArray);
        }
        String path = System.getProperty("user.dir");
        List<String[]> file = new ArrayList<>();
        if (type.contains("summary")) {
            path = path + "/target/Pod_Foods_orders_" + Utility.getTimeNow("MMddyyyy") + ".csv";
            file = CommonFile.readDataLineByLine(path);
        } else {
            path = path + "/target/Pod_Foods_order-details_" + Utility.getTimeNow("MMddyyyy") + ".xlsx";
            file = CommonFile.readDataExcelLineByLine(path);
        }
        for (int i = 0; i < list2.size(); i++) {
            for (int j = 0; j < list2.get(i).length; j++) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(CommonQuestions.AskForContainValue(file.get(i)[j], list2.get(i)[j])).isTrue()
                );
            }
//            theActorInTheSpotlight().attemptsTo(
//                    Ensure.that(Arrays.equals(file.get(i), list2.get(i))).isTrue()
//            );
        }
    }

    @And("Vendor Check items not display in order detail")
    public void vendor_check_item_not_display_in_order_detail() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(VendorOrderDetailPage.SKU_NAME(2))
        );
    }
}

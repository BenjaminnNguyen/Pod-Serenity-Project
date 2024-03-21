package steps.lp;

import cucumber.user_interface.beta.Vendor.sampleRequest.VendorSampleRequestPage;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.*;
import cucumber.tasks.lp.HandleOrdersLP;
import cucumber.tasks.vendor.orders.HandleOrdersVendor;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.orders.VendorOrderDetailPage;
import cucumber.user_interface.lp.CommonLPPage;
import cucumber.user_interface.lp.LPOrdersDetailPage;
import cucumber.user_interface.lp.OrdersLPPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.eo.Se;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.hamcrest.Matchers;
import org.openqa.selenium.Keys;

import java.util.*;

import static cucumber.singleton.GVs.URL_LP;
import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.Matchers.equalToIgnoringCase;
import static org.hamcrest.Matchers.equalToIgnoringWhiteSpace;

public class OrdersLPStepDefinitions {
    CommonVerify commonVerify = new CommonVerify();

    @And("{word} filter order by info")
    public void filter_order_by_info(String actor, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : infos) {
            HashMap<String, String> info = new HashMap<>(map);
            if (info.get("order").contains("create by buyer"))
                info = CommonTask.setValue(info, "order", info.get("order"), Serenity.sessionVariableCalled("ID Invoice").toString().substring(7), "create by buyer");
            if (info.get("order").contains("create by admin"))
                info = CommonTask.setValue(info, "order", info.get("order"), Serenity.sessionVariableCalled("ID Invoice").toString().split("#")[1], "create by admin");
            if (info.get("order").contains("create by api"))
                info = CommonTask.setValue(info, "order", info.get("order"), Serenity.sessionVariableCalled("Number Order API").toString(), "create by api");
            if (info.get("order").contains("admin create drop"))
                info = CommonTask.setValue(info, "order", info.get("order"), Serenity.sessionVariableCalled("Drop Number" + map.get("store")), "admin create drop");
            if (info.get("po").equals("create by api"))
                info = CommonTask.setValue(info, "po", info.get("po"), Serenity.sessionVariableCalled("Number Purchase Order API").toString(), "create by api");
            if (info.get("po").contains("with suffix"))
                info = CommonTask.setValue2(info, "po", info.get("po"), Serenity.sessionVariableCalled("Number Order API").toString() + info.get("po").split("suffix")[1], "with suffix");
            if (info.containsKey("index"))
                info = CommonTask.setValue(info, "order", info.get("order"), Serenity.sessionVariableCalled("Number Order API" + info.get("index")).toString(), "index");

            theActorCalled(actor).attemptsTo(
                    HandleOrdersLP.filter(info)
            );
        }
    }

    @And("{word} filter order just created")
    public void filter_order_just_created(String actor) {
        theActorCalled(actor).attemptsTo(
                HandleOrdersLP.filterOrderJustCreated()
        );
    }

    @And("LP search order with all filter")
    public void search_order_all_filter(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersLP.searchAll()
        );
        for (Map<String, String> map : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleOrdersLP.inputSearchAll(map)
            );
        }
    }

    @And("Lp {string} search order")
    public void collapse_search_order(String collapse) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersLP.collapse(collapse)
        );
    }

    @And("LP clear filter {string}")
    public void clear_field(String field) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorSampleRequestPage.SEARCH(field)),
                MoveMouse.to(VendorSampleRequestPage.SEARCH(field)),
                CommonWaitUntil.isVisible(VendorSampleRequestPage.CLEAR_ICON),
                Click.on(VendorSampleRequestPage.CLEAR_ICON),
                WindowTask.threadSleep(1000)
        );
    }


    @And("LP clear search all filters")
    public void clear_search_order_all_filter() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersVendor.clearSearchAll()
        );
    }

    @And("LP close search all filters")
    public void close_search_order_all_filter() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersLP.closeSearchAll()
        );
    }

    @And("Check order record on order page")
    public void check_po_all_page(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String number = list.get(i).get("number");
            if (number.isEmpty()) {
                number = Serenity.sessionVariableCalled("Id Sub-invoice LP").toString();
            }
            if (number.contains("create by api")) {
                number = Serenity.sessionVariableCalled("Number Purchase Order API").toString();
            }
            if (number.contains("admin create drop")) {
                number = Serenity.sessionVariableCalled("Drop Number" + list.get(i).get("store")).toString();
            }
            if (list.get(i).containsKey("suffix")) {
                number = Serenity.sessionVariableCalled("Number Order API").toString() + list.get(i).get("suffix");
            }
            theActorInTheSpotlight().attemptsTo(
                    WindowTask.threadSleep(1000),
                    Ensure.that(OrdersLPPage.ORDERED(number)).text().contains(CommonHandle.setDate(list.get(i).get("ordered"), "MM/dd/yy")),
                    Ensure.that(OrdersLPPage.D_COL(number, "store")).text().contains(list.get(i).get("store")),
                    Check.whether(list.get(i).get("delivery").isEmpty())
                            .otherwise(Ensure.that(OrdersLPPage.D_COL(number, "delivery")).text().contains(list.get(i).get("delivery"))),
                    Ensure.that(OrdersLPPage.D_COL(number, "route")).text().contains(list.get(i).get("route")),
                    Ensure.that(OrdersLPPage.D_COL(number, "address")).text().contains(list.get(i).get("address")),
                    Ensure.that(OrdersLPPage.D_COL(number, "fulfillment")).text().contains(list.get(i).get("fulfillment"))
            );
            if (list.get(i).containsKey("deliveryTime")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(OrdersLPPage.DELIVERYTIME(list.get(i).get("deliveryTime"))).isDisplayed()
                );
            }
            if (list.get(i).containsKey("eta")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(OrdersLPPage.D_COL(number, "eta-date")).text().contains(CommonHandle.setDate2(list.get(i).get("eta"), "MM/dd/yy"))
                );
            }
        }
    }

    @And("LP don't found order record on order page")
    public void dont_found_orderin__page(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            String number = list.get(i).get("number");
            if (number.isEmpty()) {
                number = Serenity.sessionVariableCalled("Id Sub-invoice LP").toString();
            }
            if (number.contains("create by api")) {
                number = Serenity.sessionVariableCalled("Number Purchase Order API").toString();
            }
            if (list.get(i).containsKey("suffix")) {
                number = Serenity.sessionVariableCalled("Number Order API").toString() + list.get(i).get("suffix");
            }
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isNotVisible(OrdersLPPage.ORDERED(number))
            );
        }
    }

    @And("Check not found PO on all order page")
    public void check_no_po_all_page() {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(OrdersLPPage.NO_ORDER_FOUND)),
                seeThat(CommonQuestions.getNumElement(OrdersLPPage.RECORD_ROW), equalTo(0))
        );
    }

    @And("LP go to order detail {string}")
    public void lp_go_to_detail(String id) {
        if (id.equals("")) {
            id = Serenity.sessionVariableCalled("Id Sub-invoice LP").toString();
        }
        if (id.equals("create by admin")) {
            id = Serenity.sessionVariableCalled("Sub-invoice ID create by admin");
        }
        if (id.equals("create by api")) {
            id = Serenity.sessionVariableCalled("Number Purchase Order API");
        }
        if (id.contains("admin create drop store")) {
            id = Serenity.sessionVariableCalled("Drop Number" + id.split("store ")[1]);
        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPOrdersDetailPage.NUMBER(id)),
                Click.on(LPOrdersDetailPage.NUMBER(id)),
                CommonWaitUntil.isVisible(LPOrdersDetailPage.DYNAMIC_TARGET("order-date"))
        );
        String num = LPOrdersDetailPage.NUMBER_PO.resolveFor(theActorInTheSpotlight()).getText().substring(1);
        Serenity.setSessionVariable("Id Sub-invoice LP").to(num);
    }

    @And("LP go to order detail")
    public void lp_go_to_detail(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        String id = null;
        if (list.get(0).containsKey("store")) {
            id = Serenity.sessionVariableCalled("Drop Number" + list.get(0).get("store"));

        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPOrdersDetailPage.NUMBER(id)),
                Click.on(LPOrdersDetailPage.NUMBER(id)),
                CommonWaitUntil.isVisible(LPOrdersDetailPage.DYNAMIC_TARGET("order-date"))
        );
        String num = LPOrdersDetailPage.NUMBER_PO.resolveFor(theActorInTheSpotlight()).getText().substring(1);
        Serenity.setSessionVariable("Id Sub-invoice LP").to(num);
    }

    @And("LP verify information of order detail")
    public void lp_verify_information_of_order_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(1000),
                Ensure.that(LPOrdersDetailPage.DYNAMIC_TARGET("order-date")).text().contains(CommonHandle.setDate(list.get(0).get("orderDate"), "MM/dd/yy")),
                Ensure.that(LPOrdersDetailPage.DYNAMIC_TARGET("fulfillment")).text().contains(list.get(0).get("fulfillment")),
                Ensure.that(LPOrdersDetailPage.BUYER).text().contains(list.get(0).get("buyer")),
                Ensure.that(LPOrdersDetailPage.STORE).text().contains(list.get(0).get("store")),
                Ensure.that(LPOrdersDetailPage.DYNAMIC_TARGET2("Address")).text().contains(list.get(0).get("address")),
                Check.whether(list.get(0).get("department").isEmpty())
                        .otherwise(
                                Ensure.that(LPOrdersDetailPage.DYNAMIC_TARGET2("Department")).text().contains(list.get(0).get("department"))),
                Ensure.that(LPOrdersDetailPage.DYNAMIC_TARGET2("Receiving weekday")).text().contains(list.get(0).get("receivingWeekday")),
                Ensure.that(LPOrdersDetailPage.DYNAMIC_TARGET2("Receiving time")).text().contains(list.get(0).get("receivingTime")),
                Ensure.that(LPOrdersDetailPage.DYNAMIC_TARGET2("Route information")).text().contains(list.get(0).get("route")),
                Ensure.that(LPOrdersDetailPage.DYNAMIC_TARGET2("Admin Note")).text().contains(list.get(0).get("adminNote")),
                Ensure.that(LPOrdersDetailPage.LP_NOTE2).attribute("value").contains(list.get(0).get("lpNote")),
                Check.whether(list.get(0).get("fulfillmentDate").isEmpty())
                        .otherwise(Ensure.that(LPOrdersDetailPage.EXPECTED_FULFILLMENT_DATE).text().contains(CommonHandle.setDate2(list.get(0).get("fulfillmentDate"), "MM/dd/yy")))
        );
        if (list.get(0).containsKey("storeNote")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(LPOrdersDetailPage.DYNAMIC_TARGET2("Store receiving note")).text().contains(list.get(0).get("storeNote"))
            );
        }
    }

    @And("LP check line items")
    public void checkOrderDetail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_ITEM_INFO(list.get(i).get("sku"), "brand")), containsString(list.get(i).get("brand"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_ITEM_INFO(list.get(i).get("sku"), "product")), containsString(list.get(i).get("product"))),
//                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.SKU(i + 1)), containsString(list.get(i).get("sku"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_ITEM_INFO(list.get(i).get("sku"), "upc")), equalToIgnoringCase(list.get(i).get("unitUPC"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_ITEM_INFO(list.get(i).get("sku"), "pack")), equalToIgnoringCase(list.get(i).get("pack"))),
//                    seeThat(CommonQuestions.isControlDisplay(LPOrdersDetailPage.POD_CONSIGNMENT_AUTO_CONFIRMATION(list.get(i).get("sku"))), Matchers.equalTo(Boolean.parseBoolean(list.get(i).get("podConsignment")))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.STORAGE_CONDITION(list.get(i).get("sku"))), containsString(list.get(i).get("storageCondition"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.QUANTITY(list.get(i).get("sku"))), containsString(list.get(i).get("quantity")))
            );
        }

    }

    @And("LP check Distribution")
    public void checkDistribution(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.DISTRIBUTION_CENTER(i + 1)), equalToIgnoringCase(list.get(i).get("distributionCenter"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.DISTRIBUTION_CENTER_NAME(i + 1)), equalToIgnoringCase(list.get(i).get("distributionCenterName")))
            );
        }
    }

    @And("LP set fulfillment date {string}")
    public void setFulfilmentDate(String date) {
        HandleOrdersLP.setFulfillment(date);
    }

    @And("LP check fulfilled date {string} on order detail")
    public void checkFulfilmentDate(String date) {
        theActorInTheSpotlight().attemptsTo(
                Scroll.to(LPOrdersDetailPage.FULFILLED_DATE),
                Ensure.that(LPOrdersDetailPage.FULFILLED_DATE).text().contains(CommonHandle.setDate2(date, "MM/dd/yy"))
        );
    }

    @And("See invoice then check promotion")
    public void see_invoice_then_check_promotion(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        String id = Serenity.sessionVariableCalled("Id Sub-invoice LP");
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersLP.seeDetail(id),
                HandleOrdersLP.seeInvoice(id)
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(OrdersLPPage.PROMO_INVOICE), containsString(expected.get(0).get("promoDiscount")))
        );
    }

    @And("LP confirm order unconfirmed then verify status is {string}")
    public void lp_confirm_order_unconfirmed(String status) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersLP.confirmOderUnconfirmed(),
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_ALERT("Fulfillment details updated successfully.")),
                CommonWaitUntil.isNotVisible(CommonLPPage.DYNAMIC_ALERT("Fulfillment details updated successfully.")),
                Ensure.that(LPOrdersDetailPage.DYNAMIC_TARGET("fulfillment")).text().contains(status)
        );
    }

    @And("LP confirm order unconfirmed")
    public void lp_confirm_order_unconfirmed() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersLP.confirmOderUnconfirmed()
        );
    }

    @And("LP set fulfillment order from admin with date {string}")
    public void lp_set_fulfillment_order_from_admin_with_date(String date) {
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersLP.setFulfillment1(date)
        );
    }

    @And("LP see packing slip")
    public void lp_verify_info_in_packing_slip() {
        String id = Serenity.sessionVariableCalled("Id Sub-invoice LP");
        theActorInTheSpotlight().attemptsTo(
                HandleOrdersLP.seePackingSlip(id)
        );
    }

    @And("LP verify info of packing slip")
    public void lp_verify_info_of_packing_slip(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(OrdersLPPage.D_FIELD_PACKING_SLIP("Store")).text().contains(expected.get(0).get("store")),
                Ensure.that(OrdersLPPage.D_FIELD_PACKING_SLIP("Buyer")).text().contains(expected.get(0).get("buyer")),
                Ensure.that(OrdersLPPage.D_FIELD_PACKING_SLIP("Order Date")).text().contains(CommonHandle.setDate2(expected.get(0).get("orderDate"), "MM/dd/yy")),
                Check.whether(expected.get(0).get("customerPO").equals(""))
                        .otherwise(Ensure.that(OrdersLPPage.D_FIELD_PACKING_SLIP("Store PO no.")).text().contains(expected.get(0).get("customerPO"))),
                Ensure.that(OrdersLPPage.D_FIELD_PACKING_SLIP("Address")).text().contains(expected.get(0).get("address")),
                Check.whether(expected.get(0).get("department").equals(""))
                        .otherwise(Ensure.that(OrdersLPPage.D_FIELD_PACKING_SLIP("Department")).text().contains(expected.get(0).get("department"))),
                Check.whether(expected.get(0).get("receivingWeekday").equals(""))
                        .otherwise(Ensure.that(OrdersLPPage.D_FIELD_PACKING_SLIP("Receiving weekday")).text().contains(expected.get(0).get("receivingWeekday"))),
                Check.whether(expected.get(0).get("receivingTime").equals(""))
                        .otherwise(Ensure.that(OrdersLPPage.D_FIELD_PACKING_SLIP("Receiving time")).text().contains(expected.get(0).get("receivingTime"))),

                // Switch lại parent
                WindowTask.closeCurrentAndSwitchParentWindowByURL(URL_LP + "lp/orders", "slip")
        );
    }

    @And("LP check {int} number record on pagination")
    public void lp_check_pagination_product(Integer num) {
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.getNumElement(CommonVendorPage.RECORD), Matchers.equalTo(num))
        );
    }

    @And("LP click {string} on pagination")
    public void lp_click_pagination(String page) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(page.contains("next") ? CommonVendorPage.ARROW_RIGHT : page.contains("back") ? CommonVendorPage.ARROW_LEFT : CommonVendorPage.PAGE(page)),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING_ICON("Fetching your"))
        );
    }

    @And("LP choose order to confirm")
    public void lp_choose_order(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            String number = map.get("number");
            if (map.get("number").contains("create by api")) {
                number = Serenity.sessionVariableCalled("Number Order API").toString();
            }
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(OrdersLPPage.CHECKBOX_ORDER(number + map.get("suffix"))),
                    Click.on(OrdersLPPage.CHECKBOX_ORDER(number + map.get("suffix")))
            );
        }
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(CommonVendorPage.DYNAMIC_ANY_TEXT(list.size() + " selected")))
        );
    }

    @And("LP Pick Fulfillment date {string} to confirm POs")
    public void lp_choose_date_order(String date) {
        theActorInTheSpotlight().attemptsTo(
                Enter.theValue(CommonHandle.setDate2(date, "MM/dd/yy")).into(OrdersLPPage.DYNAMIC_FILTER("Pick Fulfillment date first")).thenHit(Keys.ENTER)
        );

    }

    @And("LP select all orders on list")
    public void lp_select_all_orders() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(OrdersLPPage.SELECT_ALL),
                Click.on(OrdersLPPage.SELECT_ALL)
        );
    }

    @And("LP wait for download {string} success")
    public void wait_DownloadSubInvoice(String type) {
        if (type.equals("Sub-invoices"))
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.waitToDownloadSuccessfully("Pod_Foods_logistic-partner-sub-invoices_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".pdf")
            );
        else
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.waitToDownloadSuccessfully("Pod_Foods_logistic-partner-packing-slips_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".pdf")
            );
    }

    @And("LP {string} Unselect above POs with number {string} suffix {string}")
    public void checkDistribution(String action, String order, String suffix) {
        order = order.equals("create by api") ? Serenity.sessionVariableCalled("Number Order API").toString() : order;
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(OrdersLPPage.UNSELECT_BUTTON),
                Ensure.that(OrdersLPPage.MESSAGE_CONTENT).text().contains("Your selected action is not applicable for the following POs:"),
                Ensure.that(OrdersLPPage.MESSAGE_CONTENT).text().contains("- PO_" + order + suffix),
                Ensure.that(OrdersLPPage.MESSAGE_CONTENT).text().contains("Please unselect them before continuing."),
                Check.whether(action.equals("")).andIfSo(
                        Click.on(OrdersLPPage.UNSELECT_BUTTON),
                        CommonWaitUntil.isNotVisible(OrdersLPPage.UNSELECT_BUTTON)
                ).otherwise(
                        Click.on(OrdersLPPage.CLOSE_BUTTON),
                        CommonWaitUntil.isNotVisible(OrdersLPPage.UNSELECT_BUTTON)
                )
        );
    }

    @And("{word} export summary order")
    public void exportSummary(String actor) {
        String file = "Pod_Foods_purchase-orders_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".csv";
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON("Summary Export")),
                Click.on(CommonLPPage.DYNAMIC_BUTTON("Summary Export")),
                WindowTask.threadSleep(10000),
                CommonWaitUntil.waitToDownloadSuccessfully(file)
        );
    }

    @And("LP check content file export summary")
    public void checkExportSummary(DataTable table) {
        List<String[]> list2 = CommonHandle.convertDataTableToListArrayString(table);
        String path = System.getProperty("user.dir") + "/target/Pod_Foods_purchase-orders_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".csv";
        List<String[]> file = new ArrayList<>();
        file = CommonFile.readDataLineByLine(path);
        for (int i = 0; i < list2.size(); i++) {
            for (int j = 0; j < list2.get(i).length; j++)
                theActorInTheSpotlight().should(
                        seeThat(CommonQuestions.AskForContainValue(file.get(i)[j], list2.get(i)[j]))
                );
        }
    }

    @And("LP delete file export summary")
    public void deleteExportSummary() {
        String file;
        String path = "Pod_Foods_purchase-orders_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".csv";
        theActorInTheSpotlight().attemptsTo(
                CommonFile.deleteFileToDownload(path)
        );
    }

    @And("LP print {string}")
    public void see_invoice(String invoice) {
        String id = Serenity.sessionVariableCalled("Id Sub-invoice LP");
        if (invoice.contains("invoice"))
            theActorInTheSpotlight().attemptsTo(
                    HandleOrdersLP.seeInvoice(id)
            );
        if (invoice.contains("packing slip"))
            theActorInTheSpotlight().attemptsTo(
                    HandleOrdersLP.seePackingSlip(id)
            );
    }

    @And("Switch to window PO detail")
    public void switchToPODetail() {
        String id = Serenity.sessionVariableCalled("Id Sub-invoice LP");
        theActorInTheSpotlight().attemptsTo(
                WindowTask.switchToChildWindowsByTitle1("#PO_" + id + " - Pod Foods | Online Distribution Platform for Emerging Brands"),
                CommonWaitUntil.isVisible(LPOrdersDetailPage.NUMBER_PO));
    }

    @And("Close this window")
    public void closeWindow() {
        theActorInTheSpotlight().attemptsTo(
//                WindowTask.closeCurrentWindow()
        );
    }

    @And("LP verify info in Invoice")
    public void lp_verify_info_in_invoice(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        String invoiceNumber = Serenity.sessionVariableCalled("Id Sub-invoice LP");
        commonVerify.verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Order Date"), expected.get(0), "orderDate", CommonHandle.setDate2(expected.get(0).get("orderDate"), "MM/dd/yy"))
                .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Invoice Number"), expected.get(0), "invoiceNumber", expected.get(0).get("invoiceNumber").contains("subInvoice api") ? Serenity.sessionVariableCalled("Number Purchase Order API") : invoiceNumber)
                .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Delivery Date"), expected.get(0), "deliveryDate", CommonHandle.setDate2(expected.get(0).get("deliveryDate"), "MM/dd/yy"))
                .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Department"), expected.get(0), "department")
                .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Receiving time"), expected.get(0), "receivingTime")
                .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Deliver to"), expected.get(0), "deliverTo")
                .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Contact #"), expected.get(0), "contact")
                .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Payment Method"), expected.get(0), "paymentMethod")
                .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Payment term"), expected.get(0), "paymentTerm")
                .verifyTargetTextContain(LPOrdersDetailPage.INVOICE_EFFECTIVE, expected.get(0), "effective")
        ;
    }

    @And("LP verify items info in Invoice")
    public void lp_verify_items_info_in_invoice(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.STORAGE_ITEM_SUB_INVOICE(expected.get(i).get("storage"))), equalToIgnoringCase(expected.get(i).get("storage"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_SUB_INVOICE("tc upc-ean", i + 1)), equalToIgnoringCase(expected.get(i).get("unitUPC"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_SUB_INVOICE("tc pack", i + 1)), equalToIgnoringCase(expected.get(i).get("pack"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_SUB_INVOICE("tr size", i + 1)), equalToIgnoringCase(expected.get(i).get("unitSize"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_SUB_INVOICE("tc desc", i + 1)), containsString(expected.get(i).get("description"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_SUB_INVOICE("tc temp", i + 1)), equalToIgnoringCase(expected.get(i).get("temp"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_SUB_INVOICE("tc qty", i + 1)), equalToIgnoringCase(expected.get(i).get("caseQty"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_SUB_INVOICE("tr price", i + 1)), equalToIgnoringCase(expected.get(i).get("casePrice"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_SUB_INVOICE("tr discount", i + 1)), equalToIgnoringCase(expected.get(i).get("discount"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_SUB_INVOICE("tr tax", i + 1)), equalToIgnoringCase(expected.get(i).get("bottleDeposit"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_SUB_INVOICE("tr total", i + 1)), equalToIgnoringCase(expected.get(i).get("total"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_SUB_INVOICE("tr issue", i + 1)), equalToIgnoringCase(""))
            );
        }
    }

    @And("LP verify summary items info in Invoice")
    public void lp_verify_summary_items_info_in_invoice(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        commonVerify
                .verifyTargetTextContain(LPOrdersDetailPage.TOTAL_SUMMARY_ITEM_SUB_INVOICE("tc qty"), expected.get(0), "totalQuantity")
                .verifyTargetTextContain(LPOrdersDetailPage.TOTAL_SUMMARY_ITEM_SUB_INVOICE("tr discount"), expected.get(0), "discount")
                .verifyTargetTextContain(LPOrdersDetailPage.TOTAL_SUMMARY_ITEM_SUB_INVOICE("tr tax"), expected.get(0), "tax")
                .verifyTargetTextContain(LPOrdersDetailPage.TOTAL_SUMMARY_ITEM_SUB_INVOICE("tr total"), expected.get(0), "totalPrice")
                .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Subtotal"), expected.get(0), "subTotal")
                .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Bottle Deposit"), expected.get(0), "bottleDeposit")
                .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Promotional Discount"), expected.get(0), "promotionDiscount")
                .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Invoice Total"), expected.get(0), "invoiceTotal")
                .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Small Order Surcharge"), expected.get(0), "smallOrderSurcharge")
        ;
//        theActorInTheSpotlight().should(
//                seeThat(CommonQuestions.targetText(LPOrdersDetailPage.TOTAL_SUMMARY_ITEM_SUB_INVOICE("tc qty")), equalToIgnoringCase(expected.get(0).get("totalQuantity"))),
//                seeThat(CommonQuestions.targetText(LPOrdersDetailPage.TOTAL_SUMMARY_ITEM_SUB_INVOICE("tr discount")), equalToIgnoringCase(expected.get(0).get("discount"))),
//                seeThat(CommonQuestions.targetText(LPOrdersDetailPage.TOTAL_SUMMARY_ITEM_SUB_INVOICE("tr tax")), equalToIgnoringCase(expected.get(0).get("tax"))),
//                seeThat(CommonQuestions.targetText(LPOrdersDetailPage.TOTAL_SUMMARY_ITEM_SUB_INVOICE("tr total")), equalToIgnoringCase(expected.get(0).get("totalPrice"))),
//                seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Subtotal")), equalToIgnoringCase(expected.get(0).get("subTotal"))),
//                seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Bottle Deposit")), equalToIgnoringCase(expected.get(0).get("bottleDeposit"))),
//                seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Promotional Discount")), equalToIgnoringCase(expected.get(0).get("promotionDiscount"))),
//                seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Invoice Total")), equalToIgnoringCase(expected.get(0).get("invoiceTotal"))),
//                seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Small Order Surcharge")), equalToIgnoringCase(expected.get(0).get("smallOrderSurcharge")))
////                seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_SUB_INVOICE("Logistics Surcharge")), equalToIgnoringCase(expected.get(0).get("logisticSurcharge")))
//        );
    }

    @And("LP verify packing slip")
    public void lp_verify_packing_slip(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : expected) {
            commonVerify.verifyTargetTextContain(LPOrdersDetailPage.D_INFO_PACKING_SLIP("Store"), item, "store")
                    .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_PACKING_SLIP("Buyer"), item, "buyer")
                    .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_PACKING_SLIP("Order Date"), item, "orderDate", CommonHandle.setDate2(item.get("orderDate"), "MM/dd/yy"))
                    .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_PACKING_SLIP("Address"), item, "address")
                    .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_PACKING_SLIP("Department"), item, "department")
                    .verifyTargetTextContain(LPOrdersDetailPage.D_INFO_PACKING_SLIP("Receiving weekday"), item, "receiving")
//                    .verifyTargetTextContain(LPOrdersDetailPage.PACKING_SLIP_NUMBER, item, "number", item.get("number").contains("create") ? Serenity.sessionVariableCalled("Id Sub-invoice LP") : item.get("number"))
            ;
            if(item.containsKey("number")){
                commonVerify.verifyTargetTextContain(LPOrdersDetailPage.PACKING_SLIP_NUMBER, item, "number", item.get("number").contains("create") ? Serenity.sessionVariableCalled("Id Sub-invoice LP") : item.get("number"));

            }
        }
    }

    @And("LP verify items on packing slip")
    public void lp_verify_items_packing_slip(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_PACKING_SLIP("brand", expected.get(i).get("variant"))), containsString(expected.get(i).get("brand"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_PACKING_SLIP("product", expected.get(i).get("variant"))), containsString(expected.get(i).get("product"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_PACKING_SLIP("variant", expected.get(i).get("variant"))), containsString(expected.get(i).get("variant"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_PACKING_SLIP("condition", expected.get(i).get("variant"))), containsString(expected.get(i).get("condition"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_PACKING_SLIP("unit-upc", expected.get(i).get("variant"))), containsString(expected.get(i).get("unitUPC"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_PACKING_SLIP("case-upc", expected.get(i).get("variant"))), containsString(expected.get(i).get("caseUPC"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_PACKING_SLIP("case-units", expected.get(i).get("variant"))), equalToIgnoringCase(expected.get(i).get("caseUnit"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_PACKING_SLIP("lp-business-name", expected.get(i).get("variant"))), equalToIgnoringCase(expected.get(i).get("distributeCenter"))),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.D_INFO_ITEM_PACKING_SLIP("quantity tr", expected.get(i).get("variant"))), equalToIgnoringCase(expected.get(i).get("quantity")))
            );
        }
    }

    @And("LP upload Proof of Delivery file")
    public void lp_upload_proof_of_delivery(List<String> files) {
        for (String file : files)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isPresent(LPOrdersDetailPage.UPLOAD_POD),
                    CommonFile.upload1(file, LPOrdersDetailPage.UPLOAD_POD)
            );
    }

    @And("LP edit LP note in order detail")
    public void lp_edit_note(List<String> notes) {
        for (String note : notes)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isPresent(LPOrdersDetailPage.LP_NOTE2),
                    Enter.theValue(note).into(LPOrdersDetailPage.LP_NOTE2).thenHit(Keys.TAB),
                    CommonWaitUntil.isVisible(LPOrdersDetailPage.SAVE_LP_NOTE),
                    Click.on(LPOrdersDetailPage.SAVE_LP_NOTE)
            );
    }

    @And("LP check pod uploaded")
    public void lp_check_pod(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        String order = Serenity.sessionVariableCalled("Id Sub-invoice LP").toString();
        for (Map<String, String> map : expected) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.POD_UPLOADED("name")), containsString(map.get("name") + order)),
                    seeThat(CommonQuestions.targetText(LPOrdersDetailPage.POD_UPLOADED("link")), containsString(map.get("file")))
            );
        }
    }

    @And("LP {string} remove files pod uploaded {string}")
    public void lp_remove_pod(String action, String file) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPOrdersDetailPage.REMOVE_POD_UPLOADED(file)),
                Click.on(LPOrdersDetailPage.REMOVE_POD_UPLOADED(file)),
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON(action)),
                Click.on(CommonLPPage.DYNAMIC_BUTTON(action))
        );
    }

    @And("LP Check LP Note is disabled")
    public void checkField() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPOrdersDetailPage.LP_NOTE2),
                Ensure.that(LPOrdersDetailPage.LP_NOTE2).isDisabled()
        );
    }

}

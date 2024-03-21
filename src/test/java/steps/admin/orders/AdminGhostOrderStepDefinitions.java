package steps.admin.orders;

import cucumber.tasks.buyer.HandleOrderGuide;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.orders.HandleGhostOrders;
import cucumber.tasks.admin.orders.HandleOrders;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.CreateNewOrderPage;
import cucumber.user_interface.admin.orders.GhostOrderPage;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;
import static org.hamcrest.CoreMatchers.containsString;

public class AdminGhostOrderStepDefinitions {

    GhostOrderPage ghostOrderPage = new GhostOrderPage();
    OrderDetailPage orderDetailPage = new OrderDetailPage();

    @And("Admin create new ghost order")
    public void create_new_ghost_order(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleGhostOrders.goToCreate(),
                HandleOrders.fillInfoToCreateOrder(list.get(0))
        );
    }

    @And("{word} convert ghost order to real order")
    public void admin_convert_ghost_order_to_real_order(String actor) {
        theActorCalled(actor).attemptsTo(
                HandleGhostOrders.convertOrder()
        );
    }

    @And("Admin verify {word} require of line items in create new ghost orders")
    public void admin_verify_mov_require_line_items_in_create_new_ghost_orders(String type, DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        if (type.equals("MOV")) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(OrderDetailPage.COMPANY_NAME_MOV),
                    Ensure.that(OrderDetailPage.COMPANY_NAME_MOV).text().contains(expected.get(0).get("companyName")),
                    Ensure.that(OrderDetailPage.TOTAL_PAYMENT_MOV).text().contains(expected.get(0).get("totalPayment")),
                    Ensure.that(OrderDetailPage.PRICE_MOV).text().contains(expected.get(0).get("movPrice")),
                    Ensure.that(OrderDetailPage.MESSAGE_MOV).text().contains(expected.get(0).get("message"))
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.ITEM_WITH_MOQ).text().contains(expected.get(0).get("itemMOQ")),
                    Ensure.that(OrderDetailPage.MESSAGE_NOT_MEET_MOQ).text().contains(expected.get(0).get("message"))
            );
        }
    }

    @And("Admin confirm convert ghost order to real order")
    public void admin_confirm_convert_ghost_order_to_real_order() {
        theActorInTheSpotlight().attemptsTo(
                HandleGhostOrders.confirmConvertOrder()
        );

        String orderID = Text.of(OrderDetailPage.ORDER_ID_HEADER).answeredBy(theActorInTheSpotlight()).toString();
        orderID = orderID.substring(orderID.lastIndexOf("#")).trim();
        System.out.println("ID Order = " + orderID);
        Serenity.setSessionVariable("ID Order").to(orderID.substring(1));
    }

    @And("Admin confirm convert ghost order to real order {string} with customer PO")
    public void admin_confirm_convert_ghost_order_to_real_order_PO(String order) {
        order = Serenity.sessionVariableCalled("ID Invoice");
        theActorInTheSpotlight().attemptsTo(
                HandleGhostOrders.confirmConvertOrderWithPO(order)
        );

        String orderID = Text.of(OrderDetailPage.ORDER_ID_HEADER).answeredBy(theActorInTheSpotlight()).toString();
        orderID = orderID.substring(orderID.lastIndexOf("#")).trim();
        System.out.println("ID Order = " + orderID);
        Serenity.setSessionVariable("ID Order").to(orderID.substring(1));
    }

    @And("Admin verify line items in ghost order detail")
    public void admin_verify_line_item_of_ghost_order_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(item.get("tagPD").equals("Yes"))
                            .andIfSo(
                                    CommonWaitUntil.isVisible(ghostOrderPage.TAG_PD_DETAILS(item.get("skuID"))),
                                    Ensure.that(ghostOrderPage.TAG_PD_DETAILS(item.get("skuID"))).isDisplayed()),
                    Check.whether(item.get("tagPE").equals("Yes"))
                            .andIfSo(
                                    CommonWaitUntil.isVisible(ghostOrderPage.TAG_PE_DETAILS(item.get("skuID"))),
                                    Ensure.that(ghostOrderPage.TAG_PE_DETAILS(item.get("skuID"))).isDisplayed()),
                    CommonWaitUntil.isVisible(ghostOrderPage.SKU_ID_DETAIL(item.get("skuID"))),
                    Ensure.that(ghostOrderPage.SKU_ID_DETAIL(item.get("skuID"))).text().contains(item.get("skuID")),
                    Ensure.that(ghostOrderPage.SKU_DETAIL(item.get("skuID"))).text().contains(item.get("sku")),
                    Ensure.that(ghostOrderPage.PRODUCT_DETAIL(item.get("skuID"))).attribute("data-original-text").contains(item.get("product")),
                    Ensure.that(ghostOrderPage.BRAND_DETAIL(item.get("skuID"))).attribute("data-original-text").contains(item.get("brand")),

                    Ensure.that(ghostOrderPage.CASE_PRICE_DETAILS(item.get("skuID"))).text().contains(item.get("price")),
                    Ensure.that(ghostOrderPage.UNITS_DETAILS(item.get("skuID"))).text().contains(item.get("unitCase")),
                    Ensure.that(ghostOrderPage.QUANTITY_DETAILS(item.get("skuID"))).text().contains(item.get("quantity")),
                    Check.whether(item.get("endQuantity").isEmpty())
                            .otherwise(Ensure.that(ghostOrderPage.END_QUANTITY_DETAILS(item.get("skuID"))).text().contains(item.get("endQuantity"))),
                    Ensure.that(ghostOrderPage.TOTAL_DETAILS(item.get("skuID"))).text().contains(item.get("total"))
            );
        }
    }

    @And("Admin verify general information of ghost order detail")
    public void admin_verify_general_info_of_ghost_order_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(ghostOrderPage.DATE_GENERAL),
                Check.whether(list.get(0).get("customerPo").equals(""))
                        .otherwise(Ensure.that(ghostOrderPage.CUSTOMER_PO_GENERAL).text().contains(list.get(0).get("customerPo"))),
                Ensure.that(ghostOrderPage.DATE_GENERAL).text().contains(CommonHandle.setDate(list.get(0).get("date"), "MM/dd/yy")),
                Ensure.that(ghostOrderPage.REGION_GENERAL).text().contains(list.get(0).get("region")),
                Ensure.that(ghostOrderPage.BUYER_GENERAL).text().contains(list.get(0).get("buyer")),
                Ensure.that(ghostOrderPage.STORE_GENERAL).text().contains(list.get(0).get("store")),
                Ensure.that(ghostOrderPage.ORDER_VALUE_GENERAL).text().contains(list.get(0).get("orderValue")),
                Ensure.that(ghostOrderPage.CREATOR_GENERAL).text().contains(list.get(0).get("creator")),
                Ensure.that(ghostOrderPage.MANAGED_GENERAL).text().contains(list.get(0).get("managed")),
                Ensure.that(ghostOrderPage.LAUNCHED_GENERAL).text().contains(list.get(0).get("launched")),
                Check.whether(list.get(0).get("address").equals(""))
                        .otherwise(Ensure.that(ghostOrderPage.ADDRESS_GENERAL).text().contains(list.get(0).get("address"))),
                Check.whether(list.get(0).get("adminNote").equals(""))
                        .otherwise(Ensure.that(ghostOrderPage.ADMIN_NOTE_GENERAL).text().contains(list.get(0).get("adminNote")))
        );
    }

    @And("Admin verify line items in create new ghost orders")
    public void admin_verify_line_items_in_create_new_ghost_orders(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(orderDetailPage.BRAND_IN_LINE_ITEM(expected.get(0).get("skuID"))),
                Ensure.that(orderDetailPage.BRAND_IN_LINE_ITEM(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("brand")),
                Ensure.that(orderDetailPage.PRODUCT_IN_LINE_ITEM(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("product")),
                Ensure.that(orderDetailPage.SKU_IN_LINE_ITEM(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("sku")),
                Ensure.that(orderDetailPage.SKU_ID_IN_LINE_ITEM(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("skuID")),
                Ensure.that(orderDetailPage.UNIT_UPC_IN_LINE_ITEM(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("unitUPC")),
                Ensure.that(orderDetailPage.UNITS_IN_LINE_ITEM(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("unitCase")),
                Ensure.that(orderDetailPage.STATUS_IN_LINE_ITEM(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("status")),
                Ensure.that(orderDetailPage.PRICE_IN_LINE_ITEM(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("price")),
                Ensure.that(orderDetailPage.QUANTITY_IN_LINE_ITEM(expected.get(0).get("skuID"))).attribute("value").contains(expected.get(0).get("quantity")),
                Ensure.that(orderDetailPage.REGION_IN_LINE_ITEM(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("region"))
        );
    }

    @And("Admin verify line item in convert ghost order")
    public void admin_verify_line_item_in_convert_ghost_order(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(ghostOrderPage.QUANTITY_IN_LINE_ITEM_CONVERT(expected.get(0).get("skuID"))),
                Ensure.that(ghostOrderPage.SKU_ID_DETAIL(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("skuID")),
                Ensure.that(ghostOrderPage.BRAND_IN_LINE_ITEM_CONVERT(expected.get(0).get("skuID"))).attribute("data-original-text").contains(expected.get(0).get("brand")),
                Ensure.that(ghostOrderPage.PRODUCT_IN_LINE_ITEM_CONVERT(expected.get(0).get("skuID"))).attribute("data-original-text").contains(expected.get(0).get("product")),
                Ensure.that(ghostOrderPage.SKU_IN_LINE_ITEM_CONVERT(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("sku")),
                Ensure.that(ghostOrderPage.PRICE_IN_LINE_ITEM_CONVERT(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("price")),
                Ensure.that(ghostOrderPage.UNITS_IN_LINE_ITEM_CONVERT(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("units")),
                Ensure.that(ghostOrderPage.QUANTITY_IN_LINE_ITEM_CONVERT(expected.get(0).get("skuID"))).attribute("value").contains(expected.get(0).get("quantity")),
                Ensure.that(ghostOrderPage.END_QUANTITY_IN_LINE_ITEM_CONVERT(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("endQuantity"))
        );
        if (expected.get(0).containsKey("total")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(ghostOrderPage.TOTAL_IN_LINE_ITEM_CONVERT(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("total"))
            );
        }
        if (expected.get(0).containsKey("oldTotal")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(ghostOrderPage.NEW_TOTAL_IN_LINE_ITEM_CONVERT(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("newTotal")),
                    Ensure.that(ghostOrderPage.OLD_TOTAL_IN_LINE_ITEM_CONVERT(expected.get(0).get("skuID"))).text().contains(expected.get(0).get("oldTotal"))
            );
        }
    }

    @And("Admin verify line iem in not display in convert ghost order")
    public void admin_verify_line_item_is_not_display_in_convert_ghost_order(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        for (Map<String, String> info : expected) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Convert Order")),
                    Ensure.that(ghostOrderPage.SKU_ID_DETAIL(info.get("skuID"))).isNotDisplayed(),
                    Ensure.that(ghostOrderPage.BRAND_IN_LINE_ITEM_CONVERT(info.get("skuID"))).isNotDisplayed()
            );
        }

    }

    @And("Admin verify summary {string} in convert ghost order")
    public void admin_verify_summary_in_convert_ghost_order(String type, DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        String index = "1";
        if (type.equals("in stock")) {
            index = "2";
        }
        if (type.equals("OOS or LS")) {
            index = "3";
        }

        theActorInTheSpotlight().attemptsTo(
                Scroll.to(ghostOrderPage.DYNAMIC_PRICE_IN_SUMMARY("Total cases", index)),
                WindowTask.threadSleep(3000)
        );
        theActorInTheSpotlight().attemptsTo(
                Check.whether(infos.get(0).get("totalCase").equals(""))
                        .otherwise(Ensure.that(ghostOrderPage.DYNAMIC_PRICE_IN_SUMMARY("Total cases", index)).text().contains(infos.get(0).get("totalCase"))),
                Check.whether(infos.get(0).get("totalOrderValue").equals(""))
                        .otherwise(Ensure.that(ghostOrderPage.DYNAMIC_PRICE_IN_SUMMARY("Total Order Value", index)).text().contains(infos.get(0).get("totalOrderValue"))),
                Check.whether(infos.get(0).get("discount").equals(""))
                        .otherwise(Ensure.that(ghostOrderPage.DYNAMIC_PRICE_IN_SUMMARY("Discount", index)).text().contains(infos.get(0).get("discount"))),
                Check.whether(infos.get(0).get("taxes").equals(""))
                        .otherwise(Ensure.that(ghostOrderPage.DYNAMIC_PRICE_IN_SUMMARY("Taxes", index)).text().contains(infos.get(0).get("taxes"))),
                Check.whether(infos.get(0).get("smallOrderSurcharge").equals(""))
                        .otherwise(Ensure.that(ghostOrderPage.DYNAMIC_PRICE_IN_SUMMARY("Small order surcharge", index)).text().contains(infos.get(0).get("smallOrderSurcharge"))),
                Check.whether(infos.get(0).get("logisticsSurcharge").equals(""))
                        .otherwise(Ensure.that(ghostOrderPage.DYNAMIC_PRICE_IN_SUMMARY("Logistics surcharge", index)).text().contains(infos.get(0).get("logisticsSurcharge"))),
                Check.whether(infos.get(0).get("specialDiscount").equals(""))
                        .otherwise(Ensure.that(ghostOrderPage.DYNAMIC_PRICE_IN_SUMMARY("Special discount", index)).text().contains(infos.get(0).get("specialDiscount"))),
                Check.whether(infos.get(0).get("specialDiscount").equals(""))
                        .otherwise(Ensure.that(ghostOrderPage.DYNAMIC_PRICE_IN_SUMMARY("Total payment", index)).text().contains(infos.get(0).get("totalPayment")))
        );
    }

    @And("Admin verify {word} require of line items in convert ghost orders")
    public void admin_verify_mov_require_line_items_in_convert_ghost_orders(String type, DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        if (type.equals("MOV")) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(OrderDetailPage.COMPANY_NAME_MOV),
                    Ensure.that(OrderDetailPage.COMPANY_NAME_MOV).text().contains(expected.get(0).get("companyName")),
                    Ensure.that(OrderDetailPage.TOTAL_PAYMENT_MOV).text().contains(expected.get(0).get("totalPayment")),
                    Ensure.that(OrderDetailPage.PRICE_MOV).text().contains(expected.get(0).get("movPrice")),
                    Ensure.that(GhostOrderPage.MESSAGE_MOV).text().contains(expected.get(0).get("message"))
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(GhostOrderPage.MESSAGE_MOV),
                    Ensure.that(GhostOrderPage.MESSAGE_MOV).text().contains(expected.get(0).get("message"))
            );
        }
    }

    @And("Admin search the ghost orders by info")
    public void search_the_ghost_order_by_info(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));
        String idInvoice = null;
        if (infos.get(0).get("ghostOrderNumber").contains("create by admin")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order");
            info = CommonTask.setValue(infos.get(0), "ghostOrderNumber", infos.get(0).get("ghostOrderNumber"), idInvoice, "create by admin");
        }
        if (infos.get(0).get("ghostOrderNumber").contains("create by api")) {
            idInvoice = Serenity.sessionVariableCalled("Ghost Order Number API");
            info = CommonTask.setValue(infos.get(0), "ghostOrderNumber", infos.get(0).get("ghostOrderNumber"), idInvoice, "create by api");
        }
        if (infos.get(0).containsKey("index")) {
            idInvoice = Serenity.sessionVariableCalled("Ghost Order Number API" + infos.get(0).get("index"));
            info = CommonTask.setValue(infos.get(0), "ghostOrderNumber", infos.get(0).get("ghostOrderNumber"), idInvoice, "create by api");
        }

        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleGhostOrders.searchGhostOrder(info)
        );
    }

    @And("Admin verify result ghost order in all order")
    public void verify_result_order_in_all_order(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(expected.get(0), "ghostOrderNumber", expected.get(0).get("ghostOrderNumber"), Serenity.sessionVariableCalled("Ghost Order Number API").toString(), "create by api");
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(GhostOrderPage.ORDER_RESULT), containsString(info.get("ghostOrderNumber"))),
                seeThat(CommonQuestions.targetText(GhostOrderPage.CUSTOMER_PO_RESULT), containsString(info.get("customerPO"))),
                seeThat(CommonQuestions.targetText(GhostOrderPage.CREATED_DATE_RESULT), containsString(CommonHandle.setDate2(expected.get(0).get("createdDate"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(GhostOrderPage.CREATOR_RESULT), containsString(expected.get(0).get("creator"))),
                seeThat(CommonQuestions.attributeText(GhostOrderPage.BUYER_RESULT, "data-original-text"), containsString(expected.get(0).get("buyer"))),
                seeThat(CommonQuestions.targetText(GhostOrderPage.STORE_RESULT), containsString(expected.get(0).get("store"))),
                seeThat(CommonQuestions.targetText(GhostOrderPage.REGION_RESULT), containsString(expected.get(0).get("region"))),
                seeThat(CommonQuestions.targetText(GhostOrderPage.TOTAL_RESULT), containsString(expected.get(0).get("total")))
        );
    }

    @And("Admin go to create new ghost order")
    public void go_to_create_new_ghost_order() {
        theActorInTheSpotlight().attemptsTo(
                HandleGhostOrders.goToCreate()
        );
    }

    @And("Admin verify field blank when create ghost order")
    public void verify_field_blank_when_create_ghost_order() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(CreateNewOrderPage.CREATE_ORDER_BUTTON),
                WindowTask.threadSleep(1000),
                // Verify error message
                Ensure.that(GhostOrderPage.ERROR_MESSAGE_TEXTBOX("Buyer")).text().contains("Please select a specific buyer for the new order"),
                Ensure.that(GhostOrderPage.ERROR_MESSAGE_TEXTBOX("Street address")).text().contains("Please input shipping street address"),
                Ensure.that(GhostOrderPage.ERROR_MESSAGE_TEXTBOX("City")).text().contains("Please input shipping city"),
                Ensure.that(GhostOrderPage.ERROR_MESSAGE_TEXTBOX("State (Province/Territory)")).text().contains("Please select shipping state"),
                Ensure.that(GhostOrderPage.ERROR_MESSAGE_TEXTBOX("Zip")).text().contains("Please input shipping postal zip code"),
                Ensure.that(GhostOrderPage.ERROR_MESSAGE_LINE_ITEM_TEXTBOX).text().contains("Please add line items for this order")
        );
    }

    @And("Admin verify field buyer when create ghost order")
    public void verify_field_buyer_when_create_ghost_order() {
        theActorInTheSpotlight().attemptsTo(
                // search buyer inactive
                Enter.theValue("ngocbuyerinactive").into(CreateNewOrderPage.DYNAMIC_TEXTBOX("Buyer")),
                CommonWaitUntil.isVisible(CommonAdminForm.NO_DATA),
                Ensure.that(CommonAdminForm.NO_DATA).isDisplayed(),
                // search head buyer
                Enter.theValue("ngoctx stborderdetail36hchi01").into(CreateNewOrderPage.DYNAMIC_TEXTBOX("Buyer")),
                CommonWaitUntil.isVisible(CommonAdminForm.NO_DATA),
                Ensure.that(CommonAdminForm.NO_DATA).isDisplayed()
        );
    }

    @And("Admin verify stamp SOS, LS when choose field buyer when create ghost order")
    public void verify_stamp_SOS_LS_when_choose_field_buyer_when_create_ghost_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (info.get("sos").equals("display")) {
                theActorInTheSpotlight().attemptsTo(
                        // verify spam SOS, LS visible
                        CommonTask.chooseItemInDropdownWithValueInput1(CreateNewOrderPage.DYNAMIC_TEXTBOX("Buyer"), infos.get(0).get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(infos.get(0).get("buyer"))),
                        CommonWaitUntil.isVisible(GhostOrderPage.SOS_STAMP),
                        Ensure.that(GhostOrderPage.SOS_STAMP).isDisplayed()
//                        Ensure.that(GhostOrderPage.LS_STAMP).isDisplayed()
                );
            }
            if (info.get("sos").equals("undisplay")) {
                theActorInTheSpotlight().attemptsTo(
                        // verify spam SOS, LS visible
                        CommonTask.chooseItemInDropdownWithValueInput1(CreateNewOrderPage.DYNAMIC_TEXTBOX("Buyer"), infos.get(0).get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(infos.get(0).get("buyer"))),
                        CommonWaitUntil.isNotVisible(GhostOrderPage.SOS_STAMP),
                        Ensure.that(GhostOrderPage.SOS_STAMP).isNotDisplayed()
                );
            }
        }
    }

    @And("Admin verify auto fill address")
    public void verify_auto_fill_address(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                // Choose buyer
                CommonTask.chooseItemInDropdownWithValueInput1(CreateNewOrderPage.DYNAMIC_TEXTBOX("Buyer"), infos.get(0).get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(infos.get(0).get("buyer"))),
                // Fill address
                Click.on(GhostOrderPage.FILL_ADDRESS_INFO),
                WindowTask.threadSleep(1000),
                // Verify
                Ensure.that(CreateNewOrderPage.DYNAMIC_TEXTBOX("Street address")).attribute("value").contains(infos.get(0).get("street1")),
                Check.whether(infos.get(0).get("street2").equals(""))
                        .otherwise(Ensure.that(GhostOrderPage.STREET2_TEXTBOX).attribute("value").contains(infos.get(0).get("street2"))),
                Ensure.that(CreateNewOrderPage.DYNAMIC_TEXTBOX("City")).attribute("value").contains(infos.get(0).get("city")),
                Ensure.that(CreateNewOrderPage.DYNAMIC_TEXTBOX("State (Province/Territory)")).attribute("value").contains(infos.get(0).get("state")),
                Ensure.that(CreateNewOrderPage.DYNAMIC_TEXTBOX("Zip")).attribute("value").contains(infos.get(0).get("zip"))
        );
        if (infos.get(0).containsKey("annt")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CreateNewOrderPage.DYNAMIC_TEXTBOX("ATTN")).attribute("value").contains(infos.get(0).get("attn"))
            );
        }
    }

    @And("Admin verify zip code in create ghost order")
    public void verify_zip_code(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : infos) {
            theActorInTheSpotlight().attemptsTo(
                    Enter.theValue(item.get("zip")).into(CreateNewOrderPage.DYNAMIC_TEXTBOX("Zip")).thenHit(Keys.TAB),
                    Check.whether(item.get("verify").equals(""))
                            .andIfSo(
                                    WindowTask.threadSleep(1000),
                                    Ensure.that(GhostOrderPage.ERROR_MESSAGE_TEXTBOX("Zip")).isNotDisplayed())
                            .otherwise(
                                    CommonWaitUntil.isVisible(GhostOrderPage.ERROR_MESSAGE_TEXTBOX("Zip")),
                                    Ensure.that(GhostOrderPage.ERROR_MESSAGE_TEXTBOX("Zip")).text().contains(item.get("verify")))
            );


        }
    }

    @And("Admin go to ghost order detail number {string}")
    public void admin_go_to_detail_after_search(String number) {
        String idInvoice = number;
        if (number.equals("")) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice").toString();
            idInvoice = idInvoice.substring(7);
        }
        if (number.contains("create by admin")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order");
        }
        if (number.contains("create by api")) {
            idInvoice = Serenity.sessionVariableCalled("Ghost Order Number API").toString();
        }
        // lấy ID để search Orders
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.seeDetail(idInvoice)
        );
    }

    @And("Admin edit general information of ghost order detail")
    public void admin_edit_general_information_of_ghost_order_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrderGuide.editGeneralInformation(infos.get(0))
        );
    }

    @And("Admin add line item in ghost order")
    public void admin_add_line_item_in_ghost_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleGhostOrders.addLineItem(infos.get(0)),
                WindowTask.threadSleep(500),
                HandleOrders.saveAction()
        );
    }

    @And("Admin verify history add new line item in ghost order detail")
    public void admin_verify_history_add_new_line_in_ghost_order_detail(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    // Verify info of popup
                    HandleGhostOrders.seeHistoryAddItem(infos.get(i).get("sku"))
            );
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(OrderDetailPage.POPRER_HELP_VALUE(i + 1)),
                    Ensure.that(OrderDetailPage.POPRER_HELP_VALUE(i + 1)).text().contains(infos.get(i).get("quantity")),
                    Ensure.that(OrderDetailPage.POPRER_HELP_REASON(i + 1)).text().contains(infos.get(i).get("reason")),
                    Ensure.that(OrderDetailPage.POPRER_HELP_UPDATE_BY(i + 1)).text().contains(infos.get(i).get("updateBy")),
                    Ensure.that(OrderDetailPage.POPRER_HELP_UPDATE_ON(i + 1)).text().contains(CommonHandle.setDate2(infos.get(i).get("updateOn"), "MM/dd/yy")),
                    Ensure.that(OrderDetailPage.POPRER_HELP_NOTE(i + 1)).text().contains(infos.get(i).get("note"))
            );
        }
    }

    @And("Admin delete line item in ghost order detail")
    public void admin_delete_line_item_in_ghost_order_detail(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    // Verify info of popup
                    HandleGhostOrders.deleteLineItem(infos.get(i))
            );
        }
    }

    @And("Admin check line items {string} in ghost order details")
    public void admin_check_line_item_non_invoice_in_order_detail(String type, DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.openExpandOrder()
        );
        String typeLine = null;
        switch (type) {
            case "deleted or shorted items":
                typeLine = "non-invoice-group order-disabled";
                break;
        }

        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> info = CommonTask.setValueRandom(list.get(i), "sku", Serenity.sessionVariableCalled("SKU inventory"));
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.LINE_ITEM_BRAND(typeLine, i + 1)).attribute("data-original-text").contains(list.get(i).get("brand")),
                    Ensure.that(OrderDetailPage.LINE_ITEM_PRODUCT(typeLine, i + 1)).attribute("data-original-text").contains(list.get(i).get("product")),
                    Ensure.that(OrderDetailPage.LINE_ITEM_SKU(typeLine, i + 1)).attribute("data-original-text").contains(info.get("sku")),
                    Ensure.that(OrderDetailPage.LINE_ITEM_CASE_PRICE(typeLine, i + 1)).text().contains(list.get(i).get("casePrice")),
                    Check.whether(typeLine.equals("non-invoice-group order-disabled"))
                            .andIfSo(Ensure.that(OrderDetailPage.LINE_ITEM_QUANTITY_DELETE2(typeLine)).text().contains(list.get(i).get("quantity")))
                            .otherwise(Ensure.that(OrderDetailPage.LINE_ITEM_QUANTITY1(typeLine, i + 1)).text().contains(list.get(i).get("quantity"))),
                    Ensure.that(OrderDetailPage.LINE_ITEM_CASE_UNIT(typeLine, i + 1)).text().contains(list.get(i).get("unitCase")),
                    Check.whether(list.get(i).get("endQuantity").equals(""))
                            .otherwise(Ensure.that(OrderDetailPage.LINE_ITEM_END_QUANTITY(typeLine, i + 1)).text().contains(list.get(i).get("endQuantity"))),
                    Ensure.that(OrderDetailPage.LINE_ITEM_TOTAL(typeLine, i + 1)).text().contains(list.get(i).get("total"))
            );
            if (info.containsKey("skuID")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(OrderDetailPage.LINE_ITEM_SKU_ID(list.get(i).get("skuID"))).text().contains(list.get(i).get("skuID"))
                );
            }
        }
    }

    @And("Admin delete ghost order")
    public void admin_delete_ghost_order() {
        theActorInTheSpotlight().attemptsTo(
                // Verify info of popup
                HandleGhostOrders.deleteGhostOrder()
        );

    }

    @And("Admin verify stamp SOS, LS when choose field buyer in convert ghost order")
    public void verify_stamp_SOS_LS_when_choose_field_buyer_in_convert_ghost_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(infos.get(0).get("sos").equals(""))
                        .otherwise(Ensure.that(GhostOrderPage.SOS_ALERT).text().contains(infos.get(0).get("sos"))),
                Check.whether(infos.get(0).get("ls").equals(""))
                        .otherwise(Ensure.that(GhostOrderPage.LS_ALERT).text().contains(infos.get(0).get("ls")))
        );
    }

    @And("Admin create ghost order success")
    public void admin_create_ghost_order_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleOrders.createOrderSuccess()
        );
        String orderID = Text.of(OrderDetailPage.ORDER_ID_HEADER).answeredBy(theActorInTheSpotlight()).toString();
        orderID = orderID.substring(orderID.lastIndexOf("#")).trim();
        System.out.println("ID Invoice Ghost Order " + orderID);
        Serenity.setSessionVariable("ID Invoice Ghost Order").to(orderID);
        Serenity.setSessionVariable("ID Ghost Order").to(orderID.substring(1));
        Serenity.setSessionVariable("ID Ghost Order create by admin").to(orderID);
    }

    @And("Admin convert ghost order then see message {string}")
    public void admin_convert_ghost_order_then_see_message(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Convert Order")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Convert Order")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    @And("Admin select ghost order in result search")
    public void admin_select_ghost_order_in_result_search(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleGhostOrders.selectGhostOrder(infos)
        );
    }

    @And("Admin convert bulk ghost order")
    public void admin_convert_bulk_ghost_order() {
        theActorInTheSpotlight().attemptsTo(
                HandleGhostOrders.convertBulk()
        );
    }

    @And("Admin expand order bulk ghost order")
    public void admin_expand_order_bulk_ghost_order(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String ghostOrderNumber = Serenity.sessionVariableCalled("Ghost Order Number API" + infos.get(0).get("index"));
        theActorInTheSpotlight().attemptsTo(
                HandleGhostOrders.expandBulk(ghostOrderNumber)
        );
    }

    @And("Admin verify line items in bulk ghost order detail")
    public void admin_verify_line_item_of_bulk_ghost_order_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(ghostOrderPage.SKU_ID_DETAIL(item.get("skuID"))),
                    Ensure.that(ghostOrderPage.SKU_ID_DETAIL(item.get("skuID"))).text().contains(item.get("skuID")),
                    Ensure.that(ghostOrderPage.SKU_DETAIL(item.get("skuID"))).attribute("data-original-text").contains(item.get("sku")),
                    Ensure.that(ghostOrderPage.PRODUCT_DETAIL(item.get("skuID"))).attribute("data-original-text").contains(item.get("product")),
                    Ensure.that(ghostOrderPage.BRAND_DETAIL(item.get("skuID"))).attribute("data-original-text").contains(item.get("brand")),
                    Ensure.that(ghostOrderPage.CASE_PRICE_DETAILS(item.get("skuID"))).text().contains(item.get("price")),
                    Ensure.that(ghostOrderPage.UNITS_DETAILS(item.get("skuID"))).text().contains(item.get("unitCase")),
                    Ensure.that(ghostOrderPage.QUANTITY_BULK(item.get("skuID"))).attribute("value").contains(item.get("quantity")),
                    Ensure.that(ghostOrderPage.END_QUANTITY_DETAILS(item.get("skuID"))).text().contains(item.get("endQuantity"))

            );
            if (item.containsKey("newTotal")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(ghostOrderPage.NEW_TOTAL_IN_LINE_ITEM_BULK(item.get("skuID"))).text().contains(item.get("newTotal")),
                        Ensure.that(ghostOrderPage.OLD_TOTAL_IN_LINE_ITEM_BULK(item.get("skuID"))).text().contains(item.get("oldTotal"))
                );
            } else {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(ghostOrderPage.TOTAL_DETAILS(item.get("skuID"))).text().contains(item.get("total"))
                );
            }
        }
    }

    @And("Admin delete line item in bulk ghost order detail")
    public void admin_delete_line_item_in_bulk_ghost_order_detail(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleGhostOrders.deleteLineItemBulk(infos)
        );
    }

    @And("Admin verify {word} require of line items in convert bulk ghost orders")
    public void admin_verify_mov_require_line_items_in_convert_bulk_ghost_orders(String type, DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        if (type.equals("MOV")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.COMPANY_NAME_MOV).text().contains(expected.get(0).get("companyName")),
                    Ensure.that(OrderDetailPage.TOTAL_PAYMENT_MOV).text().contains(expected.get(0).get("totalPayment")),
                    Ensure.that(OrderDetailPage.PRICE_MOV).text().contains(expected.get(0).get("movPrice")),
                    Ensure.that(GhostOrderPage.MESSAGE_MOV).text().contains(expected.get(0).get("message"))
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(OrderDetailPage.MESSAGE_NOT_MEET_MOQ_BULK).text().contains(expected.get(0).get("message"))
            );
        }
    }

    @And("Admin verify not meet {word} require of line items in convert bulk ghost orders")
    public void admin_verify_not_meet_mov_require_line_items_in_convert_bulk_ghost_orders(String type) {
        if (type.equals("MOV")) {
            theActorInTheSpotlight().attemptsTo(
                    WindowTask.threadSleep(10000),
                    Ensure.that(GhostOrderPage.MESSAGE_MOV).isNotDisplayed()
            );
        } else {
            theActorInTheSpotlight().attemptsTo(
                    WindowTask.threadSleep(1000),
                    Ensure.that(OrderDetailPage.MESSAGE_NOT_MEET_MOQ_BULK).isNotDisplayed()
            );
        }
    }

    @And("Admin change quantity of line items in convert bulk ghost orders")
    public void admin_change_quantity_of_line_items_in_convert_bulk_ghost_orders(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleGhostOrders.changeQuantityBulk(infos)
        );
    }

    @And("Admin verify checkbox ghost order result")
    public void admin_verify_checkbox_ghost_order_result() {
        theActorInTheSpotlight().attemptsTo(
                // select all sẽ hiển thị popup convert
                HandleGhostOrders.selectAll(),
                // unselect all sẽ hiển thị popup convert
                HandleGhostOrders.unSelectAll()
        );
    }

    @And("{word} convert order in bulk ghost order to real order")
    public void admin_convert_order_in_bulk_ghost_order_to_real_order(String actor) {
        theActorCalled(actor).attemptsTo(
                HandleGhostOrders.convertOrder(),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Convert Order"))
        );
    }

    @And("{word} convert order in bulk ghost order to real order and see message {string}")
    public void admin_convert_order_in_bulk_ghost_order_to_real_order_and_see_message(String actor, String message) {
        theActorCalled(actor).attemptsTo(
                HandleGhostOrders.convertOrder(),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }
}

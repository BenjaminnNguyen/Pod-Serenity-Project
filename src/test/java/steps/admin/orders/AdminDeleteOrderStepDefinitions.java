package steps.admin.orders;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.orders.HandleDeletedOrders;
import cucumber.tasks.admin.orders.HandleOrders;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.AllOrdersForm;
import cucumber.user_interface.admin.orders.DeletedOrderPage;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.JavaScript;
import org.openqa.selenium.JavascriptExecutor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.CoreMatchers.containsString;

public class AdminDeleteOrderStepDefinitions {
    @And("Admin search the orders deleted by info")
    public void admin_search_the_order_deleted_by_info(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>(infos.get(0));
        String idInvoice = null;
        if (infos.get(0).get("orderNumber").isEmpty()) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            idInvoice = idInvoice.substring(7);
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "");
        }
        if (infos.get(0).get("orderNumber").contains("create by admin")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order");
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "create by admin");
        }
        if (infos.get(0).get("orderNumber").contains("create by api")) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "create by api");
        }
        if (infos.get(0).get("orderNumber").contains("empty")) {
            idInvoice = "";
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "empty");
        }
        if (infos.get(0).get("orderNumber").contains("sub")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order").toString() + infos.get(0).get("sub");
            info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "sub");
        }
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleDeletedOrders.searchByInfo(info)
        );
    }

    @And("Admin verify result order in deleted order")
    public void verify_result_order_in_deleted_order(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        String idInvoice = null;
        // check empty do tạo order từ multiple order không lấy được order number
        HashMap<String, String> info = new HashMap<>();
        if (expected.get(0).get("order").equals("empty")) {
            idInvoice = "";
            info = CommonTask.setValue(expected.get(0), "order", expected.get(0).get("order"), idInvoice, "empty");
        } else {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            info = CommonTask.setValue(expected.get(0), "order", expected.get(0).get("order"), idInvoice.substring(7), "random");
            info = CommonTask.setValue(info, "order", info.get("order"), Serenity.sessionVariableCalled("ID Invoice").toString(), "create by api");
        }

        theActorInTheSpotlight().attemptsTo(
                Check.whether(info.get("order").equals("empty"))
                        .otherwise(Ensure.that(AllOrdersForm.ORDER_RESULT).text().contains(info.get("order"))),
                Ensure.that(AllOrdersForm.CHECKOUT_RESULT).text().contains(CommonHandle.setDate(expected.get(0).get("checkout"), "MM/dd/yy")),
                Ensure.that(AllOrdersForm.BUYER_RESULT).attribute("data-original-text").contains(expected.get(0).get("buyer")),
                Ensure.that(AllOrdersForm.STORE_RESULT).text().contains(expected.get(0).get("store")),
                Ensure.that(AllOrdersForm.REGION_RESULT).text().contains(expected.get(0).get("region")),
                Ensure.that(AllOrdersForm.TOTAL_RESULT).text().contains(expected.get(0).get("total")),
                Ensure.that(AllOrdersForm.VENDOR_FEE_RESULT).text().contains(expected.get(0).get("vendorFee")),
                Ensure.that(AllOrdersForm.BUYER_PAYMENT_RESULT).text().contains(expected.get(0).get("buyerPayment")),
                Ensure.that(AllOrdersForm.FULFILLMENT_RESULT).text().contains(expected.get(0).get("fulfillment")),
                Ensure.that(AllOrdersForm.VENDOR_PAYMENT_RESULT).text().contains(expected.get(0).get("vendorPayment"))
        );
        if (info.containsKey("financePending")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllOrdersForm.PENDING_FINANCE_APPROVAL).isDisplayed()
            );
        }
        if (info.containsKey("creator")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllOrdersForm.CREATOR_RESULT).text().contains(info.get("creator"))
            );
        }
        if (info.containsKey("customerPO")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllOrdersForm.CUSTOMER_PO_RESULT).text().contains(info.get("customerPO"))
            );
        }
    }

    @And("Admin go to order deleted detail number {string}")
    public void admin_go_to_order_deleted_detail_after_search(String number) {
        String idInvoice = number;
        if (number.contains("create")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order");
        }
        // lấy ID để search Orders
        theActorInTheSpotlight().attemptsTo(
                HandleDeletedOrders.seeDetail(idInvoice)
        );
    }

    @And("Admin verify general information of order deleted detail")
    public void admin_verify_gereral_information_of_order_deleted_detail(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Check.whether(list.get(0).get("customerPo").isEmpty())
                        .otherwise(Ensure.that(DeletedOrderPage.GENERAL_CUSTOM_PO_FIELD).text().contains(list.get(0).get("customerPo"))),
                Ensure.that(DeletedOrderPage.GENERAL_DATE).text().contains(CommonHandle.setDate2(list.get(0).get("date"), "MM/dd/yy")),
                Ensure.that(DeletedOrderPage.GENERAL_REGION).text().contains(list.get(0).get("region")),
                Ensure.that(DeletedOrderPage.GENERAL_BUYER).text().contains(list.get(0).get("buyer")),
                Ensure.that(DeletedOrderPage.GENERAL_STORE).text().contains(list.get(0).get("store")),
                Ensure.that(DeletedOrderPage.GENERAL_CREATOR).text().contains(list.get(0).get("creator")),
                Ensure.that(DeletedOrderPage.GENERAL_DELETED_BY).text().contains(list.get(0).get("deletedBy")),
                Ensure.that(DeletedOrderPage.GENERAL_DELETED_ON).text().contains(CommonHandle.setDate2(list.get(0).get("deletedOn"), "MM/dd/yy")),
                Ensure.that(DeletedOrderPage.GENERAL_BUYER_PAYMENT).text().contains(list.get(0).get("buyerPayment")),
                Ensure.that(DeletedOrderPage.GENERAL_PAYMENT_TYPE).text().contains(list.get(0).get("paymentType")),
                Ensure.that(DeletedOrderPage.GENERAL_PAYMENT_DATE).text().contains(list.get(0).get("paymentDate")),
                Ensure.that(DeletedOrderPage.GENERAL_VENDOR_PAYMENT).text().contains(list.get(0).get("vendorPayment")),
                Ensure.that(DeletedOrderPage.GENERAL_FULFILLMENT).text().contains(list.get(0).get("fulfillment")),
                Ensure.that(DeletedOrderPage.GENERAL_SHOW_ON_VENDOR(list.get(0).get("showOnVendor"))).text().contains(list.get(0).get("showOnVendor"))
        );
        if (list.get(0).containsKey("deleteReason")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(DeletedOrderPage.GENERAL_DELETED_REASON).text().contains(list.get(0).get("deleteReason"))
            );
        }
        if (list.get(0).containsKey("deleteNote")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(DeletedOrderPage.GENERAL_DELETED_NOTE).text().contains(list.get(0).get("deleteNote"))
            );
        }

    }

    @And("Admin verify price in order deleted details")
    public void admin_verify_price_in_order_deleted_details(DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(DeletedOrderPage.GENERAL_ORDER_VALUE), containsString(list.get(0).get("orderValue"))),
                seeThat(CommonQuestions.targetText(DeletedOrderPage.GENERAL_DISCOUNT), containsString(list.get(0).get("discount"))),
                seeThat(CommonQuestions.targetText(DeletedOrderPage.GENERAL_TAXES), containsString(list.get(0).get("taxes"))),
                seeThat(CommonQuestions.targetText(DeletedOrderPage.GENERAL_SOS), containsString(list.get(0).get("smallOrderSurcharge"))),
                seeThat(CommonQuestions.targetText(DeletedOrderPage.GENERAL_FS), containsString(list.get(0).get("fuelSurcharge"))),
                seeThat(CommonQuestions.targetText(DeletedOrderPage.GENERAL_TOTAL_PAYMENT), containsString(list.get(0).get("total"))),
                seeThat(CommonQuestions.targetText(DeletedOrderPage.GENERAL_VENDOR_SERVICE_FEE), containsString(list.get(0).get("vendorServiceFee")))
        );
    }

    @And("Admin check line items non invoice in order deleted details")
    public void admin_check_line_item_non_invoice_in_order_detail(DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> info = CommonTask.setValueRandom(list.get(i), "sku", Serenity.sessionVariableCalled("SKU inventory"));
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(DeletedOrderPage.LINE_ITEM_BRAND("group non-invoice-group", i + 1)).attribute("data-original-text").contains(list.get(i).get("brand")),
                    Ensure.that(DeletedOrderPage.LINE_ITEM_PRODUCT("group non-invoice-group", i + 1)).attribute("data-original-text").contains(list.get(i).get("product")),
                    Ensure.that(DeletedOrderPage.LINE_ITEM_SKU("group non-invoice-group", i + 1)).attribute("data-original-text").contains(info.get("sku")),
                    Ensure.that(DeletedOrderPage.LINE_ITEM_SKU_ID("group non-invoice-group", i + 1)).text().contains(info.get("skuID")),
                    Ensure.that(DeletedOrderPage.LINE_ITEM_CASE_PRICE("group non-invoice-group", i + 1)).text().contains(list.get(i).get("casePrice")),
                    Ensure.that(DeletedOrderPage.LINE_ITEM_CASE_UNIT("group non-invoice-group", i + 1)).text().contains(list.get(i).get("caseUnit")),
                    Ensure.that(DeletedOrderPage.LINE_ITEM_QUANTITY("group non-invoice-group", i + 1)).text().contains(list.get(i).get("quantity")),
                    Check.whether(list.get(i).get("endQuantity").isEmpty())
                            .otherwise(Ensure.that(DeletedOrderPage.LINE_ITEM_END_QUANTITY("group non-invoice-group", i + 1)).text().contains(list.get(i).get("endQuantity"))),
                    Ensure.that(DeletedOrderPage.LINE_ITEM_TOTAL("group non-invoice-group", i + 1)).text().contains(list.get(i).get("total")),
                    Ensure.that(DeletedOrderPage.LINE_ITEM_FULFILLMENT_DATE("group non-invoice-group", i + 1)).isDisplayed(),
                    Check.whether(list.get(i).get("distribution").equals("Yes"))
                            .andIfSo(Ensure.that(DeletedOrderPage.LINE_ITEM_DISTRIBUTION_CENTER("group non-invoice-group", i + 1)).isDisplayed())
            );
        }
    }

    @And("Admin verify vendor payment in order deleted details")
    public void admin_verify_vendor_payment_in_order_detail(DataTable price) {
        List<Map<String, String>> list = price.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(DeletedOrderPage.VENDOR_PAYMENT_PRODUCT).text().contains(list.get(0).get("product")),
                Ensure.that(DeletedOrderPage.VENDOR_PAYMENT_FULFILLMENT).text().contains(list.get(0).get("fulfillment")),
                Ensure.that(DeletedOrderPage.VENDOR_PAYMENT_PAYMENT_STATE).text().contains(list.get(0).get("paymentState")),
                Ensure.that(DeletedOrderPage.VENDOR_PAYMENT_VALUE).text().contains(list.get(0).get("value")),
                Ensure.that(DeletedOrderPage.VENDOR_PAYMENT_DISCOUNT).text().contains(list.get(0).get("discount")),
                Ensure.that(DeletedOrderPage.VENDOR_PAYMENT_SERVICE_FEE).text().contains(list.get(0).get("serviceFee")),
                Ensure.that(DeletedOrderPage.VENDOR_PAYMENT_ADDITIONAL_FEE).text().contains(list.get(0).get("additionalFee")),
                Ensure.that(DeletedOrderPage.VENDOR_PAYMENT_PAID_TO_VENDOR).text().contains(list.get(0).get("paidToVendor")),
                Ensure.that(DeletedOrderPage.VENDOR_PAYMENT_PAYOUT_DATE).text().contains(list.get(0).get("payoutDate")),
                Ensure.that(DeletedOrderPage.VENDOR_PAYMENT_PAYMENT_TYPE).text().contains(list.get(0).get("payoutType"))
        );

    }

    @And("Admin verify how to use button detail")
    public void admin_verify_how_to_use_button_detail() {

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("How to use")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("How to use")),
                CommonWaitUntil.isVisible(DeletedOrderPage.HOW_TO_USE_EDIT_BUTTON),
                // Edit instruction how to use
                Click.on(DeletedOrderPage.HOW_TO_USE_EDIT_BUTTON),
                CommonWaitUntil.isVisible(DeletedOrderPage.EDIT_INSTRUCTION_POPUP),
                WindowTask.threadSleep(2000),
//                Click.on(DeletedOrderPage.TEST),
                WindowTask.addTextToCodeMirror("Test123123", DeletedOrderPage.EDIT_INSTRUCTION_TEXTBOX),
                WindowTask.threadSleep(1000),
                Click.on(DeletedOrderPage.EDIT_INSTRUCTION_UPDATE_BUTTON),
                // Verify
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("How to use")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("How to use")),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Test123123"))
        );
    }

    @And("Admin verify ETA email not set is not display in delete order detail")
    public void admin_verify_eta_not_set() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(OrderDetailPage.ETA_NOT_SET)
        );
    }

    @And("Admin check sub invoice of order {string} in delete order detail")
    public void check_Sub_Invoice(String order, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        String subInvoice = null;
        for (Map<String, String> item : list) {
            if (order.equals("create by api")) {
                subInvoice = Serenity.sessionVariableCalled("ID Order").toString() + item.get("sub");
            }

            theActorInTheSpotlight().attemptsTo(
                    Check.whether(item.get("eta").isEmpty())
                            .otherwise(Ensure.that(OrderDetailPage.SUB_INVOICE_ETA(subInvoice)).attribute("value").contains(CommonHandle.setDate2(item.get("eta"), "MM/dd/yy"))),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_PAYMENT_STATUS(subInvoice)).text().contains(item.get("paymentStatus")),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_TOTAL(subInvoice)).text().contains(item.get("total")),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_TOTAL_QUANTITY(subInvoice)).text().contains(item.get("totalQuantity")),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_TOTAL_WEIGHT(subInvoice)).text().contains(item.get("totalWeight")),
                    Ensure.that(OrderDetailPage.SUB_INVOICE_FULFILLMENT_STATUS(subInvoice)).text().contains(item.get("fulfillmentStatus"))

            );
            if (item.get("markFulfill").equals("Yes")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(OrderDetailPage.SUB_INVOICE_MARK_FULFILL(subInvoice)).isDisplayed()
                );
            }
            if (item.get("markFulfill").equals("No")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(OrderDetailPage.SUB_INVOICE_MARK_FULFILL(subInvoice)).isNotDisplayed()
                );
            }
        }
    }

    /**
     * Export order
     */
    @And("Admin export delete order detail")
    public void export_delete_order_detail() {
        String fileName = Serenity.sessionVariableCalled("ID Order API") + "-" + Serenity.sessionVariableCalled("Number Order API") + "-" + CommonHandle.setDate2("currentDate", "MM_dd_yy") + ".csv";
        Serenity.setSessionVariable("Filename Delete Order Detail CSV").to(fileName);
        theActorInTheSpotlight().attemptsTo(
                HandleDeletedOrders.exportDetail(fileName)
        );
    }
}

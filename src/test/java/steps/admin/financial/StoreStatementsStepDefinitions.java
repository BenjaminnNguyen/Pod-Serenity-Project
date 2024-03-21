package steps.admin.financial;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.user_interface.admin.financial.VendorStatementsDetailPage;
import io.cucumber.java.en.*;
import cucumber.tasks.admin.financial.HandleStoreStatements;
import cucumber.tasks.admin.financial.HandleVendorStatements;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.financial.storestatements.StoreStatementsDetailPage;
import cucumber.user_interface.admin.financial.storestatements.StoreStatementsPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;
import org.openqa.selenium.Keys;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.*;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class StoreStatementsStepDefinitions {
    @And("Admin search store statements")
    public void admin_search_store_statements(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "buyerCompany", infos.get(0).get("buyerCompany"), Serenity.sessionVariableCalled("Onboard Name Company"), "onboard");
        theActorInTheSpotlight().attemptsTo(
                HandleStoreStatements.search(info)
        );
    }

    @And("Admin go to detail of store statement {string}")
    public void admin_go_to_detail_of_store_statements(String storeStatement) {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreStatements.goToDetail(storeStatement)
        );
    }

    @And("Admin verify payment after record in bottom of store statements detail")
    public void admin_verify_payment_in_bottom_of_store_statements(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        String id = Serenity.sessionVariableCalled("Sub-invoice ID create by admin");
        String index = "1";

        if (info.get(0).get("type").equals("Unapplied Payment")) {
            index = "2";
        }
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(StoreStatementsDetailPage.D_ROW_RESULT(id, index)).text().isEqualTo(info.get(0).get("type")),
                Ensure.that(StoreStatementsDetailPage.D_CHECKOUT_RESULT(id, index)).text().isEqualTo(CommonHandle.setDate(info.get(0).get("checkout"), "MM/dd/yy")),
                Ensure.that(StoreStatementsDetailPage.D_DELIVERY_RESULT(id, index)).text().isEqualTo(CommonHandle.setDate(info.get(0).get("deliveryDate"), "MM/dd/yy")),
                Ensure.that(StoreStatementsDetailPage.D_BUYER_RESULT(id, index)).text().isEqualTo(info.get(0).get("buyer")),
                Ensure.that(StoreStatementsDetailPage.D_STATUS_RESULT(id, index)).text().isEqualTo(info.get(0).get("status")),
                Ensure.that(StoreStatementsDetailPage.D_DESCRIPTION_RESULT(id, index)).text().isEqualTo(info.get(0).get("description")),
                Ensure.that(StoreStatementsDetailPage.D_ORDER_VALUE_RESULT(id, index)).text().isEqualTo(info.get(0).get("orderValue")),
                Ensure.that(StoreStatementsDetailPage.D_DISCOUNT_RESULT(id, index)).text().isEqualTo(info.get(0).get("discount")),
                Ensure.that(StoreStatementsDetailPage.D_DEPOSIT_RESULT(id, index)).text().isEqualTo(info.get(0).get("deposit")),
                Ensure.that(StoreStatementsDetailPage.D_FEE_RESULT(id, index)).text().isEqualTo(info.get(0).get("fee")),
                Ensure.that(StoreStatementsDetailPage.D_MEMO_RESULT(id, index)).text().isEqualTo(info.get(0).get("credit")),
                Ensure.that(StoreStatementsDetailPage.D_PAYMENT_RESULT(id, index)).text().isEqualTo(info.get(0).get("pymt")),
                Ensure.that(StoreStatementsDetailPage.D_TOTAL_RESULT(id, index)).text().isEqualTo(info.get(0).get("total"))
        );
        if (info.contains("aging")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(StoreStatementsDetailPage.D_AGING_RESULT(id, index)).text().isEqualTo(info.get(0).get("aging"))
            );
        }
    }

    @And("Admin get id of Unapplied payment after record payment success")
    public void amin_get_id_of_Unapplied_payment_after_record_payment_success() {
        String id = Serenity.sessionVariableCalled("Sub-invoice ID create by admin");
        String idRow = StoreStatementsDetailPage.ROW_UNAPPLIED_PAYMENT(id).resolveFor(theActorInTheSpotlight()).getAttribute("data-id").trim();
        System.out.println("ID " + idRow);
        Serenity.setSessionVariable("ID Unapplied Payment").to(idRow);

    }

    @And("Admin add record payment")
    public void admin_add_record_payment(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(infos.get(0), "orderID", Serenity.sessionVariableCalled("Sub-invoice ID create by admin"));
        info = CommonTask.setValueRandom(info, "creditMemos", Serenity.sessionVariableCalled("ID Credit Memo"));
        // nếu 1 order có nhiều sub invoice
        if (infos.get(0).get("orderID").length() == 1) {
            info = CommonTask.setValue(infos.get(0), "orderID", infos.get(0).get("orderID"), Serenity.sessionVariableCalled("ID Order") + infos.get(0).get("orderID"), infos.get(0).get("orderID"));
        }
        // nếu có nhiều order được tạo bởi api
        if (infos.get(0).get("orderID").contains("index")) {
            info = CommonTask.setValue2(infos.get(0), "orderID", infos.get(0).get("orderID"), Serenity.sessionVariableCalled("Number Order API" + infos.get(0).get("orderID").substring(5)).toString() + infos.get(0).get("sub"), infos.get(0).get("orderID"));
        }

        theActorInTheSpotlight().attemptsTo(
                HandleStoreStatements.goToRecordPayment(),
                HandleStoreStatements.addRecordPayment(info)
        );
    }

    @And("Admin verify summary in popup record payment")
    public void admin_verify_summary_in_popup_record_payment(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(StoreStatementsDetailPage.ADJUSTMENT_IN_SUM).text().isEqualTo(expected.get(0).get("adjustment")),
                Ensure.that(StoreStatementsDetailPage.SUBINVOICE_IN_SUM).text().isEqualTo(expected.get(0).get("subinvoice")),
                Ensure.that(StoreStatementsDetailPage.CREDIT_MEMO_IN_SUM).text().isEqualTo(expected.get(0).get("memo")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_PAYMENT_IN_SUM).text().isEqualTo(expected.get(0).get("unapplied")),
                Ensure.that(StoreStatementsDetailPage.PAYMENT_IN_SUM).text().isEqualTo(expected.get(0).get("payment")),
                Ensure.that(StoreStatementsDetailPage.TOTAL_IN_SUM).text().isEqualTo(expected.get(0).get("net"))
        );
    }

    @And("Admin add record payment success")
    public void admin_add_record_payment_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreStatements.addRecordPaymentSuccess(),
                HandleVendorStatements.closeAlertPopup()
        );
    }

    @And("Admin add record payment error")
    public void admin_add_record_payment_error() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(StoreStatementsPage.COMPLETE_RECORD_PAYMENT).isDisabled()
        );
    }

    @And("Admin verify unapplied payment in {string} of store statements detail of {string} month")
    public void admin_verify_payment_in_middle_of_store_statements(String type, String month, DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        String id = Serenity.sessionVariableCalled("ID Unapplied Payment");
        if (month.equals("previous")) {
            id = Serenity.sessionVariableCalled("ID Unapplied Payment Previous Month");
        }

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE(type, id, "id")).text().isEqualTo(info.get(0).get("type")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE_2(type, id, "checkout")).text().isEqualTo(CommonHandle.setDate(info.get(0).get("checkout"), "MM/dd/yy")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE_2(type, id, "delivery-date")).text().isEqualTo(CommonHandle.setDate(info.get(0).get("deliveryDate"), "MM/dd/yy")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE_2(type, id, "buyer")).text().isEqualTo(info.get(0).get("buyer")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE_3(type, id, "status")).text().isEqualTo(info.get(0).get("status")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE_2(type, id, "aging")).text().isEqualTo(info.get(0).get("aging")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE_2(type, id, "description")).text().isEqualTo(info.get(0).get("description")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE_2(type, id, "tr order-value")).text().isEqualTo(info.get(0).get("orderValue")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE_2(type, id, "tr discount")).text().isEqualTo(info.get(0).get("discount")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE_2(type, id, "tr deposit")).text().isEqualTo(info.get(0).get("deposit")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE_2(type, id, "tr fee")).text().isEqualTo(info.get(0).get("fee")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE_2(type, id, "tr memo")).text().isEqualTo(info.get(0).get("credit")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE_2(type, id, "tr payment")).text().isEqualTo(info.get(0).get("pymt")),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_RESULT_MIDDLE_2(type, id, "tr total")).text().isEqualTo(info.get(0).get("total"))
        );
    }

    @And("Admin add an adjustment")
    public void admin_add_an_adjustment(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(infos.get(0), "subInvoice", Serenity.sessionVariableCalled("Sub-invoice ID create by admin"));

        theActorInTheSpotlight().attemptsTo(
                HandleStoreStatements.goToAddAdjustment(),
                HandleStoreStatements.addAnAdjustment(info)
        );
    }

    @And("Admin verify {string} in {string} of store statements details")
    public void admin_verify_info_in_store_statements(String check, String type, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>();
        for (Map<String, String> item : infos) {
            if (item.containsKey("skuName")) {
                info = CommonTask.setValueRandom(item, "orderID", Serenity.sessionVariableCalled("Sub-invoice ID create by admin" + item.get("skuName")));
            } else {
                switch (check) {
                    case "credit memo":
                        info = CommonTask.setValueRandom(item, "orderID", Serenity.sessionVariableCalled("ID Credit Memo"));
                        break;
                    case "sub invoice":
                        info = CommonTask.setValueRandom(item, "orderID", Serenity.sessionVariableCalled("Sub-invoice ID create by admin"));
                        break;
                    case "adjustment":
                        info = CommonTask.setValueRandom(item, "orderID", infos.get(0).get("orderID"));
                        break;
                }
            }

            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(StoreStatementsDetailPage.INVOICE_RESULT(type, info.get("orderID"))),
                    Scroll.to(StoreStatementsDetailPage.INVOICE_RESULT(type, info.get("orderID"))),
                    Ensure.that(StoreStatementsDetailPage.INVOICE_RESULT(type, info.get("orderID"))).isDisplayed(),
                    Ensure.that(StoreStatementsDetailPage.CHECKOUT_RESULT(type, info.get("orderID"))).text().isEqualTo(CommonHandle.setDate2(info.get("checkout"), "MM/dd/yy")),
                    Ensure.that(StoreStatementsDetailPage.DELIVERY_RESULT(type, info.get("orderID"))).text().isEqualTo(CommonHandle.setDate2(info.get("deliveryDate"), "MM/dd/yy")),
                    Ensure.that(StoreStatementsDetailPage.BUYER_RESULT(type, info.get("orderID"))).text().isEqualTo(info.get("buyer")),
                    Ensure.that(StoreStatementsDetailPage.STATUS_RESULT(type, info.get("orderID"))).text().isEqualTo(info.get("status")),
                    Ensure.that(StoreStatementsDetailPage.DESCRIPTION_RESULT(type, info.get("orderID"))).text().isEqualTo(info.get("description")),
                    Ensure.that(StoreStatementsDetailPage.ORDERVALUE_RESULT(type, info.get("orderID"))).text().isEqualTo(info.get("orderValue")),
                    Ensure.that(StoreStatementsDetailPage.DISCOUNT_RESULT(type, info.get("orderID"))).text().isEqualTo(info.get("discount")),
                    Ensure.that(StoreStatementsDetailPage.DEPOSIT_RESULT(type, info.get("orderID"))).text().isEqualTo(info.get("deposit")),
                    Ensure.that(StoreStatementsDetailPage.FEE_RESULT(type, info.get("orderID"))).text().isEqualTo(info.get("fee")),
                    Ensure.that(StoreStatementsDetailPage.MEMO_RESULT(type, info.get("orderID"))).text().isEqualTo(info.get("credit")),
                    Ensure.that(StoreStatementsDetailPage.PAYMENT_RESULT(type, info.get("orderID"))).text().isEqualTo(info.get("pymt")),
                    Ensure.that(StoreStatementsDetailPage.TOTAL_RESULT(type, info.get("orderID"))).text().isEqualTo(info.get("total"))
            );
            if (info.containsKey("aging")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(StoreStatementsDetailPage.AGING_RESULT(type, info.get("orderID"))).text().isEqualTo(info.get("aging"))
                );
            }
        }
    }

    @And("Admin verify sum of {string} in {string} of store statements details")
    public void admin_verify_sum_of_order_value(String type, String value) {
        String classTotal = null;
        switch (type) {
            case "order-value":
                classTotal = "order-value";
                break;
            case "deposit":
                classTotal = "deposit";
                break;
            case "fee":
                classTotal = "fee";
                break;
            case "memo":
                classTotal = "credit";
                break;
            case "payment":
                classTotal = "payment";
                break;
            case "total":
                classTotal = "due";
                break;

        }
        String price = null;
        Integer sumPrice = 0;
        // List element của cột giá tiền
        List<WebElementFacade> listPositive = StoreStatementsDetailPage.LIST_VALUE(value, type).resolveAllFor(theActorInTheSpotlight());
        for (WebElementFacade item : listPositive) {
            //giá tiền của từng dòng trong bảng
            price = item.getText();
            if (!price.isEmpty()) {
                // giá tiền âm hoặc dương
                if (price.contains(",")) {
                    price = price.replaceAll(",", "");
                }
                int priceTemp = Integer.parseInt(price.substring(price.indexOf("$") + 1, price.indexOf(".")));
                if (price.contains("(")) { // giá âm thì trừ
                    sumPrice = sumPrice - priceTemp;
                } else { // giá dương thị cộng
                    sumPrice = sumPrice + priceTemp;
                }
            }
        }
        if (sumPrice < 0) {
            sumPrice = Math.abs(sumPrice);
        }
        String priceVerify = String.format("%,8d%n", sumPrice);

        DecimalFormat df = new DecimalFormat("###,###,###");
        df.format(sumPrice);

        System.out.print("Sum of price positive" + priceVerify);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(StoreStatementsDetailPage.LIST_TOTAL_VALUE(value, classTotal)).text().contains("$" + df.format(sumPrice).toString().trim() + ".00")
        );
    }

    @And("Admin verify {string} in {string} of store statements details is disable")
    public void admin_verify_info_in_store_statements_is_disable(String check, String type) {
        if (check.equals("random")) {
            check = Serenity.sessionVariableCalled("Sub-invoice ID create by admin");
        }
        theActorInTheSpotlight().attemptsTo(
                Scroll.to(StoreStatementsDetailPage.ROW_DISABLE(type, check)),
                Ensure.that(StoreStatementsDetailPage.INVOICE_RESULT(type, check)).isDisplayed()
        );
    }

    @And("Admin get id of unapplied payment previous month")
    public void admin_verify_info_in_store_statements_is_disable() {
        // get ID của Unapplied payment để check trên line middle
        String idOrder = Serenity.sessionVariableCalled("Sub-invoice ID create by admin");
        String idRow = StoreStatementsDetailPage.ROW_UNAPPLIED_PAYMENT_PREVIOUS(idOrder).resolveFor(theActorInTheSpotlight()).getAttribute("data-id").trim();
        System.out.println("ID " + idRow);
        Serenity.setSessionVariable("ID Unapplied Payment Previous Month").to(idRow);
    }

    @And("Admin verify {string} after record in {string} of store statements detail of previous month")
    public void admin_verify_payment_in_bottom_of_store_statements_of_previous_month(String type, String position, DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        if (type.equals("Payment")) {
            type = "Applied";
        }
        if (type.equals("Unapplied Payment")) {
            type = "Unapplied";
        }
        theActorInTheSpotlight().attemptsTo(
                Scroll.to(StoreStatementsDetailPage.UNAPPLIED_ID_PREVIOUS(position, type)),
                Ensure.that(StoreStatementsDetailPage.UNAPPLIED_ID_PREVIOUS(position, type)).text().isEqualTo(info.get(0).get("type")),
                Ensure.that(StoreStatementsDetailPage.D_PREVIOUS(position, type, "checkout")).text().isEqualTo(CommonHandle.setDate(info.get(0).get("checkout"), "MM/dd/yy")),
                Ensure.that(StoreStatementsDetailPage.D_PREVIOUS(position, type, "delivery-date")).text().isEqualTo(CommonHandle.setDate(info.get(0).get("deliveryDate"), "MM/dd/yy")),
                Ensure.that(StoreStatementsDetailPage.D_PREVIOUS(position, type, "buyer")).text().isEqualTo(info.get(0).get("buyer")),
                Check.whether(type.equals("Unapplied"))
                        .andIfSo(Ensure.that(StoreStatementsDetailPage.STATUS_ID_PREVIOUS(position, type)).text().isEqualTo(info.get(0).get("status"))
                        ),
                Ensure.that(StoreStatementsDetailPage.D_PREVIOUS(position, type, "aging")).text().isEqualTo(info.get(0).get("aging")),
                Ensure.that(StoreStatementsDetailPage.D_PREVIOUS(position, type, "description")).text().isEqualTo(info.get(0).get("description")),
                Ensure.that(StoreStatementsDetailPage.D_PREVIOUS(position, type, "tr order-value")).text().isEqualTo(info.get(0).get("orderValue")),
                Ensure.that(StoreStatementsDetailPage.D_PREVIOUS(position, type, "tr discount")).text().isEqualTo(info.get(0).get("discount")),
                Ensure.that(StoreStatementsDetailPage.D_PREVIOUS(position, type, "tr deposit")).text().isEqualTo(info.get(0).get("deposit")),
                Ensure.that(StoreStatementsDetailPage.D_PREVIOUS(position, type, "tr fee")).text().isEqualTo(info.get(0).get("fee")),
                Ensure.that(StoreStatementsDetailPage.D_PREVIOUS(position, type, "tr memo")).text().isEqualTo(info.get(0).get("credit")),
                Ensure.that(StoreStatementsDetailPage.D_PREVIOUS(position, type, "tr payment")).text().isEqualTo(info.get(0).get("pymt")),
                Ensure.that(StoreStatementsDetailPage.D_PREVIOUS(position, type, "tr total")).text().isEqualTo(info.get(0).get("total"))
        );
    }

    @And("{word} wait to payment paid after run job sidekiq")
    public void admin_wait_to_payment_paid_after_run_job_sidekiq(String actor) {
        String id = Serenity.sessionVariableCalled("Sub-invoice ID create by admin");
        String status = Text.of(StoreStatementsDetailPage.STATUS_RESULT("bottom", id)).answeredBy(theActorInTheSpotlight()).toString();
        while (status.equals("Unpaid")) {
            status = Text.of(StoreStatementsDetailPage.STATUS_RESULT("bottom", id)).answeredBy(theActorInTheSpotlight()).toString();
            theActorCalled(actor).attemptsTo(
                    WindowTask.refeshBrowser(),
                    CommonWaitUntil.isVisible(CommonAdminForm.LOADING_SPINNER),
                    WindowTask.threadSleep(1000)
            );
        }

    }

    @And("Admin no found store statement in result")
    public void admin_no_found_store_statement_in_result() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(CommonAdminForm.NO_DATA_RESULT).isDisplayed()
        );
    }

    @And("Admin verify store statement in result")
    public void admin_verify_store_statement_in_result(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(StoreStatementsPage.STORE_IN_RESULT).text().contains(expected.get(0).get("store")),
                Ensure.that(StoreStatementsPage.MONTH_IN_RESULT).text().contains(CommonHandle.setDate2(expected.get(0).get("month"), "MM/yyyy")),
                Check.whether(expected.get(0).get("beginningBalance").isEmpty())
                        .otherwise(Ensure.that(StoreStatementsPage.BEGINNING_IN_RESULT).text().contains(expected.get(0).get("beginningBalance"))),
                Check.whether(expected.get(0).get("endingBalance").isEmpty())
                        .otherwise(Ensure.that(StoreStatementsPage.ENDING_IN_RESULT).text().contains(expected.get(0).get("endingBalance")))
        );
        String idStore = Text.of(StoreStatementsPage.ID_IN_RESULT).answeredBy(theActorInTheSpotlight()).toString();
        Serenity.setSessionVariable("ID StoreStatement").to(idStore);
    }

    @And("Admin verify field Statement month criteria")
    public void admin_verify_field_statement_month_criteria() {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Click.on(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("statement_month")),
                CommonWaitUntil.isVisible(CommonAdminForm.DATE_PICKER_HEADER),
                Ensure.that(CommonAdminForm.DATE_PICKER_HEADER).text().contains("2023"),
                Click.on(CommonAdminForm.PREVIOUS_YEAR_DATE_PICKER),
                Ensure.that(CommonAdminForm.DATE_PICKER_HEADER).text().contains("2022"),
                Click.on(CommonAdminForm.NEXT_YEAR_DATE_PICKER),
                Click.on(CommonAdminForm.NEXT_YEAR_DATE_PICKER),
                Ensure.that(CommonAdminForm.DATE_PICKER_HEADER).text().contains("2024"),
                CommonTask.pressESC()
        );
    }

    @And("Admin verify header-bar of statement detail {string} - {string}")
    public void admin_verify_header_bar_of_statement_detail(String store, String date) {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(StoreStatementsDetailPage.HEADER_BAR).text()
                        .contains("Store statement " + Serenity.sessionVariableCalled("ID StoreStatement").toString() + " — " + store + " – " + CommonHandle.setDate2(date, "MM/yyyy"))
        );
    }

    @And("Admin verify general information of statement detail")
    public void admin_verify_general_information_of_statement_detail(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(StoreStatementsDetailPage.STORE_IN_GENERAL_INFO(list.get(0).get("store"))),
                Ensure.that(StoreStatementsDetailPage.STORE_IN_GENERAL_INFO(list.get(0).get("store"))).text().contains(list.get(0).get("store")),
                Ensure.that(StoreStatementsDetailPage.STATEMENT_IN_GENERAL_INFO).text().contains(CommonHandle.setDate2(list.get(0).get("statementMonth"), "MM/yyyy"))
        );
    }

    @And("Admin verify top section of statement detail")
    public void admin_verify_top_section_of_statement_detail(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(StoreStatementsDetailPage.BEGINNING_BALANCE_TOP).text().contains(list.get(0).get("beginningBalance")),
                Ensure.that(StoreStatementsDetailPage.DELIVERED_ORDERS_TOP).text().contains(list.get(0).get("deliveredOrder")),
                Check.whether(list.get(0).get("payment").isEmpty())
                        .andIfSo(Ensure.that(StoreStatementsDetailPage.PAYMENT_TOP).text().contains(list.get(0).get("payment"))),
                Check.whether(list.get(0).get("payment").isEmpty())
                        .andIfSo(Ensure.that(StoreStatementsDetailPage.CREDIT_TOP).text().contains(list.get(0).get("credit"))),
                Ensure.that(StoreStatementsDetailPage.ENDING_BALANCE_TOP).text().contains(list.get(0).get("endingBalance"))
        );
    }

    @And("Admin verify electronic ACH in top section of statement detail")
    public void admin_verify_electronic_ach_top_section_of_statement_detail(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(StoreStatementsDetailPage.D_TOP_SECTION("bank-name")).text().contains(list.get(0).get("bank")),
                Ensure.that(StoreStatementsDetailPage.D_TOP_SECTION("bank-account-name")).text().contains(list.get(0).get("accountName")),
                Ensure.that(StoreStatementsDetailPage.D_TOP_SECTION("bank-routing-number")).text().contains(list.get(0).get("routingNumber")),
                Ensure.that(StoreStatementsDetailPage.D_TOP_SECTION("bank-account-number")).text().contains(list.get(0).get("accountNumber"))
        );
    }

    @And("Admin verify mail a check in top section of statement detail")
    public void admin_verify_mail_a_check_top_section_of_statement_detail(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(StoreStatementsDetailPage.D_TOP_SECTION("mail-name")).text().contains(list.get(0).get("name")),
                Ensure.that(StoreStatementsDetailPage.D_TOP_SECTION("mail-address")).text().contains(list.get(0).get("address")),
                Ensure.that(StoreStatementsDetailPage.D_TOP_SECTION("mail-city")).text().contains(list.get(0).get("city")),
                Ensure.that(StoreStatementsDetailPage.D_TOP_SECTION("mail-state-zip")).text().contains(list.get(0).get("state"))
        );
    }

    @And("Admin no found sub invoice in store statement detail")
    public void admin_verrify_no_found_sub_invoice_in_store_statement_detail() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(StoreStatementsDetailPage.INVOICE_RESULT("middle", Serenity.sessionVariableCalled("Sub-invoice ID create by admin"))).isNotDisplayed()
        );
    }

    @And("Admin no found sub invoice of SKU {string} in store statement detail")
    public void admin_verrify_no_found_sub_invoice_in_store_statement_detail(String skuName) {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(StoreStatementsDetailPage.INVOICE_RESULT("middle", Serenity.sessionVariableCalled("Sub-invoice ID create by admin" + skuName))).isNotDisplayed()
        );
    }

    @And("Admin verify {string} no found in {string} of store statements details")
    public void admin_verify_info_no_found_in_store_statements(String check, String type, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>();
        for (Map<String, String> item : infos) {
            if (item.containsKey("skuName")) {
                info = CommonTask.setValueRandom(item, "orderID", Serenity.sessionVariableCalled("Sub-invoice ID create by admin" + item.get("skuName")));
            } else {
                switch (check) {
                    case "credit memo":
                        info = CommonTask.setValueRandom(item, "orderID", Serenity.sessionVariableCalled("ID Credit Memo"));
                        break;
                    case "sub invoice":
                        info = CommonTask.setValueRandom(item, "orderID", Serenity.sessionVariableCalled("Sub-invoice ID create by admin"));
                        break;
                    case "adjustment":
                        info = CommonTask.setValueRandom(item, "orderID", infos.get(0).get("orderID"));
                        break;
                }
            }

            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(StoreStatementsDetailPage.INVOICE_RESULT(type, info.get("orderID"))).isNotDisplayed()
            );
        }

    }

    @And("Admin edit an adjustment")
    public void admin_edit_an_adjustment(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleStoreStatements.editAnAdjustment(infos.get(0))
        );
    }

    @And("Admin delete an adjustment")
    public void admin_delete_an_adjustment() {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreStatements.deleteAnAdjustment()
        );
    }

    @And("Admin no found adjustment with description {string} in store statement detail")
    public void admin_verrify_no_found_adjustment_in_store_statement_detail(String description) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(StoreStatementsDetailPage.ADJUSTMENT_BY_DESCRIPTION_RESULT(description)),
                Ensure.that(StoreStatementsDetailPage.ADJUSTMENT_BY_DESCRIPTION_RESULT(description)).isNotDisplayed()
        );
    }

    @And("Admin edit record payment")
    public void admin_edit_record_payment(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(infos.get(0), "orderID", Serenity.sessionVariableCalled("Sub-invoice ID create by admin"));
        info = CommonTask.setValueRandom(info, "creditMemos", Serenity.sessionVariableCalled("ID Credit Memo"));
        theActorInTheSpotlight().attemptsTo(
                HandleStoreStatements.addRecordPayment(info)
        );
    }

    @And("Admin verify adjustment type {string} in store statement")
    public void verify_adjustment_type_in_store_statement(String adjustmentType) {
        theActorInTheSpotlight().attemptsTo(
                HandleStoreStatements.goToAddAdjustment(),
                CommonTask.chooseItemInDropdownWithValueInput(StoreStatementsPage.D_TEXTBOX("Type"), adjustmentType, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(adjustmentType))
        );
    }

    @And("Admin verify field search uncheck all in edit visibility of store statement")
    public void admin_verify_field_search_uncheck_in_edit_visibility() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id")).isNotDisplayed(),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id")).isNotDisplayed(),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id")).isNotDisplayed(),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("statement_month")).isNotDisplayed(),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id")).isNotDisplayed(),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("manager_id")).isNotDisplayed()
        );
    }

    @And("Admin verify field search in edit visibility of store statement")
    public void admin_verify_field_search_in_edit_visibility() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id")).isDisplayed(),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id")).isDisplayed(),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id")).isDisplayed(),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("statement_month")).isDisplayed(),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id")).isDisplayed(),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("manager_id")).isDisplayed()
        );
    }

    @And("Admin verify search field after choose filter in store statements")
    public void admin_verify_search_field_after_choose_filter(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(2000),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id")).attribute("value").contains(infos.get(0).get("buyerCompany")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id")).attribute("value").contains(infos.get(0).get("store")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id")).attribute("value").contains(infos.get(0).get("buyer")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("statement_month")).attribute("value").contains(infos.get(0).get("statementMonth")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id")).attribute("value").contains(infos.get(0).get("region")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("manager_id")).attribute("value").contains(infos.get(0).get("managedBy"))
        );
    }




}

package steps.admin.financial;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.financial.HandleVendorStatements;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.user_interface.admin.financial.VendorStatementsDetailPage;
import cucumber.user_interface.admin.financial.VendorStatementsPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.equalToIgnoringCase;

public class VendorStatementsStepDefinitions {

    @And("Admin fill password to authen permission")
    public void admin_fill_password_to_authen_permission() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.authenPermission()
        );
    }

    @And("Admin search vendor statements")
    public void admin_search_vendor_statements(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleVendorStatements.search(infos.get(0))
        );
    }

    @And("Admin verify result vendor statements")
    public void admin_verify_result_vendor_statements(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorStatementsPage.VENDOR_COMPANY_RESULT(infos.get(0).get("vendorCompany"))).isDisplayed(),
                Ensure.that(VendorStatementsPage.MONTH_RESULT).text().contains(CommonHandle.setDate(infos.get(0).get("month"), "MM/yyyy")),
                Check.whether(infos.get(0).get("status").isEmpty())
                        .otherwise(Ensure.that(VendorStatementsPage.STATUS_RESULT).text().contains(infos.get(0).get("status"))),
                Check.whether(infos.get(0).get("beginningBalance").isEmpty())
                        .otherwise(Ensure.that(VendorStatementsPage.BEGINNING_BALANCE_RESULT).text().contains(infos.get(0).get("beginningBalance"))),
                Check.whether(infos.get(0).get("endingBalance").isEmpty())
                        .otherwise(Ensure.that(VendorStatementsPage.ENDING_BALANCE_RESULT).text().contains(infos.get(0).get("endingBalance")))
        );
    }

    @And("Admin go to detail of vendor statement {string}")
    public void admin_go_to_detail_of_vendor_statement(String vendorCompany) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.goToDetail(vendorCompany)
        );
    }

    @And("Admin check the order in list")
    public void checkTheOrder(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        String orderNumber = null;
        if (infos.get(0).get("number").equals("create by api")) {
            orderNumber = Serenity.sessionVariableCalled("ID Order");
        }
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(VendorStatementsDetailPage.ORDER_DETAIL(orderNumber, "order-date")), equalToIgnoringCase(CommonHandle.setDate(infos.get(0).get("orderDate"), "MM/dd/yy"))),
                seeThat(CommonQuestions.targetText(VendorStatementsDetailPage.DESCRIPION_DETAIL(orderNumber, "description")), equalToIgnoringCase(infos.get(0).get("description"))),
                seeThat(CommonQuestions.attributeText(VendorStatementsDetailPage.ORDER_DETAIL(orderNumber, "store"), "data-original-text"), equalToIgnoringCase(infos.get(0).get("store"))),
                seeThat(CommonQuestions.targetText(VendorStatementsDetailPage.ORDER_DETAIL(orderNumber, "order-value")), equalToIgnoringCase(infos.get(0).get("orderValue"))),
                seeThat(CommonQuestions.targetText(VendorStatementsDetailPage.ORDER_DETAIL(orderNumber, "service-fee")), equalToIgnoringCase(infos.get(0).get("serviceFee"))),
                seeThat(CommonQuestions.targetText(VendorStatementsDetailPage.ORDER_DETAIL(orderNumber, "net-payment")), equalToIgnoringCase(infos.get(0).get("netPayment")))
        );
    }

    @And("Admin choose order in vendor statements")
    public void admin_choose_order_in_vendor_statements(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        HashMap<String, String> info = null;
        String idInvoice;
        if (infos.get(0).get("orderID").isEmpty()) {
            idInvoice = Serenity.sessionVariableCalled("ID Invoice");
            idInvoice = idInvoice.substring(7);
            info = CommonTask.setValue(infos.get(0), "orderID", infos.get(0).get("orderID"), idInvoice, "");
        }
        if (infos.get(0).get("orderID").contains("create by admin")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order");
            info = CommonTask.setValue(infos.get(0), "orderID", infos.get(0).get("orderID"), idInvoice, "create by admin");
        }
        if (infos.get(0).get("orderID").contains("create by api")) {
            idInvoice = Serenity.sessionVariableCalled("ID Order");
            info = CommonTask.setValue(infos.get(0), "orderID", infos.get(0).get("orderID"), idInvoice, "create by api");
        }

        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.chooseOrderToPay(info.get("orderID"))
        );
    }

    @And("Admin choose all order in vendor statements")
    public void admin_choose_all_order_in_vendor_statements() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.chooseAllOrder()
        );
    }

    @And("Admin pay in vendor statements")
    public void admin_pay_in_vendor_statements(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        // set random vào description để tiện tìm xpath
        String description = CommonTask.randomAlphaNumeric(10);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "description", infos.get(0).get("description"), description, "random");
        Serenity.setSessionVariable("Payment Description").to(description);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.payMoney(info)
        );
    }

    @And("Admin pay error in vendor statements")
    public void admin_pay_error_in_vendor_statements(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.payMoneyError(infos.get(0))
        );
    }


    @And("Admin verify checkbox of order is disabled")
    public void admin_verify_checkbox_of_order_is_disable() {
        String order = Serenity.sessionVariableCalled("ID Invoice");
        order = order.substring(7);
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.isControlDisplay(VendorStatementsPage.ORDER_NUMBER_CHECKBOX_VERIFY(order)))
        );
    }

    @And("Admin verify general information vendor statement")
    public void admin_verify_general_information_vendor_statement(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorStatementsPage.VENDOR_COMPANY_FIELD).text().contains(infos.get(0).get("vendorCompany")),
                Ensure.that(VendorStatementsPage.STATEMENT_MONTH_FIELD).text().contains(CommonHandle.setDate(infos.get(0).get("statementMonth"), "MM/yyyy")),
                Check.whether(infos.get(0).get("paymentState").isEmpty())
                        .otherwise(Ensure.that(VendorStatementsPage.PAYMENT_STATE_FIELD).text().contains(infos.get(0).get("paymentState")))
        );
    }

    @And("Admin upload file {string} in Upload Adjustments in vendor statement")
    public void admin_go_to_upload_adjustment_in_vendor_statement(String file) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.uploadAdjustmentFile(file)
        );
    }

    @And("Admin verify upload adjustment csv popup")
    public void admin_verify_upload_adjustment_csv(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorStatementsPage.MONTH_UPLOAD_CSV(i + 1)).text().contains(infos.get(i).get("month")),
                    Check.whether(infos.get(i).get("vendorCompany").isEmpty())
                            .otherwise(Ensure.that(VendorStatementsPage.VENDOR_COMPANY_UPLOAD_CSV(i + 1)).text().contains(infos.get(i).get("vendorCompany"))),
                    Check.whether(infos.get(i).get("adjustmentType").isEmpty())
                            .otherwise(Ensure.that(VendorStatementsPage.ADJUSTMENT_TYPE_UPLOAD_CSV(i + 1)).text().contains(infos.get(i).get("adjustmentType"))),
                    Check.whether(infos.get(i).get("effectiveDate").isEmpty())
                            .otherwise(Ensure.that(VendorStatementsPage.EFFECTIVE_DATE_UPLOAD_CSV(i + 1)).text().contains(CommonHandle.setDate2(infos.get(i).get("effectiveDate"), "MM/dd/yy"))),
                    Check.whether(infos.get(i).get("description").isEmpty())
                            .otherwise(Ensure.that(VendorStatementsPage.DESCRIPTION_UPLOAD_CSV(i + 1)).text().contains(infos.get(i).get("description"))),
                    Check.whether(infos.get(i).get("amount").isEmpty())
                            .otherwise(Ensure.that(VendorStatementsPage.AMOUNT_UPLOAD_CSV(i + 1)).text().contains(infos.get(i).get("amount"))),
                    Check.whether(infos.get(i).get("error").isEmpty())
                            .otherwise(Ensure.that(VendorStatementsPage.ERROR_UPLOAD_CSV(i + 1)).text().contains(infos.get(i).get("error")))
            );
        }
    }

    @And("Admin confirm to upload adjustment csv success")
    public void admin_confirm_to_upload_adjustment_csv_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.uploadAdjustmentSuccess()
        );
    }

    @And("Admin verify adjustment in vendor statement detail")
    public void admin_verify_adjustment_vendor_statement_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (int i = 0; i < infos.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorStatementsPage.DATE_ADJUSTMENT(i + 1)),
                    Ensure.that(VendorStatementsPage.DATE_ADJUSTMENT(i + 1)).text().contains(CommonHandle.setDate2(infos.get(0).get("date"), "MM/dd/yy")),
                    Ensure.that(VendorStatementsPage.EDIT_ADJUSTMENT(i + 1)).isDisplayed(),
                    Ensure.that(VendorStatementsPage.DELETE_ADJUSTMENT(i + 1)).isDisplayed(),
                    Ensure.that(VendorStatementsPage.TYPE_ADJUSTMENT(i + 1)).text().contains(infos.get(0).get("type")),
                    Ensure.that(VendorStatementsPage.DESCRIPTION_ADJUSTMENT(i + 1)).text().contains(infos.get(0).get("description")),
                    Ensure.that(VendorStatementsPage.AMOUNT_ADJUSTMENT(i + 1)).text().contains(infos.get(0).get("amount"))
            );
        }

    }

    @And("Admin verify adjustment by description in vendor statement detail")
    public void admin_verify_adjustment_by_description_in_vendor_statement_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "description", infos.get(0).get("description"), Serenity.sessionVariableCalled("Adjustment Description"), "random");
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorStatementsPage.DATE_ADJUSTMENT(info.get("description"))),
                Ensure.that(VendorStatementsPage.DATE_ADJUSTMENT(info.get("description"))).text().contains(CommonHandle.setDate2(info.get("effectiveDate"), "MM/dd/yy")),
                Ensure.that(VendorStatementsPage.EDIT_ADJUSTMENT(info.get("description"))).isDisplayed(),
                Ensure.that(VendorStatementsPage.DELETE_ADJUSTMENT(info.get("description"))).isDisplayed(),
                Ensure.that(VendorStatementsPage.TYPE_ADJUSTMENT(info.get("description"))).text().contains(info.get("type")),
                Ensure.that(VendorStatementsPage.DESCRIPTION_ADJUSTMENT(info.get("description"))).text().contains(info.get("description")),
                Ensure.that(VendorStatementsPage.AMOUNT_ADJUSTMENT(info.get("description"))).text().contains(info.get("value"))
        );
        if (info.containsKey("status")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorStatementsPage.DELETE_ADJUSTMENT_DISABLE(info.get("description"))).isDisplayed(),
                    Ensure.that(VendorStatementsPage.EDIT_ADJUSTMENT_DISABLED(info.get("description"))).isDisplayed()
            );
        }
    }

    @And("Admin check the order {string} no found in vendor statement")
    public void admin_check_order_no_found(String order) {
        String orderNumber = null;
        if (order.equals("create by api")) {
            orderNumber = Serenity.sessionVariableCalled("ID Order");
        }
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorStatementsDetailPage.ORDER_DETAIL(orderNumber, "order-date")).isNotDisplayed()
        );
    }

    @And("Admin add an adjustment in vendor statement")
    public void admin_add_an_adjustment(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        // set random vào description để tiện tìm xpath
        String description = CommonTask.randomAlphaNumeric(10);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "description", infos.get(0).get("description"), description, "random");
        Serenity.setSessionVariable("Adjustment Description").to(description);

        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.goToCreateAdjustment(),
                HandleVendorStatements.addAnAdjustment(info),
                HandleVendorStatements.addAnAdjustmentSuccess()
        );
    }

    @And("Admin verify default adjustment in vendor statement")
    public void admin_verify_default_adjustment_in_vendor_statement() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add an adjustment")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add an adjustment")),
                MoveMouse.to(VendorStatementsDetailPage.EFFECTIVE_DATE_TEXTBOX_ADJUSTMENT_POPUP),
                Click.on(VendorStatementsDetailPage.ICON_CLOSE_TEXTBOX_ADJUSTMENT_POPUP),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                WindowTask.threadSleep(1000),
                // Verify
                Ensure.that(VendorStatementsDetailPage.D_ERROR_ADJUSTMENT_POPUP("Value")).text().contains("Please enter adjustment value"),
                Ensure.that(VendorStatementsDetailPage.D_ERROR_ADJUSTMENT_POPUP("Type")).text().contains("Please select an adjustment type"),
                Ensure.that(VendorStatementsDetailPage.D_ERROR_ADJUSTMENT_POPUP("Effective date")).text().contains("Please enter effective date"),
                Ensure.that(VendorStatementsDetailPage.D_ERROR_ADJUSTMENT_POPUP("Description")).text().contains("Please enter adjustment description"),
                // Close popup
                Click.on(VendorStatementsDetailPage.CLOSE_ADJUSTMENT_POPUP)
        );
    }

    @And("Admin edit an adjustment in vendor statement")
    public void admin_edit_an_adjustment(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.goToEditAdjustment(Serenity.sessionVariableCalled("Adjustment Description"))
        );
        // set random vào description để tiện tìm xpath
        String description = CommonTask.randomAlphaNumeric(10);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "description", infos.get(0).get("description"), description, "random");
        Serenity.setSessionVariable("Adjustment Description").to(description);

        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.addAnAdjustment(info),
                HandleVendorStatements.editAnAdjustmentSuccess()
        );
    }

    @And("Admin delete an adjustment in vendor statement")
    public void admin_delete_an_adjustment(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.deleteAdjustment(Serenity.sessionVariableCalled("Adjustment Description"))
        );
    }

    @And("Admin verify no found adjustment in vendor statement")
    public void admin_verify_no_found_adjustment(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorStatementsDetailPage.DELETE_ADJUSTMENT_BUTTON(infos.get(0).get("description") + Serenity.sessionVariableCalled("Adjustment Description Date"))).isNotDisplayed()
        );
    }

    @And("Admin verify adjustment type {string} in vendor statement")
    public void verify_adjustment_type_in_vendor_statement(String adjustmentType) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.goToCreateAdjustment(),
                CommonTask.chooseItemInDropdownWithValueInput1(VendorStatementsDetailPage.TYPE_TEXTBOX_ADJUSTMENT_POPUP, adjustmentType, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(adjustmentType))
        );
    }

    @And("Admin choose adjustment in vendor statements")
    public void admin_pay_adjustment_in_vendor_statements(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        HashMap<String, String> info = null;

        if (infos.get(0).get("adjustmentDescription").contains("random")) {
            String description = Serenity.sessionVariableCalled("Adjustment Description");
            info = CommonTask.setValue(infos.get(0), "adjustmentDescription", infos.get(0).get("adjustmentDescription"), description, "random");
        }

        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.chooseAdjustmentToPay(info.get("adjustmentDescription"))
        );
    }

    @And("Admin verify payment in vendor statement detail")
    public void admin_verify_payment_by_description_in_vendor_statement_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "description", infos.get(0).get("description"), Serenity.sessionVariableCalled("Payment Description"), "random");
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorStatementsPage.PAYMENT_DATE(info.get("description"))),
                Ensure.that(VendorStatementsPage.PAYMENT_DATE(info.get("description"))).text().contains(CommonHandle.setDate2(info.get("effectiveDate"), "MM/dd/yy")),
                Ensure.that(VendorStatementsPage.PAYMENT_TYPE1(info.get("description"))).text().contains(info.get("type")),
                Ensure.that(VendorStatementsPage.PAYMENT_DESCRIPTION(info.get("description"))).isDisplayed(),
                Ensure.that(VendorStatementsPage.PAYMENT_PAYMENTS(info.get("description"))).text().contains(info.get("payments")),
                Ensure.that(VendorStatementsPage.PAYMENT_NET_PAYMENT(info.get("description"))).text().contains(info.get("netPayment"))
        );
    }

    @And("Admin verify payment not display in vendor statement detail")
    public void admin_verify_payment_by_description_not_display(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "description", infos.get(0).get("description"), Serenity.sessionVariableCalled("Payment Description"), "random");
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(VendorStatementsPage.PAYMENT_DESCRIPTION(info.get("description")))
        );

    }

    @And("Admin verify search field after choose filter in vendor statements")
    public void admin_verify_search_field_after_choose_filter(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(2000),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("payment_state")).attribute("value").contains(infos.get(0).get("paymentStatus")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("email")).attribute("value").contains(infos.get(0).get("email")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id")).attribute("value").contains(infos.get(0).get("vendorCompany")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_ach")).attribute("value").contains(infos.get(0).get("ach")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("statement_month")).attribute("value").contains(CommonHandle.setDate2(infos.get(0).get("statementMonth"),"MM/yyyy")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("pay_early_discount")).attribute("value").contains(infos.get(0).get("prePayment"))
        );
    }

    /**
     * Process
     */
    @And("Admin go to process of vendor statement")
    public void admin_go_to_process_of_vendor_statement() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.goToProcess()
        );
    }

    @And("Admin search info in process of vendor statement")
    public void admin_search_info_in_process_of_vendor_statement(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.fillInfoProcess(infos.get(0))
        );
    }

    @And("Admin select vendor company in process of vendor statement")
    public void admin_select_vendor_company_in_process_of_vendor_statement(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.selectVendorInProcess(infos)
        );
    }

    @And("Admin process of vendor statement")
    public void admin_process_of_vendor_statement() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorStatements.process()
        );
    }

}

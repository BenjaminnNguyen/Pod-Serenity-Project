package cucumber.tasks.admin.financial;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.financial.VendorStatementsDetailPage;
import cucumber.user_interface.admin.financial.VendorStatementsPage;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleVendorStatements {

    public static Task authenPermission() {
        return Task.where("Authen permission request",
                Check.whether(valueOf(VendorStatementsPage.PASSWORD_TEXTBOX), isCurrentlyVisible())
                        .andIfSo(
                                CommonWaitUntil.isVisible(VendorStatementsPage.PASSWORD_TEXTBOX),
                                Enter.theValue("12345678a").into(VendorStatementsPage.PASSWORD_TEXTBOX),
                                Click.on(VendorStatementsPage.AUTHORIZE_BUTTON),
                                closeAlertPopup(),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
                        )
        );
    }

    public static Task closeAlertPopup() {
        return Task.where("Close alert popup",
                CommonWaitUntil.isVisible(VendorStatementsPage.AUTHORIZE_ALERT),
                WindowTask.threadSleep(1000),
                Click.on(VendorStatementsPage.AUTHORIZE_ALERT_CLOSE)
        );
    }

    public static Task search(Map<String, String> info) {
        return Task.where("Search vendor statements",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Check.whether(!Objects.equals(info.get("paymentStatus"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("payment_state"), info.get("paymentStatus"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("paymentStatus")))
                        ),
                Enter.theValue(info.get("email")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("email")),
                Check.whether(!Objects.equals(info.get("vendorCompany"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("vendorCompany")))
                        ),
                Check.whether(!Objects.equals(info.get("ach"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_ach"), info.get("ach"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("ach")))
                        ),
                Check.whether(!Objects.equals(info.get("statementMonth"), ""))
                        .andIfSo(
                                Enter.theValue(CommonHandle.setDate(info.get("statementMonth"), "MM/yyyy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("statement_month")).thenHit(Keys.ENTER)
                        ),
                Check.whether(!Objects.equals(info.get("prePayment"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("pay_early_discount"), info.get("prePayment"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("prePayment")))
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToDetail(String vendorCompany) {
        return Task.where("Go to detail",
                CommonWaitUntil.isVisible(VendorStatementsPage.VENDOR_COMPANY_RESULT(vendorCompany)),
                Click.on(VendorStatementsPage.VENDOR_COMPANY_RESULT(vendorCompany)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task chooseOrderToPay(String order) {
        return Task.where("Choose order to pay",
                CommonWaitUntil.isVisible(VendorStatementsPage.VENDOR_COMPANY_FIELD),
                Scroll.to(VendorStatementsPage.ORDER_NUMBER_CHECKBOX(order)),
                CommonWaitUntil.isVisible(VendorStatementsPage.ORDER_NUMBER_CHECKBOX(order)),
                JavaScriptClick.on(VendorStatementsPage.ORDER_NUMBER_CHECKBOX(order)),
                CommonWaitUntil.isVisible(VendorStatementsPage.PAY_ACTION)
        );
    }

    public static Task payMoney(Map<String, String> info) {
        return Task.where("Pay money in vendor statements",
                CommonWaitUntil.isVisible(VendorStatementsPage.PAY_ACTION),
                Click.on(VendorStatementsPage.PAY_ACTION),
                // Choose payment type and write description
                Enter.theValue(info.get("description")).into(VendorStatementsPage.DESCRIPTION_TEXTBOX),
                Click.on(VendorStatementsPage.PAYMENT_TYPE(info.get("paymentType"))),
                Click.on(VendorStatementsPage.CONFIRM_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task payMoneyError(Map<String, String> info) {
        return Task.where("Pay money in vendor statements",
                CommonWaitUntil.isVisible(VendorStatementsPage.PAY_ACTION),
                Click.on(VendorStatementsPage.PAY_ACTION),
                // Choose payment type and write description
                Enter.theValue(info.get("description")).into(VendorStatementsPage.DESCRIPTION_TEXTBOX),
                Click.on(VendorStatementsPage.PAYMENT_TYPE(info.get("paymentType"))),
                Click.on(VendorStatementsPage.CONFIRM_BUTTON),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP(info.get("message")))
        );
    }


    public static Task chooseAllOrder() {
        return Task.where("Choose all order to pay",
                CommonWaitUntil.isVisible(VendorStatementsPage.VENDOR_COMPANY_FIELD),
                JavaScriptClick.on(VendorStatementsPage.ALL_CHECKBOX),
                CommonWaitUntil.isVisible(VendorStatementsPage.PAY_ACTION)
        );
    }

    public static Task chooseAdjustmentToPay(String adjustmentDescription) {
        return Task.where("Choose adjustment to pay",
                CommonWaitUntil.isVisible(VendorStatementsPage.VENDOR_COMPANY_FIELD),
                Scroll.to(VendorStatementsPage.ADJUSTMENT_DESCRIPTION_CHECKBOX(adjustmentDescription)),
                CommonWaitUntil.isVisible(VendorStatementsPage.ADJUSTMENT_DESCRIPTION_CHECKBOX(adjustmentDescription)),
                JavaScriptClick.on(VendorStatementsPage.ADJUSTMENT_DESCRIPTION_CHECKBOX(adjustmentDescription)),
                CommonWaitUntil.isVisible(VendorStatementsPage.PAY_ACTION)
        );
    }

    public static Task uploadAdjustmentFile(String filename) {
        return Task.where("upload adjustment file",
                CommonWaitUntil.isPresent(VendorStatementsPage.UPLOAD_ADJUSTMENT_BUTTON),
                CommonFile.upload1(filename, VendorStatementsPage.UPLOAD_ADJUSTMENT_BUTTON),
                CommonWaitUntil.isVisible(VendorStatementsPage.UPLOAD_ADJUSTMENT_CSV_LABEL)
        );
    }

    public static Task uploadAdjustmentSuccess() {
        return Task.where("upload adjustment file success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Confirm")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Confirm")),
                CommonWaitUntil.isNotVisible(VendorStatementsPage.UPLOAD_ADJUSTMENT_CSV_LABEL),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Adjustments have been added successfully!"))

        );
    }

    public static Task goToCreateAdjustment() {
        return Task.where("Go to create adjustment",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add an adjustment")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add an adjustment")),
                CommonWaitUntil.isVisible(VendorStatementsDetailPage.ADD_AN_ADJUSTMENT_LABEL)
        );
    }

    public static Task goToEditAdjustment(String description) {
        return Task.where("Go to edit adjustment",
                CommonWaitUntil.isVisible(VendorStatementsDetailPage.EDIT_ADJUSTMENT_BUTTON(description)),
                Click.on(VendorStatementsDetailPage.EDIT_ADJUSTMENT_BUTTON(description)),
                CommonWaitUntil.isVisible(VendorStatementsDetailPage.EDIT_AN_ADJUSTMENT_LABEL)
        );
    }

    public static Task addAnAdjustment(Map<String, String> info) {
        return Task.where("Add an adjustment",
                Hit.the(Keys.BACK_SPACE).into(VendorStatementsDetailPage.VALUE_TEXTBOX_ADJUSTMENT_POPUP),
                // Value
                Enter.theValue(info.get("value")).into(VendorStatementsDetailPage.VALUE_TEXTBOX_ADJUSTMENT_POPUP),
                // Type
                CommonTask.chooseItemInDropdownWithValueInput1(VendorStatementsDetailPage.TYPE_TEXTBOX_ADJUSTMENT_POPUP, info.get("type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("type"))),
                // Effective date
                MoveMouse.to(VendorStatementsDetailPage.EFFECTIVE_DATE_TEXTBOX_ADJUSTMENT_POPUP),
                Click.on(VendorStatementsDetailPage.ICON_CLOSE_TEXTBOX_ADJUSTMENT_POPUP),
                Enter.theValue(CommonHandle.setDate2(info.get("effectiveDate"), "MM/dd/yy")).into(VendorStatementsDetailPage.EFFECTIVE_DATE_TEXTBOX_ADJUSTMENT_POPUP).thenHit(Keys.ENTER),
                // Description + ngày giờ
                Enter.theValue(info.get("description")).into(VendorStatementsDetailPage.DESCRIPTION_TEXTBOX_ADJUSTMENT_POPUP)
        );
    }

    public static Task addAnAdjustmentSuccess() {
        return Task.where("Add an adjustmen success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Add an adjustment"))
        );
    }

    public static Task editAnAdjustmentSuccess() {
        return Task.where("Add an adjustmen success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isVisible(VendorStatementsDetailPage.EDIT_AN_ADJUSTMENT_LABEL)
        );
    }

    public static Task deleteAdjustment(String description) {
        return Task.where("Delete adjustment",
                CommonWaitUntil.isVisible(VendorStatementsDetailPage.DELETE_ADJUSTMENT_BUTTON(description)),
                Click.on(VendorStatementsDetailPage.DELETE_ADJUSTMENT_BUTTON(description)),
                CommonWaitUntil.isVisible(VendorStatementsDetailPage.ALERT_MESSAGE_ADJUSTMENT("Are you really sure to remove adjustment")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Process")),
                CommonWaitUntil.isNotVisible(VendorStatementsDetailPage.ALERT_MESSAGE_ADJUSTMENT("Are you really sure to remove adjustment"))
        );
    }

    public static Task goToProcess() {
        return Task.where("Go to process",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Process")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Process")),
                CommonWaitUntil.isVisible(VendorStatementsDetailPage.AUTO_PAYMENT_PROCESS_POPUP)
        );
    }

    public static Task fillInfoProcess(Map<String, String> info) {
        return Task.where("Fill info process",
                CommonWaitUntil.isVisible(VendorStatementsDetailPage.PROCESS_TEXTBOX_POPUP("Start date")),
                Check.whether(info.get("startDate").isEmpty())
                        .otherwise(Enter.theValue(info.get("startDate")).into(VendorStatementsDetailPage.PROCESS_TEXTBOX_POPUP("Start date")).thenHit(Keys.ENTER)),
                Check.whether(info.get("endDate").isEmpty())
                        .otherwise(Enter.theValue(info.get("endDate")).into(VendorStatementsDetailPage.PROCESS_TEXTBOX_POPUP("End date")).thenHit(Keys.ENTER)),
                Check.whether(info.get("filterAmount").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdown(VendorStatementsDetailPage.FILTER_AMOUNT_PROCESS_POPUP, CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(info.get("filterAmount")))),
                Check.whether(info.get("amount").isEmpty())
                        .otherwise(Enter.theValue(info.get("amount")).into(VendorStatementsDetailPage.AMOUNT_PROCESS_POPUP)),
                Check.whether(info.get("ach").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdown(VendorStatementsDetailPage.PROCESS_TEXTBOX_POPUP("ACH"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(info.get("ach")))),
                // Enter password
                Enter.theValue(info.get("password")).into(VendorStatementsDetailPage.PROCESS_TEXTBOX_POPUP("Enter authentication password to confirm"))
        );
    }

    public static Performable selectVendorInProcess(List<Map<String, String>> infos) {
        return Task.where("Select vendor company in process",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(VendorStatementsDetailPage.SELECT_ALL_CHECKBOX),
                            Click.on(VendorStatementsDetailPage.SELECT_ALL_CHECKBOX)
                    );
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                Enter.theValue(info.get("vendorCompany")).into(VendorStatementsDetailPage.VENDOR_COMPANY_PROCESS_POPUP).thenHit(Keys.ENTER),
                                WindowTask.threadSleep(1000),
                                Click.on(VendorStatementsDetailPage.VENDOR_COMPANY_CHECKBOX_PROCESS_POPUP(info.get("vendorCompany")))
                                );
                    }
                }
        );
    }

    public static Task process() {
        return Task.where("Process",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Process")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Process"))
        );
    }
}

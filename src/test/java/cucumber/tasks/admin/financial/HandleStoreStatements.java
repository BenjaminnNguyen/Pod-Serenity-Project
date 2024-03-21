package cucumber.tasks.admin.financial;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.financial.VendorStatementsPage;
import cucumber.user_interface.admin.financial.storestatements.StoreStatementsDetailPage;
import cucumber.user_interface.admin.financial.storestatements.StoreStatementsPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleStoreStatements {

    public static Task search(Map<String, String> info) {
        return Task.where("Search store statements",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Check.whether(!Objects.equals(info.get("buyerCompany"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id"), info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerCompany")))
                        ),
                Check.whether(!Objects.equals(info.get("store"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("store")))
                        ),
                Check.whether(!Objects.equals(info.get("buyer"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id"), info.get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_2(info.get("buyer")))
                        ),
                Check.whether(!Objects.equals(info.get("statementMonth"), ""))
                        .andIfSo(
                                Enter.theValue(CommonHandle.setDate(info.get("statementMonth"), "MM/yyyy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("statement_month")).thenHit(Keys.ENTER)
                        ),
                Check.whether(!Objects.equals(info.get("region"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("region")))
                        ),
                Check.whether(!Objects.equals(info.get("managedBy"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("manager_id"), info.get("managedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("managedBy")))
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToDetail(String storeStatement) {
        return Task.where("Go to detail",
                CommonWaitUntil.isVisible(StoreStatementsPage.STORE_RESULT(storeStatement)),
                Click.on(StoreStatementsPage.STORE_RESULT(storeStatement)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToRecordPayment() {
        return Task.where("Go to record payment",
                CommonWaitUntil.isVisible(StoreStatementsPage.RECORD_PAYMENT_BUTTON),
                Scroll.to(StoreStatementsPage.GENERAL_INFO_HEADER),
                JavaScriptClick.on(StoreStatementsPage.RECORD_PAYMENT_BUTTON),
                CommonWaitUntil.isVisible(StoreStatementsPage.PAYMENT_TEXTBOX("Payment Amount"))
        );
    }

    public static Task addRecordPayment(Map<String, String> info) {
        return Task.where("Add record payment",
                Check.whether(info.get("orderID").equals("all"))
                        .andIfSo(Click.on(StoreStatementsPage.SELECT_ALL_SUB_INVOICE))
                        .otherwise(JavaScriptClick.on(StoreStatementsPage.SUB_INVOICE_CHECKBOX(info.get("orderID")))),
                Enter.theValue(info.get("paymentAmount")).into(StoreStatementsPage.PAYMENT_TEXTBOX("Payment Amount")),
                Enter.theValue(CommonHandle.setDate2(info.get("paymentDate"), "MM/dd/yyyy")).into(StoreStatementsPage.PAYMENT_TEXTBOX("Payment Date")).thenHit(Keys.ENTER),
                Check.whether(!Objects.equals(info.get("paymentType"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        StoreStatementsPage.PAYMENT_TEXTBOX("Payment Type"), info.get("paymentType"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("paymentType")))
                        ),
                Enter.theValue(info.get("note")).into(StoreStatementsPage.PAYMENT_TEXTAREA("Note")),
                // Tick chọn credit memos, unapplied payments và adjustments
                Check.whether(!Objects.equals(info.get("creditMemos"), ""))
                        .andIfSo(
                                JavaScriptClick.on(StoreStatementsDetailPage.D_CHECKBOX(info.get("creditMemos")))
                        ),
                Check.whether(!Objects.equals(info.get("unappliedPayment"), ""))
                        .andIfSo(
                                JavaScriptClick.on(StoreStatementsDetailPage.D_CHECKBOX(info.get("unappliedPayment")))
                        ),
                Check.whether(!Objects.equals(info.get("adjustment"), ""))
                        .andIfSo(
                                JavaScriptClick.on(StoreStatementsDetailPage.D_CHECKBOX(info.get("adjustment")))
                        )
        );
    }

    public static Task addRecordPaymentSuccess() {
        return Task.where("Add record payment success",
                CommonWaitUntil.isClickable(StoreStatementsPage.COMPLETE_RECORD_PAYMENT),
                Click.on(StoreStatementsPage.COMPLETE_RECORD_PAYMENT),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task addAnAdjustment(Map<String, String> info) {
        return Task.where("Add an adjustment",
                CommonWaitUntil.isVisible(StoreStatementsPage.D_TEXTBOX("Value")),
                Enter.theValue(info.get("value")).into(StoreStatementsPage.D_TEXTBOX("Value")),
                CommonTask.chooseItemInDropdownWithValueInput(StoreStatementsPage.D_TEXTBOX("Type"), info.get("type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("type"))),
                Check.whether(info.get("subInvoice").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(StoreStatementsPage.D_TEXTBOX("Sub-invoice"), info.get("subInvoice"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("subInvoice")))),
                Enter.theValue(CommonHandle.setDate(info.get("deliveryDate"), "MM/dd/yy")).into(StoreStatementsPage.D_TEXTBOX("Delivery date")).thenHit(Keys.ENTER),
                Enter.theValue(info.get("description")).into(StoreStatementsPage.D_TEXTBOX("Description")),
                Click.on(StoreStatementsDetailPage.CREATE_ADJUSTMENT),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task editAnAdjustment(Map<String, String> info) {
        return Task.where("Edit an adjustment",
                CommonWaitUntil.isVisible(StoreStatementsPage.EDIT_LAST_ADJUSTMENT_BUTTON),
                Click.on(StoreStatementsPage.EDIT_LAST_ADJUSTMENT_BUTTON),
                CommonWaitUntil.isVisible(StoreStatementsPage.D_TEXTBOX("Value")),
                Enter.theValue(info.get("value")).into(StoreStatementsPage.D_TEXTBOX("Value")),
                CommonTask.chooseItemInDropdownWithValueInput(StoreStatementsPage.D_TEXTBOX("Type"), info.get("type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("type"))),
                Click.on(StoreStatementsDetailPage.UPDATE_ADJUSTMENT),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task deleteAnAdjustment() {
        return Task.where("Delete an adjustment",
                CommonWaitUntil.isVisible(StoreStatementsPage.DELETE_LAST_ADJUSTMENT_BUTTON),
                Click.on(StoreStatementsPage.DELETE_LAST_ADJUSTMENT_BUTTON),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("Warning")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Process")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToAddAdjustment() {
        return Task.where("Go to add an adjustment",
                CommonWaitUntil.isVisible(StoreStatementsPage.ADJUSTMENT_BUTTON),
                Scroll.to(StoreStatementsPage.ADJUSTMENT_BUTTON),
                Click.on(StoreStatementsPage.ADJUSTMENT_BUTTON),
                CommonWaitUntil.isVisible(StoreStatementsPage.D_TEXTBOX("Value"))
        );
    }

}

package cucumber.tasks.admin.financial;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.financial.storestatements.CreditMemosPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Hit;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;
import java.util.Objects;

public class HandleCreditMemos {

    public static Task search(Map<String, String> info) {
        return Task.where("Search credit memo",
                Check.whether(!Objects.equals(info.get("number"), ""))
                        .andIfSo(
                                Enter.theValue(info.get("number")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number"))
                        ),
                Check.whether(!Objects.equals(info.get("buyerEmail"), ""))
                        .andIfSo(
                                Enter.theValue(info.get("buyerEmail")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_email"))
                        ),
                Check.whether(!Objects.equals(info.get("buyer"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id"), info.get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyer")))
                        ),
                Check.whether(!Objects.equals(info.get("store"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("store")))
                        ),
                Check.whether(!Objects.equals(info.get("buyerCompany"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id"), info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerCompany")))
                        ),
                Check.whether(!Objects.equals(info.get("state"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdown1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("state")))
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task fillInfoToCreate(Map<String, String> info) {
        return Task.where("Fill info to create credit memo",
                CommonTask.chooseItemInDropdownWithValueInput(CreditMemosPage.D_TEXTBOX("Buyer"), info.get("buyer"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_2(info.get("buyer"))),
                CommonTask.chooseItemInDropdownWithValueInput(CreditMemosPage.D_TEXTBOX("Type"), info.get("type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("type"))),
                Enter.theValue(info.get("amount")).into(CreditMemosPage.D_TEXTBOX("Amount")),
                Enter.theValue(info.get("description")).into(CreditMemosPage.D_TEXTAREA("Description")),
                CommonFile.upload1(info.get("file"), CreditMemosPage.ATTACTMENT_BUTTON)
        );
    }

    public static Task createCreditMemoSuccess() {
        return Task.where("Create credit memo success",
                Click.on(CreditMemosPage.CREATE_BUTTON),
                CommonWaitUntil.isVisible(CreditMemosPage.GENERAL_INFO_LABEL)
        );
    }

    public static Task createCreditMemoError(String message) {
        return Task.where("Create credit memo error",
                Click.on(CreditMemosPage.CREATE_BUTTON),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    public static Task cancel() {
        return Task.where("Cancel this credit memo",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Cancel this credit memo")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Cancel this credit memo")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("Cancel")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Yes")),
                CommonWaitUntil.isVisible(CreditMemosPage.CANCEL_BUTTON_DISABLE)
        );
    }

    public static Task edit(Map<String, String> info) {
        return Task.where("Edit this credit memo",
                Check.whether(info.get("amount").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(CreditMemosPage.AMOUNT_FIELD, info.get("amount"))),
                Check.whether(info.get("state").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipDropdown(CreditMemosPage.STATE_FIELD, info.get("state"))),
                Check.whether(info.get("description").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(CreditMemosPage.GENERAL_INFO_DESCRIPTION, info.get("description"))),
                Check.whether(info.get("order").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipDropdownWithInput(CreditMemosPage.GENERAL_INFO_ORDER, info.get("order")))
        );
    }

    public static Task goToCreate() {
        return Task.where("Go to create credit memo",
                Click.on(CreditMemosPage.CREATE_BUTTON),
                CommonWaitUntil.isVisible(CreditMemosPage.D_TEXTBOX("Buyer"))
        );
    }

    public static Performable fillCostCoveredByPodFoods(Map<String, String> info) {
        return Task.where("Fill info cost covered by : PodFoods",
                CommonTask.chooseMultiWithOneItemInDropdown(CreditMemosPage.D_TEXTBOX("Cost covered by"), info.get("costCovered"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("costCovered"))),
                Enter.theValue(info.get("amount")).into(CreditMemosPage.POD_FOODS_COST_COVERED_BY_TEXTBOX)
        );
    }

    public static Performable chooseTypeCostCoveredBy(List<Map<String, String>> infos) {
        return Task.where("Fill info cost covered by : PodFoods",
                actor -> {
                    actor.attemptsTo(
                            CommonTask.chooseMultiItemInDropdown1(CreditMemosPage.D_TEXTBOX("Cost covered by"), infos)
                    );
                }
        );
    }

    public static Performable fillCostCoveredBy(String type, List<Map<String, String>> infos) {
        return Task.where("Fill info cost covered by : PodFoods",
                actor -> {
                    for (Map<String, String> info : infos) {
                        if (type.equals("Pod Foods")) {
                            actor.attemptsTo(
                                    Enter.theValue(info.get("amount")).into(CreditMemosPage.POD_FOODS_COST_COVERED_BY_TEXTBOX)
                            );
                        }
                        if (type.equals("Vendor Company")) {
                            actor.attemptsTo(
                                    // choose vendor company
                                    CommonTask.chooseItemInDropdownWithValueInput1(CreditMemosPage.VENDOR_COMPANY_COST_COVERED_BY_TEXTBOX, info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany"))),
                                    CommonWaitUntil.isVisible(CreditMemosPage.COST_COVERED_BY_TEXTBOX(info.get("vendorCompany"))),
                                    Enter.theValue(info.get("amount")).into(CreditMemosPage.COST_COVERED_BY_TEXTBOX(info.get("vendorCompany")))
                            );
                        }
                        if (type.equals("Logistics Partner")) {
                            actor.attemptsTo(
                                    // choose Logistics Partner
                                    CommonTask.chooseItemInDropdownWithValueInput1(CreditMemosPage.LOGISTIC_PARTNER_COST_COVERED_BY_TEXTBOX, info.get("logisticPartner"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("logisticPartner"))),
                                    CommonWaitUntil.isVisible(CreditMemosPage.COST_COVERED_BY_TEXTBOX(info.get("logisticPartner"))),
                                    Enter.theValue(info.get("amount")).into(CreditMemosPage.COST_COVERED_BY_TEXTBOX(info.get("logisticPartner")))
                            );
                        }
                    }
                }
        );
    }

    public static Performable removeVendorCompany(List<Map<String, String>> infos) {
        return Task.where("Remove vendor company of cost covered by",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(CreditMemosPage.COST_COVERED_BY_DELETE_BUTTON(info.get("vendorCompany"))),
                                Click.on(CreditMemosPage.COST_COVERED_BY_DELETE_BUTTON(info.get("vendorCompany"))),
                                CommonWaitUntil.isNotVisible(CreditMemosPage.COST_COVERED_BY_DELETE_BUTTON(info.get("vendorCompany")))
                        );
                    }
                }
        );
    }

    public static Task saveAction() {
        return Task.where("Save action",
                //Save action
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                //Wait loading
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task editCostCoveredByPodFoods(String amount) {
        return Task.where("Edit amount cost covered by pod foods",
                //Save action
                CommonWaitUntil.isVisible(CreditMemosPage.GENERAL_INFO_CREATED),
                Enter.theValue(amount).into(CreditMemosPage.COST_COVERED_BY_TEXTBOX("Podfoods"))
        );
    }

    public static Task uploadAnotherAttachment(String file) {
        return Task.where("Upload another attachment",
                //open upload file
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Upload another attachment")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Upload another attachment")),
                CommonWaitUntil.isPresent(CreditMemosPage.ATTACHMENT_POPUP),

                //upload file
                CommonFile.upload1(file, CreditMemosPage.ACTTACHMENT_POPUP_UPLOAD),
                Click.on(CreditMemosPage.ACTTACHMENT_POPUP_BUTTON_UPDATE),
                CommonWaitUntil.isNotVisible(CreditMemosPage.ATTACHMENT_POPUP)
        );
    }

    public static Task goToDetail(String creditMemo) {
        return Task.where("Go to detail credit memo",
                CommonWaitUntil.isVisible(CreditMemosPage.NUMBER_RESULT(creditMemo)),
                Click.on(CreditMemosPage.NUMBER_RESULT(creditMemo))
        );
    }

    public static Task sendEmailToBuyer() {
        return Task.where("Send email to buyer",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Send email to buyer")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Send email to buyer")),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("You won't be able to edit this memo after sending the email. Proceed??")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Send")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.D_MESSAGE_POPUP("You won't be able to edit this memo after sending the email. Proceed??"))
        );
    }
}


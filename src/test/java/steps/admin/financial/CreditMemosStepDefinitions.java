package steps.admin.financial;

import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import io.cucumber.java.en.*;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.financial.HandleCreditMemos;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.user_interface.admin.financial.storestatements.CreditMemosPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class CreditMemosStepDefinitions {

    @And("Admin create credit memo with info")
    public void admin_create_credit_memo_with_info(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.goToCreate(),
                HandleCreditMemos.fillInfoToCreate(info.get(0))
        );
    }

    @And("Admin create credit memo success")
    public void admin_create_credit_memo_success() {
        // get ID của credit memo
        String id = Text.of(CreditMemosPage.NUMBER_CREDIT).answeredBy(theActorInTheSpotlight()).toString();
        System.out.println("ID credit memo " + id.substring(1));
        Serenity.setSessionVariable("ID Credit Memo").to(id.substring(1));

        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.createCreditMemoSuccess()
        );
    }

    @And("Admin create credit memo error then see message {string}")
    public void admin_create_credit_memo_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.createCreditMemoError(message)
        );
    }


    @And("Admin cancel this credit memo")
    public void admin_cancel_this_credit_memo() {
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.cancel()
        );
    }

    @And("Admin edit general information of credit memo")
    public void admin_edit_general_information_of_credit_memo(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.edit(infos.get(0))
        );
    }

    @And("Admin search credit memo")
    public void admin_search_credit_memo(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>();
        info = CommonTask.setValue(infos.get(0), "number", infos.get(0).get("number").toString(), Serenity.sessionVariableCalled("ID Credit Memo"), "create by admin");

        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.resetFilter(),
                CommonTaskAdmin.showFilter(),
                HandleCreditMemos.search(info)
        );
    }

    @And("Admin verify first credit memo after search")
    public void admin_verify_first_credit_memo_after_search(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CreditMemosPage.NUMBER_RESULT_FIRST),
                Ensure.that(CreditMemosPage.STORE_RESULT_FIRST).text().contains(infos.get(0).get("store")),
                Ensure.that(CreditMemosPage.BUYER_RESULT_FIRST).attribute("data-original-text").contains(infos.get(0).get("buyer"))
        );

        // get ID credit memo
        String number = CreditMemosPage.NUMBER_RESULT_FIRST.resolveFor(theActorInTheSpotlight()).getText();
        Serenity.setSessionVariable("ID Credit Memo").to(number);
    }

    @And("Admin verify credit memo in result")
    public void admin_verify_credit_memo_in_result(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = new HashMap<>();
        if (infos.get(0).get("number").equals("create by admin")) {
            info = CommonTask.setValue(infos.get(0), "number", infos.get(0).get("number").toString(), Serenity.sessionVariableCalled("ID Credit Memo"), "create by admin");
        }
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CreditMemosPage.NUMBER_RESULT(info.get("number"))),
                Ensure.that(CreditMemosPage.NUMBER_RESULT(info.get("number"))).text().contains(info.get("number")),
                Ensure.that(CreditMemosPage.STORE_RESULT(info.get("number"))).attribute("data-original-text").contains(info.get("store")),
                Ensure.that(CreditMemosPage.BUYER_RESULT(info.get("number"))).attribute("data-original-text").contains(info.get("buyer")),
                Ensure.that(CreditMemosPage.EMAIL_BUYER_RESULT(info.get("number"))).attribute("data-original-text").contains(info.get("email")),
                Ensure.that(CreditMemosPage.AMOUNT_RESULT(info.get("number"))).text().contains(info.get("amount")),
                Ensure.that(CreditMemosPage.STATE_RESULT(info.get("number"))).text().contains(info.get("state"))
        );

    }

    @And("Admin verify credit memo type {string} in create credit memo")
    public void admin_verify_credit_memo_type_in_create_credit_memo(String type) {
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.goToCreate(),
                CommonTask.chooseItemInDropdownWithValueInput(CreditMemosPage.D_TEXTBOX("Type"), type, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(type))
        );


    }

    @And("Admin fill info field cost covered {string} in create credit memo")
    public void admin_fill_info_field_cost_covered_by_in_create_credit_memo(String type, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.fillCostCoveredBy(type, infos)
        );
    }

    @And("Admin choose cost covered in create credit memo")
    public void admin_choose_cost_covered_by_in_create_credit_memo(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.chooseTypeCostCoveredBy(infos)
        );
    }

    @And("Admin verify field cost covered vendor company {string} exists in create credit memo")
    public void admin_fill_info_field_cost_covered_by_vendor_company_exists(String vendorCompany) {
        theActorInTheSpotlight().attemptsTo(
                CommonTask.chooseItemInDropdownWithValueInput1(CreditMemosPage.VENDOR_COMPANY_COST_COVERED_BY_TEXTBOX, vendorCompany, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(vendorCompany)),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Item already exists"))
        );
    }

    @And("Admin remove vendor company in cost covered by")
    public void admin_remove_vendor_company_in_cost_covered_by(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.removeVendorCompany(infos)
        );
    }

    @And("Admin verify balance in create credit memo is {string}")
    public void admin_verify_balance_in_create_credit_memo(String balance) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CreditMemosPage.BALANCE_TEXTBOX),
                Ensure.that(CreditMemosPage.BALANCE_TEXTBOX).text().contains(balance)
        );
    }

    @And("Admin verify general information of credit memo")
    public void admin_verify_general_information_of_credit_memo(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CreditMemosPage.GENERAL_INFO_CREATED),
                Ensure.that(CreditMemosPage.GENERAL_INFO_CREATED).text().contains(CommonHandle.setDate2(infos.get(0).get("created"), "MM/dd/yy")),
                Ensure.that(CreditMemosPage.GENERAL_INFO_BUYER).text().contains(infos.get(0).get("buyer")),
                Ensure.that(CreditMemosPage.GENERAL_INFO_STORE).text().contains(infos.get(0).get("store")),
                Check.whether(infos.get(0).get("order").equals(""))
                        .otherwise(Ensure.that(CreditMemosPage.GENERAL_INFO_ORDER).text().contains(infos.get(0).get("order"))),
                Check.whether(infos.get(0).get("description").equals(""))
                        .otherwise(Ensure.that(CreditMemosPage.GENERAL_INFO_DESCRIPTION).text().contains(infos.get(0).get("description"))),
                Ensure.that(CreditMemosPage.GENERAL_INFO_TYPE).text().contains(infos.get(0).get("type")),
                Ensure.that(CreditMemosPage.GENERAL_INFO_EXPIRY_DATE).text().contains(CommonHandle.setDate2(infos.get(0).get("expiryDate"), "MM/dd/yy")),
                Ensure.that(CreditMemosPage.GENERAL_INFO_STATUS).text().contains(infos.get(0).get("status")),
                Ensure.that(CreditMemosPage.GENERAL_INFO_AMOUNT).text().contains(infos.get(0).get("amount"))
        );
    }

    @And("Admin verify cost covered by in credit memo detail")
    public void admin_verify_cost_covered_by_in_credit_memo(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CreditMemosPage.GENERAL_INFO_CREATED),
                    Ensure.that(CreditMemosPage.VENDOR_COMPANY_COVER(info.get("title"))).text().contains(info.get("title")),
                    Ensure.that(CreditMemosPage.VENDOR_COMPANY_COVER_AMOUNT(info.get("title"))).attribute("value").contains(info.get("amount"))
            );
        }
    }

    @And("Admin verify cost covered by not display in credit memo detail")
    public void admin_verify_cost_covered_by_not_display_in_credit_memo(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CreditMemosPage.GENERAL_INFO_CREATED),
                    Ensure.that(CreditMemosPage.VENDOR_COMPANY_COVER(info.get("title"))).isNotDisplayed()
            );
        }
    }

    @And("Admin verify attachment in credit memo detail")
    public void admin_verify_attachment_in_credit_memo(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CreditMemosPage.GENERAL_INFO_CREATED),
                    Ensure.that(CreditMemosPage.ATTACTMENT_IN_DETAIL(info.get("file"))).text().contains(info.get("file"))
            );
        }

    }

    @And("Admin verify field cost covered logistic partner {string} exists in create credit memo")
    public void admin_fill_info_field_cost_covered_by_logistic_partner_exists(String logisticPartner) {
        theActorInTheSpotlight().attemptsTo(
                CommonTask.chooseItemInDropdownWithValueInput1(CreditMemosPage.LOGISTIC_PARTNER_COST_COVERED_BY_TEXTBOX, logisticPartner, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(logisticPartner)),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Item already exists"))
        );
    }

    @And("Admin remove cost covered by vendor company in credit memo detail")
    public void admin_remove_cost_covered_by_in_credit_memo(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.removeVendorCompany(infos)
        );
    }

    @And("Admin save action in credit memo detail")
    public void admin_action_in_credit_memo_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.saveAction()
        );
    }

    @And("Admin verify cost covered by pod foods in credit memo detail")
    public void admin_verify_cost_covered_by_pod_foods_in_credit_memo(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(CreditMemosPage.COST_COVERED_BY_TEXTBOX("Podfoods")).attribute("value").contains(infos.get(0).get("amount"))
        );

    }

    @And("Admin edit cost covered by pod foods in credit memo detail")
    public void admin_edit_cost_covered_by_pod_foods_in_credit_memo(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.editCostCoveredByPodFoods(infos.get(0).get("amount"))
        );

    }

    @And("Admin verify upload another attachment in credit memo detail")
    public void admin_verify_another_attachment_in_credit_memo_detail() {
        theActorInTheSpotlight().attemptsTo(
                //open upload file
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Upload another attachment")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Upload another attachment")),
                CommonWaitUntil.isVisible(CreditMemosPage.ATTACHMENT_POPUP),

                // dont upload file
                Click.on(CreditMemosPage.ACTTACHMENT_POPUP_BUTTON_UPDATE),
                CommonWaitUntil.isNotVisible(CreditMemosPage.ATTACHMENT_POPUP),

                // upload file >10MB
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Upload another attachment")),
                CommonWaitUntil.isVisible(CreditMemosPage.ATTACHMENT_POPUP),
                CommonFile.upload2("10MBgreater.jpg", CreditMemosPage.ACTTACHMENT_POPUP_UPLOAD),
                Click.on(CreditMemosPage.ACTTACHMENT_POPUP_BUTTON_UPDATE),
                CommonWaitUntil.isNotVisible(CommonAdminForm.D_MESSAGE_POPUP("Maximum file size exceeded.")),

                // upload file not type pdf
                CommonFile.upload1("autotest.csv", CreditMemosPage.ACTTACHMENT_POPUP_UPLOAD),
                Click.on(CreditMemosPage.ACTTACHMENT_POPUP_BUTTON_UPDATE),
                CommonWaitUntil.isNotVisible(CommonAdminForm.D_MESSAGE_POPUP("Validation failed: Credit memo version attachment content type is invalid")),
                Click.on(CreditMemosPage.ACTTACHMENT_POPUP_BUTTON_CANCEL),

                // upload file not type pdf
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Upload another attachment")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Upload another attachment")),
                CommonWaitUntil.isVisible(CreditMemosPage.ATTACHMENT_POPUP),
                Click.on(CreditMemosPage.ACTTACHMENT_POPUP_BUTTON_UPDATE),
                CommonWaitUntil.isNotVisible(CommonAdminForm.D_MESSAGE_POPUP("Validation failed: Credit memo version can't be blank")),

                // Close add image
                Click.on(CreditMemosPage.ACTTACHMENT_POPUP_BUTTON_CANCEL)
        );
    }

    @And("Admin update another attachment {string} in credit memo detail")
    public void admin_update_another_attachment_in_credit_memo_detail(String file) {
        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.uploadAnotherAttachment(file)

        );
    }

    @And("Admin go to detail credit memo {string}")
    public void admin_go_to_detail_credit_memo(String creditMemo) {
        creditMemo = Serenity.sessionVariableCalled("ID Credit Memo");

        theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.goToDetail(creditMemo)
        );
    }

    @And("Admin send email to buyer of credit memo")
    public void admin_send_email_to_buyer_of_credit_memo() {
              theActorInTheSpotlight().attemptsTo(
                HandleCreditMemos.sendEmailToBuyer()
        );
    }

}

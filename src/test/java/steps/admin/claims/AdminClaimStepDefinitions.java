package steps.admin.claims;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.claims.HandleAdminClaims;
import cucumber.tasks.admin.claims.HandleAdminVendorClaim;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.buyer.orders.HandleClaim;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.claims.AdminClaimsPage;
import cucumber.user_interface.admin.setting.SettingAdminForm;
import cucumber.user_interface.admin.store.AllStoresPage;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;

import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Hit;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;
import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminClaimStepDefinitions {

    @And("Admin go to create claims page")
    public void admin_go_to_create_claims_page() {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminVendorClaim.goToCreateClaims()
        );
    }

    @And("Admin search claims")
    public void admin_search_claims(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), Serenity.sessionVariableCalled("ID Order"), "create by api");
        info = CommonTask.setValue(info, "claimNumber", infos.get(0).get("claimNumber"), Serenity.sessionVariableCalled("Claim ID"), "create by admin");
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.resetFilter(),
                HandleAdminClaims.search(info)
        );
    }

    @And("Admin verify claim result after search")
    public void admin_verify_result_after_search(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "order", infos.get(0).get("order"), Serenity.sessionVariableCalled("ID Order").toString(), "create by api");
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AdminClaimsPage.DATE_RESULT(info.get("order"), 1)).text().contains(CommonHandle.setDate2(info.get("date"), "MM/dd/yy")),
                Ensure.that(AdminClaimsPage.STORE_RESULT(info.get("order"), 1)).text().contains(info.get("store")),
                Ensure.that(AdminClaimsPage.BUYER_RESULT(info.get("order"), 1)).text().contains(info.get("buyer")),
                Ensure.that(AdminClaimsPage.ORDER_RESULT(info.get("order"), 1)).isDisplayed(),
                Ensure.that(AdminClaimsPage.STATUS_RESULT(info.get("order"), 1)).text().contains(info.get("status")),
                Ensure.that(AdminClaimsPage.ISSUE_RESULT(info.get("order"), 1)).text().contains(info.get("issue"))
        );
    }

    @And("Admin verify first result after search")
    public void admin_verify_first_result_after_search(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AdminClaimsPage.DATE_FIRST_RESULT).text().contains(CommonHandle.setDate2(expected.get(0).get("date"), "MM/dd/yy")),
                Ensure.that(AdminClaimsPage.STORE_FIRST_RESULT).text().contains(expected.get(0).get("store")),
                Ensure.that(AdminClaimsPage.BUYER_FIRST_RESULT).text().contains(expected.get(0).get("buyer")),
                Ensure.that(AdminClaimsPage.ORDER_FIRST_RESULT).text().contains(expected.get(0).get("order")),
                Ensure.that(AdminClaimsPage.STATUS_FIRST_RESULT).text().contains(expected.get(0).get("status")),
                Ensure.that(AdminClaimsPage.ISSUE_FIRST_RESULT).text().contains(expected.get(0).get("issue"))
        );
    }

    @And("Admin go to detail of claim order {string} index {int}")
    public void admin_go_to_detail_claim_order(String orderType, int index) {
        String order = Serenity.sessionVariableCalled("ID Order");
        theActorInTheSpotlight().attemptsTo(
                HandleAdminClaims.goToDetail(order, index)
        );
    }

    @And("Admin go to detail of claim order first result")
    public void admin_go_to_detail_claim_order_first_result() {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminClaims.goToDetailFirstResult()
        );
    }

    @And("Admin verify general information")
    public void amdin_verify_general_information(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        // get info of order number
        HashMap<String, String> info = CommonTask.setValue(expected.get(0), "orderID", expected.get(0).get("orderID"), "idInvoice", "");
        info = CommonTask.setValue(info, "orderID", info.get("orderID"), Serenity.sessionVariableCalled("ID Order").toString(), "create by admin");
        // get info of subinvoice number
        info = CommonTask.setValue(info, "subinvoice", info.get("subinvoice"), Serenity.sessionVariableCalled("Sub-invoice ID create by admin").toString(), "create by admin");
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AdminClaimsPage.STORE_NAME_DETAIL).text().contains(expected.get(0).get("store")),
                Ensure.that(AdminClaimsPage.BUYER_NAME_DETAIL).text().contains(expected.get(0).get("buyer")),
                Ensure.that(AdminClaimsPage.BUYER_COMPANY_NAME_DETAIL).text().contains(expected.get(0).get("buyerCompany")),
                Ensure.that(AdminClaimsPage.ORDER_NUMBER_DETAIL).text().contains(info.get("orderID")),
                Ensure.that(AdminClaimsPage.SUB_INVOICE_DETAIL).text().contains(info.get("subInvoice")),
                Ensure.that(AdminClaimsPage.ISSUE_DETAIL).text().contains(expected.get(0).get("issue")),
                Ensure.that(AdminClaimsPage.ISSUE_DESCRIPTION_DETAIL).text().contains(expected.get(0).get("issueDescription")),
                Ensure.that(AdminClaimsPage.DATE_SUBMISSION_DETAIL).text().contains(CommonHandle.setDate2(expected.get(0).get("dateOfSubmission"), "MM/dd/yy")),
                Ensure.that(AdminClaimsPage.STATUS_DETAIL).text().contains(expected.get(0).get("status"))
        );
        if (expected.get(0).containsKey("manager")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AdminClaimsPage.MANAGER_DETAIL).text().contains(expected.get(0).get("manager"))
            );
        }
        if (expected.get(0).containsKey("adminNote")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AdminClaimsPage.ADMIN_NOTE_DETAIL).text().contains(expected.get(0).get("adminNote"))
            );
        }
    }

    @And("Admin verify pictures")
    public void amdin_verify_pictures(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AdminClaimsPage.PICTURE_DETAIL).text().contains(expected.get(0).get("picture"))
        );
    }

    @And("Admin verify affected products")
    public void amdin_verify_affected_product(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AdminClaimsPage.BRAND_DETAIL(i + 1)).text().contains(expected.get(0).get("brand")),
                    Ensure.that(AdminClaimsPage.PRODUCT_DETAIL(i + 1)).text().contains(expected.get(0).get("product")),
                    Ensure.that(AdminClaimsPage.SKU_DETAIL(i + 1)).text().contains(expected.get(0).get("sku")),
                    Ensure.that(AdminClaimsPage.SKU_ID_DETAIL(i + 1)).text().contains(expected.get(0).get("skuID")),
                    Ensure.that(AdminClaimsPage.QUANTITY_DETAIL(i + 1)).attribute("value").contains(expected.get(0).get("quantity"))
            );
        }
    }

    @And("Admin verify general information of guest claim")
    public void amdin_verify_general_information_of_guest_claim(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        // get info of order number
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AdminClaimsPage.STORE_NAME_EMPTY_DETAIL).text().contains(expected.get(0).get("store")),
                Ensure.that(AdminClaimsPage.BUYER_NAME_DETAIL1).text().contains(expected.get(0).get("buyer")),
                Ensure.that(AdminClaimsPage.BUYER_COMPANY_NAME_DETAIL).isNotDisplayed(),
                Ensure.that(AdminClaimsPage.ORDER_NUMBER_DETAIL).isNotDisplayed(),
                Ensure.that(AdminClaimsPage.SUB_INVOICE_DETAIL).text().contains(expected.get(0).get("subInvoice")),
                Ensure.that(AdminClaimsPage.ISSUE_DETAIL).text().contains(expected.get(0).get("issue")),
                Ensure.that(AdminClaimsPage.ISSUE_DESCRIPTION_EMPTY_DETAIL).text().contains(expected.get(0).get("issueDescription")),
                Ensure.that(AdminClaimsPage.DATE_SUBMISSION_DETAIL).text().contains(CommonHandle.setDate2(expected.get(0).get("dateOfSubmission"), "MM/dd/yy")),
                Ensure.that(AdminClaimsPage.STATUS_DETAIL).text().contains(expected.get(0).get("status"))
        );
    }

    @And("Admin create claims")
    public void admin_create_claims(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "orderID", infos.get(0).get("orderID"), Serenity.sessionVariableCalled("ID Order"), "create by api");
        theActorInTheSpotlight().attemptsTo(
                HandleAdminClaims.createClaims(info)
        );
    }

    @And("Admin upload picture to create claims")
    public void admin_upload_picture_to_create_claims(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminClaims.uploadPicture(infos)

        );
    }

    @And("Admin remove picture to create claims")
    public void admin_remove_picture_to_create_claims(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminClaims.uploadPicture(infos)
        );
    }

    @And("Admin verify info default of claim page")
    public void admin_verify_info_default_of_claim_page() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AdminClaimsPage.D_TEXTBOX("Buyer")).attribute("value").contains(""),
                Ensure.that(AdminClaimsPage.STORE_NAME_CREATE_CLAIM).isNotDisplayed(),
                Ensure.that(AdminClaimsPage.BUYER_COMPANY_CREATE_CLAIM).isNotDisplayed(),
                Ensure.that(AdminClaimsPage.D_TEXTBOX("Sub invoice")).attribute("value").contains(""),
                Ensure.that(AdminClaimsPage.D_TEXTAREA("Issue description")).attribute("value").contains(""),
                Ensure.that(AdminClaimsPage.D_TEXTAREA("Admin note")).attribute("value").contains("")
        );
    }

    @And("Admin verify info blank field of claim page")
    public void admin_verify_info_blank_field_of_claim_page() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                // Verify
                CommonWaitUntil.isVisible(AdminClaimsPage.D_ERROR("Buyer")),
                Ensure.that(AdminClaimsPage.D_ERROR("Buyer")).text().contains("Please select a buyer for this claim"),
                Ensure.that(AdminClaimsPage.D_ERROR("Sub invoice")).text().contains("Please select a sub invoice"),
                Ensure.that(AdminClaimsPage.D_ERROR("Issue")).text().contains("Please select a issue")
        );
    }

    @And("Admin verify field buyer in create claim form")
    public void admin_verify_field_buyer_in_create_claim_form() {
        theActorInTheSpotlight().attemptsTo(
                Enter.theValue("ngoc123").into(AdminClaimsPage.D_TEXTBOX("Buyer")),
                // verify dropdown nodata
                CommonWaitUntil.isVisible(CommonBuyerPage.NO_DATA_DROPDOWN),
                Ensure.that(CommonBuyerPage.NO_DATA_DROPDOWN).isDisplayed(),
                Hit.the(Keys.ESCAPE).into(AdminClaimsPage.D_TEXTBOX("Buyer"))
        );
    }

    @And("Admin verify picture field in create claim form")
    public void admin_verify_picture_field_in_create_claim_form() {
        theActorInTheSpotlight().attemptsTo(
                // Verify field when picture blank
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add picture")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Claim documents attachment can't be blank")),
                // Verify field when picture upload > 10MB
                CommonFile.upload1("10MBgreater.jpg", CommonAdminForm.ATTACHMENT_BUTTON),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")),
                // verify upload success
                CommonFile.upload1("claim.jpg", CommonAdminForm.ATTACHMENT_BUTTON),
                CommonWaitUntil.isVisible(AdminClaimsPage.PICTURE_ADDED("claim.jpg")),
                // verify remove upload
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Remove")).afterWaitingUntilEnabled(),
                CommonWaitUntil.isNotVisible(AdminClaimsPage.PICTURE_ADDED("claim.jpg"))
        );
    }

    @And("Admin create claims success")
    public void admin_create_claims_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminClaims.claimSuccess()
        );
    }

    @And("Admin get claims id")
    public void admin_get_claim_id() {
        String idClaim = Text.of(AdminClaimsPage.CLAIM_ID).answeredBy(theActorInTheSpotlight()).toString().substring(6);
        System.out.println("Claim ID = " + idClaim);
        Serenity.setSessionVariable("Claim ID").to(idClaim);
    }

    @And("Admin verify general information in claim detail")
    public void admin_verify_general_information_in_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String idInvoice = Serenity.sessionVariableCalled("ID Order");
        HashMap<String, String> info = CommonTask.setValue(infos.get(0), "orderNumber", infos.get(0).get("orderNumber"), idInvoice, "create by api");

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminClaimsPage.CLAIM_ID),
                // Verify
                Ensure.that(AdminClaimsPage.STORE_GENERAL_INFO).text().contains(info.get("store")),
                Ensure.that(AdminClaimsPage.BUYER_GENERAL_INFO).text().contains(info.get("buyer")),
                Ensure.that(AdminClaimsPage.EMAIL_GENERAL_INFO).text().contains(info.get("email")),
                Check.whether(info.get("buyerCompany").equals(""))
                        .otherwise(Ensure.that(AdminClaimsPage.BUYER_COMPANY_GENERAL_INFO).text().contains(info.get("buyerCompany"))),
                Check.whether(info.get("orderNumber").equals(""))
                        .otherwise(Ensure.that(AdminClaimsPage.ORDER_GENERAL_INFO).text().contains(info.get("orderNumber"))),
                Check.whether(info.get("sub").equals(""))
                        .otherwise(Ensure.that(AdminClaimsPage.SUB_INVOICE_GENERAL_INFO).text().contains(info.get("orderNumber") + info.get("sub"))),
                Ensure.that(AdminClaimsPage.ISSUE_GENERAL_INFO).text().contains(info.get("issue")),
                Ensure.that(AdminClaimsPage.ISSUE_DESCRIPTION_GENERAL_INFO).text().contains(info.get("issueDescription")),
                Ensure.that(AdminClaimsPage.DATE_GENERAL_INFO).text().contains(CommonHandle.setDate2(info.get("date"), "MM/dd/yy")),
                Ensure.that(AdminClaimsPage.STATUS_GENERAL_INFO).text().contains(info.get("status")),
                Check.whether(info.get("manager").equals(""))
                        .otherwise(Ensure.that(AdminClaimsPage.MANAGER_GENERAL_INFO).text().contains(info.get("manager"))),
                Check.whether(info.get("adminNote").equals(""))
                        .otherwise(Ensure.that(AdminClaimsPage.ADMIN_NOTE_GENERAL_INFO).text().contains(info.get("adminNote"))),
                Check.whether(info.get("picture").equals(""))
                        .otherwise(Ensure.that(AdminClaimsPage.PICTURE_GENERAL_INFO).text().contains(info.get("picture")))
        );
    }

    @And("Admin delete claim of order {string} in result")
    public void admin_delete_claim_in_result(String order) {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminClaims.deleteClaim(order)
        );
    }

    @And("Admin go to {string} in claim detail by redirect icon and verify")
    public void admin_go_to_by_redirect_icon_in_claim_detail(String value) {
        Target target = null;
        Target targetResult = null;
        switch (value) {
            case "store":
                target = AdminClaimsPage.STORE_GENERAL_INFO_LINK;
                targetResult = AllStoresPage.DYNAMIC_DETAIL("name");
                break;
            case "buyer":
                target = AdminClaimsPage.BUYER_GENERAL_INFO_LINK;
                targetResult = AllStoresPage.DYNAMIC_DETAIL("email");
                break;
            case "buyer company":
                target = AdminClaimsPage.BUYER_COMPANY_GENERAL_INFO_LINK;
                targetResult = SettingAdminForm.ADMIN_HEADER;
                break;
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(target),
                CommonWaitUntil.isVisible(targetResult),
                Ensure.that(targetResult).isDisplayed()
        );
    }

    @And("Admin add sku in claim form")
    public void admin_add_sku_in_claim_form(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleAdminClaims.goToAddItem(),
                    HandleAdminClaims.addItemInClaimDetail(info)
            );
        }
    }

    @And("Admin verify sku in add item popup of claim detail")
    public void admin_verify_sku_in_claim_item_popup_of_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminClaims.goToAddItem()
        );
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    Click.on(AdminClaimsPage.SELECT_ITEM_TEXTBOX).afterWaitingUntilEnabled(),
                    CommonWaitUntil.isVisible(AdminClaimsPage.PRODUCT_IN_POPUP),
                    // Verify
                    Ensure.that(AdminClaimsPage.BRAND_IN_POPUP).text().contains(info.get("brand")),
                    Ensure.that(AdminClaimsPage.PRODUCT_IN_POPUP).text().contains(info.get("product")),
                    Ensure.that(AdminClaimsPage.SKU_IN_POPUP).text().contains(info.get("sku")),
                    Ensure.that(AdminClaimsPage.SKU_ID_IN_POPUP).text().contains(info.get("skuID"))
            );
        }
    }

    @And("Admin verify no data in add item popup of claim detail")
    public void admin_verify_no_data_in_claim_item_popup_of_claim_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminClaims.goToAddItem()
        );
        theActorInTheSpotlight().attemptsTo(
                Click.on(AdminClaimsPage.SELECT_ITEM_TEXTBOX).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(CommonAdminForm.NO_DATA),
                // Verify
                Ensure.that(CommonAdminForm.NO_DATA).isDisplayed()
        );
    }

    @And("Admin verify affected products in claim detail")
    public void admin_verify_affected_products_in_claim_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    // Verify
                    Ensure.that(AdminClaimsPage.BRAND_AFFECTED(info.get("skuID"))).text().contains(info.get("brand")),
                    Ensure.that(AdminClaimsPage.PRODUCT_AFFECTED(info.get("skuID"))).text().contains(info.get("product")),
                    Ensure.that(AdminClaimsPage.SKU_AFFECTED(info.get("skuID"))).text().contains(info.get("sku")),
                    Ensure.that(AdminClaimsPage.SKU_ID_AFFECTED(info.get("skuID"))).text().contains(info.get("skuID")),
                    Ensure.that(AdminClaimsPage.QUANTITY_AFFECTED(info.get("skuID"))).attribute("value").contains(info.get("quantity")),
                    Ensure.that(AdminClaimsPage.ACTION_AFFECTED(info.get("skuID"))).isDisplayed()
            );
        }
    }

    @And("Admin save claim in claim detail then see message {string}")
    public void admin_save_claim_in_claim_detail(String message) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    @And("Admin save claims after edit")
    public void admin_save_claim_after_edit() {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminClaims.save()
        );
    }

    @And("Admin remove item {string} has been added in claim detail")
    public void admin_remove_item_has_been_in_claim_detail(String sku) {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminClaims.removeLineItem(sku)
        );
    }

    @And("Admin upload picture in claims detail")
    public void admin_upload_picture_in_claims_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminClaims.uploadPictureInDetail(infos),
                HandleAdminClaims.saveActionPicture()
        );
    }

    @And("Admin remove picture in claims detail")
    public void admin_remove_picture_in_claims_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminClaims.removePictureInDetail(),
                HandleAdminClaims.saveActionPicture()
        );
    }

    @And("Admin verify download picture {string} in claims detail")
    public void admin_verify_download_picture_in_claims_detail(String picture) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminClaimsPage.DOWNLOAD_PICTURE_BUTTON),
                Click.on(AdminClaimsPage.DOWNLOAD_PICTURE_BUTTON),
                WindowTask.threadSleep(2000),
                WindowTask.switchToChildWindowsByTitle(picture),
                WindowTask.switchToChildWindowsByTitle("Claim ")
        );
    }
}

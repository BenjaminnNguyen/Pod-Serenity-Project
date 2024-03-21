package steps.buyer.orders;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.claims.AdminClaimsPage;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.LoginForm;
import cucumber.user_interface.beta.Vendor.products.VendorCreateProductPage;
import io.cucumber.java.en.*;
import cucumber.tasks.buyer.orders.HandleClaim;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.Buyer.orders.BuyerClaimPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Clear;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Hit;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class ClaimAndInquiryStepDefinitions {

    @And("Buyer go to claim page")
    public void buyer_go_to_claim_page() {
        theActorInTheSpotlight().attemptsTo(
                HandleClaim.goToClaimPage()
        );
    }

    @And("Buyer go to claim page by url")
    public void buyer_go_to_claim_page_by_url() {
        theActorInTheSpotlight().attemptsTo(
                HandleClaim.goToClaimPageByUrl()
        );
    }

    @And("Buyer verify info default of claim page")
    public void buyer_verify_info_default_of_claim_page(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(BuyerClaimPage.COMPANY_TEXTBOX).attribute("value").contains(expected.get(0).get("company")),
                Ensure.that(BuyerClaimPage.EMAIL_TEXTBOX).attribute("value").contains(expected.get(0).get("email")),
                Ensure.that(BuyerClaimPage.INVOICE_TEXTBOX).attribute("value").contains(expected.get(0).get("invoice"))
        );
    }

    @And("Head buyer verify info default of claim page")
    public void head_buyer_verify_info_default_of_claim_page(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(BuyerClaimPage.STORE_TEXTBOX).attribute("value").contains(""),
                Ensure.that(BuyerClaimPage.EMAIL_TEXTBOX).attribute("value").contains(expected.get(0).get("email")),
                Ensure.that(BuyerClaimPage.INVOICE_TEXTBOX_DISABLE).isDisplayed()
        );
    }
    @And("Guest verify info default of claim page")
    public void guest_verify_info_default_of_claim_page() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(BuyerClaimPage.COMPANY_TEXTBOX).attribute("value").contains(""),
                Ensure.that(BuyerClaimPage.EMAIL_TEXTBOX).attribute("value").contains(""),
                Ensure.that(BuyerClaimPage.INVOICE_TEXTBOX).attribute("value").contains(""),
                Ensure.that(BuyerClaimPage.AFFECTED_PRODUCT_TEXTAREA).isDisplayed()
        );
    }

    @And("Buyer fill info to claim of invoice {string}")
    public void buyer_fill_info_to_claim(String type, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String invoice = null;
        if (type.equals("")) {
            invoice = Serenity.sessionVariableCalled("ID Invoice").toString();
        }
        if (type.equals("create by api")) {
            invoice = Serenity.sessionVariableCalled("Sub-invoice ID create by admin").toString();
        }
        if (type.equals("create by buyer")) {
            invoice = Serenity.sessionVariableCalled("ID Invoice").toString();
        }
        theActorInTheSpotlight().attemptsTo(
                HandleClaim.fillInfoToClaimBuyer(invoice, infos.get(0))
        );
    }
    @And("Guest fill info to claim of invoice")
    public void buyer_fill_info_to_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleClaim.guestFillInfoToClaim(infos.get(0))
        );
    }

    @And("Guest upload file to claim")
    public void guest_upload_file_to_claim(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleClaim.uploadFile(infos)
        );
    }

    @And("Guest verify message error {string}")
    public void guest_verify_message_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerClaimPage.MESSAGE_SUCCESS(message))
        );
    }

    @And("Buyer finish form claim with message {string}")
    public void buyer_finish_form_claim(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleClaim.finishFormClaimSuccess(message)
        );
    }

    @And("Buyer finish form claim with message error {string}")
    public void buyer_finish_form_claim_with_message_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleClaim.finishFormClaimError(message)
        );
    }

    @And("Buyer submit another claim by button here")
    public void buyer_submit_another_claim_by_button_here() {
        theActorInTheSpotlight().attemptsTo(
                HandleClaim.reSubmitClaimByHere()
        );
    }

    @And("Guest verify info blank field of claim page")
    public void guest_verify_infoblank_field_of_claim_page() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_BUTTON("Submit")),
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Submit")),
                // Verify
                Ensure.that(BuyerClaimPage.COMPANY_ERROR_LABEL).text().contains("This field cannot be blank"),
                Ensure.that(BuyerClaimPage.EMAIL_ERROR_LABEL).text().contains("This field cannot be blank"),
                Ensure.that(BuyerClaimPage.INVOICE_ERROR_LABEL).text().contains("This field cannot be blank"),
                Ensure.that(BuyerClaimPage.AFFECTED_ERROR_LABEL).text().contains("This field cannot be blank")
        );
    }

    @And("Head buyer verify info blank field of claim page")
    public void head_buyer_verify_infoblank_field_of_claim_page() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonBuyerPage.DYNAMIC_BUTTON("Submit")),
                Clear.field(BuyerClaimPage.EMAIL_TEXTBOX),
                Click.on(BuyerClaimPage.EMAIL_TEXTBOX),
                Hit.the(Keys.BACK_SPACE).into(BuyerClaimPage.EMAIL_TEXTBOX),
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Submit")),
                // Verify
                CommonWaitUntil.isNotVisible(VendorCreateProductPage.DYNAMIC_ALERT_TEXT("Please correct the errors on this form before continuing.")),
                Ensure.that(BuyerClaimPage.STORE_ERROR_LABEL).text().contains("This field cannot be blank"),
                Ensure.that(BuyerClaimPage.INVOICE_ERROR_LABEL).text().contains("This field cannot be blank"),
                Ensure.that(BuyerClaimPage.ISSUE_ERROR_LABEL).text().contains("This field cannot be blank")
        );
    }

    @And("Buyer finish form claim when store inactive")
    public void buyer_finish_form_claim_when_store_inactive() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonBuyerPage.DYNAMIC_BUTTON("Submit")),
                WindowTask.threadSleep(2000),
                // Verify
                Ensure.that(LoginForm.LOGIN_BUTTON).isDisplayed()
        );
    }

    @And("Buyer verify field invoice in claim form")
    public void buyer_verify_field_invoice_in_claim_form() {
        theActorInTheSpotlight().attemptsTo(
                Enter.theValue("1231241231").into(BuyerClaimPage.INVOICE_TEXTBOX),
                // verify dropdown nodata
                CommonWaitUntil.isVisible(CommonBuyerPage.NO_DATA_DROPDOWN),
                Ensure.that(CommonBuyerPage.NO_DATA_DROPDOWN).isDisplayed(),
                Hit.the(Keys.ESCAPE).into(BuyerClaimPage.INVOICE_TEXTBOX)
        );
    }

    @And("Head buyer verify field invoice in claim form")
    public void head_buyer_verify_field_invoice_in_claim_form(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTask.chooseItemInDropdownWithValueInput1(BuyerClaimPage.STORE_TEXTBOX, infos.get(0).get("store"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(infos.get(0).get("store"))),
                Enter.theValue("123").into(BuyerClaimPage.INVOICE_TEXTBOX),
                // verify dropdown nodata
                CommonWaitUntil.isVisible(CommonBuyerPage.NO_DATA_DROPDOWN),
                Ensure.that(CommonBuyerPage.NO_DATA_DROPDOWN).isDisplayed(),
                Hit.the(Keys.ESCAPE).into(BuyerClaimPage.INVOICE_TEXTBOX)
        );
    }

    @And("Buyer check sku in affected products in claim form")
    public void buyer_check_sku_in_affectec_product(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleClaim.chooseSkuAffected(info)
            );
        }
    }

    @And("Head buyer check sku in affected products in claim form")
    public void head_buyer_check_sku_in_affectec_product(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleClaim.chooseSkuAffected(info)
            );
        }
    }

    @And("Admin check sku in affected products in claim form")
    public void admin_check_sku_in_affectec_product(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleClaim.adminChooseSkuAffected(info)
            );
        }
    }
    @And("Buyer verify affected products in claim form")
    public void buyer_verify_sku_in_affectec_product(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerClaimPage.SKU_AFFECTED_CHECKBOX(info.get("sku"))).isDisplayed(),
                    Ensure.that(BuyerClaimPage.QUANTITY_AFFECTED_CHECKBOX(info.get("sku"))).attributeValues("value").contains("1")
            );
        }
    }

    @And("Head buyer fill info to claim of invoice {string}")
    public void head_buyer_fill_info_to_claim(String type, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String invoice = null;
        if (type.equals("")) {
            invoice = Serenity.sessionVariableCalled("ID Invoice").toString();
        }
        if (type.equals("create by api")) {
            invoice = Serenity.sessionVariableCalled("Sub-invoice ID create by admin").toString();
        }
        if (type.equals("create by buyer")) {
            invoice = Serenity.sessionVariableCalled("ID Invoice").toString();
        }
        theActorInTheSpotlight().attemptsTo(
                HandleClaim.fillInfoToClaimHeadBuyer(invoice, infos.get(0))
        );
    }

    @And("Head buyer verify field store in claim form")
    public void head_buyer_verify_field_store_in_claim_form() {
        theActorInTheSpotlight().attemptsTo(
                Enter.theValue("123").into(BuyerClaimPage.STORE_TEXTBOX),
                // verify dropdown nodata
                CommonWaitUntil.isVisible(CommonBuyerPage.NO_DATA_DROPDOWN),
                Ensure.that(CommonBuyerPage.NO_DATA_DROPDOWN).isDisplayed(),
                Hit.the(Keys.ESCAPE).into(BuyerClaimPage.STORE_TEXTBOX)
        );
    }

    @And("Admin check sku not check in affected products in claim form")
    public void admin_check_sku_in_affectec_product() {
            theActorInTheSpotlight().attemptsTo(
                    Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                    CommonWaitUntil.isVisible(AdminClaimsPage.D_ERROR("Affected products"))
            );
        }
}

package steps.onboard;

import io.cucumber.java.en.*;
import cucumber.tasks.buyer.addtocart.AddToCart;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.onboard.HandleOnboardBuyer;
import cucumber.tasks.vendor.VendorDashboardTask;
import cucumber.user_interface.beta.Buyer.setting.GeneralPage;
import cucumber.user_interface.beta.Onboarding.BuyerOnboardingPage;
import cucumber.user_interface.beta.Onboarding.RegisterPage;
import cucumber.user_interface.beta.Vendor.VendorDashboardPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class BuyerOnboardingStepDefinition {

    @And("User verify info Receiving in Retailer Details")
    public void verify_receiving_in_retailer_details(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerOnboardingPage.WELCOME_HEADER),
                Click.on(BuyerOnboardingPage.CONTINUE_BUTTON),
                CommonWaitUntil.isVisible(RegisterPage.D_TEXTBOX_INFO_COMPANY("Delivery Street Address")),
                Ensure.that(RegisterPage.D_TEXTBOX_INFO_COMPANY("Delivery Street Address")).attribute("value").contains(expected.get(0).get("address")),
                Ensure.that(RegisterPage.D_TEXTBOX_INFO_COMPANY("City")).attribute("value").contains(expected.get(0).get("city")),
                Ensure.that(RegisterPage.D_TEXTBOX_INFO_COMPANY("State/Province")).attribute("value").contains(expected.get(0).get("state")),
                Ensure.that(RegisterPage.D_TEXTBOX_INFO_COMPANY("Zip/Code")).attribute("value").contains(expected.get(0).get("zip")),
                Ensure.that(RegisterPage.D_TEXTBOX_INFO_COMPANY("Store Phone number")).attribute("value").contains(expected.get(0).get("phone")),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Earliest time")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Latest time")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Delivery Instructions")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Delivery Instructions")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.CHECKBOX_CHECKED).isNotDisplayed(),
                Ensure.that(BuyerOnboardingPage.LABEL_CHECKED).isNotDisplayed()
        );
    }

    @And("User fill info Receiving in Retailer Details")
    public void user_fill_info_receiving_in_retailer_details(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOnboardBuyer.fillReceiving(infos.get(0))
        );
    }

    @And("User fill info Buying in Retailer Details")
    public void user_fill_info_buying_in_retailer_details(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOnboardBuyer.fillBuying(infos.get(0))
        );
    }

    @And("User verify field empty Buying in Retailer Details")
    public void verify_buying_in_retailer_details() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Department Buyer Name")),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Department Buyer Name")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Department Buyer Email")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Department Buyer Phone Number")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Additional Department")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Additional Department Buyer Name")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Additional Department Buyer Email")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTAREA("Additional Department Infomation")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.CHECKBOX_CHECKED).isNotDisplayed(),
                Ensure.that(BuyerOnboardingPage.LABEL_CHECKED).isNotDisplayed()
        );
    }

    @And("User verify field empty Trade references in Retailer Details")
    public void verify_trade_references_in_retailer_details() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerOnboardingPage.DYNAMIC_TEXTAREA("Trade Reference 1")),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTAREA("Trade Reference 1")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTAREA("Trade Reference 2")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTAREA("Trade Reference 3")).attribute("value").contains("")
        );
    }

    @And("User fill info Trade references in Retailer Details")
    public void user_fill_info_trade_references_in_retailer_details(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOnboardBuyer.fillTradeReferences(infos.get(0))
        );
    }

    @And("User fill info Financial in Retailer Details")
    public void user_fill_info_financial_in_retailer_details(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOnboardBuyer.fillFinancial(infos.get(0))
        );
    }

    @And("User verify field empty Financial in Retailer Details")
    public void verify_financial_in_retailer_details() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Accounts Payable Name")),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Accounts Payable Name")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Accounts Payable Email")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Accounts Payable Phone")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Accounts Payable Mailing Address")).attribute("value").contains(""),
                Ensure.that(BuyerOnboardingPage.LABEL_CHECKED).isDisplayed()
        );
    }

    @And("User upload file Certificated")
    public void upload_file_certificated(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleOnboardBuyer.uploadCertificates(infos.get(0))
        );
    }

    @And("User verify empty in Certificate")
    public void verify_empty_in_certificate() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isPresent(BuyerOnboardingPage.DYNAMIC_UPLOAD_FILE("Business License Certificate")),
                Ensure.that(BuyerOnboardingPage.FILENAME_UPLOADED("anhJPEG.jpg")).isNotDisplayed(),
                Ensure.that(BuyerOnboardingPage.FILENAME_UPLOADED("anhPNG.png")).isNotDisplayed(),
                Ensure.that(BuyerOnboardingPage.DESCRIPTION_CERTIFICATE).isDisplayed()
        );
    }

    @And("User verify after upload in Certificate")
    public void verify_after_upload_in_certificate() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerOnboardingPage.DYNAMIC_BUTTON("Submit")),
                Click.on(BuyerOnboardingPage.PREVIOUS_STEP),
                CommonWaitUntil.isPresent(BuyerOnboardingPage.DYNAMIC_UPLOAD_FILE("Business License Certificate")),
                Ensure.that(BuyerOnboardingPage.FILENAME_UPLOADED("anhJPEG.jpg")).isDisplayed(),
                Ensure.that(BuyerOnboardingPage.FILENAME_UPLOADED("anhPNG.png")).isDisplayed(),
                Ensure.that(BuyerOnboardingPage.DESCRIPTION_CERTIFICATE).isDisplayed(),
                Click.on(BuyerOnboardingPage.NEXT_BUTTON)
        );
    }

    @And("User verify Review Tos in Certificate")
    public void verify_review_to_in_certificate(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerOnboardingPage.TERM_OF_USER),
                Ensure.that(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Name")).attribute("value").contains(expected.get(0).get("name")),
                Ensure.that(BuyerOnboardingPage.TODAY_DATE).attribute("value").contains(CommonHandle.setDate(expected.get(0).get("date"), "MM/dd/yy")),
                Ensure.that(BuyerOnboardingPage.TERM_OF_USER).isDisplayed(),
                Ensure.that(BuyerOnboardingPage.CHECKBOX_CHECKED).isNotDisplayed()
        );
    }

    @And("User check Term in Review Tos")
    public void check_term_in_review_tos() {
        theActorInTheSpotlight().attemptsTo(
                HandleOnboardBuyer.fillReviewTos()
        );
    }

    @And("User summit to finish")
    public void summit_to_finish() {
        theActorInTheSpotlight().attemptsTo(
                HandleOnboardBuyer.submit()
        );
    }

    @And("User go to General Page")
    public void go_to_general_page() {
        theActorInTheSpotlight().attemptsTo(
                HandleOnboardBuyer.goToGeneralSetting()
        );
    }

    @And("User verify Personal Information in General Settings")
    public void verify_personal_infomation(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(GeneralPage.DYNAMIC_FIELD("First name")),
                Ensure.that(GeneralPage.DYNAMIC_FIELD("First name")).text().contains(expected.get(0).get("firstName")),
                Ensure.that(GeneralPage.DYNAMIC_FIELD("Last name")).text().contains(expected.get(0).get("lastName")),
//                Ensure.that(GeneralPage.DYNAMIC_FIELD("Email")).text().contains(Serenity.sessionVariableCalled("Email Onboard").toString()),
                Ensure.that(GeneralPage.DYNAMIC_FIELD("Phone Number")).text().contains(expected.get(0).get("phone"))
        );
    }

    @And("User verify Store Information in General Settings")
    public void verify_store_infomation(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
//                Ensure.that(GeneralPage.DYNAMIC_FIELD("Business Name")).text().contains(Serenity.sessionVariableCalled("Onboard Name Company DBA").toString()),
                Ensure.that(GeneralPage.DYNAMIC_FIELD("Business Phone")).text().contains(expected.get(0).get("phoneBusiness")),
                Ensure.that(GeneralPage.DYNAMIC_FIELD("Store Type")).text().contains(expected.get(0).get("typeStore")),
                Ensure.that(GeneralPage.DYNAMIC_FIELD("Store Size")).text().contains(expected.get(0).get("sizeStore")),
                Ensure.that(GeneralPage.DYNAMIC_FIELD("Address")).text().contains(expected.get(0).get("address")),
                Ensure.that(GeneralPage.DYNAMIC_FIELD("Time Zone")).text().contains(expected.get(0).get("timeZone"))
        );
    }

    @And("User verify Company Information in General Settings")
    public void verify_company_infomation(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
//                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(GeneralPage.DYNAMIC_FIELD("Company name")),
//                Ensure.that(GeneralPage.DYNAMIC_FIELD("Company name")).text().contains(Serenity.sessionVariableCalled("Onboard Name Company").toString()),
                Ensure.that(GeneralPage.DYNAMIC_FIELD("EIN")).text().contains(expected.get(0).get("ein")),
                Ensure.that(GeneralPage.DYNAMIC_FIELD("Documents")).text().contains(expected.get(0).get("document")),
                Ensure.that(GeneralPage.DYNAMIC_IMAGE("Business License Certificates")).text().contains(expected.get(0).get("businessCerti")),
                Ensure.that(GeneralPage.DYNAMIC_IMAGE("Resale Certificates")).text().contains(expected.get(0).get("resaleCerti"))
        );
    }

    @And("User verify message under review {string} in page {string} and {string}")
    public void verify_message_under_review_in_page(String type, String page, String message) {
        theActorInTheSpotlight().attemptsTo(
                VendorDashboardTask.navigate(page, VendorDashboardPage.OPTION(page)),
                Check.whether(type.equals("not display"))
                        .andIfSo(Ensure.that(BuyerOnboardingPage.WARNING_MESSAGE).isNotDisplayed())
                        .otherwise(
                                CommonWaitUntil.isVisible(BuyerOnboardingPage.WARNING_MESSAGE),
                                Ensure.that(BuyerOnboardingPage.WARNING_MESSAGE).isDisplayed()),
                Check.whether(message.equals(""))
                        .otherwise(
                                CommonWaitUntil.isVisible(BuyerOnboardingPage.NO_RESULT(message)),
                                Ensure.that(BuyerOnboardingPage.NO_RESULT(message)).isDisplayed())
        );
    }

    @And("User verify can't add to cart of product {string}")
    public void verify_cant_add_to_cart(String productName) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue("Product", productName),
                HandleOnboardBuyer.cantAddToCart(productName)
        );
    }

    @And("User verify don't see add to cart of product {string} in product detail")
    public void verify_see_add_to_cart_in_detail(String productName) {
        theActorInTheSpotlight().attemptsTo(
                AddToCart.searchByValue("Product", productName),
                HandleOnboardBuyer.dontSeeAddToCart(productName)
        );
    }

    @And("User check brand {string} of state {string}")
    public void verify_check_brand(String brandName, String state) {
        theActorInTheSpotlight().attemptsTo(

        );
    }
}


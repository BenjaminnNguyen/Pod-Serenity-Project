package cucumber.tasks.onboard;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.user_interface.beta.Buyer.products.BuyerProductDetailPage;
import cucumber.user_interface.beta.Buyer.setting.GeneralPage;
import cucumber.user_interface.beta.DashBoardForm;
import cucumber.user_interface.beta.HomePageForm;
import cucumber.user_interface.beta.Onboarding.BuyerOnboardingPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.Map;

public class HandleOnboardBuyer {

    public static Task fillReceiving(Map<String, String> info) {
        return Task.where("Fill info in receiving of Retailer Details",
                Click.on(BuyerOnboardingPage.RECEIVING_DAYS(info.get("receivingDay"))),
                Enter.keyValues(info.get("earliestTime")).into(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Earliest time")).thenHit(Keys.ENTER),
                Enter.keyValues(info.get("latestTime")).into(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Latest time")).thenHit(Keys.ENTER),
                Enter.keyValues(info.get("deliveryInstructions")).into(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Delivery Instructions")),
                Enter.keyValues(info.get("deliveryNote")).into(BuyerOnboardingPage.DYNAMIC_TEXTAREA("Delivery Note")),
                Click.on(BuyerOnboardingPage.LIFTDATE(info.get("liftDate"))),
                Click.on(BuyerOnboardingPage.PALLETS(info.get("pallets"))),
                Click.on(BuyerOnboardingPage.DYNAMIC_BUTTON("Next"))
        );
    }

    public static Task fillBuying(Map<String, String> info) {
        return Task.where("Fill info in Buying of Retailer Details",
                JavaScriptClick.on(BuyerOnboardingPage.DYNAMIC_CHECKBOX(info.get("prefered"))),
                JavaScriptClick.on(BuyerOnboardingPage.DYNAMIC_CHECKBOX(info.get("category"))),
                Enter.keyValues(info.get("departmentBuyerName")).into(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Department Buyer Name")),
                Enter.keyValues(info.get("departmentBuyerEmail")).into(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Department Buyer Email")),
                Enter.keyValues(info.get("departmentBuyerPhone")).into(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Department Buyer Phone Number")),
                Enter.keyValues(info.get("additionalDepartment")).into(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Additional Department")),
                Enter.keyValues(info.get("additionalDepartmentBuyerName")).into(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Additional Department Buyer Name")),
                Enter.keyValues(info.get("additionalDepartmentBuyerEmail")).into(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Additional Department Buyer Email")),
                Enter.keyValues(info.get("additionalDepartmentBuyerInfo")).into(BuyerOnboardingPage.DYNAMIC_TEXTAREA("Additional Department Infomation")),
                Click.on(BuyerOnboardingPage.INTERESTED(info.get("interested"))),
                Click.on(BuyerOnboardingPage.DYNAMIC_BUTTON("Next"))
                );
    }

    public static Task fillTradeReferences(Map<String, String> info) {
        return Task.where("Fill info in Trade references of Retailer Details",
                CommonWaitUntil.isVisible(BuyerOnboardingPage.DYNAMIC_TEXTAREA("Trade Reference 1")),
                Enter.keyValues(info.get("trade1")).into(BuyerOnboardingPage.DYNAMIC_TEXTAREA("Trade Reference 1")),
                Enter.keyValues(info.get("trade2")).into(BuyerOnboardingPage.DYNAMIC_TEXTAREA("Trade Reference 2")),
                Enter.keyValues(info.get("trade3")).into(BuyerOnboardingPage.DYNAMIC_TEXTAREA("Trade Reference 3")),
                Click.on(BuyerOnboardingPage.DYNAMIC_BUTTON("Next"))
        );
    }

    public static Task fillFinancial(Map<String, String> info) {
        return Task.where("Fill info in Financial of Retailer Details",
                CommonWaitUntil.isVisible(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Accounts Payable Name")),
                Enter.keyValues(info.get("accountPlayableName")).into(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Accounts Payable Name")),
                Enter.keyValues(info.get("accountPlayableEmail")).into(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Accounts Payable Email")),
                Enter.keyValues(info.get("accountPlayablePhone")).into(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Accounts Payable Phone")),
                Enter.keyValues(info.get("accountPlayableMailingAddress")).into(BuyerOnboardingPage.DYNAMIC_TEXTBOX("Accounts Payable Mailing Address")),
                Click.on(BuyerOnboardingPage.BANKRUPTCY(info.get("bankruptcy"))),
                Click.on(BuyerOnboardingPage.RECEIVE_INVOICE(info.get("receiveInvoice"))),
                Click.on(BuyerOnboardingPage.DYNAMIC_BUTTON("Next"))
        );
    }

    public static Task uploadCertificates(Map<String, String> info) {
        return Task.where("Upload file certificates",
                CommonWaitUntil.isPresent(BuyerOnboardingPage.DYNAMIC_UPLOAD_FILE("Business License Certificate")),
                CommonFile.upload(info.get("businessCertificate"), BuyerOnboardingPage.DYNAMIC_UPLOAD_FILE("Business License Certificate")),
                CommonFile.upload(info.get("resaleCertificate"), BuyerOnboardingPage.DYNAMIC_UPLOAD_FILE("Resale Certificate")),
                CommonWaitUntil.isClickable(BuyerOnboardingPage.SAVE_BUTTON),
                Click.on(BuyerOnboardingPage.SAVE_BUTTON)

        );
    }

    public static Task fillReviewTos() {
        return Task.where("Check term of use in Review Tos",
                CommonWaitUntil.isVisible(BuyerOnboardingPage.TERM_OF_USER),
                Click.on(BuyerOnboardingPage.CHECKBOX_REVIEW_TOS)
        );
    }

    public static Task submit() {
        return Task.where("Submit to finish create onboard",
                CommonWaitUntil.isClickable(BuyerOnboardingPage.DYNAMIC_BUTTON("Submit")),
                Click.on(BuyerOnboardingPage.DYNAMIC_BUTTON("Submit")),
                CommonWaitUntil.isVisible(BuyerOnboardingPage.TASKS_COMPLETED),
                Click.on(BuyerOnboardingPage.DYNAMIC_BUTTON("Browse Catalog"))
        );
    }

    public static Task goToGeneralSetting() {
        return Task.where("Go to General Setting",
                CommonWaitUntil.isVisible(DashBoardForm.DASHBOARD_BUTTON),
                Click.on(DashBoardForm.DASHBOARD_BUTTON),
                CommonWaitUntil.isVisible(DashBoardForm.SETTINGS_BUTTON),
                Click.on(DashBoardForm.SETTINGS_BUTTON),
                CommonWaitUntil.isVisible(GeneralPage.GENERAL_BUTTON),
                Click.on(GeneralPage.GENERAL_BUTTON),
                CommonWaitUntil.isVisible(GeneralPage.GENERAL_HEADER)
        );
    }

    public static Task cantAddToCart(String productName) {
        return Task.where("Can't add to cart ",
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                MoveMouse.to(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                Ensure.that(HomePageForm.ADD_TO_CART_TOOLTIP_BY_PRODUCT(productName)).isNotDisplayed()
        );
    }

    public static Task dontSeeAddToCart(String productName) {
        return Task.where("Don't see add to cart ",
                CommonWaitUntil.isVisible(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                Click.on(HomePageForm.PRODUCT_IN_CATALOG_LABEL(productName)),
                CommonWaitUntil.isNotVisible(BuyerProductDetailPage.ADD_TO_CART_BUTTON),
                Ensure.that(BuyerProductDetailPage.ADD_TO_CART_BUTTON).isNotDisplayed()
        );
    }
}

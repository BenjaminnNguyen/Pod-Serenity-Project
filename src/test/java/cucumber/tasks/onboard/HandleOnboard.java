package cucumber.tasks.onboard;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.HomePageForm;
import cucumber.user_interface.beta.Onboarding.BuyerOnboardingPage;
import cucumber.user_interface.beta.Onboarding.RegisterPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleOnboard {

    public static Task fillInfo(Map<String, String> info) {
        return Task.where("Register",
                CommonWaitUntil.isVisible(RegisterPage.DYNAMIC_TEXTBOX("Company name")),
                Enter.theValue(info.get("nameCompany")).into(RegisterPage.DYNAMIC_TEXTBOX("Company name")),
                Enter.theValue(info.get("email")).into(RegisterPage.DYNAMIC_TEXTBOX("Business email")),
                Enter.theValue(info.get("website")).into(RegisterPage.DYNAMIC_TEXTBOX("Website")),
                CommonTask.chooseItemInDropdown(
                        RegisterPage.DYNAMIC_TEXTBOX("How did you hear about Pod Foods?"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(info.get("hear"))),
                Enter.theValue(info.get("comment")).into(RegisterPage.COMMENT_TEXTAREA)
        );
    }

    public static Task fillInfoOfRole(Map<String, String> info) {
        return Task.where("fill info of role",
                Scroll.to(RegisterPage.DYNAMIC_TEXTBOX("Website")),
                CommonTask.chooseItemInDropdown1(RegisterPage.DYNAMIC_TEXTBOX("Contact type"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(info.get("role"))),
                Enter.theValue(info.get("firstname")).into(RegisterPage.DYNAMIC_TEXTBOX("First name")),
                Enter.theValue(info.get("lastname")).into(RegisterPage.DYNAMIC_TEXTBOX("Last name")),
                Check.whether(info.get("role").equals("Broker"))
                        .otherwise(
                                Enter.theValue(info.get("phone")).into(RegisterPage.DYNAMIC_TEXTBOX("Phone number")),
                                Enter.theValue(info.get("contactRole")).into(RegisterPage.DYNAMIC_TEXTBOX("Job title"))),
                Enter.theValue(info.get("businessAddress")).into(RegisterPage.DYNAMIC_TEXTBOX("Business address")),
                Enter.theValue(info.get("ein")).into(RegisterPage.DYNAMIC_TEXTBOX("EIN (Employer Identification Number)")),
                Check.whether(info.get("role").equals("Retailer"))
                        .andIfSo(
                                Click.on(RegisterPage.CHECKBOX_AGREE))
        );
    }

    public static Task chooseRegion(String region) {
        return Task.where("Choose region",
                Click.on(RegisterPage.DYNAMIC_REGION(region))
        );
    }

    public static Task chooseCategory(String category) {
        return Task.where("Choose category",
                Click.on(RegisterPage.DYNAMIC_REGION(category))
        );
    }

    public static Task fillAbountCompany(Map<String, String> info) {
        return Task.where("Fill info about your company",
                CommonWaitUntil.isVisible(RegisterPage.D_TEXTBOX_INFO_COMPANY("Company name")),
                Enter.theValue(info.get("nameCompany")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("Company name")),
                Enter.theValue(info.get("nameCompanyDBA")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("Company name (DBA)")),
                Enter.theValue(info.get("date")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("Date company established")).thenHit(Keys.ENTER),
                Enter.theValue(info.get("fein")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("FEIN/Federal tax ID")),
                Enter.theValue(info.get("email")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("Contact email")),
                Enter.theValue(info.get("storePhone")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("Store phone number")),
                CommonTask.chooseItemInDropdown(RegisterPage.D_TEXTBOX_INFO_COMPANY("Store size"), RegisterPage.D_ITEM_DROPDOWN(info.get("storeSize"))),
                CommonTask.chooseItemInDropdown(RegisterPage.D_TEXTBOX_INFO_COMPANY("Store types"), RegisterPage.D_ITEM_DROPDOWN(info.get("storeTypes"))),
                Click.on(RegisterPage.DYNAMIC_BUTTON("Next"))
        );
    }

    public static Task fillCompanyAddress(Map<String, String> info) {
        return Task.where("Fill info your company address",
                CommonWaitUntil.isVisible(RegisterPage.D_TEXTBOX_INFO_COMPANY("Company street address 1")),
                Enter.theValue(info.get("address1")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("Company street address 1")),
                Enter.theValue(info.get("address2")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("Company street address 2")),
                Enter.theValue(info.get("city")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("City")),
                CommonTask.chooseItemInDropdown(RegisterPage.D_TEXTBOX_INFO_COMPANY("State/Province"), RegisterPage.D_STATE_ITEM(info.get("state"))),
                Enter.theValue(info.get("zip")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("Zip/Portal code")),
                CommonTask.chooseItemInDropdown(RegisterPage.D_TEXTBOX_INFO_COMPANY("Time zone"), RegisterPage.D_ITEM_DROPDOWN(info.get("timeZone"))),
                Click.on(RegisterPage.DYNAMIC_BUTTON("Next"))
        );
    }

    public static Task fillAccount(Map<String, String> info) {
        return Task.where("Fill info your account",
                CommonWaitUntil.isVisible(RegisterPage.D_TEXTBOX_INFO_COMPANY("First name")),
                Enter.theValue(info.get("firstName")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("First name")),
                Enter.theValue(info.get("lastName")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("Last name")),
                Enter.theValue(info.get("email")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("Login email")),
                Enter.theValue(info.get("phone")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("Contact phone number")),
                Enter.theValue(info.get("password")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("Account password")),
                Enter.theValue(info.get("confirmPass")).into(RegisterPage.D_TEXTBOX_INFO_COMPANY("Confirm password"))
        );
    }

    public static Task getStartedThenLogin() {
        return Task.where("Get started",
                Click.on(RegisterPage.DYNAMIC_BUTTON("Get started")),
                CommonWaitUntil.isVisible(RegisterPage.DYNAMIC_BUTTON("Login")),
                Click.on(RegisterPage.DYNAMIC_BUTTON("Login"))
        );
    }

    public static Task fillRetailerDetail() {
        return Task.where("Get started",
                Click.on(RegisterPage.DYNAMIC_BUTTON("Get started")),
                CommonWaitUntil.isVisible(BuyerOnboardingPage.WELCOME_HEADER),
                Click.on(BuyerOnboardingPage.CONTINUE_BUTTON)
        );
    }
}

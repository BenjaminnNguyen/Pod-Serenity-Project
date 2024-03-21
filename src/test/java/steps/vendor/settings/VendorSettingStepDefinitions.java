package steps.vendor.settings;

import cucumber.constants.buyer.WebsiteBuyerConstants;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.tasks.vendor.setting.HandleVendorGeneralSetting;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.HomePageForm;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.setting.VendorSettingGeneralPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Switch;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.WebElement;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class VendorSettingStepDefinitions {

    @And("Vendor go to general")
    public void vendor_go_to_general() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToGeneralSetting()
        );
    }

    @And("Vendor verify company information in general settings")
    public void vendor_verify_company_information_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_INFO("Company name")),
                Ensure.that(VendorSettingGeneralPage.D_INFO("Company name")).text().contains(infos.get(0).get("companyName")),
                Ensure.that(VendorSettingGeneralPage.D_INFO("EIN")).text().contains(infos.get(0).get("ein")),
                Ensure.that(VendorSettingGeneralPage.D_INFO("Business email")).text().contains(infos.get(0).get("email")),
                Ensure.that(VendorSettingGeneralPage.D_INFO("Business phone")).text().contains(infos.get(0).get("phone")),
                Ensure.that(VendorSettingGeneralPage.WEBSITE_COMPANY_INFO).text().contains(infos.get(0).get("website")),
                Ensure.that(VendorSettingGeneralPage.D_INFO("Company Size (estimated monthly revenue)")).text().contains(infos.get(0).get("size")),
                Ensure.that(VendorSettingGeneralPage.ADDRESS_COMPANY_INFO).text().contains(infos.get(0).get("street")),
                Check.whether(infos.get(0).get("apt").equals(""))
                        .otherwise(Ensure.that(VendorSettingGeneralPage.ADDRESS_COMPANY_INFO).text().contains(infos.get(0).get("apt"))),
                Ensure.that(VendorSettingGeneralPage.ADDRESS_COMPANY_INFO).text().contains(infos.get(0).get("city")),
                Ensure.that(VendorSettingGeneralPage.ADDRESS_COMPANY_INFO).text().contains(infos.get(0).get("state")),
                Ensure.that(VendorSettingGeneralPage.ADDRESS_COMPANY_INFO).text().contains(infos.get(0).get("zip"))
        );
    }

    @And("Vendor go to edit company information in general settings")
    public void vendor_go_to_edit_company_information() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToEditCompany()
        );
    }

    @And("Vendor edit company information in general settings")
    public void vendor_edit_company_information_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.editStoreInformation(infos.get(0))
        );
    }

    @And("Vendor edit success in general settings")
    public void vendor_edit_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.editInfoSuccess()
        );
    }

    @And("Vendor verify info of edit company information in general settings")
    public void vendor_verify_info_of_edit_company_information_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Company name")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Company name")).attribute("value").contains(infos.get(0).get("companyName")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("EIN")).attribute("value").contains(infos.get(0).get("ein")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Company Size (estimated monthly revenue)")).attribute("value").contains(infos.get(0).get("size")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Email")).attribute("value").contains(infos.get(0).get("email")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Business phone")).attribute("value").contains(infos.get(0).get("phone")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Website")).attribute("value").contains(infos.get(0).get("website")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Street address")).attribute("value").contains(infos.get(0).get("street")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Apt, Suite, etc.")).attribute("value").contains(infos.get(0).get("apt")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("City")).attribute("value").contains(infos.get(0).get("city")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("State")).attribute("value").contains(infos.get(0).get("state")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Zip code")).attribute("value").contains(infos.get(0).get("zip"))
        );
    }

    @And("Vendor update company infor then see message {string}")
    public void vendor_see_message(String message) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    @And("Admin verify field company name in edit company info of setting")
    public void admin_verify_field_company_name() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToEditCompany(),

                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Company name")),
                // Company name blank
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Company name")),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Name can't be blank")),

                // Company name blank
                Enter.theValue("ngoc vc 1").into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Company name")),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Name has already been taken")),

                // Close popup
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON)
        );
    }

    @And("Admin verify field company zip code in edit company info of setting")
    public void admin_verify_field_zip_code() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToEditCompany(),

                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Zip code")),
                // Company name blank
                Enter.theValue("123").into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Zip code")),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Address zip is the wrong length (should be 5 characters)")),

                // Close popup
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON)
        );
    }

    @And("Vendor verify personal in general settings")
    public void vendor_verify_personal_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_INFO("Company name")),
                Ensure.that(VendorSettingGeneralPage.D_INFO("First name")).text().contains(infos.get(0).get("firstName")),
                Ensure.that(VendorSettingGeneralPage.D_INFO("Last name")).text().contains(infos.get(0).get("lastName")),
                Ensure.that(VendorSettingGeneralPage.D_INFO("Email")).text().contains(infos.get(0).get("email"))
        );
    }

    @And("Vendor go to edit personal in general settings")
    public void vendor_go_to_edit_personal() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToEditPersonal()
        );
    }

    @And("Vendor verify edit personal in general settings")
    public void vendor_verify_edit_personal_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")).attribute("value").contains(infos.get(0).get("firstName")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Last name")).attribute("value").contains(infos.get(0).get("lastName")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Email")).attribute("value").contains(infos.get(0).get("email"))
        );
        if(infos.get(0).containsKey("contactNumber")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Contact number")).attribute("value").contains(infos.get(0).get("contactNumber"))
            );
        }
    }

    @And("Vendor edit personal in general settings")
    public void vendor_edit_personal_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.editPersonal(infos.get(0))
        );
    }

    @And("Admin verify field in edit personal info of setting")
    public void admin_verify_field_in_personal() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToEditPersonal(),

                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                // field blank
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Last name")),
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Email")),
                // verify
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("First name")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("First name")).text().contains("Please input your first name"),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("Last name")).text().contains("Please input your last name"),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("Email")).text().contains("Please input a valid email address"),
                // close popup
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON)
        );
    }


    @And("Vendor go to change password in general settings")
    public void vendor_go_to_change_password() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToChangePassword()
        );
    }

    @And("Vendor verify field change password in general settings")
    public void vendor_verify_vield_change_password() {
        theActorInTheSpotlight().attemptsTo(
                // go to popup change password
                HandleVendorGeneralSetting.goToChangePassword(),

                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("Submit")),
                Click.on(CommonVendorPage.DYNAMIC_DIALOG_BUTTON("Submit")),
                // verify
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("Current password")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("Current password")).text().contains("Please input your current password"),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("New password")).text().contains("Please input your new password"),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("New password confirmation")).text().contains("Please input your password confirmation"),

                // verify new password
                Enter.theValue("123").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("New password")),
                WindowTask.threadSleep(500),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("New password")).text().contains("At least 1 letter, a number, at least 8 characters."),
                // close popup
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON)
        );
    }

    @And("Vendor change password in general settings")
    public void vendor_change_password(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.changePassword(infos.get(0))
        );
    }

    @And("Vendor change password success")
    public void vendor_change_password_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.changePasswordSuccess()
        );
    }

    @And("Vendor change password error then see message {string}")
    public void vendor_change_password_success(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.changePasswordError(message)
        );
    }

    /**
     * Minimums
     */

    @And("Vendor go to minimums")
    public void vendor_go_to_minimums() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToMinimums()
        );
    }

    @And("Vendor go to choose minimum type {string}")
    public void vendor_choose_minimum_type(String type) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.chooseMinimumsType(type)
        );
    }

    @And("Vendor edit minimum type mov in minimum")
    public void vendor_verify_field_in_minimum(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.editMinimumsToMOV(infos.get(0))
        );
    }

    @And("Vendor update minimum type then see message {string}")
    public void vendor_update_minimum_type_then_see_message(String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.updateMinimumError(message)
        );
    }

    @And("Vendor update minimum type success")
    public void vendor_update_minimum_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.updateMinimumSuccess()
        );
    }

    @And("Vendor go to invite colleagues")
    public void vendor_go_to_invite_colleagues() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToInviteColleagues()
        );
    }

    @And("Vendor verify field in invite colleagues")
    public void vendor_verify_field_in_invite_colleagues() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Invite")),
                // verify blank field
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("First name")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("First name")).text().contains("Required"),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("Last name")).text().contains("Required"),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("Email")).text().contains("Please enter a valid email"),
                // verify first name blank and too short,
                Enter.theValue(" ").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                Enter.theValue("autotest").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Last name")),
                Enter.theValue("test@gmail.com").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Email")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Invite")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("First name can't be blank")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("First name is too short (minimum is 1 character)")),

                // verify last name blank and too short,
                Enter.theValue("autotest").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                Enter.theValue(" ").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Last name")),
                Enter.theValue("test@gmail.com").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Email")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Invite")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Last name can't be blank")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Last name is too short (minimum is 1 character)")),

                // verify first name too long
                Enter.theValue("autotestautotestautotestautotestautotestautotestautotestautotest").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                Enter.theValue("1").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Last name")),
                Enter.theValue("test@gmail.com").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Email")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Invite")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("First name is too long (maximum is 50 characters)")),

                // verify last name too long
                Enter.theValue("1").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                Enter.theValue("autotestautotestautotestautotestautotestautotestautotestautotest").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Last name")),
                Enter.theValue("test@gmail.com").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Email")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Invite")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Last name is too long (maximum is 50 characters)"))
        );
    }

    @And("Vendor fill info to invite colleagues")
    public void vendor_invite_colleagues(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.fillInfoInviteColleagues(infos.get(0))
        );
    }

    @And("Vendor go to payments tab")
    public void vendor_go_to_payment() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToPayment()
        );
    }

    @And("Vendor verify pink payment is display")
    public void vendor_verify_pink_payment() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.PINK_PAYMENT),
                Ensure.that(VendorSettingGeneralPage.PINK_PAYMENT).text().contains(WebsiteBuyerConstants.PINK_PAYMENT1),
                Ensure.that(VendorSettingGeneralPage.PINK_PAYMENT).text().contains(WebsiteBuyerConstants.PINK_PAYMENT2),
                Ensure.that(VendorSettingGeneralPage.PINK_PAYMENT).text().contains(WebsiteBuyerConstants.PINK_PAYMENT3)
        );
    }

    @And("Vendor verify pink payment is not display")
    public void vendor_verify_pink_payment_not_display() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isNotVisible(VendorSettingGeneralPage.PINK_PAYMENT)
        );
    }

    @And("Vendor go to add credit card")
    public void vendor_go_to_add_credit_card() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToCreditCard()
        );
    }


    @And("Vendor go to add bank account")
    public void vendor_go_to_add_bank_account() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToAddBankAccount()
        );
    }

    @And("Vendor add bank account type 1")
    public void vendor_add_bank_account_type_1() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.addBankAccount1()
        );
    }

    @And("Vendor verify current bank account")
    public void vendor_verify_current_bank_account(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.LAST_4_CARD_NUMBER),
                Ensure.that(VendorSettingGeneralPage.LAST_4_CARD_NUMBER).text().contains(infos.get(0).get("last4")),
                Ensure.that(VendorSettingGeneralPage.CARD_NAME).text().contains(infos.get(0).get("cardName"))
        );
    }

    @And("Vendor go to replace current bank account")
    public void vendor_go_to_add_replace_current_bank_account() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToReplacedBankAccount()
        );
    }

    @And("Vendor add bank account type 3")
    public void vendor_add_bank_account_type_3() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.addBankAccount3(),
                // verify
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.NOTE_VERIFY_BANK_ACC_1),
                Ensure.that(VendorSettingGeneralPage.NOTE_VERIFY_BANK_ACC_1).text().contains("Your bank verification is now in progress"),
                Ensure.that(VendorSettingGeneralPage.NOTE_VERIFY_BANK_ACC_2).text().contains("You’ll verify that two deposits in the range of $0.01-$0.99 appeared in your account.")
        );
    }

    @And("Vendor verify bank account type 3")
    public void vendor_verify_bank_account_type_3() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.addBankAccount3()
        );
    }
}

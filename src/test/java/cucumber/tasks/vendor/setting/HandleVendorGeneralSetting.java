package cucumber.tasks.vendor.setting;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.Buyer.common.CommonBuyerPage;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.setting.VendorSettingGeneralPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.actions.Switch;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.Map;

public class HandleVendorGeneralSetting {

    public static Task goToGeneralSetting() {
        return Task.where("Go to General Setting",
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.GENERAL_BUTTON),
                Click.on(VendorSettingGeneralPage.GENERAL_BUTTON),
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_HEADER("Accounts"))
        );
    }

    public static Task goToEditCompany() {
        return Task.where("Go to edit company information",
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.COMPANY_EDIT_BUTTON),
                Click.on(VendorSettingGeneralPage.COMPANY_EDIT_BUTTON),
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.POPUP_EDIT_TITLE)
        );
    }

    public static Task editStoreInformation(Map<String, String> info) {
        return Task.where("Edit store information",
                Check.whether(info.get("companyName").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("companyName")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Company name"))),
                Check.whether(info.get("ein").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("ein")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("EIN"))),
                Check.whether(info.get("size").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Company Size (estimated monthly revenue)"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(info.get("size")))),
                Check.whether(info.get("email").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("email")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Email"))),
                Check.whether(info.get("phone").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("phone")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Business phone"))),
                Check.whether(info.get("website").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("website")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Website"))),
                Check.whether(info.get("street").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("street")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Street address"))),
                Check.whether(info.get("apt").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("apt")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Apt, Suite, etc."))),
                Check.whether(info.get("city").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("city")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("City"))),
                Check.whether(info.get("state").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("State"), CommonBuyerPage.DYNAMIC_ITEM_DROPDOWN_3(info.get("state")))),
                Check.whether(info.get("zip").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("zip")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Zip code")))
        );
    }

    public static Task editInfoSuccess() {
        return Task.where("Edit information success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(VendorSettingGeneralPage.POPUP_EDIT_TITLE)
        );
    }

    public static Task goToEditPersonal() {
        return Task.where("Go to edit personal",
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.PERSONAL_EDIT_BUTTON),
                Click.on(VendorSettingGeneralPage.PERSONAL_EDIT_BUTTON),
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.POPUP_EDIT_TITLE)
        );
    }

    public static Performable editPersonal(Map<String, String> info) {
        return Task.where("Edit store information",
                actor -> {
                    actor.attemptsTo(
                            Check.whether(info.get("firstName").equals(""))
                                    .otherwise(
                                            Enter.theValue(info.get("firstName")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("First name"))),
                            Check.whether(info.get("lastName").equals(""))
                                    .otherwise(
                                            Enter.theValue(info.get("lastName")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Last name"))),
                            Check.whether(info.get("email").equals(""))
                                    .otherwise(
                                            Enter.theValue(info.get("email")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Email")))
                    );
                    if (info.containsKey("contactNumber")) {
                        actor.attemptsTo(
                                Enter.theValue(info.get("contactNumber")).into(VendorSettingGeneralPage.D_TEXTBOX_COMPANY_INFO("Contact number"))
                        );
                    }
                }


        );
    }

    public static Task goToChangePassword() {
        return Task.where("Go to change password",
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.CHANGE_PASSWORD_BUTTON),
                Click.on(VendorSettingGeneralPage.CHANGE_PASSWORD_BUTTON),
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.POPUP_EDIT_TITLE)
        );
    }

    public static Task changePassword(Map<String, String> info) {
        return Task.where("change password",
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Current password")),
                Enter.theValue(info.get("currentPassword")).into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Current password")),
                Enter.theValue(info.get("newPassword")).into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("New password")),
                Enter.theValue(info.get("confirm")).into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("New password confirmation"))
        );
    }

    public static Task changePasswordSuccess() {
        return Task.where("change password",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Submit")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Submit")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Submit"))
        );
    }

    public static Task changePasswordError(String message) {
        return Task.where("change password error",
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Submit")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    public static Task goToMinimums() {
        return Task.where("Go to minimums",
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.MINIMUM_BUTTON),
                Click.on(VendorSettingGeneralPage.MINIMUM_BUTTON),
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_HEADER("Minimums"))
        );
    }

    public static Task chooseMinimumsType(String type) {
        return Task.where("Choose type of minimums",
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.MINIMUM_TYPE_RADIO(type)),
                Click.on(VendorSettingGeneralPage.MINIMUM_TYPE_RADIO(type))
        );
    }

    public static Task editMinimumsToMOV(Map<String, String> info) {
        return Task.where("Edit type of minimums",
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.MOV_REGION_TEXTBOX("Pod Direct West")),
                Check.whether(info.get("pdw").equals(""))
                        .otherwise(Enter.theValue(info.get("pdw")).into(VendorSettingGeneralPage.MOV_REGION_TEXTBOX("Pod Direct West"))),
                Check.whether(info.get("pdc").equals(""))
                        .otherwise(Enter.theValue(info.get("pdc")).into(VendorSettingGeneralPage.MOV_REGION_TEXTBOX("Pod Direct Central"))),
//                Check.whether(info.get("pds").equals(""))
//                        .otherwise(Enter.theValue(info.get("pdw")).into(VendorSettingGeneralPage.MOV_REGION_TEXTBOX("Pod Direct Southeast"))),
//                Check.whether(info.get("pdn").equals(""))
//                        .otherwise(Enter.theValue(info.get("pdw")).into(VendorSettingGeneralPage.MOV_REGION_TEXTBOX("Pod Direct Northeast"))),
                Check.whether(info.get("pde").equals(""))
                        .otherwise(Enter.theValue(info.get("pde")).into(VendorSettingGeneralPage.MOV_REGION_TEXTBOX("Pod Direct East")))
        );
    }

    public static Task updateMinimumSuccess() {
        return Task.where("Update minimum success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Update")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("Updated successfully."))
        );
    }

    public static Task updateMinimumError(String message) {
        return Task.where("Update minimum success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Update")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT(message))
        );
    }

    public static Task goToInviteColleagues() {
        return Task.where("Go to Invite colleagues",
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.INVITE_COLLEAGUES_BUTTON),
                Click.on(VendorSettingGeneralPage.INVITE_COLLEAGUES_BUTTON),
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_HEADER("Invite colleagues"))
        );
    }

    public static Performable fillInfoInviteColleagues(Map<String, String> info) {
        return Task.where("Fill info to Invite colleagues",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                            Enter.theValue(info.get("firstName")).into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                            Enter.theValue(info.get("lastName")).into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Last name")),
                            Enter.theValue(info.get("email")).into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Email")),

                            Click.on(CommonVendorPage.DYNAMIC_BUTTON("Invite"))
                    );
                    if (info.containsKey("author")) {
                        actor.attemptsTo(
                                Click.on(VendorSettingGeneralPage.INVITE_AUTHOR_RADIO_BUTTON)
                        );
                    }

                    actor.attemptsTo(
                            Click.on(CommonVendorPage.DYNAMIC_BUTTON("Invite"))
                    );
                }

        );
    }

    public static Task goToPayment() {
        return Task.where("Go to payment",
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.PAYMENT_BUTTON),
                Click.on(VendorSettingGeneralPage.PAYMENT_BUTTON),
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_HEADER("Payments"))
        );
    }

    public static Task goToCreditCard() {
        return Task.where("Go to payment",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a credit card")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a credit card"))
        );
    }

    public static Task goToAddBankAccount() {
        return Task.where("Go to add bank account",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a bank account")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a bank account"))
        );
    }

    public static Task addBankAccount1() {
        return Task.where("Add bank account",
                WindowTask.switchFrame("//iframe[@title='Plaid Link']"),

                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Continue")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Continue")),
                // choose type
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.SEARCH_INSTITUTIONS_TEXTBOX),
                Enter.theValue("Houndstooth Bank").into(VendorSettingGeneralPage.SEARCH_INSTITUTIONS_TEXTBOX),
                Click.on(VendorSettingGeneralPage.RESULT_INSTITUTION("Houndstooth Bank")),
                //add user
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Username")),
                Enter.theValue("user_good").into(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Username")),
                Enter.theValue("pass_good").into(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Password")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Submit")),
                // click paid saving
                Click.on(VendorSettingGeneralPage.PLAID_SAVING),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Continue")).afterWaitingUntilEnabled(),
                // routing number
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Routing number")),
                Enter.theValue("021000021").into(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Routing number")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Continue")).afterWaitingUntilEnabled(),
                // account number
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Account number")),
                Enter.theValue("1111222233331111").into(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Account number")),
                Enter.theValue("1111222233331111").into(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Confirm account number")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Continue")).afterWaitingUntilEnabled(),
                // success
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.ADD_SUCCESS_LABEL),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Continue")).afterWaitingUntilEnabled(),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Continue")),
                // switch to default
                Switch.toDefaultContext()
        );
    }

    public static Task addBankAccount3() {
        return Task.where("Add bank account",
                WindowTask.switchFrame("//iframe[@title='Plaid Link']"),

                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Continue")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Continue")),
                // choose link with account number
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.SEARCH_INSTITUTIONS_TEXTBOX),
                JavaScriptClick.on(CommonAdminForm.DYNAMIC_BUTTON("Link with account numbers")),
                // routing number
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Routing number")),
                Enter.theValue("110000000").into(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Routing number")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Continue")).afterWaitingUntilEnabled(),
                // account number
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Account number")),
                Enter.theValue("1111222233330000").into(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Account number")),
                Enter.theValue("1111222233330000").into(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Confirm account number")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Continue")).afterWaitingUntilEnabled(),
                // input full name
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Full Name")),
                Enter.theValue("Autotest").into(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("Full Name")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Continue")).afterWaitingUntilEnabled(),
                // select account type
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.ACCOUNT_TYPE),
                Click.on(VendorSettingGeneralPage.ACCOUNT_TYPE),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Continue")).afterWaitingUntilEnabled(),
                // authorize
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Authorize")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Authorize")).afterWaitingUntilEnabled(),
                // continue
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Continue")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Continue")).afterWaitingUntilEnabled(),
                // switch to default
                Switch.toDefaultContext()
        );
    }

    public static Task goToReplacedBankAccount() {
        return Task.where("Go to replace current bank account",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Replace current bank account")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Replace current bank account"))
        );
    }

    public static Task verifyBankAccount3() {
        return Task.where("Add bank account",
                Switch.toFrame("plaid-link-iframe-2"),
                // enter 3-letter code
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("3-letter code")),
                Enter.theValue("abc").into(VendorSettingGeneralPage.D_ADD_BANK_TEXTBOX("3-letter code")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Continue")).afterWaitingUntilEnabled(),
                // success
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.ADD_SUCCESS_LABEL),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Continue")).afterWaitingUntilEnabled(),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Continue")),
                // switch to default
                Switch.toDefaultContext(),
                CommonWaitUntil.isNotVisible(VendorSettingGeneralPage.NOTE_VERIFY_BANK_ACC_1)
        );
    }
}

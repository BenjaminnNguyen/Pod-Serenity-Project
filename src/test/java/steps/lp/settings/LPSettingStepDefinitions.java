package steps.lp.settings;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.lp.setting.HandleLPGeneralSetting;
import cucumber.tasks.vendor.setting.HandleVendorGeneralSetting;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.Vendor.setting.VendorSettingGeneralPage;
import cucumber.user_interface.lp.LPSettingPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class LPSettingStepDefinitions {

    @And("LP verify personal in general settings")
    public void lp_verify_personal_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPSettingPage.D_PERSONAL_INFO("First name")),
                Ensure.that(LPSettingPage.D_PERSONAL_INFO("First name")).text().contains(infos.get(0).get("firstName")),
                Ensure.that(LPSettingPage.D_PERSONAL_INFO("Last name")).text().contains(infos.get(0).get("lastName")),
                Ensure.that(LPSettingPage.D_PERSONAL_INFO("Email")).text().contains(infos.get(0).get("email")),
                Ensure.that(LPSettingPage.D_PERSONAL_INFO("Contact number")).text().contains(infos.get(0).get("contactNumber"))
        );
    }

    @And("LP verify field in edit personal info of setting")
    public void lp_verify_field_in_personal() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorGeneralSetting.goToEditPersonal(),

                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                // verify first name too long
                Enter.theValue("ngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEdit").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("First name is too long (maximum is 50 characters)")),
                // verify last name too long
                Enter.theValue("ngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEdit").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Last name")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("Last name is too long (maximum is 50 characters)")),
                // field blank
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Last name")),
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Email")),
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Contact number")),
                // verify
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("First name")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("First name")).text().contains("Please input your first name"),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("Last name")).text().contains("Please input your last name"),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("Email")).text().contains("Please input a valid email address"),
                // close popup
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON)
        );
    }

    @And("LP verify company in general settings")
    public void lp_verify_company_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPSettingPage.D_COMPANY_INFO("Company name")),
                Ensure.that(LPSettingPage.D_COMPANY_INFO("Company name")).text().contains(infos.get(0).get("companyName")),
                Ensure.that(LPSettingPage.D_COMPANY_INFO("Contact number")).text().contains(infos.get(0).get("contactNumber"))
        );
    }

    @And("LP verify field in edit company info of setting")
    public void lp_verify_field_in_company() {
        theActorInTheSpotlight().attemptsTo(
                HandleLPGeneralSetting.goToEditCompany(),

                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Company name")),
                // verify first name too long
                Enter.theValue("ngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEdit").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Company name")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("Business name is too long (maximum is 50 characters)")),
                // verify last name too long
                Enter.theValue("1234567890123456789012345678901234567890").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Contact number")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("Contact number is the wrong length (should be 10 characters)")),
                // field blank
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Company name")),
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Contact number")),
                // verify
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("Company name")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("Company name")).text().contains("Please input your company name"),
                // close popup
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON)
        );
    }

    @And("LP go to edit company in general settings")
    public void lp_go_to_edit_company() {
        theActorInTheSpotlight().attemptsTo(
                HandleLPGeneralSetting.goToEditCompany()
        );
    }

    @And("LP verify edit personal in general settings")
    public void lp_verify_edit_personal_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPSettingPage.D_COMPANY_INFO("Company name")),
                Ensure.that(LPSettingPage.D_COMPANY_INFO("Company name")).attribute("value").contains(infos.get(0).get("companyName")),
                Ensure.that(LPSettingPage.D_COMPANY_INFO("Contact number")).attribute("value").contains(infos.get(0).get("contactNumber"))
        );
    }

    @And("LP edit personal in general settings")
    public void lp_edit_personal_in_general_settings(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleLPGeneralSetting.editCompany(infos.get(0))
        );
    }

    @And("LP verify upload document of setting")
    public void lp_verify_upload_document_in_setting() {
        theActorInTheSpotlight().attemptsTo(

                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                // verify first name too long
                Enter.theValue("ngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEdit").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("First name is too long (maximum is 50 characters)")),
                // verify last name too long
                Enter.theValue("ngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEditngoctxEdit").into(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Last name")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("Last name is too long (maximum is 50 characters)")),
                // field blank
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("First name")),
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Last name")),
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Email")),
                CommonTask.clearTextbox(VendorSettingGeneralPage.D_TEXTBOX_POPUP_EDIT("Contact number")),
                // verify
                CommonWaitUntil.isVisible(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("First name")),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("First name")).text().contains("Please input your first name"),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("Last name")).text().contains("Please input your last name"),
                Ensure.that(VendorSettingGeneralPage.D_TEXTBOX_POPUP_ERROR("Email")).text().contains("Please input a valid email address"),
                // close popup
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON)
        );
    }
}

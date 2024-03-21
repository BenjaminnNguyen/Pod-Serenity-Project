package steps.admin.vendors;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.vendors.HandleAllVendors;
import cucumber.tasks.admin.vendors.HandleVendorCompanies;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.Brand.BrandReferralPage;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.buyer.BuyerCompaniesPage;
import cucumber.user_interface.admin.vendors.AllVendorsForm;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Hit;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AllVendorsStepDefinitions {

    @And("Admin verify default create custom field")
    public void admin_verify_default_create_custom_field() {
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.goToCreateCustomField(),
                // Verify default
                Ensure.that(AllVendorsForm.NAME_CUSTOM_VENDOR_FIELD_TEXTBOX).attribute("value").isEqualToIgnoringCase(""),
                Ensure.that(AllVendorsForm.DATA_TYPE_CUSTOM_VENDOR_FIELD_TEXTBOX).attribute("value").isEqualToIgnoringCase(""),
                // Verify empty field
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),

                Ensure.that(AllVendorsForm.NAME_CUSTOM_VENDOR_FIELD_ERROR).text().isEqualToIgnoringCase("Please enter a name"),
                Ensure.that(AllVendorsForm.DATA_TYPE_CUSTOM_VENDOR_FIELD_ERROR).text().isEqualToIgnoringCase("Please select a data type"),
                // Close popup
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON)
        );
    }

    @And("Admin create new custom field")
    public void admin_create_custom_field(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleAllVendors.goToCreateCustomField(),
                    HandleAllVendors.createNewCustomField(info)
            );
        }
    }

    @And("Admin verify default create new vendor")
    public void admin_verify_default_create_new_vendor() {
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.goToCreateCustomField(),
                // Verify default
                Ensure.that(AllVendorsForm.NAME_CUSTOM_VENDOR_FIELD_TEXTBOX).attribute("value").isEqualToIgnoringCase(""),
                Ensure.that(AllVendorsForm.DATA_TYPE_CUSTOM_VENDOR_FIELD_TEXTBOX).attribute("value").isEqualToIgnoringCase(""),
                // Verify empty field
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),

                Ensure.that(AllVendorsForm.NAME_CUSTOM_VENDOR_FIELD_ERROR).text().isEqualToIgnoringCase("Please enter a name"),
                Ensure.that(AllVendorsForm.DATA_TYPE_CUSTOM_VENDOR_FIELD_ERROR).text().isEqualToIgnoringCase("Please select a data type"),
                // Close popup
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON)
        );
    }

    @And("Admin verify default create vendor field")
    public void admin_verify_default_create_vendor_field() {
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.goToCreateNewVendor(),
                // Verify default
                Ensure.that(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Name")).attribute("value").isEqualToIgnoringCase(""),
                Ensure.that(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Email")).attribute("value").isEqualToIgnoringCase(""),
                Ensure.that(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Company")).attribute("value").isEqualToIgnoringCase(""),
                Ensure.that(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Password")).attribute("value").isEqualToIgnoringCase(""),
                Ensure.that(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Tags")).attribute("value").isEqualToIgnoringCase(""),
                // Verify empty field
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                WindowTask.threadSleep(500),
                Ensure.that(AllVendorsForm.D_CREATE_VENDOR_ERROR("Name")).text().isEqualToIgnoringCase("Please input first name and last name for this vendor"),
                Ensure.that(AllVendorsForm.D_CREATE_VENDOR_ERROR("Email")).text().isEqualToIgnoringCase("Please input a valid email address"),
                Ensure.that(AllVendorsForm.D_CREATE_VENDOR_ERROR("Company")).text().isEqualToIgnoringCase("Please select a company for this vendor"),
                Ensure.that(AllVendorsForm.D_CREATE_VENDOR_ERROR("Password")).text().isEqualToIgnoringCase("password is required"),
                // Verify error password
                Enter.theValue("123").into(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Password")),
                WindowTask.threadSleep(500),
                Ensure.that(AllVendorsForm.D_CREATE_VENDOR_ERROR("Password")).text().isEqualToIgnoringCase("At least 1 letter, a number, at least 8 characters"),
                // Close popup
                Click.on(CommonAdminForm.POPUP_CLOSE_BUTTON)
        );
    }

    @And("Admin fill info to create new vendor")
    public void admin_fill_info_to_create_new_vendor(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleAllVendors.fillInfoToCreateVendor(info)
            );
        }
    }

    @And("Admin fill info custom to create new vendor")
    public void admin_fill_info_custom_to_create_new_vendor(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.fillInfoCustomToCreateVendor(infos.get(0))
        );
    }

    @And("Admin go to create new vendor")
    public void admin_go_to_create_new_vendor() {
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.goToCreateNewVendor()
        );
    }

    @And("Admin close popup create new vendor")
    public void admin_close_popup_create_new_vendor() {
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.goToCreateNewVendor()
        );
    }

    @And("Admin add tags in create new vendor")
    public void admin_add_tags_in_create_new_vendor(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.addTags(infos)
        );
    }

    @And("Admin create vendor and verify message error {string}")
    public void admin_create_vendor_and_verify_message_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    @And("Admin verify password message error {string}")
    public void admin_verify_password_message_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllVendorsForm.PASWORD_FIELD_ERROR)
        );
    }

    @And("Admin delete tags in create new vendor")
    public void admin_delete_tags_in_create_new_vendor(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.deleteTags(infos)
        );
    }

    @And("Admin create vendor success")
    public void admin_create_vendor_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.createVendorSuccess()
        );
    }

    @And("Admin search vendors")
    public void admin_search_vendor(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleAllVendors.searchVendors(infos.get(0))
        );
    }

    @And("Admin verify vendor in result")
    public void admin_verify_vendor_in_result(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllVendorsForm.NAME_IN_RESULT).attribute("data-original-text").contains(infos.get(0).get("name")),
                Ensure.that(AllVendorsForm.EMAIL_IN_RESULT).attribute("data-original-text").contains(infos.get(0).get("email")),
                Ensure.that(AllVendorsForm.VENDOR_COMPANY_IN_RESULT).attribute("data-original-text").contains(infos.get(0).get("vendorCompany")),
                Ensure.that(AllVendorsForm.ADDRESS_IN_RESULT).attribute("data-original-text").contains(infos.get(0).get("address")),
                Check.whether(infos.get(0).get("shopify").equals(""))
                        .otherwise(Ensure.that(AllVendorsForm.SHOPIFY_IN_RESULT).attribute("data-original-text").contains(infos.get(0).get("shopify")))
        );
    }

    @And("Admin no found vendor {string} in result")
    public void admin_no_found_vendor_in_result(String vendor) {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllVendorsForm.NAME_IN_RESULT(vendor)).isNotDisplayed()
        );
    }

    @And("Admin go to vendor detail {string}")
    public void admin_go_to_vendor_detail(String vendor) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.goToVendorDetail(vendor)
        );
    }

    @And("Admin verify general information in vendor detail")
    public void admin_verify_general_information_in_vendor_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllVendorsForm.GENERAL_INFO_LABEL),

                Ensure.that(AllVendorsForm.EMAIL_IN_DETAIL).text().contains(infos.get(0).get("email")),
                Ensure.that(AllVendorsForm.FIRST_NAME_IN_DETAIL).text().contains(infos.get(0).get("firstName")),
                Ensure.that(AllVendorsForm.LAST_NAME_IN_DETAIL).text().contains(infos.get(0).get("lastName")),
                Ensure.that(AllVendorsForm.COMPANY_IN_DETAIL).text().contains(infos.get(0).get("company")),
                Ensure.that(AllVendorsForm.ADDRESS_IN_DETAIL).text().contains(infos.get(0).get("address"))
        );
    }

    @And("Admin verify tags in vendor detail")
    public void admin_verify_tag_in_vendor_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllVendorsForm.TAGS_IN_DETAIL(info.get("tag"))).isDisplayed()
            );
        }
    }

    @And("Admin verify edit email field in vendor detail")
    public void admin_verify_edit_email_field_in_vendor_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(AllVendorsForm.EMAIL_IN_DETAIL, info.get("email"), info.get("message"))
                );
            }
        }
        //verify valid
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.changeValueTooltipTextbox(AllVendorsForm.EMAIL_IN_DETAIL, infos.get(3).get("email")),
                WindowTask.threadSleep(1000),
                Ensure.that(AllVendorsForm.EMAIL_IN_DETAIL).text().contains(infos.get(3).get("email"))
        );
    }

    @And("Admin verify edit first name field in vendor detail")
    public void admin_verify_edit_name_field_in_vendor_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(AllVendorsForm.FIRST_NAME_IN_DETAIL, info.get("firstName"), info.get("message"))
                );
            }
        }
        //verify valid
        for (int i = 1; i < infos.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipTextbox(AllVendorsForm.FIRST_NAME_IN_DETAIL, infos.get(i).get("firstName")),
                    WindowTask.threadSleep(1000),
                    Ensure.that(AllVendorsForm.FIRST_NAME_IN_DETAIL).text().contains(infos.get(i).get("firstName"))
            );
        }
    }

    @And("Admin verify edit last name field in vendor detail")
    public void admin_verify_edit_last_name_field_in_vendor_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(AllVendorsForm.LAST_NAME_IN_DETAIL, info.get("lastName"), info.get("message"))
                );
            }
        }
        //verify valid
        for (int i = 1; i < infos.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipTextbox(AllVendorsForm.LAST_NAME_IN_DETAIL, infos.get(i).get("lastName")),
                    WindowTask.threadSleep(1000),
                    Ensure.that(AllVendorsForm.LAST_NAME_IN_DETAIL).text().contains(infos.get(i).get("lastName"))
            );
        }
    }

    @And("Admin verify edit company field in vendor detail")
    public void admin_verify_edit_company_name_field_in_vendor_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllVendorsForm.COMPANY_IN_DETAIL),
                Click.on(AllVendorsForm.COMPANY_IN_DETAIL),
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_COMBOBOX),
                // Verify invalid company
                Enter.theValue("ngoc invalid").into(CommonAdminForm.TOOLTIP_COMBOBOX),
                CommonWaitUntil.isVisible(CommonAdminForm.NO_DATA),
                Click.on(AllVendorsForm.GENERAL_INFO_LABEL)
        );
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipDropdownWithInput(AllVendorsForm.COMPANY_IN_DETAIL, info.get("company")),
                    WindowTask.threadSleep(2000),
                    Ensure.that(AllVendorsForm.COMPANY_IN_DETAIL).text().contains(info.get("company")),
                    Ensure.that(AllVendorsForm.ADDRESS_IN_DETAIL).text().contains(info.get("address"))

            );
        }
    }

    @And("Admin verify default popup tag field in {word} detail")
    public void admin_verify_default_popup_tag_field_in_vendor_detail(String page, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllVendorsForm.TAGS_IN_DETAIL(infos.get(0).get("tag"))),
                Click.on(AllVendorsForm.TAGS_IN_DETAIL(infos.get(0).get("tag"))),
                CommonWaitUntil.isVisible(AllVendorsForm.TAGS_POPUP_LABEL)
        );
        // verify default popup tag in
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllVendorsForm.TAGS_IN_POPUP(info.get("tag"))).isDisplayed()
            );
        }
    }

    @And("Admin remove tag field in {word} detail")
    public void admin_remove_popup_tag_field_in_vendor_detail(String page, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.deleteTagsInDetail(infos)
        );
    }

    @And("Admin add tag field in vendor detail")
    public void admin_add_popup_tag_field_in_vendor_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.addTagsInDetail(infos)

        );
    }

    @And("Admin verify password field in vendor detail")
    public void admin_verify_password_field_in_vendor_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipTextboxError(CommonAdminForm.DYNAMIC_BUTTON("Change password"), info.get("password"), info.get("message"))
            );
        }
    }

    @And("Admin change password to {string} success in vendor detail")
    public void admin_change_password_success_in_vendor_detail(String newPassword) {
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.changeValueTooltipTextbox(CommonAdminForm.DYNAMIC_BUTTON("Change password"), newPassword)
        );
    }

    @And("Admin verify custom field in vendor detail")
    public void admin_verify_custom_field_in_vendor_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllVendorsForm.GENERAL_INFO_LABEL),
                Ensure.that(AllVendorsForm.CUSTOM_FIELD_DETAIL("Vendor boolean", "boolean-field")).text().contains(infos.get(0).get("boolean")),
                Ensure.that(AllVendorsForm.CUSTOM_FIELD_DETAIL("Vendor date", "date-field")).text().contains(CommonHandle.setDate2(infos.get(0).get("date"), "yyyy-MM-dd")),
                Ensure.that(AllVendorsForm.CUSTOM_FIELD_DETAIL("Vendor numeric", "numeric-field")).text().contains(infos.get(0).get("numeric")),
                Ensure.that(AllVendorsForm.CUSTOM_FIELD_DETAIL("Vendor text", "text-field")).text().contains(infos.get(0).get("text")),
                Ensure.that(AllVendorsForm.CUSTOM_FIELD_DETAIL_FILE).text().contains(infos.get(0).get("file"))
        );
    }

    @And("Admin edit custom field in vendor detail")
    public void admin_edit_custom_field_vendor_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.editCustomField(infos.get(0))
        );
    }

    @And("Admin navigate relate product in vendor detail")
    public void admin_navigate_relate_product_in_vendor_detail() {
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.navigateProductLink()
        );
    }

    @And("Admin delete vendor {string} in result")
    public void admin_delete_vendor_in_detail(String vendor) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllVendors.delete(vendor)
        );
    }

    @And("Admin {string} this vendor")
    public void admin_activate_vendor(String action) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(action.equals("activate"))
                        .andIfSo(HandleAllVendors.activeThisVendor())
                        .otherwise(HandleAllVendors.deactivateThisVendor())
        );
    }
}

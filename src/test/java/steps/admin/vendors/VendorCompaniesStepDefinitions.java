package steps.admin.vendors;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.vendors.AllVendorsForm;
import io.cucumber.java.en.*;
import cucumber.tasks.admin.vendors.HandleVendorCompanies;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.actions.Switch;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class VendorCompaniesStepDefinitions {

    @And("Admin search vendor company")
    public void admin_search_vendor_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleVendorCompanies.search(infos.get(0))
        );
    }

    @And("Admin verify info vendor company")
    public void admin_verify_info_vendor_company(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorCompaniesPage.D_RESULT("name")).attribute("data-original-text").contains(expected.get(0).get("name")),
                Check.whether(expected.get(0).get("region").equals(""))
                        .otherwise(Ensure.that(VendorCompaniesPage.D_RESULT("region")).text().contains(expected.get(0).get("region"))),
                Check.whether(expected.get(0).get("email").equals(""))
                        .otherwise(Ensure.that(VendorCompaniesPage.D_RESULT("email")).attribute("data-original-text").contains(expected.get(0).get("email"))),
                Ensure.that(VendorCompaniesPage.D_RESULT("ein")).text().contains(expected.get(0).get("ein")),
                Ensure.that(VendorCompaniesPage.D_RESULT("website")).text().contains(expected.get(0).get("website")),
                Ensure.that(VendorCompaniesPage.D_RESULT("managed-by")).text().contains(expected.get(0).get("managedBy")),
                Ensure.that(VendorCompaniesPage.D_RESULT("launched-by")).text().contains(expected.get(0).get("launchBy"))
        );
        if (expected.get(0).containsKey("legalName")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCompaniesPage.D_RESULT("legal-entity-name")).attribute("data-original-text").contains(expected.get(0).get("legalName"))
            );
        }
        if (expected.get(0).containsKey("prePayment")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCompaniesPage.PREPAYMENT_IN_RESULT(expected.get(0).get("prePayment"))).isDisplayed()
            );
        }
    }

    @And("Admin go to detail vendor company {string}")
    public void admin_go_to_detail(String vendor) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.goToDetail(vendor)
        );
    }

    @And("Admin go to detail vendor company {string} by edit button")
    public void admin_go_to_detail_by_edit_button(String vendor) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.goToDetailByEdit(vendor)
        );
    }

    @And("Admin verify general info vendor company")
    public void admin_verify_general_info_vendor_company(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorCompaniesPage.DETAIL_STATE).text().contains(expected.get(0).get("state")),
                Ensure.that(VendorCompaniesPage.D_DETAIL("name")).text().contains(expected.get(0).get("name")),
                Ensure.that(VendorCompaniesPage.D_DETAIL("ein")).text().contains(expected.get(0).get("ein")),
                Ensure.that(VendorCompaniesPage.D_DETAIL("company_size")).text().contains(expected.get(0).get("companySize")),
                Ensure.that(VendorCompaniesPage.D_DETAIL("avg-lead-time")).text().contains(expected.get(0).get("avg")),
                Ensure.that(VendorCompaniesPage.D_DETAIL("manager")).text().contains(expected.get(0).get("manager")),
                Ensure.that(VendorCompaniesPage.D_DETAIL("launcher")).text().contains(expected.get(0).get("launcher")),
                Ensure.that(VendorCompaniesPage.REFERRED_NAME).text().contains(expected.get(0).get("referredName"))
        );
        if (expected.get(0).containsKey("legalName")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCompaniesPage.D_DETAIL("legal-entity-name")).text().contains(expected.get(0).get("legalName"))
            );
        }
        if (expected.get(0).containsKey("ein")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCompaniesPage.D_DETAIL("ein")).text().contains(expected.get(0).get("ein"))
            );
        }
        if (expected.get(0).containsKey("website")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCompaniesPage.D_DETAIL("website")).text().contains(expected.get(0).get("website"))
            );
        }
        if (expected.get(0).containsKey("ach")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCompaniesPage.D_DETAIL_1("ach", expected.get(0).get("ach"))).isDisplayed()
            );
        }
        if (expected.get(0).containsKey("prepayment")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCompaniesPage.D_DETAIL_1("prepayment", expected.get(0).get("prepayment"))).isDisplayed()
            );
        }
        if (expected.get(0).containsKey("showTab")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCompaniesPage.D_DETAIL_1("all_tabs", expected.get(0).get("showTab"))).isDisplayed()
            );
        }
        if (expected.get(0).containsKey("hideBrand")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCompaniesPage.D_DETAIL_1("hide-brand", expected.get(0).get("hideBrand"))).isDisplayed()
            );
        }
        if (expected.get(0).containsKey("address")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorCompaniesPage.ADDRESS_DETAIL).text().contains(expected.get(0).get("address"))
            );
        }

    }

    @And("Admin update Regional limit of vendor company to {string}")
    public void admin_update_regional_limit_of_vendor_company(String limit) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.updateRegional(limit)
        );
    }

    @And("Admin edit region MOV of vendor company")
    public void admin_edit_region_mov(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleVendorCompanies.updateRegionalMOVValue(map.get("region"), map.get("value"))
            );
        }
    }

    @And("Admin check region MOV of vendor company")
    public void admin_check_region_mov(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(VendorCompaniesPage.REGION_MOV(map.get("region"))),
                    Ensure.that(VendorCompaniesPage.REGION_MOV(map.get("region"))).text().containsIgnoringCase(map.get("value"))
            );
        }
    }

    @And("Admin check region MOQ of vendor company")
    public void admin_check_region_moq() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCompaniesPage.LIMIT_TYPE),
                Ensure.that(VendorCompaniesPage.LIMIT_TYPE).text().containsIgnoringCase("MOQ")
        );
    }

    @And("Admin delete vendor company {string} in result search and see message")
    public void admin_delete_vendor_company_in_result(String vendorCompanyName) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.delete(vendorCompanyName),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("This vendor company could not be deleted because one of its SKUs has been ordered. You must delete all associated entities before deleting this one."))
        );
    }

    @And("Admin go to create new vendor company popup")
    public void admin_go_to_create_vendor_company_popup() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.goToCreateNewVendorCompany()
        );
    }

    @And("Admin verify detect duplicates create vendor company {string}")
    public void admin_verify_detect_duplicate_create_vendor_company(String vendorCompany) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCompaniesPage.D_CREATE_TEXTBOX("Name")),
                Enter.theValue(vendorCompany).into(VendorCompaniesPage.D_CREATE_TEXTBOX("Name")).thenHit(Keys.ENTER),
                CommonWaitUntil.isVisible(VendorCompaniesPage.SIMILAR_VENDOR_COMPANY(vendorCompany)),
                //Verify info
                Ensure.that(VendorCompaniesPage.SIMILAR_DESCRIPTION).text().contains("We found similar vendor companies. Please use one of them if it is duplicated"),
                Ensure.that(VendorCompaniesPage.SIMILAR_VENDOR_COMPANY(vendorCompany)).isDisplayed(),
                // Verify redirect similar vendor company
                Click.on(VendorCompaniesPage.SIMILAR_VENDOR_COMPANY(vendorCompany)),
                Switch.toWindowTitled("Vendor company 1983 — AT Create Vendor Company 01"),
                CommonWaitUntil.isVisible(VendorCompaniesPage.D_DETAIL("name")),
                Ensure.that(VendorCompaniesPage.D_DETAIL("name")).text().contains(vendorCompany),
                Switch.toDefaultContext(),
                // verify button "I still want to create a new one"))",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("I still want to create a new one")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("I still want to create a new one")),
                Ensure.that(VendorCompaniesPage.D_CREATE_TEXTBOX("Name")).attribute("value").contains(vendorCompany)
        );
    }

    @And("Admin verify empty field in create new vendor company popup")
    public void admin_verify_empty_field_in_create_new_vendor_company() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isVisible(VendorCompaniesPage.D_ERROR_CREATE("Street")),
                // Verify
                Ensure.that(VendorCompaniesPage.D_ERROR_CREATE("Street")).text().contains("Please enter street address for this vendor company"),
                Ensure.that(VendorCompaniesPage.D_ERROR_CREATE("City")).text().contains("Please enter this vendor company city name"),
                Ensure.that(VendorCompaniesPage.D_ERROR_CREATE("State (Province/Territory)")).text().contains("Please select this vendor company address state"),
                Ensure.that(VendorCompaniesPage.D_ERROR_CREATE("Zip")).text().contains("Please enter a valid 5-digits zip code"),
                Ensure.that(VendorCompaniesPage.D_ERROR_CREATE("Regional Limit Type")).text().contains("Please choose a limit type for this vendor company"),
                // Verify default form
                Ensure.that(VendorCompaniesPage.D_CREATE_TEXTBOX("Legal Entity Name")).attribute("placeholder").contains("Legal Entity Name"),
                Ensure.that(VendorCompaniesPage.D_CREATE_TEXTBOX("Email")).attribute("placeholder").contains("company@email.com"),
                Ensure.that(VendorCompaniesPage.D_CREATE_TEXTBOX("Website")).attribute("placeholder").contains("https://company.website.com"),
                Ensure.that(VendorCompaniesPage.D_CREATE_TEXTBOX("EIN")).attribute("placeholder").contains("xx-xxxxxxx")
        );
    }

    @And("Admin fill info to create new vendor company")
    public void admin_fill_info_to_create_new_vendor_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.fillInfoToCreateNewVendor(infos.get(0))
        );
    }

    @And("Admin fill info optional to create new vendor company")
    public void admin_fill_info_optional_to_create_new_vendor_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.fillInfoOptionalToCreateNewVendor(infos.get(0))
        );
    }

    @And("Admin fill info custom field to create new vendor company")
    public void admin_fill_info_custom_field_to_create_new_vendor_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.fillInfoCustomField(infos.get(0))
        );
    }

    @And("Admin create new vendor company success")
    public void admin_create_new_vendor_company_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.createVendorCompanySuccess()
        );
    }

    @And("Admin refresh page vendor company by button")
    public void admin_refresh_page_by_button() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.refreshPageByButton()
        );
    }

    @And("Admin verify edit name field in vendor company detail")
    public void admin_verify_edit_name_field_in_vendor_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(VendorCompaniesPage.D_DETAIL("name"), info.get("name"), info.get("message"))
                );
            } else if (info.get("message").equals("success")) {
                //verify valid
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextbox(VendorCompaniesPage.D_DETAIL("name"), info.get("name")),
                        WindowTask.threadSleep(1000),
                        Ensure.that(VendorCompaniesPage.D_DETAIL("name")).text().contains(info.get("name"))
                );
            }
        }
    }

    @And("Admin verify edit legal entity name field in vendor company detail")
    public void admin_verify_edit_legal_entity_name_field_in_vendor_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(VendorCompaniesPage.D_DETAIL("legal-entity-name"), info.get("legalName"), info.get("message"))
                );
            } else if (info.get("message").equals("success")) {
                //verify valid
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextbox(VendorCompaniesPage.D_DETAIL("legal-entity-name"), info.get("legalName")),
                        WindowTask.threadSleep(1000),
                        Ensure.that(VendorCompaniesPage.D_DETAIL("legal-entity-name")).text().contains(info.get("legalName"))
                );
            }
        }
    }

    @And("Admin verify edit ein field in vendor company detail")
    public void admin_verify_edit_ein_field_in_vendor_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            //verify valid
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipTextbox(VendorCompaniesPage.D_DETAIL("ein"), info.get("ein")),
                    WindowTask.threadSleep(1000),
                    Ensure.that(VendorCompaniesPage.D_DETAIL("ein")).text().contains(info.get("ein"))
            );
        }
    }

    @And("Admin verify edit company size field in vendor company detail")
    public void admin_verify_edit_company_size_field_in_vendor_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            //verify valid
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipDropdown(VendorCompaniesPage.D_DETAIL("company_size"), info.get("companySize")),
                    WindowTask.threadSleep(1000),
                    Ensure.that(VendorCompaniesPage.D_DETAIL("company_size")).text().contains(info.get("companySize"))
            );
        }
    }

    @And("Admin verify edit managed by field in vendor company detail")
    public void admin_verify_edit_managed_by_field_in_vendor_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            //verify valid
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipDropdownWithInput(VendorCompaniesPage.D_DETAIL_EDIT("Managed by"), info.get("manageBy")),
                    WindowTask.threadSleep(1000),
                    Ensure.that(VendorCompaniesPage.D_DETAIL("manager")).text().contains(info.get("manageBy"))
            );
        }
    }

    @And("Admin verify edit launched by field in vendor company detail")
    public void admin_verify_edit_launched_by_field_in_vendor_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            //verify valid
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipDropdownWithInput(VendorCompaniesPage.D_DETAIL_EDIT("Launched by"), info.get("launchBy")),
                    WindowTask.threadSleep(1000),
                    Ensure.that(VendorCompaniesPage.D_DETAIL("launcher")).text().contains(info.get("launchBy"))
            );
        }
    }

    @And("Admin verify default popup tag field in vendor company detail")
    public void admin_verify_default_popup_tag_field_in_vendor_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCompaniesPage.D_DETAIL_EDIT("Tags")),
                Click.on(VendorCompaniesPage.D_DETAIL_EDIT("Tags")),
                CommonWaitUntil.isVisible(AllVendorsForm.TAGS_POPUP_LABEL)
        );
        // verify default popup tag in
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllVendorsForm.TAGS_IN_POPUP(info.get("tag"))).isDisplayed()
            );
        }
    }

    @And("Admin verify edit referred by field in vendor company detail")
    public void admin_verify_edit_referred__by_field_in_vendor_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            //verify valid
            if (info.get("referredBy").equals("")) {
                theActorInTheSpotlight().attemptsTo(
                        Click.on(VendorCompaniesPage.REFERRED_NAME_EDIT),
                        HandleVendorCompanies.removeAllItemInMultiDropdown(),
                        Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                        CommonWaitUntil.isVisible(CommonAdminForm.LOADING_SPINNER),
                        Ensure.that(VendorCompaniesPage.REFERRED_NAME).text().contains(info.get("referredBy"))
                );
            } else {
                theActorInTheSpotlight().attemptsTo(
                        WindowTask.threadSleep(1000),
                        HandleVendorCompanies.changeValueTooltipDropdownMulti(VendorCompaniesPage.REFERRED_NAME_EDIT, info.get("referredBy"))
                );
            }
        }
    }

    @And("Admin verify edit email by field in vendor company detail")
    public void admin_verify_edit_email_field_in_vendor_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(VendorCompaniesPage.D_DETAIL("email"), info.get("email"), info.get("message"))
                );
            } else {
                //verify valid
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextbox(VendorCompaniesPage.D_DETAIL_EDIT("Email"), info.get("email")),
                        WindowTask.threadSleep(1000),
                        Ensure.that(VendorCompaniesPage.D_DETAIL("email")).text().contains(info.get("email"))
                );
            }
        }
    }

    @And("Admin verify edit contact by field in vendor company detail")
    public void admin_verify_edit_contact_field_in_vendor_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(VendorCompaniesPage.D_DETAIL("contact-number"), info.get("contact"), info.get("contact"))
                );
            } else {
                //verify valid
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextbox(VendorCompaniesPage.D_DETAIL_EDIT("Contact number"), info.get("contact")),
                        WindowTask.threadSleep(1000),
                        Ensure.that(VendorCompaniesPage.D_DETAIL("contact-number")).text().contains(info.get("contact"))
                );
            }
        }
    }

    @And("Admin verify edit website by field in vendor company detail")
    public void admin_verify_edit_website_field_in_vendor_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            //verify valid
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipTextbox(VendorCompaniesPage.D_DETAIL_EDIT("Website"), info.get("website")),
                    WindowTask.threadSleep(1000),
                    Ensure.that(VendorCompaniesPage.D_DETAIL("website")).text().contains(info.get("website"))
            );
        }
    }

    @And("Admin verify edit address by field in vendor company detail")
    public void admin_verify_edit_address_field_in_vendor_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.editAddress(infos.get(0))
        );
    }

    @And("Admin update {string} of vendor company")
    public void admin_update_checkbox_of_vendor_company(String type) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCompaniesPage.CHECKBOX_GENERAL(type)),
                CommonTaskAdmin.changeSwitchValueFromTooltip(VendorCompaniesPage.CHECKBOX_GENERAL(type), "Yes")
        );
    }

    @And("Admin {string} vendor company")
    public void admin_activate_vendor_company(String action) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(action.equals("activate"))
                        .andIfSo(HandleVendorCompanies.activeThisCompany())
                        .otherwise(HandleVendorCompanies.deactivateThisCompany())
        );
    }

    @And("Admin verify history active vendor company")
    public void admin_verify_active_vendor_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCompaniesPage.ACTIVE_HISTORY_ICON),
                MoveMouse.to(VendorCompaniesPage.ACTIVE_HISTORY_ICON),
                CommonWaitUntil.isVisible(VendorCompaniesPage.ACTIVE_HISTORY_STATE),
                //Verify
                Ensure.that(VendorCompaniesPage.ACTIVE_HISTORY_STATE).text().contains(infos.get(0).get("state")),
                Ensure.that(VendorCompaniesPage.ACTIVE_HISTORY_UPDATE_BY).text().contains(infos.get(0).get("updateBy")),
                Ensure.that(VendorCompaniesPage.ACTIVE_HISTORY_UPDATE_ON).text().contains(CommonHandle.setDate2(infos.get(0).get("updateOn"), "MM/dd/yy"))
        );
    }

    @And("Admin delete vendor company {string} in result")
    public void admin_delete_vendor_company_in_detail(String vendorCompanyName) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.delete(vendorCompanyName)
        );
    }

    @And("Admin verify custom field in vendor company detail")
    public void admin_verify_custom_field_vendor_company(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCompaniesPage.CUSTOM_FIELD_DETAIL("Boolean", "boolean-field")),
                Ensure.that(VendorCompaniesPage.CUSTOM_FIELD_DETAIL("Boolean", "boolean-field")).text().contains(expected.get(0).get("boolean")),
                Ensure.that(VendorCompaniesPage.CUSTOM_FIELD_DETAIL("Date", "date-field")).text().contains(CommonHandle.setDate2(expected.get(0).get("date"), "yyyy-MM-dd")),
                Ensure.that(VendorCompaniesPage.CUSTOM_FIELD_DETAIL("Numeirc", "numeric-field")).text().contains(expected.get(0).get("numeric")),
                Ensure.that(VendorCompaniesPage.CUSTOM_FIELD_DETAIL("Text", "text-field")).text().contains(expected.get(0).get("text")),
                Ensure.that(VendorCompaniesPage.CUSTOM_FIELD_DETAIL_FILE).text().contains(expected.get(0).get("file"))
        );
    }

    @And("Admin edit custom field in vendor company detail")
    public void admin_edit_custom_field_vendor_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.editCustomField(infos.get(0))
        );
    }

    @And("Admin go to vendor company {string} by url")
    public void buyer_go_to_vendor_company_page_by_url(String id) {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.goToPageByUrl(id)
        );
    }

    @And("Admin verify state of vendor company is {string}")
    public void admin_verify_state_of_vendor_company(String state) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorCompaniesPage.DETAIL_STATE),
                Ensure.that(VendorCompaniesPage.DETAIL_STATE).text().contains(state)
        );
    }

    @And("Admin select vendor company in result")
    public void admin_select_vendor_company_in_result(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.select(infos)
        );
    }

    @And("Admin go to bulk edit in result")
    public void admin_go_to_bulk_edit_in_result() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.goToBulkEdit()
        );
    }

    @And("Admin clear section bulk edit in result")
    public void admin_clear_session_bulk_edit_in_result() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.clearSelectSession()
        );
    }

    @And("Admin update bulk vendor company")
    public void admin_update_bulk_vendor_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.updateBulk(infos.get(0))
        );
    }

    @And("Admin update bulk vendor company success")
    public void admin_update_bulk_vendor_company_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleVendorCompanies.updateBulkSuccess()
        );
    }
}

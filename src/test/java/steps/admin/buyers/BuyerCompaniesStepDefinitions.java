package steps.admin.buyers;


import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.buyers.HandleBuyerCompanies;
import cucumber.tasks.admin.vendors.HandleVendorCompanies;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.buyer.BuyerCompaniesPage;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class BuyerCompaniesStepDefinitions {

    @And("Admin search buyer company")
    public void admin_search_buyer_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(infos.get(0), "name", Serenity.sessionVariableCalled("Onboard Name Company"));

        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.search(info)
        );
    }

    @And("Admin verify result buyer company")
    public void admin_verify_result_buyer_company(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(BuyerCompaniesPage.BUYER_NAME).attribute("data-original-text").contains(expected.get(0).get("name")),
                Ensure.that(BuyerCompaniesPage.EIN).text().contains(expected.get(0).get("ein")),
                Ensure.that(BuyerCompaniesPage.WEBSITE).attribute("data-original-text").contains(expected.get(0).get("website")),
                Ensure.that(BuyerCompaniesPage.STATUS).text().contains(expected.get(0).get("status"))
        );
        // get ID buyer company
        String id = Text.of(BuyerCompaniesPage.BUYER_ID).answeredBy(theActorInTheSpotlight()).toString();
        Serenity.setSessionVariable("Buyer Company ID").to(id);
    }

    @And("Admin go to detail of buyer company {string}")
    public void admin_search_buyer_company(String buyerCompany) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(BuyerCompaniesPage.BUYER_NAME_RESULT(buyerCompany)),
                CommonWaitUntil.isVisible(BuyerCompaniesPage.DETAIL_STATE)
        );
    }

    @And("Admin verify general information of buyer company")
    public void admin_verify_general_info_of_buyer_company(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(expected.get(0), "name", Serenity.sessionVariableCalled("Onboard Name Company"));

        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCompaniesPage.DETAIL_STATE),
                Ensure.that(BuyerCompaniesPage.DETAIL_STATE).text().contains(expected.get(0).get("state")),
                Ensure.that(BuyerCompaniesPage.DETAIL_NAME).text().contains(info.get("name")),
                Ensure.that(BuyerCompaniesPage.DETAIL_MANAGED_BY).text().contains(info.get("managedBy")),
                Ensure.that(BuyerCompaniesPage.DETAIL_LAUNCHED_BY).text().contains(info.get("launchedBy")),
                Ensure.that(BuyerCompaniesPage.DETAIL_STORE_TYPE).text().contains(info.get("storeType")),
                Ensure.that(BuyerCompaniesPage.DETAIL_EIN).text().contains(expected.get(0).get("ein")),
                Ensure.that(BuyerCompaniesPage.DETAIL_WEBSITE).text().contains(expected.get(0).get("website")),
                Ensure.that(BuyerCompaniesPage.DETAIL_CREDIT).text().contains(expected.get(0).get("limit")),
                Ensure.that(BuyerCompaniesPage.DETAIL_ONBOARDING_STATE).text().contains(expected.get(0).get("onboardStatus")),
                Ensure.that(BuyerCompaniesPage.DETAIL_EDI_STATE).text().contains(expected.get(0).get("edi")),
                Ensure.that(BuyerCompaniesPage.DETAIL_FUEL_SURCHARGE).text().contains(expected.get(0).get("fuel"))
        );
    }

    @And("Admin choose region {string} and approve buyer company")
    public void approve_user_company(String region) {
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.chooseRegionAndApprove(region)
        );
    }

    @And("Admin create buyer company")
    public void admin_create_buyer_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.fillInfoToCreateBuyerCompany(infos.get(0))
        );
    }

    @And("Admin add tags to create buyer company")
    public void admin_add_tags_to_create_buyer_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.addTagsToCreate(infos)
        );
    }

    @And("Admin create buyer company {string} success")
    public void admin_create_buyer_company_success(String buyerCompany) {
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.createBuyerCompanySuccess()
        );
        // get ID của buyer company
        String buyerCompanyID = Text.of(BuyerCompaniesPage.ID_BUYER_COMPANY_RESULT(buyerCompany)).answeredBy(theActorInTheSpotlight()).toString();
        Serenity.setSessionVariable("Buyer Company ID").to(buyerCompanyID);
    }

    @And("Admin verify buyer company in result")
    public void admin_verify_buyer(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(BuyerCompaniesPage.BUYER_COMPANY_RESULT(infos.get(0).get("buyerCompany"))).text().contains(infos.get(0).get("buyerCompany")),
                Ensure.that(BuyerCompaniesPage.EIN_RESULT(infos.get(0).get("buyerCompany"))).text().contains(infos.get(0).get("ein")),
                Ensure.that(BuyerCompaniesPage.WEBSITE_RESULT(infos.get(0).get("buyerCompany"))).attribute("data-original-text").contains(infos.get(0).get("website")),
                Ensure.that(BuyerCompaniesPage.STATUS_RESULT(infos.get(0).get("buyerCompany"))).text().contains(infos.get(0).get("status"))
        );
    }

    @And("Admin go to create buyer company")
    public void admin_go_to_create_buyer_company() {
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.goToCreateBuyerCompany()
        );
    }

    @And("Admin verify default form create buyer company")
    public void admin_verify_default_form_create_buyer_company() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCompaniesPage.CREATE_BUYER_COMPANY_BUTTON),
                Enter.theValue("123456").into(BuyerCompaniesPage.CREATE_BUYER_NAME_TEXTBOX),
                Clear.field(BuyerCompaniesPage.CREATE_BUYER_NAME_TEXTBOX),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Ensure.that(BuyerCompaniesPage.CREATE_BUYER_NAME_TEXTBOX).attribute("placeholder").contains("Name"),
                Ensure.that(BuyerCompaniesPage.CREATE_BUYER_MANAGED_TEXTBOX).attribute("placeholder").contains("Select"),
                Ensure.that(BuyerCompaniesPage.CREATE_BUYER_LAUNCH_TEXTBOX).attribute("placeholder").contains("Select"),
                Ensure.that(BuyerCompaniesPage.CREATE_BUYER_STORE_TYPE_TEXTBOX).attribute("placeholder").contains("Select")
        );
    }

    @And("Admin verify detect duplicates create buyer company {string}")
    public void admin_verify_detect_duplicate_create_buyer_company(String buyerCompany) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCompaniesPage.CREATE_BUYER_NAME_TEXTBOX),
                Enter.theValue(buyerCompany).into(BuyerCompaniesPage.CREATE_BUYER_NAME_TEXTBOX).thenHit(Keys.ENTER),
                CommonWaitUntil.isVisible(BuyerCompaniesPage.SIMILAR_VENDOR_COMPANY(buyerCompany)),
                //Verify info
                Ensure.that(BuyerCompaniesPage.SIMILAR_DESCRIPTION).text().contains("We found similar buyer companies. Please use one of them if it is duplicated"),
                Ensure.that(BuyerCompaniesPage.SIMILAR_VENDOR_COMPANY(buyerCompany)).isDisplayed(),
                // Verify redirect similar vendor company
                Click.on(BuyerCompaniesPage.SIMILAR_VENDOR_COMPANY(buyerCompany)),
                WindowTask.switchToChildWindowsByTitle(buyerCompany),
                CommonWaitUntil.isVisible(BuyerCompaniesPage.DETAIL_NAME),
                Ensure.that(BuyerCompaniesPage.DETAIL_NAME).text().contains(buyerCompany),
                WindowTask.switchToChildWindowsByTitle("Buyer companies"),
                // verify button "I still want to create a new one"))",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("I still want to create a new one")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("I still want to create a new one")),
                Ensure.that(BuyerCompaniesPage.CREATE_BUYER_NAME_TEXTBOX).attribute("value").contains(buyerCompany)
        );
    }

    @And("Admin verify default popup tag field in buyer company detail")
    public void admin_verify_default_popup_tag_field_in_buyer_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCompaniesPage.D_DETAIL_EDIT("Tags")),
                Click.on(BuyerCompaniesPage.D_DETAIL_EDIT("Tags")),
                CommonWaitUntil.isVisible(BuyerCompaniesPage.TAGS_POPUP_LABEL)
        );
        // verify default popup tag in
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(BuyerCompaniesPage.TAGS_IN_POPUP(info.get("tag"))).isDisplayed()
            );
        }
    }

    @And("Admin verify edit name field in buyer company detail")
    public void admin_verify_edit_name_field_in_buyer_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(BuyerCompaniesPage.DETAIL_NAME, info.get("name"), info.get("message"))
                );
            } else if (info.get("message").equals("success")) {
                //verify valid
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextbox(BuyerCompaniesPage.DETAIL_NAME, info.get("name")),
                        WindowTask.threadSleep(2000),
                        Ensure.that(BuyerCompaniesPage.DETAIL_NAME).text().contains(info.get("name"))
                );
            }
        }
    }

    @And("Admin verify edit managed by field in buyer company detail")
    public void admin_verify_edit_managed_by_field_in_buyer_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            //verify valid
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipDropdownWithInput(BuyerCompaniesPage.DETAIL_MANAGED_BY_EDIT, info.get("manageBy")),
                    WindowTask.threadSleep(2000),
                    Ensure.that(BuyerCompaniesPage.DETAIL_MANAGED_BY).text().contains(info.get("manageBy"))
            );
        }
    }

    @And("Admin verify edit launched by field in buyer company detail")
    public void admin_verify_edit_launched_by_field_in_buyer_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            //verify valid
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipDropdownWithInput(BuyerCompaniesPage.DETAIL_LAUNCHED_BY_EDIT, info.get("launchBy")),
                    WindowTask.threadSleep(2000),
                    Ensure.that(BuyerCompaniesPage.DETAIL_LAUNCHED_BY).text().contains(info.get("launchBy"))
            );
        }
    }

    @And("Admin verify edit store type field in buyer company detail")
    public void admin_verify_edit_store_type_field_in_buyer_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            //verify valid
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipDropdown(BuyerCompaniesPage.DETAIL_STORE_TYPE, info.get("storeType")),
                    WindowTask.threadSleep(2000),
                    Ensure.that(BuyerCompaniesPage.DETAIL_STORE_TYPE).text().contains(info.get("storeType"))
            );
        }
    }

    @And("Admin verify edit ein field in buyer company detail")
    public void admin_verify_edit_ein_field_in_buyer_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            //verify valid
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipTextbox(BuyerCompaniesPage.DETAIL_EIN_BY_EDIT, info.get("ein")),
                    WindowTask.threadSleep(2000),
                    Ensure.that(BuyerCompaniesPage.DETAIL_EIN).text().contains(info.get("ein"))
            );
        }
    }

    @And("Admin verify edit website by field in buyer company detail")
    public void admin_verify_edit_website_field_in_buyer_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            //verify valid
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipTextbox(BuyerCompaniesPage.DETAIL_WEBSITE, info.get("website")),
                    WindowTask.threadSleep(2000),
                    Ensure.that(BuyerCompaniesPage.DETAIL_WEBSITE).text().contains(info.get("website"))
            );
        }
    }

    @And("Admin verify edit edi and fuel by field in buyer company detail")
    public void admin_verify_edit_edi_and_fuel_field_in_buyer_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {

            theActorInTheSpotlight().attemptsTo(
                    //verify edi
                    CommonTaskAdmin.changeSwitchValueFromTooltip(BuyerCompaniesPage.DETAIL_EDI, info.get("edi")),
                    WindowTask.threadSleep(2000),
                    Ensure.that(BuyerCompaniesPage.DETAIL_EDI).text().contains(info.get("edi")),
                    //verify fuel
                    CommonTaskAdmin.changeSwitchValueFromTooltip(BuyerCompaniesPage.DETAIL_FUEL, info.get("fuel")),
                    WindowTask.threadSleep(2000),
                    Ensure.that(BuyerCompaniesPage.DETAIL_FUEL).text().contains(info.get("fuel"))
            );
        }
    }

    @And("Admin remove tag field in buyer company detail")
    public void admin_remove_popup_tag_field_in_buyer_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.deleteTagsInDetail(infos)
        );
    }

    @And("Admin add tag field in buyer company detail")
    public void admin_add_popup_tag_field_in_buyer_company_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.addTagsInDetail(infos)

        );
    }

    @And("Admin {string} buyer company")
    public void admin_activate_buyer_company(String action) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(action.equals("activate"))
                        .andIfSo(HandleBuyerCompanies.activeThisCompany())
                        .otherwise(HandleBuyerCompanies.deactivateThisCompany())
        );
    }

    @And("Admin verify history active buyer company")
    public void admin_verify_active_buyer_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(BuyerCompaniesPage.ACTIVE_HISTORY_ICON),
                MoveMouse.to(VendorCompaniesPage.ACTIVE_HISTORY_ICON),
                CommonWaitUntil.isVisible(VendorCompaniesPage.ACTIVE_HISTORY_STATE),
                //Verify
                Ensure.that(VendorCompaniesPage.ACTIVE_HISTORY_STATE).text().contains(infos.get(0).get("state")),
                Ensure.that(VendorCompaniesPage.ACTIVE_HISTORY_UPDATE_BY).text().contains(infos.get(0).get("updateBy")),
                Ensure.that(VendorCompaniesPage.ACTIVE_HISTORY_UPDATE_ON).text().contains(CommonHandle.setDate2(infos.get(0).get("updateOn"), "MM/dd/yy"))
        );
    }

    @And("Admin upload company document")
    public void admin_upload_company_document(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.uploadCompanyDocument(infos)
        );
    }

    @And("Admin upload company document multi in row")
    public void admin_upload_company_document_multi_in_row(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.uploadMultiInRowCompanyDocument(infos)
        );
    }

    @And("Admin verify company document tab in buyer company detail")
    public void admin_verify_company_document_tab() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                Scroll.to(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                // verify choose company document preview tooltip
                CommonWaitUntil.isVisible(BuyerCompaniesPage.COMPANY_DOCUMENT_SELECT_LABEL),
                MoveMouse.to(BuyerCompaniesPage.COMPANY_DOCUMENT_SELECT_LABEL),
                CommonWaitUntil.isVisible(BuyerCompaniesPage.COMPANY_DOCUMENT_PREVIEW_TOOLTIP),
                // verify choose company document file icon tooltip
                MoveMouse.to(BuyerCompaniesPage.COMPANY_DOCUMENT_SELECT_ICON),
                CommonWaitUntil.isVisible(BuyerCompaniesPage.COMPANY_DOCUMENT_PREVIEW_ICON_TOOLTIP)

        );
    }

    @And("Admin verify error message of company document")
    public void admin_verify_error_message_of_company_document() {
        theActorInTheSpotlight().attemptsTo(
                // blank file preview file
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Documents attachment can't be blank")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON),
                // file > 10 MB
                CommonFile.upload1("10MBgreater.jpg", BuyerCompaniesPage.COMPANY_DOCUMENT_UPLOAD_FILE("1")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")),

                Click.on(BuyerCompaniesPage.COMPANY_DOCUMENT_REMOVE_BUTTON(1))
        );
    }

    @And("Admin verify after upload company document")
    public void admin_verify_after_upload_company_document(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    // verify file after upload
                    Ensure.that(BuyerCompaniesPage.COMPANY_DOCUMENT_FILE_UPLOADED(info.get("index"))).text().contains(info.get("file")),
                    Ensure.that(BuyerCompaniesPage.COMPANY_DOCUMENT_PREVIEW_DESCRIPTION(info.get("index"))).attribute("value").contains(info.get("description"))
            );
        }

        theActorInTheSpotlight().attemptsTo(
                // verify download button
                Click.on(BuyerCompaniesPage.COMPANY_DOCUMENT_DOWNLOAD_BUTTON(1)),
                WindowTask.threadSleep(2000),
                Switch.toWindowTitled(infos.get(0).get("file")),
                WindowTask.switchToChildWindowsByTitle("AT Buyer Company 01 Edit")
        );
    }

    @And("Admin verify business license certificates tab in buyer company detail")
    public void admin_verify_business_license_certificate_tab() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a business license certificates")),
                Scroll.to(CommonAdminForm.DYNAMIC_BUTTON("Add a business license certificates")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a business license certificates")),
                // verify choose business license certificates preview tooltip
                CommonWaitUntil.isVisible(BuyerCompaniesPage.BUSINESS_LICENSE_CERTIFICATES_SAVE_BUTTON),
                MoveMouse.to(BuyerCompaniesPage.BUSINESS_LICENSE_CERTIFICATES_LABEL),
                CommonWaitUntil.isVisible(BuyerCompaniesPage.BUSINESS_LICENSE_CERTIFICATES_TOOLTIP),
                // verify choose company document file icon tooltip
                MoveMouse.to(BuyerCompaniesPage.BUSINESS_LICENSE_CERTIFICATES_SELECT_ICON),
                CommonWaitUntil.isVisible(BuyerCompaniesPage.BUSINESS_LICENSE_CERTIFICATES_ICON_TOOLTIP)
        );
    }

    @And("Admin verify error message of business license certificates")
    public void admin_verify_error_message_of_business_license_certificates() {
        theActorInTheSpotlight().attemptsTo(
                // file > 10 MB
                CommonFile.upload1("10MBgreater.jpg", BuyerCompaniesPage.BUSINESS_LICENSE_CERTIFICATES_UPLOAD_FILE("1")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")),
                Click.on(BuyerCompaniesPage.BUSINESS_LICENSE_CERTIFICATES_REMOVE_BUTTON("1"))
        );
    }

    @And("Admin upload business license certificates multi in row")
    public void admin_upload_business_license_certificates_multi_in_row(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.uploadMultiInRowBusinessLicenseCertificates(infos)
        );
    }

    @And("Admin upload business license certificates")
    public void admin_upload_business_license_certificates(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.uploadBusinessLicenseCertificates(infos)
        );
    }

    @And("Admin verify after business license certificates")
    public void admin_verify_after_business_license_certificates(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    // verify file after upload
                    Ensure.that(BuyerCompaniesPage.BUSINESS_LICENSE_CERTIFICATES_FILE_UPLOADED(info.get("index"))).text().contains(info.get("file"))
            );
        }

        theActorInTheSpotlight().attemptsTo(
                // verify download button
                Click.on(BuyerCompaniesPage.BUSINESS_LICENSE_DOWNLOAD_BUTTON(1)),
                WindowTask.threadSleep(2000),
                Switch.toWindowTitled(infos.get(0).get("file")),
                WindowTask.switchToChildWindowsByTitle("AT Buyer Company 01 Edit")
        );
    }

    @And("Admin verify resale certificates tab in buyer company detail")
    public void admin_verify_resale_certificate_tab() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a resale certificate")),
                Scroll.to(CommonAdminForm.DYNAMIC_BUTTON("Add a resale certificate")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a resale certificate")),
                // verify choose resale certificates preview tooltip
                CommonWaitUntil.isVisible(BuyerCompaniesPage.RESALE_CERTIFICATES_SAVE_BUTTON),
                MoveMouse.to(BuyerCompaniesPage.RESALE_CERTIFICATES_LABEL),
                CommonWaitUntil.isVisible(BuyerCompaniesPage.RESALE_CERTIFICATES_TOOLTIP),
                // verify choose resale file icon tooltip
                MoveMouse.to(BuyerCompaniesPage.RESALE_CERTIFICATES_SELECT_ICON),
                CommonWaitUntil.isVisible(BuyerCompaniesPage.BUSINESS_LICENSE_CERTIFICATES_ICON_TOOLTIP)
        );
    }

    @And("Admin verify error message of resale certificates")
    public void admin_verify_error_message_of_resale_certificates() {
        theActorInTheSpotlight().attemptsTo(
                // file > 10 MB
                CommonFile.upload1("10MBgreater.jpg", BuyerCompaniesPage.RESALE_CERTIFICATES_UPLOAD_FILE("1")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Maximum file size exceeded.")),
                Click.on(BuyerCompaniesPage.RESALE_CERTIFICATES_REMOVE_BUTTON("1"))
        );
    }

    @And("Admin upload resale certificates multi in row")
    public void admin_upload_resale_certificates_multi_in_row(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.uploadMultiInRowResaleCertificates(infos)
        );
    }

    @And("Admin upload resale certificates")
    public void admin_upload_resale_certificates(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.uploadResaleCertificates(infos)
        );
    }

    @And("Admin verify after resale certificates")
    public void admin_verify_after_resale_certificates(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    // verify file after upload
                    Ensure.that(BuyerCompaniesPage.RESALE_CERTIFICATES_FILE_UPLOADED(info.get("index"))).text().contains(info.get("file"))
            );
        }
        theActorInTheSpotlight().attemptsTo(
                // verify download button
                Click.on(BuyerCompaniesPage.RESALE_CERTIFICATES_DOWNLOAD_BUTTON(1)),
                WindowTask.threadSleep(2000),
                Switch.toWindowTitled(infos.get(0).get("file")),
                WindowTask.switchToChildWindowsByTitle("AT Buyer Company 01 Edit")
        );

    }

    @And("Admin remove resale certificates")
    public void admin_remove_resale_certificates(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
            theActorInTheSpotlight().attemptsTo(
                    HandleBuyerCompanies.removeResaleCertificates(infos)
            );
    }

    @And("Admin remove company document")
    public void admin_remove_company_document(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.removeCompanyDocument(infos)
        );
    }

    @And("Admin remove business license certificate")
    public void admin_remove_business_license_certificate(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.removeBusinessLicenseCertificates(infos)
        );
    }

    @And("Admin set referrer vendor company is {string}")
    public void admin_set_referrer_vendor_company(String vendorCompany) {
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.setReferrerVendorCompany(vendorCompany)
        );
    }

    /**
     * Custom field
     */

    @And("Admin create custom field of buyer company")
    public void admin_create_custom_field_of_buyer_company(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.goToCreateCustomField()
        );
    }

    /**
     * Bulk update
     */

    @And("Admin select buyer company in result")
    public void admin_select_buyer_company_in_result(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.select(infos)
        );
    }

    @And("Admin update bulk buyer company")
    public void admin_update_bulk_buyer_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.updateBulk(infos.get(0))
        );
    }


    @And("Admin go to buyer company {string} by url")
    public void buyer_go_to_buyer_company_page_by_url(String id) {
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.goToPageByUrl(id)
        );
    }

    @And("Admin delete buyer company {string}")
    public void admin_delete_buyer_company(String buyerCompany) {
        theActorInTheSpotlight().attemptsTo(
                HandleBuyerCompanies.delete(buyerCompany)
        );
    }

    @And("Admin verify search field after choose filter in buyer company")
    public void admin_verify_search_field_after_choose_filter_in_buyer_company(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(2000),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("name")).attribute("value").contains(infos.get(0).get("name")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("manager_id")).attribute("value").contains(infos.get(0).get("managedBy")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("onboarding_state")).attribute("value").contains(infos.get(0).get("onboardStatus")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("tag_ids")).attribute("value").contains(infos.get(0).get("tag"))
        );
    }
}

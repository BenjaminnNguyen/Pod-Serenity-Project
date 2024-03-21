package cucumber.tasks.admin.vendors;

import cucumber.singleton.GVs;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.IncomingInventoryDetailPage;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import cucumber.user_interface.admin.store.AllStoresPage;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import cucumber.user_interface.beta.HomePageForm;
import cucumber.user_interface.beta.Vendor.inventory.VendorInventoryPage;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleVendorCompanies {

    public static Task search(Map<String, String> info) {
        return Task.where("Search vendor company",
                Enter.theValue(info.get("name")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("name")),
                Check.whether(!Objects.equals(info.get("prepayment"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdown(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("pay_early_discount"), VendorCompaniesPage.PREPAY_ITEM_DROPDOWN(info.get("prepayment")))
                        ),
                Check.whether(!Objects.equals(info.get("region"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX2("region_id"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("region")))
                        ),
                Enter.theValue(info.get("website")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("website")),
                Enter.theValue(info.get("ein")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("ein")),
                Enter.theValue(info.get("email")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("email")),
                Check.whether(!Objects.equals(info.get("managedBy"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX2("manager_id"), info.get("managedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("managedBy")))
                        ),
                Check.whether(!Objects.equals(info.get("ach"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX2("ach"), info.get("ach"), VendorCompaniesPage.ACH_ITEM_DROPDOWN(info.get("ach")))
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToDetail(String vendorCompany) {
        return Task.where("Go to detail",
                CommonWaitUntil.isVisible(VendorCompaniesPage.NAME_RESULT(vendorCompany)),
                Click.on(VendorCompaniesPage.NAME_RESULT(vendorCompany)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToDetailByEdit(String vendorCompany) {
        return Task.where("Go to detail by edit button",
                CommonWaitUntil.isVisible(VendorCompaniesPage.EDIT_RESULT_BUTTON(vendorCompany)),
                Click.on(VendorCompaniesPage.EDIT_RESULT_BUTTON(vendorCompany)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task updateRegional(String type) {
        return Task.where("Update regional",
                CommonWaitUntil.isVisible(VendorCompaniesPage.LIMIT_TYPE),
                Click.on(VendorCompaniesPage.LIMIT_TYPE),
                CommonWaitUntil.isVisible(VendorCompaniesPage.LIMIT_TYPE_INPUT),
                Click.on(VendorCompaniesPage.LIMIT_TYPE_INPUT),
                CommonTask.ChooseValueFromSuggestions(type),
//                Click.on(CompaniesPage.LIMIT_TYPE_UPDATE),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                CommonWaitUntil.isNotVisible(VendorCompaniesPage.LIMIT_TYPE_UPDATE)
        );
    }

    public static Task updateRegionalMOVValue(String region, String value) {
        return Task.where("Update regional",
                CommonTaskAdmin.changeValueTooltipTextbox(VendorCompaniesPage.REGION_MOV(region), value)
        );
    }

    public static Task delete(String vendorCompany) {
        return Task.where("Delete vendor company",
                CommonWaitUntil.isVisible(VendorCompaniesPage.DELETE_RESULT_BUTTON(vendorCompany)),
                Click.on(VendorCompaniesPage.DELETE_RESULT_BUTTON(vendorCompany)),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Deleting this vendor company will also delete all its brands, products and SKUs. Are you sure you want to continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue"))
        );
    }

    public static Task goToCreateNewVendorCompany() {
        return Task.where("Go to create new vendor company",
                CommonWaitUntil.isVisible(VendorCompaniesPage.CREATE_NEW_VENDOR_COMPANY_BUTTON),
                Click.on(VendorCompaniesPage.CREATE_NEW_VENDOR_COMPANY_BUTTON),
                CommonWaitUntil.isVisible(VendorCompaniesPage.CREATE_NEW_VENDOR_COMPANY_LABEL)
        );
    }

    public static Task fillInfoToCreateNewVendor(Map<String, String> info) {
        return Task.where("Fill info require to create new vendor",
                Enter.theValue(info.get("name")).into(VendorCompaniesPage.D_CREATE_TEXTBOX("Name")),
                // choose I still want to create a new one
                Check.whether(valueOf(CommonAdminForm.DYNAMIC_BUTTON("I still want to create a new one")), isVisible())
                        .andIfSo(Click.on(CommonAdminForm.DYNAMIC_BUTTON("I still want to create a new one")).afterWaitingUntilEnabled()),
                Enter.theValue(info.get("street1")).into(VendorCompaniesPage.D_CREATE_TEXTBOX("Street")).thenHit(Keys.ENTER),
                Check.whether(info.get("street2").isEmpty())
                        .otherwise(Enter.theValue(info.get("street2")).into(VendorCompaniesPage.STREET_2_TEXTBOX)),
                Enter.theValue(info.get("city")).into(VendorCompaniesPage.D_CREATE_TEXTBOX("City")),
                CommonTask.chooseItemInDropdownWithValueInput1(VendorCompaniesPage.D_CREATE_TEXTBOX("State (Province/Territory)"), info.get("state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("state"))),
                Enter.theValue(info.get("zip")).into(VendorCompaniesPage.D_CREATE_TEXTBOX("Zip")),
                CommonTask.chooseItemInDropdown1(VendorCompaniesPage.D_CREATE_TEXTBOX("Regional Limit Type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("limitType")))
        );
    }

    public static Task fillInfoOptionalToCreateNewVendor(Map<String, String> info) {
        return Task.where("Fill info optional to create new vendor",
                Check.whether(info.get("legalName").isEmpty())
                        .otherwise(Enter.theValue(info.get("legalName")).into(VendorCompaniesPage.D_CREATE_TEXTBOX("Legal Entity Name"))),
                Check.whether(info.get("email").isEmpty())
                        .otherwise(Enter.theValue(info.get("email")).into(VendorCompaniesPage.D_CREATE_TEXTBOX("Email"))),
                Check.whether(info.get("website").isEmpty())
                        .otherwise(Enter.theValue(info.get("website")).into(VendorCompaniesPage.D_CREATE_TEXTBOX("Website"))),
                Check.whether(info.get("ein").isEmpty())
                        .otherwise(Enter.theValue(info.get("ein")).into(VendorCompaniesPage.D_CREATE_TEXTBOX("EIN"))),
                Check.whether(info.get("contact").isEmpty())
                        .otherwise(Enter.theValue(info.get("contact")).into(VendorCompaniesPage.D_CREATE_TEXTBOX("Contact number"))),
                Check.whether(info.get("companySize").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdown1(VendorCompaniesPage.D_CREATE_TEXTBOX("Company size"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("companySize")))),
                Check.whether(info.get("ach").isEmpty())
                        .otherwise(Click.on(VendorCompaniesPage.D_CREATE_CHECKBOX("ACH"))),
                Check.whether(info.get("prepayment").isEmpty())
                        .otherwise(Click.on(VendorCompaniesPage.D_CREATE_CHECKBOX("Prepayment"))),
                Check.whether(info.get("showAllTab").isEmpty())
                        .otherwise(Click.on(VendorCompaniesPage.D_CREATE_CHECKBOX("Show all tabs"))),
                Check.whether(info.get("hideBrand").isEmpty())
                        .otherwise(Click.on(VendorCompaniesPage.D_CREATE_CHECKBOX("Hide brands"))),
                Check.whether(info.get("manageBy").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(VendorCompaniesPage.D_CREATE_TEXTBOX("Manage by"), info.get("manageBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("manageBy")))),
                Check.whether(info.get("launchBy").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(VendorCompaniesPage.D_CREATE_TEXTBOX("Launch by"), info.get("launchBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("launchBy")))),
                Check.whether(info.get("referredBy").isEmpty())
                        .otherwise(CommonTask.chooseMultiItemInDropdown(VendorCompaniesPage.D_CREATE_TEXTBOX("Referred by"), info.get("referredBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("referredBy")))),
                Check.whether(info.get("tags").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdown1(VendorCompaniesPage.D_CREATE_TEXTBOX("Tags"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("tags"))))
        );
    }

    public static Task fillInfoCustomField(Map<String, String> info) {
        return Task.where("Fill info custom field to create new vendor",
                Check.whether(info.get("boolean").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(VendorCompaniesPage.D_CREATE_TEXTBOX1("Boolean"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("boolean")))),
                Check.whether(info.get("date").equals(""))
                        .otherwise(
                                Enter.theValue(CommonHandle.setDate2(info.get("date"), "MM/dd/yy")).into(VendorCompaniesPage.D_CREATE_TEXTBOX1("Date")).thenHit(Keys.ENTER)),
                Check.whether(info.get("file").equals(""))
                        .otherwise(
                                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Add file")),
                                CommonFile.upload2(info.get("file"), VendorCompaniesPage.D_CREATE_TEXTBOX1("File"))
                        ),
                Check.whether(info.get("numeric").equals(""))
                        .otherwise(Enter.theValue(info.get("numeric")).into(VendorCompaniesPage.D_CREATE_TEXTBOX1("Numeirc"))),
                Check.whether(info.get("text").equals(""))
                        .otherwise(Enter.theValue(info.get("text")).into(VendorCompaniesPage.D_CREATE_TEXTBOX1("Text")))
        );
    }

    public static Task createVendorCompanySuccess() {
        return Task.where("Create vendor company success",
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create"))
        );
    }

    public static Task refreshPageByButton() {
        return Task.where("refresh page by button",
                CommonWaitUntil.isVisible(VendorCompaniesPage.REFRESH_PAGE_BUTTON),
                Click.on(VendorCompaniesPage.REFRESH_PAGE_BUTTON),
                CommonWaitUntil.isClickable(VendorCompaniesPage.REFRESH_PAGE_BUTTON),
                WindowTask.threadSleep(1000)
        );
    }

    public static Performable removeAllItemInMultiDropdown() {
        return Task.where("refresh page by button",
                actor -> {
                    List<WebElementFacade> CLOSE_ITEM = VendorCompaniesPage.LIST_REFERRED_CLOSE.resolveAllFor(theActorInTheSpotlight());
                    if (CLOSE_ITEM.size() > 0) {
                        for (WebElementFacade ITEM : CLOSE_ITEM) {
                            theActorInTheSpotlight().attemptsTo(
                                    Click.on(ITEM),
                                    WindowTask.threadSleep(1000)
                            );
                        }
                    }
                }
        );
    }

    public static Task changeValueTooltipDropdownMulti(Target target, String value) {
        return Task.where("Change value tooltip dropdownlist with input",
                Click.on(target),
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_COMBOBOX),
                Enter.theValue(value).into(CommonAdminForm.TOOLTIP_COMBOBOX),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(value)),
                WindowTask.threadSleep(500),
                Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(value)),
                WindowTask.threadSleep(500),
                JavaScriptClick.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.TOOLTIP_COMBOBOX),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task editAddress(Map<String, String> info) {
        return Task.where("Edit address",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Edit")),
                CommonWaitUntil.isVisible(CommonAdminForm.TITLE_POPUP),

                Enter.theValue(info.get("street1")).into(VendorCompaniesPage.D_CREATE_TEXTBOX("Street")),
                Check.whether(info.get("street2").equals(""))
                        .otherwise(Enter.theValue(info.get("street2")).into(VendorCompaniesPage.STREET_2_TEXTBOX)),
                Enter.theValue(info.get("city")).into(VendorCompaniesPage.D_CREATE_TEXTBOX("City")),
                CommonTask.chooseItemInDropdownWithValueInput1(VendorCompaniesPage.D_CREATE_TEXTBOX("State (Province/Territory)"), info.get("state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("state"))),
                Enter.theValue(info.get("zip")).into(VendorCompaniesPage.D_CREATE_TEXTBOX("Zip")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isVisible(CommonAdminForm.TITLE_POPUP)
        );
    }

    public static Task deactivateThisCompany() {
        return Task.where("Deactivate this company",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Deactivate this company")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Deactivate this company")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("This will deactivate current vendor company. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("This will deactivate current vendor company. Continue?")),
                CommonWaitUntil.isVisible(VendorCompaniesPage.DETAIL_STATE_VALUE("Inactive"))
        );
    }

    public static Task activeThisCompany() {
        return Task.where("Activate this company",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Activate this company")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Activate this company")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("This will activate current vendor company. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("This will activate current vendor company. Continue?")),
                CommonWaitUntil.isVisible(VendorCompaniesPage.DETAIL_STATE_VALUE("Active"))
        );
    }

    public static Task editCustomField(Map<String, String> info) {
        return Task.where("Edit custom field",
                Check.whether(info.get("boolean").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipDropdown(VendorCompaniesPage.CUSTOM_FIELD_DETAIL("Boolean", "boolean-field"), info.get("boolean"))),
                Check.whether(info.get("date").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipDateTime(VendorCompaniesPage.CUSTOM_FIELD_DETAIL("Date", "date-field"), CommonHandle.setDate2(info.get("date"), "MM/dd/yy"))),
                Check.whether(info.get("numeric").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(VendorCompaniesPage.CUSTOM_FIELD_DETAIL("Numeirc", "numeric-field"), info.get("numeric"))),
                Check.whether(info.get("text").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(VendorCompaniesPage.CUSTOM_FIELD_DETAIL("Text", "text-field"), info.get("text"))),
                Check.whether(info.get("file").equals(""))
                        .otherwise(
                                // remove old file
                                Click.on(VendorCompaniesPage.CUSTOM_FIELD_FILE_REMOVE_BUTTON),
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add file")),
                                CommonFile.upload2(info.get("file"), VendorCompaniesPage.CUSTOM_FIELD_FILE_UPLOAD),
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")))
        );
    }

    public static Task uploadFileOtherTab(Map<String, String> info) {
        return Task.where("Upload document in others of company document",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                CommonFile.upload1(info.get("file"), VendorCompaniesPage.OTHER_TAB_UPLOAD_FILE),
                Enter.theValue(info.get("description")).into(VendorCompaniesPage.OTHER_TAB_DESCRIPTION),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Save"))
        );
    }

    public static Task goToPageByUrl(String id) {
        return Task.where("Go to vendor company page by url",
                Open.url(GVs.URL_ADMIN + "vendors/companies/" + id),
                WindowTask.threadSleep(2000)
        );
    }

    public static Performable select(List<Map<String, String>> infos) {
        return Task.where("Select vendor company in result",
                actor -> {
                    for (Map<String, String> info : infos) {
                        theActorInTheSpotlight().attemptsTo(
                                CommonWaitUntil.isVisible(VendorCompaniesPage.D_CHECKBOX_RESULT(info.get("vendorCompany"))),
                                JavaScriptClick.on(VendorCompaniesPage.D_CHECKBOX_RESULT(info.get("vendorCompany"))),
                                WindowTask.threadSleep(1000)
                        );
                    }
                }
        );
    }

    public static Task goToBulkEdit() {
        return Task.where("Go to go to bulk edit",
                CommonWaitUntil.isVisible(VendorCompaniesPage.EDIT_ACTION_BAR),
                Click.on(VendorCompaniesPage.EDIT_ACTION_BAR)
        );
    }

    public static Task clearSelectSession() {
        return Task.where("Clear select session",
                CommonWaitUntil.isVisible(VendorCompaniesPage.CLEAR_ACTION_BAR),
                Click.on(VendorCompaniesPage.CLEAR_ACTION_BAR)
        );
    }

    public static Task updateBulk(Map<String, String> info) {
        return Task.where("Update bulk vendor companies",
               Check.whether(info.get("managedBy").equals(""))
                       .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(VendorCompaniesPage.D_TEXT_BULK_UPDATE("Managed by"), info.get("managedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("managedBy")))),
                Check.whether(info.get("launchedBy").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(VendorCompaniesPage.D_TEXT_BULK_UPDATE("Launched by"), info.get("launchedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("launchedBy")))),
                Check.whether(info.get("referredBy").equals(""))
                        .otherwise(CommonTask.chooseMultiItemInDropdown(VendorCompaniesPage.D_TEXT_BULK_UPDATE("Referred by"), info.get("referredBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("referredBy"))))
        );
    }

    public static Task updateBulkSuccess() {
        return Task.where("Update bulk edit success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Confirm")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Confirm")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Confirm")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Selected items has been updated successfully!"))
        );
    }
}

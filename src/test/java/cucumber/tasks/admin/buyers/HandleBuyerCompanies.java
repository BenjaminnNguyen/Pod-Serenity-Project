package cucumber.tasks.admin.buyers;

import cucumber.singleton.GVs;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.buyer.AllBuyerPage;
import cucumber.user_interface.admin.buyer.BuyerCompaniesPage;
import cucumber.user_interface.admin.vendors.AllVendorsForm;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.actions.Open;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleBuyerCompanies {

    public static Task search(Map<String, String> info) {
        return Task.where("Search buyer company",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Enter.theValue(info.get("name")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("name")),
                Check.whether(!Objects.equals(info.get("managedBy"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("manager_id"), info.get("managedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("managedBy")))
                        ),
                Check.whether(!Objects.equals(info.get("status"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("onboarding_state"), info.get("status"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("status")))
                        ),
                Check.whether(!Objects.equals(info.get("tag"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("tag_ids"), info.get("tag"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("tag")))
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task chooseRegionAndApprove(String region) {
        return Task.where("choose region and approve",
                CommonWaitUntil.isClickable(AllBuyerPage.REGION_SELECT),
                Click.on(AllBuyerPage.REGION_SELECT),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(region)),
                Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(region)),
                Click.on(AllBuyerPage.APPROVE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Buyer company has been approved successfully !")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)
        );
    }

    public static Task fillInfoToCreateBuyerCompany(Map<String, String> info) {
        return Task.where("Fill info to create buyer company",
                Enter.theValue(info.get("name")).into(BuyerCompaniesPage.CREATE_BUYER_NAME_TEXTBOX),
                Check.whether(valueOf(CommonAdminForm.DYNAMIC_BUTTON("I still want to create a new one")), isVisible())
                        .andIfSo(Click.on(CommonAdminForm.DYNAMIC_BUTTON("I still want to create a new one")).afterWaitingUntilEnabled()),
                CommonTask.chooseItemInDropdown1(BuyerCompaniesPage.CREATE_BUYER_STORE_TYPE_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("storeType"))),
                Check.whether(info.get("managedBy").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(BuyerCompaniesPage.CREATE_BUYER_MANAGED_TEXTBOX, info.get("managedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("managedBy")))),
                WindowTask.threadSleep(1000),
                Check.whether(info.get("launchBy").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(BuyerCompaniesPage.CREATE_BUYER_LAUNCH_TEXTBOX, info.get("launchBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("launchBy")))),
                Check.whether(info.get("edi").isEmpty())
                        .otherwise(Click.on(BuyerCompaniesPage.CREATE_BUYER_EDI_RADIOBUTTON)),
                Check.whether(info.get("fuelSurcharge").isEmpty())
                        .otherwise(Click.on(BuyerCompaniesPage.CREATE_BUYER_FUEL_RADIOBUTTON)),
                Check.whether(info.get("ein").isEmpty())
                        .otherwise(Enter.theValue(info.get("ein")).into(BuyerCompaniesPage.CREATE_BUYER_EIN_TEXTBOX)),
                Check.whether(info.get("website").isEmpty())
                        .otherwise(Enter.theValue(info.get("website")).into(BuyerCompaniesPage.CREATE_BUYER_WEBSITE_TEXTBOX))
        );
    }

    public static Performable addTagsToCreate(List<Map<String, String>> infos) {
        return Task.where("Add tags to create buyer company",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonTask.chooseItemInDropdownWithValueInput1(BuyerCompaniesPage.CREATE_BUYER_TAG_TEXTBOX, info.get("tags"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("tags")))
                        );
                    }

                }
        );
    }

    public static Task goToCreateBuyerCompany() {
        return Task.where("Go to create buyer company",
                CommonWaitUntil.isClickable(BuyerCompaniesPage.CREATE_BUYER_COMPANY_BUTTON),
                Click.on(BuyerCompaniesPage.CREATE_BUYER_COMPANY_BUTTON),
                CommonWaitUntil.isClickable(BuyerCompaniesPage.CREATE_NEW_BUYER_COMPANY_POPUP)
        );
    }

    public static Task createBuyerCompanySuccess() {
        return Task.where("Create buyer company success",
                CommonWaitUntil.isClickable(BuyerCompaniesPage.CREATE_BUYER_BUTTON_CREATE),
                Click.on(BuyerCompaniesPage.CREATE_BUYER_BUTTON_CREATE),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Performable deleteTagsInDetail(List<Map<String, String>> infos) {
        return Task.where("Delete tags in buyer company detail",
                actor -> {
                    for (Map<String, String> info : infos)
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.TAGS_IN_DETAIL(info.get("tag"))),
                                Click.on(BuyerCompaniesPage.TAGS_IN_DETAIL(info.get("tag"))),
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.TAGS_DELETE_BUTTON_IN_POPUP(info.get("tag"))),
                                Click.on(BuyerCompaniesPage.TAGS_DELETE_BUTTON_IN_POPUP(info.get("tag"))),
                                Click.on(BuyerCompaniesPage.TAGS_UPDATE_BUTTON_POPUP),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                                CommonWaitUntil.isNotVisible(BuyerCompaniesPage.TAG_CREATE_VENDOR_DELETE_BUTTON(info.get("tag")))
                        );
                }
        );
    }

    public static Performable addTagsInDetail(List<Map<String, String>> infos) {
        return Task.where("Add tags in vendor detail",
                actor -> {
                    for (Map<String, String> info : infos)
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.TAG_IN_DETAIL),
                                Click.on(BuyerCompaniesPage.TAG_IN_DETAIL),
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.TAGS_POPUP_LABEL),
                                CommonTask.chooseItemInDropdownWithValueInput1(BuyerCompaniesPage.TAGS_TEXTBOX_POPUP, info.get("tag"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("tag"))),
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.TAGS_DELETE_BUTTON_IN_POPUP(info.get("tag"))),
                                Check.whether(info.get("expiryDate").isEmpty())
                                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("expiryDate"), "MM/dd/yy")).into(BuyerCompaniesPage.TAGS_EXPIRY_TEXTBOX_IN_POPUP(info.get("tag"))).thenHit(Keys.ENTER)),
                                Click.on(BuyerCompaniesPage.TAGS_UPDATE_BUTTON_POPUP),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                                CommonWaitUntil.isNotVisible(BuyerCompaniesPage.TAG_CREATE_VENDOR_DELETE_BUTTON(info.get("tag"))),
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.TAGS_IN_DETAIL(info.get("tag"))),
                                Check.whether(info.get("expiryDate").isEmpty())
                                        .otherwise(CommonWaitUntil.isVisible(BuyerCompaniesPage.TAGS_EXPIRY_DATE_IN_DETAIL(info.get("tag"))))
                        );
                }
        );
    }

    public static Task deactivateThisCompany() {
        return Task.where("Deactivate this company",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Deactivate this company")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Deactivate this company")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Deactivating this buyer company will also deactivate its stores and associated buyer accounts won't be able to login. Proceed?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Deactivating this buyer company will also deactivate its stores and associated buyer accounts won't be able to login. Proceed?")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Processing…")),
                CommonWaitUntil.isVisible(VendorCompaniesPage.DETAIL_STATE_VALUE("Inactive"))
        );
    }

    public static Task activeThisCompany() {
        return Task.where("Activate this company",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Activate this company")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Activate this company")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("This will activate current buyer company. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("This will activate current buyer company. Continue?")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Processing…")),
                CommonWaitUntil.isVisible(VendorCompaniesPage.DETAIL_STATE_VALUE("Active"))
        );
    }

    public static Performable uploadCompanyDocument(List<Map<String, String>> infos) {
        return Task.where("Upload company document",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.COMPANY_DOCUMENT_PREVIEW_DESCRIPTION(info.get("index"))),
                                CommonFile.upload2(info.get("file"), BuyerCompaniesPage.COMPANY_DOCUMENT_UPLOAD_FILE(info.get("index"))),
                                Enter.theValue(info.get("description")).into(BuyerCompaniesPage.COMPANY_DOCUMENT_PREVIEW_DESCRIPTION(info.get("index"))),
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Processing…"))
                        );
                    }
                }
        );
    }

    public static Performable uploadMultiInRowCompanyDocument(List<Map<String, String>> infos) {
        return Task.where("upload company document multi in row",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                            Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a document"))
                    );
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.COMPANY_DOCUMENT_PREVIEW_DESCRIPTION(info.get("index"))),
                                CommonFile.upload2(info.get("file"), BuyerCompaniesPage.COMPANY_DOCUMENT_UPLOAD_FILE(info.get("index"))),
                                Enter.theValue(info.get("description")).into(BuyerCompaniesPage.COMPANY_DOCUMENT_PREVIEW_DESCRIPTION(info.get("index")))
                        );
                    }
                    actor.attemptsTo(
                            Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Processing…"))
                    );
                }
        );
    }

    public static Performable uploadMultiInRowBusinessLicenseCertificates(List<Map<String, String>> infos) {
        return Task.where("upload business license certificates multi in row",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a business license certificates")),
                            Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a business license certificates"))
                    );
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.BUSINESS_LICENSE_CERTIFICATES_REMOVE_BUTTON(info.get("index"))),
                                CommonFile.upload2(info.get("file"), BuyerCompaniesPage.BUSINESS_LICENSE_CERTIFICATES_UPLOAD_FILE(info.get("index")))
                        );
                    }
                    actor.attemptsTo(
                            Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Processing…"))
                    );
                }
        );
    }

    public static Performable uploadBusinessLicenseCertificates(List<Map<String, String>> infos) {
        return Task.where("Upload business license certificates",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a business license certificates")),
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a business license certificates")),
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.BUSINESS_LICENSE_CERTIFICATES_REMOVE_BUTTON(info.get("index"))),
                                CommonFile.upload2(info.get("file"), BuyerCompaniesPage.BUSINESS_LICENSE_CERTIFICATES_UPLOAD_FILE(info.get("index"))),
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Processing…"))
                        );
                    }
                }
        );
    }

    public static Performable uploadMultiInRowResaleCertificates(List<Map<String, String>> infos) {
        return Task.where("upload resale certificates multi in row",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a resale certificate")),
                            Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a resale certificate"))
                    );
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.RESALE_CERTIFICATES_REMOVE_BUTTON(info.get("index"))),
                                CommonFile.upload2(info.get("file"), BuyerCompaniesPage.RESALE_CERTIFICATES_UPLOAD_FILE(info.get("index")))
                        );
                    }
                    actor.attemptsTo(
                            Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Processing…"))
                    );
                }
        );
    }

    public static Performable uploadResaleCertificates(List<Map<String, String>> infos) {
        return Task.where("Upload resale certificates",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a resale certificate")),
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a resale certificate")),
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.RESALE_CERTIFICATES_REMOVE_BUTTON(info.get("index"))),
                                CommonFile.upload2(info.get("file"), BuyerCompaniesPage.RESALE_CERTIFICATES_UPLOAD_FILE(info.get("index"))),
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Processing…"))
                        );
                    }
                }
        );
    }

    public static Performable removeResaleCertificates(List<Map<String, String>> infos) {
        return Task.where("remove resale certificates",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.RESALE_CERTIFICATES_REMOVE_BUTTON(info.get("index"))),
                                Click.on(BuyerCompaniesPage.RESALE_CERTIFICATES_REMOVE_BUTTON(info.get("index")))
                        );
                    }
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                            Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Processing…"))
                    );
                }
        );
    }

    public static Performable removeCompanyDocument(List<Map<String, String>> infos) {
        return Task.where("remove company document",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.COMPANY_DOCUMENT_REMOVE_BUTTON(info.get("index"))),
                                Click.on(BuyerCompaniesPage.COMPANY_DOCUMENT_REMOVE_BUTTON(info.get("index")))
                        );
                    }
                    actor.attemptsTo(
                            Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Save"))
                    );
                }
        );
    }

    public static Performable removeBusinessLicenseCertificates(List<Map<String, String>> infos) {
        return Task.where("remove Business license certificates",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(BuyerCompaniesPage.BUSINESS_LICENSE_REMOVE_BUTTON(info.get("index"))),
                                Click.on(BuyerCompaniesPage.BUSINESS_LICENSE_REMOVE_BUTTON(info.get("index")))
                        );
                    }
                    actor.attemptsTo(
                            Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Save"))
                    );
                }
        );
    }

    public static Task setReferrerVendorCompany(String vendorCompany) {
        return Task.where("Set Referrer Vendor Company",
                CommonWaitUntil.isVisible(BuyerCompaniesPage.SET_REFERRER_VENDOR_COMPANY),
                Click.on(BuyerCompaniesPage.SET_REFERRER_VENDOR_COMPANY),
                CommonWaitUntil.isVisible(BuyerCompaniesPage.SET_REFERRER_VENDOR_COMPANY_TEXTBOX),
                CommonTask.chooseItemInDropdownWithValueInput1(BuyerCompaniesPage.SET_REFERRER_VENDOR_COMPANY_TEXTBOX, vendorCompany, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(vendorCompany)),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Set referrer vendor company")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("All stores in this buyer company has been updated successfully !!")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)

        );
    }

    public static Task goToCreateCustomField() {
        return Task.where("Go to create custom field",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create Custom Field")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create Custom Field")),
                CommonWaitUntil.isVisible(BuyerCompaniesPage.CREATE_NEW_BUYER_FIELD_LABEL)
        );
    }

    public static Task createNewCustomField(Map<String, String> info) {
        return Task.where("Create new custom field",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create Custom Field")),
                Enter.theValue(info.get("name")).into(AllVendorsForm.NAME_CUSTOM_VENDOR_FIELD_TEXTBOX),
                CommonTask.chooseItemInDropdown1(AllVendorsForm.DATA_TYPE_CUSTOM_VENDOR_FIELD_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("dataType"))),
                WindowTask.threadSleep(500),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create"))
        );
    }

    public static Performable select(List<Map<String, String>> infos) {
        return Task.where("Select buyer company in result",
                actor -> {
                    for (Map<String, String> info : infos) {
                        theActorInTheSpotlight().attemptsTo(
                                CommonWaitUntil.isVisible(VendorCompaniesPage.D_CHECKBOX_RESULT(info.get("buyerCompany"))),
                                JavaScriptClick.on(VendorCompaniesPage.D_CHECKBOX_RESULT(info.get("buyerCompany"))),
                                WindowTask.threadSleep(1000)
                        );
                    }
                }
        );
    }

    public static Task goToPageByUrl(String id) {
        return Task.where("Go to buyer company page by url",
                Open.url(GVs.URL_ADMIN + "buyers/companies/" + id),
                WindowTask.threadSleep(2000)
        );
    }

    public static Task updateBulk(Map<String, String> info) {
        return Task.where("Update bulk buyer companies",
                Check.whether(info.get("managedBy").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(VendorCompaniesPage.D_TEXT_BULK_UPDATE("Managed by"), info.get("managedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("managedBy")))),
                Check.whether(info.get("launchedBy").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(VendorCompaniesPage.D_TEXT_BULK_UPDATE("Launched by"), info.get("launchedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("launchedBy")))),
                Check.whether(info.get("storeType").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(VendorCompaniesPage.D_TEXT_BULK_UPDATE("Store type"), info.get("storeType"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("storeType"))))
        );
    }

    public static Task delete(String buyerCompany) {
        return Task.where("Delete this company",
                CommonWaitUntil.isVisible(BuyerCompaniesPage.BUYER_COMPANY_DELETE_RESULT(buyerCompany)),
                Click.on(BuyerCompaniesPage.BUYER_COMPANY_DELETE_RESULT(buyerCompany)),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Deleting this buyer company will also delete all its stores and buyers. Are you sure you want to continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(BuyerCompaniesPage.BUYER_COMPANY_DELETE_RESULT(buyerCompany))
        );
    }

}

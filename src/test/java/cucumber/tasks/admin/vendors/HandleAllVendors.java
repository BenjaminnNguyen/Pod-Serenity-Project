package cucumber.tasks.admin.vendors;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.vendors.AllVendorsForm;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

public class HandleAllVendors {

    public static Task goToCreateCustomField() {
        return Task.where("Go to create custom field",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create Custom Field")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create Custom Field")),
                CommonWaitUntil.isVisible(AllVendorsForm.CREATE_NEW_VENDOR_FIELD_LABEL)
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

    public static Task goToCreateNewVendor() {
        return Task.where("Go to create new vendor",
                CommonWaitUntil.isVisible(AllVendorsForm.CREATE_VENDOR_BUTTON),
                Click.on(AllVendorsForm.CREATE_VENDOR_BUTTON).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(AllVendorsForm.CREATE_NEW_VENDOR_FIELD_LABEL)
        );
    }

    public static Task fillInfoToCreateVendor(Map<String, String> info) {
        return Task.where("Fill info to create vendor",
                CommonWaitUntil.isVisible(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Name")),
                Enter.theValue(info.get("firstName")).into(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Name")),
                Enter.theValue(info.get("lastName")).into(AllVendorsForm.LAST_NAME_TEXTBOX),
                Enter.theValue(info.get("email")).into(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Email")),
                CommonTask.chooseItemInDropdownWithValueInput1(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Company"), info.get("company"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("company"))),
                Enter.theValue(info.get("password")).into(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Password"))
        );
    }

    public static Task fillInfoCustomToCreateVendor(Map<String, String> info) {
        return Task.where("Fill info custom to create vendor",
                CommonWaitUntil.isVisible(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Vendor boolean")),
                Check.whether(info.get("boolean").equals(""))
                        .otherwise(CommonTask.chooseItemInDropdown1(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Vendor boolean"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("boolean")))),
                Check.whether(info.get("date").equals(""))
                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("date"), "MM/dd/yy")).into(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Vendor date")).thenHit(Keys.ENTER)),
                Check.whether(info.get("file").equals(""))
                        .otherwise(
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add file")),
                                CommonFile.upload2(info.get("file"), AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Vendor file"))),
                Check.whether(info.get("numeric").equals(""))
                        .otherwise(Enter.theValue(info.get("numeric")).into(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Vendor numeric"))),
                Check.whether(info.get("text").equals(""))
                        .otherwise(Enter.theValue(info.get("text")).into(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Vendor text")))
        );
    }

    public static Performable addTags(List<Map<String, String>> infos) {
        return Task.where("Add tags in create vendor",
                actor -> {
                    for (Map<String, String> info : infos)
                        actor.attemptsTo(
                                CommonTask.chooseItemInDropdownWithValueInput1(AllVendorsForm.D_CREATE_VENDOR_TEXTBOX("Tags"), info.get("tags"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("tags"))),
                                CommonWaitUntil.isVisible(AllVendorsForm.TAG_CREATE_VENDOR(info.get("tags"))),
                                Ensure.that(AllVendorsForm.TAG_CREATE_VENDOR(info.get("tags"))).isDisplayed()
                        );
                }
        );
    }

    public static Task createVendorSuccess() {
        return Task.where("Go to create new vendor",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Performable deleteTags(List<Map<String, String>> infos) {
        return Task.where("Delete tags in create vendor",
                actor -> {
                    for (Map<String, String> info : infos)
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(AllVendorsForm.TAG_CREATE_VENDOR(info.get("tags"))),
                                Click.on(AllVendorsForm.TAG_CREATE_VENDOR_DELETE_BUTTON(info.get("tags"))),
                                CommonWaitUntil.isNotVisible(AllVendorsForm.TAG_CREATE_VENDOR(info.get("tags")))
                        );
                }
        );
    }

    public static Task searchVendors(Map<String, String> info) {
        return Task.where("Search vendors",
                Check.whether(info.get("fullName").isEmpty())
                        .otherwise(Enter.theValue(info.get("fullName")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[full_name]"))),
                Check.whether(info.get("email").isEmpty())
                        .otherwise(Enter.theValue(info.get("email")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[email]"))),
                Check.whether(info.get("vendorCompany").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[vendor_company_id]"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany")))
                        ),
                Check.whether(info.get("brand").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[brand_id]"), info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("brand")))
                        ),
                Check.whether(info.get("region").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))
                        ),
                Check.whether(info.get("address").isEmpty())
                        .otherwise(Enter.theValue(info.get("address")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[vendor_company_address_city]"))
                        ),
                Check.whether(info.get("state").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[vendor_company_address_address_state_id]"), info.get("state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("state")))
                        ),
                Check.whether(info.get("tags").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[tag_ids][]"), info.get("tags"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("tags")))
                        ),
                Check.whether(info.get("approved").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[approved]"), info.get("approved"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("approved")))
                        ),
                Check.whether(info.get("shopify").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[shopify]"), info.get("shopify"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("shopify")))
                        ),
                Check.whether(info.get("status").isEmpty())
                        .otherwise(CommonTask.chooseItemInDropdown1(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[active_state]"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("status")))
                        ),

                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToVendorDetail(String vendor) {
        return Task.where("Go to vendor detail",
                CommonWaitUntil.isVisible(AllVendorsForm.NAME_IN_RESULT(vendor)),
                Click.on(AllVendorsForm.NAME_IN_RESULT(vendor)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(AllVendorsForm.GENERAL_INFO_LABEL)
        );
    }

    public static Performable deleteTagsInDetail(List<Map<String, String>> infos) {
        return Task.where("Delete tags in vendor detail",
                actor -> {
                    for (Map<String, String> info : infos)
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(AllVendorsForm.TAGS_IN_DETAIL(info.get("tag"))),
                                Click.on(AllVendorsForm.TAGS_IN_DETAIL(info.get("tag"))),
                                CommonWaitUntil.isVisible(AllVendorsForm.TAGS_DELETE_BUTTON_IN_POPUP(info.get("tag"))),
                                Click.on(AllVendorsForm.TAGS_DELETE_BUTTON_IN_POPUP(info.get("tag"))),
                                Click.on(AllVendorsForm.TAGS_UPDATE_BUTTON_POPUP),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                                CommonWaitUntil.isNotVisible(AllVendorsForm.TAG_CREATE_VENDOR_DELETE_BUTTON(info.get("tag")))
                        );
                }
        );
    }

    public static Performable addTagsInDetail(List<Map<String, String>> infos) {
        return Task.where("Add tags in vendor detail",
                actor -> {
                    for (Map<String, String> info : infos)
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(AllVendorsForm.TAG_IN_DETAIL),
                                Click.on(AllVendorsForm.TAG_IN_DETAIL),
                                CommonWaitUntil.isVisible(AllVendorsForm.TAGS_POPUP_LABEL),
                                CommonTask.chooseItemInDropdownWithValueInput1(AllVendorsForm.TAGS_TEXTBOX_POPUP, info.get("tag"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("tag"))),
                                CommonWaitUntil.isVisible(AllVendorsForm.TAGS_DELETE_BUTTON_IN_POPUP(info.get("tag"))),
                                Check.whether(info.get("expiryDate").isEmpty())
                                        .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("expiryDate"), "MM/dd/yy")).into(AllVendorsForm.TAGS_EXPIRY_TEXTBOX_IN_POPUP(info.get("tag"))).thenHit(Keys.ENTER)),
                                Click.on(AllVendorsForm.TAGS_UPDATE_BUTTON_POPUP),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                                CommonWaitUntil.isNotVisible(AllVendorsForm.TAG_CREATE_VENDOR_DELETE_BUTTON(info.get("tag"))),
                                CommonWaitUntil.isVisible(AllVendorsForm.TAGS_IN_DETAIL(info.get("tag"))),
                                Check.whether(info.get("expiryDate").isEmpty())
                                        .otherwise(CommonWaitUntil.isVisible(AllVendorsForm.TAGS_EXPIRY_DATE_IN_DETAIL(info.get("tag"))))
                        );
                }
        );
    }

    public static Task editCustomField(Map<String, String> info) {
        return Task.where("Edit custom field",
                Check.whether(info.get("boolean").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipDropdown(AllVendorsForm.CUSTOM_FIELD_DETAIL("Vendor boolean", "boolean-field"), info.get("boolean"))),
                Check.whether(info.get("date").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipDateTime(AllVendorsForm.CUSTOM_FIELD_DETAIL("Vendor date", "date-field"), CommonHandle.setDate2(info.get("date"), "MM/dd/yy"))),
                Check.whether(info.get("numeric").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(AllVendorsForm.CUSTOM_FIELD_DETAIL("Vendor numeric", "numeric-field"), info.get("numeric"))),
                Check.whether(info.get("text").equals(""))
                        .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(AllVendorsForm.CUSTOM_FIELD_DETAIL("Vendor text", "text-field"), info.get("text"))),
                Check.whether(info.get("file").equals(""))
                        .otherwise(
                                // remove old file
                                Click.on(AllVendorsForm.CUSTOM_FIELD_FILE_REMOVE_BUTTON),
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add file")),
                                CommonFile.upload2(info.get("file"), AllVendorsForm.CUSTOM_FIELD_FILE_UPLOAD),
                                Click.on(AllVendorsForm.CUSTOM_FIELD_FILE_SAVE_BUTTON),
                                CommonWaitUntil.isNotVisible(AllVendorsForm.CUSTOM_FIELD_FILE_SAVE_BUTTON))
        );
    }

    public static Task navigateProductLink() {
        return Task.where("Edit custom field",
                CommonWaitUntil.isVisible(AllVendorsForm.FOOTER_PRODUCT_LINK),
                Click.on(AllVendorsForm.FOOTER_PRODUCT_LINK),
                CommonWaitUntil.isVisible(CommonAdminForm.SEARCH_BUTTON)
        );
    }

    public static Task delete(String vendor) {
        return Task.where("Delete vendor",
                CommonWaitUntil.isVisible(AllVendorsForm.DELETE_RESULT_BUTTON(vendor)),
                Click.on(AllVendorsForm.DELETE_RESULT_BUTTON(vendor)),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("This will permanently delete this record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue"))
        );
    }

    public static Task activeThisVendor() {
        return Task.where("Activate this vendor",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Activate this vendor")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Activate this vendor"))
        );
    }

    public static Task deactivateThisVendor() {
        return Task.where("Deactivate this vendor",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Deactivate this vendor")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Deactivate this vendor"))
        );
    }
}

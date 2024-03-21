package cucumber.tasks.admin.buyers;

import cucumber.singleton.GVs;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
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
import net.serenitybdd.screenplay.actions.Open;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.awt.*;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleAllBuyer {

    public static Task search(Map<String, String> info) {
        return Task.where("Search all buyer",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Enter.theValue(info.get("anyText")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("any_text")),
                Enter.theValue(info.get("fullName")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("full_name")),
                Enter.theValue(info.get("email")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("email")),
                Check.whether(!Objects.equals(info.get("role"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("role"), info.get("role"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("role")))
                        ),
                Check.whether(!Objects.equals(info.get("store"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id"), info.get("store"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("store")))
                        ),
                Check.whether(!Objects.equals(info.get("managedBy"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_manager_id"), info.get("managedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("managedBy")))
                        ),
                Check.whether(!Objects.equals(info.get("tag"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("tag_ids"), info.get("tag"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("tag")))
                        ),
                Check.whether(!Objects.equals(info.get("status"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("active_state"), info.get("status"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("status")))
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToCreateBuyer() {
        return Task.where("Go to create buyer",
                CommonWaitUntil.isVisible(AllBuyerPage.CREATE_NEW_BUYER_BUTTON),
                Click.on(AllBuyerPage.CREATE_NEW_BUYER_BUTTON),
                CommonWaitUntil.isVisible(AllBuyerPage.CREATE_NEW_BUYER_POPUP)
        );
    }

    public static Performable fillInfoToCreateBuyer(Map<String, String> info) {
        return Task.where("Fill info to create new buyer",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                            Enter.theValue(info.get("firstName")).into(AllBuyerPage.CREATE_BUYER_FIRST_NAME_TEXTBOX),
                            Enter.theValue(info.get("lastName")).into(AllBuyerPage.CREATE_BUYER_LAST_NAME_TEXTBOX),
                            Enter.theValue(info.get("email")).into(AllBuyerPage.CREATE_BUYER_EMAIL_TEXTBOX),
                            CommonTask.chooseItemInDropdown1(AllBuyerPage.CREATE_BUYER_ROLE_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("role")))
                    );
                    if (info.get("role").equals("Head buyer")) {
                        actor.attemptsTo(
                                CommonTask.chooseItemInDropdownWithValueInput1(AllBuyerPage.CREATE_BUYER_BUYER_COMPANY_TEXTBOX, info.get("buyerCompany"),
                                        CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerCompany"))),
                                CommonTask.chooseItemInDropdownWithValueInput1(AllBuyerPage.CREATE_BUYER_REGION_TEXTBOX, info.get("region"),
                                        CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))
                        );
                    }
                    if (info.get("role").equals("Store manager")) {
                        actor.attemptsTo(
                                CommonTask.chooseItemInDropdownWithValueInput1(AllBuyerPage.CREATE_BUYER_STORE_TEXTBOX, info.get("store"),
                                        CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("store")))
                        );
                    }
                    if (info.get("role").equals("Store sub-buyer")) {
                        if (info.containsKey("manager"))
                            actor.attemptsTo(
                                    CommonTask.chooseItemInDropdownWithValueInput1(AllBuyerPage.CREATE_BUYER_STORE_TEXTBOX, info.get("store"),
                                            CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("store"))),
                                    CommonTask.chooseItemInDropdownWithValueInput1(AllBuyerPage.CREATE_BUYER_MANAGER_TEXTBOX, info.get("manager"),
                                            CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("manager")))
                            );
                    }
                    actor.attemptsTo(
                            Check.whether(info.get("department").isEmpty())
                                    .otherwise(
                                            Enter.theValue(info.get("department")).into(AllBuyerPage.CREATE_BUYER_DEPARTMENT_TEXTBOX)),
                            Check.whether(info.get("contactNumber").isEmpty())
                                    .otherwise(
                                            Enter.theValue(info.get("contactNumber")).into(AllBuyerPage.CREATE_BUYER_CONTACT_NUMBER_TEXTBOX)),
                            Enter.theValue(info.get("password")).into(AllBuyerPage.CREATE_BUYER_PASSWORD_TEXTBOX)
                    );
                }
        );
    }

    public static Task createBuyerSuccess() {
        return Task.where("Create Buyer success", CommonWaitUntil.isVisible(AllBuyerPage.CREATE_BUYER_BUTTON), Click.on(AllBuyerPage.CREATE_BUYER_BUTTON), CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER), CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER));
    }

    public static Task removeRegion(String region) {
        return Task.where("Remove region of create head buyer", CommonWaitUntil.isVisible(AllBuyerPage.REMOVE_REGION(region)), Click.on(AllBuyerPage.REMOVE_REGION(region)), CommonWaitUntil.isNotVisible(AllBuyerPage.REMOVE_REGION(region)));
    }

    public static Performable addTagInCreate(List<Map<String, String>> infos) {
        return Task.where("Add tag in create buyer", actor -> {
            for (Map<String, String> info : infos) {
                actor.attemptsTo(CommonWaitUntil.isVisible(AllBuyerPage.CREATE_BUYER_TAG_TEXTBOX), CommonTask.chooseItemInDropdownWithValueInput1(AllBuyerPage.CREATE_BUYER_TAG_TEXTBOX, info.get("tags"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("tags"))), CommonWaitUntil.isVisible(AllBuyerPage.CREATE_BUYER_TAG_TEXTBOX), Check.whether(info.get("expiryDate").isEmpty()).otherwise(Enter.theValue(CommonHandle.setDate2(info.get("expiryDate"), "MM/dd/yy")).into(AllBuyerPage.CREATE_BUYER_TAG_ADDED_EXPIRY_DATE(info.get("tags"))).thenHit(Keys.ENTER)));
            }
        });
    }

    public static Performable editGeneralInfo(String type, Map<String, String> info) {
        return Task.where("Edit general info",
                actor -> {
                    actor.attemptsTo(Check.whether(info.get("email").isEmpty())
                                    .otherwise(
                                            CommonTaskAdmin.changeValueTooltipTextbox(AllBuyerPage.DYNAMIC_DETAIL("email"), info.get("email"))),
                            Check.whether(info.get("firstName").isEmpty())
                                    .otherwise(
                                            CommonTaskAdmin.changeValueTooltipTextbox(AllBuyerPage.DYNAMIC_DETAIL("first-name"), info.get("firstName"))),
                            Check.whether(info.get("lastName").isEmpty())
                                    .otherwise(
                                            CommonTaskAdmin.changeValueTooltipTextbox(AllBuyerPage.DYNAMIC_DETAIL("last-name"), info.get("lastName"))),
                            Check.whether(info.get("contact").isEmpty())
                                    .otherwise(
                                            CommonTaskAdmin.changeValueTooltipTextbox(AllBuyerPage.DYNAMIC_DETAIL("contact-number"), info.get("contact"))),
                            Check.whether(info.get("department").isEmpty())
                                    .otherwise(
                                            CommonTaskAdmin.changeValueTooltipTextbox(AllBuyerPage.DYNAMIC_DETAIL("business-name"), info.get("department")))
                    );
                    if (type.equals("head")) {
                        actor.attemptsTo(
                                Check.whether(info.get("manualRegion").isEmpty())
                                        .otherwise(
                                                CommonTaskAdmin.changeValueTooltipDropdown(AllBuyerPage.MANUAL_REGION_EDIT, info.get("manualRegion")))
                        );
                    }
                    if (type.equals("store")) {
                        actor.attemptsTo(
                                Check.whether(info.get("store").isEmpty())
                                        .otherwise(
                                                CommonTaskAdmin.changeValueTooltipDropdownWithInput(AllBuyerPage.STORE_EDIT, info.get("store"))),
                                Check.whether(info.get("role").isEmpty())
                                        .otherwise(
                                                CommonTaskAdmin.changeValueTooltipDropdown(AllBuyerPage.DYNAMIC_DETAIL("role"), info.get("role"))),
                                Check.whether(info.get("manager").isEmpty())
                                        .otherwise(
                                                CommonTaskAdmin.changeValueTooltipDropdownWithInput(AllBuyerPage.BUYER_DETAIL_MANAGER, info.get("manager")))
                        );
                    }
                }
        );
    }

    public static Performable deleteTagsInDetail(List<Map<String, String>> infos) {
        return Task.where("Delete tags in buyer detail",
                actor -> {
                    for (Map<String, String> info : infos)
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(AllBuyerPage.BUYER_DETAIL_TAGS(info.get("tag"))),
                                Click.on(AllBuyerPage.BUYER_DETAIL_TAGS(info.get("tag"))),
                                CommonWaitUntil.isVisible(AllBuyerPage.TAGS_DELETE_BUTTON_IN_POPUP(info.get("tag"))),
                                Click.on(AllBuyerPage.TAGS_DELETE_BUTTON_IN_POPUP(info.get("tag"))),
                                Click.on(AllBuyerPage.TAGS_UPDATE_BUTTON_POPUP),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                                CommonWaitUntil.isNotVisible(AllBuyerPage.TAGS_DELETE_BUTTON_IN_POPUP(info.get("tag")))
                        );
                }
        );
    }

    public static Performable addTagsInDetail(List<Map<String, String>> infos) {
        return Task.where("Add tags in buyer detail",
                actor -> {
                    for (Map<String, String> info : infos)
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(AllBuyerPage.TAG_IN_DETAIL),
                                Click.on(AllBuyerPage.TAG_IN_DETAIL),
                                CommonWaitUntil.isVisible(AllBuyerPage.TAGS_POPUP_LABEL),
                                CommonTask.chooseItemInDropdownWithValueInput1(AllBuyerPage.TAGS_TEXTBOX_POPUP, info.get("tag"),
                                        CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("tag"))),
                                CommonWaitUntil.isVisible(AllBuyerPage.TAGS_DELETE_BUTTON_IN_POPUP(info.get("tag"))),
                                Check.whether(info.get("expiryDate").isEmpty())
                                        .otherwise(
                                                Enter.theValue(CommonHandle.setDate2(info.get("expiryDate"), "MM/dd/yy")).into(AllBuyerPage.TAGS_EXPIRY_TEXTBOX_IN_POPUP(info.get("tag"))).thenHit(Keys.ENTER)),
                                Click.on(AllBuyerPage.TAGS_UPDATE_BUTTON_POPUP),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                                CommonWaitUntil.isNotVisible(AllBuyerPage.TAGS_DELETE_BUTTON_IN_POPUP(info.get("tag"))),
                                CommonWaitUntil.isVisible(AllBuyerPage.BUYER_DETAIL_TAGS(info.get("tag"))),
                                Check.whether(info.get("expiryDate").isEmpty())
                                        .otherwise(
                                                CommonWaitUntil.isVisible(AllBuyerPage.BUYER_DETAIL_TAGS_EXPIRY(info.get("tag"))))
                        );
                }
        );
    }

    public static Performable navigateFooterLink(String link) {
        return Task.where("navigate buyer order link",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(AllBuyerPage.FOOTER_LINK(link)),
                            Scroll.to(AllBuyerPage.FOOTER_LINK(link)),
                            Click.on(AllBuyerPage.FOOTER_LINK(link))
                    );
                    if (!link.equals("Find all buyer's credit memos")) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(CommonAdminForm.SEARCH_BUTTON)
                        );
                    }
                });
    }

    public static Task deleteBuyer(String buyer) {
        return Task.where("Remove region of create head buyer",
                CommonWaitUntil.isVisible(AllBuyerPage.BUYER_RESULT_DELETE_BUTTON(buyer)),
                Click.on(AllBuyerPage.BUYER_RESULT_DELETE_BUTTON(buyer)),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("This will permanently delete this record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("This will permanently delete this record. Continue?"))
        );
    }

    public static Task goToPageByUrl(String id) {
        return Task.where("Go to buyer page by url",
                Open.url(GVs.URL_ADMIN + "buyers/" + id),
                WindowTask.threadSleep(2000)
        );
    }

    public static Task removeWhitelist(Map<String, String> info) {
        return Task.where("Go to buyer page by url",
                CommonWaitUntil.isVisible(AllBuyerPage.SKU_ALLOWLIST_DELETE(info.get("sku"))),
                Click.on(AllBuyerPage.SKU_ALLOWLIST_DELETE(info.get("sku"))),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Are you sure to remove this SKU from the whitelist?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK")),
                CommonWaitUntil.isNotVisible(AllBuyerPage.SKU_ALLOWLIST_DELETE(info.get("sku")))
        );
    }

    public static Task deactivateThisBuyer() {
        return Task.where("Deactivate this buyer",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Deactivate this buyer")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Deactivate this buyer")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Processing…")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Activate this buyer"))
        );
    }

    public static Task activeThisBuyer() {
        return Task.where("Activate this buyer",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Activate this buyer")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Activate this buyer")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_BUTTON("Processing…")),
                CommonWaitUntil.isVisible(VendorCompaniesPage.DETAIL_STATE_VALUE("Deactivate this buyer"))
        );
    }

}

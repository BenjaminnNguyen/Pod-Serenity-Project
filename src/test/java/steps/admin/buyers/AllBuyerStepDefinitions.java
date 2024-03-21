package steps.admin.buyers;


import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.buyers.HandleAllBuyer;
import cucumber.tasks.admin.buyers.HandleBuyerCompanies;
import cucumber.tasks.admin.financial.HandleVendorStatements;
import cucumber.tasks.admin.vendors.HandleAllVendors;
import cucumber.tasks.admin.vendors.HandleVendorCompanies;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.buyer.AllBuyerPage;
import cucumber.user_interface.admin.buyer.BuyerCompaniesPage;
import cucumber.user_interface.admin.orders.AllOrdersForm;
import cucumber.user_interface.admin.store.AllStoresPage;
import cucumber.user_interface.admin.vendors.AllVendorsForm;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.*;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Clear;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Switch;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.CoreMatchers.containsString;

public class AllBuyerStepDefinitions {

    @And("Admin search all buyer")
    public void admin_search_all_buyer(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(infos.get(0), "anyText", Serenity.sessionVariableCalled("Onboard Name Company"));
        info = CommonTask.setValueRandom(info, "store", Serenity.sessionVariableCalled("Onboard Name Company"));
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.resetFilter(),
                CommonTaskAdmin.showFilter(),
                HandleAllBuyer.search(info)
        );
    }

    @And("Admin verify result all buyer")
    public void admin_verify_result_all_buyer(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllBuyerPage.BUYER_NAME).text().contains(expected.get(0).get("name")),
                Ensure.that(AllBuyerPage.DYNAMIC_RESULT("region")).text().contains(expected.get(0).get("region")),
                Ensure.that(AllBuyerPage.DYNAMIC_RESULT("role")).text().contains(expected.get(0).get("role")),
                Ensure.that(AllBuyerPage.DYNAMIC_RESULT("email")).attribute("data-original-text").contains(expected.get(0).get("email"))
        );
        if (expected.get(0).containsKey("store")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllBuyerPage.DYNAMIC_RESULT("store")).attribute("data-original-text").contains(expected.get(0).get("store"))
            );
        }
        if (expected.get(0).containsKey("status")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllBuyerPage.STATUS_RESULT).text().contains(expected.get(0).get("status"))
            );
        }

        if (expected.get(0).containsKey("regionHover")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllBuyerPage.STATUS_RESULT).text().contains(expected.get(0).get("status"))
            );
        }
    }

    @And("Admin go to detail of buyer {string}")
    public void admin_search_buyer_company(String name) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(AllBuyerPage.BUYER_NAME),
                CommonWaitUntil.isVisible(BuyerCompaniesPage.GENERAL_INFO)
        );
    }

    @And("Admin verify general information of all buyer")
    public void admin_verify_general_information_of_all_buyer(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(expected.get(0), "email", Serenity.sessionVariableCalled("Email Onboard"));
        info = CommonTask.setValueRandom(info, "store", Serenity.sessionVariableCalled("Onboard Name Company"));

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("email")).text().contains(info.get("email")),
                Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("first-name")).text().contains(expected.get(0).get("firstName")),
                Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("last-name")).text().contains(expected.get(0).get("lastName")),
                Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("contact-number")).text().contains(expected.get(0).get("contact")),
                Check.whether(expected.get(0).get("department").isEmpty())
                        .otherwise(Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("business-name")).text().contains(expected.get(0).get("department"))),
                Ensure.that(AllBuyerPage.STORE(info.get("store"))).isDisplayed(),
                Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("role")).text().contains(expected.get(0).get("role"))
        );
        if (expected.get(0).containsKey("manager")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("manager")).text().contains(info.get("manager"))
            );
        }
    }

    @And("Admin verify general information of head buyer detail")
    public void admin_verify_general_information_of_head_buyer_detail(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("email")).text().contains(expected.get(0).get("email")),
                Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("first-name")).text().contains(expected.get(0).get("firstName")),
                Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("last-name")).text().contains(expected.get(0).get("lastName")),
                Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("contact-number")).text().contains(expected.get(0).get("contact")),
                Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("business-name")).text().contains(expected.get(0).get("department")),
                Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("role")).text().contains(expected.get(0).get("role")),
                Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("auto-generated-region")).text().contains(expected.get(0).get("autoRegion")),
                Check.whether(expected.get(0).get("manualRegion").isEmpty())
                        .otherwise(
                                Ensure.that(AllBuyerPage.DYNAMIC_DETAIL("manually-added-region")).text().contains(expected.get(0).get("manualRegion"))),
                Check.whether(expected.get(0).get("buyerCompany").isEmpty())
                        .otherwise(
                                Ensure.that(AllBuyerPage.BUYER_COMPANY_DETAIL).text().contains(expected.get(0).get("buyerCompany")))
        );
    }

    @And("Admin create new buyer account")
    public void admin_create_buyer(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.fillInfoToCreateBuyer(infos.get(0))
        );
    }

    @And("Admin create new buyer account success")
    public void admin_create_buyer_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.createBuyerSuccess()
        );
    }

    @And("Admin create new buyer account with error {string}")
    public void admin_create_buyer_success_with_error(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllBuyerPage.CREATE_BUYER_BUTTON),
                Click.on(AllBuyerPage.CREATE_BUYER_BUTTON),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    @And("Admin go to create buyer")
    public void admin_go_to_create_buyer() {
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.goToCreateBuyer()
        );
    }

    @And("Admin verify default form create buyer")
    public void admin_verify_default_form_create_buyer() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllBuyerPage.CREATE_NEW_BUYER_POPUP),
                Ensure.that(AllBuyerPage.CREATE_BUYER_FIRST_NAME_TEXTBOX).attribute("placeholder").contains("First name"),
                Ensure.that(AllBuyerPage.CREATE_BUYER_LAST_NAME_TEXTBOX).attribute("placeholder").contains("Last name"),
                Ensure.that(AllBuyerPage.CREATE_BUYER_EMAIL_TEXTBOX).attribute("placeholder").contains(""),
                Ensure.that(AllBuyerPage.CREATE_BUYER_STORE_TEXTBOX).attribute("placeholder").contains("Select"),
                Ensure.that(AllBuyerPage.CREATE_BUYER_PASSWORD_TEXTBOX).attribute("placeholder").contains("New password")
        );
    }

    @And("Admin verify email field in create buyer")
    public void admin_verify_email_field_in_create_buyer() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllBuyerPage.CREATE_NEW_BUYER_POPUP),
                Enter.theValue("123").into(AllBuyerPage.CREATE_BUYER_EMAIL_TEXTBOX),
                CommonWaitUntil.isVisible(AllBuyerPage.CREATE_BUYER_EMAIL_ERROR),
                Ensure.that(AllBuyerPage.CREATE_BUYER_EMAIL_ERROR).text().contains("Please input a valid email address")
        );
    }

    @And("Admin verify store field in create buyer")
    public void admin_verify_store_field_in_create_buyer() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllBuyerPage.CREATE_NEW_BUYER_POPUP),
                // verify invalid store
                Enter.theValue("123").into(AllBuyerPage.CREATE_BUYER_STORE_TEXTBOX),
                CommonWaitUntil.isVisible(CommonAdminForm.NO_DATA1),
                // verrify inactive store
                Enter.theValue("at createstorechi01").into(AllBuyerPage.CREATE_BUYER_STORE_TEXTBOX),
                CommonWaitUntil.isVisible(CommonAdminForm.NO_DATA1)
        );
    }

    @And("Admin verify manager field in create buyer")
    public void admin_verify_manager_field_in_create_buyer() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllBuyerPage.CREATE_NEW_BUYER_POPUP),
                CommonTask.chooseItemInDropdown1(AllBuyerPage.CREATE_BUYER_ROLE_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3("Store sub-buyer")),
                // verify invalid store
                Enter.theValue("ngoc123").into(AllBuyerPage.CREATE_BUYER_MANAGER_TEXTBOX),
                CommonWaitUntil.isVisible(CommonAdminForm.NO_DATA1)
        );
    }

    @And("Admin remove region {string} in create head buyer")
    public void admin_remove_region_in_create_head_buyer(String region) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.removeRegion(region)
        );
    }

    @And("Admin verify manager contact in create head buyer")
    public void admin_verify_manager_contact_in_create_head_buyer() {
        theActorInTheSpotlight().attemptsTo(
                Enter.theValue("123").into(AllBuyerPage.CREATE_BUYER_CONTACT_NUMBER_TEXTBOX),
                CommonWaitUntil.isVisible(AllBuyerPage.CREATE_BUYER_CONTACT_NUMBER_ERROR),
                Ensure.that(AllBuyerPage.CREATE_BUYER_CONTACT_NUMBER_ERROR).text().contains("Please enter a valid 10-digits phone number")
        );
    }

    @And("Admin verify password field in create buyer")
    public void admin_verify_password_in_create_buyer() {
        theActorInTheSpotlight().attemptsTo(
                // password too long
                Enter.theValue("1111111111111111123123124121111111111111111112312311111111111111111111111111111133333333333333333333333333312312341234444444444444a44444444433333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333a")
                        .into(AllBuyerPage.CREATE_BUYER_PASSWORD_TEXTBOX),
                CommonWaitUntil.isVisible(AllBuyerPage.CREATE_BUYER_PASSWORD_ERROR),
                Ensure.that(AllBuyerPage.CREATE_BUYER_PASSWORD_ERROR).text().contains("Password is too long (maximum is 256 characters)"),
                // password invalid
                Enter.theValue("123").into(AllBuyerPage.CREATE_BUYER_PASSWORD_TEXTBOX),
                CommonWaitUntil.isVisible(AllBuyerPage.CREATE_BUYER_PASSWORD_ERROR),
                Ensure.that(AllBuyerPage.CREATE_BUYER_PASSWORD_ERROR).text().contains("At least 1 letter, a number, at least 8 characters")
        );
    }

    @And("Admin add tags in create buyer")
    public void admin_add_tags_in_create_buyer(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.addTagInCreate(infos)
        );
    }

    @And("Admin verify tag in buyer detail")
    public void admin_verify_tag_in_detail(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : expected) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AllBuyerPage.BUYER_DETAIL_TAGS(item.get("tag"))),
                    Ensure.that(AllBuyerPage.BUYER_DETAIL_TAGS(item.get("tag"))).isDisplayed(),
                    Ensure.that(AllBuyerPage.BUYER_DETAIL_TAGS_EXPIRY(item.get("tag"))).text().contains(CommonHandle.setDate2(item.get("expiry"), "MM/dd/yy"))
            );
        }
    }

    @And("Admin edit general information of {word} buyer")
    public void admin_edit_general_information_of_buyer(String typeStore, DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.editGeneralInfo(typeStore, infos.get(0))
        );
    }

    @And("Admin delete tags in buyer detail")
    public void admin_delete_tags_in_buyer_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.deleteTagsInDetail(infos)
        );
    }

    @And("Admin add tag field in buyer detail")
    public void admin_add_popup_tag_field_in_buyer_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.addTagsInDetail(infos)

        );
    }

    @And("Admin verify email setting of buyer detail")
    public void admin_verify_email_setting_of_buyer_detail() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllBuyerPage.EMAIL_SETTING_ADMIN_CHECKED).isDisplayed(),
                Ensure.that(AllBuyerPage.EMAIL_SETTING_ORDER_CHECKED).isDisplayed()
        );
    }

    @And("Admin navigate relate buyer order in buyer detail {string}")
    public void admin_navigate_relate_buyer_order_in_buyer_detail(String buyer) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.navigateFooterLink("Find all buyer's orders"),
                WindowTask.threadSleep(2000),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id")).attribute("value").contains(buyer)
        );
    }

    @And("Admin navigate relate sample request in buyer detail {string}")
    public void admin_navigate_relate_sample_request_in_buyer_detail(String buyer) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.navigateFooterLink("Find all buyer's sample requests"),
                WindowTask.threadSleep(2000),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id")).attribute("value").contains(buyer)
        );
    }

    @And("Admin navigate relate credit memo in buyer detail {string}")
    public void admin_navigate_relate_credit_memo_in_buyer_detail(String buyer) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.navigateFooterLink("Find all buyer's credit memos"),
                HandleVendorStatements.authenPermission(),
                WindowTask.threadSleep(2000),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id")).attribute("value").contains(buyer)

        );
    }

    @And("Admin navigate store {string} in buyer detail")
    public void admin_navigate_store_in_buyer_detail(String store) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllBuyerPage.STORE_REDIRECT_LINK),
                Click.on(AllBuyerPage.STORE_REDIRECT_LINK),
                WindowTask.threadSleep(2000),
                Ensure.that(AllStoresPage.DYNAMIC_DETAIL("name")).text().contains(store)
        );
    }

    @And("Admin navigate store {string} in buyer list")
    public void admin_navigate_store_in_buyer_list(String store) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllBuyerPage.STORE_LINK),
                Click.on(AllBuyerPage.STORE_LINK),
                WindowTask.threadSleep(2000),
                Ensure.that(AllStoresPage.DYNAMIC_DETAIL("name")).text().contains(store)
        );
    }

    @And("Admin delete buyer {string} in result")
    public void admin_delete_buyer_in_result(String buyer) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.deleteBuyer(buyer)
        );
    }

    @And("Admin delete buyer {string} in result and verify message {string}")
    public void admin_delete_buyer_in_result(String buyer, String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.deleteBuyer(buyer),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message)),
                Ensure.that(CommonAdminForm.ALERT_MESSAGE(message)).isDisplayed()
        );
    }

    @And("Admin go to buyer {string} by url")
    public void buyer_go_to_buyer_page_by_url(String id) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.goToPageByUrl(id)
        );
    }

    @And("Admin remove sku whitelist")
    public void admin_remove_sku_whitelist(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllBuyer.removeWhitelist(infos.get(0))
        );
    }

    @And("Admin verify search field after choose filter in buyer")
    public void admin_verify_search_field_after_choose_filter_in_buyer(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(2000),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("name")).attribute("value").contains(infos.get(0).get("anyText")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("full_name")).attribute("value").contains(infos.get(0).get("fullName")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("email")).attribute("value").contains(infos.get(0).get("email")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("role")).attribute("value").contains(infos.get(0).get("role")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id")).attribute("value").contains(infos.get(0).get("store")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_manager_id")).attribute("value").contains(infos.get(0).get("managedBy")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("tag_ids")).attribute("value").contains(infos.get(0).get("tag")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("active_state")).attribute("value").contains(infos.get(0).get("status"))
        );
    }

    @And("Admin {string} this buyer")
    public void admin_activate_buyer(String action) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(action.equals("activate"))
                        .andIfSo(HandleAllBuyer.activeThisBuyer())
                        .otherwise(HandleAllBuyer.deactivateThisBuyer())
        );
    }

    /**
     * Verify field in general
     */
    @And("Admin verify email field in buyer detail")
    public void admin_verify_email_field_in_buyer_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(AllStoresPage.DYNAMIC_DETAIL("email"), info.get("value"), info.get("message"))
                );
            } else if (info.get("message").equals("success")) {
                //verify valid
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextbox(AllStoresPage.DYNAMIC_DETAIL("email"), info.get("value")),
                        WindowTask.threadSleep(2000),
                        Ensure.that(AllStoresPage.DYNAMIC_DETAIL("email")).text().contains(info.get("value"))
                );
            }
        }
    }

    @And("Admin verify first name in buyer detail")
    public void admin_verify_first_name_field_in_buyer_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(AllStoresPage.DYNAMIC_DETAIL("first-name"), info.get("value"), info.get("message"))
                );
            } else if (info.get("message").equals("success")) {
                //verify valid
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextbox(AllStoresPage.DYNAMIC_DETAIL("first-name"), info.get("value")),
                        WindowTask.threadSleep(2000),
                        Ensure.that(AllStoresPage.DYNAMIC_DETAIL("email")).text().contains(info.get("value"))
                );
            }
        }
    }

    @And("Admin verify last name in buyer detail")
    public void admin_verify_last_name_field_in_buyer_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(AllStoresPage.DYNAMIC_DETAIL("last-name"), info.get("value"), info.get("message"))
                );
            } else if (info.get("message").equals("success")) {
                //verify valid
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextbox(AllStoresPage.DYNAMIC_DETAIL("last-name"), info.get("value")),
                        WindowTask.threadSleep(2000),
                        Ensure.that(AllStoresPage.DYNAMIC_DETAIL("email")).text().contains(info.get("value"))
                );
            }
        }
    }

    @And("Admin verify contact number field in buyer detail")
    public void admin_verify_phone_field_in_buyer_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(AllStoresPage.DYNAMIC_DETAIL("last-name"), info.get("value"), info.get("message"))
                );
            } else if (info.get("message").equals("success")) {
                //verify valid
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextbox(AllStoresPage.DYNAMIC_DETAIL("last-name"), info.get("value")),
                        WindowTask.threadSleep(2000),
                        Ensure.that(AllStoresPage.DYNAMIC_DETAIL("email")).text().contains(info.get("value"))
                );
            }
        }
    }
}

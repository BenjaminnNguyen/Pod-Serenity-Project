package steps.admin.store;

import cucumber.actions.GoBack;
import cucumber.tasks.admin.buyers.HandleAllBuyer;
import cucumber.tasks.admin.financial.HandleVendorStatements;
import cucumber.user_interface.admin.buyer.AllBuyerPage;
import cucumber.user_interface.admin.buyer.BuyerCompaniesPage;
import cucumber.user_interface.admin.vendors.VendorCompaniesPage;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.store.HandleAllStore;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.IncomingInventoryDetailPage;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import cucumber.user_interface.admin.store.AllStoresPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.abilities.BrowseTheWeb;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.CoreMatchers.containsString;

public class AllStoreStepDefinitions {

    @And("Admin search all store")
    public void admin_search_all_store(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(infos.get(0), "name", Serenity.sessionVariableCalled("Onboard Name Company"));

        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleAllStore.search(info)
        );
    }

    @And("Admin verify result all store")
    public void admin_verify_result_all_store(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllStoresPage.STORE_NAME).text().contains(expected.get(0).get("store")),
                Ensure.that(AllStoresPage.REGION_RESULT).text().contains(expected.get(0).get("region")),
                Ensure.that(AllStoresPage.SOS_RESULT).text().contains(expected.get(0).get("sos")),
                Ensure.that(AllStoresPage.SIZE_RESULT).text().contains(expected.get(0).get("size")),
                Ensure.that(AllStoresPage.TYPE_RESULT).text().contains(expected.get(0).get("type")),
                Ensure.that(AllStoresPage.CONTACT_RESULT).attribute("data-original-text").contains(expected.get(0).get("contact"))
        );
        if (expected.get(0).containsKey("managedBy")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AllStoresPage.MANAGED_BY_RESULT), containsString(expected.get(0).get("managedBy")))
            );
        }
        if (expected.get(0).containsKey("launchedBy")) {
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.targetText(AllStoresPage.LAUNCH_BY_RESULT), containsString(expected.get(0).get("launchedBy")))
            );
        }

        if (expected.get(0).containsKey("delivery")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllStoresPage.DELIVERY_RESULT).text().contains(expected.get(0).get("delivery"))
            );
        }
        // get ID store
        String storeID = Text.of(AllStoresPage.STORE_ID(expected.get(0).get("store"))).answeredBy(theActorInTheSpotlight());
        Serenity.setSessionVariable("Store ID").to(storeID);
        Serenity.setSessionVariable("ID Store API").to(storeID);
    }

    @And("Admin go to detail of store {string}")
    public void admin_search_buyer_company(String name) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(AllStoresPage.STORE_NAME),
                CommonWaitUntil.isVisible(AllStoresPage.GENERAL_INFO)
        );
    }

    @And("Admin verify general information of all store")
    public void checkGeneralInformation(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(expected.get(0), "name", Serenity.sessionVariableCalled("Onboard Name Company"));
        info = CommonTask.setValueRandom(info, "nameCompany", Serenity.sessionVariableCalled("Onboard Name Company"));

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllStoresPage.DYNAMIC_DETAIL("name")).text().contains(info.get("name")),
                Ensure.that(AllStoresPage.DYNAMIC_DETAIL("buyer-company-name")).text().contains(info.get("nameCompany")),
                Ensure.that(AllStoresPage.STATE_DETAIL).text().contains(expected.get(0).get("stateStore")),
                Ensure.that(AllStoresPage.DYNAMIC_DETAIL("store-size")).text().contains(expected.get(0).get("storeSize")),
                Ensure.that(AllStoresPage.DYNAMIC_DETAIL("store-type")).text().contains(expected.get(0).get("storeType")),
                Ensure.that(AllStoresPage.INVOICE_OPTION_DETAIL).text().contains(expected.get(0).get("invoiceOption")),
                Ensure.that(AllStoresPage.DYNAMIC_DETAIL("payment-due-date-threshold")).text().contains(expected.get(0).get("threshold")),
                Ensure.that(AllStoresPage.DYNAMIC_DETAIL("region")).text().contains(expected.get(0).get("region")),
                Ensure.that(AllStoresPage.ADDRESS_DETAIL).text().contains(expected.get(0).get("street")),
                Ensure.that(AllStoresPage.ADDRESS_DETAIL).text().contains(expected.get(0).get("city")),
                Ensure.that(AllStoresPage.ADDRESS_DETAIL).text().contains(expected.get(0).get("state")),
                Ensure.that(AllStoresPage.ADDRESS_DETAIL).text().contains(expected.get(0).get("zip")),
                Ensure.that(AllStoresPage.DYNAMIC_DETAIL("email")).text().contains(expected.get(0).get("email")),
                Check.whether(expected.get(0).get("apEmail").isEmpty())
                        .otherwise(Ensure.that(AllStoresPage.DYNAMIC_DETAIL("ap-email")).text().contains(expected.get(0).get("apEmail"))),
                Ensure.that(AllStoresPage.DYNAMIC_DETAIL("phone-number")).text().contains(expected.get(0).get("phone")),
                Ensure.that(AllStoresPage.DYNAMIC_DETAIL("timezone")).text().contains(expected.get(0).get("timezone")),
                Check.whether(expected.get(0).get("day").isEmpty())
                        .otherwise(Ensure.that(AllStoresPage.DYNAMIC_DETAIL("day")).text().contains(expected.get(0).get("day"))),
                Ensure.that(AllStoresPage.DIRECT_RECEIVING_NOTE(expected.get(0).get("day"))).isDisplayed(),
                Check.whether(expected.get(0).get("start").isEmpty())
                        .otherwise(Ensure.that(AllStoresPage.DYNAMIC_DETAIL("start")).text().contains(expected.get(0).get("start"))),
                Check.whether(expected.get(0).get("end").isEmpty())
                        .otherwise(Ensure.that(AllStoresPage.DYNAMIC_DETAIL("end")).text().contains(expected.get(0).get("end"))),
                Check.whether(expected.get(0).get("route").isEmpty())
                        .otherwise(Ensure.that(AllStoresPage.DYNAMIC_DETAIL("router")).text().contains(expected.get(0).get("route"))),
                Check.whether(expected.get(0).get("referredBy").isEmpty())
                        .otherwise(Ensure.that(AllStoresPage.DYNAMIC_DETAIL("referred")).text().contains(expected.get(0).get("referredBy")))
        );

        if (expected.get(0).containsKey("mile")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllStoresPage.DYNAMIC_DETAIL("mileage")).text().contains(info.get("mile"))
            );
        }

        if (expected.get(0).containsKey("sendInvoice")) {
            if (expected.get(0).get("sendInvoice").equals("No")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(AllStoresPage.SEND_INVOICE_DETAIL_NO).text().contains(expected.get(0).get("sendInvoice"))
                );
            }
        }
        if (expected.get(0).containsKey("expressReceivingNote")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllStoresPage.DYNAMIC_DETAIL("receiving_note")).text().contains(info.get("expressReceivingNote"))
            );
        }

        if (expected.get(0).containsKey("directReceivingNote")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllStoresPage.DYNAMIC_DETAIL("direct_receiving_note")).text().contains(info.get("directReceivingNote"))
            );
        }

        if (expected.get(0).containsKey("liftgateRequired")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllStoresPage.LIFTGATE_REQUIRE).text().contains(info.get("liftgateRequired"))
            );
        }

        if (expected.get(0).containsKey("street2")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllStoresPage.ADDRESS_DETAIL).text().contains(info.get("street2"))
            );
        }

        if (expected.get(0).containsKey("attn")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllStoresPage.ADDRESS_DETAIL).text().contains(info.get("attn"))
            );
        }

        if (expected.get(0).containsKey("retailerStore")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllStoresPage.RETAILER_STORE).text().contains(info.get("retailerStore"))
            );
        }
    }

    @And("Admin verify ap email of store detail")
    public void admin_verify_ap_email_of_store_detail(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        int size = expected.size();
        for (int i = 0; i < size; i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllStoresPage.D_AP_EMAIL_DETAIL(i + 1)).text().contains(expected.get(i).get("apEmail"))
            );
        }
    }

    @And("Admin verify small order surcharge of store detail")
    public void admin_verify_sos_of_store_detail(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllStoresPage.APPLY_SOS).text().contains(expected.get(0).get("applySOS")),
                Ensure.that(AllStoresPage.SOS_THRESHOLD).text().contains(expected.get(0).get("sosThreshold")),
                Ensure.that(AllStoresPage.SOS_AMOUNT).text().contains(expected.get(0).get("sosAmount"))
        );
    }

    @And("Admin fill info to create store")
    public void admin_create_store(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.fillInfoRequireToCreate(infos.get(0))
        );
    }

    @And("Admin fill info receiving section to create store")
    public void admin_fill_info_receiving_section_to_create_store(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.fillInfReceivingToCreate(infos)
        );
    }

    @And("Admin fill info shipping address section to create store")
    public void admin_fill_info_shipping_address_section_to_create_store(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.fillInfShippingAddressToCreate(infos.get(0))
        );
    }

    @And("Admin create store success")
    public void admin_create_store_success() {
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.createStoreSuccess()
        );
    }

    @And("Admin go to detail store first item")
    public void admin_go_to_detail_store() {
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.goToDetailStoreFirstItem()
        );
    }

    @And("Admin {string} in store detail")
    public void admin_deactivate_store(String status) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.deactivateStore(status)
        );
    }

    @And("Admin delete store {string} and verify message {string}")
    public void admin_delete_store(String store, String message) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.deleteStore(store),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ALERT(message)),
                Ensure.that(CommonAdminForm.DYNAMIC_ALERT(message)).isDisplayed()
        );
    }

    @And("Admin delete store {string}")
    public void admin_delete_store(String store) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.deleteStore(store)
        );
    }

    @And("Admin edit general information of store")
    public void admin_edit_general_information_of_store(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.editGeneralInformation(infos.get(0))
        );
    }

    @And("Admin change possible delivery day")
    public void admin_change_possible_delivery_day(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.editPossibleDeliveryDay(infos.get(0))
        );
    }

    @And("Admin edit address in store detail")
    public void admin_edit_address_in_store_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.editAddress(infos.get(0))
        );
    }

    @And("Admin change set receiving day in store detail")
    public void admin_change_set_receiving_day(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.editSetReceivingWeekday(infos.get(0))
        );
    }

    @And("Admin change set receiving day is current day in store detail")
    public void admin_change_set_current_date_in_receiving_day() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllStoresPage.SET_RECEIVING_WEEKDAYS_LABEL),
                Click.on(AllStoresPage.SET_RECEIVING_WEEKDAYS_LABEL),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX),
                WindowTask.threadSleep(1000),
                Clear.field(AllStoresPage.TOOLTIP_TEXTBOX));
        List<WebElementFacade> elements = AllStoresPage.ICON_CHECKED_SET_RECEIVING_WEEKDAY.resolveAllFor(theActorInTheSpotlight());
        for (WebElementFacade element : elements) {
            theActorInTheSpotlight().attemptsTo(
                    Click.on(element),
                    WindowTask.threadSleep(1000)
            );
        }
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(1000),
                Click.on(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN1(CommonHandle.convertDateToWeekdays())),
                Click.on(AllStoresPage.GENERAL_INFO_HEADER),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );

    }

    @And("Admin change receiving time in store detail")
    public void admin_change_receiving_time(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.editReceivingTime(infos.get(0))
        );
    }

    @And("Admin verify error field when create store")
    public void verify_error_field_when_create_store() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                WindowTask.threadSleep(1000),

                Ensure.that(AllStoresPage.D_CREATE_TEXTBOX_ERROR("Name")).text().contains("Please enter a store name."),
                Ensure.that(AllStoresPage.D_CREATE_TEXTBOX_ERROR("Email")).text().contains("Please enter a valid email address for this store."),
                Ensure.that(AllStoresPage.D_CREATE_TEXTBOX_ERROR("Region")).text().contains("Please select a specific region for this store."),
                Ensure.that(AllStoresPage.D_CREATE_TEXTBOX_ERROR("Timezone")).text().contains("Please select a specific timezone for this store."),
                Ensure.that(AllStoresPage.D_CREATE_TEXTBOX_ERROR("Store size")).text().contains("Please select a specific size for this store."),
                Ensure.that(AllStoresPage.D_CREATE_TEXTBOX_ERROR("Buyer company")).text().contains("Please select a specific buyer company for this store."),
                Ensure.that(AllStoresPage.D_CREATE_TEXTBOX_ERROR("Phone number")).text().contains("Please enter a valid phone number for this store. (10 digits length)."),
                Ensure.that(AllStoresPage.D_CREATE_TEXTBOX_ERROR("Street")).text().contains("Please select a specific street address for this store."),
                Ensure.that(AllStoresPage.D_CREATE_TEXTBOX_ERROR("City")).text().contains("Please select a specific city for this store."),
                Ensure.that(AllStoresPage.D_CREATE_TEXTBOX_ERROR("State (Province/Territory)")).text().contains("Please select a specific state for this store."),
                Ensure.that(AllStoresPage.D_CREATE_TEXTBOX_ERROR("Zip")).text().contains("Please enter a valid 5-digits zip code")
        );
    }

    @And("Admin go to create store")
    public void admin_go_to_create_store() {
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.goToCreateStore()
        );
    }

    @And("Admin add tags in create store")
    public void admin_add_tags_in_create_store(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.addTagInCreate(infos)
        );
    }

    @And("Admin delete tags in create store")
    public void admin_delete_tags_in_create_store(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.deleteTagsInCreate(infos)
        );
    }

    @And("Admin verify navigate footer link")
    public void admin_verify_navigate_footer_link(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    HandleAllStore.navigateLink(info.get("link")),
                    // author permission when click link credit memos
                    Check.whether(info.get("title").equals("Credit memos"))
                            .andIfSo(
                                    HandleVendorStatements.authenPermission()
                            ),
                    CommonWaitUntil.isVisible(CommonAdminForm.TITLE_PAGE),
                    Ensure.that(CommonAdminForm.TITLE_PAGE).text().contains(info.get("title")),
                    // go back
                    GoBack.theBrowser()
            );
        }
    }

    @And("Admin verify name field in store detail")
    public void admin_verify_name_field_in_store_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(AllStoresPage.DYNAMIC_DETAIL("name"), info.get("value"), info.get("message"))
                );
            } else if (info.get("message").equals("success")) {
                //verify valid
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextbox(AllStoresPage.DYNAMIC_DETAIL("name"), info.get("value")),
                        WindowTask.threadSleep(2000),
                        Ensure.that(AllStoresPage.DYNAMIC_DETAIL("name")).text().contains(info.get("value"))
                );
            }
        }
    }

    @And("Admin verify email field in store detail")
    public void admin_verify_email_field_in_store_detail(DataTable dt) {
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
                        WindowTask.threadSleep(1000),
                        Ensure.that(AllStoresPage.DYNAMIC_DETAIL("email")).text().contains(info.get("value"))
                );
            }
        }
    }

    @And("Admin verify phone field in store detail")
    public void admin_verify_phone_field_in_store_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);

        for (Map<String, String> info : infos) {
            if (!info.get("message").equals("success")) {
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextboxError1(AllStoresPage.DYNAMIC_DETAIL("phone-number"), info.get("value"), info.get("message"))
                );
            } else if (info.get("message").equals("success")) {
                //verify valid
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipTextbox(AllStoresPage.DYNAMIC_DETAIL("phone-number"), info.get("value")),
                        WindowTask.threadSleep(1000),
                        Ensure.that(AllStoresPage.DYNAMIC_DETAIL("phone-number")).text().contains(info.get("value"))
                );
            }
        }
    }

    @And("Admin verify All possible delivery days field in store detail error {string}")
    public void admin_verify_possible_delivery_field_in_store_detail(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllStoresPage.POSSIBLE_RECEIVING_WEEKDAYS_LABEL),
                Click.on(AllStoresPage.POSSIBLE_RECEIVING_WEEKDAYS_LABEL),
                CommonWaitUntil.isVisible(AllStoresPage.POPUP_CHOOSE_DAY_DELIVERY),
                Click.on(AllStoresPage.WITHIN_7_BUSINESS_CHECKBOX),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message)),
                Click.on(IncomingInventoryDetailPage.TOOLTIP_MESSAGE_CLOSE),
                Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP_CANCEL)
        );

    }

    @And("Admin edit small order surcharge of store detail")
    public void admin_edit_sos_of_store_detail(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonTaskAdmin.changeValueTooltipTextboxError1(AllStoresPage.SOS_THRESHOLD, info.get("value"), info.get("message"))
            );
        }
    }

    @And("Admin turn {word} small order surcharge of store detail")
    public void admin_turn_sos_of_store_detail(String type) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllStore.turnSOS(type)
        );
    }

    @And("Admin verify small order surcharge of store detail has been turn off")
    public void admin_verify_turn_off_of_store_detail() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllStoresPage.APPLY_SOS),
                Ensure.that(AllStoresPage.APPLY_SOS).text().contains("No")
        );
    }

    @And("Admin verify credit memos of store detail")
    public void admin_verify_credit_memos_of_store_detail(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            String credit = null;
            if (info.get("creditMemo").contains("create")) {
                credit = Serenity.sessionVariableCalled("ID Credit Memo");
            }
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AllStoresPage.CREDIT_MEMOS),
                    Scroll.to(AllStoresPage.CREDIT_MEMOS),
                    Ensure.that(AllStoresPage.CREDIT_MEMOS(credit)).isDisplayed(),
                    // Verify state
                    MoveMouse.to(AllStoresPage.CREDIT_MEMOS(credit)),
                    CommonWaitUntil.isVisible(AllStoresPage.CREDIT_MEMOS_STATE),
                    Ensure.that(AllStoresPage.CREDIT_MEMOS_STATE).text().contains(info.get("state"))
            );
        }
    }

    @And("Admin verify preferred warehouses in store detail")
    public void verify_preferred_warehouse_in_store_detail(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllStoresPage.WAREHOUSE(infos.get(0).get("warehouse"))).isDisplayed(),
                Ensure.that(AllStoresPage.WAREHOUSE_ADDRESS(infos.get(0).get("warehouse"))).text().contains(infos.get(0).get("address")),
                Ensure.that(AllStoresPage.WAREHOUSE_DISTANCE(infos.get(0).get("warehouse"))).text().contains(infos.get(0).get("distance"))
        );
    }

    @And("Admin verify history of mileage in store")
    public void admin_verify_history_of_mileage_in_store(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllStoresPage.HISTORY_MILEAGE),
                MoveMouse.to(AllStoresPage.HISTORY_MILEAGE),
                CommonWaitUntil.isVisible(AllStoresPage.MILEAGE_HISTORY_STATE),
                //Verify
                Ensure.that(AllStoresPage.MILEAGE_HISTORY_STATE).text().contains(infos.get(0).get("state")),
                Ensure.that(AllStoresPage.MILEAGE_HISTORY_UPDATE_BY).text().contains(infos.get(0).get("updateBy")),
                Ensure.that(AllStoresPage.MILEAGE_HISTORY_UPDATE_ON).text().contains(CommonHandle.setDate2(infos.get(0).get("updateOn"), "MM/dd/yy"))
        );
    }

    @And("Admin verify search field after choose filter in store")
    public void admin_verify_search_field_after_choose_filter_in_store(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(2000),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("name")).attribute("value").contains(infos.get(0).get("name")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("has_surcharge")).attribute("value").contains(infos.get(0).get("sos")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_size")).attribute("value").contains(infos.get(0).get("size")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_type_id")).attribute("value").contains(infos.get(0).get("type")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("city")).attribute("value").contains(infos.get(0).get("city")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("state")).attribute("value").contains(infos.get(0).get("state")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("receiving_week_day")).attribute("value").contains(infos.get(0).get("receive")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_ids")).attribute("value").contains(infos.get(0).get("region")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("route_id")).attribute("value").contains(infos.get(0).get("route")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("manager_id")).attribute("value").contains(infos.get(0).get("managedBy")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("tag_ids")).attribute("value").contains(infos.get(0).get("tag")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id")).attribute("value").contains(infos.get(0).get("buyerCompany")),
                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_state")).attribute("value").contains(infos.get(0).get("status"))
        );
    }
}

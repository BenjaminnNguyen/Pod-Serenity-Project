package cucumber.tasks.admin.store;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.buyer.AllBuyerPage;
import cucumber.user_interface.admin.inventory.IncomingInventoryDetailPage;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import cucumber.user_interface.admin.store.AllStoresPage;
import cucumber.user_interface.admin.vendors.AllVendorsForm;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.abilities.BrowseTheWeb;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.Keys;

import java.awt.*;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleAllStore {

    public static Task search(Map<String, String> info) {
        return Task.where("Search all buyer",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Enter.theValue(info.get("name")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("name")),
                Check.whether(!Objects.equals(info.get("sos"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("has_surcharge"), info.get("sos"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("sos")))
                        ),
                Check.whether(!Objects.equals(info.get("size"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_size"), info.get("size"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("size")))
                        ),
                Check.whether(!Objects.equals(info.get("type"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_type_id"), info.get("type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("type")))
                        ),
                Enter.theValue(info.get("city")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("city")),
                Check.whether(!Objects.equals(info.get("state"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("state"), info.get("state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("state")))
                        ),
                Check.whether(!Objects.equals(info.get("receive"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("receiving_week_day"), info.get("receive"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("receive")))
                        ),
                Check.whether(!Objects.equals(info.get("region"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_ids"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("region")))
                        ),
                Check.whether(!Objects.equals(info.get("route"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("route_id"), info.get("route"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("route")))
                        ),
                Check.whether(!Objects.equals(info.get("managedBy"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("manager_id"), info.get("managedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("managedBy")))
                        ),
                Check.whether(!Objects.equals(info.get("tag"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("tag_ids"), info.get("tag"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("tag")))
                        ),
                Check.whether(!Objects.equals(info.get("buyerCompany"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_company_id"), info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("buyerCompany")))
                        ),
                Check.whether(!Objects.equals(info.get("status"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_state"), info.get("status"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("status")))
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToCreateStore() {
        return Task.where("Go to create store",
                CommonWaitUntil.isVisible(AllStoresPage.CREATE_STORE_BUTTON),
                Click.on(AllStoresPage.CREATE_STORE_BUTTON),
                CommonWaitUntil.isVisible(AllStoresPage.D_CREATE_TEXTBOX("Name"))
        );
    }

    public static Performable fillInfoRequireToCreate(Map<String, String> info) {
        return Task.where("Fill info require to create store",
                actor -> {
                    actor.attemptsTo(
                            Enter.theValue(info.get("name")).into(AllStoresPage.D_CREATE_TEXTBOX("Name")),
                            Enter.theValue(info.get("email")).into(AllStoresPage.D_CREATE_TEXTBOX("Email")),
                            CommonTask.chooseItemInDropdown1(
                                    AllStoresPage.D_CREATE_TEXTBOX("Region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region"))),
                            CommonTask.chooseItemInDropdown1(
                                    AllStoresPage.D_CREATE_TEXTBOX("Timezone"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("timeZone"))),
                            CommonTask.chooseItemInDropdown1(
                                    AllStoresPage.D_CREATE_TEXTBOX("Store size"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("storeSize"))),
                            CommonTask.chooseItemInDropdownWithValueInput(
                                    AllStoresPage.D_CREATE_TEXTBOX("Buyer company"), info.get("buyerCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("buyerCompany"))),
                            Enter.theValue(info.get("phone")).into(AllStoresPage.D_CREATE_TEXTBOX("Phone number")),
                            Enter.theValue(info.get("street")).into(AllStoresPage.D_CREATE_TEXTBOX("Street")).thenHit(Keys.ENTER),
                            Enter.theValue(info.get("city")).into(AllStoresPage.D_CREATE_TEXTBOX("City")),
                            CommonTask.chooseItemInDropdown3(
                                    AllStoresPage.D_CREATE_TEXTBOX("State (Province/Territory)"), AllStoresPage.D_CREATE_ITEM_DROP(info.get("state"))),
                            Enter.theValue(info.get("zip")).into(AllStoresPage.D_CREATE_TEXTBOX("Zip"))
                    );
                    if (info.containsKey("apEmail")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add email")),
                                CommonWaitUntil.isVisible(AllStoresPage.D_CREATE_TEXTBOX("AP emails")),
                                Enter.theValue(info.get("apEmail")).into(AllStoresPage.D_CREATE_TEXTBOX("AP emails"))
                        );
                    }
                }

        );
    }

    public static Performable fillInfReceivingToCreate(List<Map<String, String>> infos) {
        return Task.where("Fill info receiving section to create store",
                actor -> {
                    actor.attemptsTo(
                            Check.whether(infos.get(0).get("expressReceivingNote").isEmpty())
                                    .otherwise(
                                            Enter.theValue(infos.get(0).get("expressReceivingNote")).into(AllStoresPage.D_CREATE_TEXTAREA("Express receiving note"))),
                            Check.whether(infos.get(0).get("directReceivingNote").isEmpty())
                                    .otherwise(
                                            Enter.theValue(infos.get(0).get("directReceivingNote")).into(AllStoresPage.D_CREATE_TEXTAREA("Direct receiving note")))
                    );
                    // handle all possible delivery days
                    if (!infos.get(0).get("possibleDeliveryDay").isEmpty()) {
                        if (infos.get(0).get("possibleDeliveryDay").equals("Within 7 business days")) {
                            actor.attemptsTo(
                                    Click.on(AllStoresPage.CREATE_STORE_ALL_POSSIBLE_DELIVERY_CHECKBOX)
                            );
                        } else {
                            actor.attemptsTo(
                                    Click.on(AllStoresPage.CREATE_STORE_ALL_POSSIBLE_DELIVERY_TEXTBOX)
                            );
                            for (Map<String, String> info : infos) {
                                actor.attemptsTo(
                                        CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("possibleDeliveryDay"))),
                                        Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("possibleDeliveryDay")))
                                );
                            }
                            actor.attemptsTo(
                                    Hit.the(Keys.ESCAPE).into(AllStoresPage.CREATE_STORE_ALL_POSSIBLE_DELIVERY_TEXTBOX)
                            );
                        }
                    }
                    // handle set receiving weekdays
                    if (!infos.get(0).get("setReceivingDay").isEmpty()) {
                        actor.attemptsTo(
                                WindowTask.threadSleep(1000),
                                Click.on(AllStoresPage.CREATE_STORE_SET_RECEIVING_WEEKDAY_TEXTBOX)
                        );
                        for (Map<String, String> info : infos) {
                            actor.attemptsTo(
                                    CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("setReceivingDay"))),
                                    Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("setReceivingDay")))
                            );
                        }
                        actor.attemptsTo(
                                Hit.the(Keys.ESCAPE).into(AllStoresPage.CREATE_STORE_SET_RECEIVING_WEEKDAY_TEXTBOX)
                        );
                    }
                    // handle Receiving time
                    actor.attemptsTo(
                            Check.whether(infos.get(0).get("startTime").isEmpty())
                                    .otherwise(CommonTask.chooseItemInDropdown3(AllStoresPage.CREATE_STORE_RECEIVING_TIME_FROM_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(infos.get(0).get("startTime")))),
                            Check.whether(infos.get(0).get("endTime").isEmpty())
                                    .otherwise(CommonTask.chooseItemInDropdown3(AllStoresPage.CREATE_STORE_RECEIVING_TIME_TO_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(infos.get(0).get("endTime"))))
                    );
                }
        );
    }

    public static Performable fillInfShippingAddressToCreate(Map<String, String> info) {
        return Task.where("Fill info shipping address section to create store",
                Check.whether(info.get("sos").equals("No"))
                        .andIfSo(Click.on(AllStoresPage.CREATE_STORE_APPLY_SOS)),
                Check.whether(info.get("defaultSOS").equals("Yes"))
                        .otherwise(Click.on(AllStoresPage.CREATE_STORE_DEFAULT_SOS_CONFIG)),
                Check.whether(info.get("sosThreshold").isEmpty())
                        .otherwise(Enter.theValue(info.get("sosThreshold")).into(AllStoresPage.D_CREATE_TEXTBOX("Small order surcharge threshold"))),
                Check.whether(info.get("sosAmount").isEmpty())
                        .otherwise(Enter.theValue(info.get("sosAmount")).into(AllStoresPage.D_CREATE_TEXTBOX("Small order surcharge amount"))),
                Check.whether(info.get("mileage").isEmpty())
                        .otherwise(Enter.theValue(info.get("mileage")).into(AllStoresPage.D_CREATE_TEXTBOX("Mileage"))),
                Check.whether(info.get("attn").isEmpty())
                        .otherwise(Enter.theValue(info.get("attn")).into(AllStoresPage.D_CREATE_TEXTBOX("ATTN")))

        );
    }

    public static Task createStoreSuccess() {
        return Task.where("Create store success",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToDetailStoreFirstItem() {
        return Task.where("go to detail store of first item",
                CommonWaitUntil.isVisible(AllStoresPage.FIRST_RESULT_STORE),
                Click.on(AllStoresPage.FIRST_RESULT_STORE),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task deactivateStore(String status) {
        return Task.where(status + " store",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON(status)),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON(status)),
                WindowTask.threadSleep(3000),
                Check.whether(valueOf(AllStoresPage.WARNING_POPUP), isCurrentlyVisible())
                        .andIfSo(Click.on(CommonAdminForm.DYNAMIC_BUTTON("OK"))),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("Store has been updated successfully!"))
        );
    }

    public static Task deleteStore(String state) {
        return Task.where("go to detail store of first item",
                CommonWaitUntil.isVisible(AllStoresPage.DELETE_BUTTON_BY_STORE(state)),
                Click.on(AllStoresPage.DELETE_BUTTON_BY_STORE(state)),
                CommonWaitUntil.isVisible(AllStoresPage.WARNING_POPUP),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Performable editGeneralInformation(Map<String, String> info) {
        return Task.where("Edit general information",
                actor -> {
                    actor.attemptsTo(
                            Check.whether(info.get("name").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(AllStoresPage.DYNAMIC_DETAIL("name"), info.get("name"))),
                            Check.whether(info.get("storeSize").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeValueTooltipDropdown(AllStoresPage.DYNAMIC_DETAIL("store-size"), info.get("storeSize"))),
                            Check.whether(info.get("invoiceOption").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeSwitchValueFromTooltip(AllStoresPage.INVOICE_OPTION_DETAIL, info.get("invoiceOption"))),
                            Check.whether(info.get("dateThreshold").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(AllStoresPage.DYNAMIC_DETAIL("payment-due-date-threshold"), info.get("dateThreshold"))),
                            Check.whether(info.get("mile").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(AllStoresPage.DYNAMIC_DETAIL("mileage"), info.get("mile"))),
                            Check.whether(info.get("referredBy").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeValueTooltipDropdownWithInput(AllStoresPage.REFERRED_BY, info.get("referredBy"))),
                            Check.whether(info.get("region").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeValueTooltipDropdownWithInput(AllStoresPage.DYNAMIC_DETAIL("region"), info.get("region"))),
                            Check.whether(info.get("route").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeValueTooltipDropdownWithInput(AllStoresPage.ROUTE, info.get("route"))),
                            Check.whether(info.get("email").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(AllStoresPage.DYNAMIC_DETAIL("email"), info.get("email"))),
                            Check.whether(info.get("phone").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(AllStoresPage.DYNAMIC_DETAIL("phone-number"), info.get("phone"))),
                            Check.whether(info.get("timeZone").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeValueTooltipDropdown(AllStoresPage.DYNAMIC_DETAIL("timezone"), info.get("timeZone"))),
                            Check.whether(info.get("expressNote").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeValueTooltipTextarea(AllStoresPage.EXPRESS_RECEIVING_NOTE, info.get("expressNote")),
                                            CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)),
                            Check.whether(info.get("directNote").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeValueTooltipTextarea(AllStoresPage.DIRECT_RECEIVING_NOTE, info.get("directNote")),
                                            CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)),
                            Check.whether(info.get("liftGate").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeSwitchValueFromTooltip(AllStoresPage.LIFTGATE_REQUIRE, info.get("liftGate"))),
                            Check.whether(info.get("retailerStore").isEmpty())
                                    .otherwise(CommonTaskAdmin.changeValueTooltipTextbox(AllStoresPage.RETAILER_STORE, info.get("retailerStore")))
                    );
                }

        );
    }

    public static Task editAddress(Map<String, String> info) {
        return Task.where("Edit address",
                CommonWaitUntil.isVisible(AllStoresPage.ADDRESS_DETAIL_EDIT),
                Click.on(AllStoresPage.ADDRESS_DETAIL_EDIT),
                CommonWaitUntil.isVisible(AllStoresPage.D_ADDRESS_TEXTBOX("Attn")),
                //Edit
                Enter.theValue(info.get("attn")).into(AllStoresPage.D_ADDRESS_TEXTBOX("Attn")),
                Enter.theValue(info.get("street1")).into(AllStoresPage.ADDRESS_STREET1_TEXTBOX),
                Enter.theValue(info.get("street2")).into(AllStoresPage.ADDRESS_STREET2_TEXTBOX),
                Enter.theValue(info.get("city")).into(AllStoresPage.D_ADDRESS_TEXTBOX("City")),
                CommonTask.chooseItemInDropdownWithValueInput1(AllStoresPage.D_ADDRESS_TEXTBOX("State (Province/Territory)"), info.get("state"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("state"))),
                Enter.theValue(info.get("zip")).into(AllStoresPage.D_ADDRESS_TEXTBOX("Zip")),
                //Update
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isNotVisible(AllStoresPage.D_ADDRESS_TEXTBOX("Attn"))
        );
    }

    public static Task editPossibleDeliveryDay(Map<String, String> info) {
        return Task.where("Edit Possible delivery day",
                // Reset về trạng thái within 7 business day
                CommonWaitUntil.isVisible(AllStoresPage.POSSIBLE_RECEIVING_WEEKDAYS_LABEL),
                Click.on(AllStoresPage.POSSIBLE_RECEIVING_WEEKDAYS_LABEL),
                CommonWaitUntil.isVisible(AllStoresPage.POPUP_CHOOSE_DAY_DELIVERY),

                Check.whether(CommonQuestions.AskForAttributeContainText(AllStoresPage.WITHIN_7_BUSINESS_CHECKBOX, "class", "checked"))
                        .otherwise(
                                Click.on(AllStoresPage.WITHIN_7_BUSINESS_CHECKBOX)),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),

                // Reset về trạng thái within 7 business day
                CommonWaitUntil.isVisible(AllStoresPage.POSSIBLE_RECEIVING_WEEKDAYS_LABEL),
                Click.on(AllStoresPage.POSSIBLE_RECEIVING_WEEKDAYS_LABEL),
                CommonWaitUntil.isVisible(AllStoresPage.POPUP_CHOOSE_DAY_DELIVERY),

                Check.whether(info.get("date").equals("Full day"))
                        .andIfSo(
                                Click.on(AllStoresPage.WITHIN_7_BUSINESS_CHECKBOX),
                                Click.on(AllStoresPage.POSSIBLE_DELIVERY_DAY_TEXTBOX_POPUP),
                                Check.whether(info.get("mon").isEmpty())
                                        .otherwise(Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3("Monday"))),
                                Check.whether(info.get("tue").isEmpty())
                                        .otherwise(Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3("Tuesday"))),
                                Check.whether(info.get("wed").isEmpty())
                                        .otherwise(Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3("Wednesday"))),
                                Check.whether(info.get("thu").isEmpty())
                                        .otherwise(Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3("Thursday"))),
                                Check.whether(info.get("fri").isEmpty())
                                        .otherwise(Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3("Friday"))),
                                Check.whether(info.get("sat").isEmpty())
                                        .otherwise(Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3("Staturday"))),
                                Check.whether(info.get("sun").isEmpty())
                                        .otherwise(Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3("Sunday")))
                        ),
                Click.on(AllStoresPage.GENERAL_INFO_HEADER),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Performable editSetReceivingWeekday(Map<String, String> info) {
        return Task.where("Edit set receiving weekday",
                actor -> {
                    // Open popup
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(AllStoresPage.SET_RECEIVING_WEEKDAYS_LABEL),
                            Click.on(AllStoresPage.SET_RECEIVING_WEEKDAYS_LABEL),
                            CommonWaitUntil.isVisible(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX),
                            WindowTask.threadSleep(1000)

                    );
                    // Reset về trạng thái not set
                    List<WebElementFacade> elements = AllStoresPage.SET_RECEIVING_WEEKDAY_SELECTED.resolveAllFor(actor);
                    for (WebElementFacade element : elements) {
                        actor.attemptsTo(
                                Click.on(element),
                                WindowTask.threadSleep(500)
                        );
                    }
                    actor.attemptsTo(
                            WindowTask.threadSleep(1000),
                            Check.whether(info.get("mon").equals("Yes"))
                                    .andIfSo(Click.on(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN1("Monday"))),
                            Check.whether(info.get("tue").equals("Yes"))
                                    .andIfSo(Click.on(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN1("Tuesday"))),
                            Check.whether(info.get("wed").equals("Yes"))
                                    .andIfSo(Click.on(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN1("Wednesday"))),
                            Check.whether(info.get("thu").equals("Yes"))
                                    .andIfSo(Click.on(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN1("Thursday"))),
                            Check.whether(info.get("fri").equals("Yes"))
                                    .andIfSo(Click.on(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN1("Friday"))),
                            Check.whether(info.get("sat").equals("Yes"))
                                    .andIfSo(Click.on(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN1("Saturday"))),
                            Check.whether(info.get("sun").equals("Yes"))
                                    .andIfSo(Click.on(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN1("Sunday"))),
                            Click.on(AllStoresPage.GENERAL_INFO_HEADER),
                            WindowTask.threadSleep(1000),
                            Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                            WindowTask.threadSleep(1000)
                    );
                }

        );
    }

    public static Task editSetReceivingWeekday1(String date) {
        return Task.where("Edit set receiving weekday",
                // Reset về trạng thái not set
                CommonWaitUntil.isVisible(AllStoresPage.SET_RECEIVING_WEEKDAYS_LABEL),
                Click.on(AllStoresPage.SET_RECEIVING_WEEKDAYS_LABEL),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX),
                WindowTask.threadSleep(1000),
                Clear.field(AllStoresPage.TOOLTIP_TEXTBOX),
                uncheckDay(),
                WindowTask.threadSleep(1000),
                Click.on(OrderDetailPage.SET_RECEIVING_WEEKDAY_DROPDOWN1(date)),
                Click.on(AllStoresPage.GENERAL_INFO_HEADER),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task uncheckDay() {
        List<WebElementFacade> elements = AllStoresPage.ICON_CHECKED_SET_RECEIVING_WEEKDAY.resolveAllFor(theActorInTheSpotlight());
        for (WebElementFacade element : elements) {
            theActorInTheSpotlight().attemptsTo(
                    Click.on(element),
                    WindowTask.threadSleep(1000)
            );
        }
        return Task.where("");
    }

    public static Performable addTagInCreate(List<Map<String, String>> infos) {
        return Task.where("Add tag in create store", actor -> {
            for (Map<String, String> info : infos) {
                actor.attemptsTo(
                        CommonWaitUntil.isVisible(AllStoresPage.D_CREATE_TEXTBOX("Tags")),
                        CommonTask.chooseItemInDropdownWithValueInput1(AllStoresPage.D_CREATE_TEXTBOX("Tags"), info.get("tags"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("tags"))),
                        Check.whether(info.get("expiryDate").isEmpty())
                                .otherwise(Enter.theValue(CommonHandle.setDate2(info.get("expiryDate"), "MM/dd/yy")).into(AllStoresPage.CREATE_STORE_TAG_ADDED_EXPIRY_DATE(info.get("tags"))).thenHit(Keys.ENTER))
                );
            }
        });
    }

    public static Performable deleteTagsInCreate(List<Map<String, String>> infos) {
        return Task.where("Delete tags in create store",
                actor -> {
                    for (Map<String, String> info : infos)
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(AllStoresPage.CREATE_STORE_TAG_ADDED_DELETE_BUTTON(info.get("tag"))),
                                Click.on(AllStoresPage.CREATE_STORE_TAG_ADDED_DELETE_BUTTON(info.get("tag"))),
                                CommonWaitUntil.isNotVisible(AllBuyerPage.TAGS_DELETE_BUTTON_IN_POPUP(info.get("tag")))
                        );
                }
        );
    }

    public static Performable navigateLink(String value) {
        return Task.where("Navigate link " + value,
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(AllStoresPage.D_FOOTER_LINK(value)),
                            Click.on(AllStoresPage.D_FOOTER_LINK(value)),
                            WindowTask.threadSleep(2000)
                    );
                }
        );
    }

    public static Task editSOS() {
        return Task.where("Edit small order surcharge in store detail",
                CommonTaskAdmin.changeSwitchValueFromTooltip(AllStoresPage.CREATE_STORE_BUTTON, "No"),
                CommonWaitUntil.isVisible(AllStoresPage.D_CREATE_TEXTBOX("Name"))
        );
    }

    public static Task turnSOS(String type) {
        return Task.where("Turn " + type + "sos in detail",
                CommonTaskAdmin.changeSwitchValueFromTooltip(AllStoresPage.APPLY_SOS, "No"),
                WindowTask.threadSleep(1000)
        );
    }
}

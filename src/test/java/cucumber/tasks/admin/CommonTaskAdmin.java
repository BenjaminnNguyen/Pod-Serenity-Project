package cucumber.tasks.admin;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.Brand.AllBrandsPage;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.IncomingInventoryDetailPage;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import cucumber.user_interface.admin.store.AllStoresPage;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class CommonTaskAdmin {
    public static Task resetFilter() {
        return Task.where("Reset filter",
                Check.whether(valueOf(CommonAdminForm.SEARCH_BUTTON), isCurrentlyVisible())
                        .andIfSo(Click.on(CommonAdminForm.RESET_BUTTON),
                                CommonWaitUntil.isNotVisible(AllBrandsPage.LOADING_ICON)
                        )
        );
    }

    public static Task resetFilterInPopup() {
        return Task.where("Reset filter in popup",
                Check.whether(valueOf(CommonAdminForm.SEARCH_BUTTON_IN_POPUP), isCurrentlyVisible())
                        .andIfSo(Click.on(CommonAdminForm.RESET_BUTTON_IN_POPUP),
                                CommonWaitUntil.isNotVisible(AllBrandsPage.LOADING_ICON)
                        )
        );
    }

    public static Task showFilter() {
        return Task.where("Show filter",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(Click.on(CommonAdminForm.SHOW_FILTER),
                                CommonWaitUntil.isVisible(CommonAdminForm.COLLAPSE_FILTER)
                        )
        );
    }

    public static Task showFilterInPopup() {
        return Task.where("Show filter in popup",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER_IN_POPUP), isCurrentlyVisible())
                        .andIfSo(Click.on(CommonAdminForm.SHOW_FILTER_IN_POPUP),
                                CommonWaitUntil.isVisible(CommonAdminForm.COLLAPSE_FILTER_IN_POPUP)
                        )
        );
    }

    public static Task changeValueTooltipDropdown(Target target, String value) {
        return Task.where("Change value tooltip dropdown list",
                Click.on(target),
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_COMBOBOX),
                Check.whether(value.isEmpty())
                        .andIfSo(MoveMouse.to(CommonAdminForm.TOOLTIP_COMBOBOX),
                                Click.on(CommonAdminForm.ICON_CIRCLE_DELETE))
                        .otherwise(CommonTask.chooseItemInDropdown(CommonAdminForm.TOOLTIP_COMBOBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(value))),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task removeInputValue(Target target) {
        return Task.where("Clear field " + target,
                WindowTask.threadSleep(500),
                CommonWaitUntil.isVisible(target),
                MoveMouse.to(target),
                Click.on(CommonAdminForm.ICON_CIRCLE_DELETE)
        );
    }

    public static Task changeValueTooltipDropdownWithInput(Target target, String value) {
        return Task.where("Change value tooltip dropdown list with input",
                Click.on(target),
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX),
                Check.whether(value.equals(""))
                        .andIfSo(MoveMouse.to(CommonAdminForm.TOOLTIP_TEXTBOX),
                                Click.on(CommonAdminForm.ICON_CIRCLE_DELETE))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.TOOLTIP_TEXTBOX, value, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(value))),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.TOOLTIP_TEXTBOX),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task changeValueTooltipDropdownWithInput2(Target target, String value) {
        return Task.where("Change value tooltip dropdown list with input",
                CommonWaitUntil.isVisible(target),
                Click.on(target),
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX),
                Check.whether(value.equals(""))
                        .andIfSo(MoveMouse.to(CommonAdminForm.TOOLTIP_COMBOBOX),
                                Click.on(CommonAdminForm.ICON_CIRCLE_DELETE))
                        .otherwise(CommonTask.chooseItemInDropdownWithValueInput(CommonAdminForm.TOOLTIP_TEXTBOX, value, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(value))),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task changeValueTooltipDateTime(Target target, String value) {
        return Task.where("Change value tooltip DateTimePicker",
                Click.on(target),
                CommonWaitUntil.isVisible(CommonAdminForm.CURRENTDATE_IN_DATETIME),
                Click.on(CommonAdminForm.CURRENTDATE_IN_DATETIME),
                MoveMouse.to(CommonAdminForm.TOOLTIP_TEXTBOX),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.ICON_CLOSE_DATE),
                Click.on(IncomingInventoryDetailPage.ICON_CLOSE_DATE),
                Enter.theValue(value).into(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX).thenHit(Keys.ENTER),
                Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task changeValueTooltipTime(Target target, String startTime, String endTime) {
        return Task.where("Change value tooltip Time Editor",
                Click.on(target),
                CommonWaitUntil.isVisible(CommonAdminForm.START_DATE_PICKUP),
                CommonTask.chooseItemInDropdown(CommonAdminForm.START_DATE_PICKUP, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(startTime)),
                WindowTask.threadSleep(500),
                CommonTask.chooseItemInDropdown(CommonAdminForm.END_DATE_PICKUP, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(endTime)),
                Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task changeValueTooltipTextbox(Target target, String value) {
        return Task.where("Change value tooltip Textbox",
                CommonWaitUntil.isVisible(target),
                Scroll.to(target),
                Click.on(target),
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX),
                Clear.field(CommonAdminForm.TOOLTIP_TEXTBOX),
                Enter.theValue(value).into(CommonAdminForm.TOOLTIP_TEXTBOX),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task changeValueTooltipTextarea(Target target, String value) {
        return Task.where("Change value tooltip Textarea",
                Click.on(target),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.TOOLTIP_TEXTAREA),
                Clear.field(IncomingInventoryDetailPage.TOOLTIP_TEXTAREA),
                Enter.theValue(value).into(IncomingInventoryDetailPage.TOOLTIP_TEXTAREA),
                Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(IncomingInventoryDetailPage.TOOLTIP_TEXTAREA),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task changeValueFile(Target target, String value) {
        return Task.where("Change value field file",
                CommonFile.upload2(value, target)
        );
    }

    public static Task chooseDateFromTooltipDateTime(Target target, String value) {
        return Task.where("Change value tooltip DateTimePicker",
                CommonWaitUntil.isVisible(target),
                Click.on(target),
                CommonWaitUntil.isVisible(CommonAdminForm.DATE_ON_POPUP(value)),
                Click.on(CommonAdminForm.DATE_ON_POPUP(value)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.TABLE_DATE),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task changeSwitchValueFromTooltip(Target target, String value) {
        return Task.where("Change switch value",
                Check.whether(value.contains("yes"))
                        .otherwise(
                                Click.on(target),
                                CommonWaitUntil.isVisible(CommonAdminForm.D_BUTTON_SWITCH),
                                Click.on(CommonAdminForm.D_BUTTON_SWITCH),
                                Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.D_BUTTON_TOOLTIP),
                                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
                        )
        );
    }

    public static Task changeValueTooltipTextboxError(Target target, String value, String message) {
        return Task.where("Change value tooltip Textbox Error",
                CommonWaitUntil.isVisible(target),
                Click.on(target),
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX),
                WindowTask.threadSleep(1000),
                Clear.field(CommonAdminForm.TOOLTIP_TEXTBOX),
                WindowTask.threadSleep(1000),
                Enter.theValue(value).into(CommonAdminForm.TOOLTIP_TEXTBOX),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.TOOLTIP_MESSAGE(message)),
                Click.on(IncomingInventoryDetailPage.TOOLTIP_MESSAGE_CLOSE),
                Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP_CANCEL)
        );
    }

    public static Task changeValueTooltipTextboxError1(Target target, String value, String message) {
        return Task.where("Change value tooltip Textbox Error",
                CommonWaitUntil.isVisible(target),
                Click.on(target),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX),
                WindowTask.threadSleep(1000),
                Hit.the(Keys.BACK_SPACE).into(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX),
                Enter.theValue(value).into(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX),
                Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.TOOLTIP_MESSAGE(message)),
                Click.on(IncomingInventoryDetailPage.TOOLTIP_MESSAGE_CLOSE),
                Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP_CANCEL)
        );
    }

    public static Task changeValueTooltipTextboxBlank(Target target, String message) {
        return Task.where("Change value tooltip Textbox Blank",
                CommonWaitUntil.isVisible(target),
                Click.on(target),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX),
                WindowTask.threadSleep(1000),
                Hit.the(Keys.BACK_SPACE).into(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX),
                Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.TOOLTIP_MESSAGE(message)),
                Click.on(IncomingInventoryDetailPage.TOOLTIP_MESSAGE_CLOSE),
                Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP_CANCEL)
        );
    }

    public static Task chooseDateFromTooltipDateTimeError(Target target, String message) {
        return Task.where("Change value tooltip DateTimePicker error",
                Click.on(target),
                CommonWaitUntil.isVisible(CommonAdminForm.CURRENTDATE_IN_DATETIME),
                Click.on(CommonAdminForm.CURRENTDATE_IN_DATETIME),
                MoveMouse.to(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.ICON_CLOSE_DATE),
                Click.on(IncomingInventoryDetailPage.ICON_CLOSE_DATE),
                Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.TOOLTIP_MESSAGE(message)),
                CommonWaitUntil.isNotVisible(IncomingInventoryDetailPage.TOOLTIP_MESSAGE(message)),
                WindowTask.threadSleep(1000),
                Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP_CANCEL),
                CommonWaitUntil.isNotVisible(IncomingInventoryDetailPage.TOOLTIP_TEXTBOX)
        );
    }

    public static Performable changeValueTooltipTimeBlankError(Target target, String message) {
        return Task.where("Change value tooltip Time Editor",
                actor -> {
                    actor.attemptsTo(
                            Click.on(target),
                            CommonWaitUntil.isVisible(CommonAdminForm.START_DATE_PICKUP),
                            Click.on(CommonAdminForm.START_DATE_PICKUP)
                    );
                    for (int i = 0; i < 6; i++) {
                        actor.attemptsTo(
                                Hit.the(Keys.BACK_SPACE).into(CommonAdminForm.START_DATE_PICKUP)
                        );
                    }
                    actor.attemptsTo(
                            Click.on(CommonAdminForm.END_DATE_PICKUP)
                    );
                    for (int i = 0; i < 6; i++) {
                        actor.attemptsTo(
                                Hit.the(Keys.BACK_SPACE).into(CommonAdminForm.END_DATE_PICKUP)
                        );
                    }
                    actor.attemptsTo(
                            Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP),
                            CommonWaitUntil.isVisible(IncomingInventoryDetailPage.TOOLTIP_MESSAGE(message)),
                            Click.on(IncomingInventoryDetailPage.TOOLTIP_MESSAGE_CLOSE),
                            Click.on(IncomingInventoryDetailPage.D_BUTTON_TOOLTIP_CANCEL)
                    );
                }
        );
    }

    public static Task cancelEdit() {
        return Task.where("cancel edit product",
                CommonWaitUntil.isVisible(CommonAdminForm.D_BUTTON_CANCEL_TOOLTIP),
                Click.on(CommonAdminForm.D_BUTTON_CANCEL_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.D_BUTTON_CANCEL_TOOLTIP)

        );
    }

    public static Task checkHelpTooltip(String field, String message) {
        return Task.where("check help tooltip of field " + field,
                CommonWaitUntil.isVisible(CommonAdminForm.HELP_TOOLTIP(field)),
                MoveMouse.to(CommonAdminForm.HELP_TOOLTIP(field)),
                Ensure.that(CommonAdminForm.ANY_TEXT(message)).isDisplayed()
        );
    }

    public static Task checkDialogHelpTooltip(Target parent, String field, String message) {
        return Task.where("check help tooltip of field " + field,
                CommonWaitUntil.isVisible(parent),
                Click.on(parent),
                CommonWaitUntil.isVisible(CommonAdminForm.DIALOG_HELP_TOOLTIP(field)),
                MoveMouse.to(CommonAdminForm.DIALOG_HELP_TOOLTIP(field)),
                Ensure.that(CommonAdminForm.ANY_TEXT(message)).isDisplayed().then(
                        CommonTask.pressESC()
                )
        );
    }

    /*
     * time : so lan nhan
     *
     * */
    public static void changeTextboxNumberIncreaseDecreaseValue(Target field, String type, int time) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(field),
                Scroll.to(field),
                Click.on(field)
        );
        for (int i = 0; i < time; i++) {
            if (type.contains("increase"))
                theActorInTheSpotlight().attemptsTo(
                        Hit.the(Keys.ARROW_UP).into(field)
                );
            if (type.contains("decrease"))
                theActorInTheSpotlight().attemptsTo(
                        Hit.the(Keys.ARROW_DOWN).into(field)
                );
        }
    }

    public static Task goBack() {
        return Task.where("",
                CommonWaitUntil.isVisible(CommonAdminForm.BACK_BUTTON),
                Click.on(CommonAdminForm.BACK_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );

    }

    public static Task editReceivingTime(Map<String, String> info) {
        return Task.where("Edit set receiving weekday",
                // Reset về trạng thái not set
                CommonWaitUntil.isVisible(AllStoresPage.RECEIVING_TIME_LABEL),
                Click.on(AllStoresPage.RECEIVING_TIME_LABEL),
                CommonWaitUntil.isVisible(AllStoresPage.TOOLTIP_TEXTBOX),
                // Choose start time
                CommonTask.chooseItemInDropdown3(AllStoresPage.RECEIVING_TIME_FROM_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("startTime"))),
                CommonTask.chooseItemInDropdown3(AllStoresPage.RECEIVING_TIME_TO_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("endTime"))),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task editDepartment(String department) {
        return Task.where("Edit department",
                CommonWaitUntil.isVisible(OrderDetailPage.DEPARTMENT),
                Click.on(OrderDetailPage.DEPARTMENT),
                CommonWaitUntil.isVisible(CommonAdminForm.TOOLTIP_TEXTBOX),
                CommonTask.chooseItemInDropdown3(CommonAdminForm.TOOLTIP_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(department)),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task sortField(String field, String type) {
        return Task.where("Sort filter",
                CommonWaitUntil.isVisible(CommonAdminForm.D_SORT_BY(field, type)),
                Scroll.to(CommonAdminForm.D_SORT_BY(field, type)),
                Check.whether(CommonQuestions.isClickAble(CommonAdminForm.D_SORT_BY(field, type)))
                        .andIfSo(
                                Click.on(CommonAdminForm.D_SORT_BY(field, type)))
                        .otherwise(
                                JavaScriptClick.on(CommonAdminForm.D_SORT_BY(field, type))
                        ),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task saveFilter(Map<String, String> info) {
        return Task.where("Save filter",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("filters preset")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("filters preset")),
                // Go to filter popup
                CommonWaitUntil.isVisible(CommonAdminForm.FILTER_PRESET_BUTTON),
                Click.on(CommonAdminForm.FILTER_PRESET_BUTTON),
                // choose type save filter
                CommonWaitUntil.isVisible(CommonAdminForm.SAVE_FILTER_PRESET_TYPE("Save as new preset")),
                Check.whether(info.get("type").equals("Save as new preset"))
                        .andIfSo(
                                Click.on(CommonAdminForm.SAVE_FILTER_PRESET_TYPE("Save as new preset")),
                                Enter.theValue(info.get("filterName")).into(CommonAdminForm.SAVE_FILTER_NAME_TEXTBOX)
                        )
                        .otherwise(
                                Click.on(CommonAdminForm.SAVE_FILTER_PRESET_TYPE("Reset existing preset")),
                                Check.whether(info.get("filterName").isEmpty()).otherwise(
                                        CommonTask.chooseItemInDropdownWithValueInput1(CommonAdminForm.SAVE_FILTER_NAME_TEXTBOX, info.get("filterName"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("filterName")))
                                )
                        ),
                // Save
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Save"))
        );
    }

    public static Task chooseFilter(String filterName) {
        return Task.where("Save filter",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("filters preset")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("filters preset")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("filters preset")),
                Click.on(CommonAdminForm.FILTER_NAME_SAVED(filterName)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.FILTER_NAME_SAVED(filterName)),
                WindowTask.threadSleep(1000)
        );
    }

    public static Performable deleteFilter(String filterName) {
        return Task.where("Delete filter",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("filters preset")),
                            Click.on(CommonAdminForm.DYNAMIC_BUTTON("filters preset")),
                            CommonWaitUntil.isVisible(CommonAdminForm.FILTER_PRESET_BUTTON)
                    );

                    List<WebElementFacade> filters = CommonAdminForm.FILTER_NAME_SAVED_DELETE(filterName).resolveAllFor(theActorInTheSpotlight());
                    for (WebElementFacade filter : filters) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FILTER_NAME_SAVED_DELETE(filterName)),
                                WindowTask.threadSleep(1000)
                        );
                    }

                }
        );
    }

    public static Performable editVisibility(Map<String, String> info) {
        return Task.where("Edit visibility in search",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(CommonAdminForm.EDIT_VISIBILITY_BUTTON),
                            Click.on(CommonAdminForm.EDIT_VISIBILITY_BUTTON),
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Save")),
                            WindowTask.threadSleep(5000)
                    );
                    if (info.containsKey("buyerCompany")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Buyer Company")));
                    }
                    if (info.containsKey("buyercompany")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Buyer company")));
                    }
                    if (info.containsKey("buyer")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Buyer")));
                    }
                    if (info.containsKey("region")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Region")));
                    }
                    if (info.containsKey("store")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Store")));
                    }
                    if (info.containsKey("stores")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Stores")));
                    }
                    if (info.containsKey("statementMonth")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Statement month")));
                    }
                    if (info.containsKey("managedBy")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Managed by")));
                    }
                    if (info.containsKey("orderNumber")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Order # / Customer PO # / PO #")));
                    }
                    if (info.containsKey("orderGhost")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Order number / Customer PO")));
                    }
                    if (info.containsKey("orderInprocess")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Order number")));
                    }
                    if (info.containsKey("customPOInprocess")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Customer PO")));
                    }
                    if (info.containsKey("createdByInprocess")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Created by")));
                    }
                    if (info.containsKey("customStore")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Order-specific store name")));
                    }
                    if (info.containsKey("vendorCompany")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Vendor company")));
                    }
                    if (info.containsKey("brand")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Brand")));
                    }
                    if (info.containsKey("sku")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("SKU name / Item code")));
                    }
                    if (info.containsKey("upc")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("UPC/EAN")));
                    }
                    if (info.containsKey("fulfillment")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Fulfillment")));
                    }
                    if (info.containsKey("buyerPayment")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Buyer payment")));
                    }
                    if (info.containsKey("route")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Route")));
                    }
                    if (info.containsKey("storeManager")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Buyer company managed by")));
                    }
                    if (info.containsKey("lackPOD")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Lack of PoD")));
                    }
                    if (info.containsKey("lackTracking")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Lack of Tracking Information")));
                    }
                    if (info.containsKey("startDate")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Start date")));
                    }
                    if (info.containsKey("endDate")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("End date")));
                    }
                    if (info.containsKey("temperature")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Temperature")));
                    }
                    if (info.containsKey("oos")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("OOS?")));
                    }
                    if (info.containsKey("type")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Type")));
                    }
                    if (info.containsKey("orderType")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Order type")));
                    }
                    if (info.containsKey("expressProgress")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Express progress")));
                    }
                    if (info.containsKey("edi")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("EDI orders")));
                    }
                    if (info.containsKey("perPage")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Orders per page")));
                    }
                    if (info.containsKey("numberCreditMemo")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Number")));
                    }
                    if (info.containsKey("state")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("State")));
                    }
                    if (info.containsKey("buyerEmail")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Buyer email")));
                    }
                    if (info.containsKey("diff")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Diff")));
                    }
                    if (info.containsKey("perPage")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Orders per page")));
                    }
                    if (info.containsKey("paymentStatus")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Payment status")));
                    }
                    if (info.containsKey("email")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Email")));
                    }
                    if (info.containsKey("ach")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("ACH?")));
                    }
                    if (info.containsKey("prePayment")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Prepayment?")));
                    }
                    if (info.containsKey("number")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Number")));
                    }
                    if (info.containsKey("status")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Status")));
                    }
                    if (info.containsKey("anyText")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Any text")));
                    }
                    if (info.containsKey("productName")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Product name")));
                    }
                    if (info.containsKey("vendorBrand")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Vendor brand")));
                    }
                    if (info.containsKey("skuNameItemCode")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("SKU name / Item code")));
                    }
                    if (info.containsKey("warehouse")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Warehouse")));
                    }
                    if (info.containsKey("below75")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Below 75%?")));
                    }
                    if (info.containsKey("referenceNumber")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Reference number")));
                    }
                    if (info.containsKey("itemPerPage")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Items per page")));
                    }
                    if (info.containsKey("initiatedBy")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Initiated by")));
                    }
                    if (info.containsKey("lpReview")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("LP review")));
                    }
                    if (info.containsKey("freightCarrier")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Freight carrier")));
                    }
                    if (info.containsKey("trackingNumber")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Tracking number")));
                    }
                    if (info.containsKey("pendingFinancialApprove")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Pending Finance Approval?")));
                    }
                    if (info.containsKey("name")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Name")));
                    }
                    if (info.containsKey("includeStore")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Included store")));
                    }
                    if (info.containsKey("includeBuyerCompany")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Included Buyer company")));
                    }
                    if (info.containsKey("expiresBefore")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Expires before")));
                    }
                    if (info.containsKey("isStackDeal")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Is stack deals?")));
                    }
                    if (info.containsKey("excludeStore")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Excluded store")));
                    }
                    if (info.containsKey("excludeBuyerCompany")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Excluded Buyer company")));
                    }
                    if (info.containsKey("startAfter")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Starts after")));
                    }
                    if (info.containsKey("vendorPayment")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Vendor payment")));
                    }
                    if (info.containsKey("purchaseRequestNumber")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Purchase request number")));
                    }
                    if (info.containsKey("adminUser")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Admin User")));
                    }
                    if (info.containsKey("fullName")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Full name")));
                    }
                    if (info.containsKey("tags")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Tags")));
                    }
                    if (info.containsKey("approved")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Approved?")));
                    }
                    if (info.containsKey("shopify")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Shopify?")));
                    }
                    if (info.containsKey("addressCity")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Address city")));
                    }
                    if (info.containsKey("addressState")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Address state")));
                    }
                    if (info.containsKey("sos")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Small order surcharge applied?")));
                    }
                    if (info.containsKey("size")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Size")));
                    }
                    if (info.containsKey("city")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("City")));
                    }
                    if (info.containsKey("deliveryWeekDay")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Delivery week day")));
                    }
                    if (info.containsKey("onboardStatus")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Onboarding status")));
                    }
                    if (info.containsKey("role")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Role")));
                    }
                    actor.attemptsTo(
                            // save
                            WindowTask.threadSleep(500),
                            Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Save")),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Save")),
                            WindowTask.threadSleep(1000)
                    );
                }
        );
    }

    public static Performable checkAllEditVisibility(Map<String, String> info) {
        return Task.where("Uncheck all edit visibility in search",
                actor -> {
                    theActorInTheSpotlight().attemptsTo(
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Search"))
                    );
                    if (info.containsKey("orderNumber")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number")).isDisplayed());
                    }
                    if (info.containsKey("store")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id")).isDisplayed());
                    }
                    if (info.containsKey("buyer")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id")).isDisplayed());
                    }
                    if (info.containsKey("vendorCompany")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id")).isDisplayed());
                    }
                    if (info.containsKey("brand")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[brand_id]")).isDisplayed());
                    }
                    if (info.containsKey("sku")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[product_variant_ids]")).isDisplayed());
                    }
                    if (info.containsKey("upc")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[upc]")).isDisplayed());
                    }
                    if (info.containsKey("buyerCompany")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[buyer_company_id]")).isDisplayed());
                    }
                    if (info.containsKey("fulfillmentState")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[fulfillment_states]")).isDisplayed());
                    }
                    if (info.containsKey("buyerPayment")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[buyer_payment_state]")).isDisplayed());
                    }
                    if (info.containsKey("region")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id")).isDisplayed());
                    }
                    if (info.containsKey("route")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[route_id]")).isDisplayed());
                    }
                    if (info.containsKey("managedBy")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[store_manager_id]")).isDisplayed());
                    }
                    if (info.containsKey("lackPOD")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[lack_pod]")).isDisplayed());
                    }
                    if (info.containsKey("tracking")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[lack_tracking]")).isDisplayed());
                    }
                    if (info.containsKey("startDate")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("start_date")).isDisplayed());
                    }
                    if (info.containsKey("endDate")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("end_date")).isDisplayed());
                    }
                    if (info.containsKey("temperature")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("temperature_name")).isDisplayed());
                    }
                    if (info.containsKey("oos")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("has_out_of_stock_items")).isDisplayed());
                    }
                    if (info.containsKey("type")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("type")).isDisplayed());
                    }
                    if (info.containsKey("orderType")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("type")).isDisplayed());
                    }
                    if (info.containsKey("expressProgress")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("express_progress")).isDisplayed());
                    }
                    if (info.containsKey("edi")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("only_spring_po")).isDisplayed());
                    }
                    if (info.containsKey("ediOrder")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("only_edi")).isDisplayed());
                    }
                    if (info.containsKey("paymentStatus")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("payment_state")).isDisplayed()
                        );
                    }
                    if (info.containsKey("email")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("email")).isDisplayed()
                        );
                    }
                    if (info.containsKey("ach")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_ach")).isDisplayed()
                        );
                    }
                    if (info.containsKey("statementMonth")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("statement_month")).isDisplayed()
                        );
                    }
                    if (info.containsKey("prePayment")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("pay_early_discount")).isDisplayed()
                        );
                    }
                    if (info.containsKey("diff")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("diff_str")).isDisplayed()
                        );
                    }
                    if (info.containsKey("number")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number")).isDisplayed());
                    }
                    if (info.containsKey("status")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("status")).isDisplayed());
                    }
                    if (info.containsKey("anyText")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[any_text]")).isDisplayed()
                        );
                    }
                    if (info.containsKey("productName")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[product_name]")).isDisplayed());
                    }
                    if (info.containsKey("vendorBrand")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[brand_id]")).isDisplayed());
                    }
                    if (info.containsKey("skuNameItemCode")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[product_variant_id]")).isDisplayed());
                    }
                    if (info.containsKey("warehouse")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[warehouse_id]")).isDisplayed());
                    }
                    if (info.containsKey("below75")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[below_threshold]")).isDisplayed());
                    }
                    if (info.containsKey("referenceNumber")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[reference_number]")).isDisplayed());
                    }
                    if (info.containsKey("itemPerPage")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("per_page")).isDisplayed());
                    }
                    if (info.containsKey("initiatedBy")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[creator_type]")).isDisplayed());
                    }
                    if (info.containsKey("lpReview")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[lp_review]")).isDisplayed());
                    }
                    if (info.containsKey("freightCarrier")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[freight_carrier]")).isDisplayed());
                    }
                    if (info.containsKey("trackingNumber")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[tracking_number]")).isDisplayed());
                    }
                    if (info.containsKey("name")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[name]")).isDisplayed());
                    }
                    if (info.containsKey("includeStore")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[store_id]")).isDisplayed());
                    }
                    if (info.containsKey("includeBuyerCompany")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[buyer_company_id]")).isDisplayed());
                    }
                    if (info.containsKey("expiresBefore")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[expires_at]")).isDisplayed());
                    }
                    if (info.containsKey("isStackDeal")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[promo_action_type]")).isDisplayed());
                    }
                    if (info.containsKey("excludeStore")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[excluded_store_id]")).isDisplayed());
                    }
                    if (info.containsKey("excludeBuyerCompany")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[excluded_buyer_company_id]")).isDisplayed());
                    }
                    if (info.containsKey("startAfter")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[starts_at]")).isDisplayed());
                    }
                    if (info.containsKey("vendorPayment")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[vendor_payment_state]")).isDisplayed());
                    }
                    if (info.containsKey("adminUser")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("admin_id")).isDisplayed());
                    }
                    if (info.containsKey("fullName")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("full_name")).isDisplayed()
                        );
                    }
                    if (info.containsKey("addressCity")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_address_city")).isDisplayed()
                        );
                    }
                    if (info.containsKey("addressState")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_address_address_state_id")).isDisplayed()
                        );
                    }
                    if (info.containsKey("tag")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("tag_ids")).isDisplayed()
                        );
                    }
                    if (info.containsKey("approved")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("approved")).isDisplayed()
                        );
                    }
                    if (info.containsKey("shopify")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("shopify")).isDisplayed()
                        );
                    }
                    if (info.containsKey("active_state_vendor")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("active_state")).isDisplayed()
                        );
                    }
                    if (info.containsKey("sos")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[has_surcharge]")).isDisplayed());
                    }
                    if (info.containsKey("storeSize")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[store_size]")).isDisplayed());
                    }
                    if (info.containsKey("storeType")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[store_type_id]")).isDisplayed());
                    }
                    if (info.containsKey("city")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[city]")).isDisplayed());
                    }
                    if (info.containsKey("deliveryWeekDay")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[receiving_week_day]")).isDisplayed());
                    }
                    if (info.containsKey("managedByStore")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[manager_id]")).isDisplayed()
                        );
                    }
                    if (info.containsKey("statusStore")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[store_state]")).isDisplayed());
                    }
                    if (info.containsKey("onboardStatus")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[onboarding_state]")).isDisplayed());
                    }
                    if (info.containsKey("role")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("role")).isDisplayed());
                    }
                }
        );
    }

    public static Performable uncheckAllEditVisibility(Map<String, String> info) {
        return Task.where("Uncheck all edit visibility in search",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Search"))
                    );
                    if (info.containsKey("orderNumber")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("store")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("store_id")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("buyer")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_id")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("vendorCompany")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("brand")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[brand_id]")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("sku")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[product_variant_ids]")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("upc")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[upc]")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("buyerCompany")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[buyer_company_id]")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("fulfillmentState")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[fulfillment_states]")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("buyerPayment")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[buyer_payment_state]")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("region")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("route")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[route_id]")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("managedBy")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[store_manager_id]")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("lackPOD")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[lack_pod]")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("tracking")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[lack_tracking]")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("startDate")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("start_date")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("endDate")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("end_date")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("temperature")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("temperature_name")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("oos")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("has_out_of_stock_items")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("type")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("type")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("orderType")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("type")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("expressProgress")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("express_progress")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("buyerEmail")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("buyer_email")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("state")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("state")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("edi")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("only_spring_po")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("ediOrder")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("only_edi")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("diff")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("diff_str")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("paymentStatus")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("payment_state")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("email")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("email")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("ach")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_ach")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("statementMonth")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("statement_month")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("prePayment")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("pay_early_discount")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("number")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[number]")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("status")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("status")).isNotDisplayed());
                    }
                    if (info.containsKey("anyText")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[any_text]")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("productName")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[product_name]")).isNotDisplayed());
                    }
                    if (info.containsKey("vendorBrand")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[brand_id]")).isNotDisplayed());
                    }
                    if (info.containsKey("skuNameItemCode")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[product_variant_id]")).isNotDisplayed());
                    }
                    if (info.containsKey("warehouse")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[warehouse_id]")).isNotDisplayed());
                    }
                    if (info.containsKey("below75")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[below_threshold]")).isNotDisplayed());
                    }
                    if (info.containsKey("referenceNumber")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[reference_number]")).isNotDisplayed());
                    }
                    if (info.containsKey("itemPerPage")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("per_page")).isNotDisplayed());
                    }
                    if (info.containsKey("initiatedBy")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[creator_type]")).isNotDisplayed());
                    }
                    if (info.containsKey("lpReview")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[lp_review]")).isNotDisplayed());
                    }
                    if (info.containsKey("freightCarrier")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[freight_carrier]")).isNotDisplayed());
                    }
                    if (info.containsKey("trackingNumber")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[tracking_number]")).isNotDisplayed());
                    }
                    if (info.containsKey("name")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[name]")).isNotDisplayed());
                    }
                    if (info.containsKey("includeStore")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[store_id]")).isNotDisplayed());
                    }
                    if (info.containsKey("includeBuyerCompany")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[buyer_company_id]")).isNotDisplayed());
                    }
                    if (info.containsKey("expiresBefore")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[expires_at]")).isNotDisplayed());
                    }
                    if (info.containsKey("isStackDeal")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[promo_action_type]")).isNotDisplayed());
                    }
                    if (info.containsKey("excludeStore")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[excluded_store_id]")).isNotDisplayed());
                    }
                    if (info.containsKey("excludeBuyerCompany")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[excluded_buyer_company_id]")).isNotDisplayed());
                    }
                    if (info.containsKey("startAfter")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[starts_at]")).isNotDisplayed());
                    }
                    if (info.containsKey("vendorPayment")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("Vendor payment")).isNotDisplayed());
                    }
                    if (info.containsKey("customerPOInprocess")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[customer_po]")).isNotDisplayed());
                    }
                    if (info.containsKey("createdByInprocess")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[admin_id]")).isNotDisplayed());
                    }
                    if (info.containsKey("statusInprocess")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[state]")).isNotDisplayed());
                    }
                    if (info.containsKey("adminUser")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("admin_id")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("fullName")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("full_name")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("addressCity")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_address_city")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("addressState")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_address_address_state_id")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("tag")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("tag_ids")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("approved")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("approved")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("shopify")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("shopify")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("active_state_vendor")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("active_state")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("sos")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[has_surcharge]")).isNotDisplayed());
                    }
                    if (info.containsKey("storeSize")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[store_size]")).isNotDisplayed());
                    }
                    if (info.containsKey("storeType")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[store_type_id]")).isNotDisplayed());
                    }
                    if (info.containsKey("city")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[city]")).isNotDisplayed());
                    }
                    if (info.containsKey("deliveryWeekDay")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[receiving_week_day]")).isNotDisplayed());
                    }
                    if (info.containsKey("managedByStore")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[manager_id]")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("statusStore")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[store_state]")).isNotDisplayed());
                    }
                    if (info.containsKey("onboardStatus")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("onboarding_state")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("role")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("role")).isNotDisplayed()
                        );
                    }
                }
        );
    }


}

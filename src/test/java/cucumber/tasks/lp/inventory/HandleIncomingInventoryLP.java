package cucumber.tasks.lp.inventory;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.IncomingInventoryDetailPage;
import cucumber.user_interface.beta.Buyer.cart.CheckoutPage;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.orders.VendorOrderListPage;
import cucumber.user_interface.lp.CommonLPPage;
import cucumber.user_interface.lp.OrdersLPPage;
import cucumber.user_interface.lp.inventory.InboundInventoryDetailLPPage;
import cucumber.user_interface.lp.inventory.InboundInventoryLPPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.abilities.BrowseTheWeb;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleIncomingInventoryLP {

    public static Task search(String num) {
        if (num.isEmpty()) {
            return Task.where("",
                    CommonWaitUntil.isVisible(InboundInventoryLPPage.NUMBER_SEARCH),
                    Enter.theValue(Serenity.sessionVariableCalled("Inventory_Reference").toString()).into(InboundInventoryLPPage.NUMBER_SEARCH).thenHit(Keys.ENTER),
                    CommonWaitUntil.isNotVisible(InboundInventoryLPPage.LOADING)
            );
        } else {
            return Task.where("",
                    CommonWaitUntil.isVisible(InboundInventoryLPPage.NUMBER_SEARCH),
                    Enter.theValue(num).into(InboundInventoryLPPage.NUMBER_SEARCH).thenHit(Keys.ENTER),
                    CommonWaitUntil.isNotVisible(InboundInventoryLPPage.LOADING)
            );
        }
    }

    public static Task search(Map<String, String> map) {
        return Task.where("",
                CommonWaitUntil.isVisible(InboundInventoryLPPage.NUMBER_SEARCH),
                Check.whether(map.get("number").isEmpty()).otherwise(
                        Enter.theValue(map.get("number")).into(InboundInventoryLPPage.NUMBER_SEARCH).thenHit(Keys.ENTER),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories"))
                ),
                Check.whether(map.get("brand").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput1(CommonLPPage.DYNAMIC_SEARCH_FIELD("Brand"), map.get("brand"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(map.get("brand"))),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories"))
                ),
                Check.whether(map.get("start").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("start"), "MM/dd/yy")).into(CommonLPPage.DYNAMIC_SEARCH_FIELD("Start")).thenHit(Keys.ENTER),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories"))
                ),
                Check.whether(map.get("end").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("end"), "MM/dd/yy")).into(CommonLPPage.DYNAMIC_SEARCH_FIELD("End")).thenHit(Keys.ENTER),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories"))
                ),

                Check.whether(map.get("deliveryMethod").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(CommonLPPage.DYNAMIC_SEARCH_FIELD("Delivery method"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(map.get("deliveryMethod"))),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories"))
                ),
                CommonWaitUntil.isNotVisible(InboundInventoryLPPage.LOADING)
        );
    }

    public static Performable goToDetail(String number) {
        return Task.where("{0} go to detail",
                actor -> {
                    String idInbound = number;
                    if (number.isEmpty()) {
                        idInbound = Serenity.sessionVariableCalled("Inventory_Reference").toString();
                    }
                    if (number.contains("create by api")) {
                        idInbound = Serenity.sessionVariableCalled("Number Inbound Inventory api").toString();
                    }

                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(InboundInventoryLPPage.TABLE_NUMBER(idInbound)),
                            Click.on(InboundInventoryLPPage.TABLE_NUMBER(idInbound)),
                            CommonWaitUntil.isNotVisible(InboundInventoryLPPage.LOADING));
                });
    }

    public static Task uploadSignedWPL(String fileName) {
        return Task.where("Upload signed WPL",
                CommonFile.upload1(fileName, InboundInventoryDetailLPPage.UPLOAD_SIGNED_WPL)
        );
    }

    public static Task createNewInventory(Map<String, String> info) {
        return Task.where("Create new inventory",
                Click.on(InboundInventoryDetailLPPage.NEW_INVENTORY_BUTTON),
                CommonWaitUntil.isVisible(InboundInventoryDetailLPPage.CREATE_NEW_INVENTORY_HEADER),
                CommonTask.chooseItemInDropdownWithValueInput(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Distribution center"), info.get("distribution"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("distribution"))),
                CommonTask.chooseItemInDropdownWithValueInput(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("SKU"), info.get("sku"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_2(info.get("sku"))),
                Enter.theValue(info.get("quantity")).into(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Quantity")),
                Enter.theValue(info.get("lotCode")).into(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Lot Code")),
                Enter.theValue(CommonHandle.setDate2(info.get("receiveDate"), "MM/dd/yy")).into(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Receive date")).thenHit(Keys.ENTER),
                Enter.theValue(CommonHandle.setDate2(info.get("expiryDate"), "MM/dd/yy")).into(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Expiry date")).thenHit(Keys.ENTER),
                Enter.theValue(info.get("comment")).into(InboundInventoryDetailLPPage.D_TEXTBOX_CREATENEW("Comment"))
        );
    }

    public static Task createNewInventorySuccess() {
        return Task.where("Create new inventory success",
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON("Create")),
                Click.on(CommonLPPage.DYNAMIC_BUTTON("Create")));
    }

    public static Task goBackFromDetail(String a) {
        return Task.where("Go back from detail",
                Click.on(InboundInventoryDetailLPPage.D_LINK(a)),
                CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories..."))
        );
    }

    public static Task searchAll() {
        return Task.where("Open search all order",
                CommonWaitUntil.isVisible(CommonLPPage.ALL_FILTER),
                Click.on(CommonLPPage.ALL_FILTER),
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_SEARCH_FIELD("Number"))
        );
    }

    public static Task inputSearchAll(Map<String, String> map) {
        return Task.where("search all order",
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_SEARCH_FIELD("Number")),
                Check.whether(map.get("number").isEmpty()).otherwise(
                        Enter.theValue(map.get("number")).into(CommonLPPage.DYNAMIC_SEARCH_FIELD("Number")).thenHit(Keys.ENTER),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories"))
                ),
                Check.whether(map.get("brand").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput1(CommonLPPage.DYNAMIC_SEARCH_FIELD("Brand"), map.get("brand"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(map.get("brand"))),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories"))
                ),
                Check.whether(map.get("start").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("start"), "MM/dd/yy")).into(CommonLPPage.DYNAMIC_SEARCH_FIELD("Start")).thenHit(Keys.ENTER),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories"))
                ),
                Check.whether(map.get("end").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(map.get("end"), "MM/dd/yy")).into(CommonLPPage.DYNAMIC_SEARCH_FIELD("End")).thenHit(Keys.ENTER),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories"))
                ),
                Check.whether(map.get("deliveryMethod").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(CommonLPPage.DYNAMIC_SEARCH_FIELD("Delivery method"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(map.get("deliveryMethod"))),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories"))
                ),
                Check.whether(map.get("freightCarrier").isEmpty()).otherwise(
                        Enter.theValue(map.get("freightCarrier")).into(CommonLPPage.DYNAMIC_SEARCH_FIELD("Freight Carrier")).thenHit(Keys.ENTER),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories"))
                ),
                Check.whether(map.get("lpReview").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(CommonLPPage.DYNAMIC_SEARCH_FIELD("LP Review"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(map.get("lpReview"))),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories"))
                ),
                Check.whether(map.get("status").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(CommonLPPage.DYNAMIC_SEARCH_FIELD("Status"), CommonLPPage.DYNAMIC_ITEM_DROPDOWN_2(map.get("status"))),
                        CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories"))
                )
        );
    }

    public static Task closeSearchAll() {
        return Task.where("close search order",
                CommonWaitUntil.isVisible(OrdersLPPage.CLOSE_SEARCH_ALL),
                Click.on(OrdersLPPage.CLOSE_SEARCH_ALL),
                CommonWaitUntil.isNotVisible(OrdersLPPage.CLOSE_SEARCH_ALL)
        );
    }

    public static Task clearSearchAll() {
        return Task.where("close search order",
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON("Clear all filters")),
                Click.on(CommonLPPage.DYNAMIC_BUTTON("Clear all filters"))
        );
    }

    public static Task chooseAppointmentDate(String date, String time) {
        return Task.where("choose Appointment Date",
                CommonWaitUntil.isVisible(InboundInventoryDetailLPPage.APPOINTMENT_DATE),
                Check.whether(date.isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(date, "MM/dd/yy")).into(InboundInventoryDetailLPPage.APPOINTMENT_DATE).thenHit(Keys.ENTER)),
                Check.whether(time.isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(InboundInventoryDetailLPPage.APPOINTMENT_TIME, InboundInventoryDetailLPPage.APPOINTMENT_TIME(time))
                ),
                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON("Update Appointment Date")),
                Click.on(CommonLPPage.DYNAMIC_BUTTON("Update Appointment Date"))
        );
    }

    public static Task removeAppointmentDate() {
        return Task.where("remove Appointment Date",
                CommonWaitUntil.isVisible(InboundInventoryDetailLPPage.APPOINTMENT_DATE),
                Check.whether(CommonQuestions.targetValue(theActorInTheSpotlight(), InboundInventoryDetailLPPage.APPOINTMENT_DATE).equalsIgnoreCase("")).otherwise(
                        MoveMouse.to(InboundInventoryDetailLPPage.APPOINTMENT_DATE),
                        WindowTask.threadSleep(100),
                        Click.on(InboundInventoryDetailLPPage.CLEAR_ICON)
                )
        );

    }

    public static Task removeAppointmentTime() {
        return Task.where("remove Appointment Time",
                CommonWaitUntil.isVisible(InboundInventoryDetailLPPage.APPOINTMENT_TIME),
                Check.whether(CommonQuestions.targetValue(theActorInTheSpotlight(), InboundInventoryDetailLPPage.APPOINTMENT_TIME).equalsIgnoreCase("")).otherwise(
                        MoveMouse.to(InboundInventoryDetailLPPage.APPOINTMENT_TIME),
                        WindowTask.threadSleep(100),
                        Click.on(InboundInventoryDetailLPPage.CLEAR_ICON)
                )
        );

    }

    public static Task editCaseInfo(Map<String, String> map) {
        return Task.where("edit Case Info",
                CommonWaitUntil.isVisible(InboundInventoryDetailLPPage.ITEM_CASES(map.get("lotCode"), "# of Cases Received")),
                Scroll.to(InboundInventoryDetailLPPage.ITEM_CASES(map.get("lotCode"), "# of Cases Received")),
                Check.whether(map.get("casesReceived").isEmpty()).otherwise(
                        Clear.field(InboundInventoryDetailLPPage.ITEM_CASES(map.get("lotCode"), "# of Cases Received")),
                        Enter.keyValues(map.get("casesReceived")).into(InboundInventoryDetailLPPage.ITEM_CASES(map.get("lotCode"), "# of Cases Received"))
                ),
                Check.whether(map.get("damagedCase").isEmpty()).otherwise(
                        Clear.field(InboundInventoryDetailLPPage.ITEM_CASES(map.get("lotCode"), "# of Damaged Cases")),
                        Enter.keyValues(map.get("damagedCase")).into(InboundInventoryDetailLPPage.ITEM_CASES(map.get("lotCode"), "# of Damaged Cases"))
                ),
                Check.whether(map.get("shortedCase").isEmpty()).otherwise(
                        Clear.field(InboundInventoryDetailLPPage.ITEM_CASES(map.get("lotCode"), "# of Shorted Cases")),
                        Enter.keyValues(map.get("shortedCase")).into(InboundInventoryDetailLPPage.ITEM_CASES(map.get("lotCode"), "# of Shorted Cases"))
                ),
                Check.whether(map.get("excessCases").isEmpty()).otherwise(
                        Clear.field(InboundInventoryDetailLPPage.ITEM_CASES(map.get("lotCode"), "# of Excess Cases")),
                        Enter.keyValues(map.get("excessCases")).into(InboundInventoryDetailLPPage.ITEM_CASES(map.get("lotCode"), "# of Excess Cases"))
                ),
                WindowTask.threadSleep(1000),
                Click.on(CommonLPPage.DYNAMIC_BUTTON3("Update"))
        );

    }

    public static Performable uploadInventoryImage(List<Map<String, String>> infos) {
        return Task.where("Upload inventory image",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                WindowTask.threadSleep(1000),
                                CommonWaitUntil.isVisible(CommonLPPage.DYNAMIC_BUTTON("Add an image")),
                                Click.on(CommonLPPage.DYNAMIC_BUTTON("Add an image")),
                                CommonWaitUntil.isVisible(InboundInventoryDetailLPPage.REMOVE_IMAGE_BUTTON(info.get("index"))),
                                CommonFile.upload2(info.get("image"), InboundInventoryDetailLPPage.IMAGE_INDEX(info.get("index"))),
                                Enter.theValue(info.get("description")).into(InboundInventoryDetailLPPage.DESCRIPTION_TEXTBOX(info.get("index"))),
                                Scroll.to(InboundInventoryDetailLPPage.UPDATE_IMAGES),
                                Click.on(InboundInventoryDetailLPPage.UPDATE_IMAGES),
                                CommonWaitUntil.isVisible(InboundInventoryDetailLPPage.INBOUND_INVENTORY_IMAGE_PREVIEW(info.get("description")))
                        );
                    }
                }
        );
    }

    public static Performable removeInventoryImage() {
        return Task.where("Remove inventory image",
                actor -> {
                    List<WebElementFacade> removeButton = InboundInventoryDetailLPPage.REMOVE_BUTTON.resolveAllFor(actor);
                    if (removeButton.size() > 0) {
                        for (WebElementFacade item : removeButton) {
                            actor.attemptsTo(
                                    Click.on(item),
                                    WindowTask.threadSleep(500)
                            );
                        }
                    }
                }
        );
    }

    public static Task completeWithdrawal() {
        return Task.where("Complete withdrawal request",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("COMPLETE")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("COMPLETE")),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Are you sure the inventory has been withdrawn completely? Once marked as complete, the request can't be edited.")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Yes")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Request marked as complete successfully."))
        );

    }
}

package cucumber.tasks.admin.claims;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.claims.AdminVendorClaimPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Clear;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HandleAdminVendorClaim {

    public static Task search(Map<String, String> info) {
        return Task.where("Go to create vendor claims",
                Check.whether(info.get("vendorCompany").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany")))
                        ),
                Check.whether(info.get("brand").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id"), info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("brand")))
                        ),
                Check.whether(info.get("vendor").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("vendor")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_name"))
                        ),
                Check.whether(info.get("managedBy").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput1(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("manager_id"), info.get("managedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("managedBy")))
                        ),
                Check.whether(info.get("status").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("status"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("status")))
                        ),
                Check.whether(info.get("claimNumber").equals(""))
                        .otherwise(
                                Enter.theValue(info.get("claimNumber")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number"))
                        ),
                Check.whether(info.get("startDate").equals(""))
                        .otherwise(
                                Enter.theValue(CommonHandle.setDate2(info.get("startDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("start_date")).thenHit(Keys.ENTER)
                        ),
                Check.whether(info.get("endDate").equals(""))
                        .otherwise(
                                Enter.theValue(CommonHandle.setDate2(info.get("endDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("end_date")).thenHit(Keys.ENTER)
                        ),

                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToCreateClaims() {
        return Task.where("Go to create vendor claims",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(AdminVendorClaimPage.TITLE_PAGE)
        );
    }

    public static Task fillInfoToCreate(Map<String, String> info) {
        return Task.where("Fill info to create",
                CommonTask.chooseItemInDropdownWithValueInput1(AdminVendorClaimPage.D_TEXTBOX_IN_CREATE("Vendors"), info.get("vendor"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendor"))),
                Check.whether(info.get("region").equals(""))
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput1(AdminVendorClaimPage.D_TEXTBOX_IN_CREATE("Region"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))),
                Click.on(AdminVendorClaimPage.ISSUE_VALUE_IN_CREATE(info.get("issue"))),
                Enter.theValue(info.get("issueDescription")).into(AdminVendorClaimPage.D_TEXTAREA_IN_CREATE("Issue Description")),
                Check.whether(info.get("adminNote").equals(""))
                        .otherwise(Enter.theValue(info.get("adminNote")).into(AdminVendorClaimPage.D_TEXTAREA_IN_CREATE("Admin note")))
        );
    }

    public static Performable uploadFile(List<Map<String, String>> infos) {
        return Task.where("Fill info to create",
                actor -> {
                    for (int i = 0; i < infos.size(); i++) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.REMOVE_UPLOAD_IN_CREATE(i + 1)),
                                CommonFile.upload2(infos.get(i).get("uploadFile"), AdminVendorClaimPage.UPLOAD_FILE_IN_CREATE(i + 1))
                        );
                    }
                }
        );
    }

    public static Task goToAddSkuToCreate() {
        return Task.where("Go to add sku to create",
                Click.on(AdminVendorClaimPage.TYPE_VALUE_IN_CREATE("SKU(s)")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add SKUs-specific"))
        );
    }

    public static Performable addSKUToCreate(List<Map<String, String>> infos) {
        return Task.where("Add SKU to create",
                actor -> {
                    for (Map<String, String> info : infos) {
                        // add sku
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add SKUs-specific")),
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.SELECT_LINE_ITEM_POPUP),
                                Enter.theValue(info.get("sku")).into(AdminVendorClaimPage.TEXTBOX_IN_SELECT_ITEM_POPUP),
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.ITEM_IN_SELECT_LINE_ITEM_POPUP(info.get("sku"))),
                                Click.on(AdminVendorClaimPage.ITEM_IN_SELECT_LINE_ITEM_POPUP(info.get("sku"))),
                                CommonWaitUntil.isNotVisible(AdminVendorClaimPage.SELECT_LINE_ITEM_POPUP),
                                // edit quantity
                                Check.whether(info.get("quantity").equals(""))
                                        .otherwise(
                                                CommonWaitUntil.isVisible(AdminVendorClaimPage.SKU_ITEM_IN_CREATE(info.get("sku"))),
                                                Clear.field(AdminVendorClaimPage.SKU_QUANTITY_TEXTBOX_IN_CREATE(info.get("sku"))),
                                                Enter.theValue(info.get("quantity")).into(AdminVendorClaimPage.SKU_QUANTITY_TEXTBOX_IN_CREATE(info.get("sku"))).thenHit(Keys.ENTER)
                                        ),
                                WindowTask.threadSleep(1000)
                        );
                    }
                }
        );
    }

    public static Performable removeSKUToCreate(List<Map<String, String>> infos) {
        return Task.where("Remove SKU to create",
                actor -> {
                    for (Map<String, String> info : infos) {
                        // add sku
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.DELETE_SKU_IN_CREATE(info.get("sku"))),
                                Click.on(AdminVendorClaimPage.DELETE_SKU_IN_CREATE(info.get("sku"))),
                                CommonWaitUntil.isNotVisible(AdminVendorClaimPage.DELETE_SKU_IN_CREATE(info.get("sku")))
                        );
                    }
                }
        );
    }

    public static Task createClaimSuccess() {
        return Task.where("Create vendor claim success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")).afterWaitingUntilEnabled(),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task createClaimSeeMessage(String message) {
        return Task.where("Create vendor claim success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    public static Task goToDetail(String claimNumber) {
        return Task.where("Go to vendor claim detail",
                CommonWaitUntil.isVisible(AdminVendorClaimPage.CLAIM_NUMBER_RESULT(claimNumber)),
                Click.on(AdminVendorClaimPage.CLAIM_NUMBER_RESULT(claimNumber)).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(AdminVendorClaimPage.GENERAL_INFORMATION_LABEL)
        );
    }

    public static Task changeStatus(String status) {
        return Task.where("Change status claim",
                CommonTaskAdmin.changeValueTooltipDropdown(AdminVendorClaimPage.STATUS_GENERAL_INFO, status)
        );
    }

    public static Performable addOrderToCreate(List<Map<String, String>> infos) {
        return Task.where("Add Order to create",
                actor -> {
                    actor.attemptsTo(
                            Click.on(AdminVendorClaimPage.TYPE_VALUE_IN_CREATE("Order(s)")),
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add Orders-specific"))
                    );
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> item = CommonTask.setValue2(info, "order", info.get("order"), Serenity.sessionVariableCalled("Number Order API" + info.get("index")).toString(), "create by api");

                        // add order
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add Orders-specific")),
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.SELECT_ORDER_POPUP),
                                Enter.theValue(item.get("order")).into(AdminVendorClaimPage.TEXTBOX_IN_SELECT_ITEM_POPUP),
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.ITEM_IN_SELECT_ORDER_POPUP(item.get("order"))),
                                Click.on(AdminVendorClaimPage.ITEM_IN_SELECT_ORDER_POPUP(item.get("order"))),
                                CommonWaitUntil.isNotVisible(AdminVendorClaimPage.SELECT_ORDER_POPUP)
                        );
                    }
                }
        );
    }

    public static Performable editLineItemOrder(List<Map<String, String>> infos) {
        return Task.where("Edit line item of order",
                actor -> {
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> item = CommonTask.setValue2(info, "order", info.get("order"), Serenity.sessionVariableCalled("Number Order API" + info.get("index")).toString(), "create by api");

                        // add order
                        actor.attemptsTo(
                                // edit quantity of line item
                                Check.whether(info.get("quantity").equals(""))
                                        .otherwise(
                                                CommonWaitUntil.isVisible(AdminVendorClaimPage.SKU_QUANTITY_ITEM_IN_CREATE(item.get("order"), item.get("sku"))),
                                                Clear.field(AdminVendorClaimPage.SKU_QUANTITY_ITEM_IN_CREATE(item.get("order"), item.get("sku"))),
                                                Enter.theValue(info.get("quantity")).into(AdminVendorClaimPage.SKU_QUANTITY_ITEM_IN_CREATE(item.get("order"), item.get("sku"))).thenHit(Keys.ENTER)
                                        ),
                                WindowTask.threadSleep(1000)
                        );
                    }
                }
        );
    }

    public static Performable removeOrderToCreate(List<Map<String, String>> infos) {
        return Task.where("Remove Order to create",
                actor -> {
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> item = CommonTask.setValue2(info, "order", info.get("order"), Serenity.sessionVariableCalled("Number Order API" + info.get("index")).toString(), "create by api");

                        // add sku
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.DELETE_ITEM_IN_CREATE(item.get("order"))),
                                Click.on(AdminVendorClaimPage.DELETE_ITEM_IN_CREATE(item.get("order"))),
                                CommonWaitUntil.isNotVisible(AdminVendorClaimPage.DELETE_ITEM_IN_CREATE(item.get("order")))
                        );
                    }
                }
        );
    }

    public static Performable addInboundToCreate(List<Map<String, String>> infos) {
        return Task.where("Add Inbound to create",
                actor -> {
                    actor.attemptsTo(
                            Click.on(AdminVendorClaimPage.TYPE_VALUE_IN_CREATE("Inbound Inventory(s)")),
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add Inbound Inventory"))
                    );
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> item = CommonTask.setValue2(info, "inbound", info.get("inbound"), Serenity.sessionVariableCalled("Number Inbound Inventory api" + info.get("index")).toString(), "create by api");

                        // add sku
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add Inbound Inventory")),
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.SELECT_INBOUND_POPUP),
                                Enter.theValue(item.get("inbound")).into(AdminVendorClaimPage.TEXTBOX_IN_SELECT_ITEM_POPUP),
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.ITEM_IN_SELECT_ORDER_POPUP(item.get("inbound"))),
                                Click.on(AdminVendorClaimPage.ITEM_IN_SELECT_ORDER_POPUP(item.get("inbound"))),
                                CommonWaitUntil.isNotVisible(AdminVendorClaimPage.SELECT_INBOUND_POPUP)
                        );
                    }
                }
        );
    }

    public static Performable editInboundOrder(List<Map<String, String>> infos) {
        return Task.where("Edit quantity of inbound",
                actor -> {
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> item = CommonTask.setValue2(info, "inbound", info.get("inbound"), Serenity.sessionVariableCalled("Number Inbound Inventory api" + info.get("index")).toString(), "create by api");

                        // add order
                        actor.attemptsTo(
                                // edit quantity of line item
                                Check.whether(info.get("quantity").equals(""))
                                        .otherwise(
                                                CommonWaitUntil.isVisible(AdminVendorClaimPage.SKU_QUANTITY_ITEM_IN_CREATE(item.get("inbound"), item.get("sku"))),
                                                Clear.field(AdminVendorClaimPage.SKU_QUANTITY_ITEM_IN_CREATE(item.get("inbound"), item.get("sku"))),
                                                Enter.theValue(info.get("quantity")).into(AdminVendorClaimPage.SKU_QUANTITY_ITEM_IN_CREATE(item.get("inbound"), item.get("sku"))).thenHit(Keys.ENTER)
                                        ),
                                WindowTask.threadSleep(1000)
                        );
                    }
                }
        );
    }

    public static Performable removeInboundToCreate(List<Map<String, String>> infos) {
        return Task.where("Remove Inbound to create",
                actor -> {
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> item = CommonTask.setValue2(info, "inbound", info.get("inbound"), Serenity.sessionVariableCalled("Number Inbound Inventory api" + info.get("index")).toString(), "create by api");

                        // add sku
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.DELETE_ITEM_IN_CREATE(item.get("inbound"))),
                                Click.on(AdminVendorClaimPage.DELETE_ITEM_IN_CREATE(item.get("inbound"))),
                                CommonWaitUntil.isNotVisible(AdminVendorClaimPage.DELETE_ITEM_IN_CREATE(item.get("inbound")))
                        );
                    }
                }
        );
    }

    public static Task editGeneralInfoDetail(Map<String, String> info) {
        return Task.where("Edit general information of detail",
                Check.whether(info.get("region").equals(""))
                        .otherwise(
                                CommonTaskAdmin.changeValueTooltipDropdownWithInput(AdminVendorClaimPage.REGION_GENERAL_INFO, info.get("region"))),
                Check.whether(info.get("issue").equals(""))
                        .otherwise(
                                CommonTaskAdmin.changeValueTooltipDropdown(AdminVendorClaimPage.ISSUE_GENERAL_INFO, info.get("issue"))),
                Check.whether(info.get("issueDescription").equals(""))
                        .otherwise(
                                CommonTaskAdmin.changeValueTooltipTextbox(AdminVendorClaimPage.ISSUE_DESCRIPTION_GENERAL_INFO, info.get("issueDescription"))),
                Check.whether(info.get("adminNote").equals(""))
                        .otherwise(
                                CommonTaskAdmin.changeValueTooltipTextbox(AdminVendorClaimPage.ADMIN_NOTE_GENERAL_INFO, info.get("adminNote")))
        );
    }

    public static Task deleteClaim(String claimNumber) {
        return Task.where("Delete vendor claim in result",
                CommonWaitUntil.isVisible(AdminVendorClaimPage.DELETE_RESULT(claimNumber)),
                Click.on(AdminVendorClaimPage.DELETE_RESULT(claimNumber)).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("This will permanently delete this record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Understand & Continue")),
                CommonWaitUntil.isNotVisible(AdminVendorClaimPage.DELETE_RESULT(claimNumber))
        );
    }

    public static Performable addInboundInDetail(List<Map<String, String>> infos) {
        return Task.where("Add Inbound in detail",
                actor -> {
                    // Change type of detail
                    actor.attemptsTo(
                            CommonTaskAdmin.changeValueTooltipDropdown(AdminVendorClaimPage.TYPE_GENERAL_INFO, "Inbound Inventory(s)")
                    );
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> item = CommonTask.setValue2(info, "inbound", info.get("inbound"), Serenity.sessionVariableCalled("Number Inbound Inventory api" + info.get("index")).toString(), "create by api");

                        // add sku
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add Inbound Inventory")),
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.SELECT_INBOUND_POPUP),
                                Enter.theValue(item.get("inbound")).into(AdminVendorClaimPage.TEXTBOX_IN_SELECT_ITEM_POPUP),
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.ITEM_IN_SELECT_ORDER_POPUP(item.get("inbound"))),
                                Click.on(AdminVendorClaimPage.ITEM_IN_SELECT_ORDER_POPUP(item.get("inbound"))),
                                CommonWaitUntil.isNotVisible(AdminVendorClaimPage.SELECT_INBOUND_POPUP)
                        );
                    }
                }
        );
    }

    public static Task save() {
        return Task.where("Save in detail",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")).afterWaitingUntilEnabled(),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON_DISABLE("Save"))

        );
    }

    public static Performable assignedTo(List<Map<String, String>> infos) {
        return Task.where("Assigned to",
                actor -> {
                    for (int i = 0; i < infos.size(); i++) {
                        actor.attemptsTo(
                                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add Admin")),
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add Admin")),
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.ASSIGNED_TO_FIELD(i + 1)),
                                CommonTaskAdmin.changeValueTooltipDropdownWithInput(AdminVendorClaimPage.ASSIGNED_TO_FIELD(i + 1), infos.get(i).get("assigned")),
                                WindowTask.threadSleep(1000)
                        );
                    }
                }
        );
    }

    public static Performable addOrderInDetail(List<Map<String, String>> infos) {
        return Task.where("Add Order in detail",
                actor -> {
                    // Change type of detail
                    actor.attemptsTo(
                            CommonTaskAdmin.changeValueTooltipDropdown(AdminVendorClaimPage.TYPE_GENERAL_INFO, "SKU(s)")
                    );
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> item = CommonTask.setValue2(info, "order", info.get("order"), Serenity.sessionVariableCalled("Number Order API" + info.get("index")).toString(), "create by api");

                        // add order
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add Orders-specific")),
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.SELECT_ORDER_POPUP),
                                Enter.theValue(item.get("order")).into(AdminVendorClaimPage.TEXTBOX_IN_SELECT_ITEM_POPUP),
                                CommonWaitUntil.isVisible(AdminVendorClaimPage.ITEM_IN_SELECT_ORDER_POPUP(item.get("order"))),
                                Click.on(AdminVendorClaimPage.ITEM_IN_SELECT_ORDER_POPUP(item.get("order"))),
                                CommonWaitUntil.isNotVisible(AdminVendorClaimPage.SELECT_ORDER_POPUP)
                        );
                    }
                }
        );
    }

}

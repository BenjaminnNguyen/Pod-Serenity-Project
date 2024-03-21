package cucumber.tasks.vendor.inventory;

import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.inventory.VendorDisposeDonatePage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HandleVendorInventoryRequest {

    public static Task goToDisposeDonatePage() {
        return Task.where("Go to dispose donate inventory page",
                CommonWaitUntil.isVisible(VendorDisposeDonatePage.DISPOSE_DONATE_INVENTORY_TAB),
                Click.on(VendorDisposeDonatePage.DISPOSE_DONATE_INVENTORY_TAB),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING)
        );
    }

    public static Task goToTab(String type) {
        return Task.where("Go to tab in dispose donate inventory page",
                CommonWaitUntil.isVisible(VendorDisposeDonatePage.DISPOSE_DONATE_INVENTORY_SUB_TAB(type)),
                Click.on(VendorDisposeDonatePage.DISPOSE_DONATE_INVENTORY_SUB_TAB(type)),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING)
        );
    }

    public static Task goToCreateRequest() {
        return Task.where("Go to create request dispose donate inventory",
                CommonWaitUntil.isVisible(VendorDisposeDonatePage.CREATE_REQUEST_BUTTON),
                Click.on(VendorDisposeDonatePage.CREATE_REQUEST_BUTTON),
                CommonWaitUntil.isVisible(VendorDisposeDonatePage.REQUEST_TITLE)
        );
    }

    public static Task fillInfoRequest(Map<String, String> info) {
        return Task.where("fill info request",
                CommonWaitUntil.isVisible(VendorDisposeDonatePage.DISPOSE_OR_DONATE_TEXTBOX),
                Check.whether(info.get("type").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(VendorDisposeDonatePage.DISPOSE_OR_DONATE_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("type")))
                ),
                Check.whether(info.get("region").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown1(VendorDisposeDonatePage.REGION_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))
                ),
                Check.whether(info.get("comment").isEmpty())
                        .otherwise(Enter.theValue(info.get("comment")).into(VendorDisposeDonatePage.COMMENT_TEXTBOX))
        );
    }

    public static Performable addInventory(List<Map<String, String>> infos) {
        return Task.where("add inventory",
                actor -> {
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> temp = CommonTask.setValueRandom(info, "lotCode", Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")));
                        actor.attemptsTo(
                                // add inventory
                                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add new inventory")),
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add new inventory")),
                                CommonWaitUntil.isVisible(VendorDisposeDonatePage.ADD_NEW_INVENTORY_POPUP),
                                Enter.theValue(temp.get("lotCode")).into(VendorDisposeDonatePage.ADD_NEW_INVENTORY_TEXTBOX),
                                CommonWaitUntil.isVisible(VendorDisposeDonatePage.INVENTORY_LOTCODE(temp.get("lotCode"))),
                                Click.on(VendorDisposeDonatePage.INVENTORY_SELECT_CHECKBOX(temp.get("lotCode"))),
                                Click.on(VendorDisposeDonatePage.ADD_NEW_INVENTORY_BUTTON).afterWaitingUntilEnabled(),
                                CommonWaitUntil.isNotVisible(VendorDisposeDonatePage.ADD_NEW_INVENTORY_POPUP),
                                // Edit # of case
                                Check.whether(temp.get("quantity").equals("max"))
                                        .andIfSo(Click.on(VendorDisposeDonatePage.INVENTORY_MAX_CASE_TEXTBOX(temp.get("lotCode"))))
                                        .otherwise(Enter.theValue(temp.get("quantity")).into(VendorDisposeDonatePage.INVENTORY_OF_CASE_TEXTBOX(temp.get("lotCode"))))
                        );
                    }
                }
        );
    }

    public static Performable editItem(List<Map<String, String>> infos) {
        return Task.where("edit item inventory",
                actor -> {
                    for (Map<String, String> info : infos) {
                        HashMap<String, String> temp = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code" + info.get("sku") + info.get("index")), "random");
                        actor.attemptsTo(
                                // Edit # of case
                                Check.whether(temp.get("ofCases").equals("max"))
                                        .andIfSo(Click.on(VendorDisposeDonatePage.INVENTORY_MAX_CASE_TEXTBOX(temp.get("lotCode"))))
                                        .otherwise(Enter.theValue(temp.get("ofCases")).into(VendorDisposeDonatePage.INVENTORY_OF_CASE_TEXTBOX(temp.get("lotCode"))))
                        );
                    }
                }
        );
    }

    public static Task addInventorySuccess() {
        return Task.where("Add inventory success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Thank you for filling out the inventory disposal / donation form. Your request is under review and Pod Foods will reach out to you shortly.")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("OK")),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING),
                CommonWaitUntil.isVisible(VendorDisposeDonatePage.REQUEST_STATUS)
        );
    }

    public static Task goToDetail(String number) {
        return Task.where("Go to detail inventory request",
                CommonWaitUntil.isVisible(VendorDisposeDonatePage.RESULT_NUMBER(number)),
                Click.on(VendorDisposeDonatePage.RESULT_NUMBER(number)),
                CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING)
        );
    }
}

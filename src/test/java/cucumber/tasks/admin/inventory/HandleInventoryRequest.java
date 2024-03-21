package cucumber.tasks.admin.inventory;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.disposeDonateRequest.InventoryRequestPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import org.openqa.selenium.Keys;

import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleInventoryRequest {

    public static Task search(Map<String, String> info) {
        return Task.where("Search dispose donate request",
                Check.whether(info.get("number").isEmpty()).otherwise(
                        Enter.theValue(info.get("number")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number"))),
                Check.whether(info.get("vendorCompany").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("vendorCompany")))),
                Check.whether(info.get("brand").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id"), info.get("brand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("brand")))),
                Check.whether(info.get("region").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("region")))),
                Check.whether(info.get("type").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("request_type"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("type")))),
                Check.whether(info.get("status").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdown1(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("status"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("status")))),
                Check.whether(info.get("startDate").isEmpty())
                        .otherwise(
                                Enter.theValue(CommonHandle.setDate2(info.get("startDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("start_date")).thenHit(Keys.ENTER)),
                Check.whether(info.get("endDate").isEmpty())
                        .otherwise(
                                Enter.theValue(CommonHandle.setDate2(info.get("endDate"), "MM/dd/yy")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("end_date")).thenHit(Keys.ENTER)),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task goToCreate() {
        return Task.where("Go to creat inventory request",
                CommonWaitUntil.isVisible(InventoryRequestPage.CREATE_REQUEST_BUTTON),
                Click.on(InventoryRequestPage.CREATE_REQUEST_BUTTON),
                CommonWaitUntil.isVisible(InventoryRequestPage.CREATE_FORM_HEADER)
        );
    }

    public static Task create(Map<String, String> info) {
        return Task.where("Create inventory request",
                CommonWaitUntil.isVisible(InventoryRequestPage.VENDOR_COMPANY_TEXTBOX),
                CommonTask.chooseItemInDropdownWithValueInput1(InventoryRequestPage.VENDOR_COMPANY_TEXTBOX, info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany"))),
                CommonTask.chooseItemInDropdownWithValueInput1(InventoryRequestPage.REGION_TEXTBOX, info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region"))),
                Click.on(InventoryRequestPage.TYPE_CHECKBOX(info.get("type"))),
                Enter.theValue(info.get("note")).into(InventoryRequestPage.COMMENT_TEXTAREA)
        );
    }

    public static Task editNew(Map<String, String> info) {
        return Task.where("Create inventory request",
                Check.whether(info.get("vendorCompany").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput1(InventoryRequestPage.VENDOR_COMPANY_TEXTBOX, info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorCompany")))
                ),
                Check.whether(info.get("region").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput1(InventoryRequestPage.REGION_TEXTBOX, info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("region")))
                ),
                Check.whether(info.get("type").isEmpty()).otherwise(
                        Click.on(InventoryRequestPage.TYPE_CHECKBOX(info.get("type")))
                ),
                Check.whether(info.get("note").isEmpty()).otherwise(
                        Enter.theValue(info.get("note")).into(InventoryRequestPage.COMMENT_TEXTAREA)
                )
        );
    }

    public static Task goToAddInventory() {
        return Task.where("Add inventory",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add pullable Inventory")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add pullable Inventory")),
                CommonWaitUntil.isVisible(InventoryRequestPage.ADD_PULLABLE_INVENTORY_POPUP)
        );
    }

    public static Task searchPullAbleInventory(Map<String, String> info) {
        return Task.where("Search pull able  inventory to add",
                CommonWaitUntil.isVisible(InventoryRequestPage.D_ADD_LOTCODE("Vendor brand")),
                Check.whether(info.get("vendorBrand").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput1(InventoryRequestPage.D_ADD_LOTCODE("Vendor brand"), info.get("vendorBrand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("vendorBrand")))
                ),
                Check.whether(info.get("sku").isEmpty()).otherwise(
                        Enter.theValue(info.get("sku")).into(InventoryRequestPage.D_ADD_LOTCODE("SKU name"))
                ),
                Check.whether(info.get("product").isEmpty()).otherwise(
                        Enter.theValue(info.get("product")).into(InventoryRequestPage.D_ADD_LOTCODE("Product name"))
                ),
                Check.whether(info.get("lotCode").isEmpty()).otherwise(
                        Enter.theValue(info.get("lotCode")).into(InventoryRequestPage.D_ADD_LOTCODE("Lot code"))
                ),
                Click.on(InventoryRequestPage.SEARCH_LOT_CODE_BUTTON)
        );
    }

    public static Task addLotcodeAfterSearch(Map<String, String> map) {
        return Task.where("Search lot code to add",
                CommonWaitUntil.isVisible(InventoryRequestPage.FIRST_LOT_CODE),
                // Choose inventory with lotcode in result
                Click.on(InventoryRequestPage.LOT_CODE_CHECKBOX(map.get("lotCode"))),
                Click.on(InventoryRequestPage.ADD_LOT_CODE_BUTTON_IN_POPUP),
                CommonWaitUntil.isVisible(InventoryRequestPage.CASES(map.get("lotCode"))),
                WindowTask.threadSleep(1000),
                Check.whether(map.get("quantity").isEmpty()).otherwise(
                        Enter.theValue(map.get("quantity")).into(InventoryRequestPage.CASES(map.get("lotCode")))
                )
        );
    }


    public static Task createSuccess() {
        return Task.where("Create inventory request success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("Inventory requests has been created successfully !!"))
        );
    }

    public static Task createError(String message) {
        return Task.where("Create inventory request success",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE(message))
        );
    }

    public static Task removeInventory(Map<String, String> info) {
        return Task.where("Remove pullable inventory",
                CommonWaitUntil.isVisible(InventoryRequestPage.REMOVE_INVENTORY_BUTTON(info.get("lotCode"))),
                Scroll.to(InventoryRequestPage.REMOVE_INVENTORY_BUTTON(info.get("lotCode"))),
                Click.on(InventoryRequestPage.REMOVE_INVENTORY_BUTTON(info.get("lotCode"))),
                CommonWaitUntil.isNotVisible(InventoryRequestPage.REMOVE_INVENTORY_BUTTON(info.get("lotCode")))
        );
    }

    public static Task saveAction() {
        return Task.where("Remove pullable inventory",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Pullable inventories has been updated successfully !!")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)
        );
    }
}

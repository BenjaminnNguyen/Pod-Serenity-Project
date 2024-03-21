package cucumber.tasks.admin.inventory;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.AllInventoryPage;
import cucumber.user_interface.admin.inventory.IncomingInventoryDetailPage;
import cucumber.user_interface.admin.inventory.IncomingInventoryPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleIncomingInventory {

    public static Task searchIncomingInventory(Map<String, String> info) {
        Task task = Task.where("Search inventory",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Check.whether(info.get("number").isEmpty()).otherwise(
                        Enter.theValue(info.get("number")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("number"))
                ),
                Check.whether(!info.get("vendorCompany").isEmpty())
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("vendorCompany")))
                        ),
                Check.whether(!info.get("vendorBrand").isEmpty())
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id"), info.get("vendorBrand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("vendorBrand")))
                        ),
                Check.whether(!Objects.equals(info.get("region"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("region")))
                        ),
                Check.whether(!Objects.equals(info.get("initiatedBy"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("creator_type"), info.get("initiatedBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("initiatedBy")))
                        ),
                Check.whether(info.get("status").isEmpty())
                        .otherwise(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("status"), info.get("status"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("status"))),
                                Hit.the(Keys.ESCAPE).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("status"))
                        ),
                Check.whether(!Objects.equals(info.get("startDate"), ""))
                        .andIfSo(
                                Enter.theValue(info.get("startDate")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("start_date")).thenHit(Keys.ENTER)
                        ),
                Check.whether(!Objects.equals(info.get("endDate"), ""))
                        .andIfSo(
                                Enter.theValue(info.get("endDate")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("end_date")).thenHit(Keys.ENTER)
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
        if (info.containsKey("warehouse")) {
            task.then(
                    Check.whether(info.get("warehouse").isEmpty()).otherwise(
                            CommonTask.chooseItemInDropdownWithValueInput(
                                    CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[warehouse_id]"), info.get("warehouse"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("warehouse")))
                    )
            );
        }
        if (info.containsKey("lpReview")) {
            task.then(
                    Check.whether(info.get("lpReview").isEmpty()).otherwise(
                            CommonTask.chooseItemInDropdown(
                                    CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[lp_review]"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("lpReview")))
                    )
            );
        }
        if (info.containsKey("below75")) {
            task.then(
                    Check.whether(info.get("below75").isEmpty()).otherwise(
                            CommonTask.chooseItemInDropdown(
                                    CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[below_threshold]"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("below75")))
                    )
            );
        }
        if (info.containsKey("freightCarrier")) {
            task.then(
                    Check.whether(info.get("freightCarrier").isEmpty()).otherwise(
                            Enter.theValue(info.get("freightCarrier")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[freight_carrier]")))
            );
        }
        if (info.containsKey("freightCarrier")) {
            task.then(
                    Check.whether(info.get("freightCarrier").isEmpty()).otherwise(
                            Enter.theValue(info.get("freightCarrier")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[freight_carrier]")))
            );
        }
        if (info.containsKey("referenceNumber")) {
            task.then(
                    Check.whether(info.get("referenceNumber").isEmpty()).otherwise(
                            Enter.theValue(info.get("referenceNumber")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[reference_number]")))
            );
        }
        if (info.containsKey("trackingNumber")) {
            task.then(
                    Check.whether(info.get("trackingNumber").isEmpty()).otherwise(
                            Enter.theValue(info.get("trackingNumber")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("q[tracking_number]")))
            );
        }
        if (info.containsKey("itemPerPage")) {
            task.then(
                    Check.whether(info.get("itemPerPage").isEmpty()).otherwise(
                            Enter.theValue(info.get("itemPerPage")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("per_page")))
            );
        }
        return Task.where("Search inventory",
                task, Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER));
    }

    public static Task create(Map<String, String> info) {
        return Task.where("Create inventory",
                Click.on(AllInventoryPage.CREATE_BUTTON),
                CommonTask.chooseItemInDropdownWithValueInput(
                        AllInventoryPage.DYNAMIC_FIELD("warehouse_id"), info.get("distribution"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("distribution"))),
                CommonTask.chooseItemInDropdownWithValueInput(
                        AllInventoryPage.DYNAMIC_FIELD("product_variant_id"), info.get("sku"), AllInventoryPage.SKU_VALUE),
                Enter.theValue(info.get("quantity")).into(AllInventoryPage.QUALITY_TEXTBOX),
                Enter.theValue(info.get("lotCode")).into(AllInventoryPage.DYNAMIC_FIELD("lot_code")),
                Enter.theValue(CommonHandle.setDate(info.get("receiveDate"), "MM/dd/yy")).into(AllInventoryPage.DYNAMIC_FIELD("receive_date")).thenHit(Keys.ENTER),
                Click.on(AllInventoryPage.CREATE_BUTTON_IN_POPUP)
        );
    }

    public static Task createIncomingGeneral(Map<String, String> info) {
        return Task.where("Create incoming inventory input general",
//                Check.whether(CommonQuestions.isControlDisplay(AllInventoryPage.CREATE_BUTTON)).otherwise(
                Click.on(AllInventoryPage.CREATE_BUTTON),
//                ),
                Check.whether(info.get("vendorCompany").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                IncomingInventoryPage.CREATE_VENDOR_COMPANY, info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("vendorCompany")))
                ),
                Check.whether(info.get("region").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                IncomingInventoryPage.CREATE_REGION, info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("region")))
                ),
                Check.whether(info.get("warehouse").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                IncomingInventoryPage.CREATE_WAREHOUSE, info.get("warehouse"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("warehouse")))
                ),
                Check.whether(info.get("ofPallet").isEmpty()).otherwise(
                        Enter.keyValues(info.get("ofPallet")).into(IncomingInventoryPage.CREATE_OF_PALLET)
                ),
                Check.whether(info.get("estimatedWeek").isEmpty()).otherwise(
                        Enter.keyValues(info.get("estimatedWeek")).into(IncomingInventoryPage.ESTIMATED_WEEK_TEXTBOX)
                ),
                Check.whether(info.get("note").isEmpty()).otherwise(
                        Enter.keyValues(info.get("note")).into(IncomingInventoryPage.NOTE_TEXTAREA)
                ),
                Check.whether(info.get("adminNote").isEmpty()).otherwise(
                        Enter.keyValues(info.get("adminNote")).into(IncomingInventoryPage.ADMIN_NOTE_TEXTAREA)
                )

        );
    }

    public static Task createIncomingSKU(Map<String, String> info) {
        return Task.where("Create incoming inventory add skus",
                Click.on(IncomingInventoryPage.CREATE_ADD_SKU),
                CommonWaitUntil.isVisible(IncomingInventoryPage.CREATE_ADD_SKU_SEARCH_FIELD),
                Enter.theValue(info.get("sku")).into(IncomingInventoryPage.CREATE_ADD_SKU_SEARCH_FIELD),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.SKU_IN_POPUP_ADD(info.get("sku"))),
                Click.on(IncomingInventoryDetailPage.SKU_IN_POPUP_ADD(info.get("sku"))),
                Check.whether(CommonQuestions.isControlDisplay(IncomingInventoryPage.CONFIRM_ADD_SKU_AGAIN)).andIfSo(
                        Click.on(IncomingInventoryPage.CONFIRM_ADD_SKU_AGAIN)
                ),
                CommonWaitUntil.isNotVisible(IncomingInventoryPage.CREATE_ADD_SKU_SEARCH_FIELD),
                Check.whether(info.get("ofCase").isEmpty()).otherwise(
                        Enter.theValue(info.get("ofCase")).into(IncomingInventoryPage.CREATE_ADD_SKU_OF_CASE)
                )
        );
    }

    public static Task searchSKU(String sku) {
        return Task.where("Search an check skus",
                CommonWaitUntil.isVisible(IncomingInventoryPage.CREATE_ADD_SKU_SEARCH_FIELD),
                Enter.theValue(sku).into(IncomingInventoryPage.CREATE_ADD_SKU_SEARCH_FIELD).thenHit(Keys.ENTER)
        );
    }

    public static Task goToDetail(String number) {
        return Task.where("go To Detail inventory " + number,
                CommonWaitUntil.isVisible(IncomingInventoryPage.NUMBER(number)),
                Click.on(IncomingInventoryPage.NUMBER(number)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task chooseDistribution(String distribution) {
        return Task.where("",
                Click.on(IncomingInventoryDetailPage.WAREHOUSE_FIELD),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.UPDATE_WAREHOUSE),
                Click.on(IncomingInventoryDetailPage.UPDATE_SELECT),
                CommonTask.ChooseValueFromSuggestions(distribution),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.UPDATE_WAREHOUSE),
                Click.on(IncomingInventoryDetailPage.UPDATE_WAREHOUSE),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isNotVisible(IncomingInventoryDetailPage.LOADING_ICON)
        );
    }

    public static Task chooseWarehouse(String warehouse) {
        return Task.where("Change Status Incoming Inventory",
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.WAREHOUSE_FIELD1),
                Click.on(IncomingInventoryDetailPage.WAREHOUSE_FIELD1),
                CommonTask.chooseItemInDropdownWithValueInput(IncomingInventoryDetailPage.WAREHOUSE_DROPDOWN,
                        "Auto Ngoc Distribution CHI", CommonAdminForm.DYNAMIC_ITEM_DROPDOWN("Auto Ngoc Distribution CHI")),
                Click.on(IncomingInventoryDetailPage.UPDATE_WAREHOUSE),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task approve() {
        return Task.where("Approve incoming inventory",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Approve")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Approve")),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.POPUP_CONFIRM_APPROVE),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("OK")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ALERT("Inventory has been approved successfully!")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)

        );
    }

    public static Task process() {
        return Task.where("Process Incoming Inventory",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Process")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("Are you sure that you want to process this incoming inventory?")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("OK")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ALERT("Inventory has been proccessed successfully!")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task processError() {
        return Task.where("Process Incoming Inventory Error",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Process")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("Please choose warehouse for all skus")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task submitIncomingInventory() {
        return Task.where("Submit Incoming Inventory",
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Submit")),
//                Loading popup submit thành công
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
//                Loading lại page detail của incoming inventory
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ALERT("Inventory has been confirmed successfully!")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_CLOSE_BUTTON),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)

        );
    }

    public static Task uploadPODIncomingInventory() {
        return Task.where("Submit Incoming Inventory",
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON)

        );
    }

    public static Task fillInfoInSubmitForm(Map<String, String> info) {
        return Task.where("Fill info to Submit Incoming Inventory form",
                CommonTask.chooseItemInDropdown(IncomingInventoryDetailPage.D_TEXTBOX("inventory-delivery-method"), IncomingInventoryDetailPage.D_ITEM_IN_SUBMIT(info.get("deliveryMethod"))),
                Clear.field(IncomingInventoryDetailPage.ESTIMATE_DATE_OF_ARRIVAL),
                Enter.keyValues(CommonHandle.setDate2(info.get("estimateDate"), "MM/dd/yy")).into(IncomingInventoryDetailPage.ESTIMATE_DATE_OF_ARRIVAL).thenHit(Keys.ENTER),
                Clear.field(IncomingInventoryDetailPage.D_TEXTBOX("num-pallet")),
                Enter.keyValues(info.get("ofPallets")).into(IncomingInventoryDetailPage.D_TEXTBOX("num-pallet")),
                Clear.field(IncomingInventoryDetailPage.D_TEXTBOX("retail-per-master-carton")),
                Enter.keyValues(info.get("ofSellAble")).into(IncomingInventoryDetailPage.D_TEXTBOX1("# of Sellable Retail Cases per Master Carton")),
                Clear.field(IncomingInventoryDetailPage.D_TEXTBOX("total-weight")),
                Enter.keyValues(info.get("totalWeight")).into(IncomingInventoryDetailPage.D_TEXTBOX("total-weight")),
                Clear.field(IncomingInventoryDetailPage.D_TEXTBOX("zip-code")),
                Enter.keyValues(info.get("zipCode")).into(IncomingInventoryDetailPage.D_TEXTBOX("zip-code"))
        );
    }

    public static Task fillInfoInSubmitForm2(Map<String, String> info) {
        return Task.where("Fill info to Submit Incoming Inventory form",
                Check.whether(info.get("deliveryMethod").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(IncomingInventoryDetailPage.D_TEXTBOX("inventory-delivery-method"), IncomingInventoryDetailPage.D_ITEM_IN_SUBMIT(info.get("deliveryMethod")))
                ),
                Check.whether(info.get("estimatedDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("estimatedDate"), "MM/dd/yy")).into(IncomingInventoryDetailPage.ESTIMATE_DATE_OF_ARRIVAL).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("ofPallets").isEmpty()).otherwise(
                        Enter.theValue(info.get("ofPallets")).into(IncomingInventoryDetailPage.D_TEXTBOX("num-pallet"))
                ),
                Check.whether(info.get("ofSellAble").isEmpty()).otherwise(
                        Enter.theValue(info.get("ofSellAble")).into(IncomingInventoryDetailPage.D_TEXTBOX1("# of Sellable Retail Cases per Master Carton"))
                ),
                Check.whether(info.get("otherShipping").isEmpty()).otherwise(
                        Enter.theValue(info.get("otherShipping")).into(IncomingInventoryDetailPage.D_TEXTBOX1("Other special shipping details"))
                ),
                Check.whether(info.get("freightCarrier").isEmpty()).otherwise(
                        Enter.theValue(info.get("freightCarrier")).into(IncomingInventoryDetailPage.D_TEXTBOX1("Freight Carrier"))
                ),
                Check.whether(info.get("trackingNumber").isEmpty()).otherwise(
                        Enter.theValue(info.get("trackingNumber")).into(IncomingInventoryDetailPage.D_TEXTBOX("tracking-number"))
                ),
                Check.whether(info.get("referenceNumber").isEmpty()).otherwise(
                        Enter.theValue(info.get("referenceNumber")).into(IncomingInventoryDetailPage.D_TEXTBOX("reference-number"))
                ),
                Check.whether(info.get("stackableTransit").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(IncomingInventoryDetailPage.D_TEXTBOX("transit-stackable"), IncomingInventoryDetailPage.D_ITEM_IN_SUBMIT(info.get("stackableTransit")))
                ),
                Check.whether(info.get("stackableWarehouse").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(IncomingInventoryDetailPage.D_TEXTBOX("warehouse-stackable"), IncomingInventoryDetailPage.D_ITEM_IN_SUBMIT(info.get("stackableWarehouse")))
                ),
                Check.whether(info.get("totalWeight").isEmpty()).otherwise(
                        Enter.theValue(info.get("totalWeight")).into(IncomingInventoryDetailPage.D_TEXTBOX("total-weight"))
                ),
                Check.whether(info.get("zipCode").isEmpty()).otherwise(
                        Enter.theValue(info.get("zipCode")).into(IncomingInventoryDetailPage.D_TEXTBOX("zip-code"))
                ),
                Check.whether(info.get("bol").isEmpty()).otherwise(
                        CommonFile.upload2(info.get("bol"), IncomingInventoryDetailPage.D_TEXTBOX("documents"))
                ),
                Check.whether(info.get("transportName").isEmpty()).otherwise(
                        Enter.theValue(info.get("transportName")).into(IncomingInventoryDetailPage.D_TEXTBOX("transport-coordinator-name"))
                ),
                Check.whether(info.get("transportPhone").isEmpty()).otherwise(
                        Enter.theValue(info.get("transportPhone")).into(IncomingInventoryDetailPage.D_TEXTBOX("transport-coordinator-phone"))
                )
        );
    }

    public static Task fillInfoSKUInSubmitForm(Map<String, String> info) {
        return Task.where("Fill info of sku in submit form",
                Scroll.to(IncomingInventoryDetailPage.LOT_CODE_TEXTBOX_BY_SKU(info.get("skuName"), info.get("index"))),
                Check.whether(info.get("lotCode").isEmpty()).otherwise(
                        Enter.theValue(info.get("lotCode")).into(IncomingInventoryDetailPage.LOT_CODE_TEXTBOX_BY_SKU(info.get("skuName"), info.get("index")))
                ),
                Check.whether(info.get("estimateDateSKU").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("estimateDateSKU"), "MM/dd/yy")).into(IncomingInventoryDetailPage.EXPIRATION_DATE_TEXTBOX_BY_SKU(info.get("skuName"), info.get("index"))).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("ofCase").isEmpty()).otherwise(
                        Enter.theValue(info.get("ofCase")).into(IncomingInventoryDetailPage.OF_CASES_TEXTBOX_BY_SKU(info.get("skuName"), info.get("index")))
                ),
                Check.whether(info.get("receivingDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("receivingDate"), "MM/dd/YY")).into(IncomingInventoryDetailPage.RECEIVING_DATE_TEXTBOX_BY_SKU(info.get("skuName"), info.get("index"))).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("note").isEmpty()).otherwise(
                        Enter.theValue(info.get("note")).into(IncomingInventoryDetailPage.NOTE_TEXTAREA_BY_SKU(info.get("skuName"), info.get("index")))
                )
        );
    }

    public static Task changeStatusIncomingInventory(String status) {
        return Task.where("Change Status Incoming Inventory",
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.POD_SUGGESTED_BUTTON),
                Click.on(IncomingInventoryDetailPage.POD_SUGGESTED_BUTTON),
                CommonTask.chooseItemInDropdown1(IncomingInventoryDetailPage.SUBMMIT_TEXTBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(status)),
                Click.on(IncomingInventoryDetailPage.UPDATE_SUBMITTED_BUTTON)
        );
    }

    public static Task addSKU(Map<String, String> info) {
        String sku = info.get("sku");
        if (sku.contains("random"))
            sku = Serenity.sessionVariableCalled("SKU inventory");
        return Task.where("Add sku into incoming inventory",
                Scroll.to(CommonAdminForm.DYNAMIC_BUTTON("Add Sku")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add Sku")),
                CommonWaitUntil.isVisible(IncomingInventoryPage.CREATE_ADD_SKU_SEARCH_FIELD),
                Enter.theValue(sku).into(IncomingInventoryPage.CREATE_ADD_SKU_SEARCH_FIELD).thenHit(Keys.TAB),
                WindowTask.threadSleep(1000),
                Click.on(IncomingInventoryDetailPage.SKU_IN_POPUP_ADD(sku)).afterWaitingUntilEnabled(),
                Check.whether(CommonQuestions.isControlDisplay(IncomingInventoryPage.CONFIRM_ADD_SKU_AGAIN)).andIfSo(
                        Click.on(IncomingInventoryPage.CONFIRM_ADD_SKU_AGAIN)
                ),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.SKU_OF_CASE(sku, info.get("index"))),
                Enter.theValue(info.get("ofCase")).into(IncomingInventoryDetailPage.SKU_OF_CASE(sku, info.get("index")))
        );
    }

    public static Task updateRequest() {
        return Task.where("Update request",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Update Request")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Update Request"))
        );
    }

    public static Task cancelRequestInResult(String id, String note) {
        return Task.where("Cancel request incoming inventory result",
                CommonWaitUntil.isVisible(IncomingInventoryPage.CANCEL_REQUEST(id)),
                Click.on(IncomingInventoryPage.CANCEL_REQUEST(id)),
                CommonWaitUntil.isVisible(IncomingInventoryPage.NOTE_CANCEL_REQUEST),
                Enter.theValue(note).into(IncomingInventoryPage.NOTE_CANCEL_REQUEST),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Cancel")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task cancelRequestInDetail(String note) {
        return Task.where("Cancel request incoming inventory detail",
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.CANCEL_REQUEST_DETAIL),
                Click.on(IncomingInventoryDetailPage.CANCEL_REQUEST_DETAIL),
                CommonWaitUntil.isVisible(IncomingInventoryPage.NOTE_CANCEL_REQUEST),
                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG("Please leave an internal cancelation note")).isDisplayed(),
                Enter.theValue(note).into(IncomingInventoryPage.NOTE_CANCEL_REQUEST),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Cancel")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task editInfoGeneralInformation(Map<String, String> info) {
        return Task.where("Edit info general information",
                Check.whether(info.get("region").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipDropdownWithInput(IncomingInventoryDetailPage.REGION_FIELD, info.get("region")),
                        WindowTask.threadSleep(1000)
                ), Check.whether(info.get("deliveryMethod").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipDropdown(IncomingInventoryDetailPage.DELIVERY_METHOD, info.get("deliveryMethod"))
                ), Check.whether(info.get("estimatedDate").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipDateTime(IncomingInventoryDetailPage.ETA, CommonHandle.setDate2(info.get("estimatedDate"), "MM/dd/yy"))
                ), Check.whether(info.get("estimatedWeek").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL("Estimated Weeks of Inventory"), info.get("estimatedWeek"))
                ), Check.whether(info.get("ofPallets").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL2("# of Pallets"), info.get("ofPallets"))
                ), Check.whether(info.get("ofSellAble").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL2("# of Sellable Retail Cases per Master Carton"), info.get("ofSellAble"))
                ), Check.whether(info.get("transit").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipDropdown(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL("Are the pallets stackable in transit?"), info.get("transit"))
                ), Check.whether(info.get("warehouse").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipDropdown(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL("Are the pallets stackable in the warehouse?"), info.get("warehouse"))
                ), Check.whether(info.get("totalWeight").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL("Total weight of shipment?"), info.get("totalWeight"))
                ), Check.whether(info.get("zipcode").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL("What zip code is the shipment coming from?"), info.get("zipcode"))
                ), Check.whether(info.get("note").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextarea(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL2("Note"), info.get("note"))
                ), Check.whether(info.get("adminNote").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextarea(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL2("Admin note"), info.get("adminNote"))
                ), Check.whether(info.get("other").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL2("Other special shipping details"), info.get("other"))
                ), Check.whether(info.get("freight").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL2("Freight Carrier"), info.get("freight"))
                ), Check.whether(info.get("tracking").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL("Tracking Number"), info.get("tracking"))
                ), Check.whether(info.get("referenceNumber").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL("Reference Number"), info.get("referenceNumber"))
                ), Check.whether(info.get("transportName").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL("Name"), info.get("transportName"))
                ), Check.whether(info.get("transportPhone").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueTooltipTextbox(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL("Phone number"), info.get("transportPhone"))
                ), Check.whether(info.get("bol").isEmpty()).otherwise(
                        CommonTaskAdmin.changeValueFile(IncomingInventoryDetailPage.UPLOAD_BOL, info.get("bol")))
        );
    }

    public static Task editDelivery(Map<String, String> info) {
        return Task.where("Edit info general information",
                Check.whether(info.get("deliveryMethod").isEmpty()).otherwise(
                        Check.whether(CommonQuestions.isControlDisplay(CommonAdminForm.TOOLTIP_COMBOBOX)).otherwise(
//                                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.DELIVERY_METHOD),
                                JavaScriptClick.on(IncomingInventoryDetailPage.DELIVERY_METHOD)
                        ),
                        CommonTask.chooseItemInDropdown(CommonAdminForm.TOOLTIP_COMBOBOX, CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("deliveryMethod"))),
                        Check.whether(info.get("deliveryMethod").contains("Freight Carrier / LTL")).otherwise(
                                Enter.theValue(info.get("trackingNumber")).into(CommonAdminForm.DYNAMIC_TOOLTIP_INPUT("Tracking Number"))
                        ),
                        Click.on(CommonAdminForm.D_BUTTON_TOOLTIP),
                        CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
                ));
    }

    public static Task editInfoSKU(Map<String, String> info) {
        return Task.where("Edit infor general information",
                Check.whether(info.get("lotcode").isEmpty()).otherwise(
                        Enter.theValue(info.get("lotcode")).into(IncomingInventoryDetailPage.SKU_LOTCODE(info.get("skuName"), info.get("index")))
                ),
                Check.whether(info.get("expiredDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("expiredDate"), "MM/dd/yy")).into(IncomingInventoryDetailPage.SKU_EXPIRATION_DATE(info.get("skuName"), info.get("index"))).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("ofCases").isEmpty()).otherwise(
                        Enter.theValue(info.get("ofCases")).into(IncomingInventoryDetailPage.SKU_OF_CASE(info.get("skuName"), info.get("index")))
                ),
                Check.whether(info.get("receivingDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("receivingDate"), "MM/dd/yy")).into(IncomingInventoryDetailPage.SKU_RECEIVE_DATE(info.get("skuName"), info.get("index"))).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("suggestedCase").isEmpty()).otherwise(
                        Enter.theValue(info.get("suggestedCase")).into(IncomingInventoryDetailPage.SKU_SUGGEST_CASE(info.get("skuName"), info.get("index")))
                ),
                Check.whether(info.get("damagedCase").isEmpty()).otherwise(
                        Enter.theValue(info.get("damagedCase")).into(IncomingInventoryDetailPage.SKU_DAMAGED_CASE(info.get("skuName"), info.get("index")))
                ),
                Check.whether(info.get("excessCase").isEmpty()).otherwise(
                        Enter.theValue(info.get("excessCase")).into(IncomingInventoryDetailPage.SKU_EXCESS_CASE(info.get("skuName"), info.get("index")))
                ),
                Check.whether(info.get("shortedCase").isEmpty()).otherwise(
                        Enter.theValue(info.get("shortedCase")).into(IncomingInventoryDetailPage.SKU_SHORTED_CASE(info.get("skuName"), info.get("index")))
                ),
                Check.whether(info.get("caseReceived").isEmpty()).otherwise(
                        Enter.theValue(info.get("caseReceived")).into(IncomingInventoryDetailPage.SKU_RECEIVED_CASE(info.get("skuName"), info.get("index")))
                ),
                Check.whether(info.get("note").isEmpty()).otherwise(
                        Enter.theValue(info.get("note")).into(IncomingInventoryDetailPage.NOTE(info.get("skuName"), info.get("index")))
                )
        );
    }

    public static Task saveAfterChange() {
        return Task.where("Save request after change",
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.SAVE_BUTTON),
                Click.on(IncomingInventoryDetailPage.SAVE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("SKUs has been updated successfully !!"))
        );
    }

    public static Task uploadFile(Map<String, String> info) {
        return Task.where("Update POD or BOL",
                Check.whether(info.get("bol").isEmpty())
                        .otherwise(
                                CommonWaitUntil.isPresent(IncomingInventoryDetailPage.BOL_UPLOAD_FIELD),
                                CommonFile.upload1(info.get("bol"), IncomingInventoryDetailPage.BOL_UPLOAD_FIELD)),
                Check.whether(info.get("pod").isEmpty())
                        .otherwise(
                                CommonWaitUntil.isPresent(IncomingInventoryDetailPage.POD_UPLOAD_FIELD),
                                CommonFile.upload1(info.get("pod"), IncomingInventoryDetailPage.POD_UPLOAD_FIELD))
        );
    }

    public static Task markAsReceived(String type) {
        return Task.where("Mark as received",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Mark as Received")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Mark as Received")).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Are you sure that you want to change status to received in this incoming inventory?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(type)),
                Check.whether(type.equals("OK"))
                        .andIfSo(
                                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Inventory has been change status successfully!")),
                                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON),
                                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Process")))
        );
    }

    public static Performable uploadInventoryImage(List<Map<String, String>> infos) {
        return Task.where("Upload inventory image",
                actor -> {
                    for (Map<String, String> info : infos) {
                        actor.attemptsTo(
                                WindowTask.threadSleep(1000),
                                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a photo")),
                                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a photo")),
                                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.REMOVE_IMAGE_BUTTON(info.get("index"))),
                                CommonFile.upload2(info.get("image"), IncomingInventoryDetailPage.IMAGE_INDEX(info.get("index"))),
                                Enter.theValue(info.get("description")).into(IncomingInventoryDetailPage.DESCRIPTION_TEXTBOX(info.get("index"))),
                                Scroll.to(IncomingInventoryDetailPage.IMAGE_INDEX(info.get("index")))
//                                Click.on(IncomingInventoryDetailPage.SAVE_IMAGE_BUTTON),
//                                WindowTask.threadSleep(1000)
                        );
                    }
                }
        );
    }

    public static Task subscribe() {
        return Task.where("Subscribe ",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Subscribe")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Subscribe")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.ALERT_MESSAGE("A Slack message will be sent when this inbound inventory is processed")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Unsubscribe"))
        );
    }

    public static Task unsubscribe() {
        return Task.where("Unsubscribe ",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Unsubscribe")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Unsubscribe")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Subscribe"))
        );
    }

    public static Task exportPDFParkingSlip(String type) {
        return Task.where("export PDF Inbound Parking Slip ",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_HEADER_BUTTON("PDF")),
                Click.on(CommonAdminForm.DYNAMIC_HEADER_BUTTON("PDF")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_4(type)),
                Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_4(type)),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task exportExcel() {
        return Task.where("export Excel Inbounb ",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_HEADER_BUTTON("Excel")),
                Click.on(CommonAdminForm.DYNAMIC_HEADER_BUTTON("Excel")),
                WindowTask.threadSleep(1000)
        );
    }

}

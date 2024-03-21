package cucumber.tasks.admin.inventory;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.CommonFile;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.AllInventoryPage;
import cucumber.user_interface.admin.inventory.InventoryDetailPage;
import cucumber.user_interface.admin.orders.OrderDetailPage;
import cucumber.user_interface.admin.products.AdminAllProductsPage;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.Map;
import java.util.Objects;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.*;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;

public class HandleInventory {

    public static Task search(Map<String, String> info) {
        return Task.where("Search inventory",
                Check.whether(valueOf(CommonAdminForm.SHOW_FILTER), isVisible())
                        .andIfSo(
                                Click.on(CommonAdminForm.SHOW_FILTER)),
                Check.whether(info.get("skuName").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_variant"), info.get("skuName"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN3(info.get("skuName")))
                ),
                Check.whether(info.get("productName").isEmpty()).otherwise(
                        Enter.theValue(info.get("productName")).into(CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("product_name"))
                ),
                Check.whether(!Objects.equals(info.get("vendorCompany"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("vendor_company_id"), info.get("vendorCompany"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("vendorCompany")))
                        ),
                Check.whether(!Objects.equals(info.get("vendorBrand"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("brand_id"), info.get("vendorBrand"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("vendorBrand")))
                        ),
                Check.whether(!Objects.equals(info.get("region"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("region_id"), info.get("region"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("region")))
                        ),
                Check.whether(!Objects.equals(info.get("distribution"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("warehouse_id"), info.get("distribution"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("distribution")))
                        ),
                Check.whether(!Objects.equals(info.get("createdBy"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("creator_type"), info.get("createdBy"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("createdBy")))
                        ),
                Check.whether(!Objects.equals(info.get("lotCode"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("current_quantity_gt"), info.get("lotCode"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("lotCode")))
                        ),
                Check.whether(!Objects.equals(info.get("pulled"), ""))
                        .andIfSo(
                                CommonTask.chooseItemInDropdownWithValueInput(
                                        CommonAdminForm.DYNAMIC_SEARCH_TEXTBOX("pulled"), info.get("pulled"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("pulled")))
                        ),
                Click.on(CommonAdminForm.SEARCH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task sortSearch() {
        return Task.where("Sort search by date",
                // click sort 2 lần để cho ngày receive từ mới nhất
                CommonWaitUntil.isVisible(AllInventoryPage.SORT_RECEIVE_DATE_RESULT),
                Click.on(AllInventoryPage.SORT_RECEIVE_DATE_RESULT),
                WindowTask.threadSleep(1000),
                Click.on(AllInventoryPage.SORT_RECEIVE_DATE_RESULT)
        );
    }

    public static Task create(Map<String, String> info) {
        return Task.where("Create inventory",
                Check.whether(CommonQuestions.isControlDisplay(AllInventoryPage.DYNAMIC_FIELD("warehouse_id"))).otherwise(
                        Click.on(AllInventoryPage.CREATE_BUTTON),
                        Ensure.that(AllInventoryPage.DYNAMIC_FIELD("product_variant_id")).isDisabled()
                ),
                Check.whether(info.get("distribution").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                AllInventoryPage.DYNAMIC_FIELD("warehouse_id"), info.get("distribution"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(info.get("distribution")))
                ),
                Check.whether(info.get("sku").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdownWithValueInput(
                                AllInventoryPage.DYNAMIC_FIELD("product_variant_id"), info.get("sku"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("sku")))
                ),
                Check.whether(info.get("quantity").isEmpty()).otherwise(
                        Enter.theValue(info.get("quantity")).into(AllInventoryPage.QUALITY_TEXTBOX)
                ),
                Check.whether(info.get("lotCode").isEmpty()).otherwise(
                        Enter.theValue(info.get("lotCode")).into(AllInventoryPage.DYNAMIC_FIELD("lot_code"))
                ),
                Check.whether(info.get("receiveDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("receiveDate"), "MM/dd/yy")).into(AllInventoryPage.DYNAMIC_FIELD("receive_date")).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("expiryDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("expiryDate"), "MM/dd/yy")).into(AllInventoryPage.DYNAMIC_FIELD("expire_date")).thenHit(Keys.ENTER)
                ),
                Check.whether(info.get("comment").isEmpty()).otherwise(
                        Enter.theValue(info.get("comment")).into(AllInventoryPage.DYNAMIC_FIELD("comment"))
                )
        );
    }

    public static Task addImageToCreate(Map<String, String> info) {
        return Task.where("Add Image to create inventory",
                CommonWaitUntil.isVisible(AllInventoryPage.ADD_PHOTO_BUTTON),
                Click.on(AllInventoryPage.ADD_PHOTO_BUTTON),
                CommonWaitUntil.isVisible(AllInventoryPage.IMAGE_PREVIEW(info.get("index"))),
                Check.whether(info.get("file").isEmpty()).otherwise(
                        CommonFile.upload2(info.get("file"), AllInventoryPage.ATTACHMENT_BUTTON(info.get("index")))
                ),
                Check.whether(info.get("comment").isEmpty()).otherwise(
                        Enter.theValue(info.get("comment")).into(AllInventoryPage.COMMENT_IMAGE_TEXTBOX(info.get("index")))
                )
        );
    }

    public static Task createInventorySuccess() {
        return Task.where("Add Image to create inventory",
                Scroll.to(AllInventoryPage.CREATE_BUTTON_IN_POPUP),
                Click.on(AllInventoryPage.CREATE_BUTTON_IN_POPUP),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isVisible(InventoryDetailPage.PRODUCT_NAME)
        );
    }

    public static Task goToCreateSubtraction() {
        return Task.where("Go to create subtraction",
                Check.whether(CommonQuestions.isControlDisplay(InventoryDetailPage.POPUP_CREATE_QUANTITY)).otherwise(
                        CommonWaitUntil.isVisible(InventoryDetailPage.NEW_SUBTRACTION_BUTTON),
                        Click.on(InventoryDetailPage.NEW_SUBTRACTION_BUTTON)
                )
        );
    }

    public static Performable createItem(Map<String, String> info) {
        return Task.where("Create item",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(InventoryDetailPage.POPUP_CREATE_QUANTITY),
                            Check.whether(info.get("quantity").equals(""))
                                    .otherwise(
                                            Enter.theValue(info.get("quantity")).into(InventoryDetailPage.POPUP_CREATE_QUANTITY)),
                            CommonTask.chooseItemInDropdownWithValueInput(InventoryDetailPage.POPUP_CREATE_CATEGORY, info.get("category"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("category")))
                    );
                    if (info.containsKey("subCategory")) {
                        actor.attemptsTo(
                                Check.whether(info.get("subCategory").isEmpty())
                                        .otherwise(
                                                CommonTask.chooseItemInDropdownWithValueInput(InventoryDetailPage.POPUP_CREATE_SUB_CATEGORY, info.get("subCategory"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN_3(info.get("subCategory"))))
                        );
                    }
                    actor.attemptsTo(
                            Check.whether(info.get("comment").isEmpty())
                                    .otherwise(
                                            Enter.theValue(info.get("comment")).into(InventoryDetailPage.POPUP_CREATE_COMMENT)),
                            Click.on(InventoryDetailPage.POPUP_CREATE_BUTTON),
                            CommonWaitUntil.isNotVisible(InventoryDetailPage.POPUP_CREATE_BUTTON),
                            CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                            WindowTask.threadSleep(1000)
                    );
                }
        );
    }

    public static Task deleteSubtraction(String comment) {
        return Task.where("Delete subtraction",
                CommonWaitUntil.isVisible(InventoryDetailPage.FIRST_DELETE_SUBTRACTION),
                Click.on(InventoryDetailPage.FIRST_DELETE_SUBTRACTION),
                CommonWaitUntil.isVisible(InventoryDetailPage.DELETE_SUBTRACTION_REMOVAL_COMMENT),
                Enter.theValue(comment).into(InventoryDetailPage.DELETE_SUBTRACTION_REMOVAL_COMMENT),
                Click.on(InventoryDetailPage.DELETE_SUBTRACTION_REMOVAL_CONFIRM),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isNotVisible(InventoryDetailPage.DELETE_SUBTRACTION_REMOVAL_CONFIRM),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task editGeneralInformation(Map<String, String> info) {
        return Task.where("Edit general information",
                CommonTaskAdmin.changeValueTooltipDateTime(InventoryDetailPage.D_FIELD("at-receive-date"), CommonHandle.setDate2(info.get("receiveDate"), "MM/dd/yy")),
                CommonTaskAdmin.changeValueTooltipDateTime(InventoryDetailPage.D_FIELD("at-expiry-date"), CommonHandle.setDate2(info.get("expireDate"), "MM/dd/yy")),
                CommonTaskAdmin.changeValueTooltipTextbox(InventoryDetailPage.LOT_CODE, info.get("lotCode"))
        );
    }

    public static Task editDistribution(String distribution) {
        return Task.where("Edit distribution",
                CommonTaskAdmin.changeValueTooltipDropdownWithInput2(InventoryDetailPage.DISTRIBUTION_CENTER, distribution)
        );
    }

    public static Task goToProduct() {
        return Task.where("Go to product from inventory detail",
                Click.on(InventoryDetailPage.PRODUCT_LINK),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    public static Task saveImageUpload() {
        return Task.where("Save image upload",
                Scroll.to(InventoryDetailPage.SAVE_IMAGE_BUTTON),
                Click.on(InventoryDetailPage.SAVE_IMAGE_BUTTON),
                CommonWaitUntil.isVisible(InventoryDetailPage.PREVIEW_IMAGE_BUTTON)
        );
    }

    public static Task checkRegion(Map<String, String> map) {
        return Task.where("check Region",
                CommonWaitUntil.isVisible(AllInventoryPage.DYNAMIC_FIELD("warehouse_id")),
                CommonTask.chooseItemInDropdownWithValueInput(AllInventoryPage.DYNAMIC_FIELD("warehouse_id"), map.get("distribution"), CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(map.get("distribution"))),
                Ensure.that(AllInventoryPage.DYNAMIC_FIELD("product_variant_id")).isEnabled(),
                Ensure.that(AllInventoryPage.DISTRIBUTION_REGION).text().isEqualToIgnoringCase(map.get("region"))
        );
    }

    public static Task checkQuantity(Map<String, String> map) {
        return Task.where("check Quantity",
                CommonWaitUntil.isVisible(AllInventoryPage.QUALITY_TEXTBOX),
                Check.whether(CommonQuestions.targetValue(theActorInTheSpotlight(), AllInventoryPage.QUALITY_TEXTBOX).equals("1")).andIfSo(
                        Ensure.that(AllInventoryPage.EDIT_QUANTITY("decrease")).attribute("class").contains("is-disabled")
                ).otherwise(
                        Ensure.that(AllInventoryPage.EDIT_QUANTITY("decrease")).attribute("class").doesNotContain("is-disabled")
                ),
                Check.whether(map.get("action").equals("decrease")).andIfSo(
                        Click.on(AllInventoryPage.EDIT_QUANTITY("decrease"))
                ),
                Check.whether(map.get("action").equals("increase")).andIfSo(
                        Click.on(AllInventoryPage.EDIT_QUANTITY("increase"))
                ),
                WindowTask.threadSleep(100),
                Ensure.that(AllInventoryPage.QUALITY_TEXTBOX).attribute("value").isEqualToIgnoringCase(map.get("value"))
        );
    }

    public static Task deleteInventory(String action) {
        return Task.where("delete Inventory",
                CommonWaitUntil.isVisible(InventoryDetailPage.DELETE_BUTTON),
                Click.on(InventoryDetailPage.DELETE_BUTTON),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("This will permanently delete this inventory. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action)),
                WindowTask.threadSleep(500)
        );
    }

    public static Task refreshInventory() {
        return Task.where("refresh Inventory",
                CommonWaitUntil.isVisible(CommonAdminForm.REFRESH_BUTTON),
                Click.on(CommonAdminForm.REFRESH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                WindowTask.threadSleep(500)
        );
    }

    public static Task editInventory(Map<String, String> map) {
        return Task.where("edit Inventory",
                CommonWaitUntil.isVisible(InventoryDetailPage.PRODUCT_NAME),
                Check.whether(map.get("receiveDate").isEmpty()).otherwise(
                        Click.on(InventoryDetailPage.RECEIVE_DATE),
                        WindowTask.threadSleep(500),
                        Check.whether(CommonQuestions.isControlDisplay(InventoryDetailPage.DATE_TOOLTIP)).andIfSo(
                                Click.on(InventoryDetailPage.RECEIVE_DATE(CommonHandle.setDate2(map.get("receiveDate"), "d"))),
                                CommonWaitUntil.isNotVisible(InventoryDetailPage.RECEIVE_DATE(CommonHandle.setDate2(map.get("receiveDate"), "d")))
                        ).otherwise(
                                CommonWaitUntil.isVisible(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Select receive date")),
                                Enter.theValue(CommonHandle.setDate2(map.get("receiveDate"), "MM/dd/yy")).into(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Select receive date")).thenHit(Keys.ENTER)
                        ),
                        CommonWaitUntil.isVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                        Click.on(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                        CommonWaitUntil.isNotVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Update"))
                ),
                Check.whether(map.get("expiryDate").isEmpty()).otherwise(
                        Click.on(InventoryDetailPage.EXPIRY_DATE),
                        WindowTask.threadSleep(500),
                        Check.whether(CommonQuestions.isControlDisplay(InventoryDetailPage.DATE_TOOLTIP)).andIfSo(
                                Click.on(InventoryDetailPage.RECEIVE_DATE(CommonHandle.setDate2(map.get("expiryDate"), "d"))),
                                CommonWaitUntil.isNotVisible(InventoryDetailPage.RECEIVE_DATE(CommonHandle.setDate2(map.get("expiryDate"), "d")))
                        ).otherwise(
                                CommonWaitUntil.isVisible(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Select expiry date")),
                                Enter.theValue(CommonHandle.setDate2(map.get("expiryDate"), "MM/dd/yy")).into(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Select expiry date")).thenHit(Keys.ENTER)
                        ),
                        CommonWaitUntil.isVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                        Click.on(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                        CommonWaitUntil.isNotVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Update"))
                ),
                Check.whether(map.get("lotCode").isEmpty()).otherwise(
                        Click.on(InventoryDetailPage.LOT_CODE),
                        CommonWaitUntil.isVisible(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Lot code")),
                        Enter.theValue(map.get("lotCode")).into(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Lot code")),
                        Click.on(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                        CommonWaitUntil.isNotVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Update"))
                ),
                Check.whether(map.get("comment").isEmpty()).otherwise(
                        Click.on(InventoryDetailPage.COMMENT),
                        CommonWaitUntil.isVisible(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Comment")),
                        Enter.theValue(map.get("comment")).into(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Comment")),
                        Click.on(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                        CommonWaitUntil.isNotVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Update"))
                ),
                WindowTask.threadSleep(500)
        );
    }

    public static Task validateEditInventory() {
        String receiceDate = CommonQuestions.getText(theActorInTheSpotlight(), InventoryDetailPage.RECEIVE_DATE);
        String expiryDate = CommonQuestions.getText(theActorInTheSpotlight(), InventoryDetailPage.EXPIRY_DATE);
        String lotCode = CommonQuestions.getText(theActorInTheSpotlight(), InventoryDetailPage.LOT_CODE);
        return Task.where("edit Inventory",
                CommonWaitUntil.isVisible(InventoryDetailPage.PRODUCT_NAME),
                Click.on(InventoryDetailPage.RECEIVE_DATE),
                WindowTask.threadSleep(200),
                Check.whether(CommonQuestions.isControlDisplay(InventoryDetailPage.DATE_TOOLTIP)).andIfSo(
                        Click.on(InventoryDetailPage.RECEIVE_DATE(CommonHandle.setDate2("currentDate", "dd"))),
                        CommonWaitUntil.isNotVisible(InventoryDetailPage.RECEIVE_DATE(CommonHandle.setDate2("currentDate", "dd")))
                ).otherwise(
                        CommonWaitUntil.isVisible(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Select receive date")),
                        Enter.theValue(CommonHandle.setDate2("currentDate", "MM/dd/yy")).into(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Select receive date")).thenHit(Keys.ENTER)
                ),
                MoveMouse.to(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Select receive date")).then(
                        Click.on(CommonAdminForm.ICON_CIRCLE_DELETE)
                ),
                CommonWaitUntil.isVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Receive date can't be blank")),
                CommonWaitUntil.isVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Cancel")).then(
                        Click.on(CommonAdminForm.D_BUTTON_TOOLTIP("Cancel"))
                ),
                CommonWaitUntil.isNotVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Cancel")),
                Ensure.that(InventoryDetailPage.RECEIVE_DATE).text().contains(receiceDate),

                Click.on(InventoryDetailPage.EXPIRY_DATE),
                WindowTask.threadSleep(200),
                Check.whether(CommonQuestions.isControlDisplay(InventoryDetailPage.DATE_TOOLTIP)).andIfSo(
                        Click.on(InventoryDetailPage.RECEIVE_DATE(CommonHandle.setDate2("currentDate", "dd"))),
                        CommonWaitUntil.isNotVisible(InventoryDetailPage.RECEIVE_DATE(CommonHandle.setDate2("currentDate", "dd")))
                ).otherwise(
                        CommonWaitUntil.isVisible(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Select expiry date")),
                        Enter.theValue(CommonHandle.setDate2("currentDate", "MM/dd/yy")).into(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Select expiry date")).thenHit(Keys.ENTER)
                ),
                MoveMouse.to(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Select expiry date")).then(
                        Click.on(CommonAdminForm.ICON_CIRCLE_DELETE)
                ),
                CommonWaitUntil.isVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                Ensure.that(InventoryDetailPage.EXPIRY_DATE).text().contains(""),

                Click.on(InventoryDetailPage.LOT_CODE),
                CommonWaitUntil.isVisible(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Lot code")),
                Enter.theValue(" ").into(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Lot code")),
                CommonWaitUntil.isVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                CommonWaitUntil.isVisible(CommonAdminForm.ALERT_MESSAGE("Lot code can't be blank")),
                CommonWaitUntil.isVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Cancel")).then(
                        Click.on(CommonAdminForm.D_BUTTON_TOOLTIP("Cancel"))
                ),
                CommonWaitUntil.isNotVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Cancel")),
                Ensure.that(InventoryDetailPage.LOT_CODE).text().contains(lotCode),

                Click.on(InventoryDetailPage.COMMENT),
                CommonWaitUntil.isVisible(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Comment")),
                Enter.theValue(" ").into(InventoryDetailPage.EDIT_INPUT_TOOLTIP("Comment")),
                CommonWaitUntil.isVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                Click.on(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.D_BUTTON_TOOLTIP("Update")),
                Ensure.that(InventoryDetailPage.COMMENT).text().contains("Empty"),
                WindowTask.threadSleep(500)
        );
    }

    public static Task exportInventory() {
        String fileName = "inventories-summary-" + CommonHandle.setDate2("currentDate", "MM_dd_yy") + ".csv";
        return Task.where("export Inventory",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Export")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Export")),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Exporting will cost a lot of system resources. If you need large-sized data, please contact Jungmin first. If you still want to proceed, type ")),
                Enter.theValue("I UNDERSTAND").into(CommonAdminForm.DYNAMIC_DIALOG_INPUT()),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Process")),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.waitToDownloadSuccessfully(fileName)
        );
    }

    public static Task goToCreateAddition() {
        return Task.where("Go to create addition",
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("New addition item")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("New addition item")),
                CommonWaitUntil.isVisible(InventoryDetailPage.POPUP_CREATE_QUANTITY)
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
                    if (info.containsKey("vendorCompany")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Vendor company")));
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
                    if (info.containsKey("region")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Region")));
                    }
                    if (info.containsKey("createBy")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Created by")));
                    }
                    if (info.containsKey("pulled")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Pulled?")));
                    }
                    if (info.containsKey("distributionCenter")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Distribution center")));
                    }
                    if (info.containsKey("lotsWithZeroQuantity")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Lots with 0 current quantity")));
                    }
                    if (info.containsKey("storageShelfLife")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Storage shelf life")));
                    }
                    if (info.containsKey("tags")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Tags")));
                    }
                    if (info.containsKey("untilPullDate")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Days until pull date")));
                    }
                    if (info.containsKey("pullStartDate")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Pull start date")));
                    }
                    if (info.containsKey("pullEndDate")) {
                        actor.attemptsTo(
                                Click.on(CommonAdminForm.FIELD_EDIT_VISIBILITY("Pull end date")));
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

    public static Performable searchFieldUnVisible(Map<String, String> info) {
        return Task.where("Uncheck all edit visibility in search",
                actor -> {
                    actor.attemptsTo(
                            Check.whether(CommonQuestions.isControlUnDisplay(CommonAdminForm.DYNAMIC_BUTTON("Search"))).andIfSo(
                                    Click.on(AdminAllProductsPage.SHOW_FILTERS)
                            ),
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Search"))
                    );
                    if (info.containsKey("skuNameItemCode")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("SKU name / Item code")).isNotDisplayed()
                        );
                    }
                    if (info.containsKey("vendorCompany")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Vendor company")).isNotDisplayed());
                    }
                    if (info.containsKey("region")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Region")).isNotDisplayed());
                    }
                    if (info.containsKey("createBy")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Created by")).isNotDisplayed());
                    }
                    if (info.containsKey("pulled")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Pulled?")).isNotDisplayed());
                    }
                    if (info.containsKey("productName")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Product name")).isNotDisplayed());
                    }
                    if (info.containsKey("vendorBrand")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Vendor brand")).isNotDisplayed());
                    }
                    if (info.containsKey("distributionCenter")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Distribution center")).isNotDisplayed());
                    }
                    if (info.containsKey("lotsWithZeroQuantity")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Lots with 0 current quantity")).isNotDisplayed());
                    }
                    if (info.containsKey("storageShelfLife")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Storage shelf life")).isNotDisplayed());
                    }
                    if (info.containsKey("tags")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Tags")).isNotDisplayed());
                    }
//                    if (info.containsKey("untilPullDate")) {
//                        actor.attemptsTo(
//                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Days until pull date")).isNotDisplayed());
//                    }
                    if (info.containsKey("pullStartDate")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Pull start date")).isNotDisplayed());
                    }
                    if (info.containsKey("pullEndDate")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Pull end date")).isNotDisplayed());
                    }
                });
    }

    public static Performable searchFieldVisible(Map<String, String> info) {
        return Task.where("Uncheck all edit visibility in search",
                actor -> {
                    actor.attemptsTo(
                            Check.whether(CommonQuestions.isControlUnDisplay(CommonAdminForm.DYNAMIC_BUTTON("Search"))).andIfSo(
                                    Click.on(AdminAllProductsPage.SHOW_FILTERS)
                            ),
                            CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Search"))
                    );
                    if (info.containsKey("skuNameItemCode")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("SKU name / Item code")).isDisplayed()
                        );
                    }
                    if (info.containsKey("vendorCompany")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Vendor company")).isDisplayed());
                    }
                    if (info.containsKey("region")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Region")).isDisplayed());
                    }
                    if (info.containsKey("createBy")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Created by")).isDisplayed());
                    }
                    if (info.containsKey("pulled")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Pulled?")).isDisplayed());
                    }
                    if (info.containsKey("productName")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Product name")).isDisplayed());
                    }
                    if (info.containsKey("vendorBrand")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Vendor brand")).isDisplayed());
                    }
                    if (info.containsKey("distributionCenter")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Distribution center")).isDisplayed());
                    }
                    if (info.containsKey("lotsWithZeroQuantity")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Lots with 0 current quantity")).isDisplayed());
                    }if (info.containsKey("storageShelfLife")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Storage shelf life")).isDisplayed());
                    }
                    if (info.containsKey("tags")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Tags")).isDisplayed());
                    }
                    if (info.containsKey("untilPullDate")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Days until pull date")).isDisplayed());
                    }
                    if (info.containsKey("pullStartDate")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Pull start date")).isDisplayed());
                    }
                    if (info.containsKey("pullEndDate")) {
                        actor.attemptsTo(
                                Ensure.that(CommonAdminForm.DYNAMIC_INPUT("Pull end date")).isDisplayed());
                    }
                });
    }
}

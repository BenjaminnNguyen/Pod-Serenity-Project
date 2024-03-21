package cucumber.tasks.vendor.inventory;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.DashBoardForm;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.inventory.VendorInventoryPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.Performable;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.Map;

public class HandleSendInventory {

    public static Task searchInboundInventory(Map<String, String> info) {
        return Task.where("Search inventory",
                CommonWaitUntil.isVisible(VendorInventoryPage.REGION_SEARCH),
                Click.on(VendorInventoryPage.REGION_SEARCH),
                CommonTask.ChooseValueFromSuggestions(info.get("region")),
                CommonWaitUntil.isNotVisible(DashBoardForm.LOADING_ICON("Fetching your inbound inventory..."))
        );
    }

    public static Task searchInboundInventory(String tab, Map<String, String> info) {
        return Task.where("Search inventory on tab " + tab,
                CommonWaitUntil.isVisible(VendorInventoryPage.DYNAMIC_TAB(tab)),
                Click.on(VendorInventoryPage.DYNAMIC_TAB(tab)),
                CommonWaitUntil.isNotVisible(DashBoardForm.LOADING_ICON("Fetching your inbound inventory...")),
                WindowTask.threadSleep(1000),
                Check.whether(info.get("region").isEmpty()).otherwise(
                        CommonTask.chooseItemInDropdown(VendorInventoryPage.DYNAMIC_TEXTBOX2("Region"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("region")))
                ),
                Check.whether(info.get("startDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("startDate"), "MM/dd/yy")).into(VendorInventoryPage.DYNAMIC_TEXTBOX2("Start date")).thenHit(Keys.TAB)
                ),
                Check.whether(info.get("startDate").isEmpty()).otherwise(
                        Enter.theValue(CommonHandle.setDate2(info.get("endDate"), "MM/dd/yy")).into(VendorInventoryPage.DYNAMIC_TEXTBOX2("End date")).thenHit(Keys.TAB)
                ),
                Check.whether(info.containsKey("showCanceled")).andIfSo(
                        CommonTask.chooseItemInDropdown(CommonVendorPage.DYNAMIC_INPUT("Show canceled items"), CommonVendorPage.DYNAMIC_ITEM_DROPDOWN(info.get("showCanceled")))
                ),
                Check.whether(info.containsKey("reference")).andIfSo(
                        Enter.theValue(info.get("reference").contains("api") ? Serenity.sessionVariableCalled("Number Inbound Inventory api") : info.get("reference")).into(CommonVendorPage.DYNAMIC_INPUT("Reference #")).thenHit(Keys.TAB)
                ),
                CommonWaitUntil.isNotVisible(DashBoardForm.LOADING_ICON("Fetching your inbound inventory...")),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task addSKUtoInboundInventory(Map<String, String> sku) {
        return Task.where("Input the values of inbound inventory",
                Click.on(VendorInventoryPage.ADD_SKUS),
                CommonWaitUntil.isVisible(VendorInventoryPage.SELECT_SKUs),
                Enter.theValue(sku.get("sku")).into(VendorInventoryPage.SELECT_SKUs),
                CommonWaitUntil.isVisible(VendorInventoryPage.SKU_NAME),
                Click.on(VendorInventoryPage.SKU_NAME),
                Click.on(VendorInventoryPage.ADD_SELECTED_SKUS),
                Check.whether(CommonQuestions.isControlDisplay(CommonAdminForm.DYNAMIC_DIALOG("Are you sure you want to enter the same SKU(s) again?")))
                        .andIfSo(Click.on(VendorInventoryPage.POPUP_CONFIRM_SAME_SKU_BUTTON)),
                CommonWaitUntil.isVisible(VendorInventoryPage.CASE_OF_SKU),

//                Enter.theValue(sku.get("caseOfSku")).into(VendorInventoryPage.CASE_OF_SKU(sku.get("sku"), sku.get("index"))),
                Enter.theValue(sku.get("productLotCode")).into(VendorInventoryPage.PRODUCT_LOT_CODE_OF_SKU(sku.get("sku"), sku.get("index"))),
                Enter.theValue(CommonHandle.setDate2(sku.get("expiryDate"), "MM/dd/yy")).into(VendorInventoryPage.EXPIRY_DATE(sku.get("sku"), sku.get("index"))).thenHit(Keys.ENTER)
        );
    }

    public static Task editSKUtoInboundInventory(Map<String, String> sku) {
        return Task.where("Input the values of inbound inventory",
                CommonWaitUntil.isVisible(VendorInventoryPage.SKU_HEADER),
                Check.whether(!sku.get("productLotCode").isEmpty()).andIfSo(
                        Enter.theValue(sku.get("productLotCode")).into(VendorInventoryPage.PRODUCT_LOT_CODE_OF_SKU(sku.get("sku"), sku.get("index")))
                ),
                Check.whether(!sku.get("expiryDate").isEmpty()).andIfSo(
                        Enter.theValue(CommonHandle.setDate2(sku.get("expiryDate"), "MM/dd/yy")).into(VendorInventoryPage.EXPIRY_DATE(sku.get("sku"), sku.get("index"))).thenHit(Keys.ENTER)
                )
        );
    }

    public static Task confirmCreateInboundInventory() {
        return Task.where("",
                CommonWaitUntil.isVisible(VendorInventoryPage.CREATE_INVENTORY),
                Click.on(VendorInventoryPage.CREATE_INVENTORY),
                CommonWaitUntil.isVisible(VendorInventoryPage.FINAL_INSTRUCTIONS_POPUP),
                Click.on(VendorInventoryPage.CONFIRM_FINAL_INSTRUCTIONS),
                CommonWaitUntil.isNotVisible(VendorInventoryPage.FINAL_INSTRUCTIONS_POPUP),
                CommonWaitUntil.isNotVisible(VendorInventoryPage.MESSAGE_SUCCESS),
                WindowTask.threadSleep(1000)
        );
    }

    public static Task confirmUpdateInboundInventory() {
        return Task.where("confirm Update Inbound Inventory",
                CommonWaitUntil.isVisible(VendorInventoryPage.UPDATE_INVENTORY),
                Click.on(VendorInventoryPage.UPDATE_INVENTORY)
//                CommonWaitUntil.isNotVisible(VendorInventoryPage.UPDATE_INVENTORY_SUCCESS)
        );
    }

    public static Task goToDetailInboundInventory(String inbound) {
        return Task.where("Go to detail inbound inventory",
                CommonWaitUntil.isVisible(VendorInventoryPage.NUMBER_INBOUND_IN_RESULT(inbound)),
                Click.on(VendorInventoryPage.NUMBER_INBOUND_IN_RESULT(inbound))
//                CommonWaitUntil.isVisible(VendorInventoryPage.LOADING_NO_PADDING)
        );
    }

    public static Task emptyFieldFormCreate() {
        return Task.where("Empty field form create inbound inventory",
                Enter.theValue("").into(VendorInventoryPage.DYNAMIC_TEXTBOX("num-of-pallets")),
                Click.on(VendorInventoryPage.CREATE_INVENTORY),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("Please fix the highlighted error(s) to continue."))
        );
    }

    public static Performable inputInboundInventory(Map<String, String> record) {
        return Task.where("Input the values of inbound inventory",
                actor -> {
                    actor.attemptsTo(
                            CommonWaitUntil.isVisible(VendorInventoryPage.SELECT_INBOUND_DELIVERY_METHOD),
                            Check.whether(record.get("deliveryMethod").isEmpty()).otherwise(
                                    Scroll.to(VendorInventoryPage.SELECT_INBOUND_DELIVERY_METHOD),
                                    Click.on(VendorInventoryPage.SELECT_INBOUND_DELIVERY_METHOD),
                                    CommonTask.ChooseValueFromSuggestions(record.get("deliveryMethod"))
                            ),
                            Check.whether(record.get("estimatedDateArrival").isEmpty()).otherwise(
                                    Enter.theValue(CommonHandle.setDate2(record.get("estimatedDateArrival"), "MM/dd/yy")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("eta")).thenHit(Keys.ENTER)
                            ),
                            Check.whether(record.get("ofPallets").isEmpty()).otherwise(
                                    Enter.theValue(record.get("ofPallets")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("num-of-pallets"))
                            ),
                            Check.whether(record.get("ofSellableRetailPerCarton").isEmpty()).otherwise(
                                    Enter.theValue(record.get("ofSellableRetailPerCarton")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("num-of-retail-cases-per-master-carton"))
                            ),
                            // đang không thấy tracking number
//                Check.whether(record.get("trackingNumber").isEmpty()).otherwise(
//                        Enter.theValue(record.get("trackingNumber")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("tracking-number"))
//                ),
                            Check.whether(record.get("totalWeight").isEmpty()).otherwise(
                                    Enter.theValue(record.get("totalWeight")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("total-weight"))
                            ),
                            Check.whether(record.get("zipCode").isEmpty()).otherwise(
                                    Enter.theValue(record.get("zipCode")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("zip-code"))
                            )
                    );
                    if (record.get("deliveryMethod").equals("Freight Carrier / LTL")) {
                        actor.attemptsTo(
                                Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("tracking-number")).isNotDisplayed()
                        );
                        if (record.containsKey("reference"))
                            actor.attemptsTo(
                                    Check.whether(record.get("reference").isEmpty()).otherwise(
                                            Enter.theValue(record.get("reference")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("tracking-number"))
                                    )
                            );
                    }
                    if (record.get("deliveryMethod").equals("Brand Self Delivery")) {
                        if (record.containsKey("trackingNumber"))
                            actor.attemptsTo(
                                    Check.whether(record.get("trackingNumber").isEmpty()).otherwise(
                                            Enter.theValue(record.get("trackingNumber")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("tracking-number"))
                                    )
                            );
                        if (record.containsKey("reference"))
                            actor.attemptsTo(
                                    Check.whether(record.get("reference").isEmpty()).otherwise(
                                            Enter.theValue(record.get("reference")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("reference-number"))
                                    )
                            );
                    }
                    if (record.get("deliveryMethod").equals("Small Package / Parcel")) {
                        if (record.containsKey("trackingNumber"))
                            actor.attemptsTo(
                                    Check.whether(record.get("trackingNumber").isEmpty()).otherwise(
                                            Enter.theValue(record.get("trackingNumber")).into(VendorInventoryPage.DYNAMIC_TEXTBOX("tracking-number"))
                                    )
                            );
                        actor.attemptsTo(
                                Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("reference-number")).isNotDisplayed()
                        );
                    }
                }
        );
    }
}

package steps.admin.inventory;

import cucumber.tasks.admin.orders.HandleOrders;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.inventory.HandleIncomingInventory;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.*;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.inventory.IncomingInventoryDetailPage;
import cucumber.user_interface.admin.inventory.IncomingInventoryPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.*;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.*;

public class IncomingInventoryStepDefinitions {
    CommonVerify commonVerify = new CommonVerify();

    @And("Admin create new incoming inventory")
    public void create_new_inventory(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.createIncomingGeneral(infos.get(0))
        );
    }

    @And("With SKUs")
    public void create_new_inventory_sku(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> info : infos) {
            HashMap<String, String> info2 = CommonTask.setValueRandom(info, "sku", Serenity.sessionVariableCalled("SKU inventory"));
            theActorInTheSpotlight().attemptsTo(
                    HandleIncomingInventory.createIncomingSKU(info2)
            );
        }
    }

    @And("Check SKUs on create new incoming inventory form")
    public void check_create_new_inventory_sku(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
//            HashMap<String, String> info = CommonTask.setValueRandom(list.get(0), "lotCodeSKU", Serenity.sessionVariableCalled("Lot Code Inbound " + (i + 1)));
//            if (list.get(i).get("lotCodeSKU").equals("randomInbound")) {
//                info = CommonTask.setValueRandom2(list.get(i), "lotCodeSKU", "randomInbound", Serenity.sessionVariableCalled("Lot Code Inbound " + list.get(i).get("nameSKU") + " " + list.get(i).get("index")));
//                System.out.println("Lot Code Inbound " + list.get(i).get("nameSKU") + " " + list.get(i).get("index") + " : " + Serenity.sessionVariableCalled("Lot Code Inbound " + list.get(i).get("nameSKU") + " " + list.get(i).get("index")));
//            }
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(IncomingInventoryPage.SKU_BRAND(list.get(i).get("nameSKU"), list.get(i).get("index"))).text().contains(list.get(i).get("brandSKU")),
                    Ensure.that(IncomingInventoryPage.SKU_PRODUCT(list.get(i).get("nameSKU"), list.get(i).get("index"))).text().contains(list.get(i).get("productSKU")),
                    Ensure.that(IncomingInventoryPage.SKU_NAME(list.get(i).get("nameSKU"), list.get(i).get("index"))).text().contains(list.get(i).get("nameSKU")),
                    Ensure.that(IncomingInventoryPage.SKU_UPC(list.get(i).get("nameSKU"), list.get(i).get("index"))).text().contains(list.get(i).get("unitUpc")),
                    Ensure.that(IncomingInventoryPage.SKU_UNIT(list.get(i).get("nameSKU"), list.get(i).get("index"))).text().contains(list.get(i).get("caseUnit")),
                    Ensure.that(IncomingInventoryPage.SKU_MASTER_CARTON(list.get(i).get("nameSKU"), list.get(i).get("index"))).text().contains(list.get(i).get("masterCarton")),
                    Ensure.that(IncomingInventoryPage.SKU_OF_CASE(list.get(i).get("nameSKU"), list.get(i).get("index"))).attribute("value").contains(list.get(i).get("ofCaseSKU")),
                    Ensure.that(IncomingInventoryPage.SKU_STORE_SHELF_LIFE(list.get(i).get("nameSKU"), list.get(i).get("index"))).isDisabled(),
                    Ensure.that(IncomingInventoryPage.SKU_STORE_SHELF_LIFE(list.get(i).get("nameSKU"), list.get(i).get("index"))).attribute("value").contains(list.get(i).get("storeShelfLife")),
                    Ensure.that(IncomingInventoryPage.SKU_TEMPERATURE(list.get(i).get("nameSKU"), list.get(i).get("index"))).isDisabled(),
                    Ensure.that(IncomingInventoryPage.SKU_TEMPERATURE(list.get(i).get("nameSKU"), list.get(i).get("index"))).attribute("value").contains(list.get(i).get("temperature"))
            );
        }
    }

    @And("Search line item {string} and check list SKU incoming inventory")
    public void searchAndCheckList(String item, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        if (item.equals("random")) {
            item = Serenity.sessionVariableCalled("SKU inventory");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.searchSKU(item)
        );
        for (Map<String, String> info : infos) {
            if (info.get("show").equals("show"))
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(IncomingInventoryDetailPage.ITEM_INFO(info.get("sku"), "brand")).text().containsIgnoringCase(info.get("brand")),
                        Ensure.that(IncomingInventoryDetailPage.ITEM_INFO(info.get("sku"), "product")).text().containsIgnoringCase(info.get("product")),
                        Ensure.that(IncomingInventoryDetailPage.ITEM_INFO(info.get("sku"), "price")).text().isEqualTo(info.get("price")),
                        Ensure.that(IncomingInventoryDetailPage.ITEM_INFO(info.get("sku"), "status")).text().contains(info.get("status"))
                );
            else theActorInTheSpotlight().attemptsTo(
                    Ensure.that(IncomingInventoryDetailPage.ITEM_INFO(info.get("sku"), "brand")).isNotDisplayed()
            );
        }
    }

    @And("Confirm Create Incoming inventory")
    public void confirm_create_new_inventory() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(IncomingInventoryPage.CREATE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("Incoming inventory has been saved successfully !!")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
        String[] num = IncomingInventoryPage.NUMBER_INVENTORY.resolveFor(theActorInTheSpotlight()).getText().split(" - ");
        String num1 = num[1];
        Serenity.setSessionVariable("Inventory_Reference").to(num1);
    }

    @And("Admin search incoming inventory")
    public void search_inventory(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : infos) {
            HashMap<String, String> random = CommonTask.setValue2(map, "number", map.get("number"), Serenity.sessionVariableCalled("Number Inbound Inventory api"), "create by api");
            random = CommonTask.setValue2(random, "number", random.get("number"), Serenity.sessionVariableCalled("Inventory_Reference"), "create by admin");
            theActorInTheSpotlight().attemptsTo(
                    HandleIncomingInventory.searchIncomingInventory(random)
            );
        }
    }

    @And("Admin choose options on dropdown {string}")
    public void choose_option_dropdown(String field, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_INPUT2(field)),
                Click.on(CommonAdminForm.DYNAMIC_INPUT2(field))
        );
        for (Map<String, String> map : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(map.get("option"))),
                    Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(map.get("option")))
            );
        }
    }

    @And("Admin choose options on dropdown {string} input with value {string}")
    public void choose_option_dropdown2(String field, String value, DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_INPUT2(field)),
                Click.on(CommonAdminForm.DYNAMIC_INPUT2(field)),
                Enter.theValue(value).into(CommonAdminForm.DYNAMIC_INPUT2(field))
        );
        for (Map<String, String> map : infos) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(map.get("option"))),
                    Click.on(CommonAdminForm.DYNAMIC_ITEM_DROPDOWN(map.get("option")))
            );
        }
    }

    @And("Verify table result Incoming inventory")
    public void verify_result_inventory(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValue(expected.get(0), "number", expected.get(0).get("number"), Serenity.sessionVariableCalled("Inventory_Reference"), "");
        info = CommonTask.setValue2(info, "number", info.get("number"), Serenity.sessionVariableCalled("Number Inbound Inventory api"), "create by api");
        info = CommonTask.setValue2(info, "number", info.get("number"), Serenity.sessionVariableCalled("Inventory_Reference"), "create by admin");
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(IncomingInventoryPage.DYNAMIC_RESULT_IN_TABLE("number")).text().contains(info.get("number")),
                Ensure.that(IncomingInventoryPage.DYNAMIC_RESULT_IN_TABLE3("vendor-company")).attribute("data-original-text").contains(info.get("vendorCompany")),
                Ensure.that(IncomingInventoryPage.DYNAMIC_RESULT_IN_TABLE("brand")).text().contains(info.get("brand")),
                Check.whether(info.get("eta").equals(""))
                        .otherwise(Ensure.that(IncomingInventoryPage.ETA).text().contains(CommonHandle.setDate2(info.get("eta"), "MM/dd/yy"))),
                Ensure.that(IncomingInventoryPage.DYNAMIC_RESULT_IN_TABLE("status")).text().contains(info.get("status"))
        );
        if (info.containsKey("lpReview")) {

        }

    }

    @And("Go to detail of incoming inventory number {string}")
    public void goToDetail(String number) {
        String num = number;
        if (number.isEmpty())
            num = Serenity.sessionVariableCalled("Inventory_Reference");
        if (number.contains("create by api"))
            num = Serenity.sessionVariableCalled("Number Inbound Inventory api");
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.goToDetail(num)
        );
    }

    @And("Admin close submit incoming inventory")
    public void close_submit() {
        theActorInTheSpotlight().attemptsTo(
                Scroll.to(CommonAdminForm.CLOSE_POPUP2),
                Click.on(CommonAdminForm.CLOSE_POPUP2)
        );
    }

    @And("Admin check General Information of Incoming inventory")
    public void admin_check_general_information_of_incoming_inventory(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.GENERAL_INFOMATION_HEADER),
                Scroll.to(IncomingInventoryDetailPage.GENERAL_INFOMATION_HEADER));
        commonVerify
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.REGION_FIELD, list.get(0).get("region"))
                .verifyTargetTextContain(theActorInTheSpotlight(), IncomingInventoryDetailPage.DELIVERY_METHOD_FIELD, list.get(0).get("deliveryMethod"))
                .verifyTargetTextContain(theActorInTheSpotlight(), IncomingInventoryDetailPage.VENDOR_COMPANY, list.get(0).get("vendorCompany"))
                .verifyTargetTextContain(theActorInTheSpotlight(), IncomingInventoryDetailPage.WAREHOUSE_FIELD, list.get(0).get("warehouse"))
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.D_FIELD_IN_GENERAL3("LP review"), list.get(0), "lpReview")
                .verifyTargetTextContain(theActorInTheSpotlight(), IncomingInventoryDetailPage.ETA, CommonHandle.setDate2(list.get(0).get("eta"), "MM/dd/yy"))
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.STATUS, list.get(0).get("status"))
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.OF_PALLET, list.get(0).get("ofPallet"))
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.OF_SELLABLE_RETAIL, list.get(0).get("ofSellableRetail"))
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.OF_MASTER_CARTON, list.get(0).get("ofMasterCarton"))
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.OF_SELLABLE_RETAIL_MASTER_CARTON, list.get(0).get("ofSellableRetailPerCarton"))
                .verifyTargetTextContain(theActorInTheSpotlight(), IncomingInventoryDetailPage.ZIP_CODE, list.get(0).get("zipCode"))
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.ETW, list.get(0), "etw")
                .verifyTargetTextContain(theActorInTheSpotlight(), IncomingInventoryDetailPage.TRACKING_NUMBER, list.get(0), "trackingNumber")
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.D_FIELD_IN_GENERAL3("Are the pallets stackable in transit?"), list.get(0), "palletTransit")
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.D_FIELD_IN_GENERAL3("Are the pallets stackable in the warehouse?"), list.get(0), "palletWarehouse")
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.D_FIELD_IN_GENERAL3("Total weight of shipment?"), list.get(0), "totalWeight")
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.D_FIELD_IN_GENERAL5("Notes"), list.get(0), "note")
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.D_FIELD_IN_GENERAL5("Admin note"), list.get(0), "adminNote")
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.D_FIELD_IN_GENERAL4("Other special shipping details"), list.get(0), "otherShipping")
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.D_FIELD_IN_GENERAL4("Freight Carrier"), list.get(0), "freightCarrier")
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.D_FIELD_IN_GENERAL3("Reference Number"), list.get(0), "referenceNumber")
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.D_FIELD_IN_GENERAL3("Name"), list.get(0), "transportName")
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.D_FIELD_IN_GENERAL3("Phone number"), list.get(0), "transportPhone")
                .verifyTargetTextEqual(theActorInTheSpotlight(), IncomingInventoryDetailPage.D_FIELD_IN_GENERAL3("Transfer inbound?"), list.get(0), "transfer")
                .verifyTargetTextContain(theActorInTheSpotlight(), IncomingInventoryDetailPage.BOL_NAME, list.get(0), "bol")
                .verifyTargetTextContain(theActorInTheSpotlight(), IncomingInventoryDetailPage.POD_NAME, list.get(0), "pod")
        ;

    }

    @And("Admin check general information optional of Incoming inventory")
    public void admin_check_general_information_optional_of_incoming_inventory(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL("Are the pallets stackable in transit?")).text().contains(list.get(0).get("palletTransit")),
                Ensure.that(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL("Are the pallets stackable in the warehouse?")).text().contains(list.get(0).get("palletWarehouse")),
                Ensure.that(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL("Name")).text().contains(list.get(0).get("transportName")),
                Ensure.that(IncomingInventoryDetailPage.D_FIELD_IN_GENERAL("Phone number")).text().contains(list.get(0).get("transportPhone")),
                Ensure.that(IncomingInventoryDetailPage.BOL_FIELD).text().contains(list.get(0).get("bol"))
        );
    }

    @And("Admin check all field of incoming inventory is disable")
    public void checkFieldsDisable() {
        theActorInTheSpotlight().attemptsTo(
                CommonQuestions.AskForNumberElement(IncomingInventoryDetailPage.ALL_FIELD_DISABLE, 1));
    }

    @And("Admin redirect {string} from list SKU of Incoming inventory")
    public void redirectBrandProductSKUFromIncoming(String value) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.REDIRECT_SKU(value)),
                Scroll.to(IncomingInventoryDetailPage.REDIRECT_SKU(value)),
                Click.on(IncomingInventoryDetailPage.REDIRECT_SKU(value)),
                WindowTask.threadSleep(3000)
        );
    }

    @And("Check SKUs Information of Incoming inventory")
    public void checkSKuInformation(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (int i = 0; i < list.size(); i++) {
            HashMap<String, String> info = CommonTask.setValue(list.get(i), "lotCodeSKU", list.get(i).get("lotCodeSKU"), Serenity.sessionVariableCalled("Lot Code Inbound " + (i + 1)), "random");
            if (list.get(i).get("lotCodeSKU").equals("randomInbound")) {
                info = CommonTask.setValueRandom2(list.get(i), "lotCodeSKU", "randomInbound", Serenity.sessionVariableCalled("Lot Code Inbound " + list.get(i).get("nameSKU") + " " + list.get(i).get("index")));
                System.out.println("Lot Code Inbound " + list.get(i).get("nameSKU") + " " + list.get(i).get("index") + " : " + Serenity.sessionVariableCalled("Lot Code Inbound " + list.get(i).get("nameSKU") + " " + list.get(i).get("index")));
            }
            commonVerify
                    .verifyTargetTextContain(IncomingInventoryDetailPage.SKU_BRAND(info.get("nameSKU"), info.get("index")), info, "brandSKU")
                    .verifyTargetTextContain(IncomingInventoryDetailPage.SKU_PRODUCT(info.get("nameSKU"), info.get("index")), info, "productSKU")
                    .verifyTargetTextContain(IncomingInventoryDetailPage.SKU_NAME(info.get("nameSKU"), info.get("index")), info, "nameSKU")
                    .verifyTargetTextContain(IncomingInventoryDetailPage.SKU_INFO(info.get("nameSKU"), "case-upc", info.get("index")), info, "unitUPC")
                    .verifyTargetTextContain(IncomingInventoryDetailPage.SKU_INFO(info.get("nameSKU"), "unit-upc", info.get("index")), info, "caseUPC")
                    .verifyTargetTextContain(IncomingInventoryDetailPage.SKU_INFO(info.get("nameSKU"), "units", info.get("index")), info, "casePerPallet")
                    .verifyTargetTextContain(IncomingInventoryDetailPage.SKU_INFO(info.get("nameSKU"), "cases-per-master-carton", info.get("index")), info, "casePerCarton")
                    .verifyTargetAttributeTextContain(IncomingInventoryDetailPage.SKU_LOTCODE(info.get("nameSKU"), info.get("index")), "value", info, "lotCodeSKU")
                    .verifyTargetAttributeTextContain(IncomingInventoryDetailPage.SKU_OF_CASE(info.get("nameSKU"), info.get("index")), "value", info, "ofCaseSKU")
                    .verifyTargetAttributeTextContain(IncomingInventoryDetailPage.SKU_EXPIRATION_DATE(info.get("nameSKU"), info.get("index")), "value", info, "expiryDateSKU", CommonHandle.setDate2(info.get("expiryDateSKU"), "MM/dd/yy"))
                    .verifyTargetAttributeTextContain(IncomingInventoryDetailPage.SKU_RECEIVE_DATE(info.get("nameSKU"), info.get("index")), "value", info, "receivingDateSKU", CommonHandle.setDate2(info.get("receivingDateSKU"), "MM/dd/yy"))
                    .verifyTargetTextEqualNotBlank(IncomingInventoryDetailPage.BADGE_SKU(info.get("nameSKU")), info, "badge")
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.SKU_STORAGE_SHELF_LIFE(info.get("nameSKU"), info.get("index")), "value", info, "storageShelfLife")
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.SKU_STORAGE_SHELF_LIFE_CONDITION(info.get("nameSKU"), info.get("index")), "value", info, "storageShelfLifeCondition")
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.SKU_TEMPERATURE(info.get("nameSKU"), info.get("index")), "value", info, "temperature")
                    .verifyTargetTextEqualNotBlank(IncomingInventoryDetailPage.SKU_TEMPERATURE_CONDITION(info.get("nameSKU"), info.get("index")), info, "temperatureCondition")
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.SKU_SUGGEST_CASE(info.get("nameSKU"), info.get("index")), "value", info, "suggestedCase")
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.SKU_DAMAGED_CASE(info.get("nameSKU"), info.get("index")), "value", info, "damagedCase")
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.SKU_EXCESS_CASE(info.get("nameSKU"), info.get("index")), "value", info, "excessCase")
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.SKU_SHORTED_CASE(info.get("nameSKU"), info.get("index")), "value", info, "shortedCase")
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.SKU_RECEIVED_CASE(info.get("nameSKU"), info.get("index")), "value", info, "receivedCase")
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.NOTE(info.get("nameSKU"), info.get("index")), "value", info, "note")
            ;
        }
    }

    @And("Add the warehouse {string} for incoming inventory")
    public void addDistribution(String warehouse) {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.chooseDistribution(warehouse)
        );
    }

    @And("Approve for this incoming inventory")
    public void approveInventory() {
        theActorCalled("ADMIN").attemptsTo(
                Click.on(IncomingInventoryDetailPage.APPROVE_BUTTON),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.OK_BUTTON),
                Click.on(IncomingInventoryDetailPage.OK_BUTTON),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.MESSAGE_SUCCSESS)
        );
    }

    @And("Admin Process for this incoming inventory")
    public void processInventory() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(IncomingInventoryDetailPage.PROCESS_BUTTON),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.OK_BUTTON),
                Click.on(IncomingInventoryDetailPage.OK_BUTTON),
                CommonWaitUntil.isNotVisible(IncomingInventoryDetailPage.MESSAGE_SUCCSESS)
        );
    }

    @And("Admin submit incoming inventory")
    public void admin_submit_incoming_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            String lotCode = "Lot code" + Utility.getRandomString(5);
            Serenity.setSessionVariable("Lot Code Inbound " + item.get("skuName") + " " + item.get("index")).to(lotCode);
            System.out.println("Lot Code Inbound " + item.get("skuName") + " " + item.get("index") + Serenity.sessionVariableCalled("Lot Code Inbound " + item.get("skuName") + " " + item.get("index")));
            HashMap<String, String> info = CommonTask.setValue(item, "lotCode", item.get("lotCode"), lotCode, "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleIncomingInventory.changeStatusIncomingInventory("Confirmed"),
                    HandleIncomingInventory.fillInfoInSubmitForm(list.get(0)),
                    HandleIncomingInventory.fillInfoSKUInSubmitForm(info)
//                    HandleIncomingInventory.submitIncomingInventory()
            );
            theActorInTheSpotlight().attemptsTo(
                    HandleIncomingInventory.submitIncomingInventory()
            );
        }
    }

    @And("Admin fill submit incoming inventory form")
    public void admin_fill_submit_incoming_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.fillInfoInSubmitForm2(list.get(0))
        );
    }

    @And("Admin fill sku info submit incoming inventory form")
    public void admin_fill_sku_submit_incoming_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            String lotCode = "Lot code" + Utility.getRandomString(5);
            Serenity.setSessionVariable("Lot Code Inbound " + item.get("skuName") + " " + item.get("index")).to(lotCode);
            System.out.println("Lot Code Inbound " + item.get("skuName") + " " + item.get("index") + Serenity.sessionVariableCalled("Lot Code Inbound " + item.get("skuName") + " " + item.get("index")));
            HashMap<String, String> info = CommonTask.setValue(item, "lotCode", item.get("lotCode"), lotCode, "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleIncomingInventory.fillInfoSKUInSubmitForm(info)
            );
        }

    }

    @And("Admin check submit incoming inventory form")
    public void admin_check_submit_incoming_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        commonVerify
                .verifyTargetTextContain(IncomingInventoryDetailPage.D_SPAN_TEXT("vendor-company bold"), list.get(0), "vendorCompany")
                .verifyTargetTextContain(IncomingInventoryDetailPage.D_SPAN_TEXT("region bold"), list.get(0), "region")
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("delivery-method"), "value", list.get(0), "deliveryMethod")
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("el-date-editor eta"), "value", list.get(0), "eta", CommonHandle.setDate2(list.get(0).get("eta"), "MM/dd/yy"))
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("num-pallet"), "value", list.get(0), "ofPallet")
                .verifyTargetTextContain(IncomingInventoryDetailPage.D_SPAN_TEXT("num_sellable-retail-case number"), list.get(0), "ofSellable")
                .verifyTargetTextContain(IncomingInventoryDetailPage.D_SPAN_TEXT("num-of-master-carton"), list.get(0), "ofMasterCarton")
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("retail-per-master-carton"), "value", list.get(0), "ofSellableMasterCarton")
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("other-details"), "value", list.get(0), "otherDetail")
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("freight-carrier"), "value", list.get(0), "freightCarrier")
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("tracking-number"), "value", list.get(0), "trackingNumber")
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("reference-number"), "value", list.get(0), "referenceNumber")
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("transit-stackable"), "value", list.get(0), "stackableTransit")
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("warehouse-stackable"), "value", list.get(0), "stackableWarehouse")
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("total-weight"), "value", list.get(0), "totalWeight")
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("zip-code"), "value", list.get(0), "zioCode")
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("transport-coordinator-name"), "value", list.get(0), "transportName")
                .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.D_TEXTBOX("transport-coordinator-phone"), "value", list.get(0), "transportPhone")
        ;
    }

    @And("Admin check SKU section submit incoming inventory form")
    public void admin_check_sku_submit_incoming_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            commonVerify
                    .verifyTargetTextContain(IncomingInventoryDetailPage.SKU_IN_SUBMIT("brand", map.get("index")), map, "brand")
                    .verifyTargetTextContain(IncomingInventoryDetailPage.SKU_IN_SUBMIT("product", map.get("index")), map, "product")
                    .verifyTargetTextContain(IncomingInventoryDetailPage.SKU_IN_SUBMIT("variant", map.get("index")), map, "sku")
                    .verifyTargetTextContain(IncomingInventoryDetailPage.SKU_IN_SUBMIT("units", map.get("index")), map, "units")
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.SKU_IN_SUBMIT2("lot-code", map.get("index")), "value", map, "lotCode")
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.SKU_IN_SUBMIT2("quantity ", map.get("index")), "value", map, "ofCases")
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.SKU_IN_SUBMIT3("Expiration Date", map.get("index")), "value", map, "expirationData", CommonHandle.setDate2(map.get("expirationData"), "MM/dd/yy"))
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.SKU_IN_SUBMIT3("Receiving Date", map.get("index")), "value", map, "receivingData", CommonHandle.setDate2(map.get("receivingData"), "MM/dd/yy"))
                    .verifyTargetAttributeTextEqual(IncomingInventoryDetailPage.SKU_IN_SUBMIT_NOTE("Note", map.get("index")), "value", map, "note")
            ;
        }
    }

    @And("Admin changes status incoming inventory to {string}")
    public void admin_changes_status_incoming_inventory(String status) {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.changeStatusIncomingInventory(status)
        );
    }

    @And("Admin confirm incoming inventory")
    public void admin_confirm_incoming_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            String lotCode = "Lot code" + Utility.getRandomString(5);
            Serenity.setSessionVariable("Lot Code Inbound " + item.get("skuName") + " " + item.get("index")).to(lotCode);
            System.out.println("Lot Code Inbound " + item.get("skuName") + " " + item.get("index") + Serenity.sessionVariableCalled("Lot Code Inbound " + item.get("skuName") + " " + item.get("index")));
            HashMap<String, String> info = CommonTask.setValue(item, "lotCode", item.get("lotCode"), lotCode, "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleIncomingInventory.changeStatusIncomingInventory("Confirmed"),
                    HandleIncomingInventory.fillInfoInSubmitForm(list.get(0)),
                    HandleIncomingInventory.fillInfoSKUInSubmitForm(info),
                    HandleIncomingInventory.submitIncomingInventory()
            );
        }
    }

    @And("Admin upload POD to incoming inventory")
    public void admin_uploadPOD_incoming_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo();
        }
    }

    @And("Admin {string} warehouse is {string}")
    public void admin_choose_warehouse(String type, String warehouse) {
        theActorInTheSpotlight().attemptsTo(
                Check.whether(type.equals("choose"))
                        .andIfSo(
                                HandleIncomingInventory.chooseWarehouse(warehouse)
                        )
        );
    }

    @And("Admin process incoming inventory")
    public void admin_process_incoming_inventory() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.process()
        );
    }

    @And("Admin process incoming inventory error")
    public void admin_process_incoming_inventory_error() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.processError()
        );
    }

    @And("Admin add sku into incoming inventory then update request")
    public void admin_add_sku_into_incoming_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    HandleIncomingInventory.addSKU(item)
            );
        }
    }

    @And("Admin cancel incoming inventory in result")
    public void admin_delete_incoming_inventory_in_result(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        String orderID = null;
        if (infos.get(0).get("order").equals("")) {
            orderID = Serenity.sessionVariableCalled("Inventory_Reference");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.cancelRequestInResult(orderID, infos.get(0).get("note"))
        );
    }

    @And("Admin cancel incoming inventory in detail with note {string}")
    public void admin_delete_incoming_inventory_in_detail(String note) {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.cancelRequestInDetail(note)
        );
    }

    @And("Admin no found request in result incoming inventory")
    public void admin_no_found_request_in_result_incoming_inventory() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(IncomingInventoryPage.NO_FOUND_DATA).isDisplayed()
        );
    }

    @And("Admin edit general information of incoming inventory")
    public void admin_edit_general_information_of_incoming_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.editInfoGeneralInformation(list.get(0))
        );
    }

    @And("Admin edit delivery method of incoming inventory")
    public void admin_edit_delivery_method_of_incoming_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.editDelivery(list.get(0))
        );
    }

    @And("Admin edit sku information")
    public void admin_edit_sku_information(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            HashMap<String, String> info = CommonTask.setValueRandom2(item, "lotcode", "randomInbound", Serenity.sessionVariableCalled("Lot Code Inbound " + item.get("skuName") + " " + item.get("index")));
            theActorInTheSpotlight().attemptsTo(
                    HandleIncomingInventory.editInfoSKU(info)
            );
        }
    }

    @And("Admin remove SKU {string} from incoming inventory")
    public void remove_sku(String sku) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(IncomingInventoryPage.REMOVE_SKU(sku)),
                Click.on(IncomingInventoryPage.REMOVE_SKU(sku)),
                Ensure.that(IncomingInventoryPage.SKU_NAME(sku, "1")).isNotDisplayed()
        );
    }

    @And("Admin save record Confirmed after change")
    public void admin_save_record_after_change() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.saveAfterChange()
        );
    }

    @And("Admin change {string} to {string} of incoming inventory")
    public void admin_change_vendor_company_of_incoming_inventory(String type, String value) {
        switch (type) {
            case "vendor company":
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipDropdownWithInput(IncomingInventoryDetailPage.VENDOR_COMPANY, value));
                break;
            case "region":
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipDropdown(IncomingInventoryDetailPage.REGION_FIELD, value));
                break;
            case "warehouse":
                theActorInTheSpotlight().attemptsTo(
                        CommonTaskAdmin.changeValueTooltipDropdownWithInput(IncomingInventoryDetailPage.WAREHOUSE_FIELD1, value));
                break;
        }
    }

    @And("Admin change region to {string} of incoming inventory")
    public void admin_change_region_of_incoming_inventory(String region) {
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.changeValueTooltipDropdown(IncomingInventoryDetailPage.REGION_FIELD, region)
        );
    }

    @And("Admin verify no sku in sku information of incoming inventory")
    public void admin_verify_no_sku_in_sku_information() {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(IncomingInventoryDetailPage.NO_SKU).isDisplayed()
        );
    }

    @And("Admin verify signed WPL")
    public void admin_verify_signed_WPL(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(IncomingInventoryDetailPage.WPL_INPUT(item.get("index"))).attribute("value").contains(item.get("fileName"))
            );
        }
    }

    @And("Admin upload signed WPL")
    public void admin_upload_signed_WPL(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                    Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a document")),
                    CommonWaitUntil.isPresent(IncomingInventoryDetailPage.WPL_INPUT),
                    CommonFile.upload(item.get("wpl"), IncomingInventoryDetailPage.WPL_INPUT)
            );
        }

    }

    @And("Admin save signed WPL number")
    public void admin_save_signed_WPL() {
        theActorInTheSpotlight().attemptsTo(
//                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Save")),
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.SAVE_WPL),
                Click.on(IncomingInventoryDetailPage.SAVE_WPL).afterWaitingUntilEnabled(),
                WindowTask.threadSleep(2000)
        );
    }

    @And("Admin remove signed WPL number {string}")
    public void admin_remove_signed_WPL(String index) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(IncomingInventoryDetailPage.WPL_REMOVE(index)),
                Click.on(IncomingInventoryDetailPage.WPL_REMOVE(index)),
                WindowTask.threadSleep(1000)
        );
    }

    @And("Admin upload file to inbound")
    public void admin_upload_file_to_inbound(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.uploadFile(infos.get(0))
        );
    }

    @And("Admin choose {string} mark inbound as received")
    public void admin_mark_inbound_as_received(String type) {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.markAsReceived(type)
        );
    }

    @And("Admin update inbound inventory images")
    public void admin_update_inbound_inventory_images(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.uploadInventoryImage(infos)
        );
    }

    @And("Admin remove inbound inventory images")
    public void admin_remove_inbound_inventory_images(DataTable dt) {
        List<Map<String, String>> infos = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : infos)
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(IncomingInventoryDetailPage.IMAGE_REMOVE(map.get("index"))),
                    Click.on(IncomingInventoryDetailPage.IMAGE_REMOVE(map.get("index"))),
                    WindowTask.threadSleep(1000)
            );
    }

    @And("Admin save inbound inventory images")
    public void admin_save_inbound_inventory_images() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(IncomingInventoryDetailPage.IMAGE_SAVE),
                WindowTask.threadSleep(2000)
        );
    }

    @And("Admin save inbound inventory images success")
    public void admin_save_inbound_inventory_images_success() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(IncomingInventoryDetailPage.IMAGE_SAVE),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin verify inbound inventory images")
    public void admin_verify_inbound_inventory_images() {
        theActorInTheSpotlight().attemptsTo(
                //open upload file
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("Add a photo")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Add a photo")),
                CommonWaitUntil.isPresent(IncomingInventoryDetailPage.REMOVE_IMAGE_BUTTON("1")),

                // dont upload file
                Click.on(IncomingInventoryDetailPage.IMAGE_SAVE),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("param is missing or the value is empty: inbound_inventory")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON),

                // upload file >10MB
                CommonFile.upload2("10MBgreater.jpg", IncomingInventoryDetailPage.IMAGE_INDEX("1")),
                Click.on(IncomingInventoryDetailPage.IMAGE_SAVE),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Maximum file size exceeded.")),

                // upload file not type jpg
                CommonFile.upload1("autotest.csv", IncomingInventoryDetailPage.IMAGE_INDEX("1")),
                Click.on(IncomingInventoryDetailPage.IMAGE_SAVE),
                CommonWaitUntil.isVisible(CommonAdminForm.D_MESSAGE_POPUP("Validation failed: Inbound inventory images attachment content type is invalid")),
                Click.on(CommonAdminForm.ALERT_CLOSE_BUTTON),

                // Close add image
                Click.on(IncomingInventoryDetailPage.REMOVE_IMAGE_BUTTON("1"))
        );
    }

    @And("Admin subscribe incoming inventory")
    public void admin_subscribe_order() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.subscribe()
        );
    }

    @And("Admin unsubscribe incoming inventory")
    public void admin_unsubscribe_incoming() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.unsubscribe()
        );
    }

    @And("Admin download {string} PDF incoming inventory")
    public void admin_download_pdf_incoming(String type) {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.exportPDFParkingSlip(type)
        );
    }

    @And("Admin download Excel incoming inventory")
    public void admin_download_excel_incoming() {
        theActorInTheSpotlight().attemptsTo(
                HandleIncomingInventory.exportExcel()
        );
    }

    @And("Admin view changelog incoming inventory")
    public void admin_view_changelog_incoming(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_BUTTON("View changelog")),
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("View changelog"))
        );
        for (int i = 0; i < infos.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(IncomingInventoryDetailPage.TOOLTIP_CHANGELOG("value", i + 1)),
                    Ensure.that(IncomingInventoryDetailPage.TOOLTIP_CHANGELOG("value", i + 1)).text().contains(infos.get(i).get("state")),
                    Ensure.that(IncomingInventoryDetailPage.TOOLTIP_CHANGELOG("initated-by", i + 1)).text().contains(infos.get(i).get("updateBy")),
                    Ensure.that(IncomingInventoryDetailPage.TOOLTIP_CHANGELOG("date", i + 1)).text().contains(CommonHandle.setDate2(infos.get(i).get("updateOn"), "MM/dd/yy"))
            );
        }
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("View changelog")),
                CommonWaitUntil.isNotVisible(IncomingInventoryDetailPage.TOOLTIP_CHANGELOG("value", 1))
        );
    }

    @And("Admin view eta history incoming inventory")
    public void admin_view_eta_incoming(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_SPAN_TEXT("Estimated Date of Arrival")),
                Click.on(CommonAdminForm.DYNAMIC_SPAN_TEXT("Estimated Date of Arrival"))
        );
        for (int i = 0; i < infos.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(IncomingInventoryDetailPage.TOOLTIP_CHANGELOG("value", i + 1)),
                    Ensure.that(IncomingInventoryDetailPage.TOOLTIP_CHANGELOG("value", i + 1)).hasTrimmedTextContent(CommonHandle.setDate2(infos.get(i).get("oldEta"), "MM/dd/yy") + "→ " + CommonHandle.setDate2(infos.get(i).get("newEta"), "MM/dd/yy")),
                    Ensure.that(IncomingInventoryDetailPage.TOOLTIP_CHANGELOG("initated-by", i + 1)).text().contains(infos.get(i).get("updateBy")),
                    Ensure.that(IncomingInventoryDetailPage.TOOLTIP_CHANGELOG("date", i + 1)).text().contains(CommonHandle.setDate2(infos.get(i).get("updateOn"), "MM/dd/yy"))
            );
        }
        theActorInTheSpotlight().attemptsTo(
                MoveMouse.to(CommonAdminForm.DYNAMIC_HEADER_BUTTON("Excel")),
                CommonWaitUntil.isNotVisible(IncomingInventoryDetailPage.TOOLTIP_CHANGELOG("value", 1))
        );
    }

    @And("Admin reactivate incoming inventory")
    public void admin_reactivate_incoming() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_HEADER_BUTTON("Reactivate")),
                Click.on(CommonAdminForm.DYNAMIC_HEADER_BUTTON("Reactivate")),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("Are you sure you want to reactivate this inventory?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Yes")).afterWaitingUntilEnabled(),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ALERT("Inventory has been updated successfully !!")),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT("Inventory has been updated successfully !!"))

        );
    }

}

package steps.vendor.Inventory;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.Utility;
import cucumber.tasks.vendor.inventory.HandleAllInventory;
import cucumber.tasks.vendor.inventory.HandleInventoryStatus;
import cucumber.tasks.vendor.inventory.HandleSendInventory;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.inventory.AllInventoryPage;
import cucumber.user_interface.beta.Vendor.inventory.InventoryStatusPage;
import cucumber.user_interface.beta.Vendor.inventory.VendorInventoryPage;
import cucumber.user_interface.lp.CommonLPPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static cucumber.constants.vendor.WebsiteConstants.*;
import static cucumber.constants.vendor.WebsiteConstants.FL_FLOWSPACE;
import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.CoreMatchers.containsString;

public class VendorSendInventoryDefinition {
    @And("{word} search inbound inventory")
    public void search_inbound_inventory(String actor, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorCalled(actor).attemptsTo(
                HandleSendInventory.searchInboundInventory(list.get(0))
        );
    }

    @And("Vendor search inbound inventory on tab {string}")
    public void search_inbound_inventory_on_tab(String tab, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> map : list)
            theActorInTheSpotlight().attemptsTo(
                    HandleSendInventory.searchInboundInventory(tab, map)
            );
    }

    @And("Vendor verify no found inbound inventory {string}")
    public void vendor_verify_no_found_inbound_inventory(String inbound) {
        if (inbound.equals("")) {
            inbound = Serenity.sessionVariableCalled("Inventory_Reference");
        }
        if (inbound.equals("create by api")) {
            inbound = Serenity.sessionVariableCalled("Number Inbound Inventory api");
        }
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorInventoryPage.POD_INBOUND_REFERENCE_BY_ID(inbound)).isNotDisplayed()
        );
    }

    @And("Vendor verify instructions of region {string} in Inbound detail")
    public void vendor_verify_instruction_in_inbound_detail(String region) {
        String exptected = null;
        switch (region) {
            case "Dallas Express":
                exptected = INSTRUCTIONS_TEXAS;
                break;
            case "Chicagoland Express":
                exptected = INSTRUCTIONS_CHICAGOLAND;
                break;
            case "Florida Express":
                exptected = INSTRUCTIONS_FLORIDA;
                break;
            case "Mid Atlantic Express":
                exptected = INSTRUCTIONS_MID_ATLANTIC;
                break;
            case "New York Express":
                exptected = INSTRUCTIONS_NEW_YORK;
                break;
            case "North California Express":
                exptected = INSTRUCTIONS_NORTH_CALIFORNIA;
                break;
            case "South California Express":
                exptected = INSTRUCTIONS_SOUTH_CALIFORNIA;
                break;
            case "Denver Express":
                exptected = INSTRUCTIONS_DENVER;
                break;
            case "Atlanta Express":
                exptected = INSTRUCTIONS_ATLANTA;
                break;
            case "Phoenix Express":
                exptected = INSTRUCTIONS_PHOENIX;
                break;
            case "Sacramento Express":
                exptected = INSTRUCTIONS_SACRAMENTO;
                break;
            case "Fox Valley Farms":
                exptected = FOX_VALLEY_FARMS_CHI;
                break;
            case "Saroni Food Service":
                exptected = SARONI_FOOD_SERVICE;
                break;
            case "LA - Jacmar":
                exptected = JACMAR;
                break;
            case "SCAL -- One World Direct":
                exptected = SCAL_ONE_WORLD_DIRECT;
                break;
            case "Polar Crossing":
                exptected = NY_POLAR_CROSSING;
                break;
            case "TX -- Frozen Logistics":
                exptected = FROZEN_LOGISTICS;
                break;
            case "TX -- Fresh One":
                exptected = FRESH_ONE;
                break;
            case "Chad's Cold Transport":
                exptected = CHAD_COLD_TRANSPORT;
                break;
            case "FL - Flowspace":
                exptected = FL_FLOWSPACE;
                break;
        }
        theActorInTheSpotlight().should(
                seeThat("region: " + region, CommonQuestions.targetText(VendorInventoryPage.INSTRUCTIONS_OF_REGIONS), containsString(exptected)));
    }

    @And("Vendor verify search result in Send Inventory")
    public void verify_result_in_inventory_status(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            HashMap<String, String> info = CommonTask.setValue(expected.get(i), "number", expected.get(i).get("number"), Serenity.sessionVariableCalled("Number Inbound Inventory api"), "create by api");
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorInventoryPage.POD_INBOUND_REFERENCE("number", i + 1)).text().contains(info.get("number")),
                    Ensure.that(VendorInventoryPage.POD_INBOUND_REFERENCE("region", i + 1)).text().contains(info.get("region")),
                    Ensure.that(VendorInventoryPage.POD_INBOUND_REFERENCE("eta", i + 1)).text().contains(CommonHandle.setDate2(info.get("eta"), "MM/dd/yy")),
                    Ensure.that(VendorInventoryPage.POD_INBOUND_REFERENCE("status", i + 1)).text().contains(info.get("status"))
            );
        }
    }


    @And("Edit info SKU of inbound inventory")
    public void editSKUInbound(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> sku : list) {
            String lotCode = "Lot code" + Utility.getRandomString(5);
            HashMap<String, String> info = CommonTask.setValueRandom(sku, "productLotCode", lotCode);
            theActorInTheSpotlight().attemptsTo(
                    HandleSendInventory.editSKUtoInboundInventory(info)
            );
        }
        for (Map<String, String> sku : list) {
            String lotCode = VendorInventoryPage.PRODUCT_LOT_CODE_OF_SKU(sku.get("sku"), sku.get("index")).resolveFor(theActorInTheSpotlight()).getAttribute("value");
            Serenity.setSessionVariable("Lot Code Inbound " + sku.get("sku") + " " + sku.get("index")).to(lotCode);
            System.out.println("Lot Code Inbound " + sku.get("sku") + " " + sku.get("index") + " : " + Serenity.sessionVariableCalled("Lot Code Inbound " + sku.get("sku") + " " + sku.get("index")));
        }
    }

    @And("Vendor input info of inbound inventory")
    public void input_info_of_inbound_inventory(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleSendInventory.inputInboundInventory(list.get(0))
        );
    }

    @And("Vendor input info optional of inbound inventory")
    public void vendor_input_info_optional_of_inbound_inventory(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAllInventory.inputInfoOptional(list.get(0))
        );
    }

    @And("Vendor upload POD to inbound inventory")
    public void vendor_upload_pod_of_inbound_inventory(String file) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllInventory.uploadPOD(file)
        );
    }

    @And("Add SKU to inbound inventory")
    public void addSKUInbound(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> sku : list) {
            String lotCode = "Lot code" + Utility.getRandomString(5);
            Serenity.setSessionVariable("Lot Code Inbound " + sku.get("sku") + " " + sku.get("index")).to(lotCode);
            System.out.println("Lot Code Inbound " + sku.get("sku") + " " + sku.get("index") + lotCode);
            HashMap<String, String> info = CommonTask.setValueRandom(sku, "productLotCode", lotCode);
            theActorInTheSpotlight().attemptsTo(
                    HandleSendInventory.addSKUtoInboundInventory(info)
            );
        }
    }

    @And("Vendor save lotcode of inbound inventory")
    public void vendor_save_lotcode_of_inbound_inventory(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> sku : list) {
            String lotCode = VendorInventoryPage.PRODUCT_LOT_CODE_OF_SKU(sku.get("sku"), sku.get("index")).resolveFor(theActorInTheSpotlight()).getAttribute("value");
            Serenity.setSessionVariable("Lot Code Inbound " + sku.get("sku") + " " + sku.get("index")).to(lotCode);
            System.out.println("Lot Code Inbound " + sku.get("sku") + " " + sku.get("index") + " : " + Serenity.sessionVariableCalled("Lot Code Inbound " + sku.get("sku") + " " + sku.get("index")));
        }
    }

    @And("Vendor update request inbound inventory")
    public void admin_update_request_inbound_inventory() {
        theActorInTheSpotlight().attemptsTo(
                HandleSendInventory.confirmUpdateInboundInventory()
        );
    }

    @And("Confirm create inbound inventory")
    public void confirmCreateInbound() {
        theActorInTheSpotlight().attemptsTo(
                HandleSendInventory.confirmCreateInboundInventory()
        );
        Serenity.setSessionVariable("Inventory_Reference").to(VendorInventoryPage.INVENTORY_ID.resolveFor(theActorInTheSpotlight()).getText().substring(11));
    }

    @And("Vendor go to detail of inbound inventory {string}")
    public void checkGeneralInformation(String number) {
        if (number.contains("create by api")) {
            number = Serenity.sessionVariableCalled("Number Inbound Inventory api").toString();
        }
        if (number.isEmpty()) {
            number = Serenity.sessionVariableCalled("Inventory_Reference").toString();
        }
        theActorInTheSpotlight().attemptsTo(
                HandleSendInventory.goToDetailInboundInventory(number)
        );
    }

    @And("{word} Search and check Send Inventory")
    public void searchSendInventory(String actor, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> stringStringMap : list) {
            String id = stringStringMap.get("reference");
            if (stringStringMap.get("reference").isEmpty()) {
                id = Serenity.sessionVariableCalled("Inventory_Reference");
            }
            theActorCalled(actor).attemptsTo(
                    HandleSendInventory.searchInboundInventory(stringStringMap)
            );
            theActorCalled(actor).attemptsTo(
                    CommonWaitUntil.isVisible(VendorInventoryPage.POD_INBOUND_REFERENCE(id)),
                    Ensure.that(VendorInventoryPage.POD_INBOUND_REFERENCE(id)).isDisplayed(),
                    Ensure.that(VendorInventoryPage.REGION(id)).text().contains(stringStringMap.get("region")),
                    Ensure.that(VendorInventoryPage.ETA(id)).text().contains(CommonHandle.setDate2(stringStringMap.get("eta"), "MM/dd/yy"))
//                    Ensure.that(VendorInventoryPage.STATUS(id)).text().contains(stringStringMap.get("status"))
            );
        }
    }

    @And("Vendor check detail of Inbound inventory")
    public void checkGeneralInformation(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorInventoryPage.STATUS_IN_DETAIL(list.get(0).get("status"))),
                Ensure.that(VendorInventoryPage.STATUS_IN_DETAIL(list.get(0).get("status"))).isDisplayed(),
                Ensure.that(VendorInventoryPage.SELECT_REGION).attribute("value").contains(list.get(0).get("region")),
                Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("inbound-inventory-method")).attribute("value").contains(list.get(0).get("deliveryMethod")),
                Ensure.that(VendorInventoryPage.ESTIMATE_ARRIVAL).attribute("value").contains(CommonHandle.setDate2(list.get(0).get("estimatedDate"), "MM/dd/yy")),
                Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("num-of-pallets")).attribute("value").contains(list.get(0).get("ofPallets")),
                Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("num-of-retail-cases-per-master-carton")).attribute("value").contains(list.get(0).get("ofSellableRetail")),
                Check.whether(list.get(0).get("ofMaster").isEmpty())
                        .otherwise(Ensure.that(VendorInventoryPage.MASTER_CARTONS_LABEL).text().contains(list.get(0).get("ofMaster"))),
                Ensure.that(VendorInventoryPage.TOTAL_SELLABLE_RETAIL_CASE_LABEL).text().contains(list.get(0).get("ofSellableRetailPer")),
                Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("total-weight")).attribute("value").contains(list.get(0).get("totalWeight")),
                Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("zip-code")).attribute("value").contains(list.get(0).get("zipcode"))
        );
    }

    @And("Vendor check detail info optional of Inbound inventory")
    public void check_detail_info_optional_of_inbound_inventory(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("other-detail")).attribute("value").contains(list.get(0).get("other")),
                Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("freight-carrier")).attribute("value").contains(list.get(0).get("freight")),
                Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("estimated-covered-period")).attribute("value").contains(list.get(0).get("estimatedWeek")),
                Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("notes")).attribute("value").contains(list.get(0).get("note"))
        );
        if (list.get(0).containsKey("reference-number")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("reference-number")).attribute("value").contains(list.get(0).get("reference"))
            );
        }
        if (list.get(0).containsKey("palletTransit")) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(list.get(0).get("palletTransit").isEmpty()).otherwise(
                            Ensure.that(VendorInventoryPage.PALLET_STACKABLE_IN_TRANSIT(list.get(0).get("palletTransit"))).attribute("class").contains("is-active")
                    )
            );
        }
        if (list.get(0).containsKey("palletWarehouse")) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(list.get(0).get("palletWarehouse").isEmpty()).otherwise(
                            Ensure.that(VendorInventoryPage.PALLET_STACKABLE_IN_WAREHOUSE(list.get(0).get("palletWarehouse"))).attribute("class").contains("is-active")
                    ));
        }
        if (list.get(0).containsKey("fileBOL")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorInventoryPage.UPLOADED_BOL).attribute("style").contains(list.get(0).get("fileBOL"))
            );
        }
        if (list.get(0).containsKey("filePOD")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorInventoryPage.UPLOADED_POD).attribute("style").contains(list.get(0).get("filePOD"))
            );
        }
        if (list.get(0).containsKey("transportName")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("transport-coordinator-name")).value().contains(list.get(0).get("transportName"))
            );
        }
        if (list.get(0).containsKey("transportPhone")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("transport-coordinator-phone")).value().contains(list.get(0).get("transportPhone"))
            );
        }
        if (list.get(0).containsKey("trackingNumber")) {
            theActorInTheSpotlight().attemptsTo(
                    Check.whether(CommonQuestions.isControlDisplay(VendorInventoryPage.DYNAMIC_TEXTBOX("tracking-number"))).andIfSo(
                            Ensure.that(VendorInventoryPage.DYNAMIC_TEXTBOX("tracking-number")).value().contains(list.get(0).get("trackingNumber"))
                    ).otherwise(
                            Ensure.that(VendorInventoryPage.TRACKING_NUMBER).text().contains(list.get(0).get("trackingNumber"))
                    )
            );
        }
    }

    @And("Vendor check detail of SKU in Inbound inventory")
    public void vendor_check_detail_of_sku_in_inbound_inventory(DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        for (Map<String, String> item : list) {
            HashMap<String, String> info = CommonTask.setValueRandom(item, "lotCode", Serenity.sessionVariableCalled("Lot Code Inbound " + item.get("sku") + " " + item.get("index")));
            System.out.println("Lot Code Inbound " + item.get("sku") + " " + item.get("index") + " : " + Serenity.sessionVariableCalled("Lot Code Inbound " + item.get("sku") + " " + item.get("index")));
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(VendorInventoryPage.BRAND_LABEL(item.get("sku"), item.get("index"))).text().contains(item.get("brand")),
                    Ensure.that(VendorInventoryPage.PRODUCT_LABEL(item.get("sku"), item.get("index"))).text().contains(item.get("product")),
                    Ensure.that(VendorInventoryPage.SKU_LABEL(item.get("sku"), item.get("index"))).text().contains(item.get("sku")),
                    Check.whether(item.get("ofCases").equals(""))
                            .otherwise(
                                    Ensure.that(VendorInventoryPage.CASE_OF_SKU(item.get("sku"), item.get("index"))).attribute("value").contains(item.get("ofCases"))),
                    Check.whether(item.get("lotCode").equals(""))
                            .otherwise(
                                    Ensure.that(VendorInventoryPage.PRODUCT_LOT_CODE_OF_SKU(item.get("sku"), item.get("index"))).attribute("value").contains(info.get("lotCode"))),
                    Check.whether(item.get("expiryDate").equals(""))
                            .otherwise(
                                    Ensure.that(VendorInventoryPage.EXPIRY_DATE(item.get("sku"), item.get("index"))).attribute("value").contains(CommonHandle.setDate2(item.get("expiryDate"), "MM/dd/yy")))
            );
            if (item.containsKey("temperature")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorInventoryPage.TEMPERATURE(item.get("sku"), item.get("index"))).text().contains(item.get("temperature"))
                );
            }
            if (item.containsKey("shelfLife")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(VendorInventoryPage.SHELF_LIFE(item.get("sku"), item.get("index"))).text().contains(item.get("shelfLife"))
                );
            }
        }
    }

    @And("Vendor create new inbound inventory")
    public void vendor_create_new_inbound_inventory() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorInventoryPage.SEND_INVENTORY),
                Click.on(VendorInventoryPage.SEND_INVENTORY),
                CommonWaitUntil.isNotVisible(VendorInventoryPage.LOADING)
        );
    }

    @And("Vendor verify form create inbound inventory empty")
    public void vendor_verify_form_create_inbound_inventory_empty() {
        theActorInTheSpotlight().attemptsTo(
                HandleSendInventory.emptyFieldFormCreate(),
                Ensure.that(VendorInventoryPage.D_ERROR_MESSAGE("region")).isDisplayed(),
                Ensure.that(VendorInventoryPage.D_ERROR_MESSAGE("inbound-inventory-method")).isDisplayed(),
                Ensure.that(VendorInventoryPage.D_ERROR_MESSAGE("eta")).isDisplayed(),
//                Ensure.that(VendorInventoryPage.D_ERROR_MESSAGE("num-of-pallets")).isDisplayed(),
//                Ensure.that(VendorInventoryPage.D_ERROR_MESSAGE("num-of-sellable-retail-case")).isDisplayed(),
//                Ensure.that(VendorInventoryPage.D_ERROR_MESSAGE("num-of-master-cartons")).isDisplayed(),
//                Ensure.that(VendorInventoryPage.D_ERROR_MESSAGE("num-of-retail-cases-per-master-carton")).isDisplayed(),
                Ensure.that(VendorInventoryPage.D_ERROR_MESSAGE("total-weight")).isDisplayed(),
                Ensure.that(VendorInventoryPage.D_ERROR_MESSAGE("zip-code")).isDisplayed(),
                Ensure.that(VendorInventoryPage.SKU_ERROR_MESAGE).isDisplayed()
        );
    }

}

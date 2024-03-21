package steps.vendor.Inventory;

import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.singleton.GVs;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.Utility;
import cucumber.tasks.common.WindowTask;
import cucumber.tasks.vendor.inventory.HandleAllInventory;
import cucumber.tasks.vendor.inventory.HandleInventoryStatus;
import cucumber.tasks.vendor.inventory.HandleSendInventory;
import cucumber.user_interface.beta.HomePageForm;
import cucumber.user_interface.beta.User_Header;
import cucumber.user_interface.beta.Vendor.inventory.AllInventoryPage;
import cucumber.user_interface.beta.Vendor.inventory.InventoryStatusPage;
import cucumber.user_interface.beta.Vendor.inventory.VendorInventoryPage;
import cucumber.user_interface.lp.CommonLPPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.actions.Open;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.ui.Link;


import java.lang.annotation.Target;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static cucumber.constants.vendor.WebsiteConstants.*;
import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static net.serenitybdd.screenplay.matchers.WebElementStateMatchers.isCurrentlyVisible;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.the;
import static net.serenitybdd.screenplay.questions.WebElementQuestion.valueOf;
import static org.hamcrest.CoreMatchers.containsString;

public class InventoryStepDefinition {

    @And("Go to Send inventory page")
    public void go_To_send_inventory_page() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorInventoryPage.SEND_INVENTORY),
                Click.on(VendorInventoryPage.SEND_INVENTORY),
                CommonWaitUntil.isNotVisible(VendorInventoryPage.LOADING)
        );
    }

    @And("Vendor go to create inbound page by url")
    public void vendor_go_to_send_inventory_page_by_url() {
        theActorInTheSpotlight().attemptsTo(
                Open.url(GVs.URL_BETA + "vendors/inventory/inbound/create"),
                WindowTask.threadSleep(2000),
                // Check popup capital
                Check.whether(valueOf(HomePageForm.I_ACCEPT), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.I_ACCEPT),
                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                        ),
                Check.whether(valueOf(HomePageForm.NEVER_SHOW_AGAIN), isCurrentlyVisible())
                        .andIfSo(
                                Click.on(HomePageForm.NEVER_SHOW_AGAIN),
                                Click.on(HomePageForm.CLOSE_POPUP),
                                CommonWaitUntil.isVisible(Link.withText("Dashboard"))
                        ),
                CommonWaitUntil.isNotVisible(VendorInventoryPage.LOADING),
                CommonWaitUntil.isVisible(VendorInventoryPage.GENERAL_INSTRUCTIONS_POPUP)
        );
        checkGeneralInstructions();
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorInventoryPage.CONFIRM_GENERAL_INSTRUCTIONS),
                CommonWaitUntil.isNotVisible(VendorInventoryPage.GENERAL_INSTRUCTIONS_POPUP)
        );
    }

    @And("Vendor go to {string} tab")
    public void admin_go_to_tab_inventory(String tabName) {
        theActorInTheSpotlight().attemptsTo(
                HandleAllInventory.goToInventoryTab(tabName)
        );
    }

    @And("{word} Go to detail of inbound inventory have number: {string}")
    public void go_To_send_inventory_page(String actor, String num) {
        if (num.isEmpty()) {
            theActorCalled(actor).attemptsTo(
                    CommonWaitUntil.isVisible(VendorInventoryPage.POD_INBOUND_REFERENCE(Serenity.sessionVariableCalled("Inventory_Reference"))),
                    Click.on(VendorInventoryPage.POD_INBOUND_REFERENCE(Serenity.sessionVariableCalled("Inventory_Reference"))),
                    CommonWaitUntil.isNotVisible(VendorInventoryPage.LOADING)
            );
        } else if (num.contains("create by api")) {
            theActorCalled(actor).attemptsTo(
                    CommonWaitUntil.isVisible(VendorInventoryPage.POD_INBOUND_REFERENCE(Serenity.sessionVariableCalled("Number Inbound Inventory api"))),
                    Click.on(VendorInventoryPage.POD_INBOUND_REFERENCE(Serenity.sessionVariableCalled("Number Inbound Inventory api"))),
                    CommonWaitUntil.isNotVisible(VendorInventoryPage.LOADING)
            );
        } else {
            theActorCalled(actor).attemptsTo(
                    CommonWaitUntil.isVisible(VendorInventoryPage.POD_INBOUND_REFERENCE(num)),
                    Click.on(VendorInventoryPage.POD_INBOUND_REFERENCE(num)),
                    CommonWaitUntil.isNotVisible(VendorInventoryPage.LOADING)
            );
        }
    }

    @And("Vendor go to {string}")
    public void go_To_inventory_tab(String tabName) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorInventoryPage.DYNAMIC_TAB(tabName)),
                Click.on(VendorInventoryPage.DYNAMIC_TAB(tabName)),
                CommonWaitUntil.isNotVisible(VendorInventoryPage.LOADING)
        );
    }

    @And("Click Create new inbound inventory")
    public void createNewInboundInventory() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorInventoryPage.NEW_INBOUND_INVENTORY),
                Click.on(VendorInventoryPage.NEW_INBOUND_INVENTORY),
                CommonWaitUntil.isVisible(VendorInventoryPage.GENERAL_INSTRUCTIONS_POPUP)
        );
        checkGeneralInstructions();
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorInventoryPage.CONFIRM_GENERAL_INSTRUCTIONS),
                CommonWaitUntil.isNotVisible(VendorInventoryPage.GENERAL_INSTRUCTIONS_POPUP)
        );
    }

    @And("Check General Instructions")
    public void checkGeneralInstructions() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorInventoryPage.GENERAL_INSTRUCTIONS_POPUP)
        );
        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(VendorInventoryPage.GENERAL_INSTRUCTIONS_POPUP), containsString(GENERAL_INSTRUCTIONS))
        );
    }

    @And("Choose Region {string} and check Instructions")
    public void checkGeneralInstructions(String region) {
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorInventoryPage.SELECT_REGION),
                CommonTask.ChooseValueFromSuggestions(region)
        );
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
                seeThat(CommonQuestions.targetText(VendorInventoryPage.INSTRUCTIONS_OF_REGIONS), containsString(exptected)));
    }

    @And("Vendor check Total of Sellable Retail Cases = {string}")
    public void checkTotalSellable(String total) {
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(VendorInventoryPage.SELLABLE_RETAIL_CASES).text().isEqualToIgnoringCase(total)
        );
    }

    @And("Vendor search All Inventory {string}")
    public void searchAllInventory(String region, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(list.get(0), "skuName", Serenity.sessionVariableCalled("SKU inventory"));
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllInventoryPage.TAB_REGIONS(region)),
                Click.on(AllInventoryPage.TAB_REGIONS(region)),
                CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories...")),
                HandleAllInventory.search(info)
        );
    }

    @And("Vendor search Inventory on region {string}")
    public void searchAllInventoryOnRegion(String region, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Click.on(AllInventoryPage.TAB_REGIONS(region)),
                CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories..."))
        );
        for (Map<String, String> map : list) {
            HashMap<String, String> info = CommonTask.setValueRandom(list.get(0), "skuName", Serenity.sessionVariableCalled("SKU inventory"));
            theActorInTheSpotlight().attemptsTo(
                    HandleAllInventory.search(info)
            );
        }
    }

    @And("Vendor verify result in All Inventory")
    public void verify_result_in_all_inventory(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(expected.get(0), "skuName", Serenity.sessionVariableCalled("SKU inventory"));
        info = CommonTask.setValue(info, "lotCode", info.get("lotCode"), Serenity.sessionVariableCalled("Lot Code"), "random");
        if (expected.get(0).get("lotCode").equals("randomIndex")) {
            info = CommonTask.setValueRandom2(info, "lotCode", "randomIndex", Serenity.sessionVariableCalled("Lot Code" + info.get("skuName") + info.get("index")));
        }
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(AllInventoryPage.PRODUCT_NAME_IN_RESULT(info.get("lotCode"))).text().contains(expected.get(0).get("productName")),
                Ensure.that(AllInventoryPage.SKU_IN_RESULT(info.get("lotCode"))).text().contains(info.get("skuName")),
                Ensure.that(AllInventoryPage.LOT_CODE_IN_RESULT(info.get("lotCode"))).text().contains(info.get("lotCode")),
                Ensure.that(AllInventoryPage.RECEIVED_QTY_IN_RESULT(info.get("lotCode"))).text().contains(expected.get(0).get("receivedQty")),
                Check.whether(expected.get(0).get("received").equals(""))
                        .otherwise(Ensure.that(AllInventoryPage.RECEIVED_IN_RESULT(info.get("lotCode"))).text().contains(CommonHandle.setDate2(expected.get(0).get("received"), "MM/dd/yy"))),
                Ensure.that(AllInventoryPage.CURRENT_QTY_IN_RESULT(info.get("lotCode"))).text().contains(expected.get(0).get("currentQty").equalsIgnoreCase("End Quantity") ? Serenity.sessionVariableCalled("End Quantity").toString() : expected.get(0).get("currentQty").equalsIgnoreCase("End Quantity After") ? Serenity.sessionVariableCalled("End Quantity After").toString() : expected.get(0).get("currentQty")),
                Ensure.that(AllInventoryPage.PULLED_QTY_IN_RESULT(info.get("lotCode"))).text().contains(expected.get(0).get("pulledQty")),
                Ensure.that(AllInventoryPage.END_QTY_IN_RESULT(info.get("lotCode"))).text().contains(expected.get(0).get("endQty").equalsIgnoreCase("End Quantity") ? Serenity.sessionVariableCalled("End Quantity").toString() : expected.get(0).get("endQty").equalsIgnoreCase("End Quantity After") ? Serenity.sessionVariableCalled("End Quantity After").toString() : expected.get(0).get("endQty")),
                Ensure.that(AllInventoryPage.EXPIRY_DATE_IN_RESULT(info.get("lotCode"))).text().contains(CommonHandle.setDate2(expected.get(0).get("expiryDate"), "MM/dd/yy")),
                Check.whether(expected.get(0).get("pullDate").equals(""))
                        .otherwise(Ensure.that(AllInventoryPage.PULL_DATE_IN_RESULT(info.get("lotCode"))).text().contains(CommonHandle.setDate2(expected.get(0).get("pullDate"), "MM/dd/yy")))
        );

        if (info.containsKey("region")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllInventoryPage.REGION_IN_RESULT(info.get("lotCode"))).text().contains(expected.get(0).get("region"))
            );
        }

        if (info.containsKey("skuID")) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllInventoryPage.SKU_ID_IN_RESULT(info.get("lotCode"))).text().contains(expected.get(0).get("skuID"))
            );
        }
    }

    @And("Vendor verify search inventory results")
    public void verify_search_result(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            String zero = "";
            if (expected.get(i).get("currentQty").equalsIgnoreCase("0")) {
                zero = " zero-quantity";
            }
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isNotVisible(CommonVendorPage.LOADING),
                    Ensure.that(AllInventoryPage.SEARCH_RESULTS("product", zero, i + 1)).text().contains(expected.get(i).get("productName")),
                    Ensure.that(AllInventoryPage.SEARCH_RESULTS("sku", zero, i + 1)).text().contains(expected.get(i).get("skuName")),
                    Ensure.that(AllInventoryPage.SEARCH_RESULTS("sku", zero, i + 1)).text().contains(expected.get(i).get("region")),
                    Ensure.that(AllInventoryPage.SEARCH_RESULTS("edt-piece lot-code", zero, i + 1)).text().contains(expected.get(i).get("lotCode")),
                    Ensure.that(AllInventoryPage.SEARCH_RESULTS("edt-piece received-quantity", zero, i + 1)).text().contains(expected.get(i).get("receivedQty")),
                    Ensure.that(AllInventoryPage.SEARCH_RESULTS("edt-piece received", zero, i + 1)).text().contains(CommonHandle.setDate2(expected.get(i).get("received"), "MM/dd/yy")),
                    Ensure.that(AllInventoryPage.SEARCH_RESULTS("edt-piece current-quantity", zero, i + 1)).text().contains(expected.get(i).get("currentQty")),
                    Ensure.that(AllInventoryPage.SEARCH_RESULTS("edt-piece pulled-quantity", zero, i + 1)).text().contains(expected.get(i).get("pulledQty")),
                    Ensure.that(AllInventoryPage.SEARCH_RESULTS("edt-piece end-quantity", zero, i + 1)).text().contains(expected.get(i).get("endQty")),
                    Ensure.that(AllInventoryPage.SEARCH_RESULTS("edt-piece expiry", zero, i + 1)).text().contains(CommonHandle.setDate2(expected.get(i).get("expiryDate"), "MM/dd/yy")),
                    Ensure.that(AllInventoryPage.SEARCH_RESULTS("edt-piece pull-date", zero, i + 1)).text().contains(CommonHandle.setDate2(expected.get(i).get("pullDate"), "MM/dd/yy"))
            );
        }
    }

    @And("Vendor export inventory {string}")
    public void exportInventory(String type) {
        String file = "Pod_Foods_order-details_" + CommonHandle.setDate2("currentDate", "MMddyyyy") + ".xlsx";
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_BUTTON("Export")),
                Click.on(CommonVendorPage.DYNAMIC_BUTTON("Export")),
                CommonWaitUntil.isVisible(CommonVendorPage.DYNAMIC_ITEM_DROPDOWN2("Order details")),
                JavaScriptClick.on(CommonVendorPage.DYNAMIC_ITEM_DROPDOWN2("Order details")),
                WindowTask.threadSleep(1000)
        );

        theActorInTheSpotlight().attemptsTo(
                Ensure.that(CommonVendorPage.DYNAMIC_DIALOG_TEXT("It will take a few minutes to process your request. An email will be sent to the address on your profile when the CSV is ready to download. Continue?")).isDisplayed()
//                CommonWaitUntil.waitToDownloadSuccessfully(file)
        );
    }

}

package steps.vendor.Inventory;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.vendor.inventory.HandleInventoryStatus;
import cucumber.tasks.vendor.inventory.HandleVendorInventoryRequest;
import cucumber.user_interface.beta.Vendor.CommonVendorPage;
import cucumber.user_interface.beta.Vendor.inventory.AllInventoryPage;
import cucumber.user_interface.beta.Vendor.inventory.InventoryStatusPage;
import cucumber.user_interface.beta.Vendor.inventory.VendorDisposeDonatePage;
import cucumber.user_interface.beta.Vendor.inventory.VendorInventoryPage;
import cucumber.user_interface.lp.CommonLPPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.MoveMouse;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class VendorInventoryStatusDefinition {

    @And("Vendor check help popup Inventory status")
    public void vendor_verify_help_popup_inventory_status() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("Received Qty")),
                MoveMouse.to(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("Received Qty")),
                Ensure.that(CommonVendorPage.DYNAMIC_ANY_TEXT("Total inventory that has arrived on consignment")).isDisplayed(),
                MoveMouse.to(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("Deducted Qty")),
                Ensure.that(CommonVendorPage.DYNAMIC_ANY_TEXT("Total inventory that has been deducted")).isDisplayed(),
                MoveMouse.to(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("Current Qty")),
                Ensure.that(CommonVendorPage.DYNAMIC_ANY_TEXT("Total inventory currently physically on hand at distribution center")).isDisplayed(),
                MoveMouse.to(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("Pending Qty")),
                Ensure.that(CommonVendorPage.DYNAMIC_ANY_TEXT("Inventory on hand allocated to pending orders (not yet fulfilled)")).isDisplayed(),
                MoveMouse.to(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("Insufficient Qty")),
                Ensure.that(CommonVendorPage.DYNAMIC_ANY_TEXT("Inventory needed to fill pending orders (not yet confirmed due to insufficient inventory levels to fill entire order)")).isDisplayed(),
                Check.whether(CommonQuestions.isControlDisplay(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("End Qty"))).andIfSo(
                        MoveMouse.to(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("End Qty")),
                        Ensure.that(CommonVendorPage.DYNAMIC_ANY_TEXT("Quantity left once all pending orders have been fulfilled")).isDisplayed()
                ),
                Check.whether(CommonQuestions.isControlDisplay(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("Week of sales"))).andIfSo(
                        MoveMouse.to(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("Week of sales")),
                        Ensure.that(CommonVendorPage.DYNAMIC_ANY_TEXT("Quantity of in stock weeks remaining on inventory based on historical sales data")).isDisplayed()
                ),
                Check.whether(CommonQuestions.isControlDisplay(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("Week of sales"))).andIfSo(
                        MoveMouse.to(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("Low inventory threshold")),
                        Ensure.that(CommonVendorPage.DYNAMIC_ANY_TEXT("Metric signaling replenishment need based on historical sales turn")).isDisplayed()
                ),
                Check.whether(CommonQuestions.isControlDisplay(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("Week of sales"))).andIfSo(
                        MoveMouse.to(VendorInventoryPage.INVENTORY_STATUS_HELP_POPUP("Status")),
                        Ensure.that(CommonVendorPage.DYNAMIC_ANY_TEXT("Note: status may change due to order updates/cancellations or inventory replenishments")).isDisplayed()
                )
        );
    }

    @And("Vendor search Inventory Status {string}")
    public void search_inventory_status(String region, DataTable table) {
        List<Map<String, String>> list = table.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(list.get(0), "skuName", Serenity.sessionVariableCalled("SKU inventory"));
        theActorInTheSpotlight().attemptsTo(
                Click.on(VendorInventoryPage.DYNAMIC_TAB1("Inventory Status")),
                CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories...")),
                Click.on(AllInventoryPage.TAB_REGIONS(region)),
                CommonWaitUntil.isNotVisible(CommonLPPage.LOADING_ICON("Fetching your inventories...")),
                HandleInventoryStatus.search(info)
        );
    }

    @And("Vendor verify result in Inventory Status")
    public void verify_result_in_inventory_status(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        for (int i = 0; i < expected.size(); i++) {
            HashMap<String, String> info = CommonTask.setValueRandom(expected.get(i), "sku", Serenity.sessionVariableCalled("SKU inventory"));
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(InventoryStatusPage.PRODUCT_NAME(i + 1)).text().contains(expected.get(i).get("product")),
                    Ensure.that(InventoryStatusPage.BRAND_NAME(i + 1)).text().contains(expected.get(i).get("brand")),
                    Ensure.that(InventoryStatusPage.SKU_NAME(i + 1)).text().contains(info.get("sku")),
                    Ensure.that(InventoryStatusPage.DYNAMIC_VALUE(i + 1, "received-quantity")).text().contains(expected.get(i).get("receivedQuantity")),
                    Ensure.that(InventoryStatusPage.DYNAMIC_VALUE(i + 1, "deducted-quantity")).text().contains(expected.get(i).get("deductedQuantity")),
                    Ensure.that(InventoryStatusPage.DYNAMIC_VALUE(i + 1, "current-quantity")).text().contains(expected.get(i).get("currentQuantity")),
                    Ensure.that(InventoryStatusPage.DYNAMIC_VALUE(i + 1, "pending-quantity")).text().contains(expected.get(i).get("pendingQuantity")),
                    Ensure.that(InventoryStatusPage.DYNAMIC_VALUE(i + 1, "insufficient-quantity")).text().contains(expected.get(i).get("insufficientQuantity")),
                    Check.whether(expected.get(i).get("endQty").isEmpty())
                            .otherwise(
                                    Ensure.that(InventoryStatusPage.DYNAMIC_VALUE(i + 1, "end-quantity")).text().contains(expected.get(i).get("endQty"))),
                    Check.whether(expected.get(i).get("weekOfSales").isEmpty())
                            .otherwise(
                                    Ensure.that(InventoryStatusPage.DYNAMIC_VALUE(i + 1, "week-of-sales")).text().contains(expected.get(i).get("weekOfSales"))),
                    Check.whether(expected.get(i).get("lowInventoryThreshold").isEmpty())
                            .otherwise(
                                    Ensure.that(InventoryStatusPage.DYNAMIC_VALUE(i + 1, "low-inventory-threshold")).text().contains(expected.get(i).get("lowInventoryThreshold"))),
                    Check.whether(expected.get(i).get("status").isEmpty())
                            .otherwise(
                                    Ensure.that(InventoryStatusPage.DYNAMIC_VALUE(i + 1, "status")).text().contains(expected.get(i).get("status")))
            );
        }

    }
}

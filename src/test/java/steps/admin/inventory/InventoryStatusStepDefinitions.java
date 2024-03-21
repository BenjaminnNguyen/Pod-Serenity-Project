package steps.admin.inventory;

import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.admin.inventory.HandleInventoryStatus;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.vendor.inventory.HandleAllInventory;
import cucumber.user_interface.admin.inventory.InventoryStatusPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;

public class InventoryStatusStepDefinitions {

    @And("Admin search inventory status")
    public void search_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = CommonTask.setValueRandom(list.get(0), "skuName", Serenity.sessionVariableCalled("SKU inventory"));
        theActorInTheSpotlight().attemptsTo(
                HandleInventoryStatus.search(info)
        );
    }

    @And("Verify result inventory status")
    public void verify_result_inventory(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for(Map<String, String> map :expected){
            HashMap<String, String> info = CommonTask.setValueRandom(map, "sku", Serenity.sessionVariableCalled("SKU inventory"));
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(InventoryStatusPage.DYNAMIC_RESULT_IN_TABLE(info.get("sku"), "sku")).isDisplayed(),
                    Ensure.that(InventoryStatusPage.DYNAMIC_RESULT_IN_TABLE(info.get("sku"), "brand")).attribute("data-original-text").contains(info.get("brand")),
                    Ensure.that(InventoryStatusPage.DYNAMIC_RESULT_IN_TABLE(info.get("sku"), "product")).attribute("data-original-text").contains(info.get("product")),
                    Ensure.that(InventoryStatusPage.DYNAMIC_RESULT_IN_TABLE2(info.get("sku"), "received-quantity")).text().contains(info.get("receivedQuantity")),
                    Ensure.that(InventoryStatusPage.DYNAMIC_RESULT_IN_TABLE2(info.get("sku"), "fulfilled-quantity")).text().contains(info.get("fulfilledQuantity")),
                    Ensure.that(InventoryStatusPage.DYNAMIC_RESULT_IN_TABLE2(info.get("sku"), "current-quantity")).text().contains(info.get("currentquantity")),
                    Ensure.that(InventoryStatusPage.DYNAMIC_RESULT_IN_TABLE2(info.get("sku"), "pending-quantity")).text().contains(info.get("pendingQuantity")),
                    Ensure.that(InventoryStatusPage.DYNAMIC_RESULT_IN_TABLE2(info.get("sku"), "insufficient-quantity")).text().contains(info.get("insufficientQuantity")),
                    Ensure.that(InventoryStatusPage.DYNAMIC_RESULT_IN_TABLE2(info.get("sku"), "end-quantity")).text().contains(info.get("endQuantity"))
            );
            if (info.containsKey("status")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(InventoryStatusPage.DYNAMIC_RESULT_IN_TABLE2(info.get("sku"), "status")).text().contains(info.get("status"))
                );
            }
            if (info.containsKey("region")) {
                theActorInTheSpotlight().attemptsTo(
                        Ensure.that(InventoryStatusPage.REGION_IN_TABLE(info.get("sku"), "sku")).text().contains(info.get("region"))
                );
            }
        }
        
    }
}

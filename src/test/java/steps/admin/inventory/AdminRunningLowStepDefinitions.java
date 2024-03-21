package steps.admin.inventory;

import cucumber.questions.CommonQuestions;
import cucumber.tasks.vendor.inventory.HandleAllInventory;
import cucumber.tasks.vendor.inventory.HandleRunningLow;
import cucumber.tasks.vendor.inventory.HandleZeroQuantity;
import cucumber.user_interface.admin.inventory.AdminRunningLowPage;
import cucumber.user_interface.admin.inventory.ZeroQuantityPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;

public class AdminRunningLowStepDefinitions {

    @And("Admin search inventory in running low")
    public void search_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            HashMap<String, String> info = HandleAllInventory.setSKURandom(map, "skuName");
            if(map.containsKey("itemCode")){
                info = HandleAllInventory.setSKURandom(map, "itemCode");
                theActorInTheSpotlight().attemptsTo(
                        HandleRunningLow.searchWithItemCode(info)
                );
            }
            theActorInTheSpotlight().attemptsTo(
                    HandleRunningLow.search(info)
            );
        }
    }

    @And("Admin verify inventory running low")
    public void verify_inventory(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : expected) {
            HashMap<String, String> info = HandleAllInventory.setSKURandom(map, "sku");
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.attributeText(AdminRunningLowPage.DYNAMIC_TB2(info.get("sku"), "product"), "data-original-text"), containsString(map.get("product"))),
                    seeThat(CommonQuestions.targetText(AdminRunningLowPage.DYNAMIC_TB(info.get("sku"), "sku")), containsString(info.get("sku"))),
                    seeThat(CommonQuestions.targetText(AdminRunningLowPage.DYNAMIC_TB(info.get("sku"), "original-quantity")), containsString(map.get("originalQty"))),
                    seeThat(CommonQuestions.targetText(AdminRunningLowPage.DYNAMIC_TB(info.get("sku"), "current-quantity")), containsString(map.get("currentQty"))),
                    seeThat(CommonQuestions.targetText(AdminRunningLowPage.DYNAMIC_TB(info.get("sku"), " quantity ")), containsString(map.get("endQty"))),
                    seeThat(CommonQuestions.targetText(AdminRunningLowPage.DYNAMIC_TB(info.get("sku"), "pull-quantity")), containsString(map.get("pullQty"))),
                    seeThat(CommonQuestions.targetText(AdminRunningLowPage.DYNAMIC_TB(info.get("sku"), "brand-name")), containsString(map.get("brand"))),
                    seeThat(CommonQuestions.attributeText(AdminRunningLowPage.DYNAMIC_TB2(info.get("sku"), "vendor-company"), "data-original-text"), containsString(map.get("vendorCompany"))),
                    seeThat(CommonQuestions.targetText(AdminRunningLowPage.DYNAMIC_TB(info.get("sku"), "region")), containsString(map.get("region")))
            );
        }

    }
}

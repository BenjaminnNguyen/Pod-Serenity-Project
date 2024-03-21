package steps.admin.inventory;

import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.vendor.inventory.HandleAllInventory;
import cucumber.tasks.vendor.inventory.HandleZeroQuantity;
import cucumber.user_interface.admin.inventory.InventoryDetailPage;
import cucumber.user_interface.admin.inventory.ZeroQuantityPage;
import io.cucumber.datatable.DataTable;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;

public class ZeroQuantityStepDefinitions {

    @And("Admin search inventory in zero quantity")
    public void search_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = HandleAllInventory.setSKURandom(list.get(0), "skuName");
        theActorInTheSpotlight().attemptsTo(
                HandleZeroQuantity.search(info)
        );
    }

    @And("Admin verify inventory zero quantity")
    public void verify_inventory_detail(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        HashMap<String, String> info = HandleAllInventory.setSKURandom(expected.get(0), "sku");

        theActorInTheSpotlight().should(
                seeThat(CommonQuestions.targetText(ZeroQuantityPage.PRODUCT_NAME), containsString(expected.get(0).get("product"))),
                seeThat(CommonQuestions.targetText(ZeroQuantityPage.DYNAMIC_TEXT("sku")), containsString(info.get("sku"))),
                seeThat(CommonQuestions.targetText(ZeroQuantityPage.DYNAMIC_TEXT("original-quantity")), containsString(expected.get(0).get("originalQty"))),
                seeThat(CommonQuestions.targetText(ZeroQuantityPage.DYNAMIC_TEXT("current-quantity")), containsString(expected.get(0).get("currentQty"))),
                seeThat(CommonQuestions.targetText(ZeroQuantityPage.DYNAMIC_TEXT("quantity")), containsString(expected.get(0).get("qty"))),
                seeThat(CommonQuestions.targetText(ZeroQuantityPage.DYNAMIC_TEXT("pull-quantity")), containsString(expected.get(0).get("pullQty"))),
                seeThat(CommonQuestions.targetText(ZeroQuantityPage.DYNAMIC_TEXT("brand-name")), containsString(expected.get(0).get("brand"))),
                seeThat(CommonQuestions.targetText(ZeroQuantityPage.VENDOR_COMPANY_RESULT), containsString(expected.get(0).get("vendorCompany"))),
                seeThat(CommonQuestions.targetText(ZeroQuantityPage.REGION_RESULT), containsString(expected.get(0).get("region")))

        );
    }
}

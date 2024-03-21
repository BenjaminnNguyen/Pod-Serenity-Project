package steps.admin.inventory;

import io.cucumber.java.en.*;
import cucumber.tasks.admin.inventory.HandleExpireInventory;
import cucumber.tasks.admin.inventory.HandleInventory;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.user_interface.admin.inventory.AboutToExpirePage;
import cucumber.user_interface.admin.inventory.AllInventoryPage;
import cucumber.user_interface.admin.inventory.InventoryDetailPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.ensure.Ensure;
import net.serenitybdd.screenplay.questions.Text;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AboutToExpireStepDefinitions {
    @And("Admin search expire inventory")
    public void admin_search_expire_inventory(DataTable dt) {
        List<Map<String, String>> list = dt.asMaps(String.class, String.class);
        for (Map<String, String> map : list) {
            HashMap<String, String> info = CommonTask.setValue(map, "skuName", map.get("skuName"), Serenity.sessionVariableCalled("SKU inventory"), "random");
            theActorInTheSpotlight().attemptsTo(
                    HandleExpireInventory.search(info)
            );
        }
    }

    @And("Verify result expire inventory")
    public void verify_result_expire_inventory(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        HashMap<String, String> info;
        for (int i = 0; i < expected.size(); i++) {
            info = CommonTask.setValueRandom(expected.get(i), "skuName", Serenity.sessionVariableCalled("SKU inventory"));
            info = CommonTask.setValueRandom(info, "lotCode", Serenity.sessionVariableCalled("Lot Code"));
            if (expected.get(i).get("lotCode").equals("randomInbound")) {
                info = CommonTask.setValueRandom2(info, "lotCode", "randomInbound", Serenity.sessionVariableCalled("Lot Code Inbound " + info.get("skuName") + " " + info.get("index")));
                System.out.println("Lot Code Inbound " + info.get("skuName") + " " + info.get("index") + " : " + Serenity.sessionVariableCalled("Lot Code Inbound " + info.get("skuName") + " " + info.get("index")));
            }

            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AllInventoryPage.D_PRODUCT_RESULT_IN_TABLE(info.get("lotCode"))).attribute("data-original-text").contains(expected.get(i).get("productName")),
                    Ensure.that(AllInventoryPage.D_SKU_RESULT_IN_TABLE(info.get("lotCode"))).attribute("data-original-text").contains(info.get("skuName")),
                    Ensure.that(AllInventoryPage.D_LOTCODE_RESULT_IN_TABLE(info.get("lotCode"))).isDisplayed(),
                    Ensure.that(AllInventoryPage.D_ORIGINAL_QUANTITY_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(expected.get(i).get("originalQuantity")),
                    Ensure.that(AllInventoryPage.D_CURRENT_QTY_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(expected.get(i).get("currentQuantity")),
                    Ensure.that(AllInventoryPage.D_END_QTY_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(expected.get(i).get("quantity").equalsIgnoreCase("End Quantity")
                            ? Serenity.sessionVariableCalled("End Quantity").toString() : expected.get(i).get("quantity").equalsIgnoreCase("End Quantity After")
                            ? Serenity.sessionVariableCalled("End Quantity After").toString() : expected.get(i).get("quantity")),
                    Ensure.that(AllInventoryPage.D_PULL_QTY_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(expected.get(i).get("pullQuantity")),
                    Ensure.that(AllInventoryPage.D_EXPIRE_DATE_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(CommonHandle.setDate2(expected.get(i).get("expiryDate"), "yyyy-MM-dd")),
                    Ensure.that(AllInventoryPage.D_PULL_DATE_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(CommonHandle.setDate2(expected.get(i).get("pullDate"), "yyyy-MM-dd")),
                    Ensure.that(AllInventoryPage.D_RECEIVE_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(CommonHandle.setDate2(expected.get(i).get("receiveDate"), "yyyy-MM-dd")),
                    Ensure.that(AllInventoryPage.D_WAREHOUSE_RESULT_IN_TABLE(info.get("lotCode"))).attribute("data-original-text").contains(expected.get(i).get("distributionCenter")),
                    Ensure.that(AllInventoryPage.D_VENDOR_COMPANY_RESULT_IN_TABLE(info.get("lotCode"))).attribute("data-original-text").contains(expected.get(i).get("vendorCompany")),
                    Ensure.that(AllInventoryPage.D_REGION_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(expected.get(i).get("region")),
                    Ensure.that(AllInventoryPage.D_CREATED_BY_RESULT_IN_TABLE(info.get("lotCode"))).text().contains(expected.get(i).get("createdBy"))
            );
        }
    }

    @And("Admin verify red number expire")
    public void admin_verify_red_number_expire() {
        String redNumberMenu = Text.of(AboutToExpirePage.RED_NUMBER_EXPIRE_MENU).answeredBy(theActorInTheSpotlight()).toString();
        String redNumberResult = Text.of(AboutToExpirePage.TOTAL_RECORD_IN_RESULT).answeredBy(theActorInTheSpotlight()).toString();
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(redNumberMenu).isEqualTo(redNumberResult)
        );
    }

}

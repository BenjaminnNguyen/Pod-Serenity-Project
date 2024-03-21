package steps.admin.products;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.products.HandleProductAdmin;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AllProductsStepDefinitions {

    @And("Search product by info then system show result")
    public void search_product_by_full_name_field(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.resetFilter(),
                HandleProductAdmin.check(list.get(0)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }
}

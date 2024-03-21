package steps.api.admin.regions;

import cucumber.tasks.api.admin.regions.AdminDistributionCenterAPI;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

public class DistributionCenterAPIStepDefinitions {

    AdminDistributionCenterAPI adminDistributionCenterAPI = new AdminDistributionCenterAPI();

    @And("Admin search distribution center {string} by api")
    public void admin_search_distribution_by_api(String name) {
        String id = adminDistributionCenterAPI.getIdDistributionCenter(name);
        Serenity.setSessionVariable("Distribution Center ID").to(id);
    }

    @And("Admin delete distribution center {string} by api")
    public void admin_delete_distribution_by_api(String name) {
        String id =  Serenity.sessionVariableCalled("Distribution Center ID");
        if(id != null) {
            Response response = adminDistributionCenterAPI.callDeleteDistributionCenter(id);
        }
    }
}

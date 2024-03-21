package steps.api.admin.regions;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.regions.AdminRouteAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.List;
import java.util.Map;

public class AdminRouteAPIStepDefinitions {

    AdminRouteAPI adminRouteAPI = new AdminRouteAPI();

    @And("Admin search route by api")
    public void admin_search_route_by_api(DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        Response response = adminRouteAPI.callSearchRoute(infoObj.get(0));

        List<String> listId = adminRouteAPI.getRouteID(response, infoObj.get(0).get("q[name]").toString());
        Serenity.setSessionVariable("Route List ID").to(listId);
    }

    @And("Admin delete route {string} by api")
    public void admin_delete_route_by_api(String name) {
        List<String> listId = Serenity.sessionVariableCalled("Route List ID");
        if (listId.size() > 0) {
            for(String id : listId) {
                Response response = adminRouteAPI.callDeleteRoute(id);
            }
        }
    }
}

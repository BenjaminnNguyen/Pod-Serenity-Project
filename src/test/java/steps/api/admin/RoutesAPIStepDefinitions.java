package steps.api.admin;

import cucumber.tasks.api.admin.regions.AdminRouteAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RoutesAPIStepDefinitions {
    AdminRouteAPI adminRouteAPI = new AdminRouteAPI();

    @And("Admin set weekdays")
    public List<String> changeStateBrandActive(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        List<String> weekdays = new ArrayList<>();
        for (Map<String, String> map : infos) {
            weekdays.add(map.get("weekday"));
        }
        Serenity.setSessionVariable("List weekdays api").to(weekdays);
        return weekdays;
    }

    @And("Admin get Route with id {string}")
    public Response getRoute(String id) {
        Response response = adminRouteAPI.getRoute(id);
        return response;
    }

    @And("Admin edit Route id {string}")
    public Response editRoute(String id, DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        Map<String, Object> param = new HashMap<>();
        Map<String, Object> route = new HashMap<>();
        List<Map<String, Object>> routes_stores_attributes = new ArrayList<>();
//        Map<String, Object> weekdays = new HashMap<>(Serenity.sessionVariableCalled("List weekdays api"));

        route.put("name", infos.get(0).get("name"));
        route.put("region_id", infos.get(0).get("region_id"));
        route.put("weekdays", Serenity.sessionVariableCalled("List weekdays api"));
        route.put("routes_stores_attributes", routes_stores_attributes);
        route.put("delivery_cost", infos.get(0).get("delivery_cost"));
        route.put("case_pick_fee", infos.get(0).get("case_pick_fee"));
        route.put("within_7_business_day", infos.get(0).get("within_7_business_day"));
        param.put("route", route);

        Response response = adminRouteAPI.callEditRoute(id, route);

        return response;
    }

}

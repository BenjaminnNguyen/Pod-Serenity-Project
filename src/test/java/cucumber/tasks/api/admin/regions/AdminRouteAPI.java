package cucumber.tasks.api.admin.regions;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class AdminRouteAPI {
    CommonRequest commonRequest = new CommonRequest();

    public Response getRoute(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_ROUTE(id), "GET");
        System.out.println("RESPONSE ROUTE " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE ROUTE ").andContents(response.prettyPrint());
        return response;
    }

    public Response callEditRoute(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_ROUTE(id), map, "PUT");
        System.out.println("RESPONSE EDIT ROUTE " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT ROUTE ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSearchRoute(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_ROUTE, map, "GET");
        System.out.println("RESPONSE SEARCH ROUTE " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH ROUTE ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDeleteRoute(String routeID) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_ROUTE(routeID), "DELETE");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE ROUTE ").andContents(response.prettyPrint());
        return response;
    }

    public List<String> getRouteID(Response response, String name) {
        List<String> listID = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
            if(item.get("name").toString().contains(name)) {
                listID.add(item.get("id").toString());
            }
        }
        return listID;
    }

}

package cucumber.tasks.api.admin.inventory;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class InventoryRequestAPI {

    public Response callSearchInventoryRequest(Map<String, Object> map) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_GET_INVENTORY_REQUEST, map, "GET");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH INVENTORY REQUEST:  ").andContents(response.prettyPrint());
        return response;
    }

    public void callDeleteInventoryRequest(String id) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_GET_INVENTORY_REQUEST(id), "DELETE");
        System.out.println("RESPONSE DELETE INVENTORY REQUEST " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE INVENTORY REQUEST:  ").andContents(response.prettyPrint());
    }

    public void callCancelInventoryRequest(String id, Map<String, Object> map) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_CANCEL_INVENTORY_REQUEST(id), map, "PUT");
        System.out.println("RESPONSE CANCEL INVENTORY REQUEST " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CANCEL INVENTORY REQUEST:  ").andContents(response.prettyPrint());
    }

    public Response callCreateInventoryRequest(Map<String, Object> map) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_GET_INVENTORY_REQUEST, map, "POST");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE INVENTORY REQUEST:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callApprovedInventoryRequest(String id) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_APPROVED_INVENTORY_REQUEST(id), "PUT");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE APPROVED INVENTORY REQUEST: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callCompletedInventoryRequest(String id) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_COMPLETED_INVENTORY_REQUEST(id), "PUT");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE COMPLETED INVENTORY REQUEST: ").andContents(response.prettyPrint());
        return response;
    }

    public List<String> getIDsRequest(Response response) {
        List<String> ids = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
            ids.add(item.get("id").toString());
        }
        return ids;
    }

    public String getIDRequest(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        String number = jsonPath.get("number").toString();
        System.out.println("Inventory Request ID " + id);
        System.out.println("Inventory Request Number " + number);
        Serenity.setSessionVariable("Inventory Request ID API").to(id);
        Serenity.setSessionVariable("Inventory Request Number API").to(number);
        return id;
    }
}

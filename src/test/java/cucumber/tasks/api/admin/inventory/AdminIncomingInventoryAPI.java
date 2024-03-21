package cucumber.tasks.api.admin.inventory;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.specification.MultiPartSpecification;
import io.restassured.specification.RequestSpecification;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminIncomingInventoryAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callSearchIncoming(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_GET_INBOUND_INVENTORY, map, "GET");
        System.out.println("RESPONSE SEARCH INCOMING " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH INCOMING:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callCreateIncoming(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_GET_INBOUND_INVENTORY, map, "POST");
        System.out.println("RESPONSE CREATE INBOUND " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE INBOUND:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSubmitIncoming(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_INBOUND_INVENTORY(id), map, "PUT");
        System.out.println("RESPONSE SUBMIT INBOUND " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SUBMIT INBOUND:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callUploadFilesIncoming(String id, RequestSpecification requestSpecification ) {
        Response response = commonRequest.commonRequestWithParamMultiPart(UrlAdminAPI.ADMIN_INBOUND_INVENTORY(id), requestSpecification, "PUT");
        System.out.println("RESPONSE UPLOAD INBOUND " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE UPLOAD INBOUND:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callEDITIncoming(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_INBOUND_INVENTORY(id), map, "PUT");
        System.out.println("RESPONSE EDIT INBOUND " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT INBOUND:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callCancelIncoming(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_INBOUND_INVENTORY(id), map, "DELETE");
        System.out.println("RESPONSE CANCEL INBOUND " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CANCEL INBOUND:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDetailInbound(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_INBOUND_INVENTORY(id), "GET");
        System.out.println("RESPONSE GET INBOUND " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE GET INBOUND:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response getIdInbound(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        String number = jsonPath.get("number").toString();
        List<Map<String, Object>> inventories_attributes = jsonPath.get("inventories_attributes");
        List<String> inventories_attributes_id = new ArrayList<>();
        for (Map<String, Object> map : inventories_attributes) {
            inventories_attributes_id.add(map.get("id").toString());
        }
        Serenity.setSessionVariable("ID Inbound Inventory api").to(id);
        Serenity.setSessionVariable("Number Inbound Inventory api").to(number);
        Serenity.setSessionVariable("List id items Inbound Inventory api").to(inventories_attributes_id);
        return response;
    }

    public List<String> getListIdInbound(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<Map<String, Object>> results = jsonPath.get("results");
        List<String> ids = new ArrayList<>();

        for (Map<String, Object> map : results) {
            ids.add(map.get("id").toString());
        }
        System.out.println("List ID " + ids);
        Serenity.setSessionVariable("List id Inbound Inventory api").to(ids);
        return ids;
    }

    public Response getItemsInbound(String id) {
        Response response = callDetailInbound(id);
        JsonPath jsonPath = response.jsonPath();
        List<Map<String, Object>> inventories_attributes = jsonPath.get("inventories_attributes");
        Serenity.setSessionVariable("List items Inbound Inventory api").to(inventories_attributes);
        return response;
    }

    public Response getIDInventory(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<Map<String, Object>> inventories_attributes = jsonPath.get("inventories_attributes");
        String inventoryId = "";
        for (Map<String, Object> map : inventories_attributes) {
            if (map.containsKey("id"))
                inventoryId = map.get("id").toString();
        }
        Serenity.setSessionVariable("Id Inventory api").to(inventoryId);
        return response;
    }

//    public Response callDetailWithdrawal(String idWithdrawal) {
//        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_GET_DETAIL_WITHDRAWAL(idWithdrawal), "GET");
//        System.out.println("RESPONSE DETAIL WITHDRAWAL " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DETAIL WITHDRAWAL:  ").andContents(response.prettyPrint());
//        return response;
//    }

}

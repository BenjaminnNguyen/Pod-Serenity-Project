package cucumber.tasks.api.admin.products;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminProductQualitiesAPI {
    CommonRequest commonRequest = new CommonRequest();


    public Response callCreateProductQualities(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_PRODUCT_QUALITIES, map, "POST");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE PRODUCT QUALITIES: ").andContents(response.prettyPrint());
        return response;
    }

    public String getProductQualitiesId(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        Serenity.setSessionVariable("ID PRODUCT QUALITIES API").to(id);
        return id;
    }

    public Response callDeleteProductQualities(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DELETE_PRODUCT_QUALITIES(id), "DELETE");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE DELETE_PRODUCT_QUALITIES: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callEditProductQualities(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.DELETE_PRODUCT_QUALITIES(id), map, "PUT");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT DELETE_PRODUCT_QUALITIES: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callGetProductQualities() {
        Map<String, Object> map = new HashMap<>();
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_PRODUCT_QUALITIES, "GET");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE GET DELETE_PRODUCT_QUALITIES: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callGetProductQualities(int page) {
        Map<String, Object> map = new HashMap<>();
        map.put("page", page);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_PRODUCT_QUALITIES, map, "GET");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE GET DELETE_PRODUCT_QUALITIES: ").andContents(response.prettyPrint());
        return response;
    }

    public List<Map<String, Object>> callGetIdProductQualities() {
        Response response = callGetProductQualities();
        JsonPath jsonPath = response.jsonPath();
        int num_page = Integer.parseInt(jsonPath.get("num_pages").toString());
        List<Map<String, Object>> map = jsonPath.get("results");
        if (num_page >= 2) {
            for (int i = 2; i <= num_page; i++) {
                response = callGetProductQualities(i);
                jsonPath = response.jsonPath();
                List<Map<String, Object>> newMap = jsonPath.get("results");
                map.addAll(newMap);
            }
        }
        Serenity.setSessionVariable("List Product qualities").to(map);
        return map;
    }
}

package cucumber.tasks.api.admin.products;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminProductPackageSizeAPI {
    CommonRequest commonRequest = new CommonRequest();


    public Response callCreateProductPackageSize(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_PRODUCT_PACKAGE_SIZE, map, "POST");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE PRODUCT PACKAGE_SIZE: ").andContents(response.prettyPrint());
        return response;
    }

    public String getProductPackageSizeId(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        Serenity.setSessionVariable("ID PRODUCT PACKAGE SIZE API").to(id);
        return id;
    }

    public Response callDeleteProductPackageSize(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_PRODUCT_PACKAGE_SIZE(id), "DELETE");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE PACKAGE_SIZE: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callEditProductPackageSize(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_PRODUCT_PACKAGE_SIZE(id), map, "PUT");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT PACKAGE_SIZE: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callGetProductPackageSize() {
        Map<String, Object> map = new HashMap<>();
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_PRODUCT_PACKAGE_SIZE, "GET");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE GET PACKAGE_SIZE: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callGetProductPackageSize(int page) {
        Map<String, Object> map = new HashMap<>();
        map.put("page", page);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_PRODUCT_PACKAGE_SIZE, map, "GET");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE GET ADMIN_PRODUCT_PACKAGE_SIZE: ").andContents(response.prettyPrint());
        return response;
    }

    public List<Map<String, Object>> callGetIdProductPackageSize() {
        Response response = callGetProductPackageSize();
        JsonPath jsonPath = response.jsonPath();
        int num_page = Integer.parseInt(jsonPath.get("num_pages").toString());
        List<Map<String, Object>> map = jsonPath.get("results");
        if (num_page >= 2) {
            for (int i = 2; i <= num_page; i++) {
                response = callGetProductPackageSize(i);
                jsonPath = response.jsonPath();
                List<Map<String, Object>> newMap = jsonPath.get("results");
                map.addAll(newMap);
            }
        }
        Serenity.setSessionVariable("List Product Package Size").to(map);
        return map;
    }
}

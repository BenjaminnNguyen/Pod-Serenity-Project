package cucumber.tasks.api.vendor;


import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;
import org.json.JSONObject;

import java.net.URISyntaxException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callCreateProduct(JSONObject body, String basePath) {
        Response response = CommonRequest.callCommonApiTest(body, basePath);
        System.out.println("RESPONSE CREATE PRODUCT " + response.prettyPrint());
        Serenity.recordReportData().withTitle("RESPONSE CREATE PRODUCT: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSKUDraft(String url, String basePath) throws URISyntaxException {
        Response response = CommonRequest.commonRequestFormData(url, basePath);
        System.out.println("RESPONSE CREATE SKU " + response.prettyPrint());
        Serenity.recordReportData().withTitle("RESPONSE CREATE SKU: ").andContents(response.prettyPrint());
        return response;
    }
    public Response callDetailOfProduct(String basePath) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(basePath, "GET");
        System.out.println("RESPONSE DETAILS PRODUCT " + response.prettyPrint());
        Serenity.recordReportData().withTitle("RESPONSE DETAILS PRODUCT: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDeleteProduct(String basePath) {
        Response response = commonRequest.commonRequestNoBody(basePath, "PUT");
        System.out.println("RESPONSE DELETE PRODUCT " + response.prettyPrint());
        Serenity.recordReportData().withTitle("RESPONSE DELETE PRODUCT: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callStateOfProduct(String basePath) {
        Response response = commonRequest.commonRequestNoBody(basePath, "PUT");
        System.out.println("RESPONSE STATE PRODUCT " + response.prettyPrint());
        Serenity.recordReportData().withTitle("RESPONSE STATE PRODUCT: ").andContents(response.prettyPrint());
        return response;
    }

    public String getState(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String state = jsonPath.get("state").toString();
        System.out.println("State of Product = " + state);
        Serenity.setSessionVariable("State of Product").to(state);
        return state;
    }
    public List<String> getAllSKUid(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<Map<String, Object>> state = jsonPath.get("product_variants");
        List<String> ids = new ArrayList<>();
        for (Map<String, Object> id : state){
            ids.add(id.get("id").toString());
        }
        return ids;
    }

    public void getIDProduct(Response response) {
        JsonPath jsonPath = response.jsonPath();
        HashMap product = jsonPath.get("product");
        String id = product.get("id").toString();
        System.out.println("id = " + id);
        Serenity.setSessionVariable("ID Product").to(id);
        Serenity.recordReportData().withTitle("ID Product")
                .andContents(id);
    }
}

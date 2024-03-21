package cucumber.tasks.api.admin.fees;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HandleAdminFeesAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callSearchFees(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_FEES, map, "GET");
        System.out.println("response = " + response.prettyPrint());
        return response;
    }

    public void callDeleteFee(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_FEES(id), "DELETE");
    }

    public void callUpdateSmallOrderSurcharge(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_SMALL_ORDER_SURCHARGE(id), map, "PUT", 201);
        System.out.println(response.prettyPrint());
    }

    public String getId(Response response, String name) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = new ArrayList<>();
        String id = null;
        results = jsonPath.get("results");
        for (HashMap item : results) {
            if (item.get("name").toString().equals(name)) {
                id = item.get("id").toString();
            }
        }
        System.out.println("Id Fees api= " + id);
        return id;
    }
}

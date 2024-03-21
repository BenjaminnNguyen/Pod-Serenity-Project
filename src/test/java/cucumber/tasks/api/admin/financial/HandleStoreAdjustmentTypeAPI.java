package cucumber.tasks.api.admin.financial;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HandleStoreAdjustmentTypeAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callSearchStoreAdjustmentType(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.STORE_ADJUSTMENT_TYPE, map, "GET");
        System.out.println("reponse = " + response);
        return response;
    }

    public void callDeleteStoreAdjustmentType(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.STORE_ADJUSTMENT_TYPE(id), "DELETE");
    }

    public String getId(Response response, String name) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = new ArrayList<>();
        String id = null;
        results = jsonPath.get("results");
        for (HashMap item : results) {
            if(item.get("name").toString().contains(name)) {
                id = item.get("id").toString();
            }
        }
        System.out.println("Id Store adjustment type = " + id);
        return id;
    }
}

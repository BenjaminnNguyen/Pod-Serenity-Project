package cucumber.tasks.api.admin.financial;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HandleCreditMemoTypeAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callSearchCreditMemoType(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.CREDIT_MEMO_TYPE, map, "GET");
        System.out.println("reponse = " + response);
        return response;
    }

    public void callDeleteCreditMemoType(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.CREDIT_MEMO_TYPE(id), "DELETE");
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
        System.out.println("ID Credit Memo type = " + id);
        return id;
    }
}

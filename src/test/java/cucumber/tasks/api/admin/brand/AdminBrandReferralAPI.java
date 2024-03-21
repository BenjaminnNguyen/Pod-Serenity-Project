package cucumber.tasks.api.admin.brand;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminBrandReferralAPI {

    CommonRequest commonRequest = new CommonRequest();


    public Response callSearchBrandReferral(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.SEARCH_BRAND_REFERRAL, map, "GET");
        System.out.println("response " + response.prettyPrint());
        return response;
    }

    public Response callDeleteBrandReferral(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.BRAND_REFERRAL(id), "DELETE");
        return response;
    }


    public List<String> getBrandReferralListId(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        List<String> listID = new ArrayList<>();
        for (HashMap item : results) {
            listID.add(item.get("id").toString());

        }
        return listID;
    }
}

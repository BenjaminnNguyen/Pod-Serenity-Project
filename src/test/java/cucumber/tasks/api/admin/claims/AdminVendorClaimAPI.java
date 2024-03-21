package cucumber.tasks.api.admin.claims;

import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminVendorClaimAPI {
    CommonRequest commonRequest = new CommonRequest();

    public Response callSearchVendorClaims(String basePath, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(basePath, map, "GET");
        return response;
    }

    public List<String> getVendorClaimID(Response response) {
        List<String> listId = new ArrayList<String>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> listResult = jsonPath.get("results");
        for (HashMap item : listResult) {
            listId.add(item.get("id").toString());
        }
        System.out.println("list vendor claim id " + listId);
        Serenity.setSessionVariable("Vendor Claims ID").to(listId);
        return listId;
    }

    public Response callDeleteClaim(String basePath) {
        Response response = commonRequest.commonRequestNoBody(basePath, "DELETE");
        return response;
    }
}

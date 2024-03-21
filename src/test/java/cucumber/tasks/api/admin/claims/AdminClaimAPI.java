package cucumber.tasks.api.admin.claims;

import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminClaimAPI {
    CommonRequest commonRequest = new CommonRequest();

    public Response callSearchClaims(String basePath, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(basePath, map, "GET");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH CLAIM: ").andContents(response.prettyPrint());
        return response;
    }

    public List<String> getClaimID(Response response) {
        List<String> listId = new ArrayList<String>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> listResult = jsonPath.get("results");
        for (HashMap item : listResult) {
            listId.add(item.get("id").toString());
        }
        Serenity.setSessionVariable("ID Claims").to(listId);
        return listId;
    }

    public Response callDeleteClaim(String basePath) {
        Response response = commonRequest.commonRequestNoBody(basePath, "DELETE");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE CLAIMS: ").andContents(response.prettyPrint());
        return response;
    }
}

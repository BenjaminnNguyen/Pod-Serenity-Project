package cucumber.tasks.api.admin;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.Map;

public class PreOrderAdminAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callSearchPreOrder(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_GET_INVENTORY, map, "GET");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH PRE-ORDER :  ").andContents(response.prettyPrint());
        return response;
    }


}

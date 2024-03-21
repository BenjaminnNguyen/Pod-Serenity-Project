package cucumber.tasks.api.admin.master;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static cucumber.singleton.UrlAdminAPI.ADMIN_GENERAL;

public class MasterAPI {

    public Response callTurnKailua(Map<String, Object> map) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequest(map, ADMIN_GENERAL, "PUT");
        System.out.println("RESPONSE CREATE KAILUA " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE KAILUA:  ").andContents(response.prettyPrint());
        return response;
    }

}

package cucumber.tasks.api.vendor;

import cucumber.tasks.api.CommonRequest;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.Map;

public class HandleVendorAPI {

    public Response callCreateVendorCompany(Map<String, Object> map, String basePath) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequest(map, basePath, "POST");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE VENDOR COMPANY :  ").andContents(response.prettyPrint());
        return response;
    }

}

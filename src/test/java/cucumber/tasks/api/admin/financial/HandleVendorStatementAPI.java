package cucumber.tasks.api.admin.financial;

import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HandleVendorStatementAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callGetDetailVendorStatement(String basePath) {
        Response response = commonRequest.commonRequestNoBody(basePath, "GET");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DETAIL VENDOR STATEMENT: ").andContents(response.prettyPrint());
        return response;
    }

    public List<String> getListAdjustmentID(Response response) {
        List<String> list = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        HashMap vendor_statement = jsonPath.get("vendor_statement");
        if(vendor_statement.get("statement_item_and_payments") != null) {
            List<HashMap> statement_item_and_payments = (List<HashMap>) vendor_statement.get("statement_item_and_payments");
            for(HashMap item : statement_item_and_payments) {
                if(item.get("type").equals("StatementItems::Adjustment")) {
                    list.add(item.get("id").toString());
                }
            }
        }

        Serenity.setSessionVariable("List Adjustment Vendor Statement").to(list);
        return list;
    }

    public Response callDeleteAdjustment(String basePath) {
        Response response = commonRequest.commonRequestNoBody(basePath, "DELETE");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DETAIL VENDOR STATEMENT: ").andContents(response.prettyPrint());
        return response;
    }
}

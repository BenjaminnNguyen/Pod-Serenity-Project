package steps.api.admin.financial;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.admin.financial.HandleVendorStatementAPI;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.List;

public class VendorStatementAPIStepDefinitions {

    HandleVendorStatementAPI handleVendorStatementAPI = new HandleVendorStatementAPI();

    @And("Admin delete adjustment of vendor statement {string} by api")
    public void delete_adjustment_of_vendor_statement_by_API(String vendorStatementID) {
        // get detail vendor statement
        Response response = handleVendorStatementAPI.callGetDetailVendorStatement(UrlAdminAPI.VENDOR_STATEMENT(vendorStatementID));

        List<String> listAdjustmentID = handleVendorStatementAPI.getListAdjustmentID(response);
        if (listAdjustmentID.size() > 0) {
            for (String adjustmentID : listAdjustmentID) {
                handleVendorStatementAPI.callDeleteAdjustment(UrlAdminAPI.VENDOR_STATEMENT_ADJUSTMENT(vendorStatementID, adjustmentID));
            }
        }
    }
}

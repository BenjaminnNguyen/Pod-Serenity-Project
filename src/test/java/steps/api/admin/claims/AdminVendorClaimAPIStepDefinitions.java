package steps.api.admin.claims;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.claims.AdminVendorClaimAPI;
import cucumber.tasks.common.CommonTask;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminVendorClaimAPIStepDefinitions {

    @And("Admin search vendor claim by api")
    public void admin_search_vendor_claim_by_api(DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        AdminVendorClaimAPI adminVendorClaimAPI = new AdminVendorClaimAPI();
        HashMap<String, Object> info = CommonTask.setValue1(infoObj.get(0), "q[number]", infoObj.get(0).get("q[number]"), Serenity.sessionVariableCalled("Claim Number"), "create by api");
        Response response = adminVendorClaimAPI.callSearchVendorClaims(UrlAdminAPI.SEARCH_VENDOR_CLAIM, info);
        // lấy ra list ID claim
        adminVendorClaimAPI.getVendorClaimID(response);
    }

    @And("Admin delete vendor claim {string} by api")
    public void admin_delete_vendor_claim_by_api(String claimID) {
        List<String> listId = Serenity.sessionVariableCalled("Vendor Claims ID");
        if (listId.size() > 0) {
            AdminVendorClaimAPI adminVendorClaimAPI = new AdminVendorClaimAPI();
            for (String id : listId) {
                adminVendorClaimAPI.callDeleteClaim(UrlAdminAPI.DELETE_VENDOR_CLAIM(id));
            }
        }

    }
}

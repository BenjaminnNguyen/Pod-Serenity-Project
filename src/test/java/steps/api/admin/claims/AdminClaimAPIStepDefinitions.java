package steps.api.admin.claims;

import cucumber.tasks.api.CommonHandle;
import io.cucumber.java.en.*;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.admin.claims.AdminClaimAPI;
import cucumber.tasks.common.CommonTask;
import io.cucumber.datatable.DataTable;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminClaimAPIStepDefinitions {

    AdminClaimAPI adminClaimAPI = new AdminClaimAPI();

    @And("Admin search claim by api")
    public void admin_search_claim_by_api(DataTable dt) {
        List<Map<String, Object>> infoObj  = CommonHandle.convertDataTable(dt);

        HashMap<String, Object> info =  CommonTask.setValue1(infoObj.get(0), "q[sub_invoice_number]", infoObj.get(0).get("q[sub_invoice_number]"), Serenity.sessionVariableCalled("Sub-invoice ID create by admin"), "create by api");
        Response response = adminClaimAPI.callSearchClaims(UrlAdminAPI.SEARCH_CLAIM, info);
        //lấy ra list ID claim
        adminClaimAPI.getClaimID(response);
    }

    @And("Admin delete claim {string} by api")
    public void admin_delete_claim_by_api(String claimID) {
        List<String> listId = Serenity.sessionVariableCalled("ID Claims");
        for(String id : listId) {
           adminClaimAPI.callDeleteClaim(UrlAdminAPI.DELETE_CLAIM(id));
        }
    }

}

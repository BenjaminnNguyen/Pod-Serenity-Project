package steps.api.admin.brands;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.brand.AdminBrandReferralAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.List;
import java.util.Map;

public class BrandReferralAPIStepDefinitions {

    AdminBrandReferralAPI adminBrandReferralAPI = new AdminBrandReferralAPI();

    @And("Admin search brand referral by api")
    public void admin_search_brand_referral_by_api(DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        Response response = adminBrandReferralAPI.callSearchBrandReferral(infoObj.get(0));

        List<String> listID = adminBrandReferralAPI.getBrandReferralListId(response);
        System.out.println("list id =" + listID);
        Serenity.setSessionVariable("List ID Brand Referral").to(listID);
    }


    @And("Admin delete brand referral by api")
    public void delete_brand_referral_by_api() {
        List<String> listID = Serenity.sessionVariableCalled("List ID Brand Referral");
        if (listID.size() != 0) {
            for (String id : listID) {
                adminBrandReferralAPI.callDeleteBrandReferral(id);
            }
        }
    }

}

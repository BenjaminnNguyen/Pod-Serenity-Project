package steps.api.admin.vendor;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.CommonRequest;
import cucumber.tasks.api.admin.vendor.AdminVendorSuccessFormAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.List;
import java.util.Map;

public class AdminVendorSuccessFormAPIStepDefinitions {

    @And("Admin edit store list in success form by API")
    public void admin_edit_store_list_in_success_form(DataTable dt) {
        CommonRequest commonRequest = new CommonRequest();
        AdminVendorSuccessFormAPI adminVendorSuccessFormAPI = new AdminVendorSuccessFormAPI();
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);

        Map<String, Object> info = adminVendorSuccessFormAPI.setStoreListItemsModel(infos.get(0));
        Response response = adminVendorSuccessFormAPI.callEditStoreList(info);
    }

    @And("Admin edit store list {string} in success form detail by API")
    public void admin_edit_store_list_in_success_form_detail(String buyerCompany, DataTable dt) {
        CommonRequest commonRequest = new CommonRequest();
        AdminVendorSuccessFormAPI adminVendorSuccessFormAPI = new AdminVendorSuccessFormAPI();
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        // get ID from search
        Response response = Serenity.sessionVariableCalled("Response get store list");
        String id = adminVendorSuccessFormAPI.getIdStoreList(buyerCompany, response);

        Map<String, Object> info = adminVendorSuccessFormAPI.setStoreListItemsModel(infos.get(0));
        Response response1 = adminVendorSuccessFormAPI.callEditStoreListInDetail(id, info);
    }

    @And("Admin search store list in success form by API")
    public void admin_search_store_list_in_success_form(DataTable dt) {
        CommonRequest commonRequest = new CommonRequest();
        AdminVendorSuccessFormAPI adminVendorSuccessFormAPI = new AdminVendorSuccessFormAPI();
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);

        Response response = adminVendorSuccessFormAPI.callSearchStoreList(infos.get(0));
        Serenity.setSessionVariable("Response get store list").to(response);
    }

    @And("Admin get id special buyer company by API")
    public void admin_get_id_special_buyer_company() {
        AdminVendorSuccessFormAPI adminVendorSuccessFormAPI = new AdminVendorSuccessFormAPI();
        Response response = adminVendorSuccessFormAPI.callSpecialBuyerCompany();

        adminVendorSuccessFormAPI.getIdSpecialBuyerCompany(response);
    }

    @And("Admin delete special buyer company by API")
    public void admin_delete_special_buyer_company() {
        AdminVendorSuccessFormAPI adminVendorSuccessFormAPI = new AdminVendorSuccessFormAPI();
        List<String> ids = Serenity.sessionVariableCalled("Special Buyer Company List ID");
        if (ids.size() > 0) {
            for (String id : ids) {
                Response response = adminVendorSuccessFormAPI.callDeleteSpecialBuyerCompany(id);
            }
        }
    }

}

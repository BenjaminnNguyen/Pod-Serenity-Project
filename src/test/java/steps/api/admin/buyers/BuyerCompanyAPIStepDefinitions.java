package steps.api.admin.buyers;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.buyers.AdminBuyerCompanyAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BuyerCompanyAPIStepDefinitions {
    AdminBuyerCompanyAPI adminBuyerCompanyAPI = new AdminBuyerCompanyAPI();

    @And("Admin delete buyer company {string} by API")
    public void delete_buyer_company_by_API(String buyerCompanyID) {
        if (buyerCompanyID.equals("")) {
            buyerCompanyID = Serenity.sessionVariableCalled("Buyer Company ID");
        }
        if (buyerCompanyID != null) {
            Response response = adminBuyerCompanyAPI.callDeleteBuyerCompany(buyerCompanyID);
        }

    }

    @And("Admin search buyer company by API")
    public void search_buyer_company_by_api(DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);

        // set model
        Map<String, Object> map = adminBuyerCompanyAPI.setSearchBuyerCompanyModel(infoObj.get(0));
        // gửi request
        Response response = adminBuyerCompanyAPI.callSearchBuyerCompany(map);
        // get buyer company id từ response
        adminBuyerCompanyAPI.getBuyerCompanyID(response);
    }

    @And("Admin create buyer company by API")
    public void create_buyer_company_by_api(DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        // set model
        Map<String, Object> map = adminBuyerCompanyAPI.setCreateBuyerCompanyModel(infoObj.get(0));
        // gửi request
        Response response = adminBuyerCompanyAPI.callCreateBuyerCompany(map);
        // get buyer company id từ response
        adminBuyerCompanyAPI.getBuyerCompanyIDFromCreate(response);
    }

    @And("Admin change info of buyer company {string} by API")
    public void change_info_of_buyer_company_by_api(String idBuyerCompany, DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        if (idBuyerCompany.equals("create by api")) {
            idBuyerCompany = Serenity.sessionVariableCalled("Buyer Company ID");
        }
        // set model
        Map<String, Object> map = adminBuyerCompanyAPI.setChangeInfoBuyerCompanyModel(infoObj.get(0));
        // gửi request
        Response response = adminBuyerCompanyAPI.callChangeInfoBuyerCompany(idBuyerCompany, map);
    }

    @And("Admin change state of buyer company {string} to {string} by API")
    public void change_state_of_buyer_company_by_api(String idBuyerCompany, String state) {
        if (idBuyerCompany.equals("create by api")) {
            idBuyerCompany = Serenity.sessionVariableCalled("Buyer Company ID");
        }
        // get detail buyer company
        Response response = adminBuyerCompanyAPI.callGetDetailBuyerCompany(idBuyerCompany);
        // get info state of buyer company
        String curState = adminBuyerCompanyAPI.getState(response);
        if (!state.equals(curState)) {
            Response response1 = adminBuyerCompanyAPI.callChangeStateBuyerCompany(idBuyerCompany);
        }
    }

    @And("Admin change credit limit of buyer company {string} by API")
    public void change_credit_limit_of_buyer_company_by_api(String buyerCompanyID, DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        if(buyerCompanyID.equals("random")) {
            buyerCompanyID = Serenity.sessionVariableCalled("Buyer Company ID");
        }
        Map<String, Object> body = adminBuyerCompanyAPI.setChangeCreditBuyerCompanyModel(infoObj.get(0));
        Response response = adminBuyerCompanyAPI.callChangeCreditBuyerCompany(buyerCompanyID, body);
    }

    @And("Admin add tag to buyer company {string} by API")
    public void admin_add_tag_to_buyer_company_by_api(String idBuyerCompany, DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        if (idBuyerCompany.equals("create by api")) {
            idBuyerCompany = Serenity.sessionVariableCalled("Buyer Company ID");
        }
        // set model
        Map<String, Object> map = adminBuyerCompanyAPI.setChangeTagModel(infoObj);
        // gửi request
        Response response = adminBuyerCompanyAPI.callChangeInfoBuyerCompany(idBuyerCompany, map);
    }

    @And("Admin remove tag to buyer company {string} by API")
    public void admin_remove_tag_to_buyer_company_by_api(String idBuyerCompany) {
        // get detail buyer company to get list tags id
        Response response = adminBuyerCompanyAPI.callGetDetailBuyerCompany(idBuyerCompany);
        List<HashMap> tagsInfo = adminBuyerCompanyAPI.getTagIds(response);
        if (tagsInfo.size() > 0) {
            // set model
            Map<String, Object> map = adminBuyerCompanyAPI.setDeleteTagsModel(tagsInfo);
            // gửi request
            Response response1 = adminBuyerCompanyAPI.callChangeInfoBuyerCompany(idBuyerCompany, map);
        }
    }

    @And("Admin update buyer company {string} by API")
    public void setReceivingNote(String id, DataTable dt) {
        List<Map<String, Object>> info = CommonHandle.convertDataTable(dt);
        if (id.contains("api"))
            id = Serenity.sessionVariableCalled("Buyer Company ID");
        Map<String, Object> map = new HashMap<>();
        for (Map<String, Object> field : info) {
            map.putIfAbsent(field.get("field").toString(), field.get("value").toString());
            Response response = adminBuyerCompanyAPI.callUpdateBuyerCompany(id, map);
        }
    }
}

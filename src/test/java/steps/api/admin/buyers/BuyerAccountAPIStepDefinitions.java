package steps.api.admin.buyers;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.api.admin.buyers.AdminBuyerAccountAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BuyerAccountAPIStepDefinitions {
    AdminBuyerAccountAPI adminBuyerCompanyAPI = new AdminBuyerAccountAPI();

    @And("Admin create {string} buyer account by API")
    public void create_buyer_company_by_api(String type, DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);

        switch (type) {
            case "head":
                type = UrlAdminAPI.ADMIN_HEAD_BUYER_ACCOUNT;
                break;
            case "store":
            case "sub":
                type = UrlAdminAPI.ADMIN_BUYER_ACCOUNT;
                break;
        }
        // set model
        Map<String, Object> map = adminBuyerCompanyAPI.setCreateBuyerAccountModel(infoObj);
        // gửi request
        Response response = adminBuyerCompanyAPI.callCreateBuyer(type, map);
        // get buyer company id từ response
        adminBuyerCompanyAPI.getBuyerAccIDFromCreate(response);
    }

    @And("Admin search buyer by API")
    public void search_buyer_by_api(DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        // gửi request
        Response response = adminBuyerCompanyAPI.callSearchBuyer(infoObj.get(0));
        // get buyer company id từ response
        List<String> ids = adminBuyerCompanyAPI.getBuyerCompanyIDs(response);
        System.out.println("list id " + ids);
    }

    @And("Admin delete buyer all by API")
    public void delete_buyer_by_API() {
        List<String> buyerIDs = Serenity.sessionVariableCalled("Buyer IDs");
        if (buyerIDs.size() > 0) {
            for (String buyerID : buyerIDs) {
                Response response = adminBuyerCompanyAPI.callDeleteBuyer(buyerID);
            }
        }
    }

    @And("Admin delete head buyer all by API")
    public void delete_head_buyer_by_API() {
        List<String> buyerIDs = Serenity.sessionVariableCalled("Buyer IDs");
        if (buyerIDs.size() > 0) {
            for (String buyerID : buyerIDs) {
                Response response = adminBuyerCompanyAPI.callDeleteHeadBuyer(buyerID);
            }
        }
    }

    @And("Admin active buyer {string} to activate by API")
    public void update_buyer(String id) {
        // Call detail xem trạng thái buyer
        Response responseDetail = adminBuyerCompanyAPI.callDetailBuyer(id);
        String state = adminBuyerCompanyAPI.getStateBuyer(responseDetail);
        if (state.equals("inactive")) {
            Response response = adminBuyerCompanyAPI.callActiveBuyer(id);
        }
    }

    @And("Admin change general information of buyer {string}")
    public void admin_change_general_informatio_of_buyer(String buyerID, DataTable dt) {
        List<Map<String, Object>> infos = CommonHandle.convertDataTable(dt);
        Map<String, Object> buyer = adminBuyerCompanyAPI.setEditGeneralInforBuyer(infos.get(0));
        adminBuyerCompanyAPI.callEditBuyer(buyerID, buyer);
    }
}

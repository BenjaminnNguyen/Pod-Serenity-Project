package cucumber.tasks.api.admin.buyers;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminBuyerAccountAPI {

    /**
     * Set model để create buyer account
     *
     * @param maps
     * @return
     */
    public Map<String, Object> setCreateBuyerAccountModel(List<Map<String, Object>> maps) {
        // List tag
        List<String> tags = new ArrayList<>();

        for (Map<String, Object> item : maps) {
            tags.add(item.get("tag").toString());
        }
        // attribute of buyer acc
        HashMap<String, Object> att = new HashMap<>();
        att.putIfAbsent("buyers_tags_attributes", tags);

        att.putIfAbsent("business_name", maps.get(0).get("business_name"));
        // nếu tạo head buyer thì cần buyer company id
        if (maps.get(0).containsKey("buyer_company_id")) {
            String buyerCompanyID = maps.get(0).get("buyer_company_id").toString();
            if (maps.get(0).get("buyer_company_id").equals("create by api")) {
                buyerCompanyID = Serenity.sessionVariableCalled("Buyer Company ID");
            }
            att.putIfAbsent("buyer_company_id", buyerCompanyID);
        }
        // nếu tạo head buyer thì cần list region
        if (maps.get(0).containsKey("region")) {
            // List region
            List<String> regions = new ArrayList<>();
            for (Map<String, Object> item : maps) {
                regions.add(item.get("region").toString());
            }
            att.putIfAbsent("assigned_region_ids", regions);
        }
        att.putIfAbsent("contact_number", maps.get(0).get("contact_number"));
        att.putIfAbsent("email", maps.get(0).get("email"));
        att.putIfAbsent("first_name", maps.get(0).get("first_name"));
        att.putIfAbsent("last_name", maps.get(0).get("last_name"));
        if (maps.get(0).get("manager_id").equals("create by api")) {
            att.putIfAbsent("manager_id", Serenity.sessionVariableCalled("Buyer Account ID"));
        } else {
            att.putIfAbsent("manager_id", maps.get(0).get("manager_id"));
        }
        att.putIfAbsent("manager_id", maps.get(0).get("manager_id"));
        att.putIfAbsent("password", maps.get(0).get("password"));
        att.putIfAbsent("role", maps.get(0).get("role"));
        // xử lý store id
        if (maps.get(0).get("store_id").equals("create by api")) {
            att.putIfAbsent("store_id", Serenity.sessionVariableCalled("ID Store API"));
        } else {
            att.putIfAbsent("store_id", maps.get(0).get("store_id"));
        }

        // body create buyer account
        HashMap<String, Object> body = new HashMap<>();
        body.putIfAbsent("buyer", att);

        return body;
    }

    public Response callCreateBuyer(String basePath, Map<String, Object> map) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithBody2(basePath, map, "POST");
        System.out.println("RESPONSE CREATE BUYER ACCOUNT " + response.prettyPrint());
        Serenity.recordReportData().withTitle("RESPONSE CREATE BUYER ACCOUNT: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSearchBuyer(Map<String, Object> map) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_BUYER_ACCOUNT, map, "GET");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH BUYER").andContents(response.prettyPrint());
        return response;
    }

    public Response callDeleteBuyer(String vendorID) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_BUYER_ACCOUNT(vendorID), "DELETE");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE BUYER ").andContents(response.prettyPrint());
        return response;
    }

    public Response callEditBuyer(String id, Map<String, Object> map) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_BUYER_ACCOUNT(id), map, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE EDIT BUYER ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDeleteHeadBuyer(String vendorID) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_HEAD_BUYER_ACCOUNT(vendorID), "DELETE");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE HEAD BUYER ").andContents(response.prettyPrint());
        return response;
    }

    public Response callActiveBuyer(String buyerID) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_BUYER_ACCOUNT_STATE(buyerID), "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE HEAD BUYER ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDetailBuyer(String vendorID) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_BUYER_ACCOUNT(vendorID), "GET");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE HEAD BUYER ").andContents(response.prettyPrint());
        return response;
    }

    /**
     * Get buyer account from reponse create
     *
     * @param response
     * @return
     */
    public String getBuyerAccIDFromCreate(Response response) {
        String buyerAccID = null;
        JsonPath jsonPath = response.jsonPath();
        buyerAccID = jsonPath.get("id").toString();
        System.out.println("Buyer ID = " + buyerAccID);
        Serenity.setSessionVariable("Buyer Account ID").to(buyerAccID);
        return buyerAccID;
    }

    public String getBuyerCompanyID(Response response) {
        String buyerID = null;
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> result = jsonPath.get("results");
        if (result.size() > 0) {
            buyerID = result.get(0).get("id").toString();
        }
        Serenity.setSessionVariable("Buyer ID").to(buyerID);
        return buyerID;
    }

    public List<String> getBuyerCompanyIDs(Response response) {
        List<String> buyerID = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> result = jsonPath.get("results");
        if (result.size() > 0) {
            for (HashMap item : result) {
                buyerID.add(item.get("id").toString());
            }
        }
        Serenity.setSessionVariable("Buyer IDs").to(buyerID);
        return buyerID;
    }

    public String getStateBuyer(Response response) {
        String state = null;
        JsonPath jsonPath = response.jsonPath();
        state = jsonPath.get("active_state").toString();
        return state;
    }

    /**
     * Set model to edit general information of buyer
     *
     * @param response
     * @return
     */
    public Map<String, Object> setEditGeneralInforBuyer(Map<String, Object> info) {
        Map<String, Object> buyer = new HashMap<>();

        buyer.putIfAbsent("buyer", info);
        return buyer;
    }

}

package cucumber.tasks.api.admin.buyers;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.cucumber.java.hu.Ha;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminBuyerCompanyAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callDeleteBuyerCompany(String vendorID) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_BUYER_COMPANY(vendorID), "DELETE");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE BUYER COMPANY ").andContents(response.prettyPrint());
        return response;
    }

    public Response callSearchBuyerCompany(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_BUYER_COMPANY, map, "GET");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH BUYER COMPANY ").andContents(response.prettyPrint());
        return response;
    }

    public Response callCreateBuyerCompany(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_BUYER_COMPANY, map, "POST");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE BUYER COMPANY ").andContents(response.prettyPrint());
        return response;
    }

    public Response callChangeInfoBuyerCompany(String idBuyerCompany, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_BUYER_COMPANY(idBuyerCompany), map, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CHANGE INFO BUYER COMPANY ").andContents(response.prettyPrint());
        return response;
    }

    public Response callEditBuyerCompany(String idBuyerCompany, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_BUYER_COMPANY(idBuyerCompany), map, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CHANGE INFO BUYER COMPANY ").andContents(response.prettyPrint());
        return response;
    }

    public Response callChangeStateBuyerCompany(String idBuyerCompany) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_BUYER_COMPANY_STATE(idBuyerCompany), "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CHANGE STATE BUYER COMPANY ").andContents(response.prettyPrint());
        return response;
    }

    public Response callGetDetailBuyerCompany(String idBuyerCompany) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_BUYER_COMPANY(idBuyerCompany), "GET");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE GET DETAIL BUYER COMPANY ").andContents(response.prettyPrint());
        return response;
    }

    public Response callChangeCreditBuyerCompany(String idBuyerCompany, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_CHANGE_CREDIT_LIMIT(idBuyerCompany), map, "PUT");
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CHANGE CREDIT LIMIT BUYER COMPANY ").andContents(response.prettyPrint());
        return response;
    }

    public String getState(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String state = jsonPath.get("state").toString();
        System.out.println("State of store = " + state);
        Serenity.setSessionVariable("State of Store").to(state);
        return state;
    }

    /**
     * Set model để search buyer company
     *
     * @param map
     * @return
     */
    public Map<String, Object> setSearchBuyerCompanyModel(Map<String, Object> map) {
        Map<String, Object> search = new HashMap<>();
        search.putIfAbsent("q[name]", map.get("buyerCompany"));
//        search.putIfAbsent("q[managedBy]", map.get("managedBy"));
        search.putIfAbsent("q[onboarding_state]", map.get("onboardingState"));
        search.putIfAbsent("q[tag_ids][]", map.get("tag"));
        return search;
    }

    /**
     * Get buyer company from reponse search
     *
     * @param response
     * @return
     */
    public String getBuyerCompanyID(Response response) {
        String buyerCompanyID = null;
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> result = jsonPath.get("results");
        if (result.size() > 0) {
            buyerCompanyID = result.get(0).get("id").toString();
        }
        Serenity.setSessionVariable("Buyer Company ID").to(buyerCompanyID);
        return buyerCompanyID;
    }

    /**
     * Get buyer company from reponse create
     *
     * @param response
     * @return
     */
    public String getBuyerCompanyIDFromCreate(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String buyerCompanyID = jsonPath.get("id").toString();
        Serenity.setSessionVariable("Buyer Company ID").to(buyerCompanyID);
        return buyerCompanyID;
    }

    /**
     * Get list tags id from response detail buyer company
     *
     * @param response
     * @return
     */
    public List<HashMap> getTagIds(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> tagsInfo = jsonPath.get("tags_info");
        Serenity.setSessionVariable("Buyer Company Tag IDs").to(tagsInfo);
        return tagsInfo;
    }

    /**
     * Set model to create buyer company
     *
     * @param map
     * @return
     */
    public Map<String, Object> setCreateBuyerCompanyModel(Map<String, Object> map) {
        HashMap<String, Object> body = new HashMap<>(map);
        List<String> tags = new ArrayList<>();
        body.putIfAbsent("buyer_companies_tags_attributes", tags);
        return body;
    }

    /**
     * Set model to change info of  buyer company
     *
     * @param map
     * @return
     */
    public Map<String, Object> setChangeInfoBuyerCompanyModel(Map<String, Object> map) {
        HashMap<String, Object> body = new HashMap<>();
        body.putIfAbsent("buyer_company", map);
        return body;
    }

    /**
     * Set model to change info of  buyer company
     *
     * @param map
     * @return
     */
    public Map<String, Object> setChangeTagModel(List<Map<String, Object>> maps) {
        HashMap<String, Object> body = new HashMap<>();
        HashMap<String, Object> buyer_companies_tags_attributes = new HashMap<>();
        buyer_companies_tags_attributes.put("buyer_companies_tags_attributes", maps);
        body.putIfAbsent("buyer_company", buyer_companies_tags_attributes);
        return body;
    }

    /**
     * Set model để change credit buyer company
     *
     * @param map
     * @return
     */
    public Map<String, Object> setChangeCreditBuyerCompanyModel(Map<String, Object> map) {
        Map<String, Object> body = new HashMap<>();
        Map<String, Object> buyer_company = new HashMap<>();
        Map<String, Object> credit_limit_attributes = new HashMap<>();
        String buyerCompanyID = null;
        if(map.get("buyer_company_id").equals("random")) {
            buyerCompanyID = Serenity.sessionVariableCalled("Buyer Company ID");
        }
        credit_limit_attributes.putIfAbsent("buyer_company_id", buyerCompanyID);
//        credit_limit_attributes.putIfAbsent("id", map.get("id"));
        credit_limit_attributes.putIfAbsent("limit_value", map.get("limit_value"));

        buyer_company.putIfAbsent("credit_limit_attributes", credit_limit_attributes);
        buyer_company.putIfAbsent("credit_limit_temps_attributes", new ArrayList<>());

        body.putIfAbsent("buyer_company", buyer_company);

        return body;
    }

    /**
     * Set model to delete tags of  buyer company
     *
     * @param map
     * @return
     */
    public Map<String, Object> setDeleteTagsModel(List<HashMap> maps) {
        HashMap<String, Object> body = new HashMap<>();
        HashMap<String, Object> buyer_companies_tags_attributes = new HashMap<>();
        for (HashMap item : maps) {
            item.put("_destroy", true);
        }
        buyer_companies_tags_attributes.put("buyer_companies_tags_attributes", maps);
        body.putIfAbsent("buyer_company", buyer_companies_tags_attributes);
        return body;
    }

    public Response callUpdateBuyerCompany(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_BUYER_COMPANY(id), map, "PUT");
//        System.out.println("RESPONSE UPDATE STORE " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE UPDATE STORE:  ").andContents(response.prettyPrint());
        return response;
    }

}

package cucumber.tasks.api.admin.vendor;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminVendorSuccessFormAPI {

    /**
     * Edit store list in detail of vendor success form
     */
    public Response callSearchStoreList(Map<String, Object> map) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_STORE_LIST_ITEMS, map, "GET");
        Serenity.recordReportData().withTitle("RESPONSE SEARCH STORE LIST ITEM: ").andContents(response.prettyPrint());
        return response;
    }

    /**
     * Edit store list in create new form of vendor success form
     */
    public Response callEditStoreList(Map<String, Object> map) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_STORE_LIST_ITEMS, map, "POST");
        Serenity.recordReportData().withTitle("RESPONSE EDIT STORE LIST ITEM: ").andContents(response.prettyPrint());
        return response;
    }

    /**
     * Edit store list in detail of vendor success form
     */
    public Response callEditStoreListInDetail(String storeListID, Map<String, Object> map) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_STORE_LIST_ITEMS(storeListID), map, "PUT");
        Serenity.recordReportData().withTitle("RESPONSE EDIT STORE LIST ITEM: ").andContents(response.prettyPrint());
        return response;
    }

    /**
     * Get special buyer company
     */
    public Response callSpecialBuyerCompany() {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_SPECIAL_BUYER_COMPANY, "GET");
        Serenity.recordReportData().withTitle("RESPONSE SPECIAL BUYER COMPANY: ").andContents(response.prettyPrint());
        return response;
    }

    /**
     * Delete special buyer company
     */
    public Response callDeleteSpecialBuyerCompany(String id) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_SPECIAL_BUYER_COMPANY(id), "DELETE");
        Serenity.recordReportData().withTitle("RESPONSE DELETE SPECIAL BUYER COMPANY: ").andContents(response.prettyPrint());
        return response;
    }

    public Map<String, Object> setStoreListItemsModel(Map<String, Object> map) {
        Map<String, Object> store_list_item = new HashMap<>();
        store_list_item.put("store_list_item", map);
        return store_list_item;
    }


    /**
     * Get ID of store list after search
     */

    public String getIdStoreList(String buyerCompany, Response response) {
        String id = null;
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
            if (item.get("buyer_company_name").toString().equals(buyerCompany)) {
                id = item.get("id").toString();
            }
        }

        Serenity.setSessionVariable("Store List ID").to(id);
        return id;
    }

    public List<String> getIdSpecialBuyerCompany(Response response) {
        List<String> ids = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
           ids.add(item.get("id").toString());
        }

        Serenity.setSessionVariable("Special Buyer Company List ID").to(ids);
        return ids;
    }
}

package cucumber.tasks.api.admin;

import cucumber.singleton.UrlAPI;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminLPAPI {
    CommonRequest commonRequest = new CommonRequest();

    public Response callSearchLPCompany(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_LP_COMPANY(), map, "GET");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH LP COMPANY: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callCreateLPCompany(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_LP_COMPANY(), map, "POST");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE LP COMPANY: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callCreateLP(Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_LP(), map, "POST");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE LP: ").andContents(response.prettyPrint());
        return response;
    }

    public String getIdLPCompany(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        Serenity.setSessionVariable("LP Company id api").to(id);
        return id;
    }

    public String getIdLP(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        Serenity.setSessionVariable("LP id api").to(id);
        return id;
    }

    public List<String> getIdsLPCompany(Response response) {
        List<String> listId = new ArrayList<String>();
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> listResult = jsonPath.get("results");
        for (HashMap item : listResult) {
            listId.add(item.get("id").toString());
        }
        Serenity.setSessionVariable("List LP Company id api").to(listId);
        return listId;
    }

    public Response callDeleteLPCompany(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_LP_COMPANY(id), "DELETE");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE LP COMPANY: ").andContents(response.prettyPrint());
        return response;
    }

    public Response callEditLP(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_LP_PARTNER(id), map, "PUT");
        return response;
    }

    public Response callEditLPCompany(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_LP_COMPANY(id), map, "PUT");
        return response;
    }

    public Map<String, Object> setEditLP(Map<String, Object> info) {
        Map<String, Object> logistics_partner = new HashMap<>();
        ;
        logistics_partner.putIfAbsent("logistics_partner", info);

        return logistics_partner;
    }

    public Map<String, Object> setEditLPCompany(Map<String, Object> info) {
        Map<String, Object> logistics_company = new HashMap<>();
        ;
        logistics_company.putIfAbsent("logistics_company", info);

        return logistics_company;
    }
}

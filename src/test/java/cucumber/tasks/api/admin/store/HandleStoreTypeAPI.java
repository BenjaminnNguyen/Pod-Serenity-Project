package cucumber.tasks.api.admin.store;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HandleStoreTypeAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Response callGetStoreType() {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.STORE_TYPE, "GET");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE GET STORE TYPE:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDeleteStoreType(String idStoreType) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.STORE_TYPE(idStoreType), "DELETE");
        System.out.println("RESPONSE DELETE STORE TYPE " + response.prettyPrint());
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE STORE TYPE: ").andContents(response.prettyPrint());
        return response;
    }

    /**
     * Get ID store type after search
     *
     * @param response
     * @return
     */
    public String getIdStoreType(Response response, String storeType) {
        String idStoreType = null;
        JsonPath jsonPath = response.jsonPath();
        List<HashMap> results = jsonPath.get("results");
        for (HashMap item : results) {
            if (item.get("name").toString().equals(storeType)) {
                idStoreType = item.get("id").toString();
            }

        }

        Serenity.setSessionVariable("ID Store Type API").to(idStoreType);
        return idStoreType;
    }
}

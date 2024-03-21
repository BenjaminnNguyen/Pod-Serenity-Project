package cucumber.tasks.api.admin.regions;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDistributionCenterAPI {

    CommonRequest commonRequest = new CommonRequest();

    public String getIdDistributionCenter(String name) {
        String idDistribution = null;
        Boolean check = true;
        int page = 1;
        while (check) {
            // map param
            Map<String, Object> map = new HashMap<>();
            map.putIfAbsent("page", page);

            Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.DISTRIBUTION_CENTER, map, "GET");

            JsonPath jsonPath = response.jsonPath();
            List<HashMap> results = jsonPath.get("results");
            for (HashMap item : results) {
                if (item.get("name").toString().equals(name)) {
                    idDistribution = item.get("id").toString();
                    check = false;
                    break;
                }
            }
            // nếu không có tên giống thì tăng page lên 1
            page = page + 1;
            if (page > 3) {
                break;
            }
        }
        return idDistribution;
    }

    public Response callDeleteDistributionCenter(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.DISTRIBUTION_CENTER(id), "DELETE");
        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE DISTRIBUTION CENTER:  ").andContents(response.prettyPrint());
        return response;
    }
}

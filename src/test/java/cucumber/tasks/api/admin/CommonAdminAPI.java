package cucumber.tasks.api.admin;

import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CommonAdminAPI {

    CommonRequest commonRequest = new CommonRequest();

    public Map<String, Object> setInfoEditVisibilities(List<String> dt) {
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> admin_filter_visibility = new HashMap<>();
        admin_filter_visibility.putIfAbsent("content", dt);
        map.putIfAbsent("admin_filter_visibility", admin_filter_visibility);
        return map;
    }

    public Response callAdminFilterVisibilities(String id, Map<String, Object> map) {
        Response response = commonRequest.commonRequestWithBody(UrlAdminAPI.ADMIN_FILTER_VISIBILITIES(id), map, "PUT");
        return response;
    }

    public Response callDeleteAdminFilterPreset(String id) {
        Response response = commonRequest.commonRequestNoBody(UrlAdminAPI.ADMIN_DELETE_FILTER_PRESET(id), "DELETE");
        return response;
    }

    public Response callGetAdminFilterPreset(String id) {
        Map<String, Object> map = new HashMap<>();
        map.put("q[screen_id]", id);
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.ADMIN_FILTER_PRESET(id), map, "GET");
        return response;
    }
    public List<String> callGetIdAdminFilter(Response response) {
        List<String> ids = new ArrayList<>();
        JsonPath jsonPath = response.jsonPath();
        Map<String, Object> map = new HashMap<>();
        List<Map<String, Object>> listResult = jsonPath.get("results");
        for (Map<String, Object> result : listResult) {
            ids.add(result.get("id").toString());
        }
        Serenity.setSessionVariable("Ids preset api").to(ids);
        return ids;
    }

}

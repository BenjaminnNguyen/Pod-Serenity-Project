package cucumber.tasks.api.admin;

import cucumber.models.api.CreateAnnouncements;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.CommonRequest;
import io.cucumber.datatable.DataTable;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class AnnouncementsAPI {

    public Response callCreateAnnouncements(Map<String, Object> createAnnouncements, String basePath) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequest(createAnnouncements, basePath, "POST");
//        System.out.println("RESPONSE CREATE ANNOUNCEMENTS " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE CREATE ANNOUNCEMENTS:  ").andContents(response.prettyPrint());
        return response;
    }

    public Response callDeleteAnnouncements(String basePath) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestNoBody(basePath, "DELETE");
//        System.out.println("RESPONSE DELETE ANNOUNCEMENTS " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE DELETE ANNOUNCEMENTS:  ").andContents(response.prettyPrint());
        return response;
    }

    public void getIDAnnouncement(Response response) {
        JsonPath jsonPath = response.jsonPath();
        String id = jsonPath.get("id").toString();
        System.out.println("ID Announcements " + id);
        Serenity.setSessionVariable("ID Announcement Created").to(id);
    }

    public void getListIDAnnouncement(Response response) {
        JsonPath jsonPath = response.jsonPath();
        List<Map<String, Object>> result = jsonPath.get("results");
        List<String> ids = new ArrayList<>();
        for (Map<String, Object> map : result) {
            String id = map.get("id").toString();
            ids.add(id);
        }
        Serenity.setSessionVariable("List ID Announcement api").to(ids);
    }

    public Response callSearchAnnouncements(Map<String, Object> map) {
        CommonRequest commonRequest = new CommonRequest();
        Response response = commonRequest.commonRequestWithParam(UrlAdminAPI.CREATE_ANNOUNCEMENTS, map, "GET");
//        System.out.println("RESPONSE SEARCH ANNOUNCEMENTS " + response.prettyPrint());
//        Serenity.recordReportData().asEvidence().withTitle("RESPONSE SEARCH ANNOUNCEMENTS:  ").andContents(response.prettyPrint());
        return response;
    }
}

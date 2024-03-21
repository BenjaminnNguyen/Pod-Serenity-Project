package steps.api.admin.announcements;

import cucumber.tasks.api.admin.CommonAdminAPI;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.*;
import cucumber.models.api.CreateAnnouncements;
import cucumber.singleton.UrlAdminAPI;
import cucumber.tasks.api.admin.AnnouncementsAPI;
import cucumber.tasks.api.CommonHandle;
import io.restassured.response.Response;
import net.serenitybdd.core.Serenity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AnnouncementsAPIStepDefinitions {

    AnnouncementsAPI announcementsAPI = new AnnouncementsAPI();

    @Given("Admin create announcements by api")
    public void create_announcement_by_api(CreateAnnouncements createAnnouncements) {
        List<Integer> regions = Serenity.sessionVariableCalled("List region of announcement api");
        // lấy ngày hiện tại hoặc ngày tùy ý từ feature
        String startDate = CommonHandle.setDate(createAnnouncements.getStart_delivering_date(), "yyyy-MM-dd");
        String stopDate = CommonHandle.setDate(createAnnouncements.getStop_delivering_date(), "yyyy-MM-dd");
        // set ngày vào model
        createAnnouncements.setStart_delivering_date(startDate);
        createAnnouncements.setStop_delivering_date(stopDate);
        createAnnouncements.setRegion_ids(regions);
        Map<String, Object> map = new HashMap<>();
        map.put("announcement", createAnnouncements);
        Response response = announcementsAPI.callCreateAnnouncements(map, UrlAdminAPI.CREATE_ANNOUNCEMENTS);
        announcementsAPI.getIDAnnouncement(response);
    }

    @And("Admin set region of announcements api")
    public void setRegionAnnouncement(List<Integer> regions) {
        Serenity.setSessionVariable("List region of announcement api").to(regions);
    }

    @And("Admin clear region of announcements api")
    public void clearRegionAnnouncement() {
        Serenity.clearSessionVariable("List region of announcement api");
    }

    @And("Admin delete announcements {string} by api")
    public void login_to_app_by_API(String announcements) {
        String idAnnouncement = Serenity.sessionVariableCalled("ID Announcement Created");
        System.out.println("id announcements " + idAnnouncement);
        announcementsAPI.callDeleteAnnouncements(UrlAdminAPI.DELETE_ANNOUNCEMENTS(idAnnouncement));
    }


    @And("Admin delete announcements by api")
    public void deleteAnnouncements() {
        List<String> ids = Serenity.sessionVariableCalled("List ID Announcement api");
        for (String id : ids)
            announcementsAPI.callDeleteAnnouncements(UrlAdminAPI.DELETE_ANNOUNCEMENTS(id));
    }


    @And("Admin search announcements api")
    public void searchAnnouncement(DataTable dt) {
        List<Map<String, Object>> infoObj = CommonHandle.convertDataTable(dt);
        String date = CommonHandle.setDate2(infoObj.get(0).get("q[start_delivering_date]").toString(), "yyyy-MM-dd");
        infoObj.get(0).putIfAbsent("q[start_delivering_date]", date);
        Response response = announcementsAPI.callSearchAnnouncements(infoObj.get(0));
        announcementsAPI.getListIDAnnouncement(response);
    }

    /**
     * API Admin Filter Visibilities
     */

    @And("Admin filter visibility with id {string} by api")
    public void admin_filter_visibility_api(String id, List<String> dt) {
        CommonAdminAPI commonAdminAPI = new CommonAdminAPI();
        Map<String, Object> body = commonAdminAPI.setInfoEditVisibilities(dt);
        Response response = commonAdminAPI.callAdminFilterVisibilities(id, body);
    }

    @And("Admin delete filter preset of screen id {string} by api")
    public void admin_delete_filter_visibility_api(String id) {
        CommonAdminAPI commonAdminAPI = new CommonAdminAPI();
        Response response = commonAdminAPI.callGetAdminFilterPreset(id);
        List<String> ids = commonAdminAPI.callGetIdAdminFilter(response);
        for (String i : ids) {
            commonAdminAPI.callDeleteAdminFilterPreset(i);
        }
    }
}

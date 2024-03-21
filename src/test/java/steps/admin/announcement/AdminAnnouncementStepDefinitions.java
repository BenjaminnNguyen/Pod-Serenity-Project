package steps.admin.announcement;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.announcement.AnnouncementTask;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.announcement.AnnouncementPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Hit;
import net.serenitybdd.screenplay.ensure.Ensure;
import org.openqa.selenium.Keys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminAnnouncementStepDefinitions {

    @And("Admin search announcement")
    public void admin_search_announcement(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                AnnouncementTask.search(info.get(0))
        );
    }

    @And("Admin go to create announcement")
    public void admin_go_to_create() {
        theActorInTheSpotlight().attemptsTo(
                AnnouncementTask.goToCreate()
        );
    }

    @And("Admin create announcement with info")
    public void admin_create_announcement(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                AnnouncementTask.createInfo(info)
        );
    }

    @And("Admin create announcement with region")
    public void admin_create_announcement_region(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        for (Map<String, String> map : info) {
            theActorInTheSpotlight().attemptsTo(
                    AnnouncementTask.announceToRegion(map)
            );
        }
        theActorInTheSpotlight().attemptsTo(
                Hit.the(Keys.ESCAPE).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Regions"))
        );
    }

    @And("Admin confirm create announcement")
    public void admin_create_announcement_confirm() {
        theActorInTheSpotlight().attemptsTo(
                AnnouncementTask.confirmCreate());
    }


    @And("Admin check announcement list")
    public void admin_check_announcement_list(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        for (int i = 0; i < info.size(); i++) {
            HashMap<String, String> hashMap = CommonTask.setValue(info.get(i), "id", info.get(i).get("id"), Serenity.sessionVariableCalled("ID Announcement Created"), "create by api");
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(AnnouncementPage.D_RESULT("title el-table__cell", i + 1)),
                    Ensure.that(AnnouncementPage.D_RESULT("id el-table__cell", i + 1)).text().contains(hashMap.get("id")),
                    Ensure.that(AnnouncementPage.D_RESULT("title el-table__cell", i + 1)).text().contains(hashMap.get("title")),
                    Ensure.that(AnnouncementPage.D_RESULT("accounce-to ", i + 1)).text().contains(hashMap.get("announceTo")),
                    Ensure.that(AnnouncementPage.D_RESULT("start-delivering-date", i + 1)).text().contains(CommonHandle.setDate2(hashMap.get("startDate"), "MM/dd/yy")),
                    Ensure.that(AnnouncementPage.D_RESULT("stop-delivering-date", i + 1)).text().contains(CommonHandle.setDate2(hashMap.get("stopDate"), "MM/dd/yy"))
            );
        }
    }
//
//    @And("Admin refresh LP company list")
//    public void admin_refresh_LP_company() {
//        theActorInTheSpotlight().attemptsTo(
//                CommonWaitUntil.isVisible(LPCompaniesPage.REFRESH_PAGE_BUTTON),
//                Click.on(LPCompaniesPage.REFRESH_PAGE_BUTTON),
//                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
//        );
//    }
//
//    @And("Admin {string} delete LP company {string}")
//    public void admin_delete_LP_company(String action, String lp) {
//        theActorInTheSpotlight().attemptsTo(
//                CommonWaitUntil.isVisible(LPCompaniesPage.DELETE_LP_COMPANY(lp)),
//                Click.on(LPCompaniesPage.DELETE_LP_COMPANY(lp)),
//                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("Deleting this LP company will also delete all its lps. Are you sure you want to continue?")),
//                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action)),
////                WindowTask.threadSleep(2000),
//                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
//        );
//    }
//
//    @And("Admin check LP company {string} not show on list")
//    public void admin_check_LP_company(String lp) {
//        theActorInTheSpotlight().attemptsTo(
//                CommonWaitUntil.isNotVisible(LPCompaniesPage.DELETE_LP_COMPANY(lp))
//        );
//    }
//

//
//    @And("Admin check create LP company {string} success and {string}")
//    public void admin_check_LP_company_success(String lp, String action) {
//        theActorInTheSpotlight().attemptsTo(
//                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("Success")),
//                Ensure.that(CommonAdminForm.DIALOG_MESSAGE_TEXT).text().contains("LP company " + lp + " has been created successfully. Please select an option bellow to continue?"),
//                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Back to LP companies list")).isDisplayed(),
//                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Create logistics partner for this LP company")).isDisplayed(),
//                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action)),
//                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
//
//        );
//    }
//
//    @And("Admin go to detail of LP company and check information")
//    public void admin_go_detail_LP_company(DataTable table) {
//        List<Map<String, String>> info = table.asMaps(String.class, String.class);
//        theActorInTheSpotlight().attemptsTo(
//                Check.whether(CommonQuestions.isControlDisplay(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Business name"))).otherwise(
//                        CommonWaitUntil.isVisible(LPCompaniesPage.DETAIL_LP_COMPANY(info.get(0).get("businessName"))),
//                        Click.on(LPCompaniesPage.DETAIL_LP_COMPANY(info.get(0).get("businessName"))),
//                        CommonWaitUntil.isVisible(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Business name"))
//                ),
//                WindowTask.threadSleep(1000),
//                Ensure.that(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Business name")).text().contains(info.get(0).get("businessName")),
//                Ensure.that(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Contact number")).text().contains(info.get(0).get("contactNumber")),
//                Ensure.that(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Roles")).text().contains(info.get(0).get("roles"))
//        );
//    }
}

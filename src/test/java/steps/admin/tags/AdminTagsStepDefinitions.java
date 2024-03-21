package steps.admin.tags;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.announcement.AnnouncementTask;
import cucumber.tasks.admin.tags.HandleAdminTags;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.NavigateToSideBar;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.SideBar;
import cucumber.user_interface.admin.announcement.AnnouncementPage;
import cucumber.user_interface.admin.inventory.AllInventoryPage;
import cucumber.user_interface.admin.tags.AdminTagsPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminTagsStepDefinitions {

    @And("{word} navigate to Tags in sidebar")
    public void navigateTo(String actor, String parentName, String childName) {
        theActorCalled(actor).attemptsTo(
                HandleAdminTags.navigate()
        );
    }

    @And("Admin go to create tags")
    public void admin_go_to_create() {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminTags.goToCreate()
        );
    }

    @And("Admin create tag with info")
    public void admin_create_Tag(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminTags.createInfo(info)
        );
    }

    @And("Admin search tags")
    public void admin_search_tags(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleAdminTags.search(info.get(0))
        );
    }

    @And("Admin create tag with support target")
    public void admin_create_tags_target(List<String> targets) {
        for (String target : targets)
            theActorInTheSpotlight().attemptsTo(
                    HandleAdminTags.supportTarget(target)
            );
    }

    @And("Admin check tags list")
    public void admin_check_tags_list(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        for (int i = 0; i < info.size(); i++) {
            HashMap<String, String> hashMap = CommonTask.setValue(info.get(i), "id", info.get(i).get("id"), Serenity.sessionVariableCalled("ID Tag API"), "create by api");
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonAdminForm.D_RESULT("name el-table__cell", i + 1)),
                    Ensure.that(CommonAdminForm.D_RESULT("id el-table__cell", i + 1)).text().contains(hashMap.get("id")),
                    Ensure.that(CommonAdminForm.D_RESULT("name el-table__cell", i + 1)).text().contains(hashMap.get("name")),
                    Ensure.that(AnnouncementPage.D_RESULT("visibility ", i + 1)).text().contains(hashMap.get("visibility")),
                    Ensure.that(AnnouncementPage.D_RESULT("description", i + 1)).text().contains(hashMap.get("description"))
            );
        }
    }

    @And("Admin refresh tags list")
    public void admin_refresh_list() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AllInventoryPage.REFRESH_BUTTON),
                Click.on(AllInventoryPage.REFRESH_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin delete tag with name {string}")
    public void admin_delete_tag(String name) {
        theActorInTheSpotlight().attemptsTo(
                HandleAdminTags.deleteTag(name)
        );
    }

    @And("Admin open detail of tag and check info")
    public void admin_delete_tag(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        String[] target = info.get(0).get("target").split(",");
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminTagsPage.TAG_DETAIL(info.get(0).get("name"))),
                Click.on(AdminTagsPage.TAG_DETAIL(info.get(0).get("name"))),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Name")),
                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Name")).value().contains(info.get(0).get("name")),
                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Description")).value().contains(info.get(0).get("description")),
                Ensure.that(AdminTagsPage.TAG_VISIBILITY(info.get(0).get("visibility"))).isDisplayed(),
                HandleAdminTags.checkTarget(target)
        );
    }

    @And("Admin assign tag {string}")
    public void admin_assign_tag(String tagName, DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminTags.assignTag(tagName, info)
        );
    }

    @And("Admin check assign tag of target {string}")
    public void admin_check_assign_tag(String tabName, DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminTags.assignTab(tabName)
        );
        for (int i = 0; i < info.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(AdminTagsPage.TAG_TARGET_SECTION_NAME(i + 1)).text().contains(info.get(i).get("name")),
                    Ensure.that(AdminTagsPage.TAG_TARGET_SECTION_EXPIRY(i + 1)).value().contains(CommonHandle.setDate2(info.get(i).get("expiryDate"), "MM/dd/yy"))
            );
        }
    }
}

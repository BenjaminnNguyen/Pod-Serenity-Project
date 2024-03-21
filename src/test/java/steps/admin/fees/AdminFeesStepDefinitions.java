package steps.admin.fees;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.fees.HandleAdminFees;
import cucumber.tasks.admin.tags.HandleAdminTags;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
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

public class AdminFeesStepDefinitions {
    @And("Admin create state fees with info")
    public void admin_create_Fee(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminFees.createInfo(info)
        );
    }

    @And("Admin check fees list")
    public void admin_check_fees_list(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        for (int i = 0; i < info.size(); i++) {
            HashMap<String, String> hashMap = CommonTask.setValue(info.get(i), "id", info.get(i).get("id"), Serenity.sessionVariableCalled("ID Fee api"), "create by api");
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(CommonAdminForm.D_RESULT("name el-table__cell", i + 1)),
                    Ensure.that(CommonAdminForm.D_RESULT("id el-table__cell", i + 1)).text().contains(hashMap.get("id")),
                    Ensure.that(CommonAdminForm.D_RESULT("name el-table__cell", i + 1)).text().contains(hashMap.get("name")),
                    Ensure.that(CommonAdminForm.D_RESULT("description", i + 1)).text().contains(hashMap.get("description"))
            );
        }
    }

    @And("Admin open detail state fee")
    public void admin_search_tags(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminFees.edit(info.get(0).get("name")),
                HandleAdminFees.checkDetail(info.get(0))
        );
    }
}

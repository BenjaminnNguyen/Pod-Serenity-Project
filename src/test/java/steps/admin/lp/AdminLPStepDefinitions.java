package steps.admin.lp;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.lp.HandleLP;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.LP.LPCompaniesPage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminLPStepDefinitions {

    @And("Admin search LP")
    public void admin_search_LP_company(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleLP.search(info.get(0))
        );
    }

    @And("Admin check LP list")
    public void admin_check_LP(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        for (int i = 0; i < info.size(); i++) {
            HashMap<String, String> hashMap = CommonTask.setValue(info.get(i), "id", info.get(i).get("id"), Serenity.sessionVariableCalled("LP id api" + info.get(i).get("email")), "create by api");
            theActorInTheSpotlight().attemptsTo(
                    CommonWaitUntil.isVisible(LPCompaniesPage.D_RESULT("name", i + 1)),
                    Ensure.that(LPCompaniesPage.D_RESULT("id el-table__cell", i + 1)).text().contains(hashMap.get("id")),
                    Ensure.that(LPCompaniesPage.D_RESULT("name", i + 1)).text().contains(hashMap.get("name")),
                    Ensure.that(LPCompaniesPage.D_RESULT("lp-company", i + 1)).text().contains(hashMap.get("lpCompany")),
                    Ensure.that(LPCompaniesPage.D_RESULT("email", i + 1)).text().contains(hashMap.get("email")),
                    Ensure.that(LPCompaniesPage.D_RESULT("contact", i + 1)).text().contains(hashMap.get("contactNumber")),
                    Ensure.that(LPCompaniesPage.D_RESULT("active-state", i + 1)).text().contains(hashMap.get("status"))
            );
        }
    }

    @And("Admin refresh LP list")
    public void admin_refresh_LP_company() {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPCompaniesPage.REFRESH_PAGE_BUTTON),
                Click.on(LPCompaniesPage.REFRESH_PAGE_BUTTON),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin {string} delete LP {string}")
    public void admin_delete_LP_company(String action, String lp) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(LPCompaniesPage.DELETE_LP_COMPANY(lp)),
                Click.on(LPCompaniesPage.DELETE_LP_COMPANY(lp)),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("Deleting this logistics partner will also delete all its distribution centers. Are you sure you want to continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action)),
                WindowTask.threadSleep(2000),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER)
        );
    }

    @And("Admin create new logistics partner")
    public void admin_create_LP(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleLP.createLP(info)
        );
    }

    @And("Admin go to detail of LP {string}")
    public void admin_go_detail_LP(String lp) {
        theActorInTheSpotlight().attemptsTo(
              HandleLP.goToDetail(lp)
        );
    }

    @And("Admin check information of LP")
    public void admin_check_detail_LP(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(500),
                CommonWaitUntil.isVisible(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Email")),
                Ensure.that(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Email")).text().contains(info.get(0).get("email")),
                Ensure.that(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("LP company")).text().contains(info.get(0).get("lpCompany")),
                Ensure.that(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Contact number")).text().contains(info.get(0).get("contactNumber")),
                Ensure.that(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("First name")).text().contains(info.get(0).get("firstName")),
                Ensure.that(LPCompaniesPage.DETAIL_LP_COMPANY_INFO("Last name")).text().contains(info.get(0).get("lastName"))
        );
    }

    @And("Admin edit general information of lp")
    public void admin_edit_general_information_of_buyer(DataTable table) {
        List<Map<String, String>> infos = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleLP.editGeneralInfo(infos.get(0))
        );
    }
}

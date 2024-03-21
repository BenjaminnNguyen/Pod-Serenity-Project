package steps.admin.fees;

import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.brands.HandleBrand;
import cucumber.tasks.admin.fees.HandleAdminFees;
import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.fee.AdminMiscellaneousFeePage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminMiscellaneousFeesStepDefinitions {
    @And("Admin create Miscellaneous fees with info")
    public void admin_create_Fee(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                HandleAdminFees.createMiscellaneousFeesInfo(info)
        );
    }

    @And("Admin search Miscellaneous fees")
    public void admin_search_Miscellaneous_Fee(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.showFilter(),
                CommonTaskAdmin.resetFilter(),
                HandleAdminFees.searchMiscellaneous(info.get(0))
        );
    }

    @And("Admin check Miscellaneous fees list")
    public void admin_check_fees_list(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        for (int i = 0; i < info.size(); i++) {
            theActorInTheSpotlight().attemptsTo(
                    Ensure.that(CommonAdminForm.D_RESULT("created-at", i + 1)).text().contains(CommonHandle.setDate2(info.get(i).get("date"), "MM/dd/yy")),
                    Ensure.that(CommonAdminForm.D_RESULT("service-time", i + 1)).text().contains(CommonHandle.setDate2(info.get(i).get("serviceTime"), "MM/yyyy")),
                    Ensure.that(CommonAdminForm.D_RESULT("vendor-company-name", i + 1)).text().contains(info.get(i).get("vendorCompany")),
                    Ensure.that(CommonAdminForm.D_RESULT("fee-type", i + 1)).text().contains(info.get(i).get("feeType")),
                    Ensure.that(CommonAdminForm.D_RESULT(" type", i + 1)).text().contains(info.get(i).get("type")),
                    Ensure.that(CommonAdminForm.D_RESULT("region ", i + 1)).text().contains(info.get(i).get("region")),
                    Ensure.that(CommonAdminForm.D_RESULT("admin-name", i + 1)).text().contains(info.get(i).get("admin"))
            );
        }
    }

    @And("Admin {string} delete first record Miscellaneous fee")
    public void admin_search_tags(String action) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminMiscellaneousFeePage.DELETE),
                Click.on(AdminMiscellaneousFeePage.DELETE),
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG("This will permanently delete this record. Continue?")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON(action))
        );
    }
}

package steps.admin.fees;

import cucumber.tasks.admin.fees.HandleAdminFees;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.announcement.AnnouncementPage;
import cucumber.user_interface.admin.fee.AdminSmallOrderSurchargePage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.And;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.Enter;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminSmallOrderSurchargeStepDefinitions {

    @And("Admin check Small order surcharge list")
    public void admin_check_sos_list(DataTable dt) {
        List<Map<String, String>> info = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.D_RESULT("  el-table__cell", 1)),
                Ensure.that(CommonAdminForm.D_RESULT("  el-table__cell", 1)).text().contains(info.get(0).get("charge")),
                Ensure.that(CommonAdminForm.D_RESULT("  el-table__cell", 2)).text().contains(info.get(0).get("forOrder"))
        );

    }

    @And("Admin open detail Small order surcharge")
    public void admin_sos_detail(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(AdminSmallOrderSurchargePage.SMALL_ORDER_SURCHARGE_DETAIL),
                Click.on(AdminSmallOrderSurchargePage.SMALL_ORDER_SURCHARGE_DETAIL),
                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Charge")).value().isEqualTo(info.get(0).get("charge")),
                Ensure.that(CommonAdminForm.DYNAMIC_DIALOG_INPUT("For order less than")).value().isEqualTo(info.get(0).get("forOrder"))
        );
    }
    @And("Admin edit Small order surcharge")
    public void admin_edit_sos(DataTable table) {
        List<Map<String, String>> info = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Charge")),
                Enter.theValue(info.get(0).get("charge")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("Charge")),
                Enter.theValue(info.get(0).get("forOrder")).into(CommonAdminForm.DYNAMIC_DIALOG_INPUT("For order less than")),
                Click.on(CommonAdminForm.DYNAMIC_DIALOG_BUTTON("Update"))
        );
    }
}

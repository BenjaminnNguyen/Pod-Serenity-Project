package steps.admin.request;

import io.cucumber.java.en.*;
import cucumber.tasks.admin.CommonTaskAdmin;
import cucumber.tasks.admin.request.ChangeRequest;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.user_interface.admin.CommonAdminForm;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.screenplay.actions.Click;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class ChangeRequestStepDefinitions {

    @And("Search the request by info then system show result")
    public void search_the_brand_by_full_name_field(DataTable infos) {
        List<Map<String, String>> list = infos.asMaps(String.class, String.class);

        theActorInTheSpotlight().attemptsTo(
                CommonTaskAdmin.resetFilter(),
                ChangeRequest.check(list.get(0)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER),
                CommonWaitUntil.isEnabled(CommonAdminForm.EDIT_BUTTON),
                Click.on(CommonAdminForm.EDIT_BUTTON)
        );
    }
}

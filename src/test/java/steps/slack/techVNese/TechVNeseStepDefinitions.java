package steps.slack.techVNese;

import cucumber.tasks.api.CommonHandle;
import cucumber.tasks.common.CommonTask;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.slack.login.LoginSlack;
import cucumber.tasks.slack.techVNese.HandleTechVNese;
import cucumber.user_interface.beta.Vendor.inventory.VendorWithdrawalRequestPage;
import cucumber.user_interface.slack.techVNese.TechVNesePage;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;
import static org.hamcrest.Matchers.containsString;

public class TechVNeseStepDefinitions {

    @Given("Slack search value {string}")
    public void slack_search_value(String value) {
        if(value.equals("")) {
            value = Serenity.sessionVariableCalled("Inventory_Reference");
        }
        theActorInTheSpotlight().attemptsTo(
                HandleTechVNese.search(value)
        );
    }

    @Given("Slack verify info of inbound inventory")
    public void verify_info_of_inbound_inventory(DataTable dt) {
        List<Map<String, String>> expected = dt.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(TechVNesePage.TITLE_MESSAGE),
                Ensure.that(TechVNesePage.BODY_MESSAGE).text().contains(expected.get(0).get("reference").equals("") ? Serenity.sessionVariableCalled("Inventory_Reference") : expected.get(0).get("reference")),
                Ensure.that(TechVNesePage.BODY_MESSAGE).text().contains(expected.get(0).get("brand")),
                Ensure.that(TechVNesePage.BODY_MESSAGE).text().contains(expected.get(0).get("region")),
                Ensure.that(TechVNesePage.BODY_MESSAGE).text().contains(CommonHandle.setDate2(expected.get(0).get("receivedate"),"yyyy-MM-dd"))
        );
    }
}

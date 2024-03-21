package steps.admin.orders;

import io.cucumber.java.en.*;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.admin.orders.CreateNewOrderPage;
import io.cucumber.datatable.DataTable;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.ensure.Ensure;

import java.util.List;
import java.util.Map;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class AdminCreateNewOrderStepDefinition {

    @And("Admin verify error message when leave field blank in create new order")
    public void admin_verify_error_message_when_leave_field_blank_in_create_new_order() {
        theActorInTheSpotlight().attemptsTo(
                Click.on(CommonAdminForm.DYNAMIC_BUTTON("Create")),
                Ensure.that(CreateNewOrderPage.D_ERROR_MESSAGE("Buyer")).text().contains("Please select a specific buyer for the new order"),
                Ensure.that(CreateNewOrderPage.D_ERROR_MESSAGE("Street address")).text().contains("Please input shipping street address"),
                Ensure.that(CreateNewOrderPage.D_ERROR_MESSAGE("City")).text().contains("Please input shipping city"),
                Ensure.that(CreateNewOrderPage.D_ERROR_MESSAGE("State (Province/Territory)")).text().contains("Please select shipping state"),
                Ensure.that(CreateNewOrderPage.D_ERROR_MESSAGE("Zip")).text().contains("Please input shipping postal zip code"),
                Ensure.that(CreateNewOrderPage.LINE_ITEM_ERROR_MESSAGE).isDisplayed(),
                //button add line item is disable
                Ensure.that(CreateNewOrderPage.ADD_LINE_BUTTON_DISABLE).isDisplayed()
        );
    }

    @And("Admin verify summary in create new order")
    public void admin_verify_summary_in_create_new_order(DataTable table) {
        List<Map<String, String>> expected = table.asMaps(String.class, String.class);
        theActorInTheSpotlight().attemptsTo(
                Ensure.that(CreateNewOrderPage.SOS_ALERT_SUMMARY).text().contains(expected.get(0).get("sos")),
                Check.whether(expected.get(0).get("ls").equals(""))
                        .otherwise(Ensure.that(CreateNewOrderPage.LS_ALERT_SUMMARY).text().contains(expected.get(0).get("ls")))
        );
    }
}

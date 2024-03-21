package steps.buyer;

import cucumber.tasks.admin.orders.HandleOrders;
import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin.CommonAdminForm;
import cucumber.user_interface.beta.Buyer.promotion.PromotionsPage;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.conditions.Check;

import java.util.List;

import static net.serenitybdd.screenplay.GivenWhenThen.seeThat;
import static net.serenitybdd.screenplay.actors.OnStage.theActorCalled;
import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class CommonStepDefinitions {

    @And("Go to tab {string}")
    public void go_to_tab(String title) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(PromotionsPage.PROMOTIONS(title)),
                Click.on(PromotionsPage.PROMOTIONS(title))
        );
    }

    @And("Refesh browser")
    public void refesh_browser() {
        theActorInTheSpotlight().attemptsTo(
                WindowTask.refeshBrowser()
        );
    }

    @And("{word} refresh browser")
    public void actor_refesh_browser(String actor) {
        theActorCalled(actor).attemptsTo(
                WindowTask.refeshBrowser(),
                Check.whether(actor.contains("ADMIN"))
                        .andIfSo(
                                CommonWaitUntil.isNotVisible(CommonAdminForm.LOADING_SPINNER))
        );
    }

    @And("{word} wait {int} mini seconds")
    public void admin_wait_seconds(String actor, int second) {
        theActorInTheSpotlight().attemptsTo(
                WindowTask.threadSleep(second)
        );
    }
    @And("Admin verify content of alert")
    public void verifyAlert(String message) {
        theActorInTheSpotlight().attemptsTo(
                CommonWaitUntil.isVisible(CommonAdminForm.DYNAMIC_ALERT(message)),
                CommonWaitUntil.isNotVisible(CommonAdminForm.DYNAMIC_ALERT(message))
        );
    }

    @And("Admin verify content of dialog")
    public void verifyDialog(List<String> message) {
        for (String s : message)
            theActorInTheSpotlight().should(
                    seeThat(CommonQuestions.isControlDisplay(CommonAdminForm.DYNAMIC_DIALOG(s)))
            );
    }
}

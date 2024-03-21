package steps.adminOld;

import io.cucumber.java.en.*;
import cucumber.questions.CommonQuestions;
import cucumber.tasks.adminOld.HandleSideKiq;
import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin_old.login.sidekiq.ScheduledPage;
import net.serenitybdd.core.Serenity;
import net.serenitybdd.core.pages.WebElementFacade;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.JavaScriptClick;
import net.serenitybdd.screenplay.actions.Scroll;
import net.serenitybdd.screenplay.conditions.Check;
import net.serenitybdd.screenplay.questions.Text;

import java.awt.*;
import java.util.ArrayList;
import java.util.List;

import static net.serenitybdd.screenplay.actors.OnStage.theActorInTheSpotlight;

public class SidekiqJobStepDefinitions {

    @Given("Admin run job StripeChargeSubInvoiceJob in sidekiq")
    public void admin_run_job_in_sidekiq() {
        theActorInTheSpotlight().attemptsTo(
                HandleSideKiq.goToSidekiq(),
                HandleSideKiq.goToScheduled()

        );
        theActorInTheSpotlight().attemptsTo(
                Check.whether(CommonQuestions.isControlDisplay(ScheduledPage.GO_TO_LAST_TAB)).andIfSo(
                        Click.on(ScheduledPage.GO_TO_LAST_TAB),
                        CommonWaitUntil.isVisible(ScheduledPage.GO_TO_LAST_TAB_DISABLE)
                )
        );
        // ID của order
        String id = Serenity.sessionVariableCalled("ID Sub-invoice Job");
        //lấy số của tab cuối cùng
        if (ScheduledPage.TAB_NEXT_TO_LAST.resolveAllFor(theActorInTheSpotlight()).size() == 0) {
            List<WebElementFacade> listArgumentsE = ScheduledPage.LIST_ARGUMENTS.resolveAllFor(theActorInTheSpotlight());
            System.out.println("List " + listArgumentsE.size());
            for (WebElementFacade argumentE : listArgumentsE) {
                System.out.println("id = " + id);
                if (argumentE.getText().contains(id)) {
                    System.out.println("Test " + argumentE.getText());
                    theActorInTheSpotlight().attemptsTo(
                            JavaScriptClick.on(ScheduledPage.CHECKBOX_BY_ID(id)),
                            WindowTask.threadSleep(10000),
                            Scroll.to(ScheduledPage.BUTTON_ADD_TO_QUEUE),
                            Click.on(ScheduledPage.BUTTON_ADD_TO_QUEUE)
                    );
                    break;
                }
            }
        } else {
            Integer indexLast = Integer.valueOf(Text.of(ScheduledPage.TAB_NEXT_TO_LAST).answeredBy(theActorInTheSpotlight()));
            List<WebElementFacade> listArgumentsE = ScheduledPage.LIST_ARGUMENTS.resolveAllFor(theActorInTheSpotlight());
            System.out.println("List " + listArgumentsE.size());
            Boolean check = true;
            while (check) {
                listArgumentsE = ScheduledPage.LIST_ARGUMENTS.resolveAllFor(theActorInTheSpotlight());
                for (WebElementFacade argumentE : listArgumentsE) {
                    System.out.println("id = " + id);
                    if (argumentE.getText().contains(id)) {
                        System.out.println("Test " + argumentE.getText());
                        theActorInTheSpotlight().attemptsTo(
                                JavaScriptClick.on(ScheduledPage.CHECKBOX_BY_ID(id)),
                                WindowTask.threadSleep(5000),
                                Scroll.to(ScheduledPage.BUTTON_ADD_TO_QUEUE),
                                Click.on(ScheduledPage.BUTTON_ADD_TO_QUEUE),
                                WindowTask.threadSleep(5000)
                        );
                        check = false;
                        break;
                    }
                }
                indexLast = indexLast - 1;
                theActorInTheSpotlight().attemptsTo(
                        Check.whether(check)
                                .andIfSo(Click.on(ScheduledPage.TAB_BY_INDEX(indexLast)),
                                        CommonWaitUntil.isVisible(ScheduledPage.TAB_BY_INDEX_DISABLE(indexLast))
                                )
                );
            }
        }

    }

    @And("Admin run cron job {string}")
    public void runCronJob(String job) {
        theActorInTheSpotlight().attemptsTo(
//                HandleSideKiq.goToSidekiq(),
                HandleSideKiq.goToCron(),
                HandleSideKiq.enqueueCronJob(job)
        );
    }

    @And("Admin go to Sidekiq")
    public void goToSidekiq() {
        theActorInTheSpotlight().attemptsTo(
                HandleSideKiq.goToSidekiq()
        );
    }

    @Given("Admin run job UpdateStorePreferredWarehouseJob with warehouse id {string} in sidekiq")
    public void admin_run_job_warehouse_in_sidekiq(String id) {
        if (id.contains("create by api"))
            id = Serenity.sessionVariableCalled("Distribution Center ID");
        theActorInTheSpotlight().attemptsTo(
                HandleSideKiq.goToSidekiq(),
                HandleSideKiq.goToScheduled(),
                HandleSideKiq.addToQueueJob(id)

        );
    }
}

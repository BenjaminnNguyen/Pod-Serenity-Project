package cucumber.tasks.adminOld;

import cucumber.tasks.common.CommonWaitUntil;
import cucumber.tasks.common.WindowTask;
import cucumber.user_interface.admin_old.login.sidekiq.CronPage;
import cucumber.user_interface.admin_old.login.sidekiq.ScheduledPage;
import cucumber.user_interface.admin_old.login.sidekiq.SideKiqPage;
import net.serenitybdd.screenplay.Task;
import net.serenitybdd.screenplay.actions.Click;
import net.serenitybdd.screenplay.actions.JavaScriptClick;

public class HandleSideKiq {

    public static Task goToSidekiq() {
        return Task.where("Go to sidekiq",
                CommonWaitUntil.isVisible(SideKiqPage.SIDEKIQ_MENU),
                Click.on(SideKiqPage.SIDEKIQ_MENU)
        );
    }

    public static Task goToScheduled() {
        return Task.where("Go to Scheduled",
                CommonWaitUntil.isVisible(ScheduledPage.SCHEDULED_MENU),
                Click.on(ScheduledPage.SCHEDULED_MENU),
                CommonWaitUntil.isVisible(ScheduledPage.SCHEDULED_JOB_HEADER)
        );
    }

    public static Task goToCron() {
        return Task.where("Go to Cron",
                CommonWaitUntil.isVisible(SideKiqPage.CRON),
                Click.on(SideKiqPage.CRON),
                CommonWaitUntil.isVisible(CronPage.CRON_JOB_HEADER)
        );
    }

    public static Task enqueueCronJob(String job) {
        return Task.where("Enqueue Cron Job",
                CommonWaitUntil.isVisible(SideKiqPage.JOB(job)),
                JavaScriptClick.on(SideKiqPage.JOB(job)),
                WindowTask.threadSleep(1000),
                CommonWaitUntil.isVisible(CronPage.CRON_JOB_HEADER)
        );
    }

    public static Task addToQueueJob(String id) {
        return Task.where("Add to queue Job",
                CommonWaitUntil.isVisible(SideKiqPage.UPDATE_STORE_PREFERRED_WAREHOUSE_JOB(id)),
                JavaScriptClick.on(SideKiqPage.UPDATE_STORE_PREFERRED_WAREHOUSE_JOB(id)),
                WindowTask.threadSleep(500),
                CommonWaitUntil.isVisible(SideKiqPage.ADD_TO_QUEUE),
                Click.on(SideKiqPage.ADD_TO_QUEUE),
                WindowTask.threadSleep(3000)
        );
    }

}

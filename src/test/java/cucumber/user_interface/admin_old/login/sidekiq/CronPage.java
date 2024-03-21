package cucumber.user_interface.admin_old.login.sidekiq;

import net.serenitybdd.screenplay.targets.Target;

public class CronPage {

    public static Target CRON_JOB_HEADER = Target.the("Cron in header")
            .locatedBy("//h3[normalize-space()='Cron Jobs']");

}

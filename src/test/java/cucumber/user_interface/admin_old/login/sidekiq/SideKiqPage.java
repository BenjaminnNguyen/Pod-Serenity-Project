package cucumber.user_interface.admin_old.login.sidekiq;

import net.serenitybdd.screenplay.targets.Target;

public class SideKiqPage {

    public static Target SIDEKIQ_MENU = Target.the("Sidekiq in menu")
            .locatedBy("//ul[@class='sidebar-menu']//span[text()='Sidekiq']");

    public static Target CRON = Target.the("Sidekiq in menu")
            .locatedBy("//a[normalize-space()='Cron']");

    public static Target ADD_TO_QUEUE = Target.the("add_to_queue")
            .locatedBy("//input[@name='add_to_queue']");

    public static Target JOB(String job) {
        return Target.the("Job")
                .locatedBy("//b[normalize-space()='" + job + "']/../../../td/following-sibling::td//input[@name='enque']");
    }

    public static Target UPDATE_STORE_PREFERRED_WAREHOUSE_JOB(String id) {
        return Target.the("Job")
                .locatedBy("//div[contains(text(),'\"warehouse_id\"=>" + id + "')]/parent::td/preceding-sibling::td/input");
    }

}

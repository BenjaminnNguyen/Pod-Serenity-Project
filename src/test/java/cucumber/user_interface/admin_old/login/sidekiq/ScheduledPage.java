package cucumber.user_interface.admin_old.login.sidekiq;

import net.serenitybdd.screenplay.targets.Target;

public class ScheduledPage {

    public static Target SCHEDULED_MENU = Target.the("Scheduled in menu")
            .locatedBy("//a[text()='Scheduled']");

    public static Target SCHEDULED_JOB_HEADER = Target.the("Scheduled in header")
            .locatedBy("//h3[text()='Scheduled Jobs']");

    public static Target LIST_ARGUMENTS = Target.the("List arguments")
            .locatedBy("//tbody//td[contains(text(),'StripeChargeSubInvoiceJob')]/following-sibling::td/div");

    public static Target GO_TO_LAST_TAB = Target.the("Go to last tab in scheduled jobs")
            .locatedBy("//a[text()='»']");

    public static Target GO_TO_LAST_TAB_DISABLE = Target.the("Go to last tab in scheduled jobs disable")
            .locatedBy("//a[text()='»']/parent::li[@class='disabled']");

    public static Target TAB_NEXT_TO_LAST = Target.the("Tab button next to go to last button")
            .locatedBy("//a[text()='»']/parent::li[@class='disabled']/preceding-sibling::li[@class='disabled']/a");

    public static Target TAB_BY_INDEX(int index) {
        return Target.the("Tab " + index + "button")
                .locatedBy("//a[text()='" + index + "']");
    }

    public static Target TAB_BY_INDEX_DISABLE(int index) {
        return Target.the("Tab " + index + "button disable")
                .locatedBy("//a[text()='" + index + "']/parent::li[@class='disabled']");
    }

    public static Target CHECKBOX_BY_ID(String id) {
        return Target.the("Checkbox by sub invoice id")
                .locatedBy("//td[contains(text(),'StripeChargeSubInvoiceJob')]/following-sibling::td/div[contains(text(),'" + id + "')]/parent::td/preceding-sibling::td/input");
    }

    public static Target BUTTON_ADD_TO_QUEUE = Target.the("Add to queue button")
            .locatedBy("//input[@value='Add to queue']");

}

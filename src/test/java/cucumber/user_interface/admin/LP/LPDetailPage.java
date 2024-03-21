package cucumber.user_interface.admin.LP;

import net.serenitybdd.screenplay.targets.Target;

public class LPDetailPage {

    public static Target DYNAMIC_DETAIL(String title) {
        return Target.the(title)
                .locatedBy("//dt[text()='" + title + "']/following-sibling::dd//div[contains(@class,'content')]//span");
    }
}

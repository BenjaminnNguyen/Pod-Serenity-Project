package cucumber.user_interface.lp;

import net.serenitybdd.screenplay.targets.Target;

public class LPSettingPage {

    public static Target D_PERSONAL_INFO(String title) {
        return Target.the("Personal " + title)
                .locatedBy("//div[text()='Personal']/following-sibling::div//dt[text()='" + title + "']/following-sibling::dd/span");
    }

    public static Target D_COMPANY_INFO(String title) {
        return Target.the("Company " + title)
                .locatedBy("(//div[text()='Company']/following-sibling::div//dt[text()='" + title + "']/following-sibling::dd/span)[1]");
    }

    public static final Target COMPANY_EDIT_BUTTON = Target.the("Company edit button")
            .locatedBy("//div[text()='Company']//following-sibling::div//button//span[text()='Edit']");

    public static final Target POPUP_EDIT_TITLE = Target.the("Popup title")
            .locatedBy("//div[@role='dialog']//span[contains(@class,'title')]");

}

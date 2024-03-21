package cucumber.user_interface.admin.changeRequest;

import net.serenitybdd.screenplay.targets.Target;

public class AdminChangeRequestPage {

    public static Target DYNAMIC_TABLE(String col) {
        return Target.the("value of column " + col)
                .locatedBy("(//table//*[contains(@class,'" + col + "')])[1]");
    }

    public static Target DYNAMIC_TABLE2(String col) {
        return Target.the("value of column " + col)
                .locatedBy("(//table//td[contains(@class,'" + col + "')]//span)[1]");
    }

    public static Target D_EDIT_BUTTON(String id) {
        return Target.the("Button edit of id" + id)
                .locatedBy("(//div[text()='" + id + "']//parent::td//following-sibling::td[contains(@class,'actions')]//button)[1]");
    }

    public static Target D_DELETE_BUTTON(String id) {
        return Target.the("Button delete of id" + id)
                .locatedBy("(//div[text()='" + id + "']//parent::td//following-sibling::td[contains(@class,'actions')]//button)[2]");
    }

    /**
     * Change request detail
     */

    public static Target EFFECT_DATE_TEXTBOX_DETAIL = Target.the("Effect date in change request detail")
            .locatedBy("//label[text()='Effective date']/following-sibling::div//input");

    public static Target SIZE_L_TEXTBOX_DETAIL = Target.the("Size L in change request detail")
            .locatedBy("(//label[text()='Size (L × W × H)']/following-sibling::div//input)[1]");

    public static Target SIZE_W_TEXTBOX_DETAIL = Target.the("Size W in change request detail")
            .locatedBy("(//label[text()='Size (L × W × H)']/following-sibling::div//input)[2]");

    public static Target SIZE_H_TEXTBOX_DETAIL = Target.the("Size H in change request detail")
            .locatedBy("(//label[text()='Size (L × W × H)']/following-sibling::div//input)[3]");

    public static Target HISTORY_FROM_DETAIL = Target.the("History from in change request detail")
            .locatedBy("//div[@class='history']//span[@class='from']");

    public static Target HISTORY_TO_DETAIL = Target.the("History to in change request detail")
            .locatedBy("//div[@class='history']//span[@class='to']");
}

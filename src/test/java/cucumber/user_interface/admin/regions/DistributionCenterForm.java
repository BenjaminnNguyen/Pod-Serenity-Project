package cucumber.user_interface.admin.regions;

import net.serenitybdd.screenplay.targets.Target;

public class DistributionCenterForm {

    /**
     * Create new Distribution Center
     */

    public static Target CREATE_FORM_LABEL = Target.the("Create new Distribution Center label")
            .locatedBy("(//div[@role='dialog']//span[contains(@class,'title')])[1]");

    public static Target ALERT_FORM_LABEL = Target.the("Create new Distribution Center alert label")
            .locatedBy("(//div[@role='alert']//span[contains(@class,'title')])[1]");

    public static Target D_TEXT(String name) {
        return Target.the("Textbox " + name)
                .locatedBy("//label[text()='" + name + "']/following-sibling::div//input");
    }

    public static Target D_ERROR(String name) {
        return Target.the("Error of " + name)
                .locatedBy("//label[text()='" + name + "']/following-sibling::div//div[contains(@class,'error')]");
    }

    /**
     * Result Distribution Center
     */

    public static Target NAME_RESULT = Target.the("Distribution center name link")
            .locatedBy("//div[contains(@class,'el-table__body')]//child::div[@class='name link']");

    public static Target PAGE_NUM(int index) {
        return Target.the("Page of " + index)
                .locatedBy("(//div[contains(@class,'paginator')]//li[text()='" + index + "'] )[1]");
    }

    public static Target NAME_RESULT(String name) {
        return Target.the("Distribution center name link")
                .locatedBy("//td[not(contains(@class, 'is-hidden'))]//div[contains(text(),'" + name + "')]");
    }

    public static Target TIME_ZONE_RESULT(String name) {
        return Target.the("Distribution center timezone")
                .locatedBy("//div[contains(@class,'el-table__body')]//div[text()='" + name + "']/ancestor::td/following-sibling::td//div[@class='timezone']");
    }

    public static Target DESCRIPTION_RESULT(String name) {
        return Target.the("Distribution center description")
                .locatedBy("//div[contains(@class,'el-table__body')]//div[text()='" + name + "']/ancestor::td/following-sibling::td//div[contains(@class,'description')]");
    }

    public static Target EDIT_RESULT(String name) {
        return Target.the("Distribution center edit button")
                .locatedBy("(//div[contains(@class,'el-table__body')]//div[text()='" + name + "']/ancestor::td/following-sibling::td[contains(@class,'actions')]//button)[1]");
    }

    public static Target DELETE_RESULT(String name) {
        return Target.the("Distribution center delete button")
                .locatedBy("(//div[contains(@class,'el-table__body')]//div[text()='" + name + "']/ancestor::td/following-sibling::td[contains(@class,'actions')]//button)[1]");
    }

    /**
     * Edit Distribution Center popup
     */

    public static Target EDIT_FORM_LABEL(String name) {
        return Target.the("Edit Distribution Center label")
                .locatedBy("//span[@class='title' and contains(text(),'" + name + "')]");
    }

}

package cucumber.user_interface.admin.regions;

import net.serenitybdd.screenplay.targets.Target;

public class AdminRouteForm {

    /**
     * Search route
     */

    public static Target NAME_SEARCH_TEXTBOX = Target.the("Name search textbox")
            .locatedBy("//div[@data-field='q[name]']//input");

    public static Target REGION_SEARCH_TEXTBOX = Target.the("Region search textbox")
            .locatedBy("//div[@data-field='q[region_id]']//input");


    /**
     * Search route - result
     */
    public static Target NAME_RESULT = Target.the("Name result")
            .locatedBy("//span[@class='name']");

    public static Target NAME_RESULT(String name) {
        return Target.the("Name result")
                .locatedBy("//span[@class='name' and text()='" + name + "']");
    }

    public static Target REGION_RESULT = Target.the("Region result")
            .locatedBy("//span[@class='region-name']");

    public static Target WEEKDAYS_RESULT = Target.the("Weekdays result")
            .locatedBy("//span[@class='short-weekdays']");
    /**
     * Create new Route
     */

    public static Target CREATE_FORM_LABEL = Target.the("Create new Route label")
            .locatedBy("(//div[@role='dialog']//span[contains(@class,'title')])[1]");

    public static Target D_TEXT(String name) {
        return Target.the("Textbox " + name)
                .locatedBy("//div[@role='dialog']//label[text()='" + name + "']/following-sibling::div//input");
    }

    public static Target STORE_LABEL = Target.the("Store label")
            .locatedBy("//span[text()='Please select region first']");

    public static Target WITHIN_7_DAY_CHECKBOX = Target.the("Within 7 business days checkbox")
            .locatedBy("//label[text()='Weekdays']/following-sibling::div//span[text()='Within 7 business days']");

    public static Target SELECT_WEEKDAY_TEXTBOX = Target.the("Select weekdays textbox")
            .locatedBy("//label[text()='Weekdays']/following-sibling::div//div[contains(@class,'select weekdays')]//input");


    /**
     * Edit new Route
     */

    public static Target EDIT_LABEL(String name) {
        return Target.the("Select weekdays textbox")
                .locatedBy("//span[@class='name' and text()='" + name + "']");
    }

    public static Target WITHIN_7_DAY_CHECKED = Target.the("Check box within 7 day checked")
            .locatedBy("//label[@class='el-checkbox within_7_business_day is-checked']//span[text()='Within 7 business days']");

    public static Target STORE_CHOOSED = Target.the("Store choose")
            .locatedBy("//label[text()='Stores']/following-sibling::div//div[@class='name']");

    public static Target REMOVE_STORE = Target.the("Remove store")
            .locatedBy("//label[text()='Stores']/following-sibling::div//div[contains(@class,'actions')]");
}

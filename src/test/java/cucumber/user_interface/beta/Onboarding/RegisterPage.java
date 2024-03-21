package cucumber.user_interface.beta.Onboarding;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class RegisterPage {

    public static Target REGISTER_BUTTON = Target.the("'Button Start with uss'")
            .locatedBy("//div[@class='for-desktop']//a[text()='Start with us']");

    public static Target DYNAMIC_TEXTBOX(String title) {
        return Target.the("Textbox " + title)
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static Target DYNAMIC_SELECT(String name) {
        return Target.the("Select " + name)
                .locatedBy("//select[@name='" + name + "']");
    }

    public static Target COMMENT_TEXTAREA = Target.the("Comment textarea")
            .locatedBy("//label[text()='Please provide any additional comments']/following-sibling::div//textarea");

    public static Target HOW_HEAR_SELECT = Target.the("Comment textarea")
            .locatedBy("//select[@name='how_did_you_hear_about_pod_foods_']");

    public static Target DYNAMIC_ITEM_DROPDOWN(String role) {
        return Target.the(role)
                .locatedBy("//select//option[text()='" + role + "']");
    }

    public static Target MESSAGE_SUCCESS = Target.the("Message success")
            .locatedBy("//div[contains(@class,'submitted-message')]/p");

    public static Target SUBMIT_BUTTON = Target.the("Submit button")
            .locatedBy("//button//span[text()='Submit']");

    public static Target DYNAMIC_BUTTON(String name) {
        return Target.the("Button " + name)
                .locatedBy("//button//span[contains(text(),'" + name + "')]");
    }

    public static Target STORE_LOCATION_CHECKBOX(String location) {
        return Target.the("Checkbox store location")
                .locatedBy("//label[@for='store_locations']/following-sibling::div//span[text()='" + location + "']");
    }

    public static Target CHECKBOX_AGREE = Target.the("Checkbox agree")
            .locatedBy("//span[text()='By checking this box you agree that all purchases are for commercial use only']");

    public static Target DYNAMIC_REGION(String region) {
        return Target.the("Region " + region)
                .locatedBy("//label//span[text()='" + region + "']");
    }

    /**
     * About your company
     */

    public static Target D_TEXTBOX_INFO_COMPANY(String region) {
        return Target.the("Textbox  " + region + "in tab About your company")
                .locatedBy("//label[text()='" + region + "']//following-sibling::div//input");
    }

    public static Target D_ITEM_DROPDOWN(String value) {
        return Target.the(value)
                .located(By.xpath("//div[@class='el-scrollbar']//li[text()='" + value + "']"));
    }

    public static Target D_STATE_ITEM(String value) {
        return Target.the(value)
                .located(By.xpath("//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }
}

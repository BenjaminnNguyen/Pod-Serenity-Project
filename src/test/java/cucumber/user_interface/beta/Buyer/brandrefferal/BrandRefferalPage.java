package cucumber.user_interface.beta.Buyer.brandrefferal;

import net.serenitybdd.screenplay.targets.Target;

public class BrandRefferalPage {

    public static final Target INVITE_BUTTON = Target.the("Invite button")
            .locatedBy("//button//span[text()='Invite']");

    public static final Target ERROR_MESSAGE = Target.the("Error message")
            .locatedBy("//div[text()[normalize-space() = 'Please enter a valid brand name']] ");


    /**
     * Form invite
     */

    public static Target BRAND_NAME_TEXTBOX(int index) {
        return Target.the("Brand name textbox")
                .locatedBy("(//label[text()='Brand name']/following-sibling::div//input)[" + index + "]");
    }

    public static Target EMAIL_TEXTBOX(int index) {
        return Target.the("Email textbox")
                .locatedBy("(//label[text()='Email']/following-sibling::div//input)[" + index + "]");
    }

    public static Target CONTACT_TEXTBOX(int index) {
        return Target.the("Contact name textbox")
                .locatedBy("(//label[text()='Contact name']/following-sibling::div//input)[" + index + "]");
    }

    public static Target WORK_CHECKBOX(int index) {
        return Target.the("Work checkbox")
                .locatedBy("(//span[@class='el-checkbox__label'])[" + index + "]");
    }

    public static final Target ADD_MORE_BUTTON = Target.the("Add more brand button")
            .locatedBy("//span[text()='Add more brands']");

    /**
     * Popup Thank you
     */
    public static final Target THANK_YOU_POPUP = Target.the("Thank you popup")
            .locatedBy("//div[@class='el-message-box']//span[text()='Thank you!']");

    public static final Target CONTINUE_BUTTON_IN_POPUP = Target.the("Continue button in popup")
            .locatedBy("//button//span[text()[normalize-space()='Continue shopping']]");
}

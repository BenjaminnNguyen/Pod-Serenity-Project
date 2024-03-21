package cucumber.user_interface.beta.Onboarding;

import net.serenitybdd.screenplay.targets.Target;

public class BuyerOnboardingPage {

    public static Target WELCOME_HEADER = Target.the("Welcome header")
            .locatedBy("//h1[text()='Welcome to Pod Foods!']");

    public static Target CONTINUE_BUTTON = Target.the("Continue button")
            .locatedBy("//button//span[text()='Continue']");

    public static Target RECEIVING_DAYS(String day) {
        return Target.the("Receiving dáy")
                .locatedBy("//div[@role='group']//span[text()='" + day + "']");
    }

    public static Target DYNAMIC_TEXTBOX(String name) {
        return Target.the(name)
                .locatedBy("//label[text()='" + name + "']//following-sibling::div//input");
    }

    public static Target DYNAMIC_TEXTAREA(String name) {
        return Target.the(name)
                .locatedBy("//label[text()='" + name + "']//following-sibling::div//textarea");
    }

    public static Target LIFTDATE(String value) {
        return Target.the("Liftgate check")
                .locatedBy("//label[text()='Is a liftgate required at delivery?']/following-sibling::div//span[text()='" + value + "']");
    }

    public static Target PALLETS(String value) {
        return Target.the("Pallets check")
                .locatedBy("//label[text()='Can you accept pallets?']/following-sibling::div//span[text()='" + value + "']");
    }

    public static Target DYNAMIC_BUTTON(String name) {
        return Target.the("Button " + name)
                .locatedBy("//span[contains(text(),'" + name + "')]/parent::button");
    }

    public static Target DYNAMIC_CHECKBOX(String name) {
        return Target.the("Checkbox " + name)
                .locatedBy("//*[text()='" + name + "']");
    }

    public static Target INTERESTED(String value) {
        return Target.the("Interested check")
                .locatedBy("//label[contains(text(),'Are you interested')]/following-sibling::div//span[text()='" + value + "']");
    }

    public static Target CHECKBOX_CHECKED = Target.the("Checkbox is checked")
            .locatedBy("//span[@class='el-checkbox__input is-checked']");

    public static Target LABEL_CHECKED = Target.the("Label is checked")
            .locatedBy("//label[@class='el-radio is-checked']");

    public static Target BANKRUPTCY(String value) {
        return Target.the("Ever Declared Bankruptcy?")
                .locatedBy("//label[contains(text(),'Ever Declared Bankruptcy?')]/following-sibling::div//span[text()='" + value + "']");
    }

    public static Target RECEIVE_INVOICE(String value) {
        return Target.the("Receive invoice")
                .locatedBy("//label[contains(text(),'Pod Foods brings a ')]/following-sibling::div//span[text()='" + value + "']");
    }

    //UPLOAD CERTIFICATED
    public static Target DYNAMIC_UPLOAD_FILE(String name) {
        return Target.the(name)
                .locatedBy("//span[text()='" + name + "']//ancestor::label//following-sibling::div//input");
    }

    public static Target FILENAME_UPLOADED(String fileName) {
        return Target.the(fileName)
                .locatedBy("//div[text()='" + fileName + "']");
    }

    public static Target DESCRIPTION_CERTIFICATE = Target.the("Description certificate")
            .locatedBy("//div[text()='If you are a retailer with more than one location or have multiple certificates, please email']");

    // REVIEW TOS
    public static Target TERM_OF_USER = Target.the("Description certificate")
            .locatedBy("//h3[contains(text(),'Terms of use for Buyers')]");

    public static Target CHECKBOX_REVIEW_TOS = Target.the("Checkbox review tos")
            .locatedBy("//span[@class='el-checkbox__inner']");

    public static Target SAVE_BUTTON = Target.the("Save button")
            .locatedBy("//span[contains(text(),'Save')]/ancestor::button");

    public static Target TODAY_DATE = Target.the("Today's Date")
            .locatedBy("//label[text()=\"Today's Date\"]//following-sibling::div//input");

    // COMPELETE
    public static Target TASKS_COMPLETED = Target.the("Popup up tasks compeleted")
            .locatedBy("//h1[text()='Tasks completed!']");

    public static Target PREVIOUS_STEP = Target.the("Previous step button")
            .locatedBy("//div[contains(text(),'Previous step')]");

    public static Target NEXT_BUTTON = Target.the("Next button")
            .locatedBy("//span[contains(text(),'Next')]/ancestor::button");

    public static Target WARNING_MESSAGE = Target.the("Warning mesage")
            .locatedBy("//div[@class='warning__message']");

    public static Target NO_RESULT(String mesage) {
        return Target.the("No result mesage")
                .locatedBy("(//span[text()='" + mesage + "'])[1]");
    }

}

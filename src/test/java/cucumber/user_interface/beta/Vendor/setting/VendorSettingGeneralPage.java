package cucumber.user_interface.beta.Vendor.setting;

import net.serenitybdd.screenplay.targets.Target;

public class VendorSettingGeneralPage {

    public static final Target GENERAL_BUTTON = Target.the("General button")
            .locatedBy("//a[contains(@href,'/settings/general')]");

    public static final Target D_HEADER(String header) {
        return Target.the(header + " header")
                .locatedBy("//h1[text()='" + header + "']");

    }

    /**
     * Company
     */

    public static Target D_INFO(String title) {
        return Target.the(title)
                .locatedBy("//dt[text()='" + title + "']/following-sibling::dd/span");
    }

    public static final Target WEBSITE_COMPANY_INFO = Target.the("Company info website")
            .locatedBy("//dt[text()='Website']/following-sibling::dd/a");

    public static final Target ADDRESS_COMPANY_INFO = Target.the("Company info address")
            .locatedBy("//dt[text()='Address']/following-sibling::dd/div");
    /**
     * Popup edit company information
     */

    public static final Target COMPANY_EDIT_BUTTON = Target.the("Company edit button")
            .locatedBy("//div[text()='Company']//following-sibling::div//button//span[text()='Edit']");

    public static final Target POPUP_EDIT_TITLE = Target.the("Popup title")
            .locatedBy("//div[@role='dialog']//span[contains(@class,'title')]");

    public static Target D_TEXTBOX_COMPANY_INFO(String value) {
        return Target.the(value + " in Company information popup")
                .locatedBy("//label[text()='" + value + "']/following-sibling::div//input");
    }

    /**
     * Popup edit personal
     */

    public static final Target PERSONAL_EDIT_BUTTON = Target.the("Personal edit button")
            .locatedBy("//div[text()='Personal']//following-sibling::div//button//span[text()='Edit']");

    public static Target D_TEXTBOX_POPUP_EDIT(String value) {
        return Target.the(value + " in popup")
                .locatedBy("//label[text()='" + value + "']/following-sibling::div//input");
    }

    public static Target D_TEXTBOX_POPUP_ERROR(String value) {
        return Target.the(value + " in error popup")
                .locatedBy("//label[text()='" + value + "']/following-sibling::div//div[contains(@class,'error')]");
    }

    public static final Target INVITE_AUTHOR_RADIO_BUTTON = Target.the("Invite author buyer")
            .locatedBy("//div[@role='radiogroup']//span[text()='No']");

    /**
     * Popup change password
     */
    public static final Target CHANGE_PASSWORD_BUTTON = Target.the("Change password button")
            .locatedBy("//button//span[text()='Change password']");

    /**
     * Minimums
     */

    public static final Target MINIMUM_BUTTON = Target.the("Minimums button")
            .locatedBy("//a[contains(@href,'/settings/minimums')]");

    public static final Target MINIMUM_TYPE_RADIO(String type) {
        return Target.the("Minimum type " + type)
                .locatedBy("//div[text()='" + type + "']");
    }

    public static final Target MOV_REGION_TEXTBOX(String region) {
        return Target.the("MOV region " + region + " textbox")
                .locatedBy("//label[text()='" + region + "']/following-sibling::div//input");
    }

    /**
     * Invite colleagues
     */

    public static final Target INVITE_COLLEAGUES_BUTTON = Target.the("Invite colleagues button")
            .locatedBy("//a[contains(@href,'/settings/invite-colleagues')]");

    /**
     * Notification
     */

    public static final Target NOTIFICATION_BUTTON = Target.the("Notification button")
            .locatedBy("//a[contains(@href,'/settings/notifications')]");

    /**
     * Payment
     */

    public static final Target PAYMENT_BUTTON = Target.the("Payment button")
            .locatedBy("//a[contains(@href,'/settings/payments')]");

    public static final Target PINK_PAYMENT = Target.the("Pink payment")
            .locatedBy("//div[contains(@class,'payment-warning')]");


    /**
     * Bank account
     */

    public static final Target BANK_ACCOUNT_FRAME = Target.the("Bank account frame")
            .locatedBy("//iframe[@title='Plaid Link']");

    public static final Target SEARCH_INSTITUTIONS_TEXTBOX = Target.the("Search institutions")
            .locatedBy("//label[text()='Search Institutions']/following-sibling::input");

    public static final Target RESULT_INSTITUTION(String value) {
        return Target.the("Search institutions")
                .locatedBy("//button//*[text()='" + value + "']");
    }

    public static final Target D_ADD_BANK_TEXTBOX(String value) {
        return Target.the("Textbox in add bank")
                .locatedBy("//label[text()='" + value + "']/following-sibling::input");
    }

    public static final Target PLAID_SAVING = Target.the("Plaid saving")
            .locatedBy("//div[text()='Plaid Saving']");

    public static final Target ADD_SUCCESS_LABEL= Target.the("Add success label")
            .locatedBy("//h1[text()='Success']");

    public static final Target LAST_4_CARD_NUMBER = Target.the("Last 4 card number")
            .locatedBy("//span[@class='last-4']");

    public static final Target CARD_NAME = Target.the("Card name")
            .locatedBy("//div[contains(@class,'name')]");

    public static final Target ACCOUNT_TYPE = Target.the("Account type")
            .locatedBy("//div[text()='Savings']");

    public static final Target NOTE_VERIFY_BANK_ACC_1 = Target.the("Note verify bank account")
            .locatedBy("//div[@class='note']/strong");

    public static final Target NOTE_VERIFY_BANK_ACC_2 = Target.the("Note verify bank account")
            .locatedBy("//div[@class='note']/span");
}

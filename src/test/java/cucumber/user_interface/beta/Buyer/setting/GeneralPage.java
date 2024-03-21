package cucumber.user_interface.beta.Buyer.setting;

import net.serenitybdd.screenplay.targets.Target;

public class GeneralPage {

    public static final Target GENERAL_BUTTON = Target.the("General button")
            .locatedBy("//a[contains(@href,'/settings/general')]");
    public static final Target GENERAL_HEADER = Target.the("General header")
            .locatedBy("//h1[text()='General Settings']");

    public static Target DYNAMIC_FIELD(String value) {
        return Target.the("Field " + value)
                .locatedBy("//dt[text()='" + value + "']/following-sibling::dd//span");
    }

    public static Target DYNAMIC_IMAGE(String value) {
        return Target.the("Field " + value)
                .locatedBy("(//dt[text()='" + value + "']/following-sibling::dd//div[contains(@class,'name')])[1]");
    }

    /**
     * Store Information
     */
    public static final Target EDIT_STORE_BUTTON = Target.the("Edit store button")
            .locatedBy("//div[contains(@class,'store')]//span[text()='Edit']");

    public static final Target STORE_INFORMATION_POPUP = Target.the("Store information popup")
            .locatedBy("//div[@role='dialog']//span[text()='Store Information']");

    public static Target D_TEXTBOX_STORE_INFO(String value) {
        return Target.the(value + " in Store information popup")
                .locatedBy("//label[text()='" + value + "']/following-sibling::div//input");
    }

    /**
     * Company Information - Document
     */

    public static final Target COMPANY_NAME = Target.the("Company name")
            .locatedBy("//dt[text()='Company name']/following-sibling::dd/span");

    public static final Target EIN = Target.the("EIN")
            .locatedBy("//dt[text()='EIN']/following-sibling::dd/span");

    public static final Target COMPANY_DOCUMENT_DESCRIPTION = Target.the("Company document description")
            .locatedBy("//dt[text()='Documents']/following-sibling::dd//div[contains(@class,'name')]");

    public static final Target COMPANY_DOCUMENT_LINK = Target.the("Company document link")
            .locatedBy("//dt[text()='Documents']/following-sibling::dd//div[contains(@class,'link')]");

    /**
     * Company Information - Business License Certificates
     */

    public static final Target BUSINESS_LICENSE_CERTIFICATES_DESCRIPTION = Target.the("Business License Certificates description")
            .locatedBy("//dt[text()='Business License Certificates']/following-sibling::dd//div[contains(@class,'name')]");

    public static final Target BUSINESS_LICENSE_CERTIFICATES_LINK = Target.the("Business License Certificates link")
            .locatedBy("//dt[text()='Business License Certificates']/following-sibling::dd//div[contains(@class,'link')]");

    /**
     * Company Information - Resale Certificates
     */

    public static final Target RESALE_CERTIFICATES_DESCRIPTION = Target.the("Resale Certificates description")
            .locatedBy("//dt[text()='Resale Certificates']/following-sibling::dd//div[contains(@class,'name')]");

    public static final Target RESALE_CERTIFICATES_LINK = Target.the("Resale Certificates link")
            .locatedBy("//dt[text()='Resale Certificates']/following-sibling::dd//div[contains(@class,'link')]");

    /**
     * Personal Information
     */

    public static final Target PERSONAL_EDIT_BUTTON = Target.the("Personal edit button")
            .locatedBy("//div[text()='Personal Information']//following-sibling::div//button//span[text()='Edit']");

    public static final Target POPUP_EDIT_TITLE = Target.the("Popup title")
            .locatedBy("//div[@role='dialog']//span[contains(@class,'title')]");


}

package cucumber.user_interface.beta.Buyer.orders;

import net.serenitybdd.screenplay.targets.Target;

public class BuyerClaimPage {

    public static Target ISSUES_BUTTON = Target.the("Issues button in order detail")
            .locatedBy("//a//span[text()='Issues?']");

    public static Target HERE_BUTTON = Target.the("Here button to submit another")
            .locatedBy("//p//a[text()='here.']");

    /**
     * Claim detail page - buyer
     */

    public static Target COMPANY_TEXTBOX = Target.the("Company textbox")
            .locatedBy("//label[text()='Company']/following-sibling::div//input");

    public static Target EMAIL_TEXTBOX = Target.the("Email textbox")
            .locatedBy("//label[text()='Email']/following-sibling::div//input");

    public static Target INVOICE_TEXTBOX = Target.the("Invoice textbox")
            .locatedBy("//label[text()='Invoice']/following-sibling::div//input");

    public static Target INVOICE_TEXTBOX_DISABLE = Target.the("Invoice textbox")
            .locatedBy("//label[text()='Invoice']/following-sibling::div//input[@disabled='disabled']");

    public static Target D_ISSUES(String typeIssues) {
        return Target.the("Type issues " + typeIssues)
                .locatedBy("//label[@for='issue']/following-sibling::div//span[text()='" + typeIssues + "']");
    }

    public static Target D_SKU(String skuName) {
        return Target.the("Sku " + skuName)
                .locatedBy("//div[text()='" + skuName + "']/ancestor::div[@class='preview']/preceding-sibling::div[@class='select']//span[@class='el-checkbox__input']");
    }

    public static Target PICTURE_BUTTON(int index) {
        return Target.the("Picture button " + index)
                .locatedBy("(//label[text()='Pictures']/following-sibling::div//input)[" + index + "]");
    }

    public static Target ISSUES_TEXTAREA = Target.the("Picture button")
            .locatedBy("//label[text()='Issue Description']/following-sibling::div//textarea");

    public static Target AFFECTED_PRODUCT_TEXTAREA = Target.the("Affected products textarea")
            .locatedBy("//label[text()='Affected Products']/following-sibling::div//textarea");

    public static Target MESSAGE_SUCCESS(String message) {
        return Target.the("Message claim success")
                .locatedBy("//p[contains(text(),'" + message + "')]");
    }

    public static Target MESSAGE_ERROR = Target.the("Message claim success")
            .locatedBy("//div[@class='el-notification__content']/p");



    public static Target SKU_AFFECTED_CHECKBOX(String sku) {
        return Target.the("affected checkbox of sku " + sku)
                .locatedBy("//div[text()='" + sku + "']//ancestor::div[@class='preview']/preceding-sibling::div/label");
    }

    public static Target QUANTITY_AFFECTED_CHECKBOX(String sku) {
        return Target.the("affected checkbox of quantity " + sku)
                .locatedBy("//div[text()='" + sku + "']//ancestor::div/following-sibling::div[@class='quantity']//input");
    }


    // error
    public static Target COMPANY_ERROR_LABEL = Target.the("Company error message")
            .locatedBy("//label[text()='Company']/following-sibling::div/div[contains(@class,'error')]");

    public static Target EMAIL_ERROR_LABEL = Target.the("Email error message")
            .locatedBy("//label[text()='Email']/following-sibling::div/div[contains(@class,'error')]");

    public static Target INVOICE_ERROR_LABEL = Target.the("Invoice error message")
            .locatedBy("//label[text()='Invoice']/following-sibling::div/div[contains(@class,'error')]");

    public static Target ISSUE_ERROR_LABEL = Target.the("Issue error message")
            .locatedBy("//label[text()='Issue']/following-sibling::div/div[contains(@class,'error')]");

    public static Target AFFECTED_ERROR_LABEL = Target.the("Affected product error message")
            .locatedBy("//label[text()='Issue']/following-sibling::div/div[contains(@class,'error')]");

    /**
     * Claim detail page - head buyer
     */


    public static Target CLAIMS_POLICY_LINK = Target.the("Claims policy link")
            .locatedBy("//a[text()='Claims Policy here.']");
    public static Target STORE_TEXTBOX = Target.the("Store textbox")
            .locatedBy("//label[text()='Store']/following-sibling::div//input");

    public static Target STORE_ERROR_LABEL = Target.the("Store error message")
            .locatedBy("//label[text()='Store']/following-sibling::div/div[contains(@class,'error')]");

}

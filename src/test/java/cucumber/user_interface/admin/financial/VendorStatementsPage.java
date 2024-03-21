package cucumber.user_interface.admin.financial;

import net.serenitybdd.screenplay.targets.Target;

public class VendorStatementsPage {

    /**
     * Popup Permission request
     */
    public static Target PASSWORD_TEXTBOX = Target.the("Textbox Authentication password")
            .locatedBy("//input[@type='password']");

    public static Target AUTHORIZE_BUTTON = Target.the("Authorize button")
            .locatedBy("//div[@role='dialog']//button//span[text()='Authorize']");

    public static Target AUTHORIZE_ALERT = Target.the("Authorize alert popup")
            .locatedBy("//div[@role='alert']");

    public static Target AUTHORIZE_ALERT_CLOSE = Target.the("Authorize alert close button")
            .locatedBy("//div[@role='alert']//div[contains(@class,'el-icon-close')]");

    /**
     * Result after search
     */
    public static Target VENDOR_COMPANY_RESULT(String vendorCompany) {
        return Target.the("Vendor company in result")
                .locatedBy("//td[contains(@class,'vendor-company')]//a[text()='" + vendorCompany + "']");

    }

    public static Target MONTH_RESULT = Target.the("Month in result")
            .locatedBy("//td[contains(@class,'month')]//div");

    public static Target STATUS_RESULT = Target.the("Status in result")
            .locatedBy("//td[contains(@class,'payment-status')]//div");

    public static Target BEGINNING_BALANCE_RESULT = Target.the("Beginning balance in result")
            .locatedBy("//td[contains(@class,'beginning-balance')]//div");

    public static Target ENDING_BALANCE_RESULT = Target.the("Ending balance in result")
            .locatedBy("//td[contains(@class,'ending-balance')]//div");


    /**
     * Vendor statements detail
     */
    public static Target ORDER_NUMBER_CHECKBOX(String orderID) {
        return Target.the("Order number checkbox in vendor statements detail")
                .locatedBy("//td//input[@data-order='" + orderID + "']");
    }

    public static Target ORDER_NUMBER_CHECKBOX_VERIFY(String orderID) {
        return Target.the("Order number checkbox in vendor statements detail")
                .locatedBy("//input[@data-order='" + orderID + "' and @disabled='disabled']");
    }

    public static Target PAY_ACTION = Target.the("Pay money")
            .locatedBy("//div[@class='actions']//span[contains(text(),'Pay')]");

    public static Target DESCRIPTION_TEXTBOX = Target.the("Pay money")
            .locatedBy("(//div[@role='dialog']//input)[1]");

    public static Target PAYMENT_TYPE(String type) {
        return Target.the("Pay money")
                .locatedBy("//div[@role='dialog']//span[text()='" + type + "']");
    }

    public static Target ADJUSTMENT_DESCRIPTION_CHECKBOX(String adjustmentDescription) {
        return Target.the("Order number checkbox in vendor statements detail")
                .locatedBy("//span[text()='" + adjustmentDescription + "']/ancestor::tr//input");
    }

    public static Target CONFIRM_BUTTON = Target.the("Confirm button")
            .locatedBy("//button//span[text()='Confirm']");


    /**
     * Upload Adjustment popup
     */

    public static Target UPLOAD_ADJUSTMENT_BUTTON = Target.the("Upload adjustment button")
            .locatedBy("//span[text()='Upload Adjustments']/ancestor::button//following-sibling::input");

    public static Target UPLOAD_ADJUSTMENT_CSV_LABEL = Target.the("Upload adjustment csv label")
            .locatedBy("//div[@role='dialog']//span[text()='Upload Adjsutment CSV']");

    public static Target MONTH_UPLOAD_CSV(int index) {
        return Target.the("Upload adjustment csv month")
                .locatedBy("(//td[@class='month']/span)[" + index + "]");
    }

    public static Target VENDOR_COMPANY_UPLOAD_CSV(int index) {
        return Target.the("Upload adjustment csv month")
                .locatedBy("(//td[@class='vendor-company'])[" + index + "]");
    }

    public static Target ADJUSTMENT_TYPE_UPLOAD_CSV(int index) {
        return Target.the("Upload adjustment csv adjustment type")
                .locatedBy("(//td[@class='adjustment-type'])[" + index + "]");
    }

    public static Target EFFECTIVE_DATE_UPLOAD_CSV(int index) {
        return Target.the("Upload adjustment csv effective date")
                .locatedBy("(//td[@class='effective-date']/span)[" + index + "]");
    }

    public static Target DESCRIPTION_UPLOAD_CSV(int index) {
        return Target.the("Upload adjustment csv description")
                .locatedBy("(//td[@class='description'])[" + index + "]");
    }

    public static Target AMOUNT_UPLOAD_CSV(int index) {
        return Target.the("Upload adjustment csv amount")
                .locatedBy("(//td[@class='amount'])[" + index + "]");
    }

    public static Target ERROR_UPLOAD_CSV(int index) {
        return Target.the("Upload adjustment csv error")
                .locatedBy("(//td[@class='message'])[" + index + "]");
    }

    /**
     * General information detail
     */
    public static Target PAYMENT_STATE_FIELD = Target.the("Payment state in general information")
            .locatedBy("//dt[contains(text(),'Payment state')]/following-sibling::dd//div");

    public static Target VENDOR_COMPANY_FIELD = Target.the("Vendor company in general information")
            .locatedBy("(//dt[contains(text(),'Vendor company')]/following-sibling::dd//div)[1]");

    public static Target STATEMENT_MONTH_FIELD = Target.the("Statement month in general information")
            .locatedBy("(//dt[contains(text(),'Statement month')]/following-sibling::dd//div)[1]");

    public static Target ALL_CHECKBOX = Target.the("All checkbox")
            .locatedBy("((//table[contains(@class,'statement')]//tr)[1]//input)[1]");

    /**
     * Payment record in detail
     */

    public static Target PAYMENT_DESCRIPTION(String description) {
        return Target.the("Payment description")
                .locatedBy("//div[@class='description']//span[text()='" + description + "']");
    }

    public static Target PAYMENT_DATE(String description) {
        return Target.the("Payment date")
                .locatedBy("//span[text()='" + description + "']/ancestor::td/preceding-sibling::td/span[@class='created-at']");
    }

    public static Target PAYMENT_TYPE1(String description) {
        return Target.the("Payment type")
                .locatedBy("//span[text()='" + description + "']/preceding-sibling::span[@class='type']");
    }

    public static Target PAYMENT_PAYMENTS(String description) {
        return Target.the("Payment payments")
                .locatedBy("//span[text()='"+description+"']/ancestor::td/following-sibling::td/span[@class='payment']");
    }

    public static Target PAYMENT_NET_PAYMENT(String description) {
        return Target.the("Payment Net payments")
                .locatedBy("//span[text()='"+description+"']/ancestor::td/following-sibling::td/span[@class='net-payment']");
    }

    /**
     * Adjustment in detail
     */
    public static Target DATE_ADJUSTMENT(int index) {
        return Target.the("Adjustment date")
                .locatedBy("(//tr[@data-type='StatementItems::Adjustment']//span[@class='effective-date'])[" + index + "]");
    }

    public static Target EDIT_ADJUSTMENT(int index) {
        return Target.the("Adjustment date")
                .locatedBy("(//tr[@data-type='StatementItems::Adjustment']//td[@class='actions']//button[1])[" + index + "]");
    }

    public static Target EDIT_ADJUSTMENT_DISABLED(String description) {
        return Target.the("Adjustment edit button")
                .locatedBy("(//span[text()='" + description + "']/ancestor::td/preceding-sibling::td[@class='actions']//button[@disabled])[1]");
    }

    public static Target DELETE_ADJUSTMENT(int index) {
        return Target.the("Adjustment delete")
                .locatedBy("(//tr[@data-type='StatementItems::Adjustment']//td[@class='actions']//button[2])[" + index + "]");
    }

    public static Target TYPE_ADJUSTMENT(int index) {
        return Target.the("Adjustment type")
                .locatedBy("(//tr[@data-type='StatementItems::Adjustment']//span[@class='type'])[" + index + "]");
    }

    public static Target DESCRIPTION_ADJUSTMENT(int index) {
        return Target.the("Adjustment description")
                .locatedBy("(//tr[@data-type='StatementItems::Adjustment']//span[@class='divider']/following-sibling::span)[" + index + "]");
    }

    public static Target AMOUNT_ADJUSTMENT(int index) {
        return Target.the("Adjustment amount")
                .locatedBy("(//tr[@data-type='StatementItems::Adjustment']//span[@class='net-payment'])[" + index + "]");
    }

    public static Target DATE_ADJUSTMENT(String description) {
        return Target.the("Adjustment date")
                .locatedBy("//span[text()='" + description + "']/ancestor::td/preceding-sibling::td/span[@class='effective-date']");
    }

    public static Target EDIT_ADJUSTMENT(String description) {
        return Target.the("Adjustment edit button")
                .locatedBy("(//span[text()='" + description + "']/ancestor::td/preceding-sibling::td[@class='actions']//button)[1]");
    }

    public static Target DELETE_ADJUSTMENT(String description) {
        return Target.the("Adjustment delete button")
                .locatedBy("(//span[text()='" + description + "']/ancestor::td/preceding-sibling::td[@class='actions']//button)[2]");
    }

    public static Target DELETE_ADJUSTMENT_DISABLE(String description) {
        return Target.the("Adjustment delete button disable")
                .locatedBy("(//span[text()='" + description + "']/ancestor::td/preceding-sibling::td[@class='actions']//button[@disabled])[2]");
    }


    public static Target TYPE_ADJUSTMENT(String description) {
        return Target.the("Adjustment type")
                .locatedBy("//span[text()='" + description + "']/preceding-sibling::span[@class='type']");
    }

    public static Target DESCRIPTION_ADJUSTMENT(String description) {
        return Target.the("Adjustment description")
                .locatedBy("//div[@class='description']//span[text()='" + description + "']");
    }

    public static Target AMOUNT_ADJUSTMENT(String description) {
        return Target.the("Adjustment amount")
                .locatedBy("//span[text()='" + description + "']/ancestor::td/following-sibling::td//span[@class='net-payment']");
    }
}

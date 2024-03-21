package cucumber.user_interface.admin.financial.storestatements;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class CreditMemosPage {

    /**
     * Search - Result
     */


    public static Target NUMBER_RESULT_FIRST = Target.the("Number first in result")
            .located(By.xpath("(//td[contains(@class,'number')]//a)[1]"));

    public static Target STORE_RESULT_FIRST = Target.the("Store first in result")
            .located(By.xpath("(//td[contains(@class,'store')]//span)[1]"));

    public static Target BUYER_RESULT_FIRST = Target.the("Buyer first in result")
            .located(By.xpath("(//td[contains(@class,'buyer')]//span)[1]"));

    public static Target NUMBER_RESULT(String number) {
        return Target.the("Number in result")
                .located(By.xpath("//td[contains(@class,'number')]//a[text()='" + number + "']"));
    }

    public static Target STORE_RESULT(String number) {
        return Target.the("Store in result")
                .located(By.xpath("//a[text()='" + number + "']/ancestor::td/following-sibling::td//div[contains(@class,'store-name')]/span"));
    }

    public static Target BUYER_RESULT(String number) {
        return Target.the("Buyer in result")
                .located(By.xpath("//a[text()='" + number + "']/ancestor::td/following-sibling::td//div[contains(@class,'buyer-name')]/span"));
    }

    public static Target EMAIL_BUYER_RESULT(String number) {
        return Target.the("Buyer Email in result")
                .located(By.xpath("//a[text()='" + number + "']/ancestor::td/following-sibling::td//a[contains(@class,'buyer-email')]/span"));
    }

    public static Target AMOUNT_RESULT(String number) {
        return Target.the("Amount in result")
                .located(By.xpath("//a[text()='" + number + "']/ancestor::td/following-sibling::td//div[contains(@class,'amount')]"));
    }

    public static Target STATE_RESULT(String number) {
        return Target.the("State in result")
                .located(By.xpath("//a[text()='" + number + "']/ancestor::td/following-sibling::td//div[contains(@class,'status-tag')]"));
    }


    public static Target CREATE_BUTTON = Target.the("Create button")
            .located(By.xpath("//span[text()='Create']/ancestor::button"));

    public static Target D_TEXTBOX(String title) {
        return Target.the(title + " textbox")
                .located(By.xpath("//label[text()='" + title + "']/following-sibling::div//input"));
    }

    public static Target D_TEXTBOX1(String title) {
        return Target.the(title + " textbox")
                .located(By.xpath("//label[text()='" + title + "']/following-sibling::div//input/parent::div"));
    }

    public static Target D_TEXTAREA(String title) {
        return Target.the(title + " textarea")
                .located(By.xpath("//label[text()='" + title + "']/following-sibling::div//textarea"));
    }

    public static Target ATTACTMENT_BUTTON = Target.the("Attachment button")
            .located(By.xpath("//input[@type='file']"));

    public static Target NUMBER_CREDIT = Target.the("Number of credit memo")
            .located(By.xpath("//div[@class='memo-number bold']"));

    /**
     * Cost Covered by
     */
    public static Target POD_FOODS_COST_COVERED_BY_TEXTBOX = Target.the("Pod foods cost covered by textbox")
            .located(By.xpath("//span[text()='Pod foods']/parent::div/following-sibling::div//input"));


    public static Target VENDOR_COMPANY_COST_COVERED_BY_TEXTBOX = Target.the("Vendor company cost covered by textbox")
            .located(By.xpath("//label[text()='Select vendor company']/following-sibling::div//input"));

    public static Target VENDOR_COMPANY_COST_COVERED_BY_ERROR = Target.the("Vendor company cost covered by textbox")
            .located(By.xpath("//label[text()='Select vendor company']/following-sibling::div/div[contains(@class,'error')]"));

    public static Target COST_COVERED_BY_TEXTBOX(String value) {
        return Target.the("cost covered by textbox")
                .located(By.xpath("//span[text()='" + value + "']/parent::div/following-sibling::div//input"));
    }

    public static Target COST_COVERED_BY_DELETE_BUTTON(String value) {
        return Target.the("cost covered by delete button")
                .located(By.xpath("//span[text()='" + value + "']/parent::div/following-sibling::div/button"));
    }

    public static Target BALANCE_TEXTBOX = Target.the("Balance textbox")
            .located(By.xpath("//label[text()='Balance']//following-sibling::div//span"));

    public static Target LOGISTIC_PARTNER_COST_COVERED_BY_TEXTBOX = Target.the("Logistic partner cost covered by textbox")
            .located(By.xpath("//label[text()='Logistics partner']/following-sibling::div//input"));

    /**
     * Credit memo detail
     */
    public static Target GENERAL_INFO_LABEL = Target.the("General information label")
            .located(By.xpath("//div[text()='General Information']"));


    public static Target GENERAL_INFO_CREATED = Target.the("General information created")
            .located(By.xpath("//dt[text()='Created']//following-sibling::dd/span"));

    public static Target GENERAL_INFO_BUYER = Target.the("General information buyer")
            .located(By.xpath("(//dt[text()='Buyer']//following-sibling::dd/div)[1]"));

    public static Target GENERAL_INFO_STORE = Target.the("General information store")
            .located(By.xpath("(//dt[text()='Store']//following-sibling::dd/div)[1]"));

    public static Target GENERAL_INFO_ORDER = Target.the("General information order")
            .located(By.xpath("(//dt[text()='Order']//following-sibling::dd//div[contains(@class,'content el-popover__reference')]/*)[1]"));

    public static Target GENERAL_INFO_DESCRIPTION = Target.the("General information description")
            .located(By.xpath("//dt[text()='Description']//following-sibling::dd//div[contains(@class,'description')]"));

    public static Target GENERAL_INFO_TYPE = Target.the("General information type")
            .located(By.xpath("//dt[text()='Type']//following-sibling::dd//div[@class='type']"));

    public static Target GENERAL_INFO_EXPIRY_DATE = Target.the("General information expiry date")
            .located(By.xpath("//dt[text()='Expired at']//following-sibling::dd//span[contains(@class,'expiry-date')]"));

    public static Target GENERAL_INFO_STATUS = Target.the("General information status")
            .located(By.xpath("//dt[text()='State']//following-sibling::dd//div[contains(@class,'status-tag')]"));

    public static Target GENERAL_INFO_AMOUNT = Target.the("General information amount")
            .located(By.xpath("//dt[text()='Amount']//following-sibling::dd//div[contains(@class,'amount')]"));

    /**
     * Attachment
     */
    public static Target ATTACTMENT_IN_DETAIL(String fileName) {
        return Target.the("Attachment in detail")
                .located(By.xpath("//a//span[contains(text(),'" + fileName + "')]"));
    }

    /**
     * Cost covered by - detail
     */
    public static Target COST_COVERED_BY_VALUE_TEXTBOX(String fileName) {
        return Target.the("Cost covered by value in textbox")
                .located(By.xpath("//label[text()='Cost covered by']/following-sibling::div//span[contains(@class,'tags') and text()='" + fileName + "']"));
    }

    public static Target VENDOR_COMPANY_COVER(String vendorCompany) {
        return Target.the("Vendor Company in Cost covered by")
                .located(By.xpath("//span[@class='cover-stamp' and text()='" + vendorCompany + "']"));
    }

    public static Target VENDOR_COMPANY_COVER_AMOUNT(String vendorCompany) {
        return Target.the("Vendor Company amount in Cost covered by")
                .located(By.xpath("//span[@class='cover-stamp' and text()='" + vendorCompany + "']/parent::div/following-sibling::div//input"));
    }

    //Cancel button

    public static Target CANCEL_BUTTON_DISABLE = Target.the("Cancel button disable")
            .located(By.xpath("//span[text()='Cancel this credit memo']//ancestor::button[@disabled='disabled']"));

    /**
     * General Information text field
     */
    public static Target AMOUNT_FIELD = Target.the("Amount field in general information")
            .located(By.xpath("//div[@class='amount']"));

    public static Target STATE_FIELD = Target.the("General information state")
            .located(By.xpath("//div[@class='status-tag']"));


    /**
     * Upload another attachment
     */

    public static Target ATTACHMENT_POPUP = Target.the("General information state")
            .located(By.xpath("//div[@role='tooltip']//label[text()='Attachment']"));

    public static Target ACTTACHMENT_POPUP_BUTTON_UPDATE = Target.the("Attachment tooltip button update")
            .located(By.xpath("//div[@role='tooltip' and @x-placement]//button[contains(text(),'Update')]"));

    public static Target ACTTACHMENT_POPUP_BUTTON_CANCEL = Target.the("Attachment tooltip button cancel")
            .located(By.xpath("//div[@role='tooltip' and @x-placement]//button/span[contains(text(),'Cancel')]"));

    public static Target ACTTACHMENT_POPUP_UPLOAD = Target.the("Attachment tooltip upload file")
            .located(By.xpath("//div[@role='tooltip' and @x-placement]//input"));

}

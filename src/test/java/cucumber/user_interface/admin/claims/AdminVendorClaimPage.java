package cucumber.user_interface.admin.claims;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AdminVendorClaimPage {
    /**
     * Create Claim
     */

    public static Target TITLE_PAGE = Target.the("Page title")
            .located(By.xpath("//div[@class='title']/span[text()='Create new claim']"));

    public static Target D_TEXTBOX_ERROR(String title) {
        return Target.the("Textbox " + title + " error message")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div/div[contains(@class,'error')]");
    }

    public static Target D_TEXTBOX_IN_CREATE(String title) {
        return Target.the("Textbox " + title + "")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static Target D_TEXTAREA_IN_CREATE(String title) {
        return Target.the("Textarea " + title + "")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//textarea");
    }

    public static Target ISSUE_VALUE_IN_CREATE(String value) {
        return Target.the("Checkbox issue with value " + value + "")
                .locatedBy("//label[text()='Issue']/following-sibling::div//span[text()='" + value + "']");
    }

    public static Target UPLOAD_FILE_IN_CREATE(int index) {
        return Target.the("Textbox upload file in create")
                .locatedBy("(//label[text()='Upload files']/following-sibling::div//input)[" + index + "]");
    }

    public static Target REMOVE_UPLOAD_IN_CREATE(int index) {
        return Target.the("Remove upload file button in create")
                .locatedBy("(//label[text()='Upload files']/following-sibling::div//button)[" + index + "]");
    }

    public static Target TYPE_VALUE_IN_CREATE(String value) {
        return Target.the("Type with value " + value + "")
                .locatedBy("//label[text()='Type']/following-sibling::div//label//span[text()='" + value + "']");
    }

    public static Target SKU_QUANTITY_TEXTBOX_IN_CREATE(String sku) {
        return Target.the("Textbox quantity of SKU " + sku + " added in create")
                .locatedBy("//span[@data-original-text='" + sku + "']/ancestor::td/following-sibling::td//input");
    }

    public static Target SKU_ITEM_IN_CREATE(String sku) {
        return Target.the("SKU " + sku + " added in create")
                .locatedBy("//div[@class='claim-secific-Skus']//span[@data-original-text='" + sku + "']");
    }

    public static Target SKU_ID_ITEM_IN_CREATE(String sku) {
        return Target.the("ID of " + sku + " added in create")
                .locatedBy("//div[@class='claim-secific-Skus']//span[@data-original-text='" + sku + "']/parent::div/following-sibling::div[contains(@class,'item-code')]/span");
    }

    public static Target DELETE_SKU_IN_CREATE(String sku) {
        return Target.the("Delete button " + sku + " added in create")
                .locatedBy("//div[@class='claim-secific-Skus']//span[@data-original-text='" + sku + "']/ancestor::td/following-sibling::td/button");
    }

    /**
     * Create Claim - Order & Inbound
     */

    public static Target SKU_ITEM_IN_CREATE(String order, String sku) {
        return Target.the("Sku " + sku + " of item in create")
                .locatedBy("//span[text()='#" + order + "']/ancestor::tr/following-sibling::tr//span[text()='" + sku + "']");
    }

    public static Target SKU_ID_ITEM_IN_CREATE(String order, String sku) {
        return Target.the("Sku ID " + sku + " of item in create")
                .locatedBy("//span[text()='#" + order + "']/ancestor::tr/following-sibling::tr//span[text()='" + sku + "']/parent::div/following-sibling::div/span");
    }

    public static Target SKU_QUANTITY_ITEM_IN_CREATE(String number, String sku) {
        return Target.the("Quantity of sku " + sku + " of item in create")
                .locatedBy("//span[text()='#" + number + "']/ancestor::tr/following-sibling::tr//span[text()='" + sku + "']/ancestor::td/following-sibling::td//input");
    }

    public static Target DELETE_ITEM_IN_CREATE(String number) {
        return Target.the("Delete button of item " + number + " in create")
                .locatedBy("//span[text()='#" + number + "']/parent::td/following-sibling::td/button");
    }

    /**
     * Select line item - popup
     */
    public static Target SELECT_LINE_ITEM_POPUP = Target.the("Select line item popup")
            .locatedBy("//div[@role='dialog']//span[contains(text(),'Select line item')]");

    public static Target TEXTBOX_IN_SELECT_ITEM_POPUP = Target.the("Textbox search in Select item popup")
            .locatedBy("//div[@role='dialog']//input");

    public static Target ITEM_IN_SELECT_LINE_ITEM_POPUP(String sku) {
        return Target.the("Item " + sku + " in Select line item popup")
                .locatedBy("//div[@class='items']//div[@class='variant']/span[text()='" + sku + "']");
    }

    /**
     * Select order - popup
     */
    public static Target SELECT_ORDER_POPUP = Target.the("Select order popup")
            .locatedBy("//div[@role='dialog']//span[contains(text(),'Select order')]");

    public static Target ITEM_IN_SELECT_ORDER_POPUP(String order) {
        return Target.the("Item " + order + " in Select order popup")
                .locatedBy("//div[contains(@x-placement,'start')]//*[contains(text(),'" + order + "')]");
    }

    /**
     * Select inbound inventory - popup
     */
    public static Target SELECT_INBOUND_POPUP = Target.the("Select inbound popup")
            .locatedBy("//div[@role='dialog']//span[contains(text(),'Select Inbound Inventory')]");


    /**
     * Vendor Claim Detail - General Information
     */

    public static Target GENERAL_INFORMATION_LABEL = Target.the("General information label")
            .locatedBy("//div[text()='General information']");

    public static Target NUMBER_CLAIM = Target.the("Number of claim")
            .locatedBy("(//div[@class='title']/span)[1]");

    public static Target VENDOR_GENERAL_INFO = Target.the("Vendor in general information")
            .locatedBy("//div[text()='General information']/following-sibling::div//span[@class='name']");

    public static Target VENDOR_COMPANY_GENERAL_INFO = Target.the("Vendor company in general information")
            .locatedBy("//div[text()='General information']/following-sibling::div//span[@class='vendor-company-name']");

    public static Target BRAND_GENERAL_INFO = Target.the("Brand in general information")
            .locatedBy("//div[text()='General information']/following-sibling::div//div[contains(@class,'brand')]");

    public static Target REGION_GENERAL_INFO = Target.the("Region in general information")
            .locatedBy("//div[text()='General information']/following-sibling::div//span[contains(@class,'region')]");

    public static Target ISSUE_GENERAL_INFO = Target.the("Issue in general information")
            .locatedBy("//div[text()='General information']/following-sibling::div//span[@class='issue']");

    public static Target ISSUE_DESCRIPTION_GENERAL_INFO = Target.the("Issue description in general information")
            .locatedBy("((//dt[text()='Issue Description']/following-sibling::dd)[1]//span)[last()]");

    public static Target TYPE_GENERAL_INFO = Target.the("Type in general information")
            .locatedBy("(//span[text()='Type']/parent::dt/following-sibling::dd//span)[last()]");

    public static Target DATE_OF_SUBMISSION_GENERAL_INFO = Target.the("Date of submission in general information")
            .locatedBy("//div[text()='General information']/following-sibling::div//div[@class='date-of-submitssion']");

    public static Target STATUS_GENERAL_INFO = Target.the("Status in general information")
            .locatedBy("//div[text()='General information']/following-sibling::div//div[@class='status-tag']");

    public static Target ADMIN_NOTE_GENERAL_INFO = Target.the("Status in general information")
            .locatedBy("(//dt[text()='Admin note']/following-sibling::dd//span)[last()]");

    /**
     * Vendor Claim Detail - Uploaded file
     */

    public static Target FILE_UPLOADED(String fileName) {
        return Target.the("File uploaded")
                .locatedBy("//div[text()='Upload files']/following-sibling::div//div[text()='" + fileName + "']");
    }

    /**
     * Vendor Claim Detail - SKU
     */

    public static Target SKU_DETAIL(String sku) {
        return Target.the("SKU " + sku + " in claim detail")
                .locatedBy("//div[text()='SKU(s)']/following-sibling::div//span[@data-original-text='" + sku + "']");
    }

    public static Target SKU_ID_DETAIL(String sku) {
        return Target.the("ID of " + sku + " in claim detail")
                .locatedBy("//div[text()='SKU(s)']/following-sibling::div//span[@data-original-text='" + sku + "']/parent::div/following-sibling::div/span");
    }

    public static Target SKU_QUANTITY_DETAIL(String sku) {
        return Target.the("Quantity of sku " + sku + " in claim detail")
                .locatedBy("//div[text()='SKU(s)']/following-sibling::div//span[@data-original-text='" + sku + "']/ancestor::td/following-sibling::td//input");
    }

    /**
     * Vendor Claim Detail - Inbound
     */

    public static Target INBOUND_DETAIL(String inbound) {
        return Target.the("Inbound " + inbound + " in claim detail")
                .locatedBy("(//span[contains(text(),'" + inbound + "')])[1]");
    }

    public static Target SKU_INBOUND_DETAIL(String inbound, String sku) {
        return Target.the(sku + " of inbound in claim detail")
                .locatedBy("(//span[contains(text(),'" + inbound + "')]/ancestor::tr/following-sibling::tr//div[@class='variant']//span[text()='" + sku + "' or @data-original-text='" + sku + "'])[1]");
    }

    public static Target SKU_ID_INBOUND_DETAIL(String inbound, String sku) {
        return Target.the("ID " + sku + " of inbound in claim detail")
                .locatedBy("(//span[contains(text(),'" + inbound + "')]/ancestor::tr/following-sibling::tr//span[text()='" + sku + "' or @data-original-text='" + sku + "']/parent::div/following-sibling::div/span)[1]");
    }

    public static Target QUANTITY_INBOUND_DETAIL(String inbound, String sku) {
        return Target.the("Quantity of " + sku + " of inbound in claim detail")
                .locatedBy("(//span[contains(text(),'" + inbound + "')]/ancestor::tr/following-sibling::tr//span[text()='" + sku + "' or @data-original-text='" + sku + "']/ancestor::td/following-sibling::td//input)[1]");
    }

    public static Target DELETE_INBOUND_DETAIL(String inbound, String sku) {
        return Target.the("Delete button of " + sku + " of inbound in claim detail")
                .locatedBy("(//span[contains(text(),'" + inbound + "')]/ancestor::tr/following-sibling::tr//span[(text() or @data-original-text)='" + sku + "']/ancestor::td/following-sibling::td//button)[1]");
    }

    /**
     * Vendor Claim - Search result
     */

    public static Target CLAIM_NUMBER_RESULT(String numberClaim) {
        return Target.the("Claim number " + numberClaim + " in result")
                .locatedBy("//td[contains(@class,'number')]//a[text()='" + numberClaim + "']");
    }

    public static Target VENDOR_COMPANY_RESULT(String numberClaim) {
        return Target.the("Vendor company in result")
                .locatedBy("//td[contains(@class,'number')]//a[text()='" + numberClaim + "']/ancestor::td/following-sibling::td[contains(@class,'vendor-company')]//span");
    }

    public static Target BRAND_RESULT(String numberClaim) {
        return Target.the("Brand in result")
                .locatedBy("//td[contains(@class,'number')]//a[text()='" + numberClaim + "']/ancestor::td/following-sibling::td[contains(@class,'brand')]//span");
    }

    public static Target ISSUE_RESULT(String numberClaim) {
        return Target.the("Issue in result")
                .locatedBy("//td[contains(@class,'number')]//a[text()='" + numberClaim + "']/ancestor::td/following-sibling::td[contains(@class,'issue')]//span");
    }

    public static Target STATUS_RESULT(String numberClaim) {
        return Target.the("Status in result")
                .locatedBy("//td[contains(@class,'number')]//a[text()='" + numberClaim + "']/ancestor::td/following-sibling::td[contains(@class,'status')]/div/div");
    }

    public static Target ASSIGNED_RESULT(String numberClaim) {
        return Target.the("Assigned in result")
                .locatedBy("//td[contains(@class,'number')]//a[text()='" + numberClaim + "']/ancestor::td/following-sibling::td[contains(@class,'assign')]/div/span");
    }

    public static Target INBOUND_RESULT(String numberClaim, String inbound) {
        return Target.the("Inbound in result")
                .locatedBy("//td[contains(@class,'number')]//a[text()='" + numberClaim + "']/ancestor::td/following-sibling::td[contains(@class,'inbound')]//a/span[contains(text(),'" + inbound + "')]");
    }

    public static Target DELETE_RESULT(String numberClaim) {
        return Target.the("Delete button in result")
                .locatedBy("//td[contains(@class,'number')]//a[text()='" + numberClaim + "']/ancestor::td/following-sibling::td[contains(@class,'actions')]//button");
    }

    /**
     * Assigned to
     */
    public static Target ASSIGNED_TO_FIELD(int index) {
        return Target.the("Assigned to")
                .locatedBy("(((//div[@class='assigned-to']//div[contains(@class,'content ')])[" + index + "])/span)[1]");
    }

    public static Target ASSIGNED_TO_REMOVE_BUTTON(int index) {
        return Target.the("Assigned to remove button")
                .locatedBy("(//div[@class='assigned-to']//div[contains(@class,'actions ')]/button)[" + index + "]");
    }
}

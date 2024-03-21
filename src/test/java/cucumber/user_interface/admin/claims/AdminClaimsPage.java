package cucumber.user_interface.admin.claims;

import net.serenitybdd.screenplay.targets.Target;

public class AdminClaimsPage {

    public static Target CLAIMS_SIDEBAR = Target.the("Claims in sidebar")
            .locatedBy("//li//span[text()='Claims']");

    public static Target D_TEXTBOX(String title) {
        return Target.the(title + " textbox")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static Target D_TEXTAREA(String title) {
        return Target.the(title + " textarea")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//textarea");
    }

    public static Target D_ERROR(String title) {
        return Target.the(title + " error message")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//div[contains(@class,'error')]");
    }

    public static Target D_CHECKBOX(String title, String value) {
        return Target.the(title + " textbox")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input[@value='" + value + "']/parent::span");
    }

    public static Target PICTURE_ADDED(String picture) {
        return Target.the(picture + " added")
                .locatedBy("//div[@class='added']//div[text()='" + picture + "']");
    }

    /**
     * Result
     */

    public static Target DATE_RESULT(String order, int index) {
        return Target.the(" Date of claim with order " + order + " index " + index)
                .locatedBy("(//div[text()='" + order + "']/parent::td/preceding-sibling::td[contains(@class,'date')]//span)[" + index + "]");
    }

    public static Target NUMBER_RESULT(String order, int index) {
        return Target.the(" Number of claim with order " + order + " index " + index)
                .locatedBy("(//div[text()='" + order + "']/parent::td/preceding-sibling::td[contains(@class,'number')]//a)[" + index + "]");
    }

    public static Target STORE_RESULT(String order, int index) {
        return Target.the("Store of claim with order " + order + " index " + index)
                .locatedBy("(//div[text()='" + order + "']/parent::td/preceding-sibling::td[contains(@class,'store')]//div)[" + index + "]");
    }

    public static Target BUYER_RESULT(String order, int index) {
        return Target.the("Buyer of claim with order " + order + " index " + index)
                .locatedBy("(//div[text()='" + order + "']/parent::td/preceding-sibling::td[contains(@class,'buyer')]//div)[" + index + "]");
    }

    public static Target ORDER_RESULT(String order, int index) {
        return Target.the("Order of claim with order " + order + " index " + index)
                .locatedBy("(//div[text()='" + order + "'])[" + index + "]");
    }

    public static Target STATUS_RESULT(String order, int index) {
        return Target.the("Status of claim with order " + order + " index " + index)
                .locatedBy("(//div[text()='" + order + "']/parent::td/following-sibling::td[contains(@class,'status')]//div/div)[" + index + "]");
    }

    public static Target ISSUE_RESULT(String order, int index) {
        return Target.the("Issue of claim with order " + order + " index " + index)
                .locatedBy("(//div[text()='" + order + "']/parent::td/following-sibling::td[contains(@class,'issue')]//div)[" + index + "]");
    }

    public static Target DELETE_RESULT(String order) {
        return Target.the("Delete button of claim with order " + order + " index ")
                .locatedBy("(//div[contains(text(),'" + order + "')]/parent::td/following-sibling::td//button)[1]");
    }

    /**
     * Result first row
     */
    public static Target NUMBER_FIRST_RESULT = Target.the("Number in first result")
            .locatedBy("(//td[contains(@class,'number')]//a)[1]");

    public static Target DATE_FIRST_RESULT = Target.the("Date in first result")
            .locatedBy("(//td[contains(@class,'date-submission')]/div/span)[1]");

    public static Target STORE_FIRST_RESULT = Target.the("Store in first result")
            .locatedBy("(//td[contains(@class,'store-name')]/div)[1]");

    public static Target BUYER_FIRST_RESULT = Target.the("Buyer in first result")
            .locatedBy("(//td[contains(@class,'buyer-name')]/div)[1]");

    public static Target ORDER_FIRST_RESULT = Target.the("Buyer in first result")
            .locatedBy("(//td[contains(@class,'order')]/div)[1]");

    public static Target STATUS_FIRST_RESULT = Target.the("Status in first result")
            .locatedBy("(//td[contains(@class,'status')]/div/div)[1]");

    public static Target ISSUE_FIRST_RESULT = Target.the("Issue in first result")
            .locatedBy("(//td[contains(@class,'issue')]/div)[1]");

    /**
     * Claim - Details
     */

    public static Target CLAIM_ID = Target.the("Claim id")
            .locatedBy("//div[@class='title']/span");

    public static Target STORE_NAME_DETAIL = Target.the("Store in general info")
            .locatedBy("//div[@class='link-tag store-name']");

    public static Target BUYER_NAME_DETAIL = Target.the("Buyer in general info")
            .locatedBy("//div[@class='link-tag buyer-name']/span");

    public static Target BUYER_NAME_DETAIL1 = Target.the("Buyer in general info")
            .locatedBy("//dt[text()='Store']/following-sibling::dd//span[contains(@class,'buyer-name')]");

    public static Target BUYER_COMPANY_NAME_DETAIL = Target.the("Buyer company in general info")
            .locatedBy("//div[@class='link-tag buyer-company-name']");

    public static Target ORDER_NUMBER_DETAIL = Target.the("Order number in general info")
            .locatedBy("//div[@class='link-tag order-link number']");

    public static Target SUB_INVOICE_DETAIL = Target.the("Sub invoice in general info")
            .locatedBy("//span[@class='sub-invoice number']");

    public static Target ISSUE_DETAIL = Target.the("Issue in general info")
            .locatedBy("//span[@class='issue']");

    public static Target ISSUE_DESCRIPTION_DETAIL = Target.the("Issue description in general info")
            .locatedBy("(//span[@class='issue-description'])[1]");

    public static Target ISSUE_DESCRIPTION_EMPTY_DETAIL = Target.the("Issue description in general info")
            .locatedBy("//dt[text()='Issue description']/following-sibling::dd//span[text()='Empty']");
    public static Target DATE_SUBMISSION_DETAIL = Target.the("Date submission in general info")
            .locatedBy("//div[@class='date-of-submitssion']");

    public static Target STATUS_DETAIL = Target.the("Status in general info")
            .locatedBy("//div[@class='status-tag']");

    public static Target MANAGER_DETAIL = Target.the("Manager in general info")
            .locatedBy("//div[@class='manager']");

    public static Target ADMIN_NOTE_DETAIL = Target.the("Admin note in general info")
            .locatedBy("(//dt[text()='Admin note']/following-sibling::dd//span)[last()]");

    public static Target PICTURE_DETAIL = Target.the("Picture in details")
            .locatedBy("//div[@class='input']/div");

    public static Target BRAND_DETAIL(int index) {
        return Target.the("Brand of item in affected products")
                .locatedBy("(//a[@class='brand']//span)[" + index + "]");
    }

    public static Target PRODUCT_DETAIL(int index) {
        return Target.the("Product of item in affected products")
                .locatedBy("(//a[@class='product']//span)[" + index + "]");
    }

    public static Target SKU_DETAIL(int index) {
        return Target.the("SKU of item in affected products")
                .locatedBy("(//div[@class='variant']//span)[" + index + "]");
    }

    public static Target SKU_ID_DETAIL(int index) {
        return Target.the("SKU ID of item in affected products")
                .locatedBy("(//div[@class='variant']//following-sibling::div/span)[" + index + "]");
    }

    public static Target QUANTITY_DETAIL(int index) {
        return Target.the("Quantity of item in affected products")
                .locatedBy("(//td[@class='quantity']//input)[" + index + "]");
    }

    public static Target STORE_NAME_EMPTY_DETAIL = Target.the("Store in general info")
            .locatedBy("//dt[text()='Store']/following-sibling::dd//span[text()='Empty']");

    public static Target UPLOAD_PICTURE_INPUT = Target.the("Upload picture input")
            .locatedBy("//div[text()='Select a claim document']/preceding-sibling::input");

    public static Target REMOVE_PICTURE_BUTTON = Target.the("Remove picture button")
            .locatedBy("//div[contains(@class,'claim-documents')]//span[text()='Remove']");

    public static Target DOWNLOAD_PICTURE_BUTTON = Target.the("Download picture button")
            .locatedBy("//div[contains(@class,'claim-documents')]//a");

    public static Target PICTURE_SAVE_BUTTON = Target.the("Picture save button")
            .locatedBy("//div[text()='Pictures']//following-sibling::div//button//span[contains(text(),'Save')]");



    /**
     * Claim - Details - Add item
     */

    public static Target SELECT_ITEM_POPUP = Target.the("Select item popup")
            .locatedBy("//div[@id='global-dialogs']//span[text()='Select item']");

    public static Target SELECT_ITEM_TEXTBOX = Target.the("Select item textbox")
            .locatedBy("//div[@id='global-dialogs']//input");

    public static Target BRAND_IN_POPUP = Target.the("Brand in poup")
            .locatedBy("//div[contains(@x-placement,'bottom-start')]//div[@class='brand']");

    public static Target PRODUCT_IN_POPUP = Target.the("Product in poup")
            .locatedBy("//div[contains(@x-placement,'bottom-start')]//div[@class='product']");

    public static Target SKU_IN_POPUP = Target.the("Sku in poup")
            .locatedBy("//div[contains(@x-placement,'bottom-start')]//div[@class='variant']");

    public static Target SKU_ID_IN_POPUP = Target.the("Sku id in poup")
            .locatedBy("//div[contains(@x-placement,'bottom-start')]//span[@class='item-code-tag']");

    public static Target SKU_IN_POPUP(String sku) {
        return Target.the("Sku in popup")
                .locatedBy("//div[contains(@x-placement,'bottom-start')]//div[text()='" + sku + "']");
    }

    /**
     * Claim - Details - Affected products
     */

    public static Target SKU_ID_AFFECTED(String skuID) {
        return Target.the("Sku id in affected products ")
                .locatedBy("//table//div[contains(@class,'item-code')]/span[text()='" + skuID + "']");
    }

    public static Target SKU_AFFECTED(String skuID) {
        return Target.the("Sku name in affected products ")
                .locatedBy("//span[text()='" + skuID + "']/parent::div/preceding-sibling::div[@class='variant']/span");
    }

    public static Target PRODUCT_AFFECTED(String skuID) {
        return Target.the("Product of sku in affected products ")
                .locatedBy("//span[text()='" + skuID + "']/parent::div/preceding-sibling::a[@class='product']/span");
    }

    public static Target BRAND_AFFECTED(String skuID) {
        return Target.the("Brand of sku in affected products ")
                .locatedBy("//span[text()='" + skuID + "']/parent::div/preceding-sibling::a[@class='brand']/span");
    }

    public static Target QUANTITY_AFFECTED(String skuID) {
        return Target.the("Quantity of sku in affected products ")
                .locatedBy("//span[text()='" + skuID + "']//ancestor::td/following-sibling::td//input");
    }

    public static Target ACTION_AFFECTED(String skuID) {
        return Target.the("Action button of sku in affected products ")
                .locatedBy("//span[text()='" + skuID + "']//ancestor::td/following-sibling::td//button");
    }

    /**
     * Create new claims form
     */
    public static Target STORE_NAME_CREATE_CLAIM = Target.the("Store in create claim")
            .locatedBy("//div[not (@style='display: none;')]/label[text()='Store']/following-sibling::div//span");

    public static Target STORE_NAME_CREATE_CLAIM(String store) {
        return Target.the("Store in create claim")
                .locatedBy("//label[text()='Store']/following-sibling::div/span[text()='" + store + "']");
    }

    public static Target BUYER_COMPANY_CREATE_CLAIM = Target.the("Buyer company in create claim")
            .locatedBy("//div[not (@style='display: none;')]/label[text()='Buyer company']/following-sibling::div//span");

    public static Target AFFECTED_PRODUCT_CHECKBOX(String skuID) {
        return Target.the("Affected products checkbox by skuID " + skuID)
                .locatedBy("//span[text()='" + skuID + "']//ancestor::td/preceding-sibling::td/label[contains(@class,'checkbox')]");
    }

    public static Target AFFECTED_PRODUCT_QUANTITY_TEXTBOX(String skuID) {
        return Target.the("Affected products checkbox by skuID " + skuID)
                .locatedBy("//span[text()='" + skuID + "']//ancestor::td/following-sibling::td//input");
    }

    /**
     * General informarion
     */

    public static Target STORE_GENERAL_INFO = Target.the("Store in general information")
            .locatedBy("//dd//*[contains(@class,'store-name')]");

    public static Target STORE_GENERAL_INFO_LINK = Target.the("Link Store in general information")
            .locatedBy("//dd//*[contains(@class,'store-name')]/a");
    public static Target BUYER_GENERAL_INFO = Target.the("Buyer in general information")
            .locatedBy("//dd//*[contains(@class,'buyer-name')]");

    public static Target BUYER_GENERAL_INFO_LINK = Target.the("Link buyer in general information")
            .locatedBy("//dd//*[contains(@class,'buyer-name')]/a");

    public static Target EMAIL_GENERAL_INFO = Target.the("Email in general information")
            .locatedBy("//dd//*[contains(@class,'buyer-email')]");

    public static Target BUYER_COMPANY_GENERAL_INFO = Target.the("Buyer company in general information")
            .locatedBy("//dd//*[contains(@class,'buyer-company-name')]");

    public static Target BUYER_COMPANY_GENERAL_INFO_LINK = Target.the("Link buyer company in general information")
            .locatedBy("//dd//*[contains(@class,'buyer-company-name')]/a");
    public static Target ORDER_GENERAL_INFO = Target.the("Order number in general information")
            .locatedBy("//dd//*[contains(@class,'order-link')]");

    public static Target SUB_INVOICE_GENERAL_INFO = Target.the("Sub invoice in general information")
            .locatedBy("//dd//*[contains(@class,'sub-invoice')]");

    public static Target ISSUE_GENERAL_INFO = Target.the("Issue in general information")
            .locatedBy("//dt[text()='Issue']/following-sibling::dd//span[@class='issue']");

    public static Target ISSUE_DESCRIPTION_GENERAL_INFO = Target.the("Issue description in general information")
            .locatedBy("//dt[text()='Issue description']/following-sibling::dd//span[@class='issue-description']");

    public static Target DATE_GENERAL_INFO = Target.the("Date of submission in general information")
            .locatedBy("//dd//*[@class='date-of-submitssion']");

    public static Target STATUS_GENERAL_INFO = Target.the("Status in general information")
            .locatedBy("//dd//*[@class='status-tag']");

    public static Target MANAGER_GENERAL_INFO = Target.the("Status in general information")
            .locatedBy("//dd//*[@class='manager']");

    public static Target ADMIN_NOTE_GENERAL_INFO = Target.the("Admin note in general information")
            .locatedBy("//dt[text()='Admin note']/following-sibling::dd//span[@class='issue-description']");

    public static Target PICTURE_GENERAL_INFO = Target.the("Admin note in general information")
            .locatedBy("//div[@class='image']//div[@class='choose ellipsis']");


}

package cucumber.user_interface.beta.Vendor.claims;

import net.serenitybdd.screenplay.targets.Target;

public class VendorClaimsPage {

    /**
     * Create vendor claim
     */
    public static Target NEW_CLAIM_BUTTON = Target.the("New Claim button")
            .locatedBy("(//a//span[contains(text(),'New Claim')])[last()]");

    public static Target ISSUE_TYPE_IN_CREATE(String type) {
        return Target.the("Issue type " + type + " in create")
                .locatedBy("//label[text()='Issue Type']/following-sibling::div//span[text()='" + type + "']");
    }

    public static Target CREATE_CLAIM_PAGE_TITLE = Target.the("Create claim page title")
            .locatedBy("//h1[@class='page__title' and text()='Request Claim']");


    public static Target D_TEXTBOX_ERROR(String title) {
        return Target.the("Textbox " + title + " error message")
                .locatedBy("//label[text()='" + title + "']/following-sibling::div/div[contains(@class,'error')]");
    }

    public static Target D_TEXTBOX_CREATE(String value) {
        return Target.the("Textbox " + value + " error message")
                .locatedBy("//label[text()='" + value + "']/following-sibling::div//input");
    }

    public static Target D_TEXTAREA_CREATE(String value) {
        return Target.the("Textarea " + value + " error message")
                .locatedBy("//label[text()='Additional Notes']/following-sibling::div//textarea");
    }


    public static Target REMOVE_BUTTON_UPLOAD_IN_CREATE = Target.the("Remove button upload file in create")
            .locatedBy("//div[contains(text(),'Upload files')]/following-sibling::div//button");

    public static Target UPLOAD_IN_CREATE = Target.the("Upload in create")
            .locatedBy("//div[contains(text(),'Upload files')]/following-sibling::div//input");

    public static Target MESSAGE_CREATE_SUCCESS(String message) {
        return Target.the("Message create success")
                .locatedBy("//div[@role='alert']//*[text()=\"" + message + "\"]");
    }

    public static Target HELP_TEXT = Target.the("Note help text")
            .locatedBy("//div[@class='notes-help-text']");

    public static Target HERE_LINK = Target.the("Link here after create")
            .locatedBy("//div[@role='alert']//a[text()='here.']");

    /**
     * Create vendor claim - sku
     */

    public static Target TYPE_VALUE_IN_CREATE(String value) {
        return Target.the("Type with value " + value + "")
                .locatedBy("//label[text()='Please tell us more details (Optional)']/following-sibling::div//span[contains(text(),'" + value + "')]");
    }

    public static Target SKU_ITEM_IN_CREATE(String sku) {
        return Target.the("SKU " + sku + " added in create")
                .locatedBy("//div[@class='claim__skus']//span[text()='" + sku + "']");
    }

    public static Target BRAND_SKU_ITEM_IN_CREATE(String sku) {
        return Target.the("Brand of SKU " + sku + " added in create")
                .locatedBy("//div[@class='claim__skus']//span[text()='" + sku + "']/parent::div/preceding-sibling::div[@class='brand']//span");
    }

    public static Target PRODUCT_SKU_ITEM_IN_CREATE(String sku) {
        return Target.the("Product of SKU " + sku + " added in create")
                .locatedBy("//div[@class='claim__skus']//span[text()='" + sku + "']/parent::div/preceding-sibling::div[@class='product']//span");
    }

    public static Target SKU_ID_ITEM_IN_CREATE(String sku) {
        return Target.the("ID of " + sku + " added in create")
                .locatedBy("//div[@class='claim__skus']//span[text()='" + sku + "']/parent::div/following-sibling::div[contains(@class,'variant__id')]");
    }

    public static Target SKU_QUANTITY_TEXTBOX_IN_CREATE(String sku) {
        return Target.the("Textbox quantity of SKU " + sku + " added in create")
                .locatedBy("//div[@class='claim__skus']//span[text()='" + sku + "']/ancestor::div/div[contains(@class,'quantity')]//input");
    }

    public static Target DELETE_SKU_IN_CREATE(String sku) {
        return Target.the("Delete button " + sku + " added in create")
                .locatedBy("//div[@class='claim__skus']//span[text()='" + sku + "']/ancestor::div/div[contains(@class,'actions')]//button");
    }

    /**
     * Create vendor claim - order
     */
    public static Target ORDER_NUMBER_IN_DETAIL(String order) {
        return Target.the("Order number in detail")
                .locatedBy("//div[@class='claim__orders']//strong[contains(text(),'" + order + "')]");
    }

    public static Target BRAND_IN_ORDER_IN_DETAIL(String order, String sku) {
        return Target.the("Brand of line item in order in detail")
                .locatedBy("(//div[@class='claim__orders']//strong[contains(text(),'" + order + "')]/ancestor::div/following-sibling::div//span[text()='" + sku + "']/parent::div/preceding-sibling::div[@class='brand']//span)[1]");
    }

    public static Target PRODUCT_IN_ORDER_IN_DETAIL(String order, String sku) {
        return Target.the("Product of line item in order in detail")
                .locatedBy("(//div[@class='claim__orders']//strong[contains(text(),'" + order + "')]/ancestor::div/following-sibling::div//span[text()='" + sku + "']/parent::div/preceding-sibling::div[@class='product']//span)[1]");
    }

    public static Target SKU_IN_ORDER_IN_DETAIL(String order, String sku) {
        return Target.the("SKU of line item in order in detail")
                .locatedBy("(//div[@class='claim__orders']//strong[contains(text(),'" + order + "')]/ancestor::div/following-sibling::div//span[text()='" + sku + "'])[1]");
    }

    public static Target SKU_ID_IN_ORDER_IN_DETAIL(String order, String sku) {
        return Target.the("SKU ID of line item in order in detail")
                .locatedBy("(//div[@class='claim__orders']//strong[contains(text(),'" + order + "')]/ancestor::div/following-sibling::div//span[text()='" + sku + "']/parent::div/following-sibling::div[contains(@class,'variant__id')])[1]");
    }

    public static Target QUANTITY_IN_ORDER_IN_DETAIL(String order, String sku) {
        return Target.the("Quantity of line item in order in detail")
                .locatedBy("(//div[@class='claim__orders']//strong[contains(text(),'" + order + "')]/ancestor::div/following-sibling::div//span[text()='" + sku + "']/ancestor::div/following-sibling::div[contains(@class,'quantity')]//input)[1]");
    }

    public static Target DELETE_ORDER_IN_CREATE(String order) {
        return Target.the("Delete button " + order + " added in create")
                .locatedBy("(//div[@class='claim__orders']//strong[contains(text(),'" + order + "')]/ancestor::div/following-sibling::div[contains(@class,'actions')]/button)[1]");
    }

    /**
     * Select line item - popup sku
     */
    public static Target SELECT_LINE_ITEM_POPUP = Target.the("Select line item popup")
            .locatedBy("//div[@role='dialog']//span[contains(text(),'Select SKUs')]");

    public static Target TEXTBOX_IN_SELECT_LINE_ITEM_POPUP = Target.the("Textbox search in Select line item popup")
            .locatedBy("//div[@role='dialog']//input");

    public static Target ITEM_IN_SELECT_LINE_ITEM_POPUP(String sku) {
        return Target.the("Item " + sku + " in Select line item popup")
                .locatedBy("//div[@class='sku']//div[contains(@class,'sku__name') and text()='" + sku + "']");
    }

    public static Target ITEM_IN_SELECT_NOT_ADDED(String sku) {
        return Target.the("Item " + sku + " in Select line item popup can not added")
                .locatedBy("//div[contains(@class,'sku--excluded')]//div[contains(text(),'" + sku + "')]");
    }

    /**
     * Select line item - popup order
     */
    public static Target ADD_NEW_ORDERS = Target.the("Add new orders popup")
            .locatedBy("//div[@role='dialog']//span[contains(text(),'Add new orders')]");

    public static Target ORDER_IN_ADD_NEW_ORDERS_POPUP(String order) {
        return Target.the("Order " + order + " in Select line item popup")
                .locatedBy("//div[@class='records']//div[@class='claim__orders__item__number']//div[@class='claim__orders__item__value' and contains(text(),'" + order + "')]");
    }

    public static Target LINE_ITEM_SKU_IN_ADD_NEW_ORDERS_POPUP(String sku) {
        return Target.the("SKU of line item in add new order popup")
                .locatedBy("//div[@class='claim__orders__item__skus__item']//span[text()='" + sku + "']");
    }

    public static Target LINE_ITEM_BRAND_IN_ADD_NEW_ORDERS_POPUP(String sku) {
        return Target.the("Brand of line item in add new order popup")
                .locatedBy("//div[@class='claim__orders__item__skus__item']//span[text()='" + sku + "']/parent::div/preceding-sibling::div[@class='brand']//span");
    }

    public static Target LINE_ITEM_PRODUCT_IN_ADD_NEW_ORDERS_POPUP(String sku) {
        return Target.the("Product of line item in add new order popup")
                .locatedBy("//div[@class='claim__orders__item__skus__item']//span[text()='" + sku + "']/parent::div/preceding-sibling::div[@class='product']//span");
    }

    public static Target LINE_ITEM_SKU_ID_IN_ADD_NEW_ORDERS_POPUP(String sku) {
        return Target.the("SKU id of line item in add new order popup")
                .locatedBy("(//div[@class='claim__orders__item__skus__item']//span[text()='" + sku + "']/parent::div/following-sibling::div)[1]");
    }

    public static Target LINE_ITEM_QUANTITY_IN_ADD_NEW_ORDERS_POPUP(String sku) {
        return Target.the("Quantity of line item in add new order popup")
                .locatedBy("//div[@class='claim__orders__item__skus__item']//span[text()='" + sku + "']/ancestor::div/following-sibling::div[contains(@class,'quantity')]//div[@class='value']");
    }

    public static Target ITEM_IN_ADD_ORDER_POPUP_NOT_ADDED(String order) {
        return Target.the("Item " + order + " in Select add order popup can not added")
                .locatedBy("//div[contains(@class,'orders__item--excluded')]//div[contains(text(),'" + order + "')]");
    }

    /**
     * Select line item - popup order
     */
    public static Target ADD_NEW_INBOUND_INVENTORIES = Target.the("Add new inbound popup")
            .locatedBy("//div[@role='dialog']//span[contains(text(),'Add new inbound inventories')]");

    /**
     * Claim Detail
     */

    public static Target NUMBER_CLAIM = Target.the("Number claim in detail")
            .locatedBy("//h1[@class='page__title']");


    public static Target ISSUE_TYPE_SELECTED_IN_DETAIL(String value) {
        return Target.the("Issue type selected in detail")
                .locatedBy("//span[contains(@class,'checked')]//input[@value='" + value + "']");
    }

    public static Target TYPE_SELECTED_IN_DETAIL(String value) {
        return Target.the("Type selected in detail")
                .locatedBy("//span[contains(@class,'checked')]//input[contains(@value,'" + value + "')]");
    }

    /**
     * Claim Detail - Resolved
     */

    public static Target STATUS_RESOLVED_IN_DETAIL = Target.the("Status of claim resolve")
            .locatedBy("//div[@class='status']//div[contains(@class,'status-tag')]");

    public static Target ISSUE_TYPE_RESOLVED_IN_DETAIL(String value) {
        return Target.the("Issue type of claim resolve")
                .locatedBy("//label[text()='Issue Type']/following-sibling::div//span[contains(@class,'is-disabled is-checked')]//input[@value='" + value + "']");
    }

    public static Target TYPE_RESOLVED_IN_DETAIL(String value) {
        return Target.the("Type of claim resolve")
                .locatedBy("//label[text()='Please tell us more details (Optional)']/following-sibling::div//span[contains(@class,'is-disabled is-checked')]//input[@value='" + value + "']");
    }

    public static Target REGION_RESOLVED_IN_DETAIL = Target.the("Region of claim resolve")
            .locatedBy("//label[text()='Select Express Region']/following-sibling::div//input[@disabled='disabled']");

    public static Target ADDITIONAL_NOTE_RESOLVED_IN_DETAIL = Target.the("Additional note of claim resolve")
            .locatedBy("//label[text()='Additional Notes']/following-sibling::div//textarea[@disabled='disabled']");

    public static Target ADD_FILE_RESOLVED_IN_DETAIL = Target.the("Add file button of claim resolve")
            .locatedBy("//button[@disabled='disabled']//span[text()='Add a file']");

    public static Target UPDATE_RESOLVED_IN_DETAIL = Target.the("Update button of claim resolve")
            .locatedBy("//button[@disabled='disabled']//span[text()='Update']");
    /**
     * Claim Detail - upload file
     */

    public static Target UPLOADED_FILE_IN_DETAIL(String index) {
        return Target.the("Uploaded file in detail")
                .locatedBy("(//div[contains(@class,'claim-image-card')]//div[contains(@class,'file-name')])[" + index + "]");
    }

    /**
     * List Claim Detail
     */

    public static Target NUMBER_CLAIM_RESULT(String number) {
        return Target.the("Number of claim result")
                .locatedBy("//div[contains(@class,'number')]/div[contains(text(),'" + number + "')]");
    }

    public static Target SUBMITTED_CLAIM_RESULT(String number) {
        return Target.the("Submitted of claim result")
                .locatedBy("//div[contains(text(),'" + number + "')]/parent::div/preceding-sibling::div/span");
    }

    public static Target BRAND_CLAIM_RESULT(String number) {
        return Target.the("Brand of claim result")
                .locatedBy("//div[contains(text(),'" + number + "')]/parent::div/following-sibling::div[contains(@class,'brand')]/span");
    }

    public static Target REGION_CLAIM_RESULT(String number) {
        return Target.the("Region of claim result")
                .locatedBy("(//div[contains(text(),'" + number + "')]/parent::div/following-sibling::div[contains(@class,'region')]/div)[2]");
    }

    public static Target STATUS_CLAIM_RESULT(String number) {
        return Target.the("Status of claim result")
                .locatedBy("//div[contains(text(),'" + number + "')]/parent::div/following-sibling::div//div[@class='status-tag']");
    }

}

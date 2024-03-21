package cucumber.user_interface.beta.Vendor.inventory;


import net.serenitybdd.screenplay.targets.Target;

public class VendorInventoryPage {

    public static Target DYNAMIC_TAB(String tabName) {
        return Target.the("Tab " + tabName)
//                .locatedBy("//div[contains(@class,'dashboard-content')]//*[text()='" + tabName + "']");
                .locatedBy("//div[contains(@class,'entity-header')]//*[text()='" + tabName + "']");
    }

    public static Target DYNAMIC_TAB1(String tabName) {
        return Target.the("Tab " + tabName)
//                .locatedBy("//div[contains(@class,'dashboard-content')]//*[text()='" + tabName + "']");
                .locatedBy("//a[text()='" + tabName + "']");
    }

    public static Target DYNAMIC_TAB_HEADER(String tabName) {
        return Target.the("Tab " + tabName)
                .locatedBy("//div[contains(@class,'dashboard-content')]//a[text()='" + tabName + "']");
    }

    public static Target ALL_INVENTORY = Target.the("All Inventory page")
            .locatedBy("//a[contains(text(),'All Inventory')]");

    public static Target SEND_INVENTORY = Target.the("Send Inventory page")
            .locatedBy("//a[contains(text(),'Send Inventory')]");

    public static Target NEW_INBOUND_INVENTORY = Target.the("New Inbound inventory page")
            .locatedBy("//span[normalize-space()='New Inbound Inventory']");

    public static Target POD_INBOUND_REFERENCE = Target.the("NEW_INBOUND_INVENTORY")
            .locatedBy("//a[@class='edt-row record']//div[@class='edt-piece number']/div[2]");

    public static Target POD_INBOUND_REFERENCE(String class_, int i) {
        return Target.the("NEW_INBOUND_INVENTORY")
                .locatedBy("(//a[@class='edt-row record']//div[@class='edt-piece " + class_ + "']/div[2])[" + i + "]");
    }

    public static Target POD_INBOUND_REFERENCE_BY_ID(String id) {
        return Target.the("Inbound inventory by id")
                .locatedBy("//div[@class='edt-piece number']//div[contains(text(),'" + id + "')]");
    }

    public static Target POD_INBOUND_REFERENCE(String i) {
        return Target.the("NEW_INBOUND_INVENTORY")
                .locatedBy("(//a[@class='edt-row record']//div[@class='edt-piece number']/div[text()='#" + i + "'])");
    }

    public static Target REGION_SEARCH = Target.the("REGION")
            .locatedBy("//label[contains(text(),'Region')]//following-sibling::div//input");

    public static Target REGION(String id) {
        return Target.the("REGION")
                .locatedBy("//div[contains(text(),'" + id + "')]//parent::div/following-sibling::div[contains(@class,'region')]/div[2]");
    }

    public static Target ETA = Target.the("ETA")
            .locatedBy("//a[@class='edt-row record']//div[@class='edt-piece eta']/div[2]");

    public static Target ETA(String id) {
        return Target.the("ETA")
                .locatedBy("//div[contains(text(),'" + id + "')]//parent::div/following-sibling::div[contains(@class,'eta')]/div[2]");
    }

    public static Target STATUS = Target.the("STATUS")
            .locatedBy("//div[@class='status-tag has-tooltip']");

    public static Target STATUS(String id) {
        return Target.the("STATUS")
                .locatedBy("//div[contains(text(),'" + id + "')]//parent::div/following-sibling::div[contains(@class,'status')]//div[contains(@class,'status')]");
    }

    public static Target GENERAL_INSTRUCTIONS_BUTTON = Target.the("General Instructions")
            .locatedBy("//div[@class='page__actions']//span[normalize-space()='General Instructions']");

    public static Target CONFIRM_GENERAL_INSTRUCTIONS = Target.the("Confirm General Instructions")
            .locatedBy("//span[normalize-space()='Confirm']");

    public static Target GENERAL_INSTRUCTIONS_POPUP = Target.the("General Instructions")
            .locatedBy("//div[@aria-label='dialog']//div[@class='el-dialog__body']");

    public static Target INSTRUCTIONS_OF_REGIONS = Target.the("General Instructions")
            .locatedBy("//div[@class='el-alert__content']");

    public static Target SELECT_REGION = Target.the("Select express region")
            .locatedBy("//div[contains(@class,'region-select')]//input");

    public static Target SELECT_INBOUND_DELIVERY_METHOD = Target.the("Select delivery method")
            .locatedBy("//div[contains(@class,'inbound-delivery-method')]//input");

    /**
     * Inbound inventory detail page
     */
    public static Target DYNAMIC_TEXTBOX(String value) {
        return Target.the(value)
                .locatedBy("//div[contains(@class,'" + value + "')]//input");
    }

    public static Target DYNAMIC_TEXTBOX2(String value) {
        return Target.the(value)
                .locatedBy("//label[contains(text(),'" + value + "')]/following-sibling::div//input");
    }

    public static Target STATUS_IN_DETAIL(String status) {
        return Target.the("Status of inbound inventory")
                .locatedBy("//div[text()='" + status + "']");
    }

    public static Target TOTAL_SELLABLE_RETAIL_CASE_LABEL = Target.the("Total # of Sellable Retail Cases")
            .locatedBy("//span[text()='Total # of Sellable Retail Cases']/parent::div/following-sibling::div/strong");

    public static Target TRACKING_NUMBER = Target.the("TRACKING_NUMBER")
            .locatedBy("//div[normalize-space()='Tracking Number:']/following-sibling::div[@class='value']");

    public static Target MASTER_CARTONS_LABEL = Target.the("Total # Master Cartons")
            .locatedBy("//span[text()='# of Master Cartons']/parent::div/following-sibling::div/strong");

    public static Target ESTIMATE_ARRIVAL = Target.the("Estimatied Date of Arrival")
            .locatedBy("//span[text()='Estimated Date of Arrival']/parent::label/following-sibling::div//input");

    public static Target UPLOAD_BOL = Target.the("upload-bol")
            .locatedBy("//input[@type='file']");
    public static Target UPLOADED_BOL = Target.the("upload-bol")
            .locatedBy("//input[@type='file']/following-sibling::div");
    public static Target UPLOAD_POD = Target.the("upload-bol")
            .locatedBy("(//input[@type='file'])[2]");
    public static Target UPLOADED_POD = Target.the("upload-bol")
            .locatedBy("(//input[@type='file'])[2]/following-sibling::div");

    public static Target NAME = Target.the("Transportation Coordinator contact name")
            .locatedBy("//div[@class='el-form-item boxed transport-coordinator-name']//input[@type='text']");

    public static Target PHONE_NUMBER = Target.the("Transportation Coordinator contact phone number")
            .locatedBy("//div[@class='el-form-item boxed transport-coordinator-phone is-success']//input[@type='text']");

    public static Target PALLET_STACKABLE_IN_TRANSIT(String value) {
        return Target.the("Pallet stackable in transit check")
                .locatedBy("//div[contains(@class,'transit-stackable')]//span[contains(text(),'" + value + "')]/parent::label");
    }

    public static Target PALLET_STACKABLE_IN_WAREHOUSE(String value) {
        return Target.the("Pallet stackable in warehouse check")
                .locatedBy("//div[contains(@class,'warehouse-stackable')]//span[contains(text(),'" + value + "')]/parent::label");
    }

    public static Target ADD_SKUS = Target.the("Add a SKUs")
            .locatedBy("//button//span[contains(text(),'Add SKUs')]");

    public static Target SELECT_SKUs = Target.the("Add a SKUs")
            .locatedBy("//input[@placeholder='Type in SKU name or brand name here to search']");

    public static Target SKU_NAME = Target.the("Add a SKUs")
            .locatedBy("//div[@class='sku__name pf-ellipsis']");

    public static Target ADD_SELECTED_SKUS = Target.the("Add a SKUs button")
            .locatedBy("//form[@class='el-form']//button");

    public static Target CASE_OF_SKU = Target.the("of case of SKU")
            .locatedBy("//div[@class='pf-expanded el-input']//input[@type='number']");

    public static Target SKU_HEADER = Target.the("of case of SKU")
            .locatedBy("//div[text()='SKUs']");

    public static Target CASE_OF_SKU(String sku, String index) {
        return Target.the("of case of SKU")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/ancestor::div[@class='sku']//div[contains(@class,'sku__quantity')]//input[@type='number'])[" + index + "]");
    }

    public static Target TEMPERATURE(String sku, String index) {
        return Target.the("of case of SKU")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/ancestor::div[@class='sku']//div[@class='sku__temperature-range'])[" + index + "]");
    }
    public static Target SHELF_LIFE(String sku, String index) {
        return Target.the("of case of SKU")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/ancestor::div[@class='sku']//div[@class='sku__shelf-life'])[" + index + "]");
    }

    public static Target PRODUCT_LOT_CODE_OF_SKU = Target.the("product lot code of SKU")
            .locatedBy("//div[@class='el-form-item boxed sku__lot-code is-error is-required']//input[@type='text']");

    public static Target PRODUCT_LOT_CODE_OF_SKU(String sku, String index) {
        return Target.the("product lot code of SKU")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/ancestor::div[@class='sku']//div[contains(@class,'sku__lot-code')]//input[@type='text'])[" + index + "]");
    }

    public static Target EXPIRY_DATE = Target.the("expire date of SKU")
            .locatedBy("//div[@class='el-form-item boxed sku__expiry-date is-success is-required']//input");

    public static Target EXPIRY_DATE(String sku, String index) {
        return Target.the("expire date of SKU")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/ancestor::div[@class='sku']//div[contains(@class,'sku__expiry-date')]//input)[" + index + "]");
    }

    public static Target FINAL_INSTRUCTIONS_POPUP = Target.the("Final instruction popup")
            .locatedBy("//div[@class='el-message-box final-instructions-msgbox']");

    public static Target INVENTORY_ID = Target.the("Inventory id")
            .locatedBy("//div[contains(@class,'page__shelf')]//h1");

    public static Target CREATE_ALERT = Target.the("Alert")
            .locatedBy("//div[@role='alert']");

    public static Target CREATE_INVENTORY = Target.the("Create button")
            .locatedBy("//div[@class='page vendors inventories inbound']//span[normalize-space()='Create']");

    public static Target UPDATE_INVENTORY = Target.the("Update button")
            .locatedBy("//button[@class='el-button el-button--primary']");

    public static Target UPDATE_INVENTORY_SUCCESS = Target.the("Update button")
            .locatedBy("//p[text()='Inbound inventory updated successfully']");

    public static Target CONFIRM_FINAL_INSTRUCTIONS = Target.the("Confirm FINAL Instructions")
            .locatedBy("//span[normalize-space()='Confirm']");

    public static Target STATUS_IN_CREATE_PAGE = Target.the("Confirm FINAL Instructions")
            .locatedBy("//div[@class='status-tag bordered']");

    public static Target LOADING = Target.the("Loading icon")
            .locatedBy("//div[@class='loading no-padding']//div[@class='loading--indicator']");

    public static Target BRAND_LABEL(String skuName, String index) {
        return Target.the("Brand label")
                .locatedBy("(//span[contains(text(),'" + skuName + "')]/parent::div/preceding-sibling::div[@class='brand']//span)[" + index + "]");
    }

    public static Target SELLABLE_RETAIL_CASES = Target.the("Total # of Sellable Retail Cases").locatedBy("//div[contains(@class,'num-of-sellable-retail-case')]//div[@class='value']");

    public static Target PRODUCT_LABEL(String skuName, String index) {
        return Target.the("Product label")
                .locatedBy("(//span[contains(text(),'" + skuName + "')]/parent::div/preceding-sibling::div[@class='product']//span)[" + index + "]");
    }

    public static Target SKU_LABEL(String skuName, String index) {
        return Target.the("SKU label")
                .locatedBy("(//div[@class='variant']//span[contains(text(),'" + skuName + "')])[" + index + "]");
    }

    public static Target NUMBER_INBOUND_IN_RESULT(String idInbound) {
        return Target.the("Number inbound in result")
                .locatedBy("//div[@class='edt-piece number']//div[contains(text(),'" + idInbound + "')]");
    }

    public static Target LOADING_NO_PADDING = Target.the("Loading icon")
            .locatedBy("//div[@class='loading--indicator']");

    public static Target MESSAGE_SUCCESS = Target.the("Message success")
            .locatedBy("//p[contains(text(),'Inbound inventory created successfully')]");

    //Popup confirm add same SKU
    public static Target POPUP_CONFIRM_SAME_SKU_BUTTON = Target.the("Popup confirm same sku button")
            .locatedBy("//button//span[contains(text(),'Yes')]");

    // Error message in field
    public static Target D_ERROR_MESSAGE(String value) {
        return Target.the("Message error in field " + value)
                .locatedBy("//div[contains(@class,'" + value + "')]//div[contains(text(),'This field cannot be blank')]");
    }

    public static Target SKU_ERROR_MESAGE = Target.the("Sku error message")
            .locatedBy("//div[contains(text(),'Please select at least 1 SKU')]");

    /**
     * Inventory status
     */
    public static Target INVENTORY_STATUS_HELP_POPUP(String value) {
        return Target.the("Message error in field " + value)
                .locatedBy("//span[text() = '" + value + "']/following-sibling::i");
    }

}

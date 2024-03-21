package cucumber.user_interface.admin.inventory;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class IncomingInventoryDetailPage {

    public static Target GENERAL_INFOMATION_HEADER = Target.the("General information header")
            .locatedBy("//div[text()='General Information']");

    public static Target CANCEL_REQUEST_DETAIL = Target.the("Cancel request button")
            .locatedBy("//div[@class='page-header']//button//span[text()='Cancel']");

    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector("div.el-loading-mask"));

    public static Target REGION_FIELD = Target.the("Region field")
            .located(By.cssSelector("span.region"));

    public static Target DELIVERY_METHOD = Target.the("Delivery method field")
            .locatedBy("//span[@class='delivery-method']/parent::div");

    public static Target DELIVERY_METHOD_FIELD = Target.the("Delivery method field")
            .locatedBy("//dt[text()='Inbound Delivery Method']/following-sibling::dd//span");

    public static Target REGION_POPPER = Target.the("The region popper")
            .located(By.cssSelector("div.popper-region-select"));

    public static Target VENDOR_COMPANY = Target.the("The vendor company")
            .located(By.cssSelector("span.company"));

    public static Target STATUS = Target.the("The status")
            .located(By.cssSelector("div.status-tag.incoming-status"));

    public static Target ETA = Target.the("The Estimated Date of Arrival")
            .located(By.cssSelector("span.eta"));

    public static Target ETW = Target.the("Estimated Weeks of Inventory")
            .located(By.cssSelector(".est-covered-period"));

    public static Target OF_PALLET = Target.the("The of Pallets")
            .located(By.cssSelector("span.num-of-pallet"));

    public static Target OF_SELLABLE_RETAIL = Target.the("Total # of Sellable Retail Cases")
            .located(By.cssSelector("span.num-of-sellable-retail-case"));

    public static Target OF_MASTER_CARTON = Target.the("The of Master Cartons")
            .located(By.cssSelector("span.num-of-master-carton"));

    public static Target OF_SELLABLE_RETAIL_MASTER_CARTON = Target.the("The of Sellable Retail Cases per Master Carton")
            .located(By.cssSelector("span.num-of-retail-master-carton"));

    public static Target ZIP_CODE = Target.the("ZIP CODE")
            .located(By.cssSelector("span.zip-code"));

    public static Target ESTIMATED_WEEK = Target.the("Estimated weeks of inventory")
            .located(By.cssSelector("span.est-covered-period"));

    public static Target TRACKING_NUMBER = Target.the("TRACKING NUMBER")
            .located(By.cssSelector("span.tracking-number"));

    public static Target WAREHOUSE_FIELD = Target.the("Warehouse Field")
            .located(By.cssSelector("span.warehouse"));

    public static Target ESTIMATED_ARRIVAL_DATE_FIELD = Target.the("Estimated Arrival Date")
            .located(By.cssSelector("span.eta"));

    public static Target PROCESS_BUTTON = Target.the("Process button")
            .located(By.xpath("//span[normalize-space()='Process']"));

    public static Target APPROVE_BUTTON = Target.the("approve button")
            .located(By.xpath("//span[normalize-space()='Approve']"));

    public static Target SUBMITED_BUTTON = Target.the("Submited button")
            .located(By.xpath("//span[normalize-space()='Approve']"));

    public static Target OK_BUTTON = Target.the("OK button")
            .located(By.xpath("//span[normalize-space()='OK']"));

    public static Target MESSAGE_SUCCSESS = Target.the("message success")
            .located(By.xpath("//div[@class='el-notification__content']"));

    public static Target UPDATE_WAREHOUSE = Target.the("Update ware house button")
            .located(By.xpath("//div[@aria-hidden='false']//div[@class='actions']//button[@type='button'][normalize-space()='Update']"));

    public static Target UPDATE_SELECT = Target.the("Process button")
            .located(By.xpath("//div[@class='el-select entity-select region-warehouse-select']//input"));

    public static Target ALL_FIELD_DISABLE = Target.the("Process button")//except Admin note
            .located(By.xpath("//div[@class='inline-editor']"));

    public static Target POD_SUGGESTED_BUTTON = Target.the("Pod Suggested button")
            .located(By.cssSelector("div.status-tag.incoming-status"));

    public static Target WAREHOUSE_FIELD1 = Target.the("Pod Suggested button")
            .locatedBy("//dt[text()='Warehouse']/following-sibling::dd");

    public static Target WAREHOUSE_DROPDOWN = Target.the("Pod Suggested button")
            .locatedBy("//div[contains(@class,'region-warehouse')]//input");
    public static Target BOL_UPLOAD_FIELD = Target.the("BOL File")
            .locatedBy("(//dt[text()='BOL']/following-sibling::dd//div[@class='documents']//input)[1]");

    public static Target BOL_NAME = Target.the("BOL File")
            .locatedBy("(//dt[text()='BOL']/following-sibling::dd//div[@class='documents']//div[input]/div)[1]");
    public static Target POD_UPLOAD_FIELD = Target.the("POD File")
            .locatedBy("(//dt[text()='POD']/following-sibling::dd//div[@class='documents']//input)[1]");
    public static Target POD_NAME = Target.the("POD File")
            .locatedBy("(//dt[text()='POD']/following-sibling::dd//div[@class='documents']//div[input]/div)[1]");
    // Popup confirm approve incoming inventory
    public static Target POPUP_CONFIRM_APPROVE = Target.the("Popup confirm approve")
            .locatedBy(" //p[text()='Are you sure that you want to approve this incoming inventory?']");
    public static Target UPDATE_REQUEST = Target.the("Update Request button")
            .located(By.cssSelector("header.el-header .actions button.submit.el-button--default"));
    public static Target VENDOR_COMPANY_FIELD = Target.the("Vendor company field")
            .located(By.cssSelector("span.company"));
    public static Target SUBMIT_INVENTORY_BUTTON = Target.the("Update status submit inventory")
            .located(By.xpath("//button[text()='Update']"));
    // SKU
    public static Target SKU_BRAND(String sku, String index) {
        return Target.the("").locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/preceding-sibling::div[@class='brand']/div)[" + index + "]");
    }

    public static Target SKU_PRODUCT(String sku, String index) {
        return Target.the("").locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/preceding-sibling::div[@class='product']/div)[" + index + "]");
    }

    public static Target SKU_NAME(String sku, String index) {
        return Target.the("").locatedBy("(//span[contains(text(),'" + sku + "')])[" + index + "]");
    }

    public static Target SKU_LOTCODE(String sku, String index) {
        return Target.the("").locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div//div[contains(@class,'lot-code')]/input)[" + index + "]");
    }

    public static Target SKU_OF_CASE(String sku, String index) {
        return Target.the("").locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div/div/label[contains(@for,'.quantity')]/following-sibling::div//input)[" + index + "]");
    }

    public static Target SKU_INFO(String sku, String _class, String index) {
        return Target.the("").locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div[@class='variant']/following-sibling::div[contains(@class,'" + _class + "')])[" + index + "]");
    }

    public static Target SKU_EXPIRATION_DATE(String sku, String index) {
        return Target.the("")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div//div[contains(@class,'expiry-date')]/input)[" + index + "]");
    }

    public static Target SKU_RECEIVE_DATE(String sku, String index) {
        return Target.the("")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div//div[contains(@class,'receive-date')]/input)[" + index + "]");
    }

    public static Target BADGE_SKU(String skuName) {
        return Target.the("Badge of sku of " + skuName)
                .locatedBy("//span[contains(text(),'" + skuName + "')]/ancestor::div//following-sibling::div//span[text()='Below 75%']");
    }

    public static Target SKU_STORAGE_SHELF_LIFE(String sku, String index) {
        return Target.the("Storage shelf life of sku")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div//div[contains(@class,'storage-shelf-life')]/input)[" + index + "]");
    }

    public static Target SKU_STORAGE_SHELF_LIFE_CONDITION(String sku, String index) {
        return Target.the("Storage shelf life of sku")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div//div[contains(@class,'product-shelf-life-condition')]//input)[" + index + "]");
    }

    public static Target SKU_TEMPERATURE(String sku, String index) {
        return Target.the("Temperature of sku")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div//div[contains(@class,'temperature')]/input)[" + index + "]");
    }

    public static Target SKU_TEMPERATURE_CONDITION(String sku, String index) {
        return Target.the("Temperature of sku")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div//div[contains(@class,'temperature')]//span)[" + index + "]");
    }

    public static Target SKU_SUGGEST_CASE(String sku, String index) {
        return Target.the(" # of originally suggested cases of SKU")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div//label[contains(@for,'original_suggested')]/following-sibling::div//input)[" + index + "]");
    }

    public static Target SKU_DAMAGED_CASE(String sku, String index) {
        return Target.the("# of Damaged Cases")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div//label[contains(@for,'damaged_case')]/following-sibling::div//input)[" + index + "]");
    }

    public static Target SKU_EXCESS_CASE(String sku, String index) {
        return Target.the("# of Excess Cases")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div//label[contains(@for,'excess_case')]/following-sibling::div//input)[" + index + "]");
    }

    public static Target SKU_SHORTED_CASE(String sku, String index) {
        return Target.the("# of Shorted Cases")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div//label[contains(@for,'shorted_case')]/following-sibling::div//input)[" + index + "]");
    }

    public static Target SKU_RECEIVED_CASE(String sku, String index) {
        return Target.the("# of Cases Received")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div//label[contains(@for,'received_case')]/following-sibling::div//input)[" + index + "]");
    }

    public static Target NOTE(String sku, String index) {
        return Target.the("# Note")
                .locatedBy("(//span[contains(text(),'" + sku + "')]/parent::div/parent::div/following-sibling::div//label[contains(@for,'comment')]/following-sibling::div//textarea)[" + index + "]");
    }

    public static Target REDIRECT_SKU(String value) {
        return Target.the("").locatedBy("//*[contains(text(),'" + value + "')]/parent::div//a");
    }

    // ADD SKU Popup

    public static Target ADD_LINE_ITEM_BUTTON = Target.the("Add Line Item button")
            .located(By.cssSelector("button.add-line-item.el-button--default"));

    public static Target ADD_SKU_BUTTON = Target.the("Add Sku Button")
            .located(By.cssSelector("button.el-button.add-sku"));

    public static Target INPUT_SKU = Target.the("The input sku")
            .located(By.cssSelector("div.el-dialog__body .el-input__inner"));

    public static Target THE_FIRST_SKU_ON_POPUP = Target.the("The first sku on popup")
            .located(By.cssSelector("div.el-dialog__body .items >div:nth-child(2) .info"));

    /**
     * Popup Submit Incoming Inventory
     */

    public static Target D_TEXTBOX(String value) {
        return Target.the("").locatedBy("//div[@role='dialog']//div[contains(@class,'" + value + "')]//input");
    }

    public static Target D_SPAN_TEXT(String value) {
        return Target.the("").locatedBy("//div[@role='dialog']//span[contains(@class,'" + value + "')]");
    }

    public static Target D_TEXTBOX1(String value) {
        return Target.the("").locatedBy("//span[contains(text(),'" + value + "')]/ancestor::label/following-sibling::div//input");
    }

    public static Target ESTIMATE_DATE_OF_ARRIVAL = Target.the("Estimate date of arrival textbox")
            .locatedBy("(//div[@role='dialog']//div[contains(@class,'el-date-editor')]//input)[1]");

    public static Target EXPIRATION_DATE_SKU = Target.the("Expiration date of SKU")
            .locatedBy("(//div[@role='dialog']//div[contains(@class,'el-date-editor')]//input)[1]");

    public static Target LOT_CODE_TEXTBOX_BY_SKU(String skuName, String index) {
        return Target.the("Lot code textbox by sku " + skuName)
                .locatedBy("(//div[@role='dialog']//span[contains(text(),'" + skuName + "')]//ancestor::div/following-sibling::div//div[contains(@class,'lot-code')]//input)[" + index + "]");
    }

    public static Target EXPIRATION_DATE_TEXTBOX_BY_SKU(String skuName, String index) {
        return Target.the("Expiration date textbox by sku " + skuName)
                .locatedBy("(//div[@role='dialog']//span[contains(text(),'" + skuName + "')]//ancestor::div/following-sibling::div//label[text()='Expiration Date']/following-sibling::div//input)[" + index + "]");
    }

    public static Target RECEIVING_DATE_TEXTBOX_BY_SKU(String skuName, String index) {
        return Target.the("Receiving date textbox by sku " + skuName)
                .locatedBy("(//div[@role='dialog']//span[contains(text(),'" + skuName + "')]//ancestor::div/following-sibling::div//label[text()='Receiving Date']/following-sibling::div//input)[" + index + "]");
    }

    public static Target OF_CASES_TEXTBOX_BY_SKU(String skuName, String index) {
        return Target.the("Of cases textbox by sku " + skuName)
                .locatedBy("(//div[@role='dialog']//span[contains(text(),'" + skuName + "')]//ancestor::div/following-sibling::div//label[text()='# of Cases']/following-sibling::div//input)[" + index + "]");
    }

    public static Target NOTE_TEXTAREA_BY_SKU(String skuName, String index) {
        return Target.the("Note textarea by sku " + skuName)
                .locatedBy("(//div[@role='dialog']//span[contains(text(),'" + skuName + "')]//ancestor::div/following-sibling::div//label[text()='Note']/following-sibling::div//textarea)[" + index + "]");
    }


    public static Target D_ITEM_IN_SUBMIT(String value) {
        return Target.the("D_ITEM_IN_SUBMIT " + value)
                .locatedBy("//div[contains(@x-placement,'start')]//div[@class='el-scrollbar']//span[text()='" + value + "']");
    }

    /**
     * SKU Infomation
     */

    public static Target D_CASES_OF_SKU(String skuName, String index) {
        return Target.the("Cases of sku " + skuName)
                .located(By.xpath("(//span[text()='" + skuName + "']/ancestor::div/following-sibling::div//span[text()='# of Cases']/parent::label/following-sibling::div//input)[" + index + "]"));
    }

    /**
     * Popup add sku in Inventory Incoming Detail
     */
    public static Target SKU_IN_POPUP_ADD(String skuName) {
        return Target.the("SKU " + skuName + " in popup add")
                .located(By.xpath("//div[@role='dialog']//div[@class='items']//*[text()='" + skuName + "']"));
    }

    public static Target SKU_IN_SUBMIT(String _class, String index) {
        return Target.the("")
                .locatedBy("(//div[@role='dialog']//div[@class='grid incoming-inventory-line-items']//div[@class='" + _class + "'])[" + index + "]");
    }

    public static Target SKU_IN_SUBMIT2(String _class, String index) {
        return Target.the("")
                .locatedBy("(//div[@role='dialog']//div[@class='grid incoming-inventory-line-items']//div[contains(@class,'" + _class + "')]//input)[" + index + "]");
    }

    public static Target SKU_IN_SUBMIT3(String _class, String index) {
        return Target.the("")
                .locatedBy("(//div[@role='dialog']//div[@class='grid incoming-inventory-line-items']//label[text()='" + _class + "']/following-sibling::div//input)[" + index + "]");
    }

    public static Target SKU_IN_SUBMIT_NOTE(String _class, String index) {
        return Target.the("")
                .locatedBy("(//div[@role='dialog']//div[@class='grid incoming-inventory-line-items']//label[text()='" + _class + "']/following-sibling::div//textarea)[" + index + "]");
    }

    public static Target ITEM_INFO(String skuName, String class_) {
        return Target.the("SKU " + skuName + " in popup add")
                .located(By.xpath("//div[@role='dialog']//div[contains(text(),'" + skuName + "')]/parent::div/div[contains(@class,'" + class_ + "')]"));
    }

    /**
     * Tooltip
     */
    public static Target TOOLTIP_TEXTBOX = Target.the("Tooltip textbox")
            .locatedBy("//div[@role='tooltip' and @aria-hidden='false']//input");

    public static Target TOOLTIP_COMBOBOX = Target.the("Tooltip textbox")
            .locatedBy("//div[@role='tooltip' and @aria-hidden='false']//input[@placeholder]");

    public static Target TOOLTIP_TEXTBOX(int i) {
        return Target.the("Tooltip textbox")
                .locatedBy("(//div[@role='tooltip' and @aria-hidden='false']//input)[" + i + "]");
    }

    public static Target TOOLTIP_MESSAGE(String message) {
        String xpath = "//p[contains(text(),'" + message + "')]";
        if (message.contains("'"))
            xpath = "//p[contains(text(),\"" + message + "\")]";
        return Target.the("Tooltip message")
                .locatedBy(xpath);
    }

    public static Target TOOLTIP_MESSAGE1 = Target.the("Tooltip message")
            .locatedBy("//div[@class='el-notification__content']");


    public static Target TOOLTIP_MESSAGE_CLOSE = Target.the("Tooltip message close")
            .locatedBy("//div[@class='el-notification__closeBtn el-icon-close']");
    public static Target TOOLTIP_TEXTAREA = Target.the("Tooltip textarea")
            .locatedBy("//div[@role='tooltip' and @aria-hidden='false']//textarea");

    public static Target D_BUTTON_TOOLTIP = Target.the("Button")
            .located(By.xpath("(//div[@role='tooltip' and @aria-hidden='false']//button)[1]"));

    public static Target D_BUTTON_TOOLTIP_CANCEL = Target.the("Button cancel")
            .located(By.xpath("(//div[@role='tooltip' and @aria-hidden='false']//button)[2]"));

    public static Target ICON_CLOSE_DATE = Target.the("Icon close text in textbox datetime")
            .locatedBy("//i[@class='el-input__icon el-icon-circle-close']");

    public static Target D_DATE_IN_DATETIME = Target.the("Current Date")
            .located(By.xpath("//td[contains(@class,'current')]"));

    public static Target TOOLTIP_CHANGELOG(String _class, int i) {
        return Target.the("Tooltip Changelog")
                .locatedBy("(//div[@role='tooltip' and @aria-hidden='false']//tbody//td[@class='" + _class + "'])[" + i + "]");
    }


    /**
     * General information field
     */
    public static Target D_FIELD_IN_GENERAL(String title) {
        return Target.the("Field " + title)
                .located(By.xpath("(//dt[text()='" + title + "']/following-sibling::dd/div)[1]"));
    }

    public static Target D_FIELD_IN_GENERAL3(String title) {
        return Target.the("Field " + title)
                .located(By.xpath("(//dt[text()='" + title + "']/following-sibling::dd//span)"));
    }

    public static Target D_FIELD_IN_GENERAL2(String title) {
        return Target.the("Field " + title)
                .located(By.xpath("(//span[contains(text(),'" + title + "')]/ancestor::dt/following-sibling::dd/div)[1]"));
    }

    public static Target D_FIELD_IN_GENERAL4(String title) {
        return Target.the("Field " + title)
                .located(By.xpath("//span[contains(text(),'" + title + "')]/ancestor::dt/following-sibling::dd//span"));
    }

    public static Target D_FIELD_IN_GENERAL5(String title) {
        return Target.the("Field " + title)
                .located(By.xpath("//span[contains(text(),'" + title + "')]/ancestor::dt/following-sibling::dd"));
    }

    public static Target UPLOAD_BOL = Target.the("upload bol")
            .locatedBy("//input[@type='file']");

    public static Target BOL_FIELD = Target.the("BOL_FIELD")
            .locatedBy("//div[@class='input']/div");

    public static Target DYNAMIC_ITEM_DROPDOWN(String value) {
        return Target.the(value)
                .located(By.xpath("//div[@aria-hidden='false']/following-sibling::div//span[text()='" + value + "']"));
    }

    public static Target NO_SKU = Target.the("No sku in sku information")
            .locatedBy("//div[text()='Variant must have at least one']");

    /**
     *
     */
    public static Target D_FILE_SIGN_WPL(String fileName, String index) {
        return Target.the("File " + fileName)
                .located(By.xpath("(//div[text()='" + fileName + "'])[" + index + "]"));
    }

    public static Target SUBMMIT_TEXTBOX = Target.the("submit textbox")
            .locatedBy("//div[contains(@x-placement,'start')]//input");
    public static Target WPL_INPUT = Target.the("SIGNED WPL")
            .locatedBy("//div[contains(text(),'Select a wpl document')]/preceding-sibling::input");

    public static Target SAVE_WPL = Target.the("SIGNED WPL")
            .locatedBy("//div[@class='actions mt-2']//button[@type='button']//span//span[contains(text(),'Save')]");

    public static Target WPL_INPUT(String index) {
        return Target.the("SIGNED WPL")
                .locatedBy("(//div[@title='Accept: JPG, JPEG, PDF, XLS, XLSX']//input[@type='file'])[" + index + "]");
    }

    public static Target WPL_REMOVE(String index) {
        return Target.the("SIGNED WPL")
                .locatedBy("(//div[normalize-space()='Allowed formats: jpg, jpeg, pdf, xls, xlsx']/following-sibling::div//button//span[contains(text(),'Remove')])[" + index + "]");
    }

    public static Target IMAGE_REMOVE(String index) {
        return Target.the("SIGNED WPL")
                .locatedBy("(//div[normalize-space()='Inbound Inventory Images']/following-sibling::div//button//span[contains(text(),'Remove')])[" + index + "]");
    }

    public static Target IMAGE_SAVE = Target.the("SIGNED WPL")
            .locatedBy("(//div[normalize-space()='Inbound Inventory Images']/following-sibling::div//button//span[contains(text(),'Save')])");

    public static Target UPDATE_SUBMITTED_BUTTON = Target.the("Button update submitted")
            .locatedBy("//div[contains(@x-placement,'start')]//*[contains(text(),'Update')]");


    /**
     * INBOUND INVENTORY IMAGES
     */
    public static Target IMAGE_INDEX(String index) {
        return Target.the("Image " + index)
                .located(By.xpath("(//div[text()='Inbound Inventory Images']/following-sibling::div//label/input)[" + index + "]"));
    }

    public static Target REMOVE_IMAGE_BUTTON(String index) {
        return Target.the("Remove image button " + index)
                .located(By.xpath("(//button//span[contains(text(),'Remove')])[" + index + "]"));
    }

    public static Target DESCRIPTION_TEXTBOX(String index) {
        return Target.the("Description inbound inventory image textbox " + index)
                .located(By.xpath("(//div[text()='Inbound Inventory Images']/following-sibling::div//div[@class='description']//input)[" + index + "]"));
    }

    public static Target SAVE_IMAGE_BUTTON = Target.the("Save image button ")
            .located(By.xpath("(//button//span[contains(text(),'Save')])"));

    public static Target PREVIEW_IMAGE_BUTTON(String index) {
        return Target.the("Preview image button " + index)
                .located(By.xpath("(//div[text()='Inbound Inventory Images']/following-sibling::div//div[@class='actions']//a)[" + index + "]"));
    }

    public static Target SAVE_BUTTON = Target.the("Button save")
            .locatedBy("//button[contains(@class,'submit el-button--primary')]//span[contains(text(),'Save')]");

}


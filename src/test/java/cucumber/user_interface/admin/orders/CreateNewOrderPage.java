package cucumber.user_interface.admin.orders;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class CreateNewOrderPage {

    public static Target DYNAMIC_TEXTBOX(String title) {
        return Target.the(title)
                .locatedBy("(//label[contains(text(),'" + title + "')]//following-sibling::div//input)[1]");
    }

    public static Target DYNAMIC_TEXTAREA(String title) {
        return Target.the(title)
                .locatedBy("(//label[contains(text(),'" + title + "')]//following-sibling::div//textarea)[1]");
    }

    public static Target DYNAMIC_ITEM_DROPDOWN(String value) {
        return Target.the(value)
                .located(By.xpath("//div[@class='el-scrollbar']//div[text()='" + value + "']"));
    }

    public static Target D_ERROR_MESSAGE(String title) {
        return Target.the("Message error of " + title)
                .located(By.xpath("//label[text()='" + title + "']/following-sibling::div//div[@class='el-form-item__error']"));
    }

    public static final Target LINE_ITEM_ERROR_MESSAGE = Target.the("Error message add line item")
            .locatedBy("//div[contains(text(),'Please add line items for this order')]");


    public static final Target STREET1_TEXTBOX = Target.the("Street 1 address")
            .locatedBy("//div[contains(@class,'street1')]//input");

    public static final Target STREET2_TEXTBOX = Target.the("Street 2 address")
            .locatedBy("//div[contains(@class,'street-2')]//input");

    public static final Target UPLOAD_BUTTON = Target.the("Upload CSV")
            .locatedBy("//input[@class='upload-csv']");

    public static final Target ADD_LINE_BUTTON = Target.the("Add line item")
            .locatedBy("//span[text()='Add line item']/ancestor::button");

    public static final Target ADD_LINE_BUTTON_DISABLE = Target.the("Add line item disable")
            .locatedBy("(//button[contains(@class,'disabled')]//span[text()='You must choose a buyer first'])[1]");

    public static final Target CREATE_ORDER_BUTTON = Target.the("Create order button")
            .locatedBy("//button//span[text()='Create']");
    /**
     * Popup Select line item
     */

    public static final Target POPUP_SELECT_ITEM = Target.the("Popup select item")
            .locatedBy("//div[@role='dialog' and contains(@aria-label,'Select line item')]");

    public static final Target SEARCH_ITEM = Target.the("Search item in popup")
            .locatedBy("//div[@role='dialog' and contains(@aria-label,'Select line item')]//input");

    public static final Target ITEM_RESULT = Target.the("Item after searched")
            .locatedBy("//div[@role='dialog']//div[@class='variant']");

    public static final Target CLOSE_POPUP_ADD_ITEM = Target.the("Close popup add item")
            .locatedBy("//span[contains(text(),'Select line item')]/following-sibling::button");

    public static Target QUANTITY_OF_ITEM(String line) {
        return Target.the("QUANTITY_OF_ITEM " + line)
                .located(By.xpath("//span[normalize-space()='" + line + "']/ancestor::div[contains(@class,'el-row')]//input[@role='spinbutton']"));
    }

    public static Target SKU_IN_LINE_ITEM_CREATE(String sku) {
        return Target.the("Sku in line item create")
//                .locatedBy("(//div[text()='Line items']/following-sibling::div//span[text()='" + sku + "'])[last()]|(//div[text()='Line items']/following-sibling::div//span[@data-original-text='" + sku + "'])[last()]");
                .locatedBy("(//tbody//span[text()='" + sku + "'])[last()]|(//tbody//div//span[@data-original-text='" + sku + "'])[last()]");
    }

    public static final Target POPUP_SELECT_ITEM_CLOSE_BUTTON = Target.the("Popup select item close button")
            .locatedBy("//div[@role='dialog' and contains(@aria-label,'Select line item')]//button[@aria-label='Close']");

    /**
     * Line item in create new order
     */

    public static Target QUANTITY_TEXTBOX_IN_LINE_ITEM(String skuID) {
        return Target.the("Sku in line item create")
                .locatedBy("//span[text()='" + skuID + "']/ancestor::div/following-sibling::div//div[contains(@class,'quantity')]//input");
    }

    /**
     * Popup Upload file CSV
     */
    public static Target UPLOADED_PRODUCT_POPUP(int index) {
        return Target.the("Uploaded sku of row " + index)
                .located(By.xpath("//tr[" + index + "]//a[@class='product']//span"));
    }

    public static Target UPLOADED_SKU_POPUP(int index) {
        return Target.the("Uploaded sku of row " + index)
                .located(By.xpath("(//tr[" + index + "]//div[@class='variant']//span)[1]"));
    }

    public static Target UPLOADED_SKU_ID_POPUP(int index) {
        return Target.the("Uploaded sku id of row " + index)
                .located(By.xpath("(//tr[" + index + "]//div[@class='variant']//span)[2]"));
    }

    public static Target UPLOADED_UPC_POPUP(int index) {
        return Target.the("Uploaded upc of row " + index)
                .located(By.xpath("//tr[" + index + "]//span[contains(@class,'upc')]"));
    }

    public static Target UPLOADED_STATUS_POPUP(int index) {
        return Target.the("Uploaded status of row " + index)
                .located(By.xpath("//tr[" + index + "]//div[contains(@class,'status-tag')]"));
    }

    public static Target UPLOADED_REGION_POPUP(int index) {
        return Target.the("Uploaded region of row " + index)
                .located(By.xpath("//tr[" + index + "]//span[contains(@class,'region')]"));
    }


    public static Target UPLOADED_PRICE_POPUP(int index) {
        return Target.the("Uploaded price of row " + index)
                .located(By.xpath("//tr[" + index + "]//td[@class='nw uploaded_price']//span"));
    }

    public static Target ESTIMATED_PRICE_POPUP(int index) {
        return Target.the("Estimated price of row " + index)
                .located(By.xpath("//tr[" + index + "]//td[@class='nw price']//span"));
    }

    public static Target INFO_POPUP(int index) {
        return Target.the("Info message of row " + index)
                .located(By.xpath("//tr[" + index + "]//div[@class='info']"));
    }

    public static Target DANGER_POPUP(int index) {
        return Target.the("Danger message of row " + index)
                .located(By.xpath("//tr[" + index + "]//div[@class='danger']"));
    }

    public static Target WARNING_POPUP(int index) {
        return Target.the("Warning message of row " + index)
                .located(By.xpath("//tr[" + index + "]//div[@class='warning']"));
    }

    public static Target QUANTITY_POPUP(int index) {
        return Target.the("Quantity of row " + index)
                .located(By.xpath("//tr[" + index + "]//td[@class='nw quantity']//input"));
    }

    public static Target ESTIMATED_PRICE_NEW_POPUP(int index) {
        return Target.the("Estimated price new of row " + index)
                .located(By.xpath("//tr[" + index + "]//td[@class='nw price']//div[@class='new']"));
    }

    public static Target ESTIMATED_PRICE_OLD_POPUP(int index) {
        return Target.the("Estimated price old of row " + index)
                .located(By.xpath("//tr[" + index + "]//td[@class='nw price']//div[@class='old']"));
    }

    // Total
    public static Target TOTAL_CASE_POPUP(int index) {
        return Target.the("Total case " + index)
                .located(By.xpath("(//div[@role='dialog']//td[text()='Total cases']/following-sibling::td)[" + index + "]"));
    }

    public static Target TOTAL_ORDER_VALUE_POPUP(int index) {
        return Target.the("Total case " + index)
                .located(By.xpath("(//div[@role='dialog']//td[text()='Total Order Value']/following-sibling::td)[" + index + "]"));
    }

    public static Target DISCOUNT_POPUP(int index) {
        return Target.the("Discount " + index)
                .located(By.xpath("(//div[@role='dialog']//td[text()='Discount']/following-sibling::td)[" + index + "]"));
    }

    public static Target TAXES_POPUP(int index) {
        return Target.the("Taxes " + index)
                .located(By.xpath("(//div[@role='dialog']//td[text()='Taxes']/following-sibling::td)[" + index + "]"));
    }

    public static Target LOGISTICS_SURCHARGE_POPUP(int index) {
        return Target.the("Logistics surcharge " + index)
                .located(By.xpath("(//div[@role='dialog']//td[text()='Logistics surcharge']/following-sibling::td)[" + index + "]"));
    }

    public static Target SPECIAL_DISCOUNT_POPUP(int index) {
        return Target.the("Taxes " + index)
                .located(By.xpath("(//div[@role='dialog']//td[text()='Special discount']/following-sibling::td)[" + index + "]"));
    }

    public static Target TOTAL_PAYMENT_POPUP(int index) {
        return Target.the("Total payment " + index)
                .located(By.xpath("(//div[@role='dialog']//td[text()='Total payment']/following-sibling::td)[" + index + "]"));
    }

    public static final Target ADD_LINE_ITEM_BUTTON = Target.the("Add line item button")
            .locatedBy("//button//span[text()='Add line items']");

    /**
     * Line Item POPUP
     */

    public static Target BRAND_LINE_ITEM(String title, int index) {
        return Target.the("Brand in line item")
                .locatedBy("(//div[text()='" + title + "']//ancestor::div[contains(@class,'section-group')]//div[contains(@class,'el-row')]//div[@class='brand']/div)[" + index + "]");
    }

    public static Target PRODUCT_LINE_ITEM(String title, int index) {
        return Target.the("Product in line item")
                .locatedBy("(//div[text()='" + title + "']//ancestor::div[contains(@class,'section-group')]//div[contains(@class,'el-row')])[" + index + "]//div[@class='product']/div");
    }

    public static Target SKU_LINE_ITEM(String title, int index) {
        return Target.the("SKU in line item")
                .locatedBy("((//div[text()='" + title + "']//ancestor::div[contains(@class,'section-group')]//div[contains(@class,'el-row')])[" + index + "]//div[@class='variant']/span)[1]");
    }

    public static Target SKU_ID_LINE_ITEM(String title, int index) {
        return Target.the("SKU ID in line item")
                .locatedBy("((//div[text()='" + title + "']//ancestor::div[contains(@class,'section-group')]//div[contains(@class,'el-row')])[" + index + "]//div[@class='variant']/span)[2]");
    }

    public static Target UPC_LINE_ITEM(String title, int index) {
        return Target.the("UPC in line item")
                .locatedBy("(//div[text()='" + title + "']//ancestor::div[contains(@class,'section-group')]//div[contains(@class,'el-row')])[" + index + "]//span[contains(@class,'upc-tag')]");
    }

    public static Target UNITS_LINE_ITEM(String title, int index) {
        return Target.the("Units in line item")
                .locatedBy("(//div[text()='" + title + "']//ancestor::div[contains(@class,'section-group')]//div[contains(@class,'el-row')])[" + index + "]//div[contains(@class,'units')]");
    }

    public static Target STATUS_LINE_ITEM(String title, int index) {
        return Target.the("Status in line item")
                .locatedBy("(//div[text()='" + title + "']//ancestor::div[contains(@class,'section-group')]//div[contains(@class,'el-row')])[" + index + "]//div[contains(@class,'status-tag')]");
    }

    /**
     * Line Item Create order
     */

    public static Target BRAND_MOV_LINE_ITEM(String skuName) {
        return Target.the("Brand in line item mov")
                .locatedBy("//span[text()='" + skuName + "']/parent::div/preceding-sibling::div[@class='brand']/div");
    }

    public static Target PRODUCT_MOV_LINE_ITEM(String skuName) {
        return Target.the("Product in line item mov")
                .locatedBy("//span[text()='" + skuName + "']/parent::div/preceding-sibling::div[@class='product']/div");
    }

    public static Target SKU_MOV_LINE_ITEM(String skuName) {
        return Target.the("SKU in line item mov")
                .locatedBy("//span[text()='" + skuName + "']");
    }

    public static Target SKU_ID_MOV_LINE_ITEM(String skuName) {
        return Target.the("SKU ID in line item mov")
                .locatedBy("//span[text()='" + skuName + "']/following-sibling::span");
    }

    public static Target UPC_ID_MOV_LINE_ITEM(String skuName) {
        return Target.the("Case UPC in line item mov")
                .locatedBy("(//span[text()='" + skuName + "']/parent::div//following-sibling::div[@class='case-upc']//span)[2]");
    }

    public static Target STATUS_MOV_LINE_ITEM(String skuName) {
        return Target.the("Status in line item mov")
                .locatedBy("//span[text()='" + skuName + "']/parent::div/following-sibling::div[@class='status']/div");
    }

    public static Target PRICE_MOV_LINE_ITEM(String skuName) {
        return Target.the("Price in line item mov")
                .locatedBy("//span[text()='" + skuName + "']/parent::div/parent::div/following-sibling::div/span");
    }

    public static Target PRICE_NEW_MOV_LINE_ITEM(String skuName) {
        return Target.the("Price new after promo in line item mov")
                .locatedBy("(//span[text()='" + skuName + "']/parent::div/parent::div/following-sibling::div//div[@class='price']/div)[1]");
    }

    public static Target PRICE_OLD_MOV_LINE_ITEM(String skuName) {
        return Target.the("Price old after promo in line item mov")
                .locatedBy("(//span[text()='" + skuName + "']/parent::div/parent::div/following-sibling::div//div[@class='price']/div)[2]");
    }

    public static Target QUANTITY_MOV_LINE_ITEM(String skuName) {
        return Target.the("Quantity in line item mov")
                .locatedBy("//span[text()='" + skuName + "']/parent::div/parent::div/following-sibling::div//input");
    }

    // Message add more SKU
    public static Target ALERT_MESSAGE(String message) {
        return Target.the("Message alert")
                .locatedBy("//p[text()='" + message + "']");
    }

    /**
     * Summary
     */
    public static final Target SOS_ALERT_SUMMARY = Target.the("SOS alert in summary")
            .locatedBy("//div[@class='small-order-surcharge-alert']/strong");

    public static final Target LS_ALERT_SUMMARY = Target.the("LS alert in summary")
            .locatedBy("//div[@class='logistics-surcharge-alert']/strong");

}

package cucumber.user_interface.admin.inventory;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class IncomingInventoryPage {

    /**
     * Table result
     */

    public static Target DYNAMIC_RESULT_IN_TABLE(String title) {
        return Target.the(title + " in table result")
                .located(By.xpath("//td[contains(@class,'" + title + "')]"));
    }

    public static Target DYNAMIC_2_RESULT_IN_TABLE(String title) {
        return Target.the(title + " in table result")
                .located(By.xpath("//span[contains(@class,'" + title + "')]"));
    }

    public static Target DYNAMIC_RESULT_IN_TABLE3(String title) {
        return Target.the(title + " in table result")
                .located(By.xpath("//td[contains(@class,'" + title + "')]//span"));
    }

    public static Target NUMBER(String title) {
        return Target.the(title + " in table result")
                .located(By.xpath("//td[contains(@class,'number')]//*[contains(text(),'" + title + "')]"));
    }

    public static Target NUMBER_RESULT = Target.the("Number of incoming inventory after search")
            .locatedBy("//a[@class='number']");

    public static Target ETA = Target.the("Number of incoming inventory after search")
            .locatedBy("//span[contains(@class,'eta')]");

    public static Target CANCEL_REQUEST(String id) {
        return Target.the("Cancel request in result")
                .located(By.xpath("//a[text()='" + id + "']/ancestor::td/following-sibling::td//button//span[text()='Cancel']"));
    }

    /**
     * Popup Cancel Inbound Inventory
     */
    public static Target NOTE_CANCEL_REQUEST = Target.the("Note cancel request in result")
            .located(By.xpath("//div[@role='dialog']//textarea"));


    public static Target NO_FOUND_DATA = Target.the("No found data")
            .locatedBy("//span[text()='No Data']");

    /**
     * Popup Create new Inventory
     */
    public static Target DYNAMIC_FIELD(String value) {
        return Target.the("Dynamic field " + value)
                .located(By.xpath("//div[@class='el-dialog__body']//label[contains(@for,'" + value + "')]//following-sibling::div//input"));
    }

    public static Target CREATE_VENDOR_COMPANY = Target.the("Vendor company")
            .locatedBy("//div[@class='select vendor-company']//input");

    public static Target CREATE_REGION = Target.the("region")
            .locatedBy("//div[@class='select region']//input");

    public static Target CREATE_WAREHOUSE = Target.the("warehouse")
            .locatedBy("//div[@class='select warehouse']//input");
    public static Target CREATE_TOTAL_OF_SELLABLE_RETAIL_CASE = Target.the(" Total # of Sellable Retail Cases")
            .locatedBy("//div[contains(@class,'total-case')]");

    public static Target CREATE_OF_PALLET = Target.the(" # of Pallet")
            .locatedBy("//div[@class='num-pallet number el-input']//input");

    public static Target CREATE_ADD_SKU = Target.the("Add sku")
            .locatedBy("//span[contains(text(),'Add line item')]");

    public static Target CREATE_ADD_SKU_SEARCH_FIELD = Target.the("Add sku search field")
            .locatedBy("//div[@role='dialog']//div[@class='el-input']//input[@type='text']");

    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector("div.el-loading-mask"));

    public static Target CREATE_ADD_SKU_SKU_NAME = Target.the("The SKU name")
            .locatedBy("//div[@class='variant']");

    public static Target CREATE_BUTTON = Target.the("Create button")
            .locatedBy("//span[normalize-space()='Create']");

    public static Target CONFIRM_ADD_SKU_AGAIN = Target.the("Create button")
            .locatedBy("//button[contains(@class,'el-button el-button--default el-button--small el-button--primary')]");

    public static Target CREATE_ADD_SKU_OF_CASE = Target.the("The of case SKU")
            .locatedBy("(//div[@class='quantity el-input el-input--mini']//input[@type='number'])[last()]");

    public static Target NUMBER_INVENTORY = Target.the("")
            .locatedBy("//div[@class='title']/span");

    public static Target ESTIMATED_WEEK_TEXTBOX = Target.the("Estimated weeks of inventory textbox")
            .locatedBy("//label[text()='Estimated Weeks of Inventory']/following-sibling::div//input");

    public static Target NOTE_TEXTAREA = Target.the("Note textarea")
            .locatedBy("//*[contains(text(),'Notes')]/ancestor::label/following-sibling::div//textarea");

    public static Target ADMIN_NOTE_TEXTAREA = Target.the("Admin note textarea")
            .locatedBy("//*[contains(text(),'Admin note')]/ancestor::label/following-sibling::div//textarea");

    // SKU
    public static Target SKU_BRAND(String sku, String index) {
        return Target.the("").locatedBy("(//span[text()='" + sku + "']/parent::div/preceding-sibling::div[@class='brand'])[" + index + "]");
    }

    public static Target SKU_PRODUCT(String sku, String index) {
        return Target.the("").locatedBy("(//span[text()='" + sku + "']/parent::div/preceding-sibling::div[@class='product'])[" + index + "]");
    }

    public static Target SKU_NAME(String sku, String index) {
        return Target.the("").locatedBy("(//span[text()='" + sku + "'])[" + index + "]");
    }

    public static Target SKU_UPC(String sku, String index) {
        return Target.the("").locatedBy("(//span[text()='" + sku + "']/parent::div/following-sibling::div[@class='case-upc'])[" + index + "]");
    }
    public static Target SKU_UNIT(String sku, String index) {
        return Target.the("").locatedBy("(//span[text()='" + sku + "']/parent::div/following-sibling::div[@class='units'])[" + index + "]");
    }

    public static Target SKU_MASTER_CARTON(String sku, String index) {
        return Target.the("").locatedBy("(//span[text()='" + sku + "']/parent::div/following-sibling::div[@class='cases-per-master-carton'])[" + index + "]");
    }
    public static Target SKU_STORE_SHELF_LIFE(String sku, String index) {
        return Target.the("").locatedBy("(//span[text()='" + sku + "']/parent::div/parent::div/following-sibling::div//div[contains(@class,'storage-shelf-life-attributes')]/input)[" + index + "]");
    }

    public static Target SKU_TEMPERATURE(String sku, String index) {
        return Target.the("").locatedBy("(//span[text()='" + sku + "']/parent::div/parent::div/following-sibling::div//div[contains(@class,'temperature')]/input)[" + index + "]");
    }

    public static Target SKU_LOTCODE(String sku, String index) {
        return Target.the("").locatedBy("(//span[text()='" + sku + "']/parent::div/parent::div/following-sibling::div//div[contains(@class,'lot-code')]/input)[" + index + "]");
    }

    public static Target SKU_OF_CASE(String sku, String index) {
        return Target.the("").locatedBy("(//span[text()='" + sku + "']/parent::div/parent::div/following-sibling::div//div[contains(@class,'quantity')]/input)[" + index + "]");
    }


    public static Target REMOVE_SKU(String sku) {
        return Target.the("").locatedBy("//span[contains(text(),'" + sku + "')]/ancestor::div[@class='el-row']//button[contains(@class,'undo')]");
    }


}

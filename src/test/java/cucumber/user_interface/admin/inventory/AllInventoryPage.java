package cucumber.user_interface.admin.inventory;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AllInventoryPage {

    /**
     * Popup Create new Inventory
     */
    public static Target DYNAMIC_FIELD(String value) {
        return Target.the("Dynamic field " + value)
                .located(By.xpath("//div[@class='el-dialog__body']//label[contains(@for,'" + value + "')]//following-sibling::div//input"));
    }

    public static Target QUALITY_TEXTBOX = Target.the("Quality textbox")
            .located(By.xpath("//input[@aria-valuemax='Infinity']"));

    public static Target CREATE_BUTTON_IN_POPUP = Target.the("Create button in create new inventory")
            .located(By.xpath("//div[@class='el-dialog__body']//button//span[text()='Create']"));

    public static Target SORT_RECEIVE_DATE_RESULT = Target.the("Sort receive date by result")
            .located(By.xpath("//th//div[text()='Receive']"));


    public static Target CREATE_BUTTON = Target.the("Create button")
            .located(By.xpath("//button[@class='el-button el-button--primary']//span[text()='Create']"));

    public static Target REFRESH_BUTTON = Target.the("Create button")
            .located(By.xpath("//button[@data-original-title='null']//span//*[name()='svg']"));

    public static Target SKU_VALUE = Target.the("SKU value")
            .located(By.xpath("//div[@class='variant']//div[@class='name']"));

    public static Target ADD_PHOTO_BUTTON = Target.the("Add photo button")
            .located(By.xpath("//button//span[text()='Add a photo']"));

    public static Target IMAGE_PREVIEW(String index) {
        return Target.the("Image preview")
                .located(By.xpath("(//label[@class='preview'])[" + index + "]"));
    }

    public static Target COMMENT_IMAGE_TEXTBOX(String index) {
        return Target.the("Comment image textbox")
                .located(By.xpath("(//input[@placeholder='Description...'])[" + index + "]"));
    }

    public static Target ATTACHMENT_BUTTON(String index) {
        return Target.the("Attachment button")
                .located(By.xpath("(//input[@type='file'])[" + index + "]"));
    }

    public static Target EDIT_QUANTITY(String button) {
        return Target.the("EDIT_QUANTITY button " + button)
                .located(By.xpath("//span[contains(@class,'el-input-number__" + button + "')]"));
    }

    public static Target DISTRIBUTION_REGION = Target.the("").locatedBy("//span[contains(text(),'for region')]/following-sibling::span");

    /**
     * Table result
     */

    public static Target D_LOTCODE_RESULT_IN_TABLE(String lotcode) {
        return Target.the("Lotcode in table result")
                .located(By.xpath("//td[contains(@class,'lot-code')]//span[contains(@data-original-text,'" + lotcode + "')]"));
    }

    public static Target D_PRODUCT_RESULT_IN_TABLE(String lotcode) {
        return Target.the("Product in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/preceding-sibling::td[contains(@class,'product')]//span"));
    }

    public static Target D_SKU_RESULT_IN_TABLE(String lotcode) {
        return Target.the("SKU in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/preceding-sibling::td[contains(@class,'name')]//span"));
    }

    public static Target D_ORIGINAL_QUANTITY_RESULT_IN_TABLE(String lotcode) {
        return Target.the("Original quantity in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,'original-quantity')]//div"));
    }

    public static Target D_CURRENT_QTY_RESULT_IN_TABLE(String lotcode) {
        return Target.the("Current Qty in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,'current-quantity')]//div"));
    }

    public static Target D_END_QTY_RESULT_IN_TABLE(String lotcode) {
        return Target.the("End Qty in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,' quantity')]//div"));
    }

    public static Target D_PULL_QTY_RESULT_IN_TABLE(String lotcode) {
        return Target.the("Pull Qty in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,'pull-quantity')]//div"));
    }

    public static Target D_EXPIRE_DATE_RESULT_IN_TABLE(String lotcode) {
        return Target.the("Expire date in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,'expiry-date')]//div"));
    }

    public static Target D_PULL_DATE_RESULT_IN_TABLE(String lotcode) {
        return Target.the("Pull date in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,'pull-date')]//div"));
    }

    public static Target D_RECEIVE_RESULT_IN_TABLE(String lotcode) {
        return Target.the("Receive date in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,'receive-date')]//div"));
    }

    public static Target D_WAREHOUSE_RESULT_IN_TABLE(String lotcode) {
        return Target.the("Warehouse in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,'warehouse')]//span"));
    }

    public static Target D_VENDOR_COMPANY_RESULT_IN_TABLE(String lotcode) {
        return Target.the("Vendor company in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,'vendor-company')]//span"));
    }

    public static Target D_DAY_UNTIL_RESULT_IN_TABLE(String lotcode) {
        return Target.the("Day until pull date in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,'days-utill-pull-date')]//div"));
    }

    public static Target D_REGION_RESULT_IN_TABLE(String lotcode) {
        return Target.the("Region in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,'region')]//span"));
    }

    public static Target D_CREATED_BY_RESULT_IN_TABLE(String lotcode) {
        return Target.the("Created by in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,'created-by')]//span"));
    }

    public static Target SKU_LINK = Target.the("SKU link to see details")
            .located(By.xpath("(//tr)[2]//a[@class='sku']"));

    public static Target LOTCODE_LINK(String lotcode) {
        return Target.the("Lotcode link to see details")
                .locatedBy("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/preceding-sibling::td[contains(@class,'name')]");
    }

    public static Target DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE1(String lotcode, String title) {
        return Target.the(title + " in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/preceding-sibling::td[contains(@class,'" + title + "')]//span"));
    }

    public static Target DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE2(String lotcode, String title) {
        return Target.the(title + " in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,'" + title + "')]//span"));
    }

    public static Target DYNAMIC_RESULT_BY_LOTCODE_IN_TABLE3(String lotcode, String title) {
        return Target.the(title + " in table result")
                .located(By.xpath("//span[contains(@data-original-text,'" + lotcode + "')]/ancestor::td/following-sibling::td[contains(@class,'" + title + "')]//div"));
    }

    public static Target LOT_CODE_IN_TABLE(String lotcode) {
        return Target.the("Lot code in table result")
                .located(By.xpath("//td[contains(@class,'lot-code')]//span[contains(@data-original-text,'" + lotcode + "')]"));
    }


    public static Target NEXT_TAB_BUTTON = Target.the("Next tab button")
            .located(By.xpath("//button[@class='btn-next']/i"));
    public static Target SELECT_ALL_INVENTORY = Target.the("SELECT_ALL_INVENTORY")
            .located(By.xpath("//th[1]//div[1]"));

    public static Target MOVE_WAREHOUSE = Target.the("SELECT_ALL_INVENTORY")
            .located(By.xpath("//span[@class='action move']"));

    public static Target EDIT_WAREHOUSE = Target.the("SELECT_ALL_INVENTORY")
            .located(By.xpath("//span[@class='action edit']"));

    public static Target SELECT_A_INVENTORY(String sku) {
        return Target.the("SELECT_A_INVENTORY")
                .located(By.xpath("//span[contains(@data-original-text,'" + sku + "')]/ancestor::tr/td[1]//input"));
    }
}

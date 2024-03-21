package cucumber.user_interface.admin.inventory;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class InventoryDetailPage {

    public static Target PRODUCT_NAME = Target.the("Product name")
            .locatedBy("//*[@class='product']");

    public static Target SKU_NAME = Target.the("SKU name")
            .locatedBy("//a[@class='sku-name']");

    public static Target CREATED_BY = Target.the("Created by")
            .locatedBy("//dt[text()='Created by']/following-sibling::dd//span");

    public static Target DISTRIBUTION_CENTER = Target.the("Distribution center")
            .locatedBy("//*[@class='warehouse']");

    public static Target WAIT_DISTRIBUTION_CENTER(String distribution) {
        return Target.the("Distribution center")
                .locatedBy("//dt[text()='Distribution center']/following-sibling::dd//span/div/span[text()='" + distribution + "']");
    }

    public static Target RECEIVE_DATE = Target.the("Receive date")
            .locatedBy("//span[@class='at-receive-date']");

    public static Target RECEIVE_DATE(String date) {
        return Target.the("Receive date")
                .locatedBy("//div[contains(@x-placement,'start')]//div[contains(@class,'el-picker-panel__content')]//td[contains(@class,'available')]//span[contains(text(),'" + date + "')]");
    }

    public static Target EXPIRY_DATE = Target.the("Expiry date")
            .locatedBy("//span[@class='at-expiry-date']");

    public static Target PULL_DATE = Target.the("Pull date")
            .locatedBy("//dd[@class='pull-date']");

    public static Target LOT_CODE = Target.the("Lot code")
            .locatedBy("//div[@class='lot-code']");

    public static Target PRODUCT_LINK = Target.the("Product link")
            .located(By.xpath("//span[@class='product']//following-sibling::a"));

    public static Target SAVE_IMAGE_BUTTON = Target.the("Save image button")
            .located(By.xpath("//button//span[text()='Save']"));

    public static Target PREVIEW_IMAGE_BUTTON = Target.the("Preview image button")
            .located(By.xpath("//div//span[text()='Preview']"));

    public static Target COMMENT = Target.the("COMMENT")
            .located(By.xpath("//dd[@class='comment']//span"));

    /**
     * Subtraction Item
     */

    public static Target NEW_SUBTRACTION_BUTTON = Target.the("Subtraction date")
            .locatedBy("//span[contains(text(),'New subtraction item')]");

    public static Target NEW_ADDITION_BUTTON = Target.the("Addition")
            .locatedBy("//span[contains(text(),'New addition item')]");

    public static Target SUBTRACTION_DATE = Target.the("Subtraction date")
            .locatedBy("//td[@class='created-at nw']");

    public static Target SUBTRACTION_DATE(int i) {
        return Target.the("Subtraction date")
                .locatedBy("(//td[@class='created-at nw'])[" + i + "]");
    }

    public static Target SUBTRACTION_TAB(String tab) {
        return Target.the("Subtraction tab " + tab)
                .locatedBy("//label//span[normalize-space()='" + tab + "']");
    }

    public static Target SUBTRACTION_QUANTITY = Target.the("Subtraction quantity")
            .locatedBy("//td[@class='quantity nw']/span");

    public static Target SUBTRACTION_QUANTITY(int i) {
        return Target.the("Subtraction quantity")
                .locatedBy("(//td[@class='quantity nw'])[" + i + "]");
    }

    public static Target SUBTRACTION_DESCRIPTION = Target.the("Subtraction description")
            .locatedBy("//td[contains(@class,'description')]/span");

    public static Target SUBTRACTION_DESCRIPTION(int i) {
        return Target.the("Subtraction description")
                .locatedBy("(//td[contains(@class,'description')]/span)[" + i + "]");
    }

    public static Target SUBTRACTION_ORDER = Target.the("Subtraction order")
            .locatedBy("//td[contains(@class,'order')]/div");

    public static Target SUBTRACTION_ORDER(int i) {
        return Target.the("Subtraction order")
                .locatedBy("(//td[contains(@class,'order')])[" + i + "]");
    }

    public static Target SUBTRACTION_CATEGORY(int i) {
        return Target.the("Subtraction category")
                .locatedBy("(//td[contains(@class,'category')])[" + i + "]");
    }

    public static Target NO_INVENTORY_ACTIVITIES = Target.the("No inventory activities found")
            .locatedBy("//div[text()='No inventory activities found.']");

    public static Target FIRST_DELETE_SUBTRACTION = Target.the("First subtraction")
            .locatedBy("//button[@type='button']//span//span[contains(text(),'Delete')]");
    public static Target DELETE_SUBTRACTION_REMOVAL_COMMENT = Target.the("First subtraction")
            .locatedBy("//div[@role='tooltip' and(@x-placement)]//label[normalize-space()='Enter removal comment']/following-sibling::div//input");
    public static Target DELETE_SUBTRACTION_REMOVAL_CONFIRM = Target.the("First subtraction")
            .locatedBy("//div[@aria-hidden='false']//button[normalize-space()='Confirm delete']");

    public static Target WITHDRAWAL_ID_LINK = Target.the("Withdrawal id link in subtraction")
            .locatedBy("//td[contains(@class,'description')]//a");

    public static Target EDIT_FIRST_SUBTRACTION = Target.the("Edit First subtraction")
            .locatedBy("//button[@type='button']//span//span[contains(text(),'Edit')]");
    public static Target ID_FIRST_SUBTRACTION = Target.the("Edit First subtraction")
            .locatedBy("//tbody/tr[1]/td[2]");
    /**
     * Create new subtraction - new addition
     */
    public static Target POPUP_CREATE_QUANTITY = Target.the("Popup create quantity")
            .locatedBy("//label[text()='Quantity']/following-sibling::div//input");

    public static Target POPUP_CREATE_CATEGORY = Target.the("Popup create category")
            .locatedBy("//label[text()='Category']/following-sibling::div//input");

    public static Target POPUP_CREATE_SUB_CATEGORY = Target.the("Popup create sub category")
            .locatedBy("//label[text()='Sub category']/following-sibling::div//input");

    public static Target POPUP_CREATE_COMMENT = Target.the("Popup create comment")
            .locatedBy("//div[@role='dialog']//label[text()='Comment']/following-sibling::div//input");

    public static Target POPUP_CREATE_BUTTON = Target.the("Popup create button")
            .locatedBy("//button[@type='button']//span//span[contains(text(),'Create')]");

    public static Target SUBTRACTION_ID = Target.the("SUBTRACTION_ID")
            .locatedBy("//td[contains(@class,'id')]");

    /**
     * General information field
     */
    public static Target D_FIELD(String value) {
        return Target.the("Subtraction category")
                .locatedBy("//span[@class='" + value + "']");
    }

    public static Target DYNAMIC_INFO(String title) {
        return Target.the(title + " in general information")
                .located(By.xpath("//dd[@class='" + title + "']"));
    }

    public static Target DATE_TOOLTIP = Target.the("")
            .located(By.xpath("//div[contains(@x-placement,'start')]//div[contains(@class,'el-picker-panel__content')]"));

    public static Target DATE_TOOLTIP(String date) {
        return Target.the("")
                .located(By.xpath("//div[contains(@x-placement,'start')]//div[contains(@class,'el-picker-panel__content')]//td[contains(@class,'" + date + "')]"));


    }

    public static Target EDIT_INPUT_TOOLTIP(String input) {
        return Target.the("")
                .located(By.xpath("//div[contains(@x-placement,'start')]//label[normalize-space()='" + input + "']/following-sibling::div//input"));


    }

    public static Target DELETE_BUTTON = Target.the("Delete button")
            .located(By.xpath("//button[contains(@class,'el-button el-button--danger')]"));

    public static Target DELETE_BUTTON_DISABLE = Target.the("Delete button disable")
            .located(By.xpath("//button[contains(@class,'el-button el-button--danger') and @disabled]"));

    public static Target REFRESH_BUTTON = Target.the("REFRESH_BUTTON")
            .located(By.xpath("//button[contains(@class,'el-button el-button--danger')]/following-sibling::button"));

}

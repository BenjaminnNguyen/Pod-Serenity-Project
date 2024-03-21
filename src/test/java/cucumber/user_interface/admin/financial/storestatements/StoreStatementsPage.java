package cucumber.user_interface.admin.financial.storestatements;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class StoreStatementsPage {

    public static Target GENERAL_INFO_HEADER = Target.the("General information header")
            .located(By.xpath("//div[text()='General information']"));

    public static Target STORE_RESULT(String store) {
        return Target.the("Store in result")
                .locatedBy("//td[contains(@class,'store-name')]//a[normalize-space()='" + store + "']");

    }

    public static Target RECORD_PAYMENT_BUTTON = Target.the("Record payment button")
            .located(By.xpath("//button//span[text()='Record Payment']"));

    public static Target ADJUSTMENT_BUTTON = Target.the("Adjustment button")
            .located(By.xpath("//button//span[text()='Add an adjustment']"));

    /**
     * Edit An Adjustment
     */
    public static Target EDIT_LAST_ADJUSTMENT_BUTTON = Target.the("Edit last Adjustment button")
            .located(By.xpath("((//div[@class='adjustment-actions'])[last()]//button)[1]"));

    public static Target DELETE_LAST_ADJUSTMENT_BUTTON = Target.the("Delete last Adjustment button")
            .located(By.xpath("((//div[@class='adjustment-actions'])[last()]//button)[2]"));

    public static Target SUB_INVOICE_CHECKBOX(String orderID) {
        return Target.the("Sub invoice checkbox")
                .located(By.xpath("//div[@role='dialog']//span[text()='" + orderID + "']/parent::td/preceding-sibling::td/input"));
    }

    public static Target SELECT_ALL_SUB_INVOICE = Target.the("Select all Sub invoice")
                .located(By.xpath("//span[contains(text(),'Select all')]"));

    public static Target PAYMENT_TEXTBOX(String title) {
        return Target.the(title + " textbox")
                .located(By.xpath("//label[text()='" + title + "']/following-sibling::div//input"));
    }

    public static Target PAYMENT_TEXTAREA(String title) {
        return Target.the(title + " textarea")
                .located(By.xpath("//label[text()='" + title + "']/following-sibling::div//textarea"));
    }

    public static Target COMPLETE_RECORD_PAYMENT = Target.the("Complete record payment")
                .located(By.xpath("//span[text()='Complete']//ancestor::button"));

    public static Target D_TEXTBOX(String title) {
        return Target.the(title + " textbox")
                .located(By.xpath("//label[text()='" + title + "']/following-sibling::div//input"));
    }
    /**
     * Result table
     */
    public static Target ID_IN_RESULT = Target.the("ID in result")
            .located(By.xpath("//td[contains(@class,'id')]/div"));

    public static Target STORE_IN_RESULT = Target.the("Store in result")
            .located(By.xpath("//td[contains(@class,'store-name')]//a"));

    public static Target MONTH_IN_RESULT = Target.the("Store in result")
            .located(By.xpath("//div[@class='panner']//td[contains(@class,'month')]/div"));

    public static Target BEGINNING_IN_RESULT = Target.the("Beginning balance in result")
            .located(By.xpath("//div[@class='panner']//td[contains(@class,'beginning-balance')]/div"));

    public static Target ENDING_IN_RESULT = Target.the("Beginning balance in result")
            .located(By.xpath("//div[@class='panner']//td[contains(@class,'ending-balance')]/div"));
}

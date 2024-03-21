package cucumber.user_interface.beta.Buyer.common;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class CommonBuyerPage {

    public static Target LOADING_PRODUCT = Target.the("Loading product")
            .located(By.xpath("//div[text()='Loading product...']"));

    public static Target ALERT = Target.the("Alert")
            .located(By.xpath("//div[@role='alert']"));

    public static Target LOADING_BAR = Target.the("Loading bar")
            .located(By.xpath("//div[@class='nuxt-progress']"));

    public static Target LOADING_MESSAGE = Target.the("Loading bar with message")
            .located(By.xpath("//div[contains(text(),'Loading pre-order details...')]"));

    public static Target D_LOADING_MESSAGE(String message) {
        return Target.the("Loading bar with message")
                .located(By.xpath("//div[contains(text(),'" + message + "')]"));
    }

    public static Target NO_DATA_DROPDOWN = Target.the("No data drop down")
            .located(By.xpath("//div[contains(@class,'el-select-dropdown')]//p[contains(text(),'No data')]"));

    public static Target DYNAMIC_ITEM_DROPDOWN_3(String value) {
        return Target.the(value)
                .located(By.xpath("//div[contains(@x-placement,'start')]//*[contains(text(),'" + value + "')]"));
    }

    public static Target DYNAMIC_BUTTON(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//button//span[contains(text(),'" + value + "')]"));
    }

    public static Target DYNAMIC_DIALOG_BUTTON(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//div[@aria-label='dialog']//span[contains(text(),'" + value + "')]//ancestor::button"));
    }

    public static Target DYNAMIC_SPAN_TEXT(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//span[contains(text(),'" + value + "')]"));
    }

    public static Target DYNAMIC_TEXT(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//*[text()='" + value + "']"));
    }

    public static Target DYNAMIC_ANY_TEXT(String value) {
        String xpath = "//*[contains(text(),'" + value + "')]";
        if (value.contains("'"))
            xpath = "//*[contains(text(),\"" + value + "\")]";
        return Target.the(value + "button")
                .located(By.xpath(xpath));
    }

    public static Target DYNAMIC_TITLE(String value) {
        return Target.the(value + "DYNAMIC_TITLE")
                .located(By.xpath("//h1[contains(text(),'" + value + "')]"));
    }

    public static Target D_MESSAGE_POPUP(String message) {
        return Target.the("Message")
                .locatedBy("//p[contains(text(),'" + message + "')]");
    }

    public static Target DYNAMIC_INPUT(String name) {
        return Target.the("Message")
                .locatedBy("//label[normalize-space()='" + name + "']/following-sibling::div//input");
    }
    public static Target DYNAMIC_INPUT2(String name) {
        return Target.the("Message")
                .locatedBy("//*[normalize-space()='" + name + "']/parent::div/following-sibling::div//input | //*[normalize-space()='" + name + "']/following-sibling::div//input");
    }

    public static Target ICON_CIRCLE_DELETE = Target.the("Icon circle delete")
            .locatedBy("//div[@role='alert']//i[contains(@class,'el-icon-close')]");
    public static Target CLOSE_POPUP_BTN = Target.the("CLOSE POPUP")
            .locatedBy("//div[@role='dialog' and not(contains(@style,'display: none'))]//button[@aria-label='Close']");
}

package cucumber.user_interface.beta.Vendor;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class CommonVendorPage {

    public static Target DYNAMIC_ITEM_DROPDOWN(String value) {
        return Target.the(value)
                .located(By.xpath("//div[@x-placement]//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target DYNAMIC_ITEM_DROPDOWN1(String value) {
        return Target.the(value)
                .located(By.xpath("//div[@x-placement]//*[text()=\"" + value + "\"]"));
    }

    public static Target DYNAMIC_ITEM_DROPDOWN2(String value) {
        return Target.the("Value: " + value)
                .located(By.xpath("//ul[@x-placement]//*[text()='" + value + "']"));
    }

    public static Target DYNAMIC_BUTTON(String value) {
        return Target.the(value + " button")
                .located(By.xpath("(//button//span[contains(text(),'" + value + "')])[last()]"));
    }

    public static Target DYNAMIC_BUTTON2(String value) {
        return Target.the(value + " button")
                .located(By.xpath("(//span[contains(text(),'" + value + "')]/ancestor::button)"));
    }

    public static Target DYNAMIC_FIELD(String value) {
        return Target.the(value + "button")
                .located(By.xpath("(//label[normalize-space()='" + value + "']/parent::div/following-sibling::div//input)[last()]"));
    }

    public static Target DYNAMIC_INPUT(String value) {
        return Target.the(value + " Field ")
                .located(By.xpath("(//label[normalize-space()=\"" + value + "\"]/following-sibling::div//input)[last()]"));
    }

    public static Target DYNAMIC_INPUT2(String value) {
        return Target.the(value + " Field ")
                .located(By.xpath("(//span[normalize-space()=\"" + value + "\"]/parent::label/following-sibling::div//input)[last()]"));
    }

    public static Target DYNAMIC_INPUT_AFTER_DIV(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//div[normalize-space()='" + value + "']/following-sibling::div//input"));
    }

    public static Target DYNAMIC_FIELD2(String value, int index) {
        return Target.the(value + "button")
                .located(By.xpath("(//label[normalize-space()='" + value + "']//parent::div/following-sibling::div//input)[" + index + "]"));
    }

    public static Target DYNAMIC_TEXT_AREA(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//span[normalize-space()='" + value + "']//parent::label/following-sibling::div//textarea"));
    }

    public static Target DYNAMIC_TEXT_AREA2(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//label[normalize-space()='" + value + "']/following-sibling::div//textarea"));
    }
    public static Target DYNAMIC_DIALOG_TEXT_AREA(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//div[@role='dialog' and not(contains(@style,'display: none'))]//label[normalize-space()='" + value + "']/following-sibling::div//textarea"));
    }

    public static Target DELETE_BOTTLE_DEPOSIT(int i) {
        return Target.the("")
                .located(By.xpath("(//div[@class='el-row']//label[normalize-space()='Bottle Deposit']//parent::div/parent::div/following-sibling::div/button)[" + i + "]"));
    }

    public static Target DYNAMIC_P_ALERT(String alert) {
        return Target.the("alert message")
                .locatedBy("//p[contains(text(),\"" + alert + "\")]");
    }
    public static Target DYNAMIC_ALERT_BUTTON(String button) {
        return Target.the("button on alert message")
                .locatedBy("//div[@role='alert']//button[contains(text(),\"" + button + "\")]");
    }
    public static Target DYNAMIC_ALERT_TEXT(String name) {
        if (name.contains("\"")) {
            return Target.the("Label error of " + name)
                    .locatedBy("//div[@role='alert']//*[contains(text(),'" + name + "')]");
        } else
            return Target.the("Label error of " + name)
                    .locatedBy("//div[@role='alert']//*[contains(text(),\"" + name + "\")]");
    }
    public static Target DYNAMIC_A_TEXT(String alert) {
        return Target.the("text " + alert)
                .locatedBy("//a[contains(text(),\"" + alert + "\")]");
    }

    public static Target DYNAMIC_ANY_TEXT(String alert) {
        return Target.the("text " + alert)
                .locatedBy("//*[text()=\"" + alert + "\"]");
    }

    public static Target DYNAMIC_CONTAIN_ANY_TEXT(String alert) {
        String xpath = "//*[contains(text(),'" + alert + "')]";
        if (alert.contains("'"))
            xpath = "//*[contains(text(),\"" + alert + "\")]";
        return Target.the("text " + alert)
                .locatedBy(xpath);
    }

    public static Target D_ALERT_CLOSE_BUTTON = Target.the("Alert message close button")
            .locatedBy("//div[@role='alert']//i[contains(@class,'el-icon-close')]");

    public static Target D_DIALOG_CLOSE_BUTTON = Target.the("Alert message close button")
            .locatedBy("(//div[@role='dialog' and not(contains(@style,'display: none'))]//i[contains(@class,'el-icon-close')])");

    public static Target D_DIALOG_BUTTON = Target.the("Alert message close button")
            .locatedBy("//div[@role='dialog' and not(contains(@style,'display: none'))]//button[contains(@class,'el-button')]");

    public static Target DYNAMIC_DIALOG_MESSAGE = Target.the("Alert message")
            .locatedBy("//div[@role='dialog']//span[@class='message']");

    public static Target DYNAMIC_DIALOG_TEXT(String text) {
        return Target.the("text " + text)
                .locatedBy("//div[@role='dialog']//*[contains(text(),\"" + text + "\")]");
    }

    public static Target D_ALERT_CLOSE_BUTTON1 = Target.the("Alert message close button")
            .locatedBy("//div[@class='el-message el-message--success is-closable']//i[contains(@class,'el-icon-close')]");

    public static Target DYNAMIC_DIALOG_BUTTON(String value) {
        return Target.the("Loading " + value)
                .locatedBy("//div[@role='dialog']//button//span[contains(text(),'" + value + "')]");
    }

    public static Target DYNAMIC_DIALOG_BUTTON2(String value) {
        return Target.the("Loading " + value)
                .locatedBy("//div[@role='dialog']//button[contains(text(),'" + value + "')]");
    }

    public static Target DYNAMIC_DIALOG_INPUT(String value) {
        return Target.the("Loading " + value)
                .locatedBy("//div[@role='dialog']//label[normalize-space()='" + value + "']/following-sibling::div//input");
    }

    public static Target LOADING_ICON(String value) {
        return Target.the("Loading " + value)
                .locatedBy("//div[contains(text(),'" + value + "')]");
    }

    public static Target HELP_TOOLTIP(String field) {
        return Target.the("Help tooltip")
                .located(By.xpath("//span[text()='" + field + "']//*[contains(@class,'help')]"));
    }

    public static Target PAGE_ACTION(String field) {
        return Target.the("Help tooltip")
                .located(By.xpath("//div[@class='page__actions']//*[text()='" + field + "']"));
    }

    public static Target RECORD = Target.the("records on page").locatedBy("//a[contains(@class,'record')]");

    public static Target PAGE(String num) {
        return Target.the("records on page").locatedBy("//li[normalize-space()='" + num + "']");
    }


    public static Target ARROW_RIGHT = Target.the("records on page").locatedBy("//i[@class='el-icon el-icon-arrow-right']");
    public static Target ARROW_LEFT = Target.the("records on page").locatedBy("//i[@class='el-icon el-icon-arrow-left']");

    public static Target LOADING = Target.the("Loading icon")
            .locatedBy("//div[@class='loading no-padding']//div[@class='loading--indicator']");

}

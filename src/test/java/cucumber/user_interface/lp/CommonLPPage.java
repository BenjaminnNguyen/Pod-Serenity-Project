package cucumber.user_interface.lp;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class CommonLPPage {

    public static Target DYNAMIC_ITEM_DROPDOWN(String value) {
        return Target.the(value)
                .located(By.xpath("//div[@class='el-scrollbar']//*[contains(text(),'" + value + "')]"));
    }

    public static Target DYNAMIC_ITEM_DROPDOWN_1(String value) {
        return Target.the(value)
                .located(By.xpath("//div[contains(@x-placement,'start')]//*[text()='" + value + "']"));
    }

    public static Target DYNAMIC_ITEM_DROPDOWN_2(String value) {
        return Target.the(value)
                .located(By.xpath("//div[@x-placement]//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target LOADING_ICON(String value) {
        return Target.the("Loading " + value)
                .locatedBy("//div[text()='" + value + "']");
    }

    public static Target DYNAMIC_BUTTON(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//button//span[contains(text(),'" + value + "')]"));
    }

    public static Target DYNAMIC_BUTTON2(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//button//span[text()='" + value + "']"));
    }

    public static Target DYNAMIC_BUTTON3(String value) {
        return Target.the(value + "button")
                .located(By.xpath("(//button//span[text()='" + value + "'])[last()]"));
    }

    public static Target DYNAMIC_ALERT(String alert) {
        return Target.the("ALERT SUCCESS")
                .locatedBy("//p[contains(text(),\"" + alert + "\")]");
    }

    public static Target DYNAMIC_SEARCH_FIELD(String value) {
        return Target.the("ALERT SUCCESS")
                .located(By.xpath("(//label[contains(text(),'" + value + "')]/following-sibling::div//input)[last()]"));
    }

    public static Target PRODUCT_NAME(String nameProduct) {
        return Target.the("Preview product by name " + nameProduct)
                .locatedBy("//div[@class='products-grid']//a[normalize-space()='" + nameProduct + "']");
    }

    public static Target ICON_CIRCLE_DELETE = Target.the("Icon circle delete")
            .locatedBy("//i[contains(@class,'el-icon-circle-close')]");

    public static Target ALL_FILTER = Target.the("ALL_FILTER")
            .locatedBy("//div[@class='field more']");

    public static Target ICON_CIRCLE_DELETE1 = Target.the("Icon circle delete")
            .locatedBy("//i[contains(@class,'el-icon-close')]");

    public static Target SEARCH = Target.the("SEARCH")
            .locatedBy("//input[@placeholder='Search for products, SKUs, UPC, EAN...']");

    public static Target SEARCH_FILTER = Target.the("SEARCH")
            .locatedBy("//div[@class='results']//div[contains(@class,'sort')]//input");

    public static Target ALERT_CLOSE_BUTTON = Target.the("Alert close button")
            .located(By.xpath("//div[@class='el-notification__closeBtn el-icon-close']"));
    public static Target FILE = Target.the("Upload file button")
            .located(By.xpath("//input[@type='file']"));
}

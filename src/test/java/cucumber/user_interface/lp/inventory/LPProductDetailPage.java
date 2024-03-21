package cucumber.user_interface.lp.inventory;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class LPProductDetailPage {

    public static Target DYNAMIC_ITEM_DROPDOWN(String value) {
        return Target.the(value)
                .located(By.xpath("//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target DYNAMIC_ITEM_DROPDOWN_1(String value) {
        return Target.the(value)
                .located(By.xpath("//div[contains(@x-placement,'start')]//*[text()='" + value + "']"));
    }

    public static Target LOADING_ICON(String value) {
        return Target.the("Loading " + value)
                .locatedBy("//div[text()='" + value + "']");
    }

    public static Target DYNAMIC_BUTTON(String value) {
        return Target.the(value + "button")
                .located(By.xpath("//button//span[contains(text(),'" + value + "')]"));
    }

    public static Target DYNAMIC_ALERT(String alert) {
        return Target.the("ALERT SUCCESS")
                .locatedBy("//p[contains(text(),'" + alert + "')]");
    }

    public static Target PRODUCT_NAME(String nameProduct) {
        return Target.the("Preview product by name " + nameProduct)
                .locatedBy("//div[@class='products-grid']//a[normalize-space()='" + nameProduct + "']");
    }


    public static Target SEARCH = Target.the("Icon circle delete")
            .locatedBy("//input[@placeholder='Search for products, SKUs, UPC, EAN...']");

    public static Target PRODUCT_NAME = Target.the("Icon circle delete")
            .locatedBy("//div[@class='general-information']//div[@class='name']");

    public static Target BRAND_NAME = Target.the("Icon circle delete")
            .locatedBy("//div[@class='name pf-ellipsis']");

    public static Target AVAILABLE = Target.the("Icon circle delete")
            .locatedBy("//section[@class='regions']//div[@class='tags']");

    public static Target UNIT_UPC = Target.the("Icon circle delete")
            .locatedBy("//div[contains(@class,'upc-number')]");

    public static Target CASE_PACK = Target.the("Icon circle delete")
            .locatedBy("//dt[normalize-space()='Case Pack']/following-sibling::dd");
}

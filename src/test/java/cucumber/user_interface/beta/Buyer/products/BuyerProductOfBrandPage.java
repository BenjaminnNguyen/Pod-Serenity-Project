package cucumber.user_interface.beta.Buyer.products;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class BuyerProductOfBrandPage {

    public static Target PRODUCT_NAME(String name) {
        return Target.the("Product Name")
                .located(By.xpath("//div[@class='caption']/a[normalize-space()='" + name + "']"));
    }
    public static Target BRAND_NAME(String name) {
        return Target.the("Brand Name")
                .located(By.xpath("//a[normalize-space()='" + name + "']/parent::div//div[contains(@class,'brand-section')]"));
    }

    public static Target UNIT_PRICE(String name) {
        return Target.the("unit price")
                .locatedBy("//a[normalize-space()='" + name + "']/parent::div/following-sibling::div/div[@class='unit-price']/span");

    }
    public static Target NUMBER_SKUS(String name) {
        return Target.the("unit price")
                .locatedBy("//a[normalize-space()='" + name + "']/parent::div/following-sibling::div/div[@class='skus']/span");

    }
//
//    public static Target NUMBER_SKUS = Target.the("unit price")
//            .located(By.cssSelector("div[class='skus'] span"));
}

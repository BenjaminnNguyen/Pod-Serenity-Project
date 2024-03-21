package cucumber.user_interface.beta.Vendor;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class VendorCatalogPage {
    public static Target BRANDS_GRID = Target.the("")
            .locatedBy("div.brands-grid");
    public static Target BRANDS_CARD = Target.the("")
            .locatedBy("//article[@class='brand-card']");

    public static Target BRANDS_NAME(String brandName) {
        return Target.the(brandName)
                .locatedBy("//article//a[contains(text(),'" + brandName + "')]");
    }

    public static Target BRANDS_ADDRESS = Target.the("")
            .locatedBy("//article[@class='brand-card']/div/div");
    public static Target PRODUCTS_GRID = Target.the("")
            .locatedBy("div.products-grid.pen");

    public static Target PRODUCT_NAME(String product) {
        return Target.the("Product name").locatedBy("//a[contains(@class,'product') and text()='" + product + "']");
    }

    public static Target BRAND_NAME(String brand) {
        return Target.the("Brand name").locatedBy("//div[@class='caption']/a[normalize-space()='" + brand + "']");
    }

    public static Target PRODUCT_NAME = Target.the("")
            .locatedBy("//article[@class='brand-card']/div/div");
    public static Target NO_RESULTS_FOUND = Target.the("No results found")
            .located(By.xpath("//span[normalize-space()='No results found']"));

}

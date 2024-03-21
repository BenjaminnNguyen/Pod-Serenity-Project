package cucumber.user_interface.beta.Buyer.brands;

import net.serenitybdd.screenplay.targets.Target;

public class BrandsPage {

    public static Target BRAND_IN_GRID(String brandName) {
        return Target.the("'Brand in all brands page'")
                .locatedBy("//article[@class='brand-card']//a[text()='" + brandName + "']");
    }

    public static Target PRODUCT_TAB = Target.the("'Product tab'")
                .locatedBy("//div[text()='Products']");

    public static Target ABOUT_TAB = Target.the("'About tab'")
            .locatedBy("//div[text()='About']");
}

package cucumber.user_interface.admin.inventory;

import net.serenitybdd.screenplay.targets.Target;

public class ZeroQuantityPage {

    public static Target PRODUCT_NAME = Target.the("Product name")
            .locatedBy("//div[contains(@class,'product')]/span");

    public static Target DYNAMIC_TEXT(String value) {
        return Target.the("Text " + value)
                .locatedBy("//td[contains(@class,'" + value + "')]/div");
    }

    public static Target VENDOR_COMPANY_RESULT = Target.the("Vendor company")
            .locatedBy("//td[contains(@class,'vendor-company')]//span");

    public static Target REGION_RESULT = Target.the("Region")
            .locatedBy("//td[contains(@class,'region')]//span");
}

package cucumber.user_interface.admin.inventory;

import net.serenitybdd.screenplay.targets.Target;

public class AdminRunningLowPage {

    public static Target PRODUCT_NAME = Target.the("Product name")
            .locatedBy("//div[contains(@class,'product')]/span");

    public static Target DYNAMIC_TEXT(String value) {
        return Target.the("Text " + value)
                .locatedBy("//td[contains(@class,'" + value + "')]/div");
    }

    public static Target DYNAMIC_TB(String sku, String class_) {
        return Target.the("Text " + sku)
                .locatedBy("(//div[contains(text(),'" + sku + "')]/ancestor::tr/td[contains(@class,'" + class_ + "')])[last()]");
    }

    public static Target DYNAMIC_TB2(String sku, String class_) {
        return Target.the("Text " + sku)
                .locatedBy("//div[contains(text(),'" + sku + "')]/ancestor::tr/td[contains(@class,'" + class_ + "')]//span[@data-original-text]");
    }

    public static Target VENDOR_COMPANY_RESULT = Target.the("Vendor company")
            .locatedBy("//td[contains(@class,'vendor-company')]//span");

    public static Target REGION_RESULT = Target.the("Region")
            .locatedBy("//td[contains(@class,'region')]//span");
}

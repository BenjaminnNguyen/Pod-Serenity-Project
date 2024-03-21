package cucumber.user_interface.beta.Vendor.inventory;

import net.serenitybdd.screenplay.targets.Target;

public class InventoryStatusPage {

    public static Target PRODUCT_NAME_FIRST_ROW = Target.the("Product name in first row")
            .locatedBy("(//tr)[2]//td[@class='name']//a");

    public static Target PRODUCT_NAME(int i) {
        return Target.the("Product name")
                .locatedBy("(//tbody//tr)[" + i + "]//td[@class='name']//a");
    }

    public static Target BRAND_NAME(int i) {
        return Target.the("Product name")
                .locatedBy("(//tbody//tr)[" + i + "]//td[@class='name']//div[@class='brand']");
    }
    public static Target SKU_NAME(int i) {
        return Target.the("Product name")
                .locatedBy("(//tbody//tr)[" + i + "]//td[@class='name']//div[@class='sku']");
    }
    public static Target DYNAMIC_VALUE(int i, String title) {
        return Target.the("Product name")
                .locatedBy("(//tbody//tr)[" + i + "]//td[@class='" + title + "']//span");
    }

    public static Target BRAND_NAME_FIRST_ROW = Target.the("Brand name in first row")
            .locatedBy("((//tr)[2]//td[@class='name']//div)[1]");

    public static Target SKU_NAME_FIRST_ROW = Target.the("Sku name in first row")
            .locatedBy("((//tr)[2]//td[@class='name']//div)[2]");

    public static Target DYNAMIC_VALUE_FIRST_ROW(String title) {
        return Target.the(title + " in first row")
                .locatedBy("(//tr)[2]//td[@class='" + title + "']//span");
    }
}

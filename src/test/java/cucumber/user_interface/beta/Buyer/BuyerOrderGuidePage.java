package cucumber.user_interface.beta.Buyer;

import net.serenitybdd.screenplay.targets.Target;

public class BuyerOrderGuidePage {

    public static Target ITEM_CODE = Target.the("ITEM_CODE")
            .locatedBy("//input[@placeholder='Search item code or Brand name']");

    public static Target TIME_INTERVAL = Target.the("TIME_INTERVAL")
            .locatedBy("//div[contains(text(),'Time interval')]/following-sibling::div//input");
    public static Target ORDER_BY = Target.the("ORDER_BY")
            .locatedBy("//div[contains(text(),'Order by')]/following-sibling::div//input");
    public static Target STORE = Target.the("ORDER_BY")
            .locatedBy("//div[contains(text(),'Store')]/following-sibling::div//input");
    public static Target ACTIVE_ONLY = Target.the("ACTIVE_ONLY")
            .locatedBy("//span[@class='el-switch__core']");

    public static Target IMAGE_SKU(String sku) {
        return Target.the(sku)
                .locatedBy("//div[@class='info-variant__name' and contains(text(),'" + sku + "')]/ancestor::div[@class='edt-row']//div[@class='contain']");
    }

    public static Target SKU_INFO(String sku, String class_) {
        return Target.the(sku + class_)
                .locatedBy("//div[@class='info-variant__name' and contains(text(),'" + sku + "')]/ancestor::div[contains(@class,'edt-row')]//div[@class='" + class_ + "']");
    }

    public static Target SKU_INFO2(String sku, String class_) {
        return Target.the(sku + class_)
                .locatedBy("//div[@class='info-variant__name' and contains(text(),'" + sku + "')]/ancestor::div[contains(@class,'edt-row')]//span[@class='" + class_ + "']");
    }

    public static Target ADD_CART(String sku) {
        return Target.the(sku + "add cart btn")
                .locatedBy("//div[@class='info-variant__name' and contains(text(),'" + sku + "')]/ancestor::div[contains(@class,'edt-row')]//div[contains(@class,'edt-piece action')]/button");
    }

    public static Target ORDER_DATE(String sku, int i) {
        return Target.the(sku)
                .locatedBy("(//div[@class='info-variant__name' and contains(text(),'" + sku + "')]/ancestor::div[contains(@class,'edt-row')]//div[@class='edt-piece date-quantity']/dl[@class='metas']/dt)[" + i + "]");
    }

    public static Target ORDER_QTY(String sku, int i) {
        return Target.the(sku)
                .locatedBy("(//div[@class='info-variant__name' and contains(text(),'" + sku + "')]/ancestor::div[contains(@class,'edt-row')]//div[@class='edt-piece date-quantity']/dl[@class='metas']/dd)[" + i + "]");
    }

    public static Target TAGS_FILTER(String title) {
        return Target.the(title)
                .locatedBy("//section[@class='product-tags']//span[contains(text() , '" + title + "')]");
    }

    public static Target RECOMMENDED_PRODUCT(String product, String class_) {
        return Target.the("RECOMMENDED_PRODUCT")
                .locatedBy("//a[contains(text(),'" + product + "')]/ancestor::article//*[@class= '" + class_ + "']");
    }

    public static Target TOOLTIP_PROMO(String class_) {
        return Target.the("SKU_NAME_IN_PREVIEW")
                .locatedBy("//div[@role = 'tooltip' and @x-placement]//*[contains(@class,'" + class_ + "')]");
    }
}

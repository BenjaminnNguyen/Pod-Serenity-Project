package cucumber.user_interface.beta.Buyer;

import net.serenitybdd.screenplay.targets.Target;

public class BuyerFavoritesPage {

    public static Target SKU_INFO(String sku, String class_) {
        return Target.the(sku + class_)
                .locatedBy("//span[contains(text(),'" + sku + "')]/ancestor::article//*[contains(@class,'" + class_ + "')]");
    }

    public static Target SKU_INFO2(String sku, String class_) {
        return Target.the(sku + class_)
                .locatedBy("//div[@class='info-variant__name' and contains(text(),'" + sku + "')]/ancestor::div[contains(@class,'edt-row')]//span[@class='" + class_ + "']");
    }

    public static Target FAVORITE_ICON = Target.the("FAVORITE_ICON").locatedBy("//div[@class='heart animated']");
    public static Target CART_ICON = Target.the("CART_ICON").locatedBy("//div[@class='quick-actions']//button[@type='button']");
}

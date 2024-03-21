package cucumber.user_interface.beta.Vendor.products;

import net.serenitybdd.screenplay.targets.Target;

public class VendorProductForm {

    public static Target PREVIEW_PRODUCT_BY_NAME(String nameProduct) {
        return Target.the("Preview product by name " + nameProduct)
                .locatedBy("(//div[text()='" + nameProduct + "']/ancestor::div/following-sibling::div//button)[1]");
    }

    public static Target DUPLICATE_PRODUCT_BY_NAME(String nameProduct) {
        return Target.the("Preview product by name " + nameProduct)
                .locatedBy("(//div[text()='" + nameProduct + "']/ancestor::div/following-sibling::div//button)[2]");
    }

    public static Target DELETE_PRODUCT_BY_NAME(String nameProduct) {
        return Target.the("Preview product by name " + nameProduct)
                .locatedBy("(//div[text()='" + nameProduct + "']/ancestor::div/following-sibling::div//button)[3]");
    }

    public static Target PRODUCT_NAME(String nameProduct) {
        return Target.the("Preview product by name " + nameProduct)
                .locatedBy("//div[@class='edt-piece product']//div[normalize-space()='" + nameProduct + "']");
    }

    public static Target DYNAMIC_PRODUCT_INFO(String nameProduct, String col) {
        return Target.the("Preview product by name " + nameProduct)
                .locatedBy("//*[text()='" + nameProduct + "']/ancestor::a//div[contains(@class,'" + col + "')]//span");
    }

    public static Target DYNAMIC_PRODUCT_IMAGE(String nameProduct) {
        return Target.the("Preview product by name " + nameProduct)
                .locatedBy("//*[text()='" + nameProduct + "']/ancestor::a//div[contains(@class,'edt-preview aic')]//div[@style]");
    }


    public static Target DELETE_BUTTON = Target.the("Button delete")
                .locatedBy("//div[@class='products-list']//button");

    /**
     * Page navigator
     */

    public static Target PAGE_NAVIGATOR(int index) {
        return Target.the("Page navigator")
                .locatedBy("//ul[@class='el-pager']/li[text()='" + index + "']");
    }
}

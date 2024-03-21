package cucumber.user_interface.beta.Vendor.brands;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class VendorDetailBrandCatalogPage {

    public static Target PRODUCT_TAP = Target.the("The product tap")
            .located(By.id("tab-products"));
    public static Target BRAND_NAME = Target.the("The brand name")
            .located(By.cssSelector("div[class='name pf-ellipsis']"));
    public static Target BRAND_ADDRESS = Target.the("The brand address")
            .located(By.cssSelector("div.address"));
    public static Target ABOUT_TAP = Target.the("The about tap")
            .locatedBy("//div[@id='tab-about']");
    public static Target DESCRIPTION = Target.the("The description")
            .located(By.xpath("//div[@class='content']"));
    public static Target PRODUCT_NAME = Target.the("The product name")
            .locatedBy(".product.pf-ellipsis");
    public static Target LOGO_BRAND = Target.the("The logo of brand")
            .locatedBy("//div[@class='flex']//div[@class='logo']/a");
    public static Target COVER_IMAGE_BRAND = Target.the("The cover image of brand")
            .locatedBy("//div[@class='cover']");

    public static Target PHOTO_OF_BRAND_CATALOG(int i) {
        return Target.the("Photo").locatedBy("(//div[@class='image'])[" + i + "]/div");
    }

    public static Target PRODUCT_NAME(String product) {
        return Target.the("Product name").locatedBy("//a[contains(@class,'product pf-ellipsis') and text()='" + product + "']");
    }

    public static Target LOADING_PRODUCT = Target.the("The product name")
            .locatedBy("//div[text()='Loading product...']");
}

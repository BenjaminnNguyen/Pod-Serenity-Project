package cucumber.user_interface.beta.Vendor.brands;

import net.serenitybdd.screenplay.targets.Target;

public class VendorDetailBrandDashboardPage {

    public static Target BRAND_NAME = Target.the("The new brands")
            .locatedBy(".vendors-dashboard .page__title");

    public static Target BRAND_DESCRIPTION = Target.the("The description")
            .locatedBy(".vendors-dashboard .description");

    public static Target BRAND_COUNTRY = Target.the("The country box")
            .locatedBy("(//dl[@class='metas']//span[@class='state'])[2]");

    public static Target BRAND_STATE = Target.the("The state")
            .locatedBy("(//dl[@class='metas']//span[@class='state'])[1]");

    public static Target BRAND_CITY = Target.the("The city")
            .locatedBy("dl[class='metas'] span[class='city']");

    public static Target BRAND_PRICING = Target.the("The pricing")
            .locatedBy("//div[@class='pricing']");

    public static Target BUTTON_REMOVE = Target.the("button remove")
            .locatedBy("//button[@type='button']//span//span[contains(text(),'Remove')]");

    public static Target UPLOAD_LOGO = Target.the("upload logo")
            .locatedBy("//span[normalize-space()='Logo']/following-sibling::input");

    public static Target UPLOAD_COVER = Target.the("upload cover")
            .locatedBy("//span[normalize-space()='Cover']/following-sibling::input");

    public static Target UPLOAD_PHOTOS = Target.the("upload photos")
            .locatedBy("//span[normalize-space()='Photos']/following-sibling::input");
    public static Target LIST_PHOTOS = Target.the("upload photos")
            .locatedBy("//div[@class='image']");
    public static Target UPLOAD_PHOTO = Target.the("upload photos")
            .locatedBy("//span[normalize-space()='Photos']/..");

    public static Target PHOTO_OF_BRAND(String photo) {
        return Target.the("Photo").locatedBy("//div[@class='image' and contains(@style,'" + photo + "')]");
    }

    public static Target DELETE_PHOTO_OF_BRAND(String photo) {
        return Target.the("Photo").locatedBy("//div[@class='image' and contains(@style,'" + photo + "')]//div[@class='remove']");
    }

    public static Target PHOTO_OF_BRAND_DASHBOARD(int i) {
        return Target.the("Photo").locatedBy("(//div[@class='image'])[" + i + "]");
    }

    public static Target LOGO_BRAND = Target.the("The logo of brand")
            .locatedBy("//div[@class='page vendors brands details']//div[@class='logo']");

    public static Target COVER_IMAGE_BRAND = Target.the("The cover image of brand")
            .locatedBy("//div[@class='cover with-backdrop']");


    public static Target BRAND_LIST(int i, String class_) {
        return Target.the("upload photos")
                .locatedBy("(//div[@class='brands-list']/a)[" + i + "]//div[contains(@class,'" + class_ + "')]");
    }


    public static Target BRAND_NAME(String name) {
        return Target.the("upload photos")
                .locatedBy("//div[@class='brands-list']//div[contains(text(),'" + name + "')]");
    }

    public static Target BRAND_DELETE(String name) {
        return Target.the("upload photos")
                .locatedBy("//div[contains(text(),'" + name + "')]//ancestor::div[@class='edt-piece brand']/following-sibling::div[@class='edt-piece actions tr']//button");
    }


}

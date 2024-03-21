package cucumber.user_interface.beta.Vendor;

import net.serenitybdd.screenplay.targets.Target;

public class VendorDashboardPage {
    public static Target OPTION(String title) {
        return Target.the("Parent Menu " + title)
                .locatedBy("//div[contains(@class,'item')]//*[text()='" + title + "']");
    }

    /**
     * Create New Brand
     */
    public static Target NEW_BRAND_BUTTON = Target.the("The new brands")
            .locatedBy("//span[normalize-space()='New Brand']");

    public static Target BRAND_NAME_CREATE = Target.the("The new brands")
            .locatedBy("//label[text()='Brand name']/following-sibling::div//input");

    public static Target BRAND_DESCRIPTION_CREATE = Target.the("The description")
            .locatedBy("//textarea[@class='el-textarea__inner']");

    public static Target BRAND_CONTRY_CREATE = Target.the("The country box")
            .locatedBy("//div[@class='el-select entity-select db country-select']//input");

    public static Target DYNAMIC_DROPDOWN_OPTION(String title) {
        return Target.the(title)
                .locatedBy("//li//span[normalize-space()='" + title + "']");
    }

    public static Target BRAND_STATE_CREATE = Target.the("The state")
            .locatedBy("//div[@class='el-select entity-select db address-state-select']//input");

    public static Target BRAND_CITY_CREATE = Target.the("The city")
            .locatedBy("//label[normalize-space()='City']/following-sibling::div//input");

    public static Target BUTTON_CREATE = Target.the("button create")
            .locatedBy("//button[normalize-space()='Create']");

    public static Target allBrands = Target.the("All brands")
            .locatedBy("//a[@title='Brands']");

    public static Target allBrandsTitle = Target.the("")
            .locatedBy("//h1[normalize-space()='All brands']");

    public static Target SEARCH_BOX = Target.the("search box")
            .locatedBy("(//div[@class='search-box']//input)[2]");

    public static Target BRANDS_GRID = Target.the("search box")
            .locatedBy("div.brands-grid.pen");

    public static Target PRODUCT_GRID = Target.the("search box")
            .locatedBy("div.products-grid.pen");

    public static Target NEW_PRODUCT = Target.the("The new brands")
            .locatedBy("//a[normalize-space()='New Product']");

    public static Target DASHBOARD = Target.the("The Dashboard button")
            .locatedBy("//div[@class='user-links']//span[normalize-space()='Dashboard']");

    public static Target ORDERS = Target.the("The Orders")
            .locatedBy("//h1[normalize-space()='Orders']");

    public static Target DASH_BRAND_NAME(String brandName) {
        return Target.the("The Brand name " + brandName)
                .locatedBy("//div[contains(@class,'name') and text()='" + brandName + "']");
    }

    public static Target DASH_BRAND_ADDRESS(String brandName) {
        return Target.the("The Brand address")
                .locatedBy("//div[contains(@class,'name') and text()='" + brandName + "']/ancestor::div/following-sibling::div[contains(@class,'address')]/span");
    }

    public static Target BRAND_NAME(String name) {
        return Target.the("Brand name " + name).locatedBy("//div[@class='name pf-ellipsis focus' and normalize-space()='" + name + "']");
    }

    public static Target DASH_BRAND_DESCRIPTION(String brandName) {
        return Target.the("The brand description")
                .locatedBy("//div[contains(@class,'name') and text()='" + brandName + "']/following-sibling::div[contains(@class,'description')]");
    }

    public static Target NEXT_PAGE_BUTTON = Target.the("The next page")
            .locatedBy("button.btn-next");


}

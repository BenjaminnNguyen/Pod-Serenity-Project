package cucumber.user_interface.beta.Vendor.products;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class VendorProductDetailPage {

    public static Target ADD_NEW_SKU_BUTTON = Target.the("Add new sku button")
            .located(By.xpath("//span[normalize-space()='Create new SKU']/parent::a"));

    public static Target PRODUCT_NAME = Target.the("Product name")
            .located(By.xpath("//div[@class='general-information']//div[@class='name']/h1"));

    public static Target BRAND_NAME = Target.the("Brand name")
            .located(By.cssSelector("div[class='name pf-ellipsis']"));

    public static Target UNIT_DIMENSIONS = Target.the("Unit Dimensions")
            .locatedBy("//dt[normalize-space()='Unit Dimensions']/following-sibling::dd");

    public static Target UNIT_UPC = Target.the("UNIT_UPC")
            .locatedBy("//dt[normalize-space()='Unit UPC / EAN']/following-sibling::dd");

    public static Target MIN_ORDER_QTY = Target.the("MIN_ORDER_QTY")
            .locatedBy("//dt[normalize-space()='Minimum Order Quantity']/following-sibling::dd");

    public static Target CASE_DIMENSIONS = Target.the("Unit Dimensions")
            .locatedBy("//dt[normalize-space()='Case Dimensions']/following-sibling::dd");

    public static Target UNIT_SIZE = Target.the("Unit size")
            .locatedBy("//dt[normalize-space()='Unit Size']/following-sibling::dd");

    public static Target CASE_PACK = Target.the("Unit size")
            .locatedBy("//dt[normalize-space()='Case Pack']/following-sibling::dd");

    public static Target productName(String product) {
        return Target.the("Product name").locatedBy("//a[@class='product pf-ellipsis' and text()='" + product + "']");
    }

    public static Target REGION_NAME = Target.the("Region name")
            .locatedBy("//td[@class='region']/span");

    public static Target MASTER_IMAGE = Target.the("MASTER_IMAGE")
            .locatedBy("//div[@class='product-images-swiper']//div[@class='master']//div[@class='contain']");

    public static Target MASTER_IMAGE_SKU_NAME = Target.the("MASTER_IMAGE_SKU_NAME")
            .locatedBy("//div[@class='indicator']//div[@class='variant pf-ellipsis']");

    public static Target MASTER_IMAGE_SKU_NUMBER = Target.the("MASTER_IMAGE_SKU_NAME")
            .locatedBy("//div[@class='indicator']//div[@class='counter']");

    public static Target TAP_PRODUCT_DESCRIPTION = Target.the("TAP_PRODUCT_DESCRIPTION")
            .located(By.id("tab-description"));

    public static Target TAP_PRODUCT_DETAIL = Target.the("TAP_PRODUCT_DETAIL")
            .located(By.id("tab-detail"));

    public static Target PRODUCT_DESCRIPTION = Target.the("PRODUCT_DESCRIPTION")
            .located(By.id("pane-description"));

    public static Target LIST_SKU_BUTTON_PREVIOUS = Target.the("LIST_SKU_BUTTON")
            .locatedBy("//div[@class='swiper-btn-prev']");

    public static Target LIST_SKU_BUTTON_NEXT = Target.the("LIST_SKU_BUTTON_NEXT")
            .locatedBy("//div[@class='swiper-btn-next']");

    public static Target COPY_ICON = Target.the("COPY_ICON")
            .locatedBy("//i[@class='pf-icon bx bx-clipboard mr icon']");

    public static Target REGION_INFO(String region, String col) {
        return Target.the("Region name")
                .locatedBy("//span[text()='" + region + "']/parent::td/following-sibling::td[@class='" + col + "']");
    }

    public static Target SKU_TAG(int i) {
        return Target.the("Tag name")
                .locatedBy("(//div[@class='tags']/a)[" + i + "]");
    }

    public static Target SKU_TAG_AVAILABLE(int i) {
        return Target.the("Region name")
                .locatedBy("(//div[@class='tags']/span)[" + i + "]");
    }

    public static Target PRICE_PER_UNIT_OF_REGION(String region) {
        return Target.the("").locatedBy("//span[text()='" + region + "']/parent::td/following-sibling::td[@class='price']/span");
    }

    public static Target UNIT_PER_CASE_OF_REGION(String region) {
        return Target.the("").locatedBy("//span[text()='" + region + "']/parent::td/following-sibling::td[@class='case-price']/span");
    }

    public static Target MSRPOF_REGION(String region) {
        return Target.the("").locatedBy("//span[text()='" + region + "']/parent::td/following-sibling::td[@class='msrp']");
    }

    public static Target AVAILABILITY_OF_REGION(String region) {
        return Target.the("").locatedBy("//span[text()='" + region + "']/parent::td/following-sibling::td[@class='pd-availability']");
    }

    public static Target MOQOfRegion(String region) {
        return Target.the("").locatedBy("//span[text()='" + region + "']/parent::td/following-sibling::td[@class='moq']");
    }

    public static Target SKU_NAME(String sku) {
        return Target.the("SKU name").locatedBy("//div[@class='products-list']//div[contains(text(),'" + sku + "')]");
    }

    public static Target SKU_NAME(String tab, String sku) {
        return Target.the("SKU name").locatedBy("//div[normalize-space()='" + tab + " SKUs']/following-sibling::div//div[@class='products-list']//div[contains(text(),'" + sku + "')]");
    }

    public static Target CASE_UNIT(String sku) {
        return Target.the("SKU name").locatedBy("//div[@class='products-list']//div[contains(text(),'" + sku + "')]/following-sibling::div");
    }

    public static Target SKU_IMAGE(String sku) {
        return Target.the("SKU name").locatedBy("//div[@class='products-list']//div[contains(text(),'" + sku + "')]/preceding-sibling::div/div");
    }

    public static Target UNIT_UPC(String sku) {
        return Target.the("SKU name").locatedBy("//div[@class='products-list']//div[contains(text(),'" + sku + "')]/ancestor::div[@class='edt-piece product']/following-sibling::div[@class='edt-piece unit-upc']");
    }

    public static Target CASE_UPC(String sku) {
        return Target.the("SKU name").locatedBy("//div[@class='products-list']//div[contains(text(),'" + sku + "')]/ancestor::div[@class='edt-piece product']/following-sibling::div[@class='edt-piece case-upc']");
    }

    public static Target DYNAMIC_SKU_INFO(String sku) {
        return Target.the("SKU name").locatedBy("//div[@class='products-list']//div[contains(text(),'" + sku + "')]");
    }

    public static Target SKUS_TAB = Target.the("SKUs tap")
            .located(org.openqa.selenium.By.xpath("//a[normalize-space()='Manage SKU >']"));

    public static Target BRAND_LOCATION = Target.the("BRAND_LOCATION")
            .located(By.xpath("//dt[text()='Manufactured in']/following-sibling::dd"));

    public static Target STORAGE_SELF_LIFE = Target.the("STORAGE_SELF_LIFE")
            .located(By.xpath("//dt[text()='Storage shelf life']/following-sibling::dd"));

    public static Target RETAIL_SELF_LIFE = Target.the("RETAIL_SELF_LIFE")
            .located(By.xpath("//dt[text()='Retail shelf life']/following-sibling::dd"));

    public static Target INGREDIENTS = Target.the("INGREDIENTS")
            .located(By.xpath("//div[text()='Ingredients']/following-sibling::div"));

    public static Target TEMPERATURER_EQUIREMENTS = Target.the("INGREDIENTS")
            .located(By.xpath("//dt[text()='Temperature requirements']/following-sibling::dd"));

    public static Target PRODUCT_QUALITIES = Target.the("PRODUCT_QUALITIES")
            .located(By.xpath("//div[text()='Product Qualities']/following-sibling::ul/li"));

    public static Target NUTRITION_IMAGE = Target.the("PRODUCT_QUALITIES")
            .locatedBy("//div[@class='swiper-slide swiper-slide-active']//div[@class='contain']");

    public static Target ADDRESS = Target.the("Address")
            .located(By.cssSelector("span.address"));

    public static Target PRICE_PER_UNIT = Target.the("Product price per unit")
            .located(By.cssSelector("div[class='unit-price'] span[class='current']"));

    public static Target BADGE_DIRECT = Target.the(" badge Direct ")
            .located(By.cssSelector("div.direct-tag"));

    public static Target PRICE_PER_CASE = Target.the("Product price per case")
            .located(By.cssSelector("div[class='case-price'] span[class='current']"));

    public static Target AVAILABILITY = Target.the("Product availability")
            .located(By.xpath("//dd[@class='pd-availability']"));

    public static Target ICON_ADD_TO_FAVORITES = Target.the("Icon Add To Favorites")
            .located(By.cssSelector(".heart"));

    public static Target QUANTITY_BOX = Target.the("Quantity box")
            .located(By.cssSelector("input[role='spinbutton']"));

    public static Target TRUCK_ICON = Target.the("Truck icon")
            .located(By.cssSelector("span.pfd-region-icon"));

    public static Target HELP_TEXT_POD_DIRECT_ITEM = Target.the("Help text of Pod Direct Item")
            .located(By.cssSelector("p.warehoused-buyer-notice"));

    public static Target I_UNDERSTAND = Target.the("I Understand")
            .located(By.xpath("//span[normalize-space()='I understand']"));

    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector(".loading--indicator"));

    // REQUEST SAMPLE
    public static Target ICON_REQUEST_SAMPLE = Target.the("icon Request Sample")
            .located(By.cssSelector("i.fa-eye-dropper"));

    public static Target SAMPLE_REQUEST_MODAL = Target.the("The sample request modal")
            .located(By.cssSelector("div.sample-request-modal"));

    public static Target SUBMIT_REQUEST_BUTTON = Target.the("Submit request button")
            .located(By.cssSelector("div.sample-request-modal button.rb-send"));

    // Tabs
    public static Target PRODUCT_QUALITIES_TAB = Target.the("Product Qualities Tab")
            .located(By.cssSelector("#product-info-tab-tab-4"));

    public static Target ALERT_ADD_CART = Target.the("The Alert message")
            .located(By.xpath("//p[@class='el-message__content']"));

    public static Target ARROW_ICON(String typeArrow) {
        return Target.the("Icon arrow " + typeArrow)
                .locatedBy("//i[contains(@class,'" + typeArrow + "')]");
    }

    public static Target BUTTON_ON_SKU(String sku, int i) {
        return Target.the("BUTTON_ON_SKU ")
                .locatedBy("//div[contains(text(),'" + sku + "')]/ancestor::div[@class='edt-piece product']/following-sibling::div[@class='edt-piece actions tr']//*[contains(@class,'el-button ')][" + i + "]");
    }

    public static Target DYNAMIC_REGION_SKU(String region, int i) {
        return Target.the("DYNAMIC_REGION_SKU ")
                .locatedBy("//strong[contains(text(),'" + region + "')]/parent::div/following-sibling::div[" + i + "]");
    }

    public static Target BREADCRUMB(String title) {
        return Target.the("BREADCRUMB " + title)
                .locatedBy("//div[@aria-label='Breadcrumb']//span[@title='" + title + "']");
    }


}

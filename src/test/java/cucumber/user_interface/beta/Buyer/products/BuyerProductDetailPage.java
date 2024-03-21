package cucumber.user_interface.beta.Buyer.products;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class BuyerProductDetailPage {

    public static Target PRODUCT_NAME_HEADER(String product) {
        return Target.the("Product name header")
                .located(By.xpath("//h1[text()='" + product + "']"));
    }


    public static Target ADD_TO_CART_BUTTON = Target.the("Add To Cart button")
            .located(By.xpath("//span[normalize-space()='Add to Cart']/parent::button"));

    public static Target PRODUCT_NAME = Target.the("Product name")
            .located(By.xpath("//div[@class='general-information']//div[@class='name']/h1"));

    public static Target PRICE_PER_UNIT = Target.the("Product price per unit")
            .located(By.xpath("//div[@class='unit-price']//span[contains(@class,'current')]"));

    public static Target BADGE_DIRECT = Target.the(" badge Direct ")
            .located(By.cssSelector("div.direct-tag"));

    public static Target PRICE_PER_CASE = Target.the("Product price per case")
            .located(By.xpath("//div[@class='price']//span[contains(@class,'current')]"));

    public static Target PRICE_PER_CASE2 = Target.the("Product price per case")
            .located(By.xpath("//div[@class='case-price']//span[contains(@class,'current')]"));

    public static Target BRAND_ADDRESS = Target.the("Address")
            .located(By.xpath("//div[@class='area-heading']//span[contains(@class,'address ')]"));

    public static Target AVAILABILITY = Target.the("Product availability")
            .located(By.xpath("//dd[@class='pd-availability']"));

    public static Target UNIT_UPC_EAN = Target.the("Unit UPC / EAN")
            .located(By.xpath("//div[@class='upc-number ml-1']"));

    public static Target NEW_INVENTORY_ARRIVING = Target.the("New Inventory Arriving")
            .located(By.xpath("//dt[normalize-space()='New Inventory Arriving']/following-sibling::dd[1]"));

    public static Target LOADING_PRODUCT = Target.the("loading")
            .located(By.xpath("//div[@class='loading--explaination']"));

    public static Target ICON_ADD_TO_FAVORITES = Target.the("Icon Add To Favorites")
            .located(By.xpath("//button[@class='favorite has-tooltip']"));

    public static Target ICON_HEART = Target.the("Icon Add To Favorites")
            .located(By.xpath("//div[@class='heart']"));

    public static Target QUANTITY_BOX = Target.the("Quantity box")
            .located(By.cssSelector("input[role='spinbutton']"));

    public static Target TRUCK_ICON = Target.the("Truck icon")
            .located(By.cssSelector("img[src='/img/direct.svg']"));

    public static Target EXPRESS_ICON_PRODUCT = Target.the("EXPRESS_ICON_PRODUCT")
            .locatedBy("//div[@class='general-information']//img[@src='/img/express.svg']");

    public static Target EXPRESS_ICON_PRODUCT_DES = Target.the("EXPRESS_ICON_PRODUCT_DES")
            .locatedBy("//div[@class='express-tag']//span");

    public static Target TRUCK_ICON_PRODUCT_DES = Target.the("EXPRESS_ICON_PRODUCT_DES")
            .locatedBy("//div[@class='direct-tag']//span");

    public static Target EXPRESS_ICON_ITEM(String SKU) {
        return Target.the("Truck icon")
                .locatedBy("//div[contains(text(),'" + SKU + "')]/following-sibling::div//img[@src='/img/express.svg']");
    }


    public static Target HELP_TEXT_POD_DIRECT_ITEM = Target.the("Help text of Pod Direct Item")
            .located(By.cssSelector("p.warehoused-buyer-notice"));

    public static Target I_UNDERSTAND = Target.the("I Understand")
            .located(By.xpath("//span[normalize-space()='I understand']"));

    public static Target LOADING_BAR = Target.the("The loading bar")
            .located(By.cssSelector(".loading-bar"));

    public static Target TAGS_ON_PRODUCT_DETAIL(String tag) {
        return Target.the("TAGS_ON_PRODUCT_DETAIL")
                .locatedBy("//section[@class='tags']//a[contains(@class,'product-tag-stamp')and contains(text(),'" + tag + "')]");
    }


    // REQUEST SAMPLE
    public static Target ICON_REQUEST_SAMPLE = Target.the("icon Request Sample")
            .located(By.cssSelector("i.fa-eye-dropper"));

    public static Target SAMPLE_REQUEST = Target.the("The sample request modal")
            .located(By.xpath("//div[@class='sample-request']"));

    public static Target SUBMIT_REQUEST_BUTTON = Target.the("Submit request button")
            .located(By.cssSelector("div.sample-request-modal button.rb-send"));

    public static Target PRODUCT_QUALITIES_TAB = Target.the("Product Qualities Tab")
            .located(By.cssSelector("#product-info-tab-tab-4"));

    public static Target ALERT_ADD_CART = Target.the("The Alert message")
            .located(By.xpath("//p[@class='el-message__content']"));

    public static Target QUANTITY_FIELD = Target.the("The Quantity field")
            .located(By.xpath("//div[@class='el-input']//input[@role='spinbutton']"));

    public static Target CHOOSE_A_FLAVOR = Target.the("Choose a flavor")
            .located(By.xpath("//input[@placeholder='Choose a flavor']"));

    public static Target MESSAGE_ADD_TO_CART = Target.the("Message Item added to cart!")
            .located(org.openqa.selenium.By.xpath("//p[text()='Item added to cart!']"));

    public static Target SKU_NAME(String sku) {
        return Target.the("SKU name" + sku).locatedBy("//div[@class='name'][contains(text(),'" + sku + "')]");
    }

    public static Target SKU_IN_DETAIL(String sku) {
        return Target.the("SKU name" + sku).locatedBy("//div[@class='skus-list']//div[contains(text(),'" + sku + "')]");
    }

    public static Target SKU_IN_DETAIL_ID(String sku) {
        return Target.the("SKU name" + sku).locatedBy("//div[contains(text(),'" + sku + "') and @class='info-variant__name']/following-sibling::div");
    }

    public static Target SKU_IN_DETAIL_NOT_AVAILABLE(String sku) {
        return Target.the("SKU name" + sku).locatedBy("//div[contains(text(),'" + sku + "') and @class='info-variant__name']/ancestor::div[@class='general']/div[@class='quantity-change']");
    }

    public static Target SKU_IN_DETAIL_PRICE(String sku) {
        return Target.the("SKU name" + sku).locatedBy("//div[contains(text(),'" + sku + "') and @class='info-variant__name']/ancestor::div[@class='general']//span[@class='current']");
    }

    public static Target QUANTITY_SKU_IN_DETAIL(String sku) {
        return Target.the("SKU name" + sku).locatedBy("//div[@class='skus-list']//div[contains(text(),'" + sku + "')]/parent::div/following-sibling::div[@class='quantity-change']//input");
    }

    public static Target QUANTITY_CHANGE_SKU(String sku, String action) {
        return Target.the(action + "SKU name" + sku).locatedBy("//div[@class='skus-list']//div[contains(text(),'" + sku + "')]/parent::div/following-sibling::div[@class='quantity-change']//span[contains(@class,'" + action + "')]");
    }

    public static Target SKU_BY_ID(String id) {
        return Target.the("SKU by ID").locatedBy("//div[@class='sku-id']//span[text()='" + id + "']");
    }

    public static Target DYNAMIC_BUTTON(String name) {
        return Target.the("Pre-order button")
                .located(By.xpath("//button//span[text()='" + name + "']"));
    }

    public static Target DYNAMIC_FIELD(String name) {
        return Target.the("Pre-order button")
                .located(By.xpath("//dt[normalize-space()='" + name + "']/following-sibling::dd[1]"));
    }

    public static Target DYNAMIC_TAG(String skuName) {
        return Target.the("Tag " + skuName)
                .located(By.xpath("//div[@class='variant pf-ellipsis' and text()='" + skuName + "']"));
    }

    /**
     * Promotion
     */

    public static Target UNIT_PRICE_PROMOTED = Target.the("Unit price current promoted")
            .located(By.xpath("//div[@class='unit-price']//span[@class='current promoted']"));

    public static Target CASE_PRICE_PROMOTED = Target.the("Case price current promoted")
            .located(By.xpath("//div[@class='price']//span[contains(@class,'current')]"));

    public static Target TYPE_PROMOTION = Target.the("Type promotion")
            .located(By.xpath("//div[@class='promotion-explained']//div[@class='type flex aic']"));

    public static Target TYPE_PROMOTION(String sku) {
        return Target.the("Type promotion")
                .located(By.xpath("//div[contains(text(),'" + sku + "')]/ancestor::div[@class='general']/following-sibling::div[@class='promotion-explained']//div[@class='type flex aic']"));
    }

    public static Target TYPE_PROMOTION_TAG(String sku) {
        return Target.the("Type promotion")
                .located(By.xpath("//div[contains(text(),'" + sku + "')]/ancestor::div[@class='general']//div[@class='promotions-tag']"));
    }

    public static Target CASE_PRICE_PROMOTED(String sku) {
        return Target.the("Type promotion")
                .located(By.xpath("//div[contains(text(),'" + sku + "')]/ancestor::div[@class='general']//div[@class='price']//span[contains(@class,'current')]"));
    }

    public static Target DISCOUNT_PROMOTION(String sku) {
        return Target.the("Type promotion")
                .located(By.xpath("//div[contains(text(),'" + sku + "')]/ancestor::div[@class='general']/following-sibling::div[@class='promotion-explained']//span[@class='discounted']"));
    }

    public static Target NEW_PRICE_PROMOTION(String sku) {
        return Target.the("Type promotion")
                .located(By.xpath("//div[contains(text(),'" + sku + "')]/ancestor::div[@class='general']/following-sibling::div[@class='promotion-explained']//span[@class='new-price']"));
    }

    public static Target DISCOUNT_PROMOTION = Target.the("Discount promotion")
            .located(By.xpath("//div[@class='promotion-explained']//span[@class='discounted']"));

    public static Target NEW_PRICE_PROMOTION = Target.the("New price promotion")
            .located(By.xpath("//div[@class='promotion-explained']//span[@class='new-price']"));

    public static Target OLD_PRICE_PROMOTION = Target.the("Old price promotion")
            .located(By.xpath("//div[@class='price']//span[@class='old']"));

    public static Target OLD_PRICE_PROMOTION(String sku) {
        return Target.the("Old price promotion")
                .located(By.xpath("//div[contains(text(),'" + sku + "')]/ancestor::div[@class='general']//div[@class='price']//span[contains(@class,'old')]"));
    }

    public static Target CASE_LIMIT_PROMOTION = Target.the("Case limit promotion")
            .located(By.xpath("//div[@class='promotion-explained']//div[@class='case-limit']"));

    public static Target CASE_LIMIT_PROMOTION(String sku) {
        return Target.the("Case limit promotion")
                .located(By.xpath("//div[contains(text(),'" + sku + "')]/ancestor::div[@class='general']/following-sibling::div[@class='promotion-explained']//div[@class='case-limit']"));
    }

    public static Target CASE_MINIMUM_PROMOTION = Target.the("Case limit promotion")
            .located(By.xpath("//div[@class='promotion-explained']//div[@class='case-minimum']"));

    public static Target CASE_MINIMUM_PROMOTION(String sku) {
        return Target.the("Case limit promotion")
                .located(By.xpath("//div[contains(text(),'" + sku + "')]/ancestor::div[@class='general']/following-sibling::div[@class='promotion-explained']//div[@class='case-minimum']"));
    }

    public static Target DISCOUNT_THUMBNAIL = Target.the("Discount in thumbnails")
            .located(By.xpath("//div[contains(@class,'image swiper-slide active')]//span[@class='promotion']"));

    public static Target EXPIRE_DATE = Target.the("Expire date")
            .located(By.xpath("//div[@class='expiry-date']//strong"));

    public static Target EXPIRE_DATE(String sku) {
        return Target.the("Case limit promotion")
                .located(By.xpath("//div[contains(text(),'" + sku + "')]/ancestor::div[@class='general']/following-sibling::div[@class='promotion-explained']//div[@class='expiry-date']//strong"));
    }

    public static Target STACK_DEAL(int i) {
        return Target.the("Tag " + i)
                .located(By.xpath("//div[@class='case-stack-promotion']//div[" + i + "]"));
    }

    /**
     * Wholesale pricing
     */
    public static Target WHOLESALE_PRICING_DIALOG = Target.the("Wholesale pricing dialog")
            .located(By.xpath("//div[text()='Sign up for Wholesale pricing']"));

    public static Target WHOLESALE_PRICING_TEXTBOX(String title) {
        return Target.the("Textbox " + title)
                .located(By.xpath("//label[text()='" + title + "']/following-sibling::div//input"));
    }

    public static Target WHOLESALE_PRICING_COMMENT = Target.the("Wholesale pricing comment")
            .located(By.xpath("//label[text()='Comments']/following-sibling::div//textarea"));

    public static Target WHOLESALE_PRICING_RETAIL = Target.the("Wholesale pricing retail partner")
            .located(By.xpath("//label//span[text()='Are you a current retail partner of Pod Foods?']"));

    public static Target WHOLESALE_PRICING_SKU(String sku) {
        return Target.the("SKU " + sku)
                .located(By.xpath("//div[@role='dialog']//div[text()='" + sku + "']"));
    }

}


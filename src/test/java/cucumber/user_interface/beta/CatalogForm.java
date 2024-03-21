package cucumber.user_interface.beta;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class CatalogForm {

    public static final Target SEARCH_TEXTBOX = Target.the("'Button Search '")
            .locatedBy("(//div[@class='search-box']//input[@type='text'])[2]");

    public static final Target TYPE_SEARCH_BUTTON = Target.the("'Button Search '")
            .locatedBy("(//div[@class='search-box']//input[@type='text'])[1]");
    /**
     * Popup Preview promo
     */

    public static Target SKU_NAME_IN_PREVIEW = Target.the("SKU name in preview of promo")
            .located(By.xpath("(//div[@role='tooltip' and @aria-hidden='false']//div[@class='preview']//span)[1]"));
    public static Target PRICE_PROMO_IN_PREVIEW = Target.the("Price promo in preview of promo")
            .located(By.xpath("(//div[@role='tooltip' and @aria-hidden='false']//div[@class='preview']//div[@class='price']//span)[1]"));

    public static Target SKU_NAME_IN_PREVIEW(int i) {
        return Target.the("SKU_NAME_IN_PREVIEW")
                .locatedBy("(//div[@role='tooltip' and @aria-hidden='false']//div[@class='name']/span[1])[" + i + "]");
    }

    public static Target PROMO_IN_TAG_PREVIEW(String sku, String class_) {
        return Target.the("SKU_NAME_IN_PREVIEW")
                .locatedBy("//div[@role='tooltip' and not(contains(@style,'display: none'))]//span[contains(text(),'" + sku + "')]//ancestor::div[@class='variant']//*[contains(@class,'" + class_ + "')]");
    }

    public static Target SKU_NAME_IN_PREVIEW_POPUP(String sku) {
        return Target.the("SKU_NAME_IN_PREVIEW")
                .locatedBy("//div[@role = 'dialog']//div[@class='info-variant__name' and contains(text(),'" + sku + "')]");
    }
    public static Target SKU_NAME_IN_PREVIEW_POPUP_MOV(String sku) {
        return Target.the("SKU_NAME_IN_PREVIEW")
                .locatedBy("//div[@role = 'dialog' and contains(@class,'mov-alert-modal')]//div[@class='info-variant__name' and contains(text(),'" + sku + "')]");
    }

    public static Target TAG_IN_PREVIEW(int i) {
        return Target.the("TAG_IN_PREVIEW")
                .locatedBy("(//div[@role='tooltip' and @aria-hidden='false']//div[@class='name']/span[2])[" + i + "]");
    }

    public static Target TAG_IN_PREVIEW_POPUP(String sku, String promo) {
        return Target.the("TAG_IN_PREVIEW")
                .locatedBy("//div[@role = 'dialog']//div[@class='info-variant__name' and contains(text(),'" + sku + "')]/preceding-sibling::div[@class='promotion']//div[contains(text(),'" + promo + "')]");
    }

    public static Target TAG_IN_PREVIEW_POPUP_MOV(String sku, String promo) {
        return Target.the("TAG_IN_PREVIEW")
                .locatedBy("//div[@role = 'dialog' and contains(@class,'mov-alert-modal')]//div[@class='info-variant__name' and contains(text(),'" + sku + "')]/preceding-sibling::div[@class='promotion']//div[contains(text(),'" + promo + "')]");
    }

    public static Target PRICE_PROMO_IN_PREVIEW(int i) {
        return Target.the("PRICE_PROMO_IN_PREVIEW")
                .locatedBy("(//div[@role='tooltip' and @aria-hidden='false']//div[@class='price']/span[1])[" + i + "]");
    }

    public static Target OLD_PRICE_PROMO_IN_PREVIEW(int i) {
        return Target.the("PRICE_PROMO_IN_PREVIEW")
                .locatedBy("(//div[@role='tooltip' and @aria-hidden='false']//div[@class='price']/span[2])[" + i + "]");
    }

    public static Target TYPE_SEARCH(String type) {
        return Target.the("'Type Search '")
                .locatedBy("//li/span[text()='" + type + "']");
    }

    public static final Target SEARCH_BUTTON = Target.the("'Button Search'")
            .locatedBy("//div[@class='search']//i[contains(@class,'bx-search')]");

    public static Target PRODUCT_CARD(String name) {
        return Target.the("Product card by " + name)
                .locatedBy(" //article[contains(@class,'product-card')]//a[text()='" + name + "']");
    }

    public static Target CATALOG_MENU = Target.the("Button catalog")
            .located(By.xpath("//a[contains(text(),'Catalog')]"));

    public static Target CATALOG_MENU_ITEM(String category) {
        return Target.the("Button item in catalog panel")
                .located(By.xpath("//div[@class='categories']//span[contains(text(),'" + category + "')]"));
    }

    public static Target PROMO_TAG1(String promo, String product) {
        return Target.the("Tag Buy in in product")
                .located(By.xpath("(//a[contains(text(),'" + product + "')])//ancestor::article//div[contains(@class,'promotion-tag')]/parent::span"));
    }

    public static Target PROMO_TAG(String promo, String product) {
        return Target.the("Tag Buy in in product")
                .located(By.xpath("//a[contains(text(),'" + product + "')]//ancestor::div[contains(@class,'information')]/ancestor::article//div[text()='" + promo + "']"));
    }

    public static Target D_EXPRESS_BADGE(String skuname) {
        return Target.the("Express badge of " + skuname)
                .located(By.xpath("//a[text()='" + skuname + "']/ancestor::div[@class='edt-piece variant']//div//img[@src='/img/express.svg']"));
    }

    public static Target TOOL_TIP_BADGE = Target.the("Tool tip of badge")
            .located(By.xpath("//div[text()='Fast delivery, fully consolidated']"));

    public static Target TAG_IN_PREVIEW = Target.the("Tag Buy in preview of promo")
            .located(By.xpath("(//div[@role='tooltip' and @aria-hidden='false']//div[@class='preview']//span)[2]"));

    public static Target CASE_LIMIT_IN_PREVIEW = Target.the("Case limit in preview of promo")
            .located(By.xpath("//div[@role='tooltip' and @aria-hidden='false']//div[@class='preview']//div[@class='case-limit']//strong"));

    public static Target CASE_LIMIT_IN_PREVIEW(int i) {
        return Target.the("CASE_LIMIT_IN_PREVIEW")
                .locatedBy("(//div[@role='tooltip' and @aria-hidden='false']//div[@class='preview']//div[@class='case-limit']//strong)[" + i + "]");
    }

    public static Target CASE_MINIMUM_IN_PREVIEW(int i) {
        return Target.the("CASE_LIMIT_IN_PREVIEW")
                .locatedBy("(//div[@role='tooltip' and @aria-hidden='false']//div[@class='preview']//div[@class='case-minimum']//strong)[" + i + "]");
    }

    public static Target EXPIRY_IN_PREVIEW(int i) {
        return Target.the("CASE_LIMIT_IN_PREVIEW")
                .locatedBy("(//div[@role='tooltip' and @aria-hidden='false']//div[@class='preview']//div[@class='expiry-date']//strong)[" + i + "]");
    }
}

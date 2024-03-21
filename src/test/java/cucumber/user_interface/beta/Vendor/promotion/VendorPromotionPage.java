package cucumber.user_interface.beta.Vendor.promotion;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class VendorPromotionPage {

    public static Target LOADING_SPIN = Target.the("")
            .locatedBy("//div[@class='loading no-padding']//div[@class='loading--indicator']");

    public static Target PROMO_ID = Target.the("Promotion id")
            .locatedBy("//h1[@class='page__title']");
    public static Target TAB(String tab) {
        return Target.the("Tab ")
                .locatedBy("//div[@class='label']//span[contains(text(),'" + tab + "')]");
    }

    public static Target SEARCH(String s) {
        return Target.the("Tab ")
                .locatedBy("//label[normalize-space()='" + s + "']/following-sibling::div//input");
    }

    public static Target SEARCH_ALL_FIELD(String s) {
        return Target.the("Tab ")
                .locatedBy("//div[@role='dialog']//label[normalize-space()='" + s + "']/following-sibling::div//input");
    }

    public static Target CLOSE_SEARCH_ALL = Target.the("Close Search ")
            .located(org.openqa.selenium.By.xpath("//i[@class='el-dialog__close el-icon el-icon-close']"));

    public static Target SEARCH_ALL = Target.the(" Search All")
            .located(org.openqa.selenium.By.xpath("//div[@class='field more']//span"));
    public static Target DIV_2(String s) {
        return Target.the(" ")
                .locatedBy("//div[contains(@class,'" + s + "')]/*[2]");
    }

    public static Target DIV_1(String s) {
        return Target.the(" ")
                .locatedBy("//div[contains(@class,'" + s + "')]");
    }

    public static Target DYNAMIC_TEXT_SPAN(String st) {
        return Target.the("Text " + st)
                .locatedBy("//span[normalize-space()='" + st + "']");
    }

    public static Target DYNAMIC_INFO_SPAN(String st) {
        return Target.the("Text " + st)
                .locatedBy("//span[contains(@class,'" + st + "')]");
    }

    public static Target DYNAMIC_INFO_SPAN2(String st) {
        return Target.the("Text " + st)
                .locatedBy("//span[@class='" + st + "']/following-sibling::*");
    }

    public static Target DYNAMIC_ADDITIONAL(String st) {
        return Target.the("Text " + st)
                .locatedBy("//span[normalize-space()='" + st + "']/parent::dt//following-sibling::dd");
    }

    public static Target REGIONS = Target.the("")
            .locatedBy("//span[@class='regions']/following-sibling::*");

    public static Target EXPIRY_DATE = Target.the("EXPIRY_DATE")
            .locatedBy("//dt[normalize-space()='Expiry date']//following-sibling::dd");

    public static Target STATUS = Target.the("EXPIRY_DATE")
            .locatedBy("//span[@class='status']");

    public static Target RECORD(String num, String s) {
        return Target.the(" ")
                .locatedBy("//div[contains(text(),'#" + num + "')]/ancestor::a[@class='edt-row record']/div[contains(@class,'" + s + "')]");
    }

    public static Target RECORD(int i, String s) {
        return Target.the(" ")
                .locatedBy("(//div[contains(text(),'#')]/ancestor::a[@class='edt-row record']/div[contains(@class,'" + s + "')])[" + i + "]");
    }

    public static Target NO_RESULTS_FOUND = Target.the("No results found")
            .located(By.xpath("//span[normalize-space()='No promotions found...']"));

    public static Target NUMBER_PAGE = Target.the("Number page")
            .locatedBy("//li[contains(@class,'number')]");

    public static Target NUMBER(String number) {
        return Target.the("")
                .locatedBy("//div[@class='md focus' and contains(text(),'" + number + "')]");
    }

    public static Target NAME(String number) {
        return Target.the("")
                .locatedBy("//a[@class='edt-row record']//*[contains(text(),'" + number + "')]");
    }

    public static Target DUPLICATE(String name) {
        return Target.the("")
                .locatedBy("//span[contains(text(),'" + name + "')]/ancestor::div[@class='edt-piece name']/following-sibling::div[@class='edt-piece action tr']//button");
    }

    public static Target NUMBER = Target.the("")
            .locatedBy("//div[@class='md focus']");

    public static Target FULFILLMENT = Target.the("")
            .locatedBy("//div[@class='edt-piece fulfillment']//div[2]");

    public static Target BRAND_NAME(int i) {
        return Target.the(" brand name")
                .locatedBy("(//div[@class='brand'])[" + i + "]");
    }

    public static Target PRODUCT_NAME(int i) {
        return Target.the(" product name")
                .locatedBy("(//div[@class='product'])[" + i + "]");
    }

    public static Target REGION(int i) {
        return Target.the(" Region name")
                .locatedBy("(//div[@class='edt-piece region'])[" + i + "]");
    }

    public static Target ORIGINAL_PRICE(int i) {
        return Target.the(" Region name")
                .locatedBy("(//div[contains(@class,'edt-piece original-price')])[" + i + "]");
    }

    public static Target DISCOUNT_PRICE(int i) {
        return Target.the(" Region name")
                .locatedBy("(//div[@class='edt-piece discount-price'])[" + i + "]");
    }

    public static Target SKU_NAME(int i) {
        return Target.the(" sku name")
                .locatedBy("(//div[@class='variant'])[" + i + "]");
    }

    public static Target STATUS(int i) {
        return Target.the("status")
                .locatedBy("(//div[@class='edt-row']//div[@class='status-tag'])[" + i + "]");
    }


    /*
    Create page
     */
    public static Target REGION_SWITCH = Target.the("REGION_SWITCH")
            .locatedBy("//label[normalize-space()='Regional promotion']/preceding-sibling::div[@role='switch']");

    public static Target SPECIFIC_SWITCH = Target.the("REGION_SWITCH")
            .locatedBy("//label[normalize-space()='Retail Specific promotion']/preceding-sibling::div[@role='switch']");

    public static Target STACK_DEAL_SWITCH = Target.the("REGION_SWITCH")
            .locatedBy("//label[normalize-space()='Is this a case stack deal?']/preceding-sibling::div");

    public static Target REGION_OPTION(String region) {
        return Target.the("REGION_OPTION")
                .locatedBy("//div[@aria-label='checkbox-group']//span[text()='" + region + "']");
    }

    public static Target BUYER_COMPANY_OPTION(String region) {
        return Target.the("REGION_OPTION")
                .locatedBy("//div[@class='buyer-companies with-scroller']//div[text()='" + region + "']");
    }

    public static Target SKU_OPTION(String sku) {
        return Target.the("SKU_OPTION")
                .locatedBy("//div[@class='skus with-scroller']//div[contains(text(),'" + sku + "')]");
    }

    public static Target SKU_OPTION_SELECTED(String sku) {
        return Target.the("REGION_OPTION")
                .locatedBy("//div[contains(text(),'" + sku + "')]//ancestor::div[@class='sku sku--excluded']//label[@class='el-checkbox is-disabled']");
    }

    public static Target CREATE_SKU_LIST(String class_, int i) {
        return Target.the("CREATE_SKU_LIST")
                .locatedBy("(//div[contains(@class,'product-variants-grid__item__" + class_ + "')])[" + i + "]");
    }

    public static Target CREATE_SKU_LIST_REMOVE(String sku) {
        return Target.the("CREATE_SKU_LIST")
                .locatedBy("(//div[contains(text(),'" + sku + "')]/parent::div/following-sibling::div[contains(@class,'product-variants-grid__item__action')])");
    }

    public static Target CREATE_SKU_LIST_IMAGE(int i) {
        return Target.the("CREATE_SKU_LIST")
                .locatedBy("(//div[contains(@class,'product-variants-grid__item__image')]/div)[" + i + "]");
    }

    public static Target STACK_DEAL(String field, int i) {
        return Target.the("CREATE_SKU_LIST")
                .locatedBy("(//label[normalize-space()='" + field + "']/following-sibling::div//input)[" + i + "]");
    }

    public static Target STORE_ID(int i) {
        return Target.the("CREATE_SKU_LIST")
                .locatedBy("(//div[@class='stores']//span[@class='store'])[" + i + "]");
    }

    public static Target STORE_REGION_ID(int i) {
        return Target.the("CREATE_SKU_LIST")
                .locatedBy("(//div[@class='stores']//span[@class='region'])[" + i + "]");
    }

    public static Target STACK_DEAL_REMOVE(int i) {
        return Target.the("CREATE_SKU_LIST")
                .locatedBy("(//div[contains(@class,'submission-actions-attributes')]//i[@class='bx bxs-trash bx-2'])[" + i + "]");
    }

    public static Target APPLIED_BUYER_COMPANY(String field) {
        return Target.the("CREATE_SKU_LIST")
                .locatedBy("//div[@class='included-buyer-companies']//span[contains(text(),'" + field + "')]");
    }

    public static Target APPLIED_BUYER_COMPANY_DUPLICATE(String buyer) {
        return Target.the("CREATE_SKU_LIST")
                .locatedBy("//div[contains(@class,'buyer-companies-grid__item')]/div[contains(@class,'name') and contains(text(),'" + buyer + "')]");
    }
}

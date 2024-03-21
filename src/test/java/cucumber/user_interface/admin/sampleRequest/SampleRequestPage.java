package cucumber.user_interface.admin.sampleRequest;

import net.serenitybdd.screenplay.targets.Target;

public class SampleRequestPage {
    public static Target DYNAMIC_SEARCH(String s) {
        return Target.the("").locatedBy("//label[normalize-space()='" + s + "']/following-sibling::div//input");
    }

    public static Target DYNAMIC_TABLE(String s) {
        return Target.the("").locatedBy("//tbody//*[contains(@class,'" + s + "')]");
    }

    public static Target DYNAMIC_TABLE2(String s, String text) {
        return Target.the(s).locatedBy("//tbody//*[contains(@class,'" + s + "')]//*[contains(text(),'" + text + "')]");
    }

    public static Target DYNAMIC_GENERAL(String s) {
        return Target.the("DYNAMIC_GENERAL" + s).locatedBy("//*[@class='" + s + "']");
    }

    public static Target DYNAMIC_GENERAL_FIELD(String s) {
        return Target.the("DYNAMIC_GENERAL" + s).locatedBy("(//dt[contains(text(),'" + s + "')]/following-sibling::dd/div)[1]");
    }

    public static Target DYNAMIC_SKU(String s, int i) {
        return Target.the("").locatedBy("(//tbody[@class='variants']//*[contains(@class,'" + s + "')])[" + i + "]");
    }

    public static Target DYNAMIC_SKU_UNIT_PRICE(int i) {
        return Target.the("").locatedBy("(//tbody[@class='variants']/tr/td[@class='tr'][1])[" + i + "]");
    }

    public static Target DYNAMIC_SKU_CASE_PRICE(int i) {
        return Target.the("").locatedBy("(//tbody[@class='variants']/tr/td[@class='tr'][2])[" + i + "]");
    }

    public static Target DYNAMIC_PRODUCT(String s, int i) {
        return Target.the("").locatedBy("(//tbody[@class='variants']//*[contains(@class,'" + s + "')])[" + i + "]//span");
    }

    public static Target NUMBER(String s) {
        return Target.the("").locatedBy("//td[contains(@class,'number')]//a[contains(text(),'" + s + "')]");
    }

    public static Target DELIVERY(String s) {
        return Target.the("").locatedBy("//dd[@class='" + s + "']//div[@class='content el-popover__reference']");
    }

    public static Target COMMENT = Target.the("")
            .locatedBy("//dt[normalize-space()='Buyer comment']/following-sibling::dd");

    public static Target ADMIN_NOTE = Target.the("")
            .locatedBy("//dt[normalize-space()='Admin note']/following-sibling::dd");

    public static Target SAMPLE_NUMBER = Target.the("SAMPLE_NUMBER")
            .locatedBy("//div[@class='title']/span[1]");

    /***
     * Create Sample
     *
     */
    public static Target FULFILLMENT = Target.the("FULFILLMENT")
            .locatedBy("//label[normalize-space()='Fulfillment']/following-sibling::div/div[@role='switch']");

    public static Target ROLE(String s) {
        return Target.the("ROLE")
                .locatedBy("//label[normalize-space()='Role']/following-sibling::div//span[text()='" + s + "']");
    }

    public static Target SKU(String s) {
        return Target.the("SKU")
                .locatedBy("//span[contains(text(),'" + s + "')]/parent::div/preceding-sibling::div[@class='selector']/input");
    }

    public static Target SKU_INFO(String sku, String product) {
        return Target.the("SKU_INFO")
                .locatedBy("//div[contains(text(),'" + product + "')]/parent::div/following-sibling::div//*[contains(text(),'" + sku + "')]");
    }

    public static Target SKU_IMAGE(String sku, String product) {
        return Target.the("SKU_IMAGE")
                .locatedBy("//div[contains(text(),'" + product + "')]/parent::div/following-sibling::div//*[contains(text(),'" + sku + "')]/parent::div/preceding-sibling::div[@class='image']/div");
    }

    public static Target SKU_COMMENT(String s) {
        return Target.the("SKU_COMMENT")
                .locatedBy("//span[contains(text(),'" + s + "')]/following-sibling::div//input");
    }

    public static Target STORE_NAME(String store) {
        return Target.the("STORE_NAME")
                .locatedBy("//div[@class='address']//div[@class='name' and contains(text(),'" + store + "')]");
    }

    public static Target STORE_ADDRESS(String store) {
        return Target.the("STORE_NAME")
                .locatedBy("//div[@class='address']//div[@class='name' and contains(text(),'" + store + "')]/following-sibling::div");
    }

    public static Target BUYER_INFO(String buyer, String region, String store) {
        return Target.the("STORE_NAME")
                .locatedBy("//div[contains(text(),'" + buyer + "')]/following-sibling::div/span[normalize-space()='" + region + "']/following-sibling::span[contains(text(),'" + store + "')]");
    }

    public static Target REMOVE_BUYER(String buyer) {
        return Target.the("STORE_NAME")
                .locatedBy("//div[@class='items']//div[contains(text(),'" + buyer + "')]/ancestor::div[@class='item']//div[contains(@class,'actions')]");
    }

//    Packing slip

    public static Target NUM_SUB_PACKING_SLIP = Target.the("NUM_SUB_PACKING_SLIP")
            .locatedBy("//div[@class='name']");

    public static Target D_INFO_SUB_PACKING_SLIP(String title) {
        return Target.the(title)
                .locatedBy("//dt[text()='" + title + "']/following-sibling::dd");
    }

    public static Target D_INFO_SUB_PACKING_SLIP2(String sku, String field) {
        return Target.the(sku + field)
                .locatedBy("//div[@class='variant'][contains(text(),'" + sku + "')]/ancestor::tr//div[@class='" + field + "']");
    }

}

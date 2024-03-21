package cucumber.user_interface.beta.Buyer.sampleRequest;


import net.serenitybdd.screenplay.targets.Target;

public class BuyerSampleRequestDetailPage {

    public static Target ORDERED(int i) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[@class='edt-piece ordered pf-nowrap'])[" + i + "]/div[2]");
    }

    public static Target NUMBER(int i) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[@class='edt-piece number pf-nowrap'])[" + i + "]/div[2]");
    }

    public static Target NUMBER(String number) {
        return Target.the("")
                .locatedBy("//div[@class='md focus' and text()='#" + number + "']");
    }

    public static Target STORE(int i) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[@class='edt-piece store'])[" + i + "]/span");
    }

    public static Target CREATOR(int i) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[@class='edt-piece creator pf-nowrap'])[" + i + "]/span");
    }

    public static Target PAYMENT(int i) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[@class='edt-piece payment pf-nowrap'])[" + i + "]/div[2]");
    }

    public static Target FULLFILLMENT(int i) {
        return Target.the("")
                .locatedBy("(//a[@class='record edt-row']//div[@class='edt-piece fulfillment pf-nowrap'])[" + i + "]/div[2]");
    }

    public static Target TOTAL(int i) {
        return Target.the("")
                .locatedBy("(//div[@class='edt-piece total tr pf-nowrap']//div[@class='total'])[" + i + "]");
    }

    public static Target BRAND_NAME(int i) {
        return Target.the(" brand name")
                .locatedBy("(//div[@class='brand'])[" + i + "]");
    }

    public static Target PRODUCT_NAME(int i) {
        return Target.the(" product name")
                .locatedBy("(//div[@class='product'])[" + i + "]");
    }

    public static Target SKU_NAME(int i) {
        return Target.the(" sku name")
                .locatedBy("(//div[@class='info-variant__name'])[" + i + "]");
    }

    public static Target SKU_NAME(String i) {
        return Target.the(" sku name")
                .locatedBy("//div[@class='info-variant__name' and contains(text(),'" + i + "')]");
    }

    public static Target TAG_PROMO_SKU(String sku, String promo) {
        return Target.the(" sku name")
                .locatedBy("//div[@class='info-variant__name' and contains(text(),'" + sku + "')]/preceding-sibling::div[@class='promotion']//div[contains(text(),'" + promo + "')]");
    }

    public static Target UNIT_PER_CASE(int i) {
        return Target.the("Unit per case")
                .locatedBy("(//div[@class='variants-item']//div[@class='edt-piece unit-per-case'])[" + i + "]");
    }

    public static Target ORDER_DATE(int i) {
        return Target.the("Previous orders date")
                .locatedBy("(//dl[@class='metas']/dt)[" + i + "]");
    }

    public static Target QUANTITY(int i) {
        return Target.the("Quantity")
                .locatedBy("(//div[@class='quantity'])[" + i + "]");
    }

    public static Target CASE_PRICE(int i) {
        return Target.the("case price")
                .locatedBy("(//div[contains(@class,'case-price')]//div[2])[" + i + "]");
    }

    public static Target UNIT(int i) {
        return Target.the("Unit UPC / EAN:")
                .locatedBy("(//div[@class='upc' or @class='eta'])[" + i + "]");
    }

    public static Target STATUS(int i) {
        return Target.the("status")
                .locatedBy("(//div[@class='edt-row']//div[@class='status-tag'])[" + i + "]");
    }

    public static Target ADD_TO_CART_BUTTON(int i) {
        return Target.the("Add to cart button")
                .locatedBy("(//div[@class='edt-piece action pf-nowrap']/button)[" + i + "]");
    }

    public static Target ADD_TO_CART_BUTTON(String sku) {
        return Target.the("Add to cart button")
                .locatedBy("//div[contains(text(),'" + sku + "')]//ancestor::div[@class='edt-row']//button");
    }

    public static Target DYNAMIC_DIV(String s) {
        return Target.the("")
                .locatedBy("//div[@class='" + s + "']");
    }

    public static Target REQUEST_DATE = Target.the("")
            .locatedBy("//div[@class='edt-piece order-date']//div[2]");

    public static Target EMAIL_BUYER = Target.the("")
            .locatedBy(".linked.order-buyer-email");

    public static Target FULFILLMENT = Target.the("")
            .locatedBy("//div[@class='edt-piece fulfillment']//div[2]");

    public static Target FULFILLMENT_DATE = Target.the("")
            .locatedBy("//div[@class='fulfillment']");
    public static Target CANCELATION_NOTE = Target.the("")
            .locatedBy("//div[normalize-space()='Cancelation note']/following-sibling::div");

    public static Target FULFILLMENT_CARRIER = Target.the("")
            .locatedBy("//div[@class='carrier']");

    public static Target FULFILLMENT_TRACKING_NUMBER = Target.the("")
            .locatedBy("//div[@class='tracking-number']");
}

package cucumber.user_interface.beta.Vendor.sampleRequest;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class VendorSampleRequestPage {

    public static Target LOADING_SPIN = Target.the("LOADING_SPIN")
            .locatedBy("//div[@class='loading no-padding']//div[@class='loading--indicator']");
    public static Target CLEAR_ICON = Target.the("CLEAR_ICON")
            .locatedBy("//*[contains(@class,'el-input__icon el-icon-circle-close')]");

    public static Target TAB(String tab) {
        return Target.the("Tab " + tab)
                .locatedBy("//div[@class='label']//span[contains(text(),'" + tab + "')]");
    }

    public static Target SEARCH(String s) {
        return Target.the("SEARCH " + s)
                .locatedBy("(//label[normalize-space()='" + s + "']/following-sibling::div//input)[last()]");
    }

    public static Target DIV_2(String s) {
        return Target.the(s)
                .locatedBy("//div[contains(@class,'" + s + "')]/*[2]");
    }

    public static Target DIV_1(String s) {
        return Target.the(s)
                .locatedBy("//div[contains(@class,'" + s + "')]");
    }

    public static Target DYNAMIC_TEXT_SPAN(String st) {
        return Target.the("Text " + st)
                .locatedBy("//span[normalize-space()='" + st + "']");
    }

    public static Target DELIVERY_DATE = Target.the("DELIVERY_DATE")
            .locatedBy("//input[@placeholder='MM/DD/YY']");

    public static Target FULFILLMENT_DATE = Target.the("FULFILLMENT_DATE")
            .locatedBy("//div[@class='fulfillment-date']");

    public static Target CARRIER2 = Target.the("CARRIER2")
            .locatedBy("//div[@class='carier']");

    public static Target TRACKING_NUM = Target.the("TRACKING_NUM")
            .locatedBy("//div[@class='tracking-number']");

    public static Target CARRIER = Target.the("CARRIER")
            .locatedBy("//label[normalize-space()='Carrier']/following-sibling::div//input");

    public static Target TRACKING_NUMBER = Target.the("TRACKING_NUMBER")
            .locatedBy("//label[normalize-space()='Tracking number']/following-sibling::div//input");

    public static Target CONFIRM_FULFILLMENT = Target.the("")
            .locatedBy("//span[normalize-space()='Confirm Fulfillment Date']");

    public static Target CONFIRM_ALERT = Target.the("")
            .locatedBy("//div[@role='alert']");

    public static Target EMAIL_BUYER = Target.the("EMAIL_BUYER")
            .locatedBy(".buyer-email.linked.pf-ellipsis");

    public static Target COMMENT = Target.the("COMMENT")
            .locatedBy("//div[normalize-space()='Note From Buyer']/following::p");

    public static Target RECORD(String num, String s) {
        return Target.the("RECORD " + num + " " + s)
                .locatedBy("//div[contains(text(),'" + num + "')]/ancestor::a[@class='edt-row record']/div[contains(@class,'" + s + "')]/*[2]");
    }

    public static Target NO_RESULTS_FOUND = Target.the("No results found")
            .located(By.xpath("//span[normalize-space()='No sample requests found...']"));

    public static Target NUMBER_PAGE = Target.the("Number page")
            .locatedBy("//li[contains(@class,'number')]");

    public static Target NUMBER(String number) {
        return Target.the(number)
                .locatedBy("//div[@class='md focus' and contains(text(),'" + number + "')]");
    }

    public static Target FULFILLMENT = Target.the("FULFILLMENT")
            .locatedBy("//div[@class='edt-piece fulfillment']//div[2]");

    public static Target BRAND_NAME(int i) {
        return Target.the(" brand name")
                .locatedBy("(//div[@class='brand'])[" + i + "]");
    }

    public static Target BRAND_NAME(String product, int i) {
        return Target.the(" brand name of product " + product + i)
                .locatedBy("(//a[contains(text(),'" + product + "')]/parent::div/following-sibling::div//div[@class='brand'])[" + i + "]");
    }

    public static Target PRODUCT_NAME(int i) {
        return Target.the(" product name")
                .locatedBy("(//div[@class='product'])[" + i + "]");
    }

    public static Target SKU_NAME(int i) {
        return Target.the(" sku name")
                .locatedBy("(//div[@class='info-variant__name'])[" + i + "]");
    }

    public static Target SKU_NAME(String product, int i) {
        return Target.the(" sku name")
                .locatedBy("(//a[contains(text(),'" + product + "')]/parent::div/following-sibling::div//div[@class='info-variant__name'])[" + i + "]");
    }

    public static Target CASE_PRICE(int i) {
        return Target.the("case price")
                .locatedBy("(//div[contains(@class,'case-price')]//div[2])[" + i + "]");
    }

    public static Target UNIT(String product, int i) {
        return Target.the("Unit UPC / EAN:")
                .locatedBy("(//a[contains(text(),'" + product + "')]/parent::div/following-sibling::div//div[@class='upc' or @class='eta'])[" + i + "]");
    }

    public static Target CASE_PRICE(String product, int i) {
        return Target.the("case price")
                .locatedBy("(//a[contains(text(),'" + product + "')]/parent::div/following-sibling::div//div[contains(@class,'case-price')]//div[2])[" + i + "]");
    }

    public static Target STATUS(int i) {
        return Target.the("status")
                .locatedBy("(//div[@class='edt-row']//div[@class='status-tag'])[" + i + "]");
    }

    /// Buy and Print shipping label
    public static Target PARCEL_INFORMATION(String item) {
        return Target.the("")
                .locatedBy("//label[normalize-space()='" + item + "']/following-sibling::div//input");
    }

    public static Target GET_RATE = Target.the("Get rate")
            .locatedBy("//span[normalize-space()='Get Rates']");

    public static Target BACK = Target.the("Get rate")
            .locatedBy("//span[normalize-space()='Back']");

    public static Target BUY = Target.the("Get rate")
            .locatedBy("//span[normalize-space()='Buy']");

    public static Target CHECK_SHIPPO = Target.the("")
            .locatedBy("//div[@class='edt-piece radio']/label/span/span");

}

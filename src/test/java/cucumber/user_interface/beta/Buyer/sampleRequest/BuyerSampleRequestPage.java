package cucumber.user_interface.beta.Buyer.sampleRequest;

import net.serenitybdd.core.annotations.findby.By;
import net.serenitybdd.screenplay.targets.Target;

public class BuyerSampleRequestPage {

    public static Target LOADING = Target.the("Loading")
            .locatedBy("//div[@class='loading']");

    public static Target BACK = Target.the(" Back to Sample Requests")
            .locatedBy("//a[normalize-space()='< Back to Sample Requests']");

    public static Target REQUESTED(int i) {
        return Target.the("")
                .locatedBy("(//DIV[@class='edt-piece requested pf-nowrap']/span)[" + i + "]");
    }

    public static Target NUMBER(int i) {
        return Target.the("")
                .locatedBy("(//DIV[@class='edt-piece number pf-nowrap']/div[2])[" + i + "]");
    }

    public static Target NUMBER(String number) {
        return Target.the("")
                .locatedBy("//div[@class='md focus' and text()='#" + number + "']");
    }

    public static Target STORE(int i) {
        return Target.the("")
                .locatedBy("(//DIV[@class='edt-piece store']/span)[" + i + "]");
    }

    public static Target BRAND(int i) {
        return Target.the("")
                .locatedBy("(//DIV[@class='edt-piece brand pf-nowrap']/span)[" + i + "]");
    }

    public static Target PRODUCT(int i) {
        return Target.the("")
                .locatedBy("(//DIV[@class='edt-piece product pf-nowrap']/span)[" + i + "]");
    }

    public static Target FULFILLMENT(int i) {
        return Target.the("")
                .locatedBy("(//DIV[@class='edt-piece fulfillment pf-nowrap']//div[@class='status-tag'])[" + i + "]");
    }

    public static Target D_DEFAULT_ADDRESS(String field) {
        return Target.the("")
                .locatedBy("//div[@class='default-address']//div[@class='" + field + "']");
    }

    //POP-UP Create sample

    public static Target COMMENT = Target.the("Comment sample request")
            .locatedBy("//textarea[@class='el-textarea__inner']");

    public static Target PRODUCT = Target.the("Comment sample request")
            .locatedBy("//div[@class='page__dialog-description']");

    public static Target HELP = Target.the("Comment sample request")
            .locatedBy("//div[@class='help']");

    public static Target SWITCH = Target.the("")
            .locatedBy("//span[@class='el-switch__core']");

    public static Target SUBMIT = Target.the("")
            .locatedBy("//span[normalize-space()='Submit']");

    public static Target ALERT = Target.the("")
            .locatedBy("//div[@role='alert']");

    public static Target STORE_NAME = Target.the("")
            .locatedBy("//div[@class='store-name']");

    public static Target ADDRESS = Target.the("")
            .locatedBy("//div[@class='address-stamp']");

    public static Target PHONE = Target.the("")
            .locatedBy("//div[@class='store-phone']");

    public static Target DYNAMIC_SKU(String name) {
        return Target.the("")
                .located(By.xpath("//div[@aria-label='dialog']//div[@class='info-variant__name'][contains(text(),'" + name + "')]"));
    }

    public static Target DYNAMIC_SHIPPING(String name) {
        return Target.the("Pre-order button")
                .located(By.xpath("//label[normalize-space()='" + name + "']/following-sibling::div//input"));
    }

    public static Target RECORD(String num, String s) {
        return Target.the(" ")
                .locatedBy("//div[contains(text(),'" + num + "')]/ancestor::a[@class='record edt-row']/div[contains(@class,'" + s + "')]/*[2]");
    }

    public static Target PAGE(String tab) {
        return Target.the("Tab ")
                .locatedBy("//div[@class='page__actions']//a[contains(text(),'" + tab + "')]");
    }

    public static Target ADD_CART(String s) {
        return Target.the(" ")
                .locatedBy("//div[contains(text(),'" + s + "')]/ancestor::div[@class='edt-row']//div[contains(@class,'action')]/button");
    }

}

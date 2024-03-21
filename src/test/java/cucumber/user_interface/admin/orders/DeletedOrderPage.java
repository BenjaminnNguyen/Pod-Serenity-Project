package cucumber.user_interface.admin.orders;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class DeletedOrderPage {

    public static Target ORDER_DETAIL_BY_ID(String idInvoice) {
        return Target.the("Detail of " + idInvoice)
                .located(By.xpath("//td//a[text()='" + idInvoice + "']"));
    }

    /**
     * Order Deleted Detail - General information
     */

    public static Target GENERAL_CUSTOM_PO_FIELD = Target.the("Custom PO field")
            .locatedBy("//span[@class='customer-po']");
    public static Target GENERAL_DATE = Target.the("General information date")
            .locatedBy("//dd[@class='date']/span");

    public static Target GENERAL_REGION = Target.the("General information region")
            .locatedBy("//dd[@class='region']/span");

    public static Target GENERAL_BUYER = Target.the("General information buyer")
            .locatedBy("//dd[@class='buyer']/div");

    public static Target GENERAL_STORE = Target.the("General information store")
            .locatedBy("//dd[@class='store']/div/div");

    public static Target GENERAL_CREATOR = Target.the("General information creator")
            .locatedBy("//dd[@class='creator']/div");

    public static Target GENERAL_DELETED_BY = Target.the("General information deleted by")
            .locatedBy("//span[@class='deleted-by']");

    public static Target GENERAL_DELETED_ON = Target.the("General information deleted on")
            .locatedBy("//span[@class='deleted-on']");

    public static Target GENERAL_DELETED_REASON = Target.the("General information deleted reason")
            .locatedBy("//span[@class='deleted-reason']");

    public static Target GENERAL_DELETED_NOTE = Target.the("General information deleted note")
            .locatedBy("//span[@class='deleted-note']");

    public static Target GENERAL_SHOW_ON_VENDOR(String value) {
        return Target.the("General information show on vendor")
                .locatedBy("//dt[text()='Show on vendor']/following-sibling::dd//span[text()='" + value + "']");
    }

    public static Target GENERAL_BUYER_PAYMENT = Target.the("General information buyer payment")
            .locatedBy("//dd[@class='buyer-payment']/div");

    public static Target GENERAL_PAYMENT_TYPE = Target.the("General information payment type")
            .locatedBy("//dd[@class='payment-type']/span");

    public static Target GENERAL_PAYMENT_DATE = Target.the("General information payment date")
            .locatedBy("//dd[@class='payment-date']/span");

    public static Target GENERAL_VENDOR_PAYMENT = Target.the("General information vendor payment")
            .locatedBy("//dd[@class='vendor-payment']/div");

    public static Target GENERAL_FULFILLMENT = Target.the("General information fulfillment")
            .locatedBy("//dd[@class='fulfillment']/div");

    public static Target GENERAL_ADDRESS = Target.the("General information address")
            .locatedBy("//dd[@class='address']/div");

    public static Target GENERAL_MANAGED_BY = Target.the("General information managed by")
            .locatedBy("//dd[@class='managed']");

    public static Target GENERAL_LAUNCHED_BY = Target.the("General information launched by")
            .locatedBy("//dt[text()='Launched by']/following-sibling::dd");

    public static Target GENERAL_ORDER_VALUE = Target.the("General information order value")
            .locatedBy("//dd[@class='order-value']");

    public static Target GENERAL_DISCOUNT = Target.the("General information discount")
            .locatedBy("//dd[@class='discount']");

    public static Target GENERAL_TAXES = Target.the("General information discount")
            .locatedBy("//dd[@class='taxes']");

    public static Target GENERAL_SOS = Target.the("General information small order surcharge")
            .locatedBy("//dd[@class='shipping-fee']/span");

    public static Target GENERAL_FS = Target.the("General information fuel surcharge")
            .locatedBy("//dd[@class='logistics-surcharge']/span");

    public static Target GENERAL_TOTAL_PAYMENT = Target.the("General information total payment")
            .locatedBy("//dd[@class='total-payment']//span");

    public static Target GENERAL_VENDOR_SERVICE_FEE = Target.the("General information vendor service fee")
            .locatedBy("//dd[@class='vendor-service-fee']");

    /**
     * Line item
     */

    public static Target LINE_ITEM_BRAND(String type, int index) {
        return Target.the("Brand in line item " + index)
                .locatedBy("(//tbody[@class='" + type + "']//a[@class='brand']/span)[" + index + "]");
    }

    public static Target LINE_ITEM_PRODUCT(String type, int index) {
        return Target.the("Brand in line item " + index)
                .locatedBy("(//tbody[@class='" + type + "']//a[@class='product']/span)[" + index + "]");
    }

    public static Target LINE_ITEM_SKU(String type, int index) {
        return Target.the("Sku in line item " + index)
                .locatedBy("(//tbody[@class='" + type + "']//*[@class='variant']/span)[" + index + "]");
    }

    public static Target LINE_ITEM_SKU_ID(String type, int index) {
        return Target.the("Sku id in line item " + index)
                .locatedBy("(//tbody[@class='" + type + "']//*[contains(@class,'item-code')]/span)[" + index + "]");
    }

    public static Target LINE_ITEM_CASE_PRICE(String type, int index) {
        return Target.the("Case price in line item " + index)
                .locatedBy("(//tbody[@class='" + type + "']//*[contains(@class,'case-price')])[" + index + "]");
    }

    public static Target LINE_ITEM_CASE_UNIT(String type, int index) {
        return Target.the("Case unit in line item " + index)
                .locatedBy("(//tbody[@class='" + type + "']//*[contains(@class,'units')])[" + index + "]");
    }

    public static Target LINE_ITEM_QUANTITY(String type, int index) {
        return Target.the("Quantity in line item " + index)
                .locatedBy("(//tbody[@class='" + type + "']//*[contains(@class,'quantity')])/div/div[" + index + "]");
    }

    public static Target LINE_ITEM_END_QUANTITY(String type, int index) {
        return Target.the("End quantity in line item " + index)
                .locatedBy("(//tbody[@class='" + type + "']//*[contains(@class,'end-qty')])[" + index + "]");
    }

    public static Target LINE_ITEM_TOTAL(String type, int index) {
        return Target.the("Total in line item " + index)
                .locatedBy("(//tbody[@class='" + type + "']//*[contains(@class,'totals')]/strong)[" + index + "]");
    }

    public static Target LINE_ITEM_FULFILLMENT_DATE(String type, int index) {
        return Target.the("Fulfillment date in line item " + index)
                .locatedBy("(//tbody[@class='" + type + "']//*[contains(@class,'fulfillment-date')]//input[@disabled])[" + index + "]");
    }

    public static Target LINE_ITEM_DISTRIBUTION_CENTER(String type, int index) {
        return Target.the("Distribution center in line item " + index)
                .locatedBy("(//tbody[@class='" + type + "']//*[contains(@class,'warehouse')]//input[@disabled])[" + index + "]");
    }

    /**
     * Vendor payment
     */
    public static Target VENDOR_PAYMENT_PRODUCT = Target.the("Vendor payment product")
            .locatedBy("//div[@class='company']/div");

    public static Target VENDOR_PAYMENT_FULFILLMENT = Target.the("Vendor payment fulfillment")
            .locatedBy("//div[text()='Vendor payments']/following-sibling::div//dd[@class='fulfillment']/div");

    public static Target VENDOR_PAYMENT_PAYMENT_STATE = Target.the("Vendor payment payment state")
            .locatedBy("//div[text()='Vendor payments']/following-sibling::div//dd[@class='payment']/div");
    public static Target VENDOR_PAYMENT_VALUE = Target.the("Vendor payment value")
            .locatedBy("//div[text()='Vendor payments']/following-sibling::div//dd[@class='value']");

    public static Target VENDOR_PAYMENT_DISCOUNT = Target.the("Vendor payment discount")
            .locatedBy("//div[text()='Vendor payments']/following-sibling::div//dd[@class='discount']");

    public static Target VENDOR_PAYMENT_SERVICE_FEE = Target.the("Vendor payment service fee")
            .locatedBy("//div[text()='Vendor payments']/following-sibling::div//dd[@class='service-fee']");

    public static Target VENDOR_PAYMENT_ADDITIONAL_FEE = Target.the("Vendor payment additional fee")
            .locatedBy("//div[text()='Vendor payments']/following-sibling::div//dd[@class='additional-fee']");

    public static Target VENDOR_PAYMENT_PAID_TO_VENDOR = Target.the("Vendor payment paid to vendor")
            .locatedBy("//div[text()='Vendor payments']/following-sibling::div//dd[@class='paid']");


    public static Target VENDOR_PAYMENT_PAYOUT_DATE = Target.the("Vendor payment payout date")
            .locatedBy("//div[text()='Vendor payments']/following-sibling::div//dd[@class='payout-date']");

    public static Target VENDOR_PAYMENT_PAYMENT_TYPE = Target.the("Vendor payment payment type")
            .locatedBy("//div[text()='Vendor payments']/following-sibling::div//dd[@class='payment-type']");

    /**
     * How to use popup
     */

    public static Target HOW_TO_USE_EDIT_BUTTON = Target.the("How to use edit button")
            .locatedBy("//div[@class='action']/*");

    public static Target EDIT_INSTRUCTION_POPUP = Target.the("Edit instruction popup")
            .locatedBy("//div[@id='global-dialogs']//span[text()='Edit instruction']");

    public static Target EDIT_INSTRUCTION_TEXTBOX = Target.the("Edit instruction textbox")
            .locatedBy(".CodeMirror");

    public static Target EDIT_INSTRUCTION_UPDATE_BUTTON = Target.the("Edit instruction update button")
            .locatedBy("//div[@id='global-dialogs']//button//span[contains(text(),'Update')]");

    public static Target TEST = Target.the("Edit instruction textbox")
            .locatedBy("//div[@class='CodeMirror-code']");

    /**
     * Export CSV in detail
     */

    public static Target EXPORT_BUTTON = Target.the("Export button")
            .located(By.xpath("(//div[@class='actions']//button)[1]"));
}

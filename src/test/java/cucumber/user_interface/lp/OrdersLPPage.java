package cucumber.user_interface.lp;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class OrdersLPPage {

    public static Target BACK_TO_ORDER = Target.the("Back to order")
            .locatedBy("//a[normalize-space()='< Back to Orders']");

    public static Target NO_ORDER_FOUND = Target.the("No order found")
            .locatedBy("//span[normalize-space()='No orders found...']");

    public static Target RECORD_ROW = Target.the("row record")
            .locatedBy(".edt-row.record");

    public static Target FULFILLMENT_DETAILS = Target.the("Fulfillment details")
            .locatedBy("//div[@class='sub-title']");

    public static Target DYNAMIC_FILTER(String title) {
        return Target.the(title)
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static Target DYNAMIC_FILTER_ALL(String title) {
        return Target.the(title)
                .locatedBy("//div[@class='form']//label[contains(text(),'" + title + "')]/following-sibling::div//input");
    }

    public static Target CLOSE_SEARCH_ALL = Target.the("Close Search ")
            .located(By.xpath("//i[@class='el-dialog__close el-icon el-icon-close']"));

    public static Target SELECT_ALL = Target.the("select all  ")
            .located(By.xpath("//div[@class='label']//span[@class='el-checkbox__inner']"));

    public static Target DYNAMIC_ORDER_BY_ID(String id) {
        return Target.the("Order by " + id)
                .locatedBy("//div[@class='edt-piece number']//div[contains(text(),'" + id + "')]");
    }

    public static Target ORDERED(int i) {
        return Target.the("ordered")
                .locatedBy("(//a[@class='edt-row record']//div[@class='edt-piece ordered']/span)[" + i + "]");
    }

    public static Target ORDERED(String num) {
        return Target.the("ordered")
                .locatedBy("//div[contains(text(),'" + num + "')]/parent::div/preceding-sibling::div[@class='edt-piece ordered']/span");
    }

    public static Target NUMBER(int i) {
        return Target.the("po number")
                .locatedBy("(//a[@class='edt-row record']//div[@class='edt-piece number']/div[2])[" + i + "]");
    }

    public static Target D_COL(String number, String col) {
        return Target.the("po number" + number + col)
                .locatedBy("//div[contains(text(),'" + number + "')]/parent::div/following-sibling::div[@class='edt-piece " + col + "']");
    }

    public static Target NUMBER(String number) {
        return Target.the("po number")
                .locatedBy("//div[@class='md focus' and text()='#" + number + "']");
    }

    public static Target STORE(int i) {
        return Target.the("Store")
                .locatedBy("(//a[@class='edt-row record']//div[@class='edt-piece store']/span)[" + i + "]");
    }

    public static Target ADMIN_NOTE(int i) {
        return Target.the("Admin note")
                .locatedBy("(//a[@class='edt-row record']//div[@class='admin-note mt-1 pf-ellipsis'])[" + i + "]");
    }

    public static Target ADMIN_NOTE(String number) {
        return Target.the("Admin note")
                .locatedBy("//div[contains(text(),'" + number + "')]/following-sibling::div");
    }

    public static Target LP_NOTE(int i) {
        return Target.the("LP note")
                .locatedBy("(//a[@class='edt-row record']//div[@class='lp-note mt-1 pf-ellipsis'])[" + i + "]");
    }
    public static Target LP_NOTE(String number) {
        return Target.the("LP note")
                .locatedBy("//div[contains(text(),'" + number + "')]/following-sibling::div[2]");
    }

    public static Target DELIVERY(int i) {
        return Target.the("Delivery")
                .locatedBy("(//a[@class='edt-row record']//div[@class='edt-piece delivery']/div[2])/strong[" + i + "]");
    }

    public static Target DELIVERYTIME(String value) {
        return Target.the("Delivery time")
                .locatedBy("//a[@class='edt-row record']//div[@class='edt-piece delivery']/div[contains(text(),'" + value + "')]");
    }

    public static Target ROUTE(int i) {
        return Target.the("route")
                .locatedBy("(//a[@class='edt-row record']//div[@class='edt-piece route']/div[2])[" + i + "]");
    }

    public static Target ADDRESS(int i) {
        return Target.the("Address")
                .locatedBy("(//a[@class='edt-row record']//div[@class='edt-piece address']/div[2])[" + i + "]");
    }

    public static Target FULFILLMENT(int i) {
        return Target.the("Fulfillment")
                .locatedBy("(//a[@class='edt-row record']//div[@class='edt-piece fulfillment']/div[2])[" + i + "]");
    }

    /**
     * Invoice
     */
    public static final Target INVOICE_BUTTON = Target.the("Invoice button")
            .locatedBy("//span[text()='Invoice']");

    public static final Target TOTAL_INVOICE = Target.the("Total invoice")
            .locatedBy("//dd[contains(@class,'invoice-total')]/strong");

    public static final Target SOS_INVOICE = Target.the("Small Order Surcharge invoice")
            .locatedBy("(//dt[text()='Small Order Surcharge']/following-sibling::dd)[1]");

    public static final Target LS_INVOICE = Target.the("Logistics Surcharge invoice")
            .locatedBy("(//dt[text()='Logistics Surcharge']/following-sibling::dd)[1]");

    public static final Target PROMO_INVOICE = Target.the("Promotional Discount invoice")
            .locatedBy("(//dt[text()='Promotional Discount']/following-sibling::dd)[1]");

    /**
     * Packing Slip
     */

    public static final Target PACKING_SLIP_BUTTON = Target.the("Packing Slip button")
            .locatedBy("//span[text()='Packing Slip']");

    public static final Target UNSELECT_BUTTON = Target.the("Unselect above POs button")
            .locatedBy("//button[normalize-space()='Unselect above POs']");

    public static final Target MESSAGE_CONTENT = Target.the("MESSAGE_CONTENT")
            .locatedBy("//div[@class='el-message__content']");

    public static final Target CLOSE_BUTTON = Target.the("CLOSE_BUTTON")
            .locatedBy("//i[@class='el-message__closeBtn el-icon-close']");

    public static Target D_FIELD_PACKING_SLIP(String title) {
        return Target.the(title + "in packing slip")
                .locatedBy("//dt[text()='" + title + "']/following-sibling::dd/strong");
    }

    public static Target CHECKBOX_ORDER(String num) {
        return Target.the("CHECKBOX_ORDER on page " + num).locatedBy("//div[contains(text(),'" + num + "')]/parent::div/preceding-sibling::div[@class='edt-piece selectable']//span");
    }
}

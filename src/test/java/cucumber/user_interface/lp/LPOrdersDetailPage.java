package cucumber.user_interface.lp;

import net.serenitybdd.screenplay.targets.Target;

public class LPOrdersDetailPage {

    public static Target DYNAMIC_TARGET(String target) {
        return Target.the("")
                .locatedBy("//div[@class='edt-piece " + target + "']/div[2]");
    }

    public static Target D_INFO_SUB_INVOICE(String title) {
        return Target.the(title + "of sub invoice")
                .locatedBy("//dt[text()='" + title + "']/following-sibling::dd");
    }

    public static Target D_INFO_ITEM_SUB_INVOICE(String class_, int index) {
        return Target.the("D_INFO_ITEM_SUB_INVOICE")
                .locatedBy("(//td[@class='" + class_ + "'])[" + index + "]");
    }

    public static Target TOTAL_SUMMARY_ITEM_SUB_INVOICE(String class_) {
        return Target.the("TOTAL_SUMMARY_ITEM_SUB_INVOICE")
                .locatedBy("//strong[normalize-space()='Total']/parent::td/following-sibling::td[@class='" + class_ + "']");
    }

    public static Target STORAGE_ITEM_SUB_INVOICE(String title) {
        return Target.the(title + "of sub invoice")
                .locatedBy("//table[contains(@class,'mt-3 order-items')]/tbody/tr/td[1]/strong[text()='" + title + "']");
    }

    public static Target D_INFO_PACKING_SLIP(String title) {
        return Target.the(title + "of packing slip")
                .locatedBy("//dt[text()='" + title + "']/following-sibling::dd/strong");
    }

    public static Target PACKING_SLIP_NUMBER = Target.the("number of packing slip")
                .locatedBy("//h1[@class='order-number']");

    public static Target INVOICE_EFFECTIVE = Target.the("Effective ")
                .locatedBy("//div[@class='message']");

    public static Target D_INFO_ITEM_PACKING_SLIP(String class_, int item) {
        return Target.the("of packing slip")
                .locatedBy("(//table[@class='mt-3']//tbody//*[@class='" + class_ + "'])[" + item + "]");
    }

    public static Target D_INFO_ITEM_PACKING_SLIP(String class_, String item) {
        return Target.the("of packing slip")
                .locatedBy("//div[contains(text(),'" + item + "')]/ancestor::tr//*[@class='" + class_ + "']");
    }

    public static Target DYNAMIC_TARGET2(String target) {
        return Target.the("")
                .locatedBy("//dt[normalize-space()='" + target + ":']/following-sibling::dd[1]");
    }

    public static Target UPLOAD_POD = Target.the("UPLOAD_POD")
            .locatedBy("//input[@type='file']");

    public static Target BUYER = Target.the("")
            .locatedBy(".buyer-name.pf-ellipsis");

    public static Target NUMBER_PO = Target.the("NUMBER_PO")
            .locatedBy("//h1[@class='page__title']");

    public static Target STORE = Target.the("")
            .locatedBy(".store-name.pf-ellipsis");

    public static Target LP_NOTE = Target.the("")
            .locatedBy("//input[@placeholder='Write your note here...']");

    public static Target LP_NOTE2 = Target.the("")
            .locatedBy("//*[normalize-space()='Note']/following-sibling::input");

    public static Target SAVE_LP_NOTE = Target.the("SAVE_LP_NOTE")
            .locatedBy("//input[@placeholder='Write your note here...']/following-sibling::div/button");

    public static Target DISTRIBUTION_CENTER = Target.the("")
            .locatedBy("//*[contains(text(),'Distribution center:')]/following-sibling::span");

    public static Target DISTRIBUTION_CENTER_NAME = Target.the("")
            .locatedBy("//*[contains(text(),'Distribution center name')]/following-sibling::span");

    public static Target DYNAMIC_FILTER(String title) {
        return Target.the(title)
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static Target DYNAMIC_ORDER_BY_ID(String id) {
        return Target.the("Order by " + id)
                .locatedBy("//div[@class='content']//div[contains(text(),'" + id + "')]");
    }

    public static Target DISTRIBUTION_CENTER(int i) {
        return Target.the("")
                .locatedBy("(//*[contains(text(),'Distribution center:')]/following-sibling::span)[" + i + "]");
    }

    public static Target DISTRIBUTION_CENTER_NAME(int i) {
        return Target.the("")
                .locatedBy("(//*[contains(text(),'Distribution center name')]/following-sibling::span)[" + i + "]");
    }

    public static Target D_ITEM_INFO(String sku, String info) {
        return Target.the("brand")
                .locatedBy("//div[contains(text(),'" + sku + "')]/parent::div/div[@class='" + info + "']");
    }

    public static Target BRAND(int i) {
        return Target.the("brand")
                .locatedBy("(//div[@class='brand'])[" + i + "]");
    }

    public static Target PRODUCT(int i) {
        return Target.the("product")
                .locatedBy("(//div[@class='product'])[" + i + "]");
    }

    public static Target SKU(int i) {
        return Target.the("sku")
                .locatedBy("(//div[@class='info-variant__name'])[" + i + "]");
    }

    public static Target PACK(int i) {
        return Target.the("pack")
                .locatedBy("(//div[@class='pack'])[" + i + "]");
    }

    public static Target POD_CONSIGNMENT_AUTO_CONFIRMATION(int i) {
        return Target.the("Pod Consignment auto-confirmation")
                .locatedBy("(//div[@class='content pf-ellipsis'])[" + i + "]");
    }

    public static Target POD_CONSIGNMENT_AUTO_CONFIRMATION(String sku) {
        return Target.the("Pod Consignment auto-confirmation")
                .locatedBy("//div[contains(text(),'" + sku + "')]/ancestor::div[@class='edt-row']//div[@class='content pf-ellipsis']");
    }

    public static Target UNIT_UPC(int i) {
        return Target.the("sku")
                .locatedBy("(//div[@class='upc'])[" + i + "]");
    }

    public static Target STORAGE_CONDITION(int i) {
        return Target.the("Storage condition")
                .locatedBy("(//div[@class='edt-piece storage pf-nowrap']/div/div[2])[" + i + "]");
    }

    public static Target STORAGE_CONDITION(String sku) {
        return Target.the("Storage condition")
                .locatedBy("//div[contains(text(),'" + sku + "')]/ancestor::div[@class='edt-row']//div[@class='edt-piece storage pf-nowrap']");
    }

    public static Target NUMBER(String number) {
        return Target.the("po number")
                .locatedBy("//div[contains(@class,'md focus') and contains(text(),'" + number + "')]");
    }

    public static Target QUANTITY(int i) {
        return Target.the("QUANTITY")
                .locatedBy("(//div[@class='edt-piece quantity pf-nowrap']/div[2])[" + i + "]");
    }

    public static Target QUANTITY(String sku) {
        return Target.the("QUANTITY")
                .locatedBy("//div[contains(text(),'" + sku + "')]/ancestor::div[@class='edt-row']//div[@class='edt-piece quantity pf-nowrap']");
    }

    public static Target FULFILLMENT_DATE = Target.the("FULFILLMENT_DATE")
            .locatedBy("//div[normalize-space()='Fulfillment date']");

    public static Target EXPECTED_FULFILLMENT_DATE = Target.the("FULFILLMENT_DATE")
            .locatedBy("//div[normalize-space()='Fulfillment date']/following-sibling::p/strong");

    public static Target FULFILLED_DATE = Target.the("FULFILLMENT_DATE")
            .locatedBy("//div[normalize-space()='Fulfillment details']/following-sibling::div");

    public static Target CURRENT_ON_FULFILLMENT_DATE(String date) {
        return Target.the("CURRENT_ON_FULFILLMENT_DATE")
                .locatedBy("//div[contains(@class,'" + date + "')]//div[@class='vc-highlight'][contains(@style,'gray-600')]");

    }

    public static Target EXPECTED_ON_FULFILLMENT_DATE(String date) {
        return Target.the("CURRENT_ON_FULFILLMENT_DATE")
                .locatedBy("//div[contains(@class,'" + date + "')]//div[@class='vc-highlight'][contains(@style,'pink-600')]");

    }

    public static Target FULFILLMENT_DATE1 = Target.the("FULFILLMENT_DATE")
            .locatedBy("//div[normalize-space()='Fulfillment date']");

    public static Target SET_FULFILLMENT_DATE1 = Target.the("Button Set fulfillment date")
            .locatedBy("//button//span[contains(text(),'Set fulfillment date as')]");

    public static Target LEFT_ARROW_DATE = Target.the("Button left arrow in date time")
            .locatedBy("//div[@class='vc-arrow is-left']");

    public static Target RIGHT_ARROW_DATE = Target.the("Button right arrow in date time")
            .locatedBy("//div[@class='vc-arrow is-right']");

    public static Target FULFILLMENT_DATE(String i) {
        return Target.the("FULFILLMENT_DATE")
                .locatedBy("(//span[contains(@aria-label,'" + i + "')])[last()]");//Monday, May 23, 2022
    }

    public static Target FULFILLMENT_DATE_IN_MONTH(String i) {
        return Target.the("FULFILLMENT_DATE")
                .locatedBy("(//span[contains(@aria-label,'" + i + "')])[last()]/parent::div");//Monday, May 23, 2022
    }

    public static Target POD_UPLOADED(String class_) {
        return Target.the("POD_UPLOADED")
                .locatedBy("//a[@class='document flex']//div[@class='file']/div[contains(@class,'" + class_ + "')]");
    }

    public static Target REMOVE_POD_UPLOADED(String file) {
        return Target.the("POD_UPLOADED")
                .locatedBy("//a[contains(@href,'" + file + "')]//div[@class='remove']");
    }

    public static Target SET_FULFILLMENT_DATE_BUTTON = Target.the("Set fulfillment date")
            .locatedBy("//*[contains(text(),'Set fulfillment date as')]/ancestor::button");

    public static Target ROUTE(int i) {
        return Target.the("route")
                .locatedBy("(//a[@class='edt-row record']//div[@class='edt-piece route']/div[2])[" + i + "]");
    }

    public static Target ADDRESS(int i) {
        return Target.the("Address")
                .locatedBy("(//a[@class='edt-row record']//div[@class='edt-piece address']/div[2])[" + i + "]");
    }

    /**
     * Invoice
     */
    public static final Target MESSAGE_SUCCESS = Target.the("Invoice button")
            .locatedBy("//p[@class='el-message__content']");

    public static final Target TOTAL_INVOICE = Target.the("Total invoice")
            .locatedBy("//dd[contains(@class,'invoice-total')]/strong");

    public static final Target SOS_INVOICE = Target.the("Small Order Surcharge invoice")
            .locatedBy("(//dt[text()='Small Order Surcharge']/following-sibling::dd)[1]");

    public static final Target LS_INVOICE = Target.the("Logistics Surcharge invoice")
            .locatedBy("(//dt[text()='Logistics Surcharge']/following-sibling::dd)[1]");

    public static final Target PROMO_INVOICE = Target.the("Promotional Discount invoice")
            .locatedBy("(//dt[text()='Promotional Discount']/following-sibling::dd)[1]");
}

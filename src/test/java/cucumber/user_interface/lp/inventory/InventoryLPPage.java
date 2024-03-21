package cucumber.user_interface.lp.inventory;

import net.serenitybdd.screenplay.targets.Target;

public class InventoryLPPage {
    public static Target ALL_TAB = Target.the("All inventory page")
            .locatedBy("//a[normalize-space()='All Inventory']");

    public static Target D_HEADER_TAB(String title) {
        return Target.the(title)
                .locatedBy("//div[@class='page lp inventory']//a[text()='" + title + "']");

    }

    /**
     * Tab in header
     */
    public static Target D_TAB(String title) {
        return Target.the(title)
                .locatedBy("//div[@class='tabs-input']//span[text()='" + title + "']");
    }


    public static Target ALL_TAB_SMALL = Target.the("All inventory page")
            .locatedBy("//div[@class='label']//span[contains(text(),'All')]");

    public static Target SKU_SEARCH = Target.the("SKU field")
            .locatedBy("//label[normalize-space()='SKU']/following-sibling::div/input");

    public static Target PRODUCT_SEARCH = Target.the("Product field")
            .locatedBy("//label[normalize-space()='Product']/following-sibling::div/input");

    public static Target VENDOR_COMPANY_SEARCH = Target.the("Vendor company field")
            .locatedBy("//label[normalize-space()='Vendor Company']/following-sibling::div/input");

    public static Target VENDOR_BRAND_SEARCH = Target.the("Vendor brand field")
            .locatedBy("//label[normalize-space()='Vendor Brand']/following-sibling::div/input");

    public static Target LOADING = Target.the("Loading icon")
            .locatedBy("//div[@class='loading no-padding']//div[@class='loading--layout']");

    public static Target DYNAMIC_FILTER(String title) {
        return Target.the(title)
                .locatedBy("//label[text()='" + title + "']/following-sibling::div//input");
    }

    public static Target DYNAMIC_ORDER_BY_ID(String id) {
        return Target.the("Order by " + id)
                .locatedBy("//div[@class='content']//div[contains(text(),'" + id + "')]");
    }

    //name, distribution-center, vendor-company, lot-code, current-quantity, original-quantity, received, expiry
    public static Target DYNAMIC_TABLE(String value, int i) {
        return Target.the(value + "field")
                .locatedBy("(//div[@class='edt-piece " + value + "']/div[2])[" + i + "]");
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
     * Table result
     */

    public static Target LOT_CODE_IN_TABLE_RESULT(String lotCode) {
        return Target.the("Lot code in table result")
                .locatedBy("//div[text()='Lot code']/following-sibling::div[text()='" + lotCode + "']");
    }

    public static Target SKU_IN_TABLE_RESULT(String lotCode) {
        return Target.the("Sku in table result")
                .locatedBy("//div[contains(text(),'" + lotCode + "')]/parent::div/preceding-sibling::div[contains(@class,'name')]//span");
    }

    public static Target DISTRIBUTION_IN_TABLE_RESULT(String lotCode) {
        return Target.the("Distribution center in table result")
                .locatedBy("//div[contains(text(),'" + lotCode + "')]/parent::div/preceding-sibling::div[contains(@class,'distribution')]//div[2]");
    }
    public static Target RUNNING_LOW_PRODUCT_IN_TABLE_RESULT(String lotCode) {
        return Target.the("Product center in table result")
                .locatedBy("//div[contains(text(),'" + lotCode + "')]/parent::div/preceding-sibling::div[contains(@class,'product-name')]//span");
    }
    public static Target RUNNING_LOW_VENDOR_IN_TABLE_RESULT(String lotCode) {
        return Target.the("Product center in table result")
                .locatedBy("//div[contains(text(),'" + lotCode + "')]/parent::div/following-sibling::div[contains(@class,'vendor-company')]/div[2]");
    }

    public static Target VENDOR_COMPANY_IN_TABLE_RESULT(String lotCode) {
        return Target.the("Vendor company center in table result")
                .locatedBy("//div[contains(text(),'" + lotCode + "')]/parent::div/preceding-sibling::div[contains(@class,'vendor-company')]//div[2]");
    }

    public static Target CURRENT_QTY_IN_TABLE_RESULT(String lotCode) {
        return Target.the("Current qty center in table result")
                .locatedBy("//div[contains(text(),'" + lotCode + "')]/parent::div/following-sibling::div[contains(@class,'current-quantity')]//div[2]");
    }

    public static Target ORIGINAL_QTY_IN_TABLE_RESULT(String lotCode) {
        return Target.the("Original qty center in table result")
                .locatedBy("//div[contains(text(),'" + lotCode + "')]/parent::div/following-sibling::div[contains(@class,'original-quantity')]//div[2]");
    }

    public static Target END_QTY_IN_TABLE_RESULT(String lotCode) {
        return Target.the("Original qty center in table result")
                .locatedBy("//div[contains(text(),'" + lotCode + "')]/parent::div/following-sibling::div[contains(@class,'end-quantity')]//div[2]");
    }

    public static Target RECEIVE_QTY_IN_TABLE_RESULT(String lotCode) {
        return Target.the("Receive qty center in table result")
                .locatedBy("//div[contains(text(),'" + lotCode + "')]/parent::div/following-sibling::div[contains(@class,'received')]//span");
    }

    public static Target EXPIRY_QTY_IN_TABLE_RESULT(String lotCode) {
        return Target.the("Expiry qty center in table result")
                .locatedBy("//div[contains(text(),'" + lotCode + "')]/parent::div/following-sibling::div[contains(@class,'expiry')]//span");
    }

    public static final Target NEXT_RESULT_BUTTON = Target.the("Next result button")
            .locatedBy("//div[contains(@class,'paginator')]//button[@class='btn-next']");

    public static final Target NEXT_RESULT_BUTTON_DISABLE = Target.the("Next result button")
            .locatedBy("//div[contains(@class,'paginator')]//button[@class='btn-next' and @disabled]");

    /**
     * Inventory Images
     */
    public static Target IMAGE_PREVIEW(String image, String index) {
        return Target.the("Image " + image + " " + index)
                .locatedBy("(//div[contains(@style,'" + image + "')])[" + index + "]");
    }

    public static Target DESCRIPTION_IMAGE(String index) {
        return Target.the("Image " + index)
                .locatedBy("(//div[@class='description'])[" + index + "]");
    }
    public static Target DELETE_IMAGE(int i) {
        return Target.the("delete images")
                .locatedBy("(//div[@class='actions']/button)[" + i + "]");
    }


}

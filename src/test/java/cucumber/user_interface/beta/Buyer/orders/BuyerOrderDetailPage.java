package cucumber.user_interface.beta.Buyer.orders;


import net.serenitybdd.screenplay.targets.Target;

public class BuyerOrderDetailPage {

    public static Target BACK_TO_ORDER = Target.the("Back to order")
            .locatedBy("//a[normalize-space()='< Back to Orders']");

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

    public static Target QUANTITY_PRE(String sku) {
        return Target.the("Quantity of pre order")
                .locatedBy("(//div[text()='" + sku + "']/ancestor::div//div[@class='quantity'])[1]");
    }


    public static Target CASE_PRICE(int i) {
        return Target.the("case price")
                .locatedBy("(//div[@class='quantity']/parent::div/div[1])[" + i + "]");
    }

    public static Target FULFILLMENTSTATUS(int i) {
        return Target.the("status")
                .locatedBy("(//div[@class='edt-row']//div[@class='status-tag'])[" + i + "]");
    }

    public static Target UNIT_UPC(int i) {
        return Target.the("status")
                .locatedBy("(//div[@class='edt-row']//div[@class='upc'])[" + i + "]");
    }

    public static Target UNIT_EAN(int i) {
        return Target.the("status")
                .locatedBy("(//div[@class='edt-row']//div[@class='ean'])[" + i + "]");
    }

    public static Target PRICE_PER_UNIT(int i) {
        return Target.the("price per unit")
                .locatedBy("(//div[@class='pack']/span[1])[" + i + "]");
    }

    public static Target CASE_PER_UNIT(int i) {
        return Target.the("case per unit")
                .locatedBy("(//div[@class='pack']/span[2])[" + i + "]");
    }

    public static Target FULFILLED(int i) {
        return Target.the("fulfilled")
                .locatedBy("(//div[@class='edt-row']//div[@class='fulfilled'])[" + i + "]");
    }

    public static Target ADD_TO_CART_BUTTON(int i) {
        return Target.the("Add to cart button")
                .locatedBy("(//div[@class='edt-piece action pf-nowrap']/button)[" + i + "]");
    }

    public static Target ADD_TO_CART_BUTTON(String sku) {
        return Target.the("Add to cart button")
                .locatedBy("//div[normalize-space()='" + sku + "']//ancestor::div[@class='edt-row']//button");
    }

    public static Target TOOLTIP_ADD_TO_CART(String message) {
        return Target.the("Tooltip add to cart message " + message)
                .locatedBy("//div[@role='tooltip']//div[contains(text(),'" + message + "')]");
    }


    public static Target ORDER_BUYER_NAME = Target.the("")
            .locatedBy("//div[@class='order-buyer-name']");

    public static Target ORDER_STORE_NAME = Target.the("")
            .locatedBy("//div[@class='order-store-name']");

    public static Target ORDER_BUYER_EMAIL = Target.the("Order buyer email")
            .locatedBy("//a[contains(@class,'order-buyer-email')]");

    public static Target ORDER_SPIPPING_ADDRESS = Target.the("")
            .locatedBy("//div[@class='address-stamp']");

    public static Target ORDER_VALUE = Target.the("")
            .locatedBy("//dt[normalize-space()='Order Value']/following-sibling::dd[1]");

    public static Target ORDER_TOTAL = Target.the("")
            .locatedBy("//dt[normalize-space()='Total']/following-sibling::dd");

    public static Target SMALL_ORDER_SURCHAGE = Target.the("")
            .locatedBy("//dd[@class='text-right order-surcharge']");

    public static Target LOGISTICS_SURCHAGE = Target.the("")
            .locatedBy("//dd[@class='text-right logistics-surcharge']");

    public static Target DISCOUNT_VALUE = Target.the("Discount value")
            .locatedBy("//dd[contains(@class,'order-promotion')]/div");

    public static Target SPECIAL_DISCOUNT_VALUE = Target.the("Special discount value")
            .locatedBy("//dd[contains(@class,'special-discount')]/div");

    public static Target TAX_VALUE = Target.the("tax value")
            .locatedBy("//dd[contains(@class,'rder-total-state-fee')]/div");

    public static Target ORDER_PAYMENT_INFO = Target.the("")
            .locatedBy("//div[@class='payment-info']");

    public static Target ORDER_PAYMENT_STATUS = Target.the("")
            .locatedBy("//div[normalize-space()='Payment']/following-sibling::div[@class='status-tag']");

    public static Target SUB_INVOICE_NUM(String subInvoice) {
        return Target.the("Sub invoice")
                .locatedBy("//ul[@class='sub-invoice-list']//span[contains(@class,'sub-invoice-number') and contains(text(),'" + subInvoice + "')]");
    }

    public static Target SUB_INVOICE_TOTAL(String subInvoice) {
        return Target.the("Sub invoice total")
                .locatedBy("//ul//span[contains(@class,'sub-invoice-number') and contains(text(),'" + subInvoice + "')]/following-sibling::span[contains(@class,'sub-invovice-total')]");
    }

    public static Target SUB_INVOICE_PAYMENT(String subInvoice) {
        return Target.the("")
                .locatedBy("//ul//span[contains(@class,'sub-invoice-number') and contains(text(),'" + subInvoice + "')]/following-sibling::span[contains(@class,'sub-invoice-payment')]");
    }

    public static Target ORDER_DATE_FIELD = Target.the("Order date in order detail")
            .locatedBy("//div[text()='Order date']/following-sibling::div");


    public static Target DYNAMIC_CONFIRM(String s) {
        return Target.the("")
                .locatedBy("//dt[text()='" + s + "']/following-sibling::dd");
    }

    public static Target DYNAMIC_CONFIRM2(String s) {
        return Target.the("")
                .locatedBy("//dt[text()='" + s + "']/following-sibling::dd/span");
    }

    public static Target DELIVERY_DATE = Target.the("Delivery date")
            .locatedBy("//dt[text()='Delivery Date']/following-sibling::dd[@class='delivery-date']");

    public static Target LAUNCHING_SOON_DATE(int index) {
        return Target.the("Launching soon date in line item")
                .locatedBy("(//div[@class='coming-soon'])[" + index + "]");
    }

    public static Target STATUS_TAG(int index) {
        return Target.the("Status tag in line item")
                .locatedBy("(//div[@class='status-tag'])[" + index + "]");
    }

    /**
     * Delivery status
     */

    public static Target REORDER = Target.the("Reorder")
            .locatedBy("//span[contains(text(),'Reorder')]");

    public static Target REORDER_ADD = Target.the("ADD")
            .locatedBy("//span[normalize-space()='Add']");

    /**
     * Reorder popup
     */
    public static Target REORDER_QUANTITY_OF_SKU(String skuName) {
        return Target.the("REORDER_QUANTITY_OF_SKU " + skuName)
                .locatedBy("//div[text()='" + skuName + "']/ancestor::div[@class='sku']/div[@class='quantity']//input");
    }

    public static Target REORDER_POPUP_TITLE = Target.the("Title popup Add items to cart")
            .locatedBy("//div[@class='page__dialog-title']");

    public static Target REORDER_POPUP_HEADER(int index) {
        return Target.the("Reorder popup header")
                .locatedBy("(//div[@role='dialog']//h2)[" + index + "]");
    }

    public static Target REORDER_POPUP_DESCRIPTION(int index) {
        return Target.the("Reorder popup description")
                .locatedBy("(//div[@aria-label='dialog']//p)[" + index + "]");
    }

    public static Target REORDER_POPUP_PRODUCT(int index) {
        return Target.the("Reorder popup product item")
                .locatedBy("(//div[@aria-label='dialog']//div[@class='product']/span)[" + index + "]");
    }

    public static Target REORDER_POPUP_SKU(int index) {
        return Target.the("Reorder popup sku item")
                .locatedBy("(//div[@aria-label='dialog']//div[@class='info-variant__name'])[" + index + "]");
    }

    public static Target REORDER_POPUP_UNITCASE(int index) {
        return Target.the("Reorder popup sku item")
                .locatedBy("(//div[@aria-label='dialog']//span[@class='case-unit'])[" + index + "]");
    }

    public static Target REORDER_POPUP_PRICE(int index) {
        return Target.the("Reorder popup sku price")
                .locatedBy("(//div[@aria-label='dialog']//div[@class='price']/span)[" + index + "]");
    }

    /**
     * Pre-order detail
     */
    public static Target HIGHTLIGHT_PRE_ORDER = Target.the("Highlight pre order")
            .locatedBy("//span[text()='This is a pre-order.']");

    public static Target DATE_PRE_ORDER_HEADER = Target.the("Date pre-order header")
            .locatedBy("//div[contains(text(),'Pre-order date:')]/following-sibling::div");


    public static Target CASE_PRICE_PRE(String sku) {
        return Target.the("Case price")
                .locatedBy("(//div[text()='" + sku + "']/ancestor::div//div[@class='case-price'])[1]");
    }

    /**
     * Order detail have multi subinvoice
     */

    public static Target BRAND_NAME(String subinvoice, String index) {
        return Target.the("Brand name " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//div[@class='brand'])[" + index + "]");
    }

    public static Target PRODUCT_NAME(String subinvoice, String index) {
        return Target.the("Product name " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//div[@class='product']//a)[" + index + "]");
    }

    public static Target SKU_NAME(String subinvoice, String index) {
        return Target.the("SKU name " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//div[contains(@class,'variant__name')])[" + index + "]");
    }

    public static Target UNIT_PER_CASE(String subinvoice, String index) {
        return Target.the("Unit per case " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//span[@class='case-unit'])[" + index + "]");
    }

    public static Target CASE_PRICE(String subinvoice, String index) {
        return Target.the("Case price " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//div[@class='quantity']/preceding-sibling::div)[" + index + "]");
    }

    public static Target QUANTITY(String subinvoice, String index) {
        return Target.the("Quantity " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//div[@class='quantity'])[" + index + "]");
    }

    public static Target TOTAL(String subinvoice, String index) {
        return Target.the("Total " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//div[@class='total'])[" + index + "]");
    }

    public static Target ADD_TO_CART_BUTTON(String subinvoice, String index) {
        return Target.the("Button add to cart " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//button)[" + index + "]");
    }

    public static Target FULFILLMENT_STATUS(String subinvoice, String index) {
        return Target.the("Status " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//div[@class='status-tag'])[" + index + "]");
    }

    public static Target FULFILLMENT_STATUS_LINEITEM(String subinvoice) {
        return Target.the("Fulfilment status of sub invoice " + subinvoice)
                .locatedBy("//span[contains(text(),'" + subinvoice + "')]/following-sibling::div/div[@class='status-tag']");
    }

    public static Target FULFILLMENT_DATE(String subinvoice, String index) {
        return Target.the("Status " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//div[@class='status-tag' and text()='Fulfilled']/following-sibling::div)[" + index + "]");
    }

    public static Target UNIT_UPC(String subinvoice, String index) {
        return Target.the("Unit UPC " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//div[@class='upc']/strong)[" + index + "]");
    }

    public static Target UNIT_EAN(String subinvoice, String index) {
        return Target.the("Unit earn " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//div[@class='ean']/strong)[" + index + "]");
    }

    public static Target PRICE_PER_UNIT(String subinvoice, String index) {
        return Target.the("Price per unit " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//div[@class='pack']/span[1])[" + index + "]");
    }

    public static Target CASE_PER_UNIT(String subinvoice, String index) {
        return Target.the("Case per unit " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/parent::div/following-sibling::div[@class='sub-invoice-item-list']//div[@class='pack']/span[2])[" + index + "]");
    }

    public static Target ETA(String subinvoice, String index) {
        return Target.the("ETA " + index + " of sub invoice " + subinvoice)
                .locatedBy("(//span[contains(text(),'" + subinvoice + "')]/following-sibling::span[contains(@class,'eta')]/span[2])[" + index + "]");
    }

    public static Target ETA(int index) {
        return Target.the("ETA " + index + " of sub invoice ")
                .locatedBy("(//span[contains(@class,'eta')]/span[2])[" + index + "]");
    }
}

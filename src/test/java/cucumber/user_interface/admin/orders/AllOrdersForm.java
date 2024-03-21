package cucumber.user_interface.admin.orders;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class AllOrdersForm {

    public static Target ORDER_TITLE = Target.the("Admin Order title")
            .located(By.xpath("//div[@class='title']/span"));

    public static Target ORDER_DETAIL_FIRST_RESULT = Target.the("Order detail first result")
            .located(By.xpath("(//a[@class='number'])[1]"));

    public static Target ORDER_DETAIL_BY_ID(String idInvoice) {
        return Target.the("Detail of " + idInvoice)
                .located(By.xpath("//td//a[text()='" + idInvoice + "']"));
    }

    public static Target SMALL_ORDER_SURCHARGE = Target.the("Small order surcharge")
            .located(By.xpath("//dd[@class='shipping-fee']//div[contains(@class,'content')]/span"));

    public static Target LOGISTICS_SURCHARGE = Target.the("Logistics surcharge")
            .located(By.xpath("//dd[@class='logistics-surcharge']//div[contains(@class,'content')]/span"));

    public static Target TOTAL_PAYMENT = Target.the("Total payment")
            .located(By.xpath("//dd[@class='total-payment']//div/span"));

    public static Target DISCOUNT_PRICE = Target.the("Discount")
            .located(By.xpath("//dd[@class='discount']"));


    public static Target DELETE_ORDER(String idInvoice) {
        return Target.the("Delete order " + idInvoice)
                .located(By.xpath("(//a[normalize-space()='" + idInvoice + "']/ancestor::tr//td[contains(@class,'actions')]//button)[2]"));
    }

    public static Target DELETE_ORDER_NOTE = Target.the("Note for delete order")
            .located(By.xpath("//div[@id='global-dialogs']//textarea[contains(@class,'el-textarea__inner')]"));

    public static Target DELETE_ORDER_REASON = Target.the("Reason for delete order")
            .located(By.xpath("//label[normalize-space()='Reason']/following-sibling::div//input"));

    public static Target DELETE_ORDER_PASSKEY = Target.the("Passkey for delete order")
            .located(By.xpath("//label[normalize-space()='Passkey']/following-sibling::div//input"));

    public static Target DELETE_ORDER_DETAIL = Target.the("Delete order")
            .located(By.xpath("(//div[@class='actions']//button[contains(@class,'el-button el-button--danger')])[2]"));

    public static Target DELETE_ORDER_BUTTON = Target.the("Confirm delete order")
            .located(By.xpath("//button[@type='button']//span[contains(text(),'Delete')]"));
    /**
     * Non - invoice
     */
    public static Target NON_INVOICE = Target.the("Non-invoice row")
            .located(By.xpath("//strong[text()='Non-invoiced']"));
    public static Target NON_INVOICE_EXPAND = Target.the("Non-invoice row")
            .located(By.xpath("//a[@title='Expand this invoice' and @class='name flex']"));

    public static Target CHECKBOX_SELECT_BY_SKU(String skuName) {
        return Target.the("Non-invoice row")
                .located(By.xpath("(//span[(@data-original-text='" + skuName + "') or (text()='" + skuName + "')]//ancestor::td/preceding-sibling::td/input)[last()]"));
    }

    public static Target CHECKBOX_SELECT_BY_SKU_DISABLE(String skuName, String index) {
        return Target.the("Non-invoice row")
                .located(By.xpath("(//span[text()='" + skuName + "']//ancestor::td/preceding-sibling::td/input[@disabled='disabled'])[" + index + "]"));
    }

    /**
     * Create sub-invoice popup
     */

    public static Target SET_INVOICE = Target.the("Set-invoice")
            .located(By.xpath("//div[@class='selecting-bar']//span[text()='Set invoice']"));

    public static Target SELECTED_TO_SUB_INVOICE = Target.the("Seleted to sub-invoice")
            .located(By.xpath("//div[@role='dialog']//input[@placeholder='Choose an action']"));

    public static Target ITEM_SELETED_TO_SUB_INVOICE(String value, String index) {
        return Target.the("Item seleted to sub-invoice")
                .located(By.xpath("(//div[contains(@class,'popper-sub-invoice-select')]//span[contains(text(),'" + value + "')])[" + index + "]"));
    }

    public static Target SUFFIX_TEXTBOX = Target.the("Suffix textbox")
            .located(By.xpath("//label[text()='Suffix']/following-sibling::div//input"));

    public static Target UPDATE_SELETED_TO_SUB_INVOICE = Target.the("Update selected sub-invoice button")
            .located(By.xpath("//div[@role='dialog']//button[@class='el-button el-button--primary']//*[text()='Update']"));

    public static Target ID_SUB_INVOICE = Target.the("ID sub-invoice")
            .located(By.xpath("//strong[contains(text(),'Sub-invoice')]/following-sibling::strong"));

    /**
     * Sub-invoid express
     */

    public static Target END_QUANTITY_TOTAL = Target.the("Total end quantity")
            .located(By.xpath("//div[@class='total']/strong"));

    public static Target TOTAL_PRICE_IN_LINE(String skuName) {
        return Target.the("Total price in line")
                .located(By.xpath("//span[contains(text(),'" + skuName + "')]/ancestor::td/following::td/div[@class='totals']/strong"));
    }

    public static Target PO_LABEB_IN_SUBINVOICE = Target.the("Purchase order in subinvoice")
            .located(By.xpath("//tr[@class='purchase-order']//span[@class='name']"));
    /**
     * Add purchase order
     */

    public static Target PO_BUTTON = Target.the("Purchase order button")
            .located(By.xpath("//button//span[text()='PO']"));

    public static Target EDIT_PO_BUTTON(String subInvoice) {
        return Target.the("Edit Purchase order button")
                .located(By.xpath("//strong[contains(text(),'" + subInvoice + "')]/ancestor::tr/following-sibling::tr/td/button[1]"));
    }

    public static Target DRIVER_TEXTBOX = Target.the("Purchase order button")
            .located(By.xpath("//label[text()='Driver']//following-sibling::div//input"));

    public static Target D_TEXTBOX(String value) {
        return Target.the(value)
                .located(By.xpath("//label[text()='" + value + "']//following-sibling::div//input"));
    }

    public static Target D_TEXTBOX1(String value) {
        return Target.the(value)
                .located(By.xpath("//label[@for='" + value + "']//following-sibling::div//input"));
    }

    public static Target FULFILMENT_DATE_ERROR_MESSAGE = Target.the("Fulfillment date error message")
            .located(By.xpath("//label[text()='Fulfillment date']/following-sibling::div//div[@class='el-form-item__error']"));

    public static Target DYNAMIC_ITEM(String value) {
        return Target.the(value)
                .located(By.xpath("//div[@class='el-scrollbar']//span[text()='" + value + "']"));
    }

    public static Target CREATE_PO_BUTTON(String type) {
        return Target.the(type + " PO button")
                .located(By.xpath("//div[@class='el-dialog__wrapper']//button//span[text()='" + type + "']"));
    }

    public static Target PROOF_UPLOADED = Target.the("Proof upload")
            .located(By.xpath("//label[text()='Proof of delivery']/following-sibling::div//div[@class='input']/div"));

    public static Target ICON_CLOSE_DATE = Target.the("Icon close date")
            .located(By.xpath("//label[text()='Fulfillment date']/following-sibling::div//i[contains(@class,'circle-close')]"));

    public static Target CREATE_PO_CLOSE_POPUP_BUTTON = Target.the("Create po close popup button")
            .located(By.xpath("//span[text()='Create new Purchase Order']/parent::div/following-sibling::button/i"));


    /**
     * Result after search
     */

    public static Target ORDER_RESULT = Target.the("Order in result")
            .located(By.xpath("//td[contains(@class,'number')]//a"));

    public static Target CHECKOUT_RESULT = Target.the("Checkout in result")
            .located(By.xpath("//td[contains(@class,'checkout-date')]//span"));

    public static Target CREATOR_RESULT = Target.the("Creator in result")
            .located(By.xpath("//td[contains(@class,'crator')]//span"));

    public static Target CUSTOMER_PO_RESULT = Target.the("Customer PO in result")
            .located(By.xpath("//td[contains(@class,'customer-po')]//span"));

    public static Target BUYER_RESULT = Target.the("Buyer in result")
            .located(By.xpath("//td[contains(@class,'buyer')]//span"));

    public static Target STORE_RESULT = Target.the("Store in result")
            .located(By.xpath("//td[contains(@class,'store')]//span"));

    public static Target REGION_RESULT = Target.the("Region in result")
            .located(By.xpath("//td[contains(@class,'region')]//span"));

    public static Target TOTAL_RESULT = Target.the("Total in result")
            .located(By.xpath("//td[contains(@class,'total')]//div[@class='bold']"));

    public static Target VENDOR_FEE_RESULT = Target.the("Vendor fee in result")
            .located(By.xpath("//td[contains(@class,'service-fee')]//div[@class='bold']"));

    public static Target BUYER_PAYMENT_RESULT = Target.the("Buyer payment in result")
            .located(By.xpath("(//td[contains(@class,'payment-state')]//div[@class='status-tag'])[1]"));

    public static Target FULFILLMENT_RESULT = Target.the("Buyer payment in result")
            .located(By.xpath("(//td[contains(@class,'fulfillment-state')]//div[@class='status-tag'])[1]"));

    public static Target VENDOR_PAYMENT_RESULT = Target.the("Buyer payment in result")
            .located(By.xpath("(//td[contains(@class,'vendor-payment-state')]//div[@class='status-tag'])[1]"));

    public static Target PENDING_FINANCE_APPROVAL = Target.the("Pending finance approval")
            .located(By.xpath("//span[text()='Pending finance approval']"));

    public static Target APPROVE_TO_FULFILL = Target.the("Approve to fulfill")
            .located(By.xpath("//button//span[text()='Approve to fulfill']"));

    //Popup Warning This store has a credit issue. Make sure you check with finance team before approving this order.

    public static Target WARNING_POPUP = Target.the("Approve to fulfill")
            .located(By.xpath("//div[@role='dialog']//span[text()='Warning']"));

    public static Target APPROVE_THIS_ORDER_BUTTON = Target.the("Approve this order")
            .located(By.xpath("//div[@role='dialog']//button//span[text()='Approve this order only']|//div[@role='dialog']//button//span[text()='Ok']"));

    public static Target APPROVE_ALL_ORDERS_BUTTON = Target.the("Approve all pending orders")
            .located(By.xpath("//div[@role='dialog']//button//span[contains(text(),'Approve all pending orders')]"));

    /**
     * SKU popup when search
     */

    public static Target BRAND_IN_SKU_POPUP_SEARCH(String sku) {
        return Target.the("Brand of sku in popup search")
                .located(By.xpath("//div[@x-placement]//div[text()='" + sku + "']/preceding-sibling::div[@class='brand']"));
    }

    public static Target PRODUCT_IN_SKU_POPUP_SEARCH(String product) {
        return Target.the("Product of sku in popup search")
                .located(By.xpath("//div[@x-placement]//div[text()='" + product + "']/preceding-sibling::div[@class='product']"));
    }

    public static Target SKU_IN_SKU_POPUP_SEARCH(String sku) {
        return Target.the("SKU of sku in popup search")
                .located(By.xpath("//div[@x-placement]//div[text()='" + sku + "']"));
    }

    /**
     * Export order list
     */

    public static Target DANGER_EXPORT_TEXTBOX = Target.the("Danger export textbox in popup")
            .located(By.xpath("//span[text()='Danger']//ancestor::div/following-sibling::div//input"));

    public static Target EXPORT_BUTTON = Target.the("Export button")
            .located(By.xpath("(//div[@class='actions']//button)[1]"));

    public static Target ORDER_DETAIL_CSV = Target.the("Export button")
            .located(By.xpath("//li[text()='Order detail CSV']"));


}

package cucumber.user_interface.admin.orders;

import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class OrderDetailPage {

    /**
     * General information
     */
    public static Target GENERAL_INFORMATION = Target.the("General information").locatedBy("//div[text()='General information']");
    public static Target REGION_NAME = Target.the("REGION_NAME").located(By.cssSelector("dd.region >span"));
    public static Target BUYER_NAME = Target.the("BUYER_NAME").located(By.cssSelector("dd.buyer >div"));
    public static Target STORE_NAME = Target.the("STORE_NAME").located(By.cssSelector("dd.store >div"));
    public static Target PAYMENT_TYPE = Target.the("PAYMENT_TYPE").located(By.cssSelector("dd.payment-type span.payment-type"));
    public static Target BUYER_PAYMENT = Target.the("BUYER_PAYMENT").located(By.cssSelector("dd.buyer-payment div.status-tag"));
    public static Target VENDOR_PAYMENT = Target.the("VENDOR_PAYMENT").located(By.cssSelector("dd.vendor-payment div.status-tag"));
    public static Target FULFILLMENT = Target.the("FULFILLMENT").located(By.cssSelector("dd.fulfillment div.status-tag"));
    public static Target FINANCE_APPROVAL = Target.the("FINANCE APPROVAL").locatedBy("//dd[@class='finacnce-approval']/div");
    public static Target FINANCE_APPROVAL_BY = Target.the("FINANCE APPROVAL BY").locatedBy("//dd[@class='finance-approved-by']");
    public static Target FINANCE_APPROVAL_AT = Target.the("FINANCE APPROVAL AT").locatedBy("//dd[@class='finance-approved-at']");
    public static Target ROUTE = Target.the("Route").locatedBy("//dd[@class='route']");
    public static Target CREATOR = Target.the("Creator").locatedBy("//dd[@class='creator']/div");
    public static Target PAYMENT_DATE = Target.the("Payment date").locatedBy("//dd[@class='payment-date']/span");

    public static Target ORDER_VALUE = Target.the("ORDER_VALUE").located(By.cssSelector("dd.order-value"));
    public static Target DISCOUNT_VALUE = Target.the("DISCOUNT_VALUE").located(By.cssSelector("dd.discount"));
    public static Target SPECIAL_DISCOUNT = Target.the("DISCOUNT_VALUE").located(By.cssSelector("dd.special-discount"));
    public static Target TAXES_VALUE = Target.the("TAXES_VALUE").located(By.cssSelector("dd.taxes"));

    public static Target SMALL_ORDER_SURCHARGE(String sos) {
        return Target.the("SMALL_ORDER_SURCHARGE").locatedBy("//dd[@class='shipping-fee']//span[text()='" + sos + "']");
    }

    public static Target TOTAL_PAYMENT = Target.the("TOTAL_PAYMENT").located(By.cssSelector("dd.total-payment span.total"));
    public static Target VENDOR_SERVICE_FEE = Target.the("VENDOR_SERVICE_FEE").located(By.cssSelector("dd.vendor-service-fee"));
    public static Target DATE = Target.the("DATE").locatedBy("//dd[@class='date']");
    public static Target ADMIN_NOTE_FIELD = Target.the("Admin Note field")
            .located(By.cssSelector(".admin-note .note-to-admin"));
    public static Target ADMIN_NOTE_FIELD_EDIT = Target.the("Admin Note field edit")
            .locatedBy("//dd[@class='admin-note']/div");
    public static Target APPROVE_TO_FULFILL_BUTTON = Target.the("Approve to fulfill button")
            .locatedBy("//button//span[text()='Approve to fulfill']");
    public static Target BUYER_LINK = Target.the("Buyer link")
            .locatedBy("//dd[@class='buyer']//a");
    public static Target STORE_LINK = Target.the("Store link")
            .locatedBy("//dd[@class='store']//a");
    public static Target LINK_TAG_LINK = Target.the("Link tag link")
            .locatedBy("//dd[@class='creator']//a");
    public static Target SEND_DELIVERY_CONFIRMATION = Target.the("Send delivery confirmation")
            .locatedBy("//span[text()='Send delivery confirmation']/ancestor::button");

    public static Target MANAGED_BY = Target.the("Managed by")
            .locatedBy("//dd[@class='managed']");

    public static Target LAUNCHED_BY = Target.the("Launched by")
            .locatedBy("//dd[@class='launched-by']");

    public static Target ADDRESS = Target.the("Address")
            .locatedBy("//dd[@class='address']");
    /**
     * Line Items
     */
    public static Target EXPAND_ODER = Target.the("Expand order button")
            .locatedBy("//span[contains(text(),'Expand order')]");
    public static Target DIALOG_CLOSE_BUTTON = Target.the("Dialog close button")
            .located(By.xpath("//div[@aria-label='Add selected to sub-invoice']//i[contains(@class,'el-icon-close')]"));
    public static Target COLLAPSE_ODER = Target.the("Collapse order button")
            .locatedBy("//span[contains(text(),'Collapse order')]");
    public static Target LOADING_HEADER = Target.the("Expand order button")
            .locatedBy("//div[@class='nuxt-progress']");

    public static Target LINE_ITEM_OF_SUB_INVOICE_BRAND(String suffix, int index) {
        return Target.the("LINE_ITEM_OF_SUB_INVOICE" + suffix)
                .locatedBy("(//strong[contains(text(),'" + suffix + "')]/ancestor::tr/following-sibling::tr[@class='line-item'])[" + index + "]//a[@class='brand']/span");
    }

    public static Target LINE_ITEM_OF_SUB_INVOICE_PRODUCT(String suffix, int index) {
        return Target.the("LINE_ITEM_OF_SUB_INVOICE" + suffix)
                .locatedBy("(//strong[contains(text(),'" + suffix + "')]/ancestor::tr/following-sibling::tr[@class='line-item'])[" + index + "]//a[@class='product']/span");
    }

    public static Target LINE_ITEM_OF_SUB_INVOICE_SKU(String suffix, int index) {
        return Target.the("LINE_ITEM_OF_SUB_INVOICE" + suffix)
                .locatedBy("(//strong[contains(text(),'" + suffix + "')]/ancestor::tr/following-sibling::tr[@class='line-item'])[" + index + "]//*[@class='variant']/span");
    }

    public static Target LINE_ITEM_OF_SUB_INVOICE_CASE_PRICE(String suffix, int index) {
        return Target.the("LINE_ITEM_OF_SUB_INVOICE" + suffix)
                .locatedBy("(//strong[contains(text(),'" + suffix + "')]/ancestor::tr/following-sibling::tr[@class='line-item'])[" + index + "]//div[@class='case-price']");
    }

    public static Target LINE_ITEM_OF_SUB_INVOICE_CASE_UNIT(String suffix, int index) {
        return Target.the("LINE_ITEM_OF_SUB_INVOICE" + suffix)
                .locatedBy("(//strong[contains(text(),'" + suffix + "')]/ancestor::tr/following-sibling::tr[@class='line-item'])[" + index + "]//div[@class='units']");
    }
    public static Target LINE_ITEM_OF_SUB_INVOICE_QUANTITY(String suffix, int index) {
        return Target.the("LINE_ITEM_OF_SUB_INVOICE" + suffix)
                .locatedBy("(//strong[contains(text(),'" + suffix + "')]/ancestor::tr/following-sibling::tr[@class='line-item'])[" + index + "]//div[contains(@class,'item-quantity')]");
    }
    public static Target LINE_ITEM_OF_SUB_INVOICE_END_QUANTITY(String suffix, int index) {
        return Target.the("LINE_ITEM_OF_SUB_INVOICE" + suffix)
                .locatedBy("(//strong[contains(text(),'" + suffix + "')]/ancestor::tr/following-sibling::tr[@class='line-item'])[" + index + "]//span[@class='end-qty']");
    }
    public static Target LINE_ITEM_OF_SUB_INVOICE_END_TOTAL(String suffix, int index) {
        return Target.the("LINE_ITEM_OF_SUB_INVOICE" + suffix)
                .locatedBy("(//strong[contains(text(),'" + suffix + "')]/ancestor::tr/following-sibling::tr[@class='line-item'])[" + index + "]//strong[@class='total']");
    }

    public static Target LINE_ITEM_BRAND(String typeLine, int index) {
        return Target.the("Brand in line item of " + typeLine)
                .locatedBy("(//tbody[@class='" + typeLine + "']//a[@class='brand']/span)[" + index + "]");
    }

    public static Target LINE_ITEM_PRODUCT(String typeLine, int index) {
        return Target.the("Product in line item of " + typeLine)
                .locatedBy("(//tbody[@class='" + typeLine + "']//a[@class='product']/span)[" + index + "]");
    }

    public static Target LINE_ITEM_SKU(String typeLine, int index) {
        return Target.the("Sku in line item of " + typeLine)
                .locatedBy("(//tbody[@class='" + typeLine + "']//div[@class='variant']/span)[" + index + "]");
    }

    public static Target LINE_ITEM_CASE_PRICE(String typeLine, int index) {
        return Target.the("Case price in line item of " + typeLine)
                .locatedBy("(//tbody[@class='" + typeLine + "']//div[@class='case-price'])[" + index + "]");
    }

    public static Target LINE_ITEM_CASE_UNIT(String typeLine, int index) {
        return Target.the("Case Unit in line item of " + typeLine)
                .locatedBy("(//tbody[@class='" + typeLine + "']//div[@class='units'])[" + index + "]");
    }

    public static Target LINE_ITEM_QUANTITY1(String typeLine, int index) {
        return Target.the("Quantity in line item of " + typeLine)
                .locatedBy("(//tbody[@class='" + typeLine + "']//td[@class='quantity']//div/div[contains(@class,'quantity')])[" + index + "]");
    }

    public static Target LINE_ITEM_QUANTITY_DELETE(String typeLine, int index) {
        return Target.the("Quantity in line item delete of " + typeLine)
                .locatedBy("((//tbody[@class='" + typeLine + "']//td[contains(@class,'quantity')]//div[contains(@class,'quantity')])[" + index + "])[last()]");
    }

    public static Target LINE_ITEM_QUANTITY_DELETE1(String typeLine) {
        return Target.the("Quantity in line item delete of " + typeLine)
                .locatedBy("(//tbody[@class='" + typeLine + "']//td[contains(@class,'quantity')]//div[contains(@class,'quantity')])[last()]");
    }

    public static Target LINE_ITEM_QUANTITY_DELETE2(String typeLine) {
        return Target.the("Quantity in line item delete of " + typeLine)
                .locatedBy("(//tbody[@class='" + typeLine + "']//td//div[contains(@class,'quantity')])[last()]");
    }

    public static Target LINE_ITEM_QUANTITY(String sku) {
        return Target.the("")
                .locatedBy("//div[@class='info']//span[@data-original-text='" + sku + "']/ancestor::td/following-sibling::td//div[contains(@class,'item-quantity')]");
    }

    public static Target LINE_ITEM_SKU_ID(String skuID) {
        return Target.the("SKU ID in line item of " + skuID)
                .locatedBy("//span[text()='" + skuID + "']");
    }

    public static Target UPDATE_LINE_ITEM_FIELD = Target.the("")
            .locatedBy("//input[@role='spinbutton']");
    public static Target UPDATE_LINE_ITEM_CHANGE = Target.the("")
            .locatedBy("//button[normalize-space()='Change']");

    public static Target LINE_ITEM_END_QUANTITY(String typeLine, int index) {
        return Target.the("Line item - End quantity")
                .locatedBy("(//tbody[@class='" + typeLine + "']//span[@class='end-qty'])[" + index + "]");
    }

    public static Target LINE_ITEM_TOTAL(String typeLine, int index) {
        return Target.the("Line item - Total")
                .locatedBy("(//tbody[@class='" + typeLine + "']//strong[@class='total'])[" + index + "]");
    }

    public static Target LINE_ITEM_OLD_TOTAL(String typeLine, int index) {
        return Target.the("Line item - Total")
                .locatedBy("(//tbody[@class='" + typeLine + "']//span[@class='old-total'])[" + index + "]");
    }

    public static Target ADDITIONAL_FEE_OLD_TOTAL(String typeLine, int index) {
        return Target.the("Line item - Additional fee")
                .locatedBy("(//tbody[@class='" + typeLine + "']//div[@class='additional-fee']//strong)[" + index + "]");
    }

    public static Target DIRECT_ITEM_DELIVERY(String typeLine, int index) {
        return Target.the("Line item - Additional fee")
                .locatedBy("(//tbody[@class='" + typeLine + "']//div[@class='direct-item-delivery'])[" + index + "]");
    }

    public static Target LINE_ITEM_SKU_ID = Target.the("Line item - SKU ID")
            .locatedBy("//div[contains(@class,'item-code')]/span");

    public static Target DELETE_LINE_ITEM_BY_SKU(String skuName) {
        return Target.the("Delete line item of sku " + skuName)
                .locatedBy("//span[text()='" + skuName + "']/ancestor::td/following-sibling::td[@class='quantity']/div/button");
    }

    public static Target DELETE_LINE_ITEM_BY_SKU_BEFORE_CREATE(String skuID) {
        return Target.the("Delete line item of sku " + skuID + " before create")
                .locatedBy("//span[text()='" + skuID + "']/parent::div/parent::div//following-sibling::div//button/span");
    }

    public static Target DELETE_LINE_ITEM_BY_SKU(String group, String skuName, String index) {
        return Target.the("Delete line item of sku " + skuName + " group " + group)
                .locatedBy("(//tbody[@class='" + group + "']//span[@data-original-text='" + skuName + "']/ancestor::td/following-sibling::td[@class='quantity']/div/button)[" + index + "]");
    }

    public static Target DELETE_LINE_ITEM_BY_SKU_DISABLE(String group, String skuName, String index) {
        return Target.the("Delete line item of sku " + skuName + " group " + group)
                .locatedBy("(//tbody[@class='" + group + "']//span[@data-original-text='" + skuName + "']/ancestor::td/following-sibling::td[@class='quantity']/div/button[@disabled])[" + index + "]");
    }


    public static Target MARK_FULFILL_BUTTON(String subInvoice, int i) {
        return Target.the("Mark fulfill button")
                .located(By.xpath("(//strong[contains(text(),'" + subInvoice + "')]/ancestor::td/following-sibling::td[@class='tr']//button)[" + i + "]"));
    }

    public static Target EXPIRE_LINE_ITEM(String typeLine, int index) {
        return Target.the("Line item - Expire date")
                .locatedBy("(//tbody[@class='" + typeLine + "']//td[@class='expiry-date']//div[@class='date'])[" + index + "]");
    }

    public static Target BELOW_LINE_ITEM(String typeLine, int index) {
        return Target.the("Line item - Below 75%")
                .locatedBy("(//tbody[@class='" + typeLine + "']//td[@class='expiry-date']//span[text()='Below 75%'])[" + index + "]");
    }

    public static Target DELIVERY_LINE_ITEM(String typeLine, int index) {
        return Target.the("Line item - deliveriy")
                .locatedBy("(//tbody[@class='" + typeLine + "']//td[@class='expiry-date']//span[text()='Below 75%'])[" + index + "]");
    }

    /**
     * Popup item quantity in line item of order detail
     */
    public static Target ITEM_QUANTITY_POPUP = Target.the("Item quantity popup")
            .locatedBy("//div[@role='dialog']//span[text()='Item quantity']");

    public static Target ITEM_QUANTITY_POPUP_QUANTITY_TEXTBOX = Target.the("Textbox quantity in popup edit item quantity")
            .locatedBy("(//label[text()='Item quantity']/following-sibling::div//input)[1]");

    public static Target ITEM_QUANTITY_POPUP_REASON_TEXTBOX = Target.the("Reason in popup edit item quantity")
            .locatedBy("(//label[text()='Item quantity']/following-sibling::div//input)[2]");

    public static Target ITEM_QUANTITY_POPUP_NOTE_TEXTBOX = Target.the("Note in popup edit item quantity")
            .locatedBy("//label[text()='Note']/following-sibling::div//textarea");

    public static Target DEDUCTION_CHECKBOX_POPUP_NOTE = Target.the("Checkbox deduction checkbox popup note")
            .locatedBy("//span[text()='Also create inventory deductions']");

    public static Target SHOW_EDIT_CHECKBOX = Target.the("Show edit in vendor checkbox")
            .locatedBy("//div[@role='dialog']//span[text()='Show this edit on vendor dashboard']");

    public static Target ORDER_DETAIL_SHOW_EDIT_CHECKBOX = Target.the("Show edit in vendor checkbox of order detail")
            .locatedBy("//div[@id='global-dialogs']//span[text()='Show this edit on vendor dashboard']");

    public static Target ITEM_QUANTITY_POPUP_BUTTON(String type) {
        return Target.the("Button in popup edit item quantity")
                .locatedBy("//div[@role='tooltip' and @x-placement]//textarea");
    }

    /**
     * Reason delete line item
     */
    public static Target POPUP_REASON = Target.the("Popup reason")
            .locatedBy("//div[@role='dialog']//span[text()='Reason']");

    public static Target REASON_TEXTBOX = Target.the("Reason textbox in popup reason")
            .locatedBy("//div[@id='global-dialogs']//div[contains(@class,'reason-change')]");

    public static Target NOTE_TEXTAREA = Target.the("Note textarea in popup reason")
            .locatedBy("//div[@id='global-dialogs']//textarea");

    public static Target DEDUCTION_CHECKBOX = Target.the("Deduction checkbox in popup reason")
            .locatedBy("//div[@id='global-dialogs']//span[text()='Also create inventory deductions']");

    public static Target SHOW_EDIT_DELETE_CHECKBOX = Target.the("Show edit delele checkbox in popup reason")
            .locatedBy("//div[@id='global-dialogs']//span[text()='Show this edit on vendor dashboard']");
    public static Target SAVE_ACTION_BUTTON = Target.the("Save action button")
            .locatedBy("//div[@class='fixed-bar']/*[contains(@class,'save action')]");

    public static Target REVERT_ACTION_BUTTON = Target.the("Revert action button")
            .locatedBy("//*[contains(@class,'rollback action')]");

    public static Target FULFILL_BUTTON_DISABLE(String skuName) {
        return Target.the("")
                .locatedBy("//span[text()='" + skuName + "']//ancestor::td//following-sibling::td[@class='fulfillment-status']//input");
    }

    public static Target REASON_TEXTBOX_IN_POPUP_DELETE = Target.the("Reason textbox in popup delete")
            .locatedBy("//label[text()='Reason']/following-sibling::div//input");

    public static Target NOTE_TEXTAREA_IN_POPUP_DELETE = Target.the("Note textarea in popup delete")
            .locatedBy("//div[@id='global-dialogs']//label[text()='Note']/following-sibling::div//textarea");

    /**
     * Edit Info of new line item
     */
    public static Target NEW_QUANTITY_TEXTBOX = Target.the("New quantity textbox")
            .locatedBy("(//input[@max='Infinity' and @aria-disabled='false'])[last()]");
    public static Target NEW_NOTE_TEXTAREA = Target.the("New note textarea")
            .locatedBy("(//label[text()='Note']/following-sibling::div//textarea)[last()]");

    public static Target FULFILL_DATE_TEXTBOX(String skuName, String index) {
        return Target.the("")
                .locatedBy("(//span[@data-original-text='" + skuName + "']//ancestor::td//following-sibling::td[@class='fulfillment-date']//input)[" + index + "]");
    }

    public static Target FULFILL_BUTTON(String skuName, String index) {
        return Target.the("")
                .locatedBy("(//span[@data-original-text='" + skuName + "']//ancestor::td//following-sibling::td[@class='fulfillment-status'])[" + index + "]");
    }

    /**
     * Sub invoice
     */
    public static Target ETA_NOT_SET = Target.the("ETA not set of subinvoice")
            .locatedBy("//div[text()='Cannot send the ETA email, please set ETA for at least 1 sub-invoice.']");

    public static Target ETA_SENT = Target.the("ETA sent")
            .locatedBy("//div//span[contains(text(),'ETA email sent')]");

    public static Target SUB_INVOICE_ETA = Target.the("The ETA Date field on set invoice popup")
            .locatedBy("//input[@placeholder='Set ETA']");

    public static Target SUB_INVOICE_ETA(int i) {
        return Target.the("The ETA Date field on set invoice popup")
                .locatedBy("(//input[@placeholder='Set ETA'])[" + i + "]");
    }

    public static Target SUB_INVOICE_ETA(String subInvoice) {
        return Target.the("The ETA Date field on set invoice popup")
                .locatedBy("//*[contains(text(),'" + subInvoice + "')]/ancestor::td//div[contains(@class,'eta')]//input");
    }

    public static Target SUB_INVOICE_PAYMENT_STATUS = Target.the("The status on set invoice popup")
            .locatedBy("//div[@class='payment-status']//div[@class='status-tag']");

    public static Target SUB_INVOICE_PAYMENT_STATUS(int i) {
        return Target.the("The status on set invoice popup")
                .locatedBy("(//div[@class='payment-status']//div[@class='status-tag'])[" + i + "]");
    }

    public static Target SUB_INVOICE_PAYMENT_STATUS(String subInvoice) {
        return Target.the("Payment status on set invoice popup")
                .locatedBy("//*[contains(text(),'" + subInvoice + "')]/ancestor::tr//following-sibling::div[@class='payment-status']/div");
    }

    public static Target SUB_INVOICE_FULFILLMENT_STATUS(String subInvoice) {
        return Target.the("Fulfillment status on set invoice popup")
                .locatedBy("//*[contains(text(),'" + subInvoice + "')]/ancestor::tr//label/following-sibling::div[contains(@class,'status-tag')]");

    }

    public static Target SUB_INVOICE_FULFILLMENT_STATUS(String subInvoice, String status) {
        return Target.the("Fulfillment status on set invoice popup")
                .locatedBy("//strong[contains(text(),'" + subInvoice + "')]/ancestor::tr//label/following-sibling::div[contains(@class,'status-tag') and text()='" + status + "']");

    }

    public static Target SUB_INVOICE_TOTAL_WEIGHT = Target.the("//div[@class='weight']")
            .located(By.xpath("//div[@class='weight']"));

    public static Target SUB_INVOICE_TOTAL_WEIGHT(int i) {
        return Target.the("")
                .locatedBy("(//div[@class='weight'])[" + i + "]");
    }

    public static Target SUB_INVOICE_TOTAL_WEIGHT(String subInvoice) {
        return Target.the("Total weight of subinvoice " + subInvoice)
                .locatedBy("//strong[contains(text(),'" + subInvoice + "')]/ancestor::td//following-sibling::td//div[contains(@class,'weight')]");
    }

    public static Target SUB_INVOICE_TOTAL_QUANTITY = Target.the("//div[@class='quantity']")
            .located(By.xpath("//div[@class='quantity']"));

    public static Target SUB_INVOICE_TOTAL_QUANTITY(int i) {
        return Target.the("")
                .locatedBy("(//div[@class='quantity'])[" + i + "]");
    }

    public static Target SUB_INVOICE_TOTAL_QUANTITY(String subInvoice) {
        return Target.the("Total quantity " + subInvoice)
                .locatedBy("//strong[contains(text(),'" + subInvoice + "')]/ancestor::td//following-sibling::td//div[contains(@class,'quantity')]");
    }

    public static Target SUB_INVOICE_TOTAL = Target.the("//div[@class='total']/strong")
            .located(By.xpath("//div[@class='total']/strong"));

    public static Target SUB_INVOICE_TOTAL(int i) {
        return Target.the("")
                .locatedBy("(//div[@class='total']/strong)[" + i + "]");
    }

    public static Target SUB_INVOICE_TOTAL(String subInvoice) {
        return Target.the("Total of sub invoice " + subInvoice)
                .locatedBy("//strong[contains(text(),'" + subInvoice + "')]/ancestor::td//following-sibling::td//div[contains(@class,'total')]//strong");
    }

    public static Target SUB_INVOICE_MARK_FULFILL(String subInvoice) {
        return Target.the("Mars to fulfill of " + subInvoice)
                .locatedBy("//strong[contains(text(),'" + subInvoice + "')]/ancestor::td//following-sibling::td//button[contains(@class,'fulfill')]");
    }

    public static Target DYNAMIC_SHIPPO(String field, int i) {
        return Target.the("Shippo info")
                .locatedBy("(//div[@class='shippo-label-stamp minimal']//*[contains(@class,'" + field + "')])[" + i + "]");
    }

    public static Target DELIVERY_DETAIL(String subInvoice) {
        return Target.the("DELIVERY_DETAIL of sub invoice " + subInvoice)
                .locatedBy("//strong[contains(text(),'" + subInvoice + "')]//ancestor::td/following-sibling::td[@class='delivery-via-subinvoice']");
    }

    public static Target REMOVE_PO_BUTTON(String subInvoice) {
        return Target.the("Remove purchase order of sub invoice " + subInvoice)
                .locatedBy("//strong[contains(text(),'" + subInvoice + "')]/ancestor::tr/following-sibling::tr//button[contains(@class,'remove')]");
    }

    public static Target DISPLAY_SURCHARGE_BUTTON(String subInvoice) {
        return Target.the("Display surcharge button of sub invoice " + subInvoice)
                .locatedBy("//strong[contains(text(),'" + subInvoice + "')]/ancestor::td/following-sibling::td//span[text()='Display surcharges']");
    }

    public static Target DISPLAY_SURCHARGE_ALERT = Target.the("Display surcharge warning")
            .located(By.xpath("//p[@class='el-alert__description' and text()='Small order surcharge and Fuel surcharge have not been set to display on any created sub-invoice.']"));

    public static Target SHIP_DIRECT_TO_STORE = Target.the("SHIP_DIRECT_TO_STORE")
            .located(By.xpath("//div[@class='type']"));

    public static Target DELETE_DELIVERY = Target.the("DELETE_DELIVERY")
            .located(By.xpath("//button[@class='el-button r el-button--danger']"));

    /**
     * Create new Purchase Order
     */
    public static Target FULFILLMENT_DATE_FIELD = Target.the("The Fulfillment Date field")
            .located(By.cssSelector("div.fulfillment-date div.el-date-editor input"));
    public static Target FULFILLMENT_STATE_FIELD = Target.the("The Fulfillment State field")
            .located(By.cssSelector("div.el-dialog__body div.fulfillment-state input"));
    public static Target ADD_A_POD_BUTTON = Target.the("Add A POD button")
            .located(By.cssSelector("div.proof-of-deliver button"));
    public static Target POD_INPUT_FIELD = Target.the("POD Input Field")
            .located(By.cssSelector("div.files .file input"));
    public static Target LP_NOTE_FIELD = Target.the("LP Note field")
            .located(By.cssSelector("div.logisitics-partner-note input.el-input__inner"));
    public static Target CREATE_PURCHASE_ADMIN_NOTE_FIELD = Target.the("Admin Note field")
            .located(By.cssSelector("div.admin-note input"));
    public static Target CREATE_PURCHASE_ORDER_BUTTON = Target.the("Create Purchase Order button")
            .located(By.cssSelector("div.el-form-item.action button"));

    /**
     * Summary
     */
    public static Target LOGISTIC_SURCHARGE = Target.the("Logistic Surcharge")
            .locatedBy("(//dd[@class='logistics-surcharge']//span)[last()]");
    public static Target FUEL_SURCHARGE = Target.the("FUEL Surcharge")
            .locatedBy(".logistics-surcharge-cents");
    public static Target CUSTOM_STORE_NAME = Target.the("Custom Store Name")
            .located(By.cssSelector("span.custom-store-name"));
    public static Target CUSTOM_STORE_NAME_EDIT = Target.the("Custom Store Name to edit")
            .locatedBy("(//dd[@class='custom-store-name']//div)[1]");
    public static Target CUSTOM_PO_FIELD = Target.the("Custom PO field")
            .located(By.cssSelector("dd.customer-po .content"));

    /**
     * Line Item
     */
    public static Target SAVE_ACTION = Target.the("Save button")
            .located(By.cssSelector("div.save.action"));
    public static Target DISTRIBUTE_CENTER = Target.the("Distribute Center")
            .located(By.cssSelector("td.warehouse input"));

    public static Target DISTRIBUTE_CENTER(String sku, int index) {
        return Target.the("Distribute Center")
                .locatedBy("(//span[text()='" + sku + "']/ancestor::td/following-sibling::td[@class='warehouse']//input)[" + index + "]");
    }

    public static Target ADD_LINE_ITEM_BUTTON = Target.the("Add line item button")
            .located(By.xpath("//span[contains(text(), 'Add line item')]"));
    public static Target LOADING_ICON = Target.the("The loading icon")
            .located(By.cssSelector("div.el-loading-mask"));
    public static Target MANAGE_PRODUCT_ARRIVAL_BUTTON = Target.the("The manage product arrival button")
            .located(By.xpath("//span[text()=\"Manage product arrival\"]"));


    /**
     * PO in Line invoice
     */
    public static Target LOGISTICS_PARTNER = Target.the("logistics-partner")
            .located(By.xpath("//div[@class='logistics-partner']"));
    public static Target STATUS_FULFILL = Target.the("STATUS_FULFILL")
            .located(By.xpath("//div[@class='fulfillment']//div[@class='status-tag mr-2']"));
    public static Target DATE_FULFILL = Target.the("Date_FULFILL")
            .located(By.xpath("//div[@class='fulfillment']//span[@class='date']"));
    public static Target PO_ADMIN_NOTE = Target.the("admin note")
            .located(By.cssSelector("td[class='notes'] dd[class='admin-note']"));
    public static Target PO_LP_NOTE = Target.the("lp note")
            .located(By.cssSelector(".logistics-partner-note"));
    public static Target PO_POD_FILE = Target.the("PO_POD_FILE")
            .locatedBy("//span[@class='file-name']");
    public static Target PO_UPDATE_BY = Target.the("PO_POD_FILE")
            .locatedBy("//span[@class='file-name']");

    public static Target PO_DELETE_BUTTON(String sub) {
        return Target.the("Purchase delete button")
                .locatedBy("(//strong[contains(text(),'" + sub + "')]//ancestor::tr/following-sibling::tr[@class='purchase-order']//button)[2]");
    }


    /**
     * Set receiving weekdays
     */
    public static Target SET_RECEIVING_WEEKDAYS = Target.the("Set receiving weekdays")
            .locatedBy("//div[@class='content el-popover__reference']//div//div[@class='weekdays']");
    public static Target SET_RECEIVING_WEEKDAYS_FIELD = Target.the("Set receiving weekdays")
            .locatedBy("//input[@class='el-select__input']");
    public static Target SET_RECEIVING_WEEKDAYS_UPDATE = Target.the("Set receiving weekdays")
            .locatedBy("//label[normalize-space()='Set receiving weekdays']/..//../../../div[@aria-hidden='false']//button[text()='Update']");

    /**
     * New
     */
    public static Target POD_CONSIGNMENT_BUTTON = Target.the("Pod Consignment button")
            .located(By.xpath("//div[text()='Pod Consignment']"));

    public static Target POD_CONSIGNMENT_BUTTON(String sku, String delivery, String index) {
        return Target.the("Pod Consignment button of sku " + sku + " " + index)
                .located(By.xpath("(//span[text()='" + sku + "']/ancestor::td/following-sibling::td[@class='deliverable']//div/div[text()='" + delivery + "'])[" + index + "]"));
    }

    public static Target PREFER_WAREHOUSE_SELECT_VALUE = Target.the("Prefer warehouse select value")
            .located(By.xpath("//div[text()='Pod Consignment']"));
    public static Target DELIVERABLE_NOT_SET = Target.the("Deliverable not set")
            .located(By.xpath("//div[text()='Deliverable not set']"));
    public static Target ORDER_ID_HEADER = Target.the("Order id in header")
            .located(By.xpath("//div[@class='page-header']//div[@class='title']//span"));

    public static Target ORDER_ID_HEADER(String order) {
        return Target.the("Order id in header")
                .located(By.xpath("//div[@class='page-header']//div[@class='title']//span[contains(text(),'" + order + "')]"));
    }

    public static Target SUB_INVOICE_ID_IN_LINE(String type) {
        return Target.the("Sub-invoice id in line items")
                .located(By.xpath("(//span[contains(@class,'" + type + "')]/following-sibling::strong)[last()]"));
    }

    public static Target SUB_INVOICE_ID_IN_LINE1(int index) {
        return Target.the("Sub-invoice id in line items")
                .located(By.xpath("(//strong[contains(text(),'Sub-invoice')]//following-sibling::strong[contains(text(),'#')])[" + index + "]"));
    }

    public static Target SUB_INVOICE_ID_IN_LINE_BY_SKU(String sku, String type, String index) {
        return Target.the("Sub-invoice id in line items by sku")
                .located(By.xpath("(//span[text()='" + sku + "']/ancestor::tr/preceding-sibling::tr//span[contains(@class,'" + type + "')]/following-sibling::strong[2])[" + index + "]"));
    }

    public static Target REFRESH_BUTTON = Target.the("Refresh button")
            .locatedBy("(//header//div[@class='actions']//button)[last()]");

    public static Target DEBUG_BUTTON = Target.the("Button debug")
            .located(By.xpath("(//div[@class='debug']/button)[last()]"));

    public static Target CODE = Target.the("Code")
            .located(By.xpath("//div[@class='debug']//code"));
    public static Target SELF_DELIVER_TO_STORE_BUTTON = Target.the("Button self deliver to store button")
            .located(By.xpath("//div[text()='Self deliver to store']"));

    /**
     * Create Deliverable popup
     */
    public static Target D_TEXTBOX(String title) {
        return Target.the("Button self deliver to store button")
                .located(By.xpath("(//label[text()='" + title + "']/following-sibling::div//input)[1]"));
    }

    public static Target D_TEXTBOX_2(String title) {
        return Target.the("Button self deliver to store button")
                .located(By.xpath("(//label[text()='" + title + "']/following-sibling::div//input)[2]"));
    }

    public static Target COMMENT_TEXTAREA = Target.the("Comment textarea")
            .located(By.xpath("//label[text()='Comment']/following-sibling::div//textarea"));
    public static Target PROOF_OF_DELIVERY = Target.the("Proof of delivery")
            .located(By.xpath("//div[@class='file']//div[@class='name']"));

    /**
     * Receiving Info
     */

    public static Target POSSIBLE_RECEIVING_WEEKDAYS_LABEL = Target.the("All possible delivery days")
            .located(By.xpath("//dt[text()='All possible delivery days']/following-sibling::dd/div[@class='weekdays']/span"));
    public static Target SET_RECEIVING_WEEKDAYS_LABEL = Target.the("Set receiving weekdays")
            .located(By.xpath("//dt[text()='Set receiving weekdays']/following-sibling::dd//div[@class='weekdays']/span"));
    public static Target RECEIVING_TIME_LABEL = Target.the("Receiving Time")
            .located(By.xpath("//div[@class='timezone']"));

    public static Target EXPRESS_RECEIVING_NOTE_LABEL = Target.the("Express receiving note in receiving")
            .located(By.xpath("(//dt[text()='Express receiving note']/following-sibling::dd/span)[1]"));

    public static Target DIRECT_RECEIVING_NOTE_LABEL = Target.the("Direct receiving note")
            .located(By.xpath("(//dt[text()='Direct receiving note']/following-sibling::dd/span)[1]"));

    public static Target EXPAND_VENDOR_PAYMENT = Target.the("Expand vendor payment")
            .located(By.xpath(" //a[@title='Expand vendor payment']"));

    public static Target POSSIBLE_RECEIVING_DAY_LABEL(int index) {
        return Target.the("All possible delivery days - day")
                .located(By.xpath("(//dt[text()='All possible delivery days']/following-sibling::dd/div[@class='weekdays']/span)[" + index + "]"));
    }

    public static Target SET_RECEIVING_DAY_LABEL(int index) {
        return Target.the("Set receiving delivery days - day")
                .located(By.xpath("(//dt[text()='Set receiving weekdays']/following-sibling::dd/div[@class='weekdays']/span)[" + index + "]"));
    }

    public static Target SET_RECEIVING_WEEKDAY_DROPDOWN(String day) {
        return Target.the("Set delivery weekdays dropdown")
                .located(By.xpath("//div[contains(@x-placement,'start') and contains(@class,'dropdown')]//*[text()='" + day + "']"));
    }

    public static Target SET_RECEIVING_WEEKDAY_DROPDOWN1(String day) {
        return Target.the("Set delivery weekdays dropdown")
                .located(By.xpath("//div[contains(@x-placement,'start') and contains(@class,'dropdown')]//*[text()='" + day + "']/parent::li"));
    }

    public static Target SET_RECEIVING_WEEKDAY_POPUP = Target.the("Set receiving weekdays popup")
            .located(By.xpath("//div[@role='tooltip']//label[text()='Set receiving weekdays']"));
    public static Target SET_RECEIVING_WEEKDAY_CLOSE_ICON = Target.the("Set receiving weekdays close icon")
            .located(By.xpath("//div[@role='tooltip']//i[contains(@class,'el-icon-close')]"));
    public static Target DEPARTMENT = Target.the("Department")
            .located(By.xpath("//dt[text()='Department']/following-sibling::dd/div"));

    /**
     * Vendor payment
     */
    public static Target VENDOR_PAYMENT_FULFILLMENT(String vendorCompany) {
        return Target.the("Vendor payment fulfillment")
                .located(By.xpath("//div[text()='" + vendorCompany + "']/parent::div/following-sibling::dl//dd[@class='fulfillment']/div"));
    }

    public static Target VENDOR_PAYMENT_PAYMENT_STATE(String vendorCompany) {
        return Target.the("Vendor payment payment state")
                .located(By.xpath("//div[text()='" + vendorCompany + "']/parent::div/following-sibling::dl//dd[@class='payment']/div"));
    }

    public static Target D_VENDOR_PAYMENT(String vendorCompany, String title) {
        return Target.the("Vendor payments " + vendorCompany + title)
                .located(By.xpath("//div[text()='" + vendorCompany + "']/ancestor::div/following-sibling::div//dd[@class='" + title + "']"));
    }

    /**
     * Remove sub - invoice
     */
    public static Target REMOVE_SUBINVOICE_BY_ID(String id) {
        return Target.the("Button remove sub-invoice by id " + id)
                .located(By.xpath("(//strong[contains(text(),'" + id + "')]/ancestor::td/following-sibling::td//button[contains(@class,'remove')])"));
    }

    public static Target WARNING_POPUP = Target.the("Warning popup")
            .locatedBy("//div[@role='dialog']//span[text()='Warning']");

    /**
     * Remove Deliverable Popup
     */
    public static Target POP_CONSIGNMENT_SETTED(String sku) {
        return Target.the("Button pod consignment setted " + sku)
                .located(By.xpath("//span[contains(@data-original-text,'" + sku + "')]/ancestor::td/following-sibling::td[@class='deliverable']/div"));
    }

    /**
     * Deliverable not set
     */
    public static Target DELIVERABLE_NOT_SET_BUTTON(String subInvoice) {
        return Target.the("Deliverable not set button " + subInvoice)
                .located(By.xpath("//strong[contains(text(),'" + subInvoice + "')]//ancestor::tr//td[@class='delivery-via-subinvoice']/div"));
    }

    public static Target CREATE_DELIVERABLE_POPUP = Target.the("Create deliverable popup")
            .locatedBy("//div[@id='global-dialogs']//span[text()='Create Deliverable']");
    public static Target DELIVERY_METHOD_DROPDOWN = Target.the("Delivery method dropdown")
            .locatedBy("//label[text()='Delivery method']/following-sibling::div//input");
    public static Target DELIVERY_METHOD_COMMENT = Target.the("Delivery method dropdown")
            .locatedBy("//label[text()='Comment']/following-sibling::div//textarea");
    public static Target DELIVERY_METHOD_UPDATE_POPUP = Target.the("Delivery method update button")
            .locatedBy("//div[@id='global-dialogs']//span[text()='Update']");
    public static Target POP_CONSIGNMENT_REMOVE_BUTTON = Target.the("Pod consignment remove button in popup")
            .locatedBy("//div[contains(@aria-label,'Deliverable')]//button[contains(@class,'danger')]");

    public static Target POP_CONSIGNMENT_COMMENT_TEXTAREA = Target.the("Pod consignment comment textarea in popup")
            .locatedBy("//div[contains(@aria-label,'Deliverable')]//textarea");
    public Target CUSTOM_PO_FIELD_DELETE = Target.the("Custom PO field in delete order detail")
            .locatedBy("//dd[@class='customer-po']/span");
    public Target DATE_FIELD_DELETE = Target.the("Date field in delete order detail")
            .locatedBy("//dd[@class='date']/span");
    public Target REGION_FIELD_DELETE = Target.the("Region field in delete order detail")
            .locatedBy("//dd[@class='region']/span");
    public Target BUYER_FIELD_DELETE = Target.the("Buyer field in delete order detail")
            .locatedBy("//dd[@class='buyer']/span");
    public Target STORE_FIELD_DELETE = Target.the("Store field in delete order detail")
            .locatedBy("//dd[@class='store']/div/div");
    public Target BUYER_PAYMENT_FIELD_DELETE = Target.the("Buyer payment field in delete order detail")
            .locatedBy("//dd[@class='buyer-payment']/div");
    public Target PAYMENT_TYPE_FIELD_DELETE = Target.the("Payment type field in delete order detail")
            .locatedBy("//dd[@class='payment-type']/span");
    public Target PAYMENT_DATE_FIELD_DELETE = Target.the("Payment date field in delete order detail")
            .locatedBy("//dd[@class='payment-date']/span");
    public Target VENDOR_PAYMENT_FIELD_DELETE = Target.the("Vendor payment field in delete order detail")
            .locatedBy("//dd[@class='vendor-payment']/span");
    public Target FULFILLMENT_FIELD_DELETE = Target.the("Fulfillment field in delete order detail")
            .locatedBy("(//dd[@class='fulfillment']/div)[1]");
    public Target DELETED_BY_FIELD_DELETE = Target.the("Deleted by field in delete order detail")
            .locatedBy("(//dt[text()='Deleted by']/following-sibling::dd/span)[1]");
    public Target DELETED_ON_FIELD_DELETE = Target.the("Deleted on field in delete order detail")
            .locatedBy("(//dt[text()='Deleted on']/following-sibling::dd/span)[1]");
    public Target DELETE_REASON_FIELD_DELETE = Target.the("Delete reason field in delete order detail")
            .locatedBy("(//dt[text()='Delete reason']/following-sibling::dd/span)[1]");

    public Target D_PRICE_FIELD_DELETE(String title) {
        return Target.the(title + " field in delete order detail")
                .locatedBy("//dd[@class='" + title + "']");
    }

    public Target D_PRICE_FIELD_DELETE1(String title) {
        return Target.the(title + " field in delete order detail")
                .locatedBy("//dd[@class='" + title + "']/span");
    }

    public static Target ETA_TEXTBOX(String subInvoice) {
        return Target.the("ETA textbox of sub invoice " + subInvoice)
                .locatedBy("//strong[contains(text(),'" + subInvoice + "')]/parent::a/following-sibling::div//input");
    }

    public static Target POD_DIRECT_ITEM_HEADER_MESSAGE = Target.the("Message of pod direct item")
            .locatedBy("(//h3[text()='Pod Direct Items']/following-sibling::div/span)[2]");
    public static Target DELIVERY_DATE_TEXTBOX = Target.the("Delivery date textbox")
            .locatedBy("//label[text()='Delivery date']/following-sibling::div//input");
    public static Target CARRIER_DROPDOWN = Target.the("Delivery date dropdown")
            .locatedBy("//label[text()='Carrier']/following-sibling::div//input");
    public static Target TRACKING_NUMBER_DROPDOWN = Target.the("Tracking number textbox")
            .locatedBy("//label[text()='Tracking number']/following-sibling::div//input");
    public static Target DELIVERY_FROM_TIME_TEXTBOX = Target.the("Delivery from time textbox")
            .locatedBy("(//label[text()='Delivery time']/following-sibling::div//input)[1]");
    public static Target DELIVERY_TO_TIME_TEXTBOX = Target.the("Delivery from to textbox")
            .locatedBy("(//label[text()='Delivery time']/following-sibling::div//input)[2]");

    public static Target DELIVERY_TO_PROOF = Target.the("Delivery proof to textbox")
            .locatedBy("//label[@class='preview']//input");


    /**
     * Create order - line item
     */
    // MOV
    public static Target COMPANY_NAME_MOV = Target.the("Company name MOV")
            .locatedBy("//div[@class='company-name']");

    public static Target TOTAL_PAYMENT_MOV = Target.the("Total payment MOV")
            .locatedBy("//span[@class='total-payment']");

    public static Target PRICE_MOV = Target.the("Price require of MOV")
            .locatedBy("//span[@class='mov bold']");

    public static Target MESSAGE_MOV = Target.the("Message require of MOV")
            .locatedBy("//div[@class='header-mov']//following-sibling::div//p");


    public static Target ITEM_WITH_MOQ = Target.the("Items with moq")
            .locatedBy("//div[text()='Items with MOQ']");

    public static Target MESSAGE_NOT_MEET_MOQ = Target.the("Items with moq")
            .locatedBy("//div[text()='Items with MOQ']/following-sibling::div//p[@class='el-alert__description']");

    public Target SKU_ID_IN_LINE_ITEM(String skuID) {
        return Target.the("SKU ID in line item")
                .locatedBy("//span[text()='" + skuID + "']");
    }

    public Target SKU_IN_LINE_ITEM(String skuID) {
        return Target.the("SKU in line item")
                .locatedBy("//span[text()='" + skuID + "']/preceding-sibling::span");
    }

    public Target BRAND_IN_LINE_ITEM(String skuID) {
        return Target.the("Brand in line item of sku ID " + skuID)
                .locatedBy("//span[text()='" + skuID + "']/parent::div/preceding-sibling::div[@class='brand']/div");
    }

    public Target PRODUCT_IN_LINE_ITEM(String skuID) {
        return Target.the("Product in line item of sku ID " + skuID)
                .locatedBy("//span[text()='" + skuID + "']/parent::div/preceding-sibling::div[@class='product']/div");
    }

    public Target UNIT_UPC_IN_LINE_ITEM(String skuID) {
        return Target.the("Unit UPC in line item of sku ID " + skuID)
                .locatedBy("//span[text()='" + skuID + "']/parent::div/following-sibling::div[@class='case-upc']//span[contains(@class,'upc-tag')]");
    }

    public Target UNITS_IN_LINE_ITEM(String skuID) {
        return Target.the("Units in line item of sku ID " + skuID)
                .locatedBy("//span[text()='" + skuID + "']/parent::div/following-sibling::div[@class='units']");
    }

    public Target STATUS_IN_LINE_ITEM(String skuID) {
        return Target.the("Status in line item of sku ID " + skuID)
                .locatedBy("//span[text()='" + skuID + "']/parent::div/following-sibling::div[@class='status']/div");
    }

    public Target PRICE_IN_LINE_ITEM(String skuID) {
        return Target.the("Price in line item of sku ID " + skuID)
                .locatedBy("//span[text()='" + skuID + "']/ancestor::div/following-sibling::div/span[@class='price']");
    }

    public Target QUANTITY_IN_LINE_ITEM(String skuID) {
        return Target.the("Quantity in line item of sku ID " + skuID)
                .locatedBy("//span[text()='" + skuID + "']/parent::div/parent::div/following-sibling::div//input");
    }

    public Target REGION_IN_LINE_ITEM(String skuID) {
        return Target.the("Quantity in line item of sku ID " + skuID)
                .locatedBy("//span[text()='" + skuID + "']/parent::div/parent::div/preceding-sibling::div//span");
    }

    public static Target DISPLAY_SURCHARGE_BUTTON_CHECKED = Target.the("Display surcharge button checked")
            .locatedBy("//div[@class='el-switch is-checked']//span[text()='Display surcharges']");

    public static Target DISPLAY_SURCHARGE_BUTTON_UNCHECKED = Target.the("Display surcharge button unchecked")
            .locatedBy("//div[@class='el-switch']//span[text()='Display surcharges']");

    /**
     * Popup help in quantity line item of order detail
     */
    public static Target QUANTITY_OF_LINEITEM(String subInvoice, String skuID) {
        return Target.the("Quantity of line item")
                .locatedBy("//strong[contains(text(),'" + subInvoice + "')]/ancestor::tr/following-sibling::tr//span[text()='" + skuID + "']/ancestor::td/following-sibling::td//div[contains(@class,'item-quantity')]");
    }

    public static Target ICON_HELP_OF_LINE_ITEM = Target.the("Icon help of line item")
            .locatedBy("//div[@class='el-switch is-checked']//span[text()='Display surcharges']");

    public static Target CHANGE_QUANTITY__BUTTON_IN_POPUP = Target.the("Change quantity button in popup")
            .locatedBy("//div[@role='dialog']//button//span[text()='Change']");

    public static Target CANCEL_QUANTITY__BUTTON_IN_POPUP = Target.the("Cancel quantity button in popup")
            .locatedBy("//div[@role='dialog']//button//span[text()='Cancel']");

    public static Target HELP_OF_QUANTITY_OF_LINEITEM(String subInvoice, String skuID) {
        return Target.the("Icon help of line item")
                .locatedBy("//strong[contains(text(),'" + subInvoice + "')]/ancestor::tr/following-sibling::tr//span[text()='" + skuID + "']/ancestor::td/following-sibling::td//span[contains(@class,'help-icon popover')]");
    }

    /**
     * Poppup help text of quantity in line item
     */
    public static Target POPRER_HELP_VALUE(int i) {
        return Target.the("Value in popper help reason")
                .locatedBy("(//table[@class='popper-help-text-table']//td[@class='value']/span)[" + i + "]");
    }

    public static Target POPRER_HELP_REASON(int i) {
        return Target.the("Reason in popper help reason")
                .locatedBy("(//table[@class='popper-help-text-table']//td[@class='reason'])[" + i + "]");
    }

    public static Target POPRER_HELP_UPDATE_BY(int i) {
        return Target.the("Update by in popper help reason")
                .locatedBy("(//table[@class='popper-help-text-table']//td[@class='initated-by'])[" + i + "]");
    }

    public static Target POPRER_HELP_UPDATE_ON(int i) {
        return Target.the("Update on in popper help reason")
                .locatedBy("(//table[@class='popper-help-text-table']//td[@class='date'])[" + i + "]");
    }

    public static Target POPRER_HELP_NOTE(int i) {
        return Target.the("Note in popper help reason")
                .locatedBy("(//table[@class='popper-help-text-table']//td[@class='note'])[" + i + "]");
    }

    public static Target POPRER_HELP_SHOW(int i) {
        return Target.the("Show on vendor in popper help reason")
                .locatedBy("(//table[@class='popper-help-text-table']//td[@class='show-vendor']//div[contains(@class,'boolean-stamp')]/span/span)[" + i + "]");
    }


    /**
     * Add line item in ordertail
     */

    public static Target SKU_IN_POPUP_SEARCH_LINE_ITEM(String skuName) {
        return Target.the("Sku in popup search line item")
                .locatedBy("//div[@role='dialog']//*[text()='" + skuName + "']");
    }

    public static Target PRODUCT_IN_POPUP_SEARCH_LINE_ITEM(String skuName) {
        return Target.the("Product of sku in popup search line item")
                .locatedBy("//div[@role='dialog']//*[text()='" + skuName + "']/parent::div/preceding-sibling::div[@class='product']");
    }

    public static Target BRAND_IN_POPUP_SEARCH_LINE_ITEM(String skuName) {
        return Target.the("Brand of sku in popup search line item")
                .locatedBy("//div[@role='dialog']//*[text()='" + skuName + "']/parent::div/preceding-sibling::div[@class='brand']");
    }

    public static Target PRICE_IN_POPUP_SEARCH_LINE_ITEM(String skuName) {
        return Target.the("Price of sku in popup search line item")
                .locatedBy("//div[@role='dialog']//*[text()='" + skuName + "']/parent::div/following-sibling::div[@class='price']");
    }

    public static Target STATUS_IN_POPUP_SEARCH_LINE_ITEM(String skuName) {
        return Target.the("Status of sku in popup search line item")
                .locatedBy("//div[@role='dialog']//*[text()='" + skuName + "']/parent::div/following-sibling::div[@status]");
    }

    public static Target REGION_IN_POPUP_SEARCH_LINE_ITEM(String skuName) {
        return Target.the("Region of sku in popup search line item")
                .locatedBy("//div[@role='dialog']//*[text()='" + skuName + "']/parent::div/preceding-sibling::div[contains(@class,'region')]/span");
    }

    public static Target CLOSE_POPUP_SEARCH_LINE_ITEM = Target.the("Close popup search line item")
            .locatedBy("//div[contains(@aria-label,'Select line item')]//i[@class='el-dialog__close el-icon el-icon-close']");

    /**
     * Warning customer po already used
     */

    public static Target WARNING_PO_USED_POPUP = Target.the("Popup warning customer po used")
            .locatedBy("//div[@id='global-dialogs']//span[text()='Warning']");

    public static Target WARNING_PO_USED_MESSAGE = Target.the("Message warning customer po used")
            .locatedBy("//div[@id='global-dialogs']//div[text()='The customer PO number was used by the order(s) listed below. Do you still want to continue?']");

    public static Target ORDER_LINK_PO_USED_POPUP(String order) {
        return Target.the("Order link in popup customer po used")
                .locatedBy("//div[@id='global-dialogs']//a[contains(text(),'" + order + "')]");
    }

    public static Target MESSAGE_NOT_MEET_MOQ_BULK = Target.the("Items with moq in bulk")
            .locatedBy("//div[contains(@class,'ghost-order-information')]//div//p[@class='el-alert__description']");

    /**
     * Deduction popup
     */

    public static Target DEDUCTION_QUANTITY = Target.the("Deduction quantity textbox")
            .locatedBy("//label[text()='Deduction quantity']/following-sibling::div//input");

    public static Target DEDUCTION_CATEGORY = Target.the("Deduction category")
            .locatedBy("//label[text()='Category']/following-sibling::div//input");

    public static Target DEDUCTION_SUB_CATEGORY = Target.the("Deduction sub category")
            .locatedBy("//label[text()='Sub category']/following-sibling::div//input");

    public static Target DEDUCTION_COMMENT = Target.the("Deduction comment")
            .locatedBy("//label[text()='Comment']/following-sibling::div//textarea");

    /**
     * Fulfillment history
     */

    public static Target FULFILLMENT_HISTORY_ICON = Target.the("Fulfillment history help icon")
            .locatedBy("//span[text()='Fulfillment']/following-sibling::span[@class='help-icon popover']");

    public static Target FULFILLMENT_HISTORY_STATE(int i) {
        return Target.the("Fulfillment history state in popup")
                .locatedBy("(//table[@class='popper-help-text-table']//td[@class='value'])[" + i + "]");
    }

    public static Target FULFILLMENT_HISTORY_UPDATE_BY(int i) {
        return Target.the("Fulfillment history updated by in popup")
                .locatedBy("(//table[@class='popper-help-text-table']//td[@class='initated-by'])[" + i + "]");
    }

    public static Target FULFILLMENT_HISTORY_UPDATE_ON(int i) {
        return Target.the("Fulfillment history updated on in popup")
                .locatedBy("(//table[@class='popper-help-text-table']//td[@class='date'])[" + i + "]");
    }

    /**
     * Delete line item history popup
     */

    public static Target HISTORY_LINEITEM_HELP_ICON(String sku) {
        return Target.the("History delete line item of sku " + sku)
                .locatedBy("//span[@data-original-text='" + sku + "']/ancestor::td/preceding-sibling::td/span");
    }

    public static Target DELETE_BY_HISTORY_LINEITEM(String title) {
        return Target.the(title + " in popup of history delete line item")
                .locatedBy("//div[@role='tooltip']//td[text()='" + title + "']/following-sibling::td");
    }

    public static Target SHOW_ON_VENDOR_HISTORY_LINEITEM = Target.the("Show on vendor text in popup of history delete line item")
            .locatedBy("//div[@role='tooltip']//td[text()='Show on vendor']/following-sibling::td/div");

    public static Target SHOW_ON_VENDOR_HISTORY_LINEITEM_BUTTON = Target.the("Show on vendor button in popup of history delete line item")
            .locatedBy("//label[text()='Show on vendor']/following-sibling::div/div");

    public static Target SHOW_ON_VENDOR_HISTORY_LINEITEM_UPDATE_BUTTON = Target.the("Update show on vendor button in popup of history delete line item")
            .locatedBy("//div[@role='tooltip' and @x-placement]//*[text()='Update']");

    /**
     * Export CSV in detail
     */

    public static Target EXPORT_BUTTON = Target.the("Export button")
            .located(By.xpath("(//div[@class='actions']//button)[3]"));
}

package cucumber.user_interface.beta.Vendor.orders;


import net.serenitybdd.screenplay.targets.Target;
import org.openqa.selenium.By;

public class VendorOrderDetailPage {

    public static Target BACK_TO_ORDER = Target.the("Back to order")
            .locatedBy("//a[normalize-space()='< Back to Orders']");

    public static Target ORDERED(int i) {
        return Target.the("")
                .locatedBy("(//a[contains(@class,'edt-row record')]//div[@class='edt-piece ordered pf-nowrap']/span)[" + i + "]");
    }

    public static Target ORDER_TYPE(String number) {
        return Target.the("")
                .locatedBy("//div[contains(text(),'" + number + "')]/parent::div/preceding-sibling::div[@class='edt-piece order-type']//span/img");
    }

    public static Target NUMBER(int i) {
        return Target.the("")
                .locatedBy("(//a[contains(@class,'edt-row record')]//div[@class='edt-piece number pf-nowrap']/div[2])[" + i + "]");
    }

    public static Target NUMBER = Target.the("")
            .locatedBy("(//a[contains(@class,'edt-row record')]//div[@class='edt-piece number pf-nowrap']/div[2])");

    public static Target NUMBER(String number) {
        return Target.the("Number " + number)
                .locatedBy("//div[@class='md focus' and contains(text(),'" + number + "')]");
    }

    public static Target STORE(int i) {
        return Target.the("")
                .locatedBy("(//a[contains(@class,'edt-row record')]//div[@class='edt-piece store'])[" + i + "]/span");
    }

    public static Target DETAIL_ORDER_RECORD(String text, String field) {
        return Target.the("")
                .locatedBy("//div[contains(text(),'" + text + "')]/parent::div/following-sibling::div[contains(@class,'edt-piece " + field + "')]/span");
    }

    public static Target PAYMENT(String i, String field) {
        return Target.the("")
                .locatedBy("//div[contains(text(),'" + i + "')]/parent::div/following-sibling::div[contains(@class,'edt-piece " + field + "')]/div[2]");
    }

    public static Target DETAIL_ORDER_RECORD2(String i, String field) {
        return Target.the("")
                .locatedBy("//div[contains(text(),'" + i + "')]/parent::div/preceding-sibling::div[contains(@class,'edt-piece " + field + "')]/span");
    }

    public static Target CREATOR(int i) {
        return Target.the("")
                .locatedBy("(//a[contains(@class,'edt-row record')]//div[@class='edt-piece creator pf-nowrap'])[" + i + "]/span");
    }

    public static Target PAYMENT(int i) {
        return Target.the("")
                .locatedBy("(//a[contains(@class,'edt-row record')]//div[@class='edt-piece payment pf-nowrap'])[" + i + "]/div[2]");
    }

    public static Target FULFILLMENT(int i) {
        return Target.the("")
                .locatedBy("(//a[contains(@class,'edt-row record')]//div[@class='edt-piece fulfillment pf-nowrap'])[" + i + "]/div[2]");
    }

    public static Target FULFILLMENT(String i) {
        return Target.the("")
                .locatedBy("//div[contains(text(),'" + i + "')]/parent::div/following-sibling::div[contains(@class,'edt-piece fulfillment')]/div[2]");
    }

    public static Target FULFILLED(int i) {
        return Target.the("")
                .locatedBy("(//a[contains(@class,'edt-row record')]//div[@class='edt-piece fulfilled pf-nowrap']/span)[" + i + "]");
    }

    public static Target FULFILLED(String i, String field) {
        return Target.the("")
                .locatedBy("//div[normalize-space()='" + i + "']/parent::div/following-sibling::div[contains(@class,'edt-piece " + field + "')]/span");
    }

    public static Target TOTAL(int i) {
        return Target.the("")
                .locatedBy("(//a[contains(@class,'edt-row record')]//div[@class='edt-piece total tr pf-nowrap']/span)[" + i + "]");
    }

    public static Target TOTAL_IN_DETAIL(int i) {
        return Target.the("")
                .locatedBy("(//div[@class='total'])[" + i + "]/*[1]");
    }

    public static Target POD_CONSIGNMENT(int i) {
        return Target.the("")
                .locatedBy("(//div[@class='pod-consignment'])[" + i + "]");
    }

    public static Target POD_CONSIGNMENT_NOT_SET = Target.the("")
            .locatedBy("//div[contains(@class,'not-set')]");

    public static Target BRAND_NAME(int i) {
        return Target.the(" brand name")
                .locatedBy("(//div[@class='brand'])[" + i + "]");
    }

    public static Target FULFILLMENT_SUB_INVOICE(String subinvoice, String number) {
        return Target.the(" brand name")
                .locatedBy("//div[contains(text(),'Sub invoice #" + subinvoice + number + "')]/following-sibling::div/div");
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
                .locatedBy("(//span[@class='quantity'])[" + i + "]");
    }

    public static Target CASE_PRICE(int i) {
        return Target.the("case price")
                .locatedBy("(//span[@class='price'])[" + i + "]");
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
                .locatedBy("//div[normalize-space()='" + sku + "']//ancestor::div[@class='edt-row']//button");
    }

    public static Target ORDER_BUYER_NAME = Target.the("")
            .locatedBy("//div[@class='buyer-name pf-ellipsis']");

    public static Target ORDER_STORE_NAME = Target.the("")
            .locatedBy("//div[@class='store-name pf-ellipsis']");

    public static Target ORDER_BUYER_EMAIL = Target.the("")
            .locatedBy(".buyer-email.linked.pf-ellipsis");

    public static Target WEEKDAY = Target.the("")
            .locatedBy("//span[@class='weekday']");

    public static Target SERVICE_FEE = Target.the("Service fee")
            .locatedBy("//div[contains(@class,'service-fee')]");
    public static Target PROMOTION = Target.the("Promotion")
            .locatedBy("//div[contains(@class,'promotion')]");

    public static Target ORDER_SPIPPING_ADDRESS = Target.the("")
            .locatedBy("//div[@class='address-stamp']");

    public static Target ORDER_VALUE = Target.the("")
            .locatedBy("//dt[normalize-space()='Order value']/following-sibling::dd[1]");

    public static Target ORDER_TOTAL = Target.the("")
            .locatedBy("//dt[normalize-space()='Total']/following-sibling::dd");

    public static Target SMALL_ORDER_SURCHAGE = Target.the("")
            .locatedBy("//dd[@class='text-right order-surcharge']");

    public static Target LOGISTICS_SURCHAGE = Target.the("")
            .locatedBy("//dd[@class='text-right logistics-surcharge']");

    public static Target ORDER_PAYMENT_INFO = Target.the("")
            .locatedBy("//div[@class='payment-info']");

    public static Target ORDER_PAYMENT_STATUS = Target.the("")
            .locatedBy("//div[normalize-space()='Payment']/following-sibling::div[@class='status-tag']");


    public static Target REGION = Target.the("Region")
            .locatedBy("//span[@class='region-stamp code']");

    public static Target ORDER_DATE = Target.the("Order date")
            .locatedBy("//div[@class='edt-piece order-date']/div[2]");

    public static Target FULFILLMENT_STATUS = Target.the("Fulfillment status")
            .locatedBy("//div[@class='edt-piece fulfillment']/div[2]");

    public static Target FULFILLMENT_DATE = Target.the("Fulfillment date")
            .locatedBy("//div[@class='label mb-1']");

    public static Target SHOW_GENERAL_INFORMATION = Target.the("Show general information")
            .locatedBy("//span[normalize-space()='Show general information']");

    public static Target CONFIRM_BTN = Target.the("Confirm button")
            .locatedBy("//button[@class='el-button el-button--primary el-button--md']");

    public static Target EXPIRY_DATE_TEXTBOX(String sku) {
        return Target.the("Expiry date textbox")
                .locatedBy("(//div[contains(text(),'" + sku + "')]/ancestor::div/following-sibling::div//label[text()='Expiry date']/following-sibling::div//input)[1]");
    }

    public static Target INSTRUCTIONS_CONFIRM = Target.the("INSTRUCTIONS")
            .locatedBy("//div[@class='delivery-instruction']");

    public static Target CHOOSE_DELIVERY_CONFIRM = Target.the("CHOOSE_DELIVERY_CONFIRM")
            .locatedBy("//div[@class='el-select pf-expanded']//input[@placeholder='Select']");

    public static Target STEP_INFO(String st) {
        return Target.the("Step")
                .locatedBy("//div[@class='steps']//strong[contains(text(),'" + st + "')]/following-sibling::span");
    }

    public static Target DYNAMIC_TEXT_SPAN(String st) {
        return Target.the("Text " + st)
                .locatedBy("//span[normalize-space()='" + st + "']");
    }

    public static Target DYNAMIC_TEXT_DIV(String st) {
        return Target.the("Text " + st)
                .locatedBy("//div[@class='" + st + "']");
    }

    public static Target DYNAMIC_DIALOG_TEXT_DIV(String st) {
        return Target.the("Text " + st)
                .locatedBy("//div[@role='dialog']//div[@class='" + st + "']");
    }

    public static Target DYNAMIC_DIALOG_SPAN(String st) {
        return Target.the("Text " + st)
                .locatedBy("//div[@role='dialog']//*[text()='" + st + "']/following-sibling::div");
    }

    public static Target DYNAMIC_TEXT_PARCEL(String st) {
        return Target.the("Text " + st)
                .locatedBy("//div[@class='edt-piece parcel-info']//div[@class='" + st + "']");
    }

    public static Target CHECK_CONFIRM_ITEM(String item) {
        return Target.the("Check box")
                .locatedBy("//div[contains(text(),'" + item + "')]/ancestor::div[contains(@class,'variant')]/preceding-sibling::div//span[@class='el-checkbox__input']");
    }

    //Parcel Information

    public static Target PARCEL_INFORMATION(String item) {
        return Target.the("")
                .locatedBy("//label[normalize-space()='" + item + "']/following-sibling::div//input");
    }

    public static Target GET_RATE = Target.the("Get rate")
            .locatedBy("//button[@class='el-button mt-2 el-button--primary']");

    public static Target GET_RATE_LOADING = Target.the("Get rate")
            .locatedBy("//button[@class='el-button mt-2 el-button--primary is-loading']");

    public static Target BACK = Target.the("Get rate")
            .locatedBy("//div[@class='modal-footer']//button[1]");

    public static Target BUY = Target.the("Buy")
            .locatedBy("//button//span[text()='Buy']");

    public static Target CHECK_SHIPPO = Target.the("")
            .locatedBy("//div[@class='edt-piece radio']/label/span/span");

    public static Target SUB_INVOICE = Target.the("")
            .locatedBy("//div[@class='card__title mb-1']");

    public static Target TRACKING_NUMBER = Target.the("")
            .locatedBy("//div[@class='tracking-number']");

// Delivery detail

    public static Target DELIVERY_ITEM_IMAGE = Target.the("")
            .locatedBy("//div[@class='variant flex']//div[@class='image']");

    public static Target DELIVERY_DATE = Target.the("Delivery date")
            .locatedBy("//div[@class='el-dialog__body']//input[@placeholder='MM/DD/YY']");

    public static Target DELIVERY_COMMENTS = Target.the("")
            .locatedBy("//textarea[@placeholder='Leave your comments here...']");


    public static Target DELIVERY_ITEM_NAME = Target.the("")
            .locatedBy("//div[@class='variant flex']//div[contains(@class,'infor')]");

    public static Target DELIVERY_ITEM_NAME(String name) {
        return Target.the("DELIVERY_ITEM_NAME " + name)
                .locatedBy("//div[@class='variant flex']//div[contains(@class,'infor')][contains(text(),'" + name + "')]");
    }

    public static Target DELIVERY_ITEM_QUANTITY(String name, String qty) {
        return Target.the("DELIVERY_ITEM_NAME " + name)
                .locatedBy("//div[@class='variant flex']//div[contains(@class,'infor')][contains(text(),'" + name + "')][contains(text(),'× " + qty + "')]");
    }

    public static Target DELIVERY_METHOD = Target.the("")
            .locatedBy("//span[normalize-space()='Choose a delivery method']/parent::label/following-sibling::div[@class='el-form-item__content']//input");

    public static Target DELIVERY_SHIPPING_RATE = Target.the("")
            .locatedBy("//div[@class='label price']");

    public static Target PRINT_BTN = Target.the("")
            .locatedBy("//a[normalize-space()='Print']");

    public static Target DELIVERY_CONFIRM_BTN = Target.the("")
            .locatedBy("//div[@class='modal-footer']//span[contains(text(),'Confirm')]");

    public static Target DELIVERY_CONFIRM_ALERT = Target.the("")
            .locatedBy("//div[@role='alert']");

    public static Target DYNAMIC_TEXT_DELIVERY(String st) {
        return Target.the("Text " + st)
                .locatedBy("//strong[normalize-space()='" + st + "']/following-sibling::div");
    }

    public static Target DELIVERY_DETAIL(String subInvoice) {
        return Target.the("DELIVERY_DETAIL " + subInvoice)
                .locatedBy("//div[contains(text(),'" + subInvoice + "')]/parent::div/parent::div/following-sibling::div//span[contains(text(),'View delivery details')]");
    }

    /**
     * Self delivery popup
     */
    public static Target FROM_TEXTBOX = Target.the("From textbox")
            .locatedBy("//label[text()='From']/following-sibling::div//input");

    public static Target TO_TEXTBOX = Target.the("To textbox")
            .locatedBy("//label[text()='To']/following-sibling::div//input");

    public static Target COMMENT_TEXTAREA = Target.the("Comment textarea")
            .locatedBy("//textarea[@placeholder='Leave your comments here...']");

    public static Target CONFIRM_BUTTON = Target.the("Confirm button popup")
            .locatedBy("//div[@role='dialog']//button//span[text()='Confirm']");

    public static Target UPLOAD_BUTTON = Target.the("Upload button")
            .locatedBy("//span[normalize-space()='Upload']/following-sibling::input");

    public static Target UPLOAD_PROOF = Target.the("Upload UPLOAD_PROOF")
            .locatedBy("//span[normalize-space()='Upload Proof of Delivery']/following-sibling::input");

    public static Target UPLOAD_PROOF(String file) {
        return Target.the("File POD " + file)
                .locatedBy("//div[@class='proof-item']//div[text()='" + file + "']");
    }

    public static Target DELETE_PROOF(String file) {
        return Target.the("Delete button")
                .locatedBy("//div[normalize-space()='" + file + "']/ancestor::div[@class='proof-item']//a[2]");
    }

    public static Target DYNAMIC_ITEM_DROPDOWN(String value) {
        return Target.the(value)
                .located(By.xpath("(//div[@class='el-scrollbar']//div[text()='" + value + "'])[last()]"));
    }

    public static Target POPUP_MESSAGE_DELIVERY = Target.the("Popup message delivery")
            .locatedBy("//p[text()='Delivery information updated successfully! Please print invoice & packing slip!']");

    /**
     * Print invoice/packing slip
     */

    public static Target SHOW_MORE_ACTION = Target.the("Button show more action")
            .locatedBy("//span[text()='Show more actions']");

    public static Target D_MENU_SHOW_MORE(String title) {
        return Target.the(title + "in show more action popup")
                .locatedBy("//div[@class='menus']//span[text()='" + title + "']");
    }

    public static Target SHOW_MORE_ACTION(String subInvoice) {
        return Target.the("show more action popup of " + subInvoice)
                .locatedBy("//div[contains(text(),'" + subInvoice + "')]/following-sibling::div//span[text()='Show more actions']");
    }

    public static Target D_INFO_SUB_INVOICE(String title) {
        return Target.the(title + "of sub invoice")
                .locatedBy("(//dt[text()='" + title + "']/following-sibling::dd//strong)[1]");
    }

    public static Target D_INFO_SUB_INVOICE2(String title) {
        return Target.the(title + "of sub invoice")
                .locatedBy("//dt[text()='" + title + "']/following-sibling::dd");
    }

    public static Target STORAGE_ITEM_SUB_INVOICE(String title) {
        return Target.the(title + "of sub invoice")
                .locatedBy("//div[@class='order-packing-slip']//table[@class='mt-3 order-items']/tbody/tr/td[1]/strong[text()='" + title + "']");
    }

    public static Target TOTAL_SUMMARY_ITEM_SUB_INVOICE(String class_) {
        return Target.the("TOTAL_SUMMARY_ITEM_SUB_INVOICE")
                .locatedBy("//strong[normalize-space()='Total']/parent::td/following-sibling::td[@class='" + class_ + "']");
    }

    public static Target D_INFO_ITEM_SUB_INVOICE(String class_, int index) {
        return Target.the("D_INFO_ITEM_SUB_INVOICE")
                .locatedBy("(//td[@class='" + class_ + "'])[" + index + "]");
    }

    public static Target D_INFO_PACKING_SLIP(String index, String title) {
        return Target.the(title + "of packing slip")
                .locatedBy("((//div[@class='order-no-packing-slip mt-2'])[" + index + "]//dt[text()='" + title + "']/following-sibling::dd/strong)[1]");
    }

    public static Target D_INFO_ITEM_PACKING_SLIP(String class_, int packing, int item) {
        return Target.the("of packing slip")
                .locatedBy("((//div[@class='order-no-packing-slip mt-2']//table[@class='mt-3 order-items'])[" + packing + "]/tbody//*[@class='" + class_ + "'])[" + item + "]");
    }

    public static Target SUB_INVOICE(String skuName, String index) {
        return Target.the("Sub invoice of " + skuName)
                .locatedBy("(//div[contains(text(),'" + skuName + "')]//ancestor::div[contains(@class,'el-card')]//div[contains(@class,'card__title')])[" + index + "]");
    }

    public static Target DELETE_SUB_INVOICE(String subInvoie, String sku, String index) {
        return Target.the("Delete sub invoice " + subInvoie)
                .locatedBy("(//div[contains(text(),'" + subInvoie + "')]/ancestor::div[@class='el-card__header']/following-sibling::div//div[text()='" + sku + "']/ancestor::div[@class='edt-piece variant']/following-sibling::div[@class='edt-piece action']//button)[" + index + "]");
    }

    public static Target UNCONFIRMED_ITEM = Target.the("Unconfirmed item label")
            .locatedBy("//div[contains(text(),'Unconfirmed item')]");

    /**
     * Line item with subinvoice
     */
    public static Target BRAND_NAME(String subInvoice, int index) {
        return Target.the("Brand name")
                .locatedBy("(//div[contains(text(),'" + subInvoice + "')]/ancestor::div[@class='el-card__header']/following-sibling::div//div[@class='brand']//span)[" + index + "]");
    }

    public static Target STATUS(String subInvoice, int index) {
        return Target.the("Brand name")
                .locatedBy("(//div[contains(text(),'" + subInvoice + "')]/following-sibling::div[@class='sub-invoice-fulfillment-status'])[" + index + "]");
    }

    public static Target PRODUCT_NAME(String subInvoice, int index) {
        return Target.the("Product name")
                .locatedBy("(//div[contains(text(),'" + subInvoice + "')]/ancestor::div[@class='el-card__header']/following-sibling::div//div[@class='product']//a)[" + index + "]");
    }

    public static Target SKU_NAME(String subInvoice, int index) {
        return Target.the("SKU name")
                .locatedBy("(//div[contains(text(),'" + subInvoice + "')]/ancestor::div[@class='el-card__header']/following-sibling::div//div[@class='info-variant__name'])[" + index + "]");
    }

    public static Target CASE_PRICE(String subInvoice, int index) {
        return Target.the("Case price")
                .locatedBy("(//div[contains(text(),'" + subInvoice + "')]/ancestor::div[@class='el-card__header']/following-sibling::div//span[@class='quantity']/preceding-sibling::span)[" + index + "]");
    }

    public static Target QUANTITY_ICON(String subInvoice, int index) {
        return Target.the("Case price")
                .locatedBy("(//div[contains(text(),'" + subInvoice + "')]/ancestor::div[@class='el-card__header']/following-sibling::div//span[3])[" + index + "]");
    }

    public static Target QUANTITY(String subInvoice, int index) {
        return Target.the("Quantity")
                .locatedBy("(//div[contains(text(),'" + subInvoice + "')]/ancestor::div[@class='el-card__header']/following-sibling::div//span[@class='quantity'])[" + index + "]");
    }

    public static Target TOTAL_IN_DETAIL(String subInvoice, int index) {
        return Target.the("Total in detail")
                .locatedBy("(//div[contains(text(),'" + subInvoice + "')]/ancestor::div[@class='el-card__header']/following-sibling::div//div[@class='total']/div)[" + index + "]");
    }

    public static Target UNIT_UPC(String subInvoice, int index) {
        return Target.the("Pod consignment")
                .locatedBy("(//div[contains(text(),'" + subInvoice + "')]/ancestor::div[@class='el-card__header']/following-sibling::div//div[@class='upc'])[" + index + "]");
    }

    public static Target FEE(String subInvoice, int index) {
        return Target.the("Pod consignment")
                .locatedBy("(//div[contains(text(),'" + subInvoice + "')]/ancestor::div[@class='el-card__header']/following-sibling::div//div[@class='fee'])[" + index + "]");
    }

    public static Target POD_CONSIGNMENT(String subInvoice, int index) {
        return Target.the("Pod consignment")
                .locatedBy("(//div[contains(text(),'" + subInvoice + "')]/ancestor::div[@class='el-card__header']/following-sibling::div//div[@class='pod-consignment'])[" + index + "]");
    }

    public static Target POD_CONSIGNMENT_NOT_SET(String subInvoice, int index) {
        return Target.the("Pod consignment not set")
                .locatedBy("(//div[contains(text(),'" + subInvoice + "')]/ancestor::div[@class='el-card__header']/following-sibling::div//div[@class='edt-piece delivery'])[" + index + "]");
    }

    /**
     * Line item with pod direct item un confirm
     */
    public static Target NUMBER_UNCONFIRM = Target.the("NUMBER_UNCONFIRM")
            .locatedBy("//h3[normalize-space()='Pod Direct Items']/following-sibling::div//div[@class='header-bar__state']");

    /**
     * History change quantity popup
     */

    public static Target HISTORY_ICON = Target.the("History change quantity icon")
            .locatedBy("//span[contains(@class,'line-item-updated')]");

    public static Target HISTORY_QUANTITY(int index) {
        return Target.the("History change quantity")
                .locatedBy("(//div[@class='content']//div[contains(@class,'record')]//div[contains(@class,'quantity')])[" + index + "]");
    }

    public static Target HISTORY_REASON(int index) {
        return Target.the("History change reason")
                .locatedBy("(//div[@class='content']//div[contains(@class,'record')]//div[contains(@class,'reason')])[" + index + "]");
    }

    public static Target HISTORY_EDIT_DATE(int index) {
        return Target.the("History change edit date")
                .locatedBy("(//div[@class='content']//div[contains(@class,'record')]//div[contains(@class,'edit-date')])[" + index + "]");
    }
}
